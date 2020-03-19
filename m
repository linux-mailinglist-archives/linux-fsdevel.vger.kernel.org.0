Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A4B18BAAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgCSPK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:10:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46992 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgCSPK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:10:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so48500wru.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cb6lUWyfJYVDyB4wPMBGrg1wfAdW+cF1bQpBgq0CT7Y=;
        b=c7Klv0vNP99AyjdT4jr6H+7iiqfnKhXfBD4VFyXSSgd2m9P3Kp3gHCFXWMGlN3aTRp
         7Dg5i8KXvX2S+zumbEMhOhUSGNhr6fwgVpuWc6sT3ximt84reRt2xXpYSDcQyplN9VWM
         zJDH1R19GK2mg383Rhif204i15wBnhoMGnvmm4g8Ll7Ha/aAnIe50SskxRarwqRYIzw4
         3Wl1OYUMOYN+Ncr17uivP+WNFpM4Vgs1DSKljRHCz/dm3Sykzf3OQk/2pmvH2pGWYcBz
         730fp549MDeLcvgAYA7XR4VSZmjbJyc/GniJ4PoTGI5/ptTr/4wXXymVmSV1vcxXigpd
         5Y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cb6lUWyfJYVDyB4wPMBGrg1wfAdW+cF1bQpBgq0CT7Y=;
        b=GU+TK7bIIwlD+rBsgg7amWxrQGqlYigxu22g57Q46qvhPZarXd899Q4fMR1CmjGoug
         VIHZ5xKGD0Zi8vz5W0OgJZoURbzBra8Mhkd2sjRRsQrs4AEHmSn/AzQlXq35PUe3GN8j
         oF2wNRVTnJXcdga9qyYRXorceTC9WWjEloCzVGgXH4gzaV6KKJm73emCNvIWHdyH0k4P
         mIkUVb06vyVbPdxXdpRiPNnEr+TtptpHua+f3R6gBO4nAR1vZNtbGSInR8i29vTL5uE/
         BuPvEfohup1ksuVu18KN6ez5H5b3etzxO0J3AsxcDOXuqjPjHKJIye5a613iJZkHzJKf
         6TSA==
X-Gm-Message-State: ANhLgQ3jidlMrp3mhC4g/7lmEFs20uUyuNtx7kmr52YxJjFnAK3R0EdW
        J5j4U/HCTMnTUQqexinRvyg=
X-Google-Smtp-Source: ADFU+vtye7kTva61Pwz0k9E9TfAz6os/mdPZe3n6bmVprHwdvcFdbEV7fw6DioovANaNiRvewK1kWg==
X-Received: by 2002:a5d:5710:: with SMTP id a16mr4964015wrv.5.1584630654144;
        Thu, 19 Mar 2020 08:10:54 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:53 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 10/14] fanotify: divorce fanotify_path_event and fanotify_fid_event
Date:   Thu, 19 Mar 2020 17:10:18 +0200
Message-Id: <20200319151022.31456-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Breakup the union and make them both inherit from abstract fanotify_event.

fanotify_path_event, fanotify_fid_event and fanotify_perm_event inherit
from fanotify_event.

type field in abstract fanotify_event determines the concrete event type.

fanotify_path_event, fanotify_fid_event and fanotify_perm_event are
allocated from separate memcache pools.

The separation of struct fanotify_fid_hdr from the file handle that was
done for efficient packing of fanotify_event is no longer needed, so
re-group the file handle fields under struct fanotify_fh.

The struct fanotify_fid, which served to group fsid and file handle for
the union is no longer needed so break it up.

Rename fanotify_perm_event casting macro to FANOTIFY_PERM(), so that
FANOTIFY_PE() and FANOTIFY_FE() can be used as casting macros to
fanotify_path_event and fanotify_fid_event.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 201 +++++++++++++++++++++--------
 fs/notify/fanotify/fanotify.h      | 146 ++++++++++++---------
 fs/notify/fanotify/fanotify_user.c |  69 +++++-----
 3 files changed, 265 insertions(+), 151 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 960f4f4d9e8f..4c5dd5db21bd 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -17,6 +17,42 @@
 
 #include "fanotify.h"
 
