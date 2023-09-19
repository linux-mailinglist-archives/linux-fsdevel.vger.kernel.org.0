Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00747A6C4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 22:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjISUXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 16:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjISUXh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:23:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C4FC0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 13:23:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31dca134c83so6022896f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 13:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695155006; x=1695759806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CYD6YTMLPT4t6jUzcWWTEuj+F1jSGU0ikASMiaGZDio=;
        b=RnW6+KUkQEc6g/g2T3zs6eCA0rokyQpeuuRF2/JtiK/kDagJvNEvipxRJtbLaH8xLh
         t8s1uJ5kCdsYJ7mtRCjAj79nIhVSxI2n9xH0rXIOjXs02QPRIBtDWeNytX7xgdUzVlG5
         X5MNPnLWYfrimJOiCVm3/c9IJbwfqSfowNhF9dYfq6TYejJ1F+ndxL9noAYRvj1bfK0b
         rtNtcuSB102T6B+B9qr5DhulXIH4u6oxaN2iHczpj88sOEYORdPHM/cxT8da3NZpPFfO
         u5L4xZu6P07KN4jR17ScPOy0C4Es5n84p+Ji4NQbwSuGwqeRqqhks3nkspYSGDYLF15e
         xoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695155006; x=1695759806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYD6YTMLPT4t6jUzcWWTEuj+F1jSGU0ikASMiaGZDio=;
        b=ASDHbAH/CAYYbjzKxTBddk4KossGPuxgMt/k6tOki7joZlGlvrMed+x545f7cCPiSW
         4N0UxPrEZnfKrqpkIi3Ac0o5rXWtLxRMhZ19EjwgnVPfdmLAcv4ojvdB+F+7riEv6gWC
         4Klfbz1K3mnfEcQhCyClKtQWiPr/S3ZXE9SUSnOWBaBPiqJ1nB4VRio/gj6h5YjxAf44
         mLxEAwV2rmTi+v0yBjI5t+cxt2pq4QD7qBTfKq9FRlAOhHvvWYvSQmJNSqZ47f+qGamY
         bIoxMM9wY8u0BTVT7n+Co1FvnQOtcbk0pd9DsY4Lq+u6roy4s/VUPClzSidGtFJOtJUt
         QLYA==
X-Gm-Message-State: AOJu0YxYXN8cpuij9ZmL1FhuKrIqCjB9D7w93nyeASXQ6dih2XxgN+le
        VqZK+GFSTpV90Oa/GIOfaM35tA==
X-Google-Smtp-Source: AGHT+IEg/jLQVN8w60N42A67FdG8HZtVq7ylngADeyLJcj4udoquc/JaDyD0CJemuNN5jTsyPLNwJQ==
X-Received: by 2002:a5d:4b83:0:b0:31f:9501:fc0c with SMTP id b3-20020a5d4b83000000b0031f9501fc0cmr369111wrt.45.1695155006500;
        Tue, 19 Sep 2023 13:23:26 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id z25-20020a1c4c19000000b003fe29f6b61bsm16055440wmf.46.2023.09.19.13.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 13:23:25 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] inotify: support returning file_handles
Date:   Tue, 19 Sep 2023 22:23:03 +0200
Message-Id: <20230919202304.1197654-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds the watch mask bit "IN_FID".  It implements semantics
similar to fanotify's "FAN_REPORT_FID": if the bit is set in a "struct
inotify_event", the event (and the name) are followed by a "struct
inotify_extra_fid" which contains the filesystem id (not yet
implemented) and the file_handle.

It is debatable whether this is a useful feature; not useful for me,
but Jan Kara cited this feature as an advantage of fanotify over
inotify:
https://lore.kernel.org/linux-fsdevel/20230919100112.nlb2t4nm46wmugc2@quack3/

In a follow-up, Amir Goldstein did not want to accept that this
feature could be added easily to inotify, telling me that I "do not
understand the complexity involved":
https://lore.kernel.org/linux-fsdevel/CAOQ4uxgG6ync6dSBJiGW98docJGnajALiV+9tuwGiRt8NE8F+w@mail.gmail.com/

.. which Jan Kara agreed with: "I'll really find out it isn't so easy"
https://lore.kernel.org/linux-fsdevel/20230919132818.4s3n5bsqmokof6n2@quack3/

So here it is, an easy implementation in less than 90 lines of code
(which is slightly incomplete; grep TODO).  This is a per-watch flag
and there is no backwards compatibility breakage because the extra
struct is only added if explicitly requested by user space.

This is just a proof-of-concept, to demonstrate that adding such a
feature to inotify is not only possible, but also easy.  Even though
this part of the kernel is new to me, apparently I do "understand the
complexity involved", after all.

