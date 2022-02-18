Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC3C4BBAC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 15:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiBROil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 09:38:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbiBROij (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:38:39 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BF1294FDC
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 06:38:22 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id a19so15097119qvm.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 06:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ct/taknL5OSPLapfp68CqWQFOWxZjIbqi5eZb8JBksY=;
        b=rEEsREUjjBiua+MKZr4a2qjeGSa+MGF99nn/POZzg4DsxtgMINSozobhN0R3+8MZDk
         nlkpyn5x9YYaKXhIxYPCQvyqYZAsr4ButnuFk3/HyaTWeG9mvZTNa18fu9RLKMXB4qU6
         sz7+h8fnLyBNOxe4ouHQeKtWb6lUYccP7rLvhoN6nVNq7b5F6QzuVUSRnjrC8xTBIvhx
         z9Ww7gTfMzkx82zRRbhqbxCdRaVXscbQuNao5uexONemvobDBA+j+Q+utcBw58vUiRK+
         RqEp9FceL831AKdfQgIZBpBye9KjMJxu7b3DT3+Mg9MB8IdWzIp8zYa2oUGyEHlDIT8R
         LDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ct/taknL5OSPLapfp68CqWQFOWxZjIbqi5eZb8JBksY=;
        b=LWRMW3wx4X+VV3DsPhsf7YCUlANBu6j9POQxw3g+K5VM7VN6AYHcBDOZulqBuyCbOY
         uLS1kb2qoEVh2tklfKjatNNZHHW33uEx/Wg8GT8ikOMD/NsQ8F3jtRDJNlfleUJLQZuR
         MOlmNi7s9h1EvstRfIu6GjMfMIyxxS/tJg26FFSvAKvqgDGvg2DkUQogDaX61dWVrgqj
         I7g4StvdAu1gkYHJmUOZFmBdcKjbQ5qcaQq55wnXk7uSKftrlOt1mT/oZvTVIkqVErS3
         s6rM26bdi8wb4hXO5r5YKkMmG3fI9TZseN4Lt0s/s3cPpLYBJ0/zJfSUGOuCuazH6QNB
         Tevw==
X-Gm-Message-State: AOAM530DN1sIz74p0AzNEainVucNu3VMS1GeSZbcBRcxBCNifI5/OCnY
        vQpqW2kiptuXZUPtcdv0dFJL1g==
X-Google-Smtp-Source: ABdhPJyKZyTfSEa0vIzZ5O5IWNjOfKXn6L1s55DZaVz4whOQ5ew2pRooBom75osvbsbiK/FbHaPC8A==
X-Received: by 2002:a05:622a:102:b0:2dc:ea0f:a12c with SMTP id u2-20020a05622a010200b002dcea0fa12cmr6886023qtw.17.1645195101457;
        Fri, 18 Feb 2022 06:38:21 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k4sm24554384qta.6.2022.02.18.06.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 06:38:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v2 2/2] fs: allow cross-vfsmount reflink/dedupe
Date:   Fri, 18 Feb 2022 09:38:14 -0500
Message-Id: <9cf49345f432f3541c480f62900d7e36a90a61a3.1645194730.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645194730.git.josef@toxicpanda.com>
References: <cover.1645194730.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
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

