Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005EB2185C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgGHLMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgGHLMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3797C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so46067256wrp.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MvbXoBMoVypjtaPx+cxiAtbNly1n3Ipk++LuDqaVkZ8=;
        b=GmHlsnpw4dlR/IlunGIMkh2Y6qxXw5AW298KeGrxOKN3BEUtqwtPe4ZZOg3V5XLQA2
         GArAHtF7A10727T8QFJuubu2bFl5Qp1MFhlT5VoM1ArTXNq3wg2SwC/9ttXLEeE8EVG4
         4gp4EtPie38e5vcSNBVYVhG5Z/smnHVTlLeK1hJP5dBE2K1zWlpFFT+vBaLQxrEXhsK4
         gsLKAz1Eva42ured0TM2nqI+SFDCw/F+jltmF8qUcgOYdIOohaAm1TmYd+nlzqz+kdgn
         3hJFmN+rKI3IoCGS0T+VEDBZCPSMe3wENtBiJuBGV+K2Ie1sUCa3HIgIFeNKC5521/oF
         IwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MvbXoBMoVypjtaPx+cxiAtbNly1n3Ipk++LuDqaVkZ8=;
        b=eZv/gpIwMdZjVUqnUnKDf0q1HEaswfi7S5e0j2MfRtxJQdQqhgf/sA82ipXxgbjOlC
         A0mADYqmPec9Fl6E4mkyyzSsuZQqWDCjB7E073IEr1r2DtC6CdeNAWB2DEG8m453lX8S
         NfNfk1Y7rS4UpULxleNi7Cydydh5+jztY8xZ8SH0L2kLkbWPN7mh6vXHgW+ihkbo12m6
         qjAiB22vHtKXwNZLx9aDOhcheAsp05HLg/kqlN784JgvpyPm3nOKHZppr58+eFnfEtGX
         +GRQvg0Sxu2jrKzILO6j0pbl5uh62nLJq6FpdqY4db868Pf7UAtx41Tcd+BDiert0t82
         6n0Q==
X-Gm-Message-State: AOAM531efjWzSw+nr+iGQq+/fiK8zu5yltnBUcQFCDEz9+zUHDg8exX1
        7ctD44Ru4wBiNZEJxrpDWlE=
X-Google-Smtp-Source: ABdhPJzpp35LBi/VuPKqSePqzDPhP+ox90b+NvmR9aY11e9zjlggveOt0UoPW3TtXwYZ8n16K639vQ==
X-Received: by 2002:adf:e546:: with SMTP id z6mr54140751wrm.99.1594206754525;
        Wed, 08 Jul 2020 04:12:34 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:33 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 20/20] fanotify: no external fh buffer in fanotify_name_event
Date:   Wed,  8 Jul 2020 14:11:55 +0300
Message-Id: <20200708111156.24659-20-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
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
 fs/notify/fanotify/fanotify.c | 68 +++++++++++++++++++++++++----------
 fs/notify/fanotify/fanotify.h | 12 ++++---
 2 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 4b0bc4afe6ff..4833d4c88122 100644
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
@@ -305,27 +323,34 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
  * Return 0 on failure to encode.
  */
 static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
-			      gfp_t gfp)
+			      unsigned int fh_len, gfp_t gfp)
 {
-	int dwords, type, bytes = 0;
+	int dwords, bytes, type = 0;
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
+	if (!gfp)
+		bytes = fh_len;
+	else
+		bytes = fanotify_encode_fh_len(inode);
+	if (bytes < 4 || WARN_ON_ONCE(bytes % 4))
 		goto out_err;
 
-	bytes = dwords << 2;
-	if (bytes > FANOTIFY_INLINE_FH_LEN) {
-		/* Treat failure to allocate fh as failure to allocate event */
+	/* No external buffer in a variable size allocated fh */
+	if (gfp && bytes > FANOTIFY_INLINE_FH_LEN) {
+		/* Treat failure to allocate fh as failure to encode fh */
 		err = -ENOMEM;
 		ext_buf = kmalloc(bytes, gfp);
 		if (!ext_buf)
@@ -333,8 +358,10 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 
 		*fanotify_fh_ext_buf_ptr(fh) = ext_buf;
 		buf = ext_buf;
+		fh->flags |= FANOTIFY_FH_FLAG_EXT_BUF;
 	}
 
+	dwords = bytes >> 2;
 	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
 	err = -EINVAL;
 	if (!type || type == FILEID_INVALID || bytes != dwords << 2)
@@ -419,7 +446,7 @@ struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 
 	ffe->fae.type = FANOTIFY_EVENT_TYPE_FID;
 	ffe->fsid = *fsid;
-	fanotify_encode_fh(&ffe->object_fh, id, gfp);
+	fanotify_encode_fh(&ffe->object_fh, id, 0, gfp);
 
 	return &ffe->fae;
 }
@@ -432,8 +459,13 @@ struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
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
 
@@ -442,8 +474,13 @@ struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
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
@@ -658,12 +695,7 @@ static void fanotify_free_fid_event(struct fanotify_event *event)
 
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

