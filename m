Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276212185BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgGHLMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgGHLMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726E7C08E6DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so20494623wrp.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8LiGJZ+tYUbX3WHjUWRCTZXgGPnYXxv67V/XKvaZ2Pg=;
        b=KAlL6rcafoDgj1TWsNtOq7AFnCMZtHagtGU+TjARQZAtvskveuetdIKrF7NUIDkzh+
         tsZsmMVDYWCjjuPKF9862Vav4jNBGfmBsr5Rgc7HZq1nRYR0FiymFpVw3FZIYT38TKNU
         wlibaXefiUZHU0LFSs5JKEK5OoWgXQVETeaTvFSt6CO0B7uJAo5bxQV7mzczpCawDUuk
         p3HV+LO0IlCWlJMs+aAPt7txJqKN52fPHM0iS/il4dYYBqdIriqAc+OOR04tzS+9BoZz
         l7KF5GlM4/PfE361qSYLH4tvyfy7YFkCBsVkse5whP5f/0pHElp1i+xdJGiKbMaPQ/ca
         IARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8LiGJZ+tYUbX3WHjUWRCTZXgGPnYXxv67V/XKvaZ2Pg=;
        b=XJsHyCvgfV/nl5v5XiLH5ZGheqIjGb4MQNCCNZxNZdl6Rlz2URDHfz50L/Lmkds3X1
         7JxGJDU1BMUSHsk2tNoH+Osb89wYu2l0lOi22CIOrjXnXjLVPB1BnUwM8xFLHAf49hFE
         Lpkz3ItfJjiO6HKotBvhWukNzDYx0CSf2PUA4ElYz6uQm1pyYGQ7kW5KTpJZzqqCeEbF
         97l26FtiWNC6mbi/wV8kOp6MgdU31caVQnc/SZxxBUVqK1p3plAWMDuwSsgezaX2oefL
         h7GdElVDDsBPj6ohrIGQROyqdUCPv+BpQdm9l8aAx/66u90Jxcup9puCsRd64ZQfnFfQ
         8Vwg==
X-Gm-Message-State: AOAM531SKT/BByFIOfoEjsBo4/aZD9wRc4cq1eAlIUbhu+Hfh8yahPby
        aIzw7l6Y4pt++dF5bteuG3dPahMD
X-Google-Smtp-Source: ABdhPJxZUgZ73FrLJAUzgO2JU8WgUQuA08Rk4U6Uq2wuSBgKPEG+/9/vO80MqQzs0e2n0UnklY3/Gg==
X-Received: by 2002:adf:e9c4:: with SMTP id l4mr60401223wrn.9.1594206753099;
        Wed, 08 Jul 2020 04:12:33 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:32 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 19/20] fanotify: use struct fanotify_info to parcel the variable size buffer
Date:   Wed,  8 Jul 2020 14:11:54 +0300
Message-Id: <20200708111156.24659-19-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An fanotify event name is always recorded relative to a dir fh.
Encapsulate the name_len member of fanotify_name_event in a new struct
fanotify_info, which describes the parceling of the variable size
buffer of an fanotify_name_event.

The dir_fh member of fanotify_name_event is renamed to _dir_fh and is not
accessed directly, but via the fanotify_info_dir_fh() accessor.
Although the dir_fh len information is already available in struct
fanotify_fh, we store it also in dif_fh_totlen member of fanotify_info,
including the size of fanotify_fh header, so we know the offset of the
name in the buffer without looking inside the dir_fh.

We also add a file_fh_totlen member to allow packing another file handle
in the variable size buffer after the dir_fh and before the name.
We are going to use that space to store the child fid.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 66 ++++++++++++++++------
 fs/notify/fanotify/fanotify.h      | 91 +++++++++++++++++++++++++-----
 fs/notify/fanotify/fanotify_user.c | 25 ++++----
 3 files changed, 139 insertions(+), 43 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 3885bf63976b..4b0bc4afe6ff 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -49,22 +49,44 @@ static bool fanotify_fid_event_equal(struct fanotify_fid_event *ffe1,
 		fanotify_fh_equal(&ffe1->object_fh, &ffe2->object_fh);
 }
 
