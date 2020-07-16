Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF5C221EB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgGPImy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgGPImv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAC1C08C5CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so6088775wrw.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JEQcOibaqvI55n2tcy+nfezv63AfmNX98ijh+JKKZbg=;
        b=F4gCElBjhnclzBBNHWJShjFh8huF8NaN0St8V5H1XQduj7seBTWSCDOrAQxuIzrn0b
         006vwSm9hqzt8Wi8SKsM8U+WvFUA1ovBzlAAu2BQO+gPdicx8pB46BgXBemIi7uE5leS
         sKKfW34y3bRdZ+YjPWm9YCxngYTGrq8quNuKm1PF1jOb6KwhVMzCS8Wr+XptWlJSnZui
         k+coS8nTAw+FIxNG5/u1HVvMim1OQXjWy6yFH4syj3vZ53+qFVt5LdCqPHrsTmdkIpO9
         RSVT3ntFWOGAq8z44Yt3CFjybFdu6oqhyPlM0gUkP+7lhn/H6VMSEXewh9mXDeXdHDNy
         +psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JEQcOibaqvI55n2tcy+nfezv63AfmNX98ijh+JKKZbg=;
        b=a7LldIsQtWX8E/AbLOHxH/rMKx5nIRvf2sayAJBBofdBfBPhtTGraJRxcTBTVvE6Pu
         mJbf/WSj2LGp+H83H0/A/aXYGokJh7j6+u+VzospcA+bSOA85AyNR6jXWUzeIDs/j8p6
         7aXMp/aWVaiwwONT5QWJCUwMUYUwXcbM8fW6tg26iIKivvWOGf2V6GRlztCxaZNYMfxa
         aFpsRsnT2MFF48qF8cOnBvX8iroe7PlO9t8tuR+WzTfNr3CV0COK1oyiYrs2hsaQ5gSi
         Rf6Wl6HF5Lz4YwsoeyOu+B566ZAROhWzHjs0uPsIvrJOjQ4evPhVG7/teKH0HzVnnZL1
         vj8g==
X-Gm-Message-State: AOAM530mzbGAtp+YX8ABgTKzrhNrtG/vRTSSbw+xynT3WyMwDclcL7J5
        C5QkvPbbhIVhmNBFmCN5Bc8=
X-Google-Smtp-Source: ABdhPJyzXCU/eVGp7GHulXwHQW/qQUspVumBr6H+LT+Dkbjvn7e3QwVb8hFV9O2lR/brkahmXqVKKg==
X-Received: by 2002:adf:9283:: with SMTP id 3mr3835601wrn.231.1594888970354;
        Thu, 16 Jul 2020 01:42:50 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:49 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 10/22] fanotify: no external fh buffer in fanotify_name_event
Date:   Thu, 16 Jul 2020 11:42:18 +0300
Message-Id: <20200716084230.30611-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The fanotify_fh struct has an inline buffer of size 12 which is enough
to store the most common local filesystem file handles (e.g. ext4, xfs).
For file handles that do not fit in the inline buffer (e.g. btrfs), an
external buffer is allocated to store the file handle.

When allocating a variable size fanotify_name_event, there is no point
in allocating also an external fh buffer when file handle does not fit
in the inline buffer.

Check required size for encoding fh, preallocate an event buffer
sufficient to contain both file handle and name and store the name after
the file handle.

At this time, when not reporting name in event, we still allocate
the fixed size fanotify_fid_event and an external buffer for large
file handles, but fanotify_alloc_name_event() has already been prepared
to accept a NULL file_name.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 75 ++++++++++++++++++++++++-----------
 fs/notify/fanotify/fanotify.h | 12 +++---
 2 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 31fd41e91575..c107974d6830 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -298,6 +298,24 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	return test_mask & user_mask;
 }
 
+/*
+ * Check size needed to encode fanotify_fh.
+ *
+ * Return size of encoded fh without fanotify_fh header.
+ * Return 0 on failure to encode.
+ */
+static int fanotify_encode_fh_len(struct inode *inode)
+{
+	int dwords = 0;
+
+	if (!inode)
+		return 0;
+
+	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
+
+	return dwords << 2;
+}
+
 /*
  * Encode fanotify_fh.
  *
@@ -305,49 +323,54 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
  * Return 0 on failure to encode.
  */
 static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
