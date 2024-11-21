Return-Path: <linux-fsdevel+bounces-35418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2E79D4BA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3812815C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099061CFEC2;
	Thu, 21 Nov 2024 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EF5LNyPK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lYMdZe1c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EF5LNyPK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lYMdZe1c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4F1D1E65;
	Thu, 21 Nov 2024 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188149; cv=none; b=tLSYLDsccgsm3755Yi/6QmCHyU5zFtulkzk7D+HQRdvqAedk2YjXHxjyCSlZ9beYBsykBqizFfUScF48015AhwMH/DANDLwDiCvUfnCA6lZGTGxLwi708SeWeNTSrSgsHOy4QgGm02kA15edmh0Y1/oK339LyboUzMuNprgThnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188149; c=relaxed/simple;
	bh=c+axI1PEBbUQEWkf5cK7VekKYxbMSogFUmDcgnnDUQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iF0Td8yKkXBilCIFhrDSkA7Skn1h6EHKMdUK82bt3+M3MKGe+ri1QZNsGzbZxZnRBpWywM95hTtAhH5OpsvNR7N64aMOanduj11w1gQ4Br1syKr2QF3Td/nFjFK9jMA7bUev18NkXmGysubVdiqsMKHj6J44qdwpf1bWWNB68FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EF5LNyPK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lYMdZe1c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EF5LNyPK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lYMdZe1c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8456F21A02;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+bEVGbemNGehpTxJk8yxR4wDKTrpMY9CJ5Nf+cADDY=;
	b=EF5LNyPKpuVUU8Cm8jh7PSjOG9GxMTYi4RJODsWvIE7csbtr2dE4ZQPdylydWISfzbIZnD
	YdXhHQnPdj5O2EGPpl0mnd/aLx0M5PjMo7Ok0B9Nh6A4Y8ft84ykwEO4GENtB4oqVLTjDO
	pEIwY44Kbh5sYrMEXjVgOr46fKTRdjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+bEVGbemNGehpTxJk8yxR4wDKTrpMY9CJ5Nf+cADDY=;
	b=lYMdZe1cHPy7d56PGhjblrQhzBGJWZhwf8KRE37pzjtOQxS6+FMKTl6J7vq0pVBv9zgl0+
	wU9iUxGhTifB61DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+bEVGbemNGehpTxJk8yxR4wDKTrpMY9CJ5Nf+cADDY=;
	b=EF5LNyPKpuVUU8Cm8jh7PSjOG9GxMTYi4RJODsWvIE7csbtr2dE4ZQPdylydWISfzbIZnD
	YdXhHQnPdj5O2EGPpl0mnd/aLx0M5PjMo7Ok0B9Nh6A4Y8ft84ykwEO4GENtB4oqVLTjDO
	pEIwY44Kbh5sYrMEXjVgOr46fKTRdjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+bEVGbemNGehpTxJk8yxR4wDKTrpMY9CJ5Nf+cADDY=;
	b=lYMdZe1cHPy7d56PGhjblrQhzBGJWZhwf8KRE37pzjtOQxS6+FMKTl6J7vq0pVBv9zgl0+
	wU9iUxGhTifB61DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72C4413A23;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Eyn+G/AXP2c0fwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:22:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0972BA090B; Thu, 21 Nov 2024 12:22:24 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	brauner@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 08/19] fsnotify: pass optional file access range in pre-content event
Date: Thu, 21 Nov 2024 12:22:07 +0100
Message-Id: <20241121112218.8249-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241121112218.8249-1-jack@suse.cz>
References: <20241121112218.8249-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,toxicpanda.com,kernel.org,linux-foundation.org,ZenIV.linux.org.uk,vger.kernel.org,kvack.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLdu9otajk16idfrkma9mbkf9b)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,msgid.link:url];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

From: Amir Goldstein <amir73il@gmail.com>

We would like to add file range information to pre-content events.

Pass a struct file_range with offset and length to event handler
along with pre-content permission event.

The offset and length are aligned to page size, but we may need to
align them to minimum folio size for filesystems with large block size.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/88eddee301231d814aede27fb4d5b41ae37c9702.1731684329.git.josef@toxicpanda.com
---
 fs/notify/fanotify/fanotify.c    | 11 +++++++--
 fs/notify/fanotify/fanotify.h    |  2 ++
 fs/notify/fsnotify.c             | 18 ++++++++++++++
 include/linux/fsnotify.h         |  4 ++--
 include/linux/fsnotify_backend.h | 40 ++++++++++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 224bccaab4cc..c1e4ae221093 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -549,9 +549,13 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
 	return &pevent->fae;
 }
 