+static bool fanotify_info_equal(struct fanotify_info *info1,
+				struct fanotify_info *info2)
+{
+	if (info1->dir_fh_totlen != info2->dir_fh_totlen ||
+	    info1->file_fh_totlen != info2->file_fh_totlen ||
+	    info1->name_len != info2->name_len)
+		return false;
+
+	if (info1->dir_fh_totlen &&
+	    !fanotify_fh_equal(fanotify_info_dir_fh(info1),
+			       fanotify_info_dir_fh(info2)))
+		return false;
+
+	if (info1->file_fh_totlen &&
+	    !fanotify_fh_equal(fanotify_info_file_fh(info1),
+			       fanotify_info_file_fh(info2)))
+		return false;
+
+	return !info1->name_len ||
+		!memcmp(fanotify_info_name(info1), fanotify_info_name(info2),
+			info1->name_len);
+}
+
 static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
 				      struct fanotify_name_event *fne2)
 {
-	/* Do not merge name events without dir fh */
-	if (!fne1->dir_fh.len)
-		return false;
+	struct fanotify_info *info1 = &fne1->info;
+	struct fanotify_info *info2 = &fne2->info;
 
-	if (fne1->name_len != fne2->name_len ||
-	    !fanotify_fh_equal(&fne1->dir_fh, &fne2->dir_fh))
+	/* Do not merge name events without dir fh */
+	if (!info1->dir_fh_totlen)
 		return false;
 
-	return !memcmp(fne1->name, fne2->name, fne1->name_len);
+	return fanotify_info_equal(info1, info2);
 }
 
 static bool fanotify_should_merge(struct fsnotify_event *old_fsn,
-			 struct fsnotify_event *new_fsn)
+				  struct fsnotify_event *new_fsn)
 {
 	struct fanotify_event *old, *new;
 
@@ -276,8 +298,14 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	return test_mask & user_mask;
 }
 
