Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C508E1F7619
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFLJed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgFLJe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04048C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:28 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q19so9422645eja.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OWQKaQ/Ra3c9quSmYvR+tgSGL5xnQg3Xb/ck1VIvecg=;
        b=qS5RKnzY2YTgE+oiXMqbl+4640TuDyYz/R2iJOtmFmxv4hP8civvv7hrGAx3ipg9Is
         OvF3kLyZFjKcVmdNZ1D4MkqbUjcmXiKvFHzw0Qkl7wonjMBeSFDn29bEvHnYDfdbQmVn
         qBOiT4Zepd31Ql5fe8LHH9bPhjZC6b0Auqv+nwKUPLqGWZfuvhKqOmPw9B4v6rqh+C30
         oW5c4y0Ajk48UXyZqvL9z/2noPY2ZDqzVHpEgQWo5rMCZKAi4fKvmmOBAz04Dsj55gWs
         8idRMcnnp27rp/yZXe62kg5F4Xck0HIDc1OrFuDvnfaLC/qX0Q+3Iu8hXaTXw788hIp8
         dEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OWQKaQ/Ra3c9quSmYvR+tgSGL5xnQg3Xb/ck1VIvecg=;
        b=AdB+yjsrCZlfJbRgtkU1SqqaLGCXooT5YM5CLd6EZ3QNyhh0VNPz4KfLv/bgf/0K0e
         tXeeLiYJIsb6JdtjxqPxTbL5K5Gnz8cb53MD4NfxYXNWMn9OSSwwOu0bwpJm+YqB6t0e
         6sEFihlHM+eBNcrrIXKmy5t3YGreoVPAPgiHRntXJVuB0jpp1cS19kPrEmT7niAuQSGN
         Mp2Qsad9wOsLT9raKB66548cw3GuAwR6i3YaMIxTFMnnnq+RDeA94Pj+pZtAwdaCcevv
         KbdwzyK0VZfUv7gsKZX2PyecCTSulzwIYZSKCXjuFGCX2suc4VknJ753SEWiANKfY/jN
         d3vw==
X-Gm-Message-State: AOAM5325M8h1wc5DvuYTRPDPE0l9NEGAEgLFjz89FeHvbUnYlxzwgF92
        oHxGPBxGfdymkQYOwuYQe0WjE8OQ
X-Google-Smtp-Source: ABdhPJxKhTUSbvL2lxXcOCF+Oamppej7UhnQLLZ4jbR8ucW7zTz1YQgGelrhMmjur4Q70N+i8wlknA==
X-Received: by 2002:a17:906:6d3:: with SMTP id v19mr12181779ejb.306.1591954466672;
        Fri, 12 Jun 2020 02:34:26 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:26 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 20/20] fanotify: no external fh buffer in fanotify_name_event
Date:   Fri, 12 Jun 2020 12:33:43 +0300
Message-Id: <20200612093343.5669-21-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
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
sufficient to contain both file handle and name and store the name at
name_offset after the file handle.

At this time, when not reporting name in event, we still allocate
the fixed size fanotify_fid_event and an external buffer for large
file handles, but fanotify_alloc_name_event() has already been prepared
to accept a NULL file_name.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 72 ++++++++++++++++++++++++-----------
 fs/notify/fanotify/fanotify.h |  4 ++
 2 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 3a2d48edaddd..c3986fbb6801 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -281,10 +281,22 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	return test_mask & user_mask;
 }
 
+static unsigned int fanotify_encode_fh_len(struct inode *inode)
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
 static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
-			       gfp_t gfp)
+			       unsigned int prealloc_fh_len, gfp_t gfp)
 {
-	int dwords, type, bytes = 0;
+	int dwords, bytes, type = 0;
 	char *ext_buf = NULL;
 	void *buf = fh->buf;
 	int err;
@@ -293,15 +305,21 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	if (!inode)
 		return;
 
-	dwords = 0;
+	/*
+	 * !gpf means preallocated variable size fh, but prealloc_fh_len could
+	 * be zero in that case if encoding fh len failed.
+	 */
 	err = -ENOENT;
-	type = exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
-	if (!dwords)
+	if (!gfp)
+		bytes = prealloc_fh_len;
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
@@ -311,17 +329,19 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 		buf = ext_buf;
 	}
 