-static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
+static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
+							int data_type,
 							gfp_t gfp)
 {
+	const struct path *path = fsnotify_data_path(data, data_type);
+	const struct file_range *range =
+			    fsnotify_data_file_range(data, data_type);
 	struct fanotify_perm_event *pevent;
 
 	pevent = kmem_cache_alloc(fanotify_perm_event_cachep, gfp);
@@ -565,6 +569,9 @@ static struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
 	pevent->hdr.len = 0;
 	pevent->state = FAN_EVENT_INIT;
 	pevent->path = *path;
+	/* NULL ppos means no range info */
+	pevent->ppos = range ? &range->pos : NULL;
+	pevent->count = range ? range->count : 0;
 	path_get(path);
 
 	return &pevent->fae;
@@ -802,7 +809,7 @@ static struct fanotify_event *fanotify_alloc_event(
 	old_memcg = set_active_memcg(group->memcg);
 
 	if (fanotify_is_perm_event(mask)) {
-		event = fanotify_alloc_perm_event(path, gfp);
+		event = fanotify_alloc_perm_event(data, data_type, gfp);
 	} else if (fanotify_is_error_event(mask)) {
 		event = fanotify_alloc_error_event(group, fsid, data,
 						   data_type, &hash);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index e5ab33cae6a7..93598b7d5952 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -425,6 +425,8 @@ FANOTIFY_PE(struct fanotify_event *event)
 struct fanotify_perm_event {
 	struct fanotify_event fae;
 	struct path path;
+	const loff_t *ppos;		/* optional file range info */
+	size_t count;
 	u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
 	int fd;		/* fd we passed to userspace for this event */
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index d61f6bc679f1..e8625b61100a 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -203,6 +203,24 @@ static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
 	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
 }
 
+/* Report pre-content event with optional range info */
+int fsnotify_pre_content(const struct path *path, const loff_t *ppos,
+			 size_t count)
+{
+	struct file_range range;
+
+	/* Report page aligned range only when pos is known */
+	if (!ppos)
+		return fsnotify_path(path, FS_PRE_ACCESS);
+
+	range.path = path;
+	range.pos = PAGE_ALIGN_DOWN(*ppos);
+	range.count = PAGE_ALIGN(*ppos + count) - range.pos;
+
+	return fsnotify_parent(path->dentry, FS_PRE_ACCESS, &range,
+			       FSNOTIFY_EVENT_FILE_RANGE);
+}
+
 /*
  * Notify this dentry's parent about a child's events with child name info
  * if parent is watching or if inode/sb/mount are interested in events with
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index d91aa064f0e4..87044acf8e79 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -154,7 +154,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 * read()/write() and other types of access generate pre-content events.
 	 */
 	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
-		int ret = fsnotify_path(&file->f_path, FS_PRE_ACCESS);
+		int ret = fsnotify_pre_content(&file->f_path, ppos, count);
 
 		if (ret)
 			return ret;
@@ -171,7 +171,7 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 }
 
 /*
- * fsnotify_file_perm - permission hook before file access
+ * fsnotify_file_perm - permission hook before file access (unknown range)
  */
 static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 9bda354b5538..0d24a21a8e60 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -294,6 +294,7 @@ static inline void fsnotify_group_assert_locked(struct fsnotify_group *group)
 /* When calling fsnotify tell it if the data is a path or inode */
 enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
+	FSNOTIFY_EVENT_FILE_RANGE,
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
 	FSNOTIFY_EVENT_DENTRY,
@@ -306,6 +307,17 @@ struct fs_error_report {
 	struct super_block *sb;
 };
 
+struct file_range {
+	const struct path *path;
+	loff_t pos;
+	size_t count;
+};
+
+static inline const struct path *file_range_path(const struct file_range *range)
+{
+	return range->path;
+}
+
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 {
 	switch (data_type) {
@@ -315,6 +327,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 		return d_inode(data);
 	case FSNOTIFY_EVENT_PATH:
 		return d_inode(((const struct path *)data)->dentry);
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return d_inode(file_range_path(data)->dentry);
 	case FSNOTIFY_EVENT_ERROR:
 		return ((struct fs_error_report *)data)->inode;
 	default:
@@ -330,6 +344,8 @@ static inline struct dentry *fsnotify_data_dentry(const void *data, int data_typ
 		return (struct dentry *)data;
 	case FSNOTIFY_EVENT_PATH:
 		return ((const struct path *)data)->dentry;
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return file_range_path(data)->dentry;
 	default:
 		return NULL;
 	}
@@ -341,6 +357,8 @@ static inline const struct path *fsnotify_data_path(const void *data,
 	switch (data_type) {
 	case FSNOTIFY_EVENT_PATH:
 		return data;
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return file_range_path(data);
 	default:
 		return NULL;
 	}
@@ -356,6 +374,8 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
 		return ((struct dentry *)data)->d_sb;
 	case FSNOTIFY_EVENT_PATH:
 		return ((const struct path *)data)->dentry->d_sb;
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return file_range_path(data)->dentry->d_sb;
 	case FSNOTIFY_EVENT_ERROR:
 		return ((struct fs_error_report *) data)->sb;
 	default:
@@ -375,6 +395,18 @@ static inline struct fs_error_report *fsnotify_data_error_report(
 	}
 }
 
+static inline const struct file_range *fsnotify_data_file_range(
+							const void *data,
+							int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_FILE_RANGE:
+		return (struct file_range *)data;
+	default:
+		return NULL;
+	}
+}
+
 /*
  * Index to merged marks iterator array that correlates to a type of watch.
  * The type of watched object can be deduced from the iterator type, but not
@@ -863,9 +895,17 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
 {
 	INIT_LIST_HEAD(&event->list);
 }
+int fsnotify_pre_content(const struct path *path, const loff_t *ppos,
+			 size_t count);
 
 #else
 
+static inline int fsnotify_pre_content(const struct path *path,
+				       const loff_t *ppos, size_t count)
+{
+	return 0;
+}
+
 static inline int fsnotify(__u32 mask, const void *data, int data_type,
 			   struct inode *dir, const struct qstr *name,
 			   struct inode *inode, u32 cookie)
-- 
2.35.3


