Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484CE663750
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 03:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbjAJC0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 21:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbjAJCZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:25:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F486278
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 18:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AY7sAm0mm36QXig+QcRw0ATjP7SXMy0N+KkzGq8nj3M=; b=miFPLsTUStUUa4P7ASYGbdsnhk
        4E3T7ZbeqoYCCB5ovY05bik6ixtAMhKW6SgwixjYLrt2AKZUB5C1fOAJMk54BOaB+GDIQ7y4tr9zj
        vXiOl1n4W23FMV7rlFRgp0ZEh3g4DkhBJnemN8tLJKzK6LZk2h7lhoSxUOsBzotf+2/wp/9VBbA/b
        DLbfLUphBy2H1sl/FDeXox4H6mkUO9RwKvqyhY7Hlx7OzJzvGBNQD491xMwIfw5R0sDYhlrmFFTbB
        lL/UgTj+QojTFvqAS+44YQhKjMmCmxoEBMvVP9lUVZ48ZZwHet5o0GT6vGwlet+ZoL7id2iI+SCr7
        DrMB9ybg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pF4Kp-004yfY-6I; Tue, 10 Jan 2023 02:25:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
        hch@infradead.org, john.johansen@canonical.com,
        dhowells@redhat.com, mcgrof@kernel.org
Subject: [RFC 0/3] fs: kill old ms_* flags for internal sb
Date:   Mon,  9 Jan 2023 18:25:51 -0800
Message-Id: <20230110022554.1186499-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David had started the sb flag split for internal flags through
commit e462ec50cb5 ("VFS: Differentiate mount flags (MS_*) from internal
superblock flags") but it seems we just never axed out the old flag
usage.

I found this while inspecting adding a new temporary flag for the
superblock for filesystem freeze support. This doesn't go even build
tested, hence RFC.

Luis Chamberlain (3):
  apparmor: use SB_* flags for private sb flags
  fs: use SB_NOUSER on path_mount() instead of deprecated MS_NOUSER
  fs: remove old MS_* internal flags for the superblock

 fs/namespace.c                    | 2 +-
 include/uapi/linux/mount.h        | 8 --------
 security/apparmor/include/mount.h | 3 ++-
 security/apparmor/lsm.c           | 1 +
 security/apparmor/mount.c         | 2 +-
 tools/include/uapi/linux/mount.h  | 8 --------
 6 files changed, 5 insertions(+), 19 deletions(-)

-- 
2.35.1

