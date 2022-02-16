Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D664B9234
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 21:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiBPUVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 15:21:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiBPUVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:21:39 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42D02DC4
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Feb 2022 12:21:25 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id bs32so2759389qkb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Feb 2022 12:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GjPeMfCcKj0GO28Gl2A9XkdAnfCCv0fOpre0UUY5uFY=;
        b=ApSU/QxwRNa2S6aa8zFvWvli8mSe2eJ5hexpqAmQLIKKYzds3oOTn9qtKxyL9F6ll1
         QCzN93sw7frlNug48po+326NnvPvfpbK9MvAYqi+Uk8sCpIiS1v51GhUL2x6xN5lOJ8C
         NoJtTxnKbmjj53aYzO6W6AzIYZNVlKQSEJmij/u805RebJK7q41m9KWfOdetv0gKXqlE
         ztXcMeF7sl0IqtNxfQKZkVqwbzy5KvKI+bxHAs3efzsZCiWAcywJfmEoIKGeIMTF9wqI
         LYkE0jJ8lbmcvVy7ws8+9isoDLJtL3Ni0aJgOX28LMfxHFYZMEzdRGvgtCT5a2weOl3J
         HQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GjPeMfCcKj0GO28Gl2A9XkdAnfCCv0fOpre0UUY5uFY=;
        b=1c3aQBz/2NyAmcgebiltrdjppTbfog/XBPACxfpf/RK4By+sorqA/5zTmeYrfGrT1v
         4894ZIIXUVpQ1hRDDz//dLSoQ1EHntJUtAAPgpxEDeo5yIhVymn23BIhy/XHCP5zgukd
         2alkYJVbOudasKmYPessAff/joBXWit+jJuwu1Vn0sgA8w5EXM3gcsOnL7r7bNsokYd2
         ek8gfV/5+z64iz2AKgp21aF4JpzvQJx/TJWxnZ8SKBwoRTL8TN7Cccj4qQOxTsFW28T7
         0b4KNwkEVgZpdRCbEmocWL7LEPhI56oePncllSAjD4KWLoAr5lvUfaSduG8pPzE4cu8P
         CPog==
X-Gm-Message-State: AOAM531bnawIG3fmiEYJaKE3hSvtdgFH6OKdhd21nkRp6FWAMSpvqu6A
        vosoYspthGbLDdROKT5aFPqScg==
X-Google-Smtp-Source: ABdhPJyLXI9ZcFq/c1LSRZ8XoP2zeMAy3KBXjVai/lShs0sd+v2DssfW+Vj/muL7GOoFrZXIh8AxoA==
X-Received: by 2002:a37:950:0:b0:47d:1005:b592 with SMTP id 77-20020a370950000000b0047d1005b592mr2193810qkj.555.1645042884711;
        Wed, 16 Feb 2022 12:21:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 185sm916304qkd.49.2022.02.16.12.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:21:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] fs: allow cross-vfsmount reflink/dedupe
Date:   Wed, 16 Feb 2022 15:21:23 -0500
Message-Id: <67ae4c62a4749ae6870c452d1b458cc5f48b8263.1645042835.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently we disallow reflink and dedupe if the two files aren't on the
same vfsmount.  However we really only need to disallow it if they're
not on the same super block.  It is very common for btrfs to have a main
subvolume that is mounted and then different subvolumes mounted at
different locations.  It's allowed to reflink between these volumes, but
the vfsmount check disallows this.  Instead fix dedupe to check for the
same superblock, and simply remove the vfsmount check for reflink as it
already does the superblock check.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ioctl.c       | 4 ----
 fs/remap_range.c | 7 +------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1ed097e94af2..090bf47606ab 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -236,9 +236,6 @@ static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
 
 	if (!src_file.file)
 		return -EBADF;
-	ret = -EXDEV;
-	if (src_file.file->f_path.mnt != dst_file->f_path.mnt)
-		goto fdput;
 	cloned = vfs_clone_file_range(src_file.file, off, dst_file, destoff,
 				      olen, 0);
 	if (cloned < 0)
@@ -247,7 +244,6 @@ static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
 		ret = -EINVAL;
 	else
 		ret = 0;
-fdput:
 	fdput(src_file);
 	return ret;
 }
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 231159682907..bc5fb006dc79 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -362,11 +362,6 @@ loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
 
 	WARN_ON_ONCE(remap_flags & REMAP_FILE_DEDUP);
 
-	/*
-	 * FICLONE/FICLONERANGE ioctls enforce that src and dest files are on
-	 * the same mount. Practically, they only need to be on the same file
-	 * system.
-	 */
 	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
 		return -EXDEV;
 
@@ -458,7 +453,7 @@ loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 		goto out_drop_write;
 
 	ret = -EXDEV;
-	if (src_file->f_path.mnt != dst_file->f_path.mnt)
+	if (file_inode(src_file)->i_sb != file_inode(dst_file)->i_sb)
 		goto out_drop_write;
 
 	ret = -EISDIR;
-- 
2.26.3

