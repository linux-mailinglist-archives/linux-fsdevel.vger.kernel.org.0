Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307BB5704B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiGKNww (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 09:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiGKNwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3575961D9F
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657547565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=B8Y4HFJmfm6wiSpdeDdEueqA+VS1b+BD/sEuMVwHJLs=;
        b=AZfpP7U93Q1yi8M3SU6YnNePu0vRVRYHppdrWCGvd4XKeFRk0gHUCIVMxtvpSthW068Eyf
        k7edZaPpl5OKpGPpuhBZLRDbeQsFhBSYh0qqEjDr5K4YOTA3dGmHWvOUyzXmERsOvK8B4D
        9J3jtL5e+8wxkAGfdoHbsy8eFY22NII=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-iOyu9WOxMYa5K0GaEuP3hw-1; Mon, 11 Jul 2022 09:52:38 -0400
X-MC-Unique: iOyu9WOxMYa5K0GaEuP3hw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9E501857F02;
        Mon, 11 Jul 2022 13:52:37 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 968942EF9E;
        Mon, 11 Jul 2022 13:52:37 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ikent@redhat.com, onestero@redhat.com, willy@infradead.org
Subject: [PATCH v2 0/4] proc: improve root readdir latency with many threads
Date:   Mon, 11 Jul 2022 09:52:33 -0400
Message-Id: <20220711135237.173667-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Here's v2 of the /proc readdir optimization patches. See v1 for the full
introductary cover letter.

The refactoring in v2 adds a bit more to the idr code, but it remains
trivial with respect to eventual xarray (tag -> mark) conversion. On
that topic, I'm still looking for some feedback in the v1 thread [1] on
the prospective approach...

Brian

[1] https://lore.kernel.org/linux-fsdevel/YrykXim1t71TgdYg@bfoster/

v2:
- Clean up idr helpers to be more generic.
- Use ->idr_base properly.
- Lift tgid iteration helper into pid.c to abstract tag logic from
  users.
v1: https://lore.kernel.org/linux-fsdevel/20220614180949.102914-1-bfoster@redhat.com/

Brian Foster (4):
  radix-tree: propagate all tags in idr tree
  idr: support optional id tagging
  pid: tag pids associated with group leader tasks
  procfs: use efficient tgid pid search on root readdir

 fs/proc/base.c      | 17 +----------------
 include/linux/idr.h | 26 ++++++++++++++++++++++++++
 include/linux/pid.h |  3 ++-
 kernel/fork.c       |  2 +-
 kernel/pid.c        | 40 +++++++++++++++++++++++++++++++++++++++-
 lib/radix-tree.c    | 26 +++++++++++++++-----------
 6 files changed, 84 insertions(+), 30 deletions(-)

-- 
2.35.3