+	dwords = bytes >> 2;
 	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
 	err = -EINVAL;
-	if (!type || type == FILEID_INVALID || bytes != dwords << 2)
+	if (!type || type == FILEID_INVALID || bytes < (dwords << 2))
 		goto out_err;
 
 	fh->type = type;
-	fh->len = bytes;
-	if (fh->len > FANOTIFY_INLINE_FH_LEN)
-		fh->name_offset = FANOTIFY_INLINE_FH_LEN;
-	else
-		fh->name_offset = fh->len;
+	fh->len = dwords << 2;
+	/*
+	 * name_offset is set to preallocated fh len, even if actual fh len
+	 * is shorter.
+	 */
+	fh->name_offset = prealloc_fh_len;
 
 	return;
 
@@ -398,7 +418,7 @@ struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
 
 	ffe->fae.type = FANOTIFY_EVENT_TYPE_FID;
 	ffe->fsid = *fsid;
-	fanotify_encode_fh(&ffe->object_fh, id, gfp);
+	fanotify_encode_fh(&ffe->object_fh, id, 0, gfp);
 
 	return &ffe->fae;
 }
@@ -410,16 +430,26 @@ struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 {
 	struct fanotify_name_event *fne;
 	struct fanotify_fh *dfh;
+	unsigned int prealloc_fh_len = fanotify_encode_fh_len(id);
+	unsigned int size;
 
-	fne = kmalloc(sizeof(*fne) + file_name->len + 1, gfp);
+	size = sizeof(*fne) - FANOTIFY_INLINE_FH_LEN + prealloc_fh_len;
+	if (file_name)
+		size += file_name->len + 1;
+	fne = kmalloc(size, gfp);
 	if (!fne)
 		return NULL;
 
 	fne->fae.type = FANOTIFY_EVENT_TYPE_FID_NAME;
 	fne->fsid = *fsid;
 	dfh = &fne->dir_fh;
-	fanotify_encode_fh(dfh, id, gfp);
-	fanotify_fh_copy_name(dfh, file_name);
+	fanotify_encode_fh(dfh, id, prealloc_fh_len, 0);
+	if (file_name)
+		fanotify_fh_copy_name(dfh, file_name);
+
+	pr_debug("%s: ino=%lu size=%u prealloc_fh_len=%u dir_fh_len=%u name_len=%u name='%.*s'\n",
+		 __func__, id->i_ino, size, prealloc_fh_len, dfh->len,
+		 dfh->name_len, dfh->name_len, fanotify_fh_name(dfh));
 
 	return &fne->fae;
 }
@@ -634,11 +664,7 @@ static void fanotify_free_fid_event(struct fanotify_event *event)
 
 static void fanotify_free_name_event(struct fanotify_event *event)
 {
-	struct fanotify_name_event *fne = FANOTIFY_NE(event);
-
-	if (fanotify_fh_has_ext_buf(&fne->dir_fh))
-		kfree(fanotify_fh_ext_buf(&fne->dir_fh));
-	kfree(fne);
+	kfree(FANOTIFY_NE(event));
 }
 
 static void fanotify_free_event(struct fsnotify_event *fsn_event)
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 8cb062eefd3e..7cbdac4be42f 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -43,6 +43,10 @@ static inline void fanotify_fh_init(struct fanotify_fh *fh)
 
 static inline bool fanotify_fh_has_ext_buf(struct fanotify_fh *fh)
 {
+	/* No external buffer in a variable size allocated fh */
+	if (fh->name_offset)
+		return false;
+
 	return fh->len > FANOTIFY_INLINE_FH_LEN;
 }
 
-- 
2.17.1