-static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
-			       gfp_t gfp)
+/*
+ * Encode fanotify_fh.
+ *
+ * Return total size of encoded fh including fanotify_fh header.
+ * Return 0 on failure to encode.
+ */
+static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
+			      gfp_t gfp)
 {
 	int dwords, type, bytes = 0;
 	char *ext_buf = NULL;
@@ -287,7 +315,7 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	fh->type = FILEID_ROOT;
 	fh->len = 0;
 	if (!inode)
-		return;
+		return 0;
 
 	dwords = 0;
 	err = -ENOENT;
@@ -315,7 +343,7 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	fh->type = type;
 	fh->len = bytes;
 
-	return;
+	return FANOTIFY_FH_HDR_LEN + bytes;
 
 out_err:
 	pr_warn_ratelimited("fanotify: failed to encode fid (type=%d, len=%d, err=%i)\n",
@@ -325,6 +353,7 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	/* Report the event without a file identifier on encode error */
 	fh->type = FILEID_INVALID;
 	fh->len = 0;
+	return 0;
 }
 
 /*
@@ -401,6 +430,8 @@ struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 						 gfp_t gfp)
 {
 	struct fanotify_name_event *fne;
+	struct fanotify_info *info;
+	struct fanotify_fh *dfh;
 
 	fne = kmalloc(sizeof(*fne) + file_name->len + 1, gfp);
 	if (!fne)
@@ -408,9 +439,11 @@ struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
 
 	fne->fae.type = FANOTIFY_EVENT_TYPE_FID_NAME;
 	fne->fsid = *fsid;
-	fanotify_encode_fh(&fne->dir_fh, id, gfp);
-	fne->name_len = file_name->len;
-	strcpy(fne->name, file_name->name);
+	info = &fne->info;
+	fanotify_info_init(info);
+	dfh = fanotify_info_dir_fh(info);
+	info->dir_fh_totlen = fanotify_encode_fh(dfh, id, gfp);
+	fanotify_info_copy_name(info, file_name);
 
 	return &fne->fae;
 }
@@ -626,9 +659,10 @@ static void fanotify_free_fid_event(struct fanotify_event *event)
 static void fanotify_free_name_event(struct fanotify_event *event)
 {
 	struct fanotify_name_event *fne = FANOTIFY_NE(event);
+	struct fanotify_fh *dfh = fanotify_info_dir_fh(&fne->info);
 
-	if (fanotify_fh_has_ext_buf(&fne->dir_fh))
-		kfree(fanotify_fh_ext_buf(&fne->dir_fh));
+	if (fanotify_fh_has_ext_buf(dfh))
+		kfree(fanotify_fh_ext_buf(dfh));
 	kfree(fne);
 }
 
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 1b2a3bbe6008..5e104fc56abb 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -23,11 +23,29 @@ enum {
  * stored in either the first or last 2 dwords.
  */
 #define FANOTIFY_INLINE_FH_LEN	(3 << 2)
+#define FANOTIFY_FH_HDR_LEN	offsetof(struct fanotify_fh, buf)
 
+/* Fixed size struct for file handle */
 struct fanotify_fh {
-	unsigned char buf[FANOTIFY_INLINE_FH_LEN];
 	u8 type;
 	u8 len;
+	u8 pad[2];
+	unsigned char buf[FANOTIFY_INLINE_FH_LEN];
+} __aligned(4);
+
+/* Variable size struct for dir file handle + child file handle + name */
+struct fanotify_info {
+	/* size of dir_fh/file_fh including fanotify_fh hdr size */
+	u8 dir_fh_totlen;
+	u8 file_fh_totlen;
+	u8 name_len;
+	u8 pad;
+	unsigned char buf[];
+	/*
+	 * (struct fanotify_fh) dir_fh starts at buf[0]
+	 * (optional) file_fh starts at buf[dir_fh_totlen]
+	 * name starts at buf[dir_fh_totlen + file_fh_totlen]
+	 */
 } __aligned(4);
 
 static inline bool fanotify_fh_has_ext_buf(struct fanotify_fh *fh)
@@ -37,6 +55,7 @@ static inline bool fanotify_fh_has_ext_buf(struct fanotify_fh *fh)
 
 static inline char **fanotify_fh_ext_buf_ptr(struct fanotify_fh *fh)
 {
+	BUILD_BUG_ON(FANOTIFY_FH_HDR_LEN % 4);
 	BUILD_BUG_ON(__alignof__(char *) - 4 + sizeof(char *) >
 		     FANOTIFY_INLINE_FH_LEN);
 	return (char **)ALIGN((unsigned long)(fh->buf), __alignof__(char *));
@@ -52,6 +71,56 @@ static inline void *fanotify_fh_buf(struct fanotify_fh *fh)
 	return fanotify_fh_has_ext_buf(fh) ? fanotify_fh_ext_buf(fh) : fh->buf;
 }
 
+static inline int fanotify_info_dir_fh_len(struct fanotify_info *info)
+{
+	if (!info->dir_fh_totlen ||
+	    WARN_ON_ONCE(info->dir_fh_totlen < FANOTIFY_FH_HDR_LEN))
+		return 0;
+
+	return info->dir_fh_totlen - FANOTIFY_FH_HDR_LEN;
+}
+
+static inline struct fanotify_fh *fanotify_info_dir_fh(struct fanotify_info *info)
+{
+	BUILD_BUG_ON(offsetof(struct fanotify_info, buf) % 4);
+
+	return (struct fanotify_fh *)info->buf;
+}
+
+static inline int fanotify_info_file_fh_len(struct fanotify_info *info)
+{
+	if (!info->file_fh_totlen ||
+	    WARN_ON_ONCE(info->file_fh_totlen < FANOTIFY_FH_HDR_LEN))
+		return 0;
+
+	return info->file_fh_totlen - FANOTIFY_FH_HDR_LEN;
+}
+
+static inline struct fanotify_fh *fanotify_info_file_fh(struct fanotify_info *info)
+{
+	return (struct fanotify_fh *)(info->buf + info->dir_fh_totlen);
+}
+
+static inline const char *fanotify_info_name(struct fanotify_info *info)
+{
+	return info->buf + info->dir_fh_totlen + info->file_fh_totlen;
+}
+
+static inline void fanotify_info_init(struct fanotify_info *info)
+{
+	info->dir_fh_totlen = 0;
+	info->file_fh_totlen = 0;
+	info->name_len = 0;
+}
+
+static inline void fanotify_info_copy_name(struct fanotify_info *info,
+					   const struct qstr *name)
+{
+	info->name_len = name->len;
+	strcpy(info->buf + info->dir_fh_totlen + info->file_fh_totlen,
+	       name->name);
+}
+
 /*
  * Common structure for fanotify events. Concrete structs are allocated in
  * fanotify_handle_event() and freed when the information is retrieved by
@@ -96,9 +165,9 @@ FANOTIFY_FE(struct fanotify_event *event)
 struct fanotify_name_event {
 	struct fanotify_event fae;
 	__kernel_fsid_t fsid;
-	struct fanotify_fh dir_fh;
-	u8 name_len;
-	char name[];
+	struct fanotify_info info;
+	/* Reserve space in info.buf[] - access with fanotify_info_dir_fh() */
+	struct fanotify_fh _dir_fh;
 };
 
 static inline struct fanotify_name_event *