I don't expect this to be merged.  As much as I'd like to see inotify
improved because fanotify is too complex and cumbersome for my taste,
I'm not deluded enough to believe this PoC will convince anybody.  But
hacking it was fun and helped me learn about the inotify code which I
may continue to improve in our private kernel fork.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/notify/inotify/inotify.h          |  4 ++-
 fs/notify/inotify/inotify_fsnotify.c | 31 ++++++++++++++++++++
 fs/notify/inotify/inotify_user.c     | 43 +++++++++++++++++++++++++++-
 include/linux/inotify.h              |  1 +
 include/uapi/linux/inotify.h         | 11 +++++++
 5 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/fs/notify/inotify/inotify.h b/fs/notify/inotify/inotify.h
index 7d5df7a21539..2b20aa67fa8b 100644
--- a/fs/notify/inotify/inotify.h
+++ b/fs/notify/inotify/inotify.h
@@ -9,6 +9,8 @@ struct inotify_event_info {
 	int wd;
 	u32 sync_cookie;
 	int name_len;
+	__kernel_fsid_t fsid;
+	u8 file_handle_size;
 	char name[];
 };
 
@@ -27,7 +29,7 @@ static inline struct inotify_event_info *INOTIFY_E(struct fsnotify_event *fse)
  * userspace.  There is at least one bit (FS_EVENT_ON_CHILD) which is
  * used only internally to the kernel.
  */
-#define INOTIFY_USER_MASK (IN_ALL_EVENTS)
+#define INOTIFY_USER_MASK (IN_ALL_EVENTS|IN_FID)
 
 static inline __u32 inotify_mark_user_mask(struct fsnotify_mark *fsn_mark)
 {
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 993375f0db67..1fdfaac91d7b 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -17,6 +17,7 @@
 #include <linux/fs.h> /* struct inode */
 #include <linux/fsnotify_backend.h>
 #include <linux/inotify.h>
+#include <linux/exportfs.h>
 #include <linux/path.h> /* struct path */
 #include <linux/slab.h> /* kmem_* */
 #include <linux/types.h>
@@ -43,6 +44,7 @@ static bool event_compare(struct fsnotify_event *old_fsn,
 	    (old->name_len == new->name_len) &&
 	    (!old->name_len || !strcmp(old->name, new->name)))
 		return true;
+	// TODO compare fsid, file_handle
 	return false;
 }
 
@@ -56,6 +58,16 @@ static int inotify_merge(struct fsnotify_group *group,
 	return event_compare(last_event, event);
 }
 
+static int get_file_handle_dwords(struct inode *inode)
+{
+	if (inode == NULL)
+		return 0;
+
+	int dwords = 0;
+	exportfs_encode_fid(inode, NULL, &dwords);
+	return dwords;
+}
+
 int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 			       struct inode *inode, struct inode *dir,
 			       const struct qstr *name, u32 cookie)
@@ -66,7 +78,9 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	struct fsnotify_group *group = inode_mark->group;
 	int ret;
 	int len = 0, wd;
+	int file_handle_dwords;
 	int alloc_len = sizeof(struct inotify_event_info);
+	size_t file_handle_offset = 0;
 	struct mem_cgroup *old_memcg;
 
 	if (name) {
@@ -74,6 +88,14 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 		alloc_len += len + 1;
 	}
 
+	if (inode_mark->mask & IN_FID) {
+		file_handle_dwords = get_file_handle_dwords(inode);
+		if (file_handle_dwords > 0) {
+			file_handle_offset = roundup(alloc_len, 4);
+			alloc_len = file_handle_offset + sizeof(struct file_handle) + (file_handle_dwords << 2);
+		}
+	}
+
 	pr_debug("%s: group=%p mark=%p mask=%x\n", __func__, group, inode_mark,
 		 mask);
 
@@ -120,9 +142,18 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	event->wd = wd;
 	event->sync_cookie = cookie;
 	event->name_len = len;
+	memset(&event->fsid, 0, sizeof(event->fsid)); // TODO
 	if (len)
 		strcpy(event->name, name->name);
 
