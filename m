Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D20B4CFC91
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 12:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiCGLWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 06:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiCGLWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:22:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0ACA19E;
        Mon,  7 Mar 2022 02:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QWsN3Cm0ZkPv9e3usvN9iL4VQGUFb6A8A5Dc+lxPQZI=; b=hDr8tfShQuqA8aiZYDf0xgdeY+
        aAVlm3CtLthA7dZGYhdbSfuom5DZCIJMNmWqHSNSk5CDIGSFdkLMEbsi3HKp9pUsEfH4UfIKE7rIt
        aADAAoA1AcCBSMbCvdbR72fBfPwNctEbbAh+6JH5yd1460LhgiD8tYOHBySP/TIykeuGLNSNGMgKt
        B5yZl/86CcmpHcChg014TQrbBUwqMVwEdRr2S0KXndEp/rZQge3ojLnL4jDfBk9+ZOuUpUFWMEtY3
        Cag5V8CH3/dHJy0Q3Jd45CWm0w+ow6bgu7bym8rCNf4w2331j5gOdU7Prvz7nhaKy4hbhQZn6tKui
        JWq4a9+g==;
Received: from [2001:4bb8:184:7746:acf1:fa8:78c0:4ff2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRAtR-00HCga-8p; Mon, 07 Mar 2022 10:47:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fs: remove fs.f_write_hint
Date:   Mon,  7 Mar 2022 11:47:01 +0100
Message-Id: <20220307104701.607750-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220307104701.607750-1-hch@lst.de>
References: <20220307104701.607750-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The value is now completely unused except for reporting it back through
the F_GET_FILE_RW_HINT ioctl, so remove the value and the two ioctls
for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/fcntl.c         | 18 ------------------
 fs/open.c          |  1 -
 include/linux/fs.h |  9 ---------
 3 files changed, 28 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9c6c6a3e2de51..f15d885b97961 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -291,22 +291,6 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 	u64 h;
 
 	switch (cmd) {
-	case F_GET_FILE_RW_HINT:
-		h = file_write_hint(file);
-		if (copy_to_user(argp, &h, sizeof(*argp)))
-			return -EFAULT;
-		return 0;
-	case F_SET_FILE_RW_HINT:
-		if (copy_from_user(&h, argp, sizeof(h)))
-			return -EFAULT;
-		hint = (enum rw_hint) h;
-		if (!rw_hint_valid(hint))
-			return -EINVAL;
-
-		spin_lock(&file->f_lock);
-		file->f_write_hint = hint;
-		spin_unlock(&file->f_lock);
-		return 0;
 	case F_GET_RW_HINT:
 		h = inode->i_write_hint;
 		if (copy_to_user(argp, &h, sizeof(*argp)))
@@ -431,8 +415,6 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		break;
 	case F_GET_RW_HINT:
 	case F_SET_RW_HINT:
-	case F_GET_FILE_RW_HINT:
-	case F_SET_FILE_RW_HINT:
 		err = fcntl_rw_hint(filp, cmd, arg);
 		break;
 	default:
diff --git a/fs/open.c b/fs/open.c
index 9ff2f621b760b..1315253e02473 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -835,7 +835,6 @@ static int do_dentry_open(struct file *f,
 	     likely(f->f_op->write || f->f_op->write_iter))
 		f->f_mode |= FMODE_CAN_WRITE;
 
-	f->f_write_hint = WRITE_LIFE_NOT_SET;
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d5658ac5d8c65..a1fc3b41cd82f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -966,7 +966,6 @@ struct file {
 	 * Must not be taken from IRQ context.
 	 */
 	spinlock_t		f_lock;
-	enum rw_hint		f_write_hint;
 	atomic_long_t		f_count;
 	unsigned int 		f_flags;
 	fmode_t			f_mode;
@@ -2214,14 +2213,6 @@ static inline bool HAS_UNMAPPED_ID(struct user_namespace *mnt_userns,
 	       !gid_valid(i_gid_into_mnt(mnt_userns, inode));
 }
 
-static inline enum rw_hint file_write_hint(struct file *file)
-{
-	if (file->f_write_hint != WRITE_LIFE_NOT_SET)
-		return file->f_write_hint;
-
-	return file_inode(file)->i_write_hint;
-}
-
 static inline int iocb_flags(struct file *file);
 
 static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
-- 
2.30.2

