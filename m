Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BD8635AAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 11:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiKWK4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 05:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbiKWKz7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:55:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1303114BA9
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 02:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669200221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=trrE8tAyrhKXtA2MyH6NLMBKI+HS9a3yyOXR28Wrkgs=;
        b=TKr0Mf/m6wbXc4+9GTKoRpfVLA35UrVnmiBMuXtw1hL+O4vlKmQdoRl+GXd4R63eHFhAEF
        OmQntA/yvodah2OA8ze35gzcpopaliSANVs/VuoIhnwn3L5XpoK0PVcZSdSggoga7flReD
        tQ0HzIjHsEk69WQXwTolt1L0ulskG/M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-428-iQbCB6ShOT-XBaMbNhPFuQ-1; Wed, 23 Nov 2022 05:43:40 -0500
X-MC-Unique: iQbCB6ShOT-XBaMbNhPFuQ-1
Received: by mail-ej1-f70.google.com with SMTP id hp16-20020a1709073e1000b007adf5a83df7so9671352ejc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 02:43:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trrE8tAyrhKXtA2MyH6NLMBKI+HS9a3yyOXR28Wrkgs=;
        b=SpxMVkiqTj5w5fhoGXYdLMohSJaMV3rLYj3I+yV4Y/IKDSdPmsYvi64HL0ZoY02b+r
         YLPlV1T7cnxcuxxP1uuxXCVvH8TERXsObn0iTbP3hZJBATV09+BJhlH2cr9d5uWt92l4
         98OWnCmNUg9ccPLL2C4c6tb+E4IkPd2ut9Rj7OFBrRV9NoCNLuw6YDdvxrvzu3Rb295f
         Q3QLrR5aLPUAvYCE38mEK/bnrRCOnbN5gq++1INaokvpp24qa0216DvjEDLIEpFyqIpd
         uAT7rtVfOOZqKKT9HXrfWlY0/YOjVkuUqZBs6Thkbatc2LLSUwxw0rHtLLJDpr0Jj745
         aJ3A==
X-Gm-Message-State: ANoB5pmRYvOgVGgZSc/ZDfSRRMchVcfmv6DhrgAoeMUwYuRwcxGW2+fp
        1tuTetNv/kCUyIaRPsouJDxIDwy1EyQH0Kl4RJDQXWmxC5gSwNiUecfQUqmw4W2ZCB5p2/2y4NX
        KWf9uDE+UAA5pRpws4HADySEkDewCihcj+6jj5qG/z/ztIpJ+LYm5OSxfQ0FesD7JlwBZ+XOw7A
        CyiQ==
X-Received: by 2002:a05:6402:530c:b0:462:df63:5ec5 with SMTP id eo12-20020a056402530c00b00462df635ec5mr25057950edb.147.1669200218608;
        Wed, 23 Nov 2022 02:43:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7WLvSZHKhu1qTuoS2++1KLmuGltgmS5NRbHZNu6RKW+hh4LGlIhqGcfhTnUL0b/n0Z/CRdnA==
X-Received: by 2002:a05:6402:530c:b0:462:df63:5ec5 with SMTP id eo12-20020a056402530c00b00462df635ec5mr25057934edb.147.1669200218283;
        Wed, 23 Nov 2022 02:43:38 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (193-226-214-232.pool.digikabel.hu. [193.226.214.232])
        by smtp.gmail.com with ESMTPSA id o6-20020a056402444600b0046383354bf9sm7378682edb.40.2022.11.23.02.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 02:43:37 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>, Pengfei Xu <pengfei.xu@intel.com>,
        syzbot+462da39f0667b357c4b6@syzkaller.appspotmail.com
Subject: [PATCH] fuse: lock inode unconditionally in fuse_fallocate()
Date:   Wed, 23 Nov 2022 11:43:36 +0100
Message-Id: <20221123104336.1030702-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

file_modified() must be called with inode lock held.  fuse_fallocate()
didn't lock the inode in case of just FALLOC_KEEP_SIZE flags value, which
resulted in a kernel Warning in notify_change().

Lock the inode unconditionally, like all other fallocate implementations
do.

Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Reported-and-tested-by: syzbot+462da39f0667b357c4b6@syzkaller.appspotmail.com
Fixes: 4a6f278d4827 ("fuse: add file_modified() to fallocate")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 71bfb663aac5..89f4741728ba 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2963,11 +2963,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		.mode = mode
 	};
 	int err;
-	bool lock_inode = !(mode & FALLOC_FL_KEEP_SIZE) ||
-			   (mode & (FALLOC_FL_PUNCH_HOLE |
-				    FALLOC_FL_ZERO_RANGE));
-
-	bool block_faults = FUSE_IS_DAX(inode) && lock_inode;
+	bool block_faults = FUSE_IS_DAX(inode) &&
+		(!(mode & FALLOC_FL_KEEP_SIZE) ||
+		 (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
@@ -2976,22 +2974,20 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	if (fm->fc->no_fallocate)
 		return -EOPNOTSUPP;
 
-	if (lock_inode) {
-		inode_lock(inode);
-		if (block_faults) {
-			filemap_invalidate_lock(inode->i_mapping);
-			err = fuse_dax_break_layouts(inode, 0, 0);
-			if (err)
-				goto out;
-		}
+	inode_lock(inode);
+	if (block_faults) {
+		filemap_invalidate_lock(inode->i_mapping);
+		err = fuse_dax_break_layouts(inode, 0, 0);
+		if (err)
+			goto out;
+	}
 
-		if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)) {
-			loff_t endbyte = offset + length - 1;
+	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)) {
+		loff_t endbyte = offset + length - 1;
 
-			err = fuse_writeback_range(inode, offset, endbyte);
-			if (err)
-				goto out;
-		}
+		err = fuse_writeback_range(inode, offset, endbyte);
+		if (err)
+			goto out;
 	}
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
@@ -3039,8 +3035,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	if (block_faults)
 		filemap_invalidate_unlock(inode->i_mapping);
 
-	if (lock_inode)
-		inode_unlock(inode);
+	inode_unlock(inode);
 
 	fuse_flush_time_update(inode);
 
-- 
2.38.1