@@ -126,11 +195,11 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
 		return NULL;
 }
 
-static inline struct fanotify_fh *fanotify_event_dir_fh(
+static inline struct fanotify_info *fanotify_event_info(
 						struct fanotify_event *event)
 {
 	if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
-		return &FANOTIFY_NE(event)->dir_fh;
+		return &FANOTIFY_NE(event)->info;
 	else
 		return NULL;
 }
@@ -142,15 +211,11 @@ static inline int fanotify_event_object_fh_len(struct fanotify_event *event)
 	return fh ? fh->len : 0;
 }
 
-static inline bool fanotify_event_has_name(struct fanotify_event *event)
+static inline int fanotify_event_dir_fh_len(struct fanotify_event *event)
 {
-	return event->type == FANOTIFY_EVENT_TYPE_FID_NAME;
-}
+	struct fanotify_info *info = fanotify_event_info(event);
 
-static inline int fanotify_event_name_len(struct fanotify_event *event)
-{
-	return fanotify_event_has_name(event) ?
-		FANOTIFY_NE(event)->name_len : 0;
+	return info ? fanotify_info_dir_fh_len(info) : 0;
 }
 
 struct fanotify_path_event {
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 42b8cc51cb3f..f490ebe913f3 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -66,19 +66,17 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
 
 static int fanotify_event_info_len(struct fanotify_event *event)
 {
-	int info_len = 0;
+	struct fanotify_info *info = fanotify_event_info(event);
+	int dir_fh_len = fanotify_event_dir_fh_len(event);
 	int fh_len = fanotify_event_object_fh_len(event);
+	int info_len = 0;
+
+	if (dir_fh_len)
+		info_len += fanotify_fid_info_len(dir_fh_len, info->name_len);
 
 	if (fh_len)
 		info_len += fanotify_fid_info_len(fh_len, 0);
 
-	if (fanotify_event_name_len(event)) {
-		struct fanotify_name_event *fne = FANOTIFY_NE(event);
-
-		info_len += fanotify_fid_info_len(fne->dir_fh.len,
-						  fne->name_len);
-	}
-
 	return info_len;
 }
 
@@ -305,6 +303,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 {
 	struct fanotify_event_metadata metadata;
 	struct path *path = fanotify_event_path(event);
+	struct fanotify_info *info = fanotify_event_info(event);
 	struct file *f = NULL;
 	int ret, fd = FAN_NOFD;
 
@@ -346,13 +345,11 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		fd_install(fd, f);
 
 	/* Event info records order is: dir fid + name, child fid */
-	if (fanotify_event_name_len(event)) {
-		struct fanotify_name_event *fne = FANOTIFY_NE(event);
-
+	if (fanotify_event_dir_fh_len(event)) {
 		ret = copy_info_to_user(fanotify_event_fsid(event),
-					fanotify_event_dir_fh(event),
-					fne->name, fne->name_len,
-					buf, count);
+					fanotify_info_dir_fh(info),
+					fanotify_info_name(info),
+					info->name_len, buf, count);
 		if (ret < 0)
 			return ret;
 
-- 
2.17.1