+	if (file_handle_offset > 0) {
+		struct file_handle *fh = (struct file_handle *)((unsigned char *)event + file_handle_offset);
+		fh->handle_type = exportfs_encode_fid(inode, (struct fid *)fh->f_handle, &file_handle_dwords);
+		fh->handle_bytes = file_handle_dwords << 2;
+		event->mask |= IN_FID;
+		event->file_handle_size = sizeof(*fh) + (file_handle_dwords << 2);
+	}
+
 	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
 	if (ret) {
 		/* Our event wasn't used in the end. Free it. */
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 1c4bfdab008d..a6bf235314b8 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -133,6 +133,7 @@ static inline unsigned int inotify_arg_to_flags(u32 arg)
 static inline u32 inotify_mask_to_arg(__u32 mask)
 {
 	return mask & (IN_ALL_EVENTS | IN_ISDIR | IN_UNMOUNT | IN_IGNORED |
+		       IN_FID |
 		       IN_Q_OVERFLOW);
 }
 
@@ -173,6 +174,7 @@ static struct fsnotify_event *get_one_event(struct fsnotify_group *group,
 {
 	size_t event_size = sizeof(struct inotify_event);
 	struct fsnotify_event *event;
+	const struct inotify_event_info *ie;
 
 	event = fsnotify_peek_first_event(group);
 	if (!event)
@@ -181,6 +183,12 @@ static struct fsnotify_event *get_one_event(struct fsnotify_group *group,
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
 	event_size += round_event_name_len(event);
+
+	ie = INOTIFY_E(event);
+	if (ie->mask & IN_FID)
+		event_size += roundup(sizeof(struct inotify_extra_fid) + ie->file_handle_size,
+				      sizeof(struct inotify_event));
+
 	if (event_size > count)
 		return ERR_PTR(-EINVAL);
 
@@ -241,9 +249,42 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		/* fill userspace with 0's */
 		if (clear_user(buf, pad_name_len - name_len))
 			return -EFAULT;
+
+		buf += pad_name_len - name_len;
 		event_size += pad_name_len;
 	}
 
+	if (event->mask & IN_FID) {
+		const size_t handle_size = event->file_handle_size;
+		const size_t extra_size = sizeof(struct inotify_extra_fid) + handle_size;
+		const size_t padded_extra_size = roundup(extra_size, sizeof(struct inotify_event));
+		const size_t padding = padded_extra_size - extra_size;
+
+		const struct inotify_extra_fid extra = {
+			.fsid = event->fsid,
+			.handle_size = handle_size,
+			.padding = padding,
+		};
+
+		if (copy_to_user(buf, &extra, sizeof(extra)))
+			return -EFAULT;
+
+		buf += sizeof(extra);
+
+		const unsigned char *handle = (const unsigned char *)(event + 1) + roundup(name_len + (name_len > 0), 4);
+		if (copy_to_user(buf, handle, handle_size))
+			return -EFAULT;
+
+		buf += handle_size;
+
+		if (clear_user(buf, padding))
+			return -EFAULT;
+
+		buf += padding;
+
+		event_size += padded_extra_size;
+	}
+
 	return event_size;
 }
 
@@ -860,7 +901,7 @@ static int __init inotify_user_setup(void)
 	BUILD_BUG_ON(IN_IGNORED != FS_IN_IGNORED);
 	BUILD_BUG_ON(IN_ISDIR != FS_ISDIR);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_INOTIFY_BITS) != 22);
+	BUILD_BUG_ON(HWEIGHT32(ALL_INOTIFY_BITS) != 23);
 
 	inotify_inode_mark_cachep = KMEM_CACHE(inotify_inode_mark,
 					       SLAB_PANIC|SLAB_ACCOUNT);
diff --git a/include/linux/inotify.h b/include/linux/inotify.h
index 8d20caa1b268..0b23353a2f32 100644
--- a/include/linux/inotify.h
+++ b/include/linux/inotify.h
@@ -13,6 +13,7 @@
 			  IN_CLOSE_NOWRITE | IN_OPEN | IN_MOVED_FROM | \
 			  IN_MOVED_TO | IN_CREATE | IN_DELETE | \
 			  IN_DELETE_SELF | IN_MOVE_SELF | IN_UNMOUNT | \
+			  IN_FID | \
 			  IN_Q_OVERFLOW | IN_IGNORED | IN_ONLYDIR | \
 			  IN_DONT_FOLLOW | IN_EXCL_UNLINK | IN_MASK_ADD | \
 			  IN_MASK_CREATE | IN_ISDIR | IN_ONESHOT)
diff --git a/include/uapi/linux/inotify.h b/include/uapi/linux/inotify.h
index b3e165853d5b..90520262e47b 100644
--- a/include/uapi/linux/inotify.h
+++ b/include/uapi/linux/inotify.h
@@ -26,6 +26,16 @@ struct inotify_event {
 	char		name[];	/* stub for possible name */
 };
 
+struct inotify_extra_fid {
+	__kernel_fsid_t fsid;
+
+	__u8 handle_size;
+	__u8 padding;
+	__u8 reserved1, reserved2;
+
+	unsigned char handle[];
+};
+
 /* the following are legal, implemented events that user-space can watch for */
 #define IN_ACCESS		0x00000001	/* File was accessed */
 #define IN_MODIFY		0x00000002	/* File was modified */
@@ -50,6 +60,7 @@ struct inotify_event {
 #define IN_MOVE			(IN_MOVED_FROM | IN_MOVED_TO) /* moves */
 
 /* special flags */
+#define IN_FID			0x00800000	/* return fsid and file_handle (struct inotify_extra_fid) */
 #define IN_ONLYDIR		0x01000000	/* only watch the path if it is a directory */
 #define IN_DONT_FOLLOW		0x02000000	/* don't follow a sym link */
 #define IN_EXCL_UNLINK		0x04000000	/* exclude events on unlinked objects */
-- 
2.39.2

