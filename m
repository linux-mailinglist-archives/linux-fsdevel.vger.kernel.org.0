Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AD164BB08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 18:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbiLMRa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 12:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiLMRah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:30:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BEE2315F
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670952582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b6NsA/Xg/ZlBOc/kTzK8dUjJC76dBdCS+EN14dWWQLg=;
        b=UJ8OU4UNpODsiYGUamIFbrHunC38RGvYHVuOP6noDgSuTir5YyfSfegmcdT3VGKOY6592R
        i8bbpyBmU4ormeFA0ddzqdo1G0Dz64c8dwjxELmWkTH1bQ6Bp2ZIANRsWD63bEj1YMqeWC
        s5mcQpSatUFWKObZa3dCCISEzKHgoTw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-269-TwkPC35vOFigesIw8uJ5Fg-1; Tue, 13 Dec 2022 12:29:41 -0500
X-MC-Unique: TwkPC35vOFigesIw8uJ5Fg-1
Received: by mail-ed1-f69.google.com with SMTP id m18-20020a056402511200b0046db14dc1c9so7719354edd.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6NsA/Xg/ZlBOc/kTzK8dUjJC76dBdCS+EN14dWWQLg=;
        b=Of2yQcvlUzE3qUyPGvzdmWWHYnevJe3iimr5ld1xPsK3CWkWpoRWdWgMEbTvdJQFRA
         a/yIZdGl4S00dumklfl5/XNhOp+JRJq18lygAxeFrYq4pVuvObGcPvv3wsuqO7KixKNv
         nRq7EGNdmJFylBsotkwDjdYEmGUm5WZp6GfXjMIsR+0fPoa3HjMEhdnnK0VCd8cN2gWk
         HNG0lRKggLF9GdyFseQOXcPYjbdsErQFmMYDbsHnRhW7UBhjsISGQ9/nIQ1SglYFN2Mn
         CAgwAbbiBeiB/IlXmHdWHYCTsm6TnvUXMRUqtPxnoZyeO3xDwtKitsL9cxrpKxskAncY
         8ang==
X-Gm-Message-State: ANoB5pl+eAN56SJCdb+o9KAIE6aG7aXlDh2zrtxcWb5ySYtbM6H5VP18
        tEQYXpeVeHFO2QYvYVAgO8vClQ0+I7i9DOgdBw/GTuM9bBCA7rlRv7IJSUz56wakxJallgriqHu
        JqLFKe0PevsB+WSxl7nn0Kklu
X-Received: by 2002:a05:6402:5505:b0:45c:835b:8fb5 with SMTP id fi5-20020a056402550500b0045c835b8fb5mr17687133edb.32.1670952579707;
        Tue, 13 Dec 2022 09:29:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7qjioCE+Wh1+KtVn789k/6rYbXqUD3RgR71ElXoL1vUuQD8oUVn4IS2CUeadEQp2swqGUVJw==
X-Received: by 2002:a05:6402:5505:b0:45c:835b:8fb5 with SMTP id fi5-20020a056402550500b0045c835b8fb5mr17687123edb.32.1670952579568;
        Tue, 13 Dec 2022 09:29:39 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ec14-20020a0564020d4e00b0047025bf942bsm1204187edb.16.2022.12.13.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:29:39 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [RFC PATCH 01/11] xfs: enable large folios in xfs_setup_inode()
Date:   Tue, 13 Dec 2022 18:29:25 +0100
Message-Id: <20221213172935.680971-2-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221213172935.680971-1-aalbersh@redhat.com>
References: <20221213172935.680971-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is more appropriate place to set large folios flag as other
mapping's flags are set here. This will also allow to conditionally
enable large folios based on inode's diflags (e.g. fs-verity).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_icache.c | 2 --
 fs/xfs/xfs_iops.c   | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index f35e2cee52655..8679739160507 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -88,7 +88,6 @@ xfs_inode_alloc(
 	/* VFS doesn't initialise i_mode or i_state! */
 	VFS_I(ip)->i_mode = 0;
 	VFS_I(ip)->i_state = 0;
-	mapping_set_large_folios(VFS_I(ip)->i_mapping);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -323,7 +322,6 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	mapping_set_large_folios(inode->i_mapping);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 10a5e85f2a709..9c90cfcecabc2 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1292,6 +1292,8 @@ xfs_setup_inode(
 	gfp_mask = mapping_gfp_mask(inode->i_mapping);
 	mapping_set_gfp_mask(inode->i_mapping, (gfp_mask & ~(__GFP_FS)));
 
+	mapping_set_large_folios(inode->i_mapping);
+
 	/*
 	 * If there is no attribute fork no ACL can exist on this inode,
 	 * and it can't have any file capabilities attached to it either.
-- 
2.31.1