-			      gfp_t gfp)
+			      unsigned int fh_len, gfp_t gfp)
 {
-	int dwords, type, bytes = 0;
+	int dwords, type = 0;
 	char *ext_buf = NULL;
 	void *buf = fh->buf;
 	int err;
 
 	fh->type = FILEID_ROOT;
 	fh->len = 0;
+	fh->flags = 0;
 	if (!inode)
 		return 0;
 
-	dwords = 0;
+	/*
+	 * !gpf means preallocated variable size fh, but fh_len could
+	 * be zero in that case if encoding fh len failed.
+	 */
 	err = -ENOENT;
-	type = exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
-	if (!dwords)
+	if (fh_len < 4 || WARN_ON_ONCE(fh_len % 4))
 		goto out_err;
 
-	bytes = dwords << 2;
-	if (bytes > FANOTIFY_INLINE_FH_LEN) {
-		/* Treat failure to allocate fh as failure to allocate event */
+	/* No external buffer in a variable size allocated fh */
+	if (gfp && fh_len > FANOTIFY_INLINE_FH_LEN) {
+		/* Treat failure to allocate fh as failure to encode fh */
 		err = -ENOMEM;
-		ext_buf = kmalloc(bytes, gfp);
+		ext_buf = kmalloc(fh_len, gfp);
 		if (!ext_buf)
 			goto out_err;
 
 		*fanotify_fh_ext_buf_ptr(fh) = ext_buf;
 		buf = ext_buf;
+		fh->flags |= FANOTIFY_FH_FLAG_EXT_BUF;
 	}
 
+	dwords = fh_len >> 2;
 	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
 	err = -EINVAL;
-	if (!type || type == FILEID_INVALID || bytes != dwords << 2)
+	if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
 		goto out_err;
 
 	fh->type = type;
-	fh->len = bytes;
+	fh->len = fh_len;
 
-	return FANOTIFY_FH_HDR_LEN + bytes;
+	return FANOTIFY_FH_HDR_LEN + fh_len;
 
 out_err:
 	pr_warn_ratelimited("fanotify: failed to encode fid (type=%d, len=%d, err=%i)\n",
-			    type, bytes, err);
+			    type, fh_len, err);
 	kfree(ext_buf);
 	*fanotify_fh_ext_buf_ptr(fh) = NULL;
 	/* Report the event without a file identifier on encode error */
@@ -419,7 +442,8 @@ static struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 
 	ffe->fae.type = FANOTIFY_EVENT_TYPE_FID;
 	ffe->fsid = *fsid;
-	fanotify_encode_fh(&ffe->object_fh, id, gfp);
+	fanotify_encode_fh(&ffe->object_fh, id, fanotify_encode_fh_len(id),
+			   gfp);
 
 	return &ffe->fae;
 }
@@ -432,8 +456,13 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	struct fanotify_name_event *fne;
 	struct fanotify_info *info;
 	struct fanotify_fh *dfh;
+	unsigned int dir_fh_len = fanotify_encode_fh_len(id);
+	unsigned int size;
 
-	fne = kmalloc(sizeof(*fne) + file_name->len + 1, gfp);
+	size = sizeof(*fne) + FANOTIFY_FH_HDR_LEN + dir_fh_len;
+	if (file_name)
+		size += file_name->len + 1;
+	fne = kmalloc(size, gfp);
 	if (!fne)
 		return NULL;
 
@@ -442,8 +471,13 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 	info = &fne->info;
 	fanotify_info_init(info);
 	dfh = fanotify_info_dir_fh(info);
-	info->dir_fh_totlen = fanotify_encode_fh(dfh, id, gfp);
-	fanotify_info_copy_name(info, file_name);
+	info->dir_fh_totlen = fanotify_encode_fh(dfh, id, dir_fh_len, 0);
+	if (file_name)
+		fanotify_info_copy_name(info, file_name);
+
+	pr_debug("%s: ino=%lu size=%u dir_fh_len=%u name_len=%u name='%.*s'\n",
+		 __func__, id->i_ino, size, dir_fh_len,
+		 info->name_len, info->name_len, fanotify_info_name(info));
 
 	return &fne->fae;
 }
@@ -658,12 +692,7 @@ static void fanotify_free_fid_event(struct fanotify_event *event)
 
 static void fanotify_free_name_event(struct fanotify_event *event)
 {
-	struct fanotify_name_event *fne = FANOTIFY_NE(event);
-	struct fanotify_fh *dfh = fanotify_info_dir_fh(&fne->info);
-
-	if (fanotify_fh_has_ext_buf(dfh))
-		kfree(fanotify_fh_ext_buf(dfh));
-	kfree(fne);
+	kfree(FANOTIFY_NE(event));
 }
 
 static void fanotify_free_event(struct fsnotify_event *fsn_event)
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 5e104fc56abb..12c204b1489f 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -29,8 +29,10 @@ enum {
 struct fanotify_fh {
 	u8 type;
 	u8 len;
-	u8 pad[2];
-	unsigned char buf[FANOTIFY_INLINE_FH_LEN];
+#define FANOTIFY_FH_FLAG_EXT_BUF 1
+	u8 flags;
+	u8 pad;
+	unsigned char buf[];
 } __aligned(4);
 
 /* Variable size struct for dir file handle + child file handle + name */
@@ -50,7 +52,7 @@ struct fanotify_info {
 
 static inline bool fanotify_fh_has_ext_buf(struct fanotify_fh *fh)
 {
-	return fh->len > FANOTIFY_INLINE_FH_LEN;
+	return (fh->flags & FANOTIFY_FH_FLAG_EXT_BUF);
 }
 
 static inline char **fanotify_fh_ext_buf_ptr(struct fanotify_fh *fh)
@@ -154,6 +156,8 @@ struct fanotify_fid_event {
 	struct fanotify_event fae;
 	__kernel_fsid_t fsid;
 	struct fanotify_fh object_fh;
+	/* Reserve space in object_fh.buf[] - access with fanotify_fh_buf() */
+	unsigned char _inline_fh_buf[FANOTIFY_INLINE_FH_LEN];
 };
 
 static inline struct fanotify_fid_event *
@@ -166,8 +170,6 @@ struct fanotify_name_event {
 	struct fanotify_event fae;
 	__kernel_fsid_t fsid;
 	struct fanotify_info info;
-	/* Reserve space in info.buf[] - access with fanotify_info_dir_fh() */
-	struct fanotify_fh _dir_fh;
 };
 
 static inline struct fanotify_name_event *
-- 
2.17.1