+static bool fanotify_path_equal(struct path *p1, struct path *p2)
+{
+	return p1->mnt == p2->mnt && p1->dentry == p2->dentry;
+}
+
+static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
+				       __kernel_fsid_t *fsid2)
+{
+	return fsid1->val[0] == fsid1->val[0] && fsid2->val[1] == fsid2->val[1];
+}
+
+static bool fanotify_fh_equal(struct fanotify_fh *fh1,
+			      struct fanotify_fh *fh2)
+{
+	if (fh1->type != fh2->type || fh1->len != fh2->len)
+		return false;
+
+	/* Do not merge events if we failed to encode fh */
+	if (fh1->type == FILEID_INVALID)
+		return false;
+
+	return !fh1->len ||
+		!memcmp(fanotify_fh_buf(fh1), fanotify_fh_buf(fh2), fh1->len);
+}
+
+static bool fanotify_fid_event_equal(struct fanotify_fid_event *ffe1,
+				     struct fanotify_fid_event *ffe2)
+{
+	/* Do not merge fid events without object fh */
+	if (!ffe1->object_fh.len)
+		return false;
+
+	return fanotify_fsid_equal(&ffe1->fsid, &ffe2->fsid) &&
+		fanotify_fh_equal(&ffe1->object_fh, &ffe2->object_fh);
+}
+
 static bool should_merge(struct fsnotify_event *old_fsn,
 			 struct fsnotify_event *new_fsn)
 {
@@ -26,14 +62,15 @@ static bool should_merge(struct fsnotify_event *old_fsn,
 	old = FANOTIFY_E(old_fsn);
 	new = FANOTIFY_E(new_fsn);
 
-	if (old_fsn->objectid != new_fsn->objectid || old->pid != new->pid ||
-	    old->fh_type != new->fh_type || old->fh_len != new->fh_len)
+	if (old_fsn->objectid != new_fsn->objectid ||
+	    old->type != new->type || old->pid != new->pid)
 		return false;
 
-	if (fanotify_event_has_path(old)) {
-		return old->path.mnt == new->path.mnt &&
-			old->path.dentry == new->path.dentry;
-	} else if (fanotify_event_has_fid(old)) {
+	switch (old->type) {
+	case FANOTIFY_EVENT_TYPE_PATH:
+		return fanotify_path_equal(fanotify_event_path(old),
+					   fanotify_event_path(new));
+	case FANOTIFY_EVENT_TYPE_FID:
 		/*
 		 * We want to merge many dirent events in the same dir (i.e.
 		 * creates/unlinks/renames), but we do not want to merge dirent
@@ -42,11 +79,15 @@ static bool should_merge(struct fsnotify_event *old_fsn,
 		 * mask FAN_CREATE|FAN_DELETE|FAN_ONDIR if it describes mkdir+
 		 * unlink pair or rmdir+create pair of events.
 		 */
-		return (old->mask & FS_ISDIR) == (new->mask & FS_ISDIR) &&
-			fanotify_fid_equal(&old->fid, &new->fid, old->fh_len);
+		if ((old->mask & FS_ISDIR) != (new->mask & FS_ISDIR))
+			return false;
+
+		return fanotify_fid_event_equal(FANOTIFY_FE(old),
+						FANOTIFY_FE(new));
+	default:
+		WARN_ON_ONCE(1);
 	}
 
-	/* Do not merge events if we failed to encode fid */
 	return false;
 }
 
@@ -213,15 +254,14 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	return test_mask & user_mask;
 }
 
-static int fanotify_encode_fid(struct fanotify_event *event,
-			       struct inode *inode, gfp_t gfp,
-			       __kernel_fsid_t *fsid)
+static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
+			       gfp_t gfp)
 {
-	struct fanotify_fid *fid = &event->fid;
-	int dwords, bytes = 0;
-	int err, type;
+	int dwords, type, bytes = 0;
+	char *ext_buf = NULL;
+	void *buf = fh->buf;
+	int err;
 
-	fid->ext_fh = NULL;
 	dwords = 0;
 	err = -ENOENT;
 	type = exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
@@ -232,31 +272,32 @@ static int fanotify_encode_fid(struct fanotify_event *event,
 	if (bytes > FANOTIFY_INLINE_FH_LEN) {
 		/* Treat failure to allocate fh as failure to allocate event */
 		err = -ENOMEM;
-		fid->ext_fh = kmalloc(bytes, gfp);
-		if (!fid->ext_fh)
+		ext_buf = kmalloc(bytes, gfp);
+		if (!ext_buf)
 			goto out_err;
+
+		*fanotify_fh_ext_buf_ptr(fh) = ext_buf;
+		buf = ext_buf;
 	}
 
-	type = exportfs_encode_inode_fh(inode, fanotify_fid_fh(fid, bytes),
-					&dwords, NULL);
+	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
 	err = -EINVAL;
 	if (!type || type == FILEID_INVALID || bytes != dwords << 2)
 		goto out_err;
 
-	fid->fsid = *fsid;
-	event->fh_len = bytes;
+	fh->type = type;
+	fh->len = bytes;
 
-	return type;
+	return;
 
 out_err:
-	pr_warn_ratelimited("fanotify: failed to encode fid (fsid=%x.%x, "
-			    "type=%d, bytes=%d, err=%i)\n",
-			    fsid->val[0], fsid->val[1], type, bytes, err);
-	kfree(fid->ext_fh);
-	fid->ext_fh = NULL;
-	event->fh_len = 0;
-
-	return FILEID_INVALID;
+	pr_warn_ratelimited("fanotify: failed to encode fid (type=%d, len=%d, err=%i)\n",
+			    type, bytes, err);
+	kfree(ext_buf);
+	*fanotify_fh_ext_buf_ptr(fh) = NULL;
+	/* Report the event without a file identifier on encode error */
+	fh->type = FILEID_INVALID;
+	fh->len = 0;
 }
 
 /*
@@ -282,10 +323,17 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 					    __kernel_fsid_t *fsid)
 {
 	struct fanotify_event *event = NULL;
+	struct fanotify_fid_event *ffe = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
 	const struct path *path = fsnotify_data_path(data, data_type);
 
+	/* Make sure we can easily cast between inherited structs */
+	BUILD_BUG_ON(offsetof(struct fanotify_event, fse) != 0);
+	BUILD_BUG_ON(offsetof(struct fanotify_fid_event, fae) != 0);
+	BUILD_BUG_ON(offsetof(struct fanotify_path_event, fae) != 0);
+	BUILD_BUG_ON(offsetof(struct fanotify_perm_event, fae) != 0);
+
 	/*
 	 * For queues with unlimited length lost events are not expected and
 	 * can possibly have security implications. Avoid losing events when
@@ -306,14 +354,29 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 		pevent = kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
 		if (!pevent)
 			goto out;
+
 		event = &pevent->fae;
+		event->type = FANOTIFY_EVENT_TYPE_PATH_PERM;
 		pevent->response = 0;
 		pevent->state = FAN_EVENT_INIT;
 		goto init;
 	}
-	event = kmem_cache_alloc(fanotify_event_cachep, gfp);
-	if (!event)
-		goto out;
+
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
+		ffe = kmem_cache_alloc(fanotify_fid_event_cachep, gfp);
+		if (!ffe)
+			goto out;
+
+		event = &ffe->fae;
+		event->type = FANOTIFY_EVENT_TYPE_FID;
+	} else {
+		event = kmem_cache_alloc(fanotify_path_event_cachep, gfp);
+		if (!event)
+			goto out;
+
+		event->type = FANOTIFY_EVENT_TYPE_PATH;
+	}
+
 init: __maybe_unused
 	/*
 	 * Use the victim inode instead of the watching inode as the id for
@@ -326,18 +389,22 @@ init: __maybe_unused
 		event->pid = get_pid(task_pid(current));
 	else
 		event->pid = get_pid(task_tgid(current));
-	event->fh_len = 0;
-	if (id && FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
-		/* Report the event without a file identifier on encode error */
-		event->fh_type = fanotify_encode_fid(event, id, gfp, fsid);
-	} else if (path) {
-		event->fh_type = FILEID_ROOT;
-		event->path = *path;
-		path_get(path);
-	} else {
-		event->fh_type = FILEID_INVALID;
-		event->path.mnt = NULL;
-		event->path.dentry = NULL;
+	if (fanotify_event_has_fid(event)) {
+		ffe->object_fh.len = 0;
+		if (fsid)
+			ffe->fsid = *fsid;
+		if (id)
+			fanotify_encode_fh(&ffe->object_fh, id, gfp);
+	} else if (fanotify_event_has_path(event)) {
+		struct path *p = fanotify_event_path(event);
+
+		if (path) {
+			*p = *path;
+			path_get(path);
+		} else {
+			p->mnt = NULL;
+			p->dentry = NULL;
+		}
 	}
 out:
 	memalloc_unuse_memcg();
@@ -457,7 +524,7 @@ static int fanotify_handle_event(struct fsnotify_group *group,
 
 		ret = 0;
 	} else if (fanotify_is_perm_event(mask)) {
-		ret = fanotify_get_response(group, FANOTIFY_PE(fsn_event),
+		ret = fanotify_get_response(group, FANOTIFY_PERM(fsn_event),
 					    iter_info);
 	}
 finish:
@@ -476,22 +543,44 @@ static void fanotify_free_group_priv(struct fsnotify_group *group)
 	free_uid(user);
 }
 
+static void fanotify_free_path_event(struct fanotify_event *event)
+{
+	path_put(fanotify_event_path(event));
+	kmem_cache_free(fanotify_path_event_cachep, event);
+}
+
+static void fanotify_free_perm_event(struct fanotify_event *event)
+{
+	path_put(fanotify_event_path(event));
+	kmem_cache_free(fanotify_perm_event_cachep, event);
+}
+
+static void fanotify_free_fid_event(struct fanotify_fid_event *ffe)
+{
+	if (fanotify_fh_has_ext_buf(&ffe->object_fh))
+		kfree(fanotify_fh_ext_buf(&ffe->object_fh));
+	kmem_cache_free(fanotify_fid_event_cachep, ffe);
+}
+
 static void fanotify_free_event(struct fsnotify_event *fsn_event)
 {
 	struct fanotify_event *event;
 
 	event = FANOTIFY_E(fsn_event);
-	if (fanotify_event_has_path(event))
-		path_put(&event->path);
-	else if (fanotify_event_has_ext_fh(event))
-		kfree(event->fid.ext_fh);
 	put_pid(event->pid);
-	if (fanotify_is_perm_event(event->mask)) {
-		kmem_cache_free(fanotify_perm_event_cachep,
-				FANOTIFY_PE(fsn_event));
-		return;
+	switch (event->type) {
+	case FANOTIFY_EVENT_TYPE_PATH:
+		fanotify_free_path_event(event);
+		break;
+	case FANOTIFY_EVENT_TYPE_PATH_PERM:
+		fanotify_free_perm_event(event);
+		break;
+	case FANOTIFY_EVENT_TYPE_FID:
+		fanotify_free_fid_event(FANOTIFY_FE(event));
+		break;
+	default:
+		WARN_ON_ONCE(1);
 	}
-	kmem_cache_free(fanotify_event_cachep, event);
 }
 
 static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 68b30504284c..1bc73a65d9d2 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -5,7 +5,8 @@
 #include <linux/exportfs.h>
 
 extern struct kmem_cache *fanotify_mark_cache;
-extern struct kmem_cache *fanotify_event_cachep;
+extern struct kmem_cache *fanotify_fid_event_cachep;
+extern struct kmem_cache *fanotify_path_event_cachep;
 extern struct kmem_cache *fanotify_perm_event_cachep;
 
 /* Possible states of the permission event */
@@ -18,96 +19,102 @@ enum {
 
 /*
  * 3 dwords are sufficient for most local fs (64bit ino, 32bit generation).
- * For 32bit arch, fid increases the size of fanotify_event by 12 bytes and
- * fh_* fields increase the size of fanotify_event by another 4 bytes.
- * For 64bit arch, fid increases the size of fanotify_fid by 8 bytes and
- * fh_* fields are packed in a hole after mask.
+ * fh buf should be dword aligned. On 64bit arch, the ext_buf pointer is
+ * stored in either the first or last 2 dwords.
  */
-#if BITS_PER_LONG == 32
 #define FANOTIFY_INLINE_FH_LEN	(3 << 2)
-#else
-#define FANOTIFY_INLINE_FH_LEN	(4 << 2)
-#endif
 
-struct fanotify_fid {
-	__kernel_fsid_t fsid;
-	union {
-		unsigned char fh[FANOTIFY_INLINE_FH_LEN];
-		unsigned char *ext_fh;
-	};
-};
+struct fanotify_fh {
+	unsigned char buf[FANOTIFY_INLINE_FH_LEN];
+	u8 type;
+	u8 len;
+} __aligned(4);
+
+static inline bool fanotify_fh_has_ext_buf(struct fanotify_fh *fh)
+{
+	return fh->len > FANOTIFY_INLINE_FH_LEN;
+}
+
+static inline char **fanotify_fh_ext_buf_ptr(struct fanotify_fh *fh)
+{
+	BUILD_BUG_ON(__alignof__(char *) - 4 + sizeof(char *) >
+		     FANOTIFY_INLINE_FH_LEN);
+	return (char **)ALIGN((unsigned long)(fh->buf), __alignof__(char *));
+}
 
-static inline void *fanotify_fid_fh(struct fanotify_fid *fid,
-				    unsigned int fh_len)
+static inline void *fanotify_fh_ext_buf(struct fanotify_fh *fh)
 {
-	return fh_len <= FANOTIFY_INLINE_FH_LEN ? fid->fh : fid->ext_fh;
+	return *fanotify_fh_ext_buf_ptr(fh);
 }
 
-static inline bool fanotify_fid_equal(struct fanotify_fid *fid1,
-				      struct fanotify_fid *fid2,
-				      unsigned int fh_len)
+static inline void *fanotify_fh_buf(struct fanotify_fh *fh)
 {
-	return fid1->fsid.val[0] == fid2->fsid.val[0] &&
-		fid1->fsid.val[1] == fid2->fsid.val[1] &&
-		!memcmp(fanotify_fid_fh(fid1, fh_len),
-			fanotify_fid_fh(fid2, fh_len), fh_len);
+	return fanotify_fh_has_ext_buf(fh) ? fanotify_fh_ext_buf(fh) : fh->buf;
 }
 
 /*
- * Structure for normal fanotify events. It gets allocated in
+ * Common structure for fanotify events. Concrete structs are allocated in
  * fanotify_handle_event() and freed when the information is retrieved by
- * userspace
+ * userspace. The type of event determines how it was allocated, how it will
+ * be freed and which concrete struct it may be cast to.
  */
+enum fanotify_event_type {
+	FANOTIFY_EVENT_TYPE_FID,
+	FANOTIFY_EVENT_TYPE_PATH,
+	FANOTIFY_EVENT_TYPE_PATH_PERM,
+};
+
 struct fanotify_event {
 	struct fsnotify_event fse;
 	u32 mask;
-	/*
-	 * Those fields are outside fanotify_fid to pack fanotify_event nicely
-	 * on 64bit arch and to use fh_type as an indication of whether path
-	 * or fid are used in the union:
-	 * FILEID_ROOT (0) for path, > 0 for fid, FILEID_INVALID for neither.
-	 */
-	u8 fh_type;
-	u8 fh_len;
-	u16 pad;
-	union {
-		/*
-		 * We hold ref to this path so it may be dereferenced at any
-		 * point during this object's lifetime
-		 */
-		struct path path;
-		/*
-		 * With FAN_REPORT_FID, we do not hold any reference on the
-		 * victim object. Instead we store its NFS file handle and its
-		 * filesystem's fsid as a unique identifier.
-		 */
-		struct fanotify_fid fid;
-	};
+	enum fanotify_event_type type;
 	struct pid *pid;
 };
 
-static inline bool fanotify_event_has_path(struct fanotify_event *event)
+struct fanotify_fid_event {
+	struct fanotify_event fae;
+	__kernel_fsid_t fsid;
+	struct fanotify_fh object_fh;
+};
+
+#define FANOTIFY_FE(event) ((struct fanotify_fid_event *)(event))
+
+static inline bool fanotify_event_has_fid(struct fanotify_event *event)
 {
-	return event->fh_type == FILEID_ROOT;
+	return event->type == FANOTIFY_EVENT_TYPE_FID;
 }
 
-static inline bool fanotify_event_has_fid(struct fanotify_event *event)
+static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
 {
-	return event->fh_type != FILEID_ROOT &&
-		event->fh_type != FILEID_INVALID;
+	if (event->type == FANOTIFY_EVENT_TYPE_FID)
+		return &FANOTIFY_FE(event)->fsid;
+	else
+		return NULL;
 }
 
-static inline bool fanotify_event_has_ext_fh(struct fanotify_event *event)
+static inline struct fanotify_fh *fanotify_event_object_fh(
+						struct fanotify_event *event)
 {
-	return fanotify_event_has_fid(event) &&
-		event->fh_len > FANOTIFY_INLINE_FH_LEN;
+	if (event->type == FANOTIFY_EVENT_TYPE_FID)
+		return &FANOTIFY_FE(event)->object_fh;
+	else
+		return NULL;
 }
 
-static inline void *fanotify_event_fh(struct fanotify_event *event)
+static inline int fanotify_event_object_fh_len(struct fanotify_event *event)
 {
-	return fanotify_fid_fh(&event->fid, event->fh_len);
+	struct fanotify_fh *fh = fanotify_event_object_fh(event);
+
+	return fh ? fh->len : 0;
 }
 
+struct fanotify_path_event {
+	struct fanotify_event fae;
+	struct path path;
+};
+
+#define FANOTIFY_PE(event) ((struct fanotify_path_event *)(event))
+
 /*
  * Structure for permission fanotify events. It gets allocated and freed in
  * fanotify_handle_event() since we wait there for user response. When the
@@ -117,13 +124,14 @@ static inline void *fanotify_event_fh(struct fanotify_event *event)
  */
 struct fanotify_perm_event {
 	struct fanotify_event fae;
+	struct path path;
 	unsigned short response;	/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
 	int fd;		/* fd we passed to userspace for this event */
 };
 
 static inline struct fanotify_perm_event *
-FANOTIFY_PE(struct fsnotify_event *fse)
+FANOTIFY_PERM(struct fsnotify_event *fse)
 {
 	return container_of(fse, struct fanotify_perm_event, fae.fse);
 }
@@ -139,6 +147,22 @@ static inline struct fanotify_event *FANOTIFY_E(struct fsnotify_event *fse)
 	return container_of(fse, struct fanotify_event, fse);
 }
 
+static inline bool fanotify_event_has_path(struct fanotify_event *event)
+{
+	return event->type == FANOTIFY_EVENT_TYPE_PATH ||
+		event->type == FANOTIFY_EVENT_TYPE_PATH_PERM;
+}
+
+static inline struct path *fanotify_event_path(struct fanotify_event *event)
+{
+	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
+		return &FANOTIFY_PE(event)->path;
+	else if (event->type == FANOTIFY_EVENT_TYPE_PATH_PERM)
+		return &((struct fanotify_perm_event *)event)->path;
+	else
+		return NULL;
+}
+
 struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 					    struct inode *inode, u32 mask,
 					    const void *data, int data_type,
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0aa362b88550..6d30627863ff 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -46,18 +46,21 @@
 extern const struct fsnotify_ops fanotify_fsnotify_ops;
 
 struct kmem_cache *fanotify_mark_cache __read_mostly;
-struct kmem_cache *fanotify_event_cachep __read_mostly;
+struct kmem_cache *fanotify_fid_event_cachep __read_mostly;
+struct kmem_cache *fanotify_path_event_cachep __read_mostly;
 struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
 
 #define FANOTIFY_EVENT_ALIGN 4
 
 static int fanotify_event_info_len(struct fanotify_event *event)
 {
-	if (!fanotify_event_has_fid(event))
+	int fh_len = fanotify_event_object_fh_len(event);
+
+	if (!fh_len)
 		return 0;
 
 	return roundup(sizeof(struct fanotify_event_info_fid) +
-		       sizeof(struct file_handle) + event->fh_len,
+		       sizeof(struct file_handle) + fh_len,
 		       FANOTIFY_EVENT_ALIGN);
 }
 
@@ -90,20 +93,19 @@ static struct fsnotify_event *get_one_event(struct fsnotify_group *group,
 	}
 	fsn_event = fsnotify_remove_first_event(group);
 	if (fanotify_is_perm_event(FANOTIFY_E(fsn_event)->mask))
-		FANOTIFY_PE(fsn_event)->state = FAN_EVENT_REPORTED;
+		FANOTIFY_PERM(fsn_event)->state = FAN_EVENT_REPORTED;
 out:
 	spin_unlock(&group->notification_lock);
 	return fsn_event;
 }
 
-static int create_fd(struct fsnotify_group *group,
-		     struct fanotify_event *event,
+static int create_fd(struct fsnotify_group *group, struct path *path,
 		     struct file **file)
 {
 	int client_fd;
 	struct file *new_file;
 
-	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
+	pr_debug("%s: group=%p path=%p\n", __func__, group, path);
 
 	client_fd = get_unused_fd_flags(group->fanotify_data.f_flags);
 	if (client_fd < 0)
@@ -113,14 +115,9 @@ static int create_fd(struct fsnotify_group *group,
 	 * we need a new file handle for the userspace program so it can read even if it was
 	 * originally opened O_WRONLY.
 	 */
-	/* it's possible this event was an overflow event.  in that case dentry and mnt
-	 * are NULL;  That's fine, just don't call dentry open */
-	if (event->path.dentry && event->path.mnt)
-		new_file = dentry_open(&event->path,
-				       group->fanotify_data.f_flags | FMODE_NONOTIFY,
-				       current_cred());
-	else
-		new_file = ERR_PTR(-EOVERFLOW);
+	new_file = dentry_open(path,
+			       group->fanotify_data.f_flags | FMODE_NONOTIFY,
+			       current_cred());
 	if (IS_ERR(new_file)) {
 		/*
 		 * we still send an event even if we can't open the file.  this
@@ -208,8 +205,9 @@ static int copy_fid_to_user(struct fanotify_event *event, char __user *buf)
 {
 	struct fanotify_event_info_fid info = { };
 	struct file_handle handle = { };
-	unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh;
-	size_t fh_len = event->fh_len;
+	unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh_buf;
+	struct fanotify_fh *fh = fanotify_event_object_fh(event);
+	size_t fh_len = fh->len;
 	size_t len = fanotify_event_info_len(event);
 
 	if (!len)
@@ -221,13 +219,13 @@ static int copy_fid_to_user(struct fanotify_event *event, char __user *buf)
 	/* Copy event info fid header followed by vaiable sized file handle */
 	info.hdr.info_type = FAN_EVENT_INFO_TYPE_FID;
 	info.hdr.len = len;
-	info.fsid = event->fid.fsid;
+	info.fsid = *fanotify_event_fsid(event);
 	if (copy_to_user(buf, &info, sizeof(info)))
 		return -EFAULT;
 
 	buf += sizeof(info);
 	len -= sizeof(info);
-	handle.handle_type = event->fh_type;
+	handle.handle_type = fh->type;
 	handle.handle_bytes = fh_len;
 	if (copy_to_user(buf, &handle, sizeof(handle)))
 		return -EFAULT;
@@ -238,12 +236,12 @@ static int copy_fid_to_user(struct fanotify_event *event, char __user *buf)
 	 * For an inline fh, copy through stack to exclude the copy from
 	 * usercopy hardening protections.
 	 */
-	fh = fanotify_event_fh(event);
+	fh_buf = fanotify_fh_buf(fh);
 	if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
-		memcpy(bounce, fh, fh_len);
-		fh = bounce;
+		memcpy(bounce, fh_buf, fh_len);
+		fh_buf = bounce;
 	}
-	if (copy_to_user(buf, fh, fh_len))
+	if (copy_to_user(buf, fh_buf, fh_len))
 		return -EFAULT;
 
 	/* Pad with 0's */
@@ -261,13 +259,13 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 				  char __user *buf, size_t count)
 {
 	struct fanotify_event_metadata metadata;
-	struct fanotify_event *event;
+	struct fanotify_event *event = FANOTIFY_E(fsn_event);
+	struct path *path = fanotify_event_path(event);
 	struct file *f = NULL;
 	int ret, fd = FAN_NOFD;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, fsn_event);
 
-	event = container_of(fsn_event, struct fanotify_event, fse);
 	metadata.event_len = FAN_EVENT_METADATA_LEN;
 	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
 	metadata.vers = FANOTIFY_METADATA_VERSION;
@@ -275,12 +273,12 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
 	metadata.pid = pid_vnr(event->pid);
 
-	if (fanotify_event_has_path(event)) {
-		fd = create_fd(group, event, &f);
+	if (fanotify_event_has_fid(event)) {
+		metadata.event_len += fanotify_event_info_len(event);
+	} else if (path && path->mnt && path->dentry) {
+		fd = create_fd(group, path, &f);
 		if (fd < 0)
 			return fd;
-	} else if (fanotify_event_has_fid(event)) {
-		metadata.event_len += fanotify_event_info_len(event);
 	}
 	metadata.fd = fd;
 
@@ -296,9 +294,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		goto out_close_fd;
 
 	if (fanotify_is_perm_event(event->mask))
-		FANOTIFY_PE(fsn_event)->fd = fd;
+		FANOTIFY_PERM(fsn_event)->fd = fd;
 
-	if (fanotify_event_has_path(event)) {
+	if (f) {
 		fd_install(fd, f);
 	} else if (fanotify_event_has_fid(event)) {
 		ret = copy_fid_to_user(event, buf + FAN_EVENT_METADATA_LEN);
@@ -390,7 +388,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 			if (ret <= 0) {
 				spin_lock(&group->notification_lock);
 				finish_permission_event(group,
-					FANOTIFY_PE(kevent), FAN_DENY);
+					FANOTIFY_PERM(kevent), FAN_DENY);
 				wake_up(&group->fanotify_data.access_waitq);
 			} else {
 				spin_lock(&group->notification_lock);
@@ -474,7 +472,7 @@ static int fanotify_release(struct inode *ignored, struct file *file)
 			spin_unlock(&group->notification_lock);
 			fsnotify_destroy_event(group, fsn_event);
 		} else {
-			finish_permission_event(group, FANOTIFY_PE(fsn_event),
+			finish_permission_event(group, FANOTIFY_PERM(fsn_event),
 						FAN_ALLOW);
 		}
 		spin_lock(&group->notification_lock);
@@ -1139,7 +1137,10 @@ static int __init fanotify_user_setup(void)
 
 	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
-	fanotify_event_cachep = KMEM_CACHE(fanotify_event, SLAB_PANIC);
+	fanotify_fid_event_cachep = KMEM_CACHE(fanotify_fid_event,
+					       SLAB_PANIC);
+	fanotify_path_event_cachep = KMEM_CACHE(fanotify_path_event,
+						SLAB_PANIC);
 	if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS)) {
 		fanotify_perm_event_cachep =
 			KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
-- 
2.17.1

