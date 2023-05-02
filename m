Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011826F454B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 15:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbjEBNlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 09:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjEBNkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 09:40:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92917285;
        Tue,  2 May 2023 06:39:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A12CC1F8D7;
        Tue,  2 May 2023 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683034729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=crvNNZKHkX0qSv+47z6gi2siVKpNnXpyMa5UXHMzqQg=;
        b=PgbCIBlRsSh3JTLYfKjClKjprcbn9dDOrwzSI48oqzC8Za6rSjZhTcRjbJjhx3G3GcUMkH
        GDsVgc3VXNyAOEWuPPYC5uPNP2NyBoVzTWJS+KMhzu7OfTRSmbGsT1gF66FpRWV4RR5iLx
        0F70pNiNbLtU19jYvzEwRru7w+Zqp9U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 651B2134FB;
        Tue,  2 May 2023 13:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wx3hF2kSUWTOYQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 02 May 2023 13:38:49 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: [RFC PATCH 0/3] Rework locking when rendering mountinfo cgroup paths
Date:   Tue,  2 May 2023 15:38:44 +0200
Message-Id: <20230502133847.14570-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Idea for these modification came up when css_set_lock seemed unneeded in
cgroup_show_path.
It's a delicate change, so the deciding factor was when cgroup_show_path popped
up also in some profiles of frequent mountinfo readers.
The idea is to trade the exclusive css_set_lock for the shared
namespace_sem when rendering cgroup paths. Details are described more in
individual commits.

Michal Koutný (3):
  cgroup: Drop unused function for cgroup_path
  cgroup: Rely on namespace_sem in current_cgns_cgroup_from_root
    explicitly
  cgroup: Do not take css_set_lock in cgroup_show_path

 fs/namespace.c         |  5 +++-
 include/linux/mount.h  |  4 +++
 kernel/cgroup/cgroup.c | 58 ++++++++----------------------------------
 3 files changed, 18 insertions(+), 49 deletions(-)

-- 
2.40.1

