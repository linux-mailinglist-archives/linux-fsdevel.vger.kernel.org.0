Return-Path: <linux-fsdevel+bounces-79689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D30MKEGrGkxjAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 12:06:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C577422B596
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 12:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 524F13018E20
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092B933E37B;
	Sat,  7 Mar 2026 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrN46z5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A967322C99
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881558; cv=none; b=ljsEfoX98NbeM6SRf2aEJ8wvhTTVLxwpu/W5Id5kXxOpKpgp8a6DBfjShtkqUs2LFplljnL7q6Qu/+nMH7+GjbcTtBLhbN8EkP6aajHh7M6YdsVGh2hiVbNrMmoDvI3jjEjC7UBOviMMN0rt9Fv9XJwUCdj1jQX2rj+R9M3hh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881558; c=relaxed/simple;
	bh=QgmV3JVFmlGnaV6gjFaseUOrKkZX3kUyK/bclRmd2fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qd3ub7MYaRsZZQ37WsSm/eDb4PpmTYjw5NKWB9N13CRyIye4DAvbZFZcMQG3u1lOVcwC16qRDlDeEAAff7P9Wb6/WAS+BdXvPMNK1g9kOZcQ+vNXFBGiFiS6MPIeMxwNks1tL7nSVbgFZ4HYYL3opfaEVFw3EMb1sYNT80cXCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrN46z5Z; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-661be3380adso2072555a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 03:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772881555; x=1773486355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEJ2S5Li+vooChIxQzKyuxNfWi8Hu85Y5iLcxxHfm04=;
        b=jrN46z5Z5m8Ebd4UuXQDV/DBGa1EaHbJWXzLtYHQO5wYxOH0CT1XEWUM/J3EGzlfqw
         vZIQw7dFoKj2OkO966HtzCu2KQcooSqTsMkjNaT3cALS9HPiJqauZNnETZJb6034bDZG
         0/mpp7hudPTaN/DVf6r2Xx0ru3TYEDNp7e37ZxTg5o03jxrlv46ltYIJwwinYaT1hQ7q
         xH0KMz59iv/na060J5++AE8r703MGE52cxVai5dZNIoQ+flNmKGeJdrkSkKKn1COK0lk
         StXQjGjndujk3GGWB283HCdbjHRHqr0Mk1QbMTuuxNhaDh58NRci24nExWi/twrfccuD
         ujDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772881555; x=1773486355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dEJ2S5Li+vooChIxQzKyuxNfWi8Hu85Y5iLcxxHfm04=;
        b=rhnAA6bg/aCPWXjvynLTaKSuD5E1Y1F9dLNjOy6aGFuh02tugwrgKIu5zbgieFG8Mp
         caufLFSWiXLemmXvUlATmOOyxcj9WQBRjMtlIFpCZsyUmVD7f18ybwePehzxgX7VEml+
         NYsWd2RTSYd+Iiz1o9//LG/H+8y1tx3jYB+0vQ55GuvdJ+8snXpqtUbTRm8mOa4q28e4
         0I7pOwKlxt/3sEZ6K45K9aqUGsTtGIwCFGxcJLcWg+mbfKJ53U9qpC4xhQmxiFkV60Yr
         yDYDrk2vMTcssR33sO9tix5GjaR/UBj3uVbAgDV2nmbZNi7udqWYM9JhTC1IeMAASmP3
         8eqg==
X-Forwarded-Encrypted: i=1; AJvYcCXAlZjmlIsS900t0p027DL29nVGenoDAET2PRpkARgHO75OpRULQMCw6aTpA0+YdFjc8a4vbIC9X2ta6zGT@vger.kernel.org
X-Gm-Message-State: AOJu0YzhypJatYtSZmjYQLz9s+1rzWwbZdcdqhFw3kbSaFQqzcsdpOsb
	7BdimaseH+m4ZzwRClCk13MQY+5CQDqd8GFRGn7IqBCbXMaZTky2B3Dj
X-Gm-Gg: ATEYQzxq4/OvpOQl9CLNbPvC1bKEUwpysspCBJ92AvQz72Wpba0uSrm+K5GV75XeTuN
	U8Df16MKDHH9P/2hSzYf01yvgOQuOusVubKWqkULfm7QKhLLzfO5UiQgRdBJBFMqyLTwgLwMPQ7
	KjH1i6MwiMB6pxZmwOWbG5UUOmpXA1IK1d6rXpmBUbnFppAMh94PL9lYJnVD+dbYuIHcU8b3Z01
	Nhc67DgGTRmvQH5Wo2cQq2cjpjF9MkcbWgBYVbOWa3LmDqonqkuUJJl6pDxMqgmCsFHx86xV+OG
	K83rNu4LEm1ySeHg4zLKBa4lwVEUtszZ0ZS2tGhJaG+SDCzCugPGu7jZRV8tvIxAauzh1LQ1Ab9
	J6jCBL149Q4l/oFCDVrV69C/Cs3wOO33zpzQXjBIsHtHunGOgoiIvuxGJEzHpSOnyZT13fMFMp2
	Yx/d3gKbGvE0kp87Lna6qA0ZxPUV/X2ZbrbQ9HHVPkVcDZyA/B+pGK+tF5+T637W/uPMUU1f6hq
	MQSg7i0NSPafrFhsIJu+bpH+n04
X-Received: by 2002:a05:6402:146a:b0:658:cbf0:6a08 with SMTP id 4fb4d7f45d1cf-6619d4d9b1cmr2827267a12.17.1772881554788;
        Sat, 07 Mar 2026 03:05:54 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-7ad4-b88c-4d95-6756.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:7ad4:b88c:4d95:6756])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-661a559bab6sm1103991a12.29.2026.03.07.03.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 03:05:54 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Tejun Heo <tj@kernel.org>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 2/5] fanotify: use high bits for FAN_NS_CREATE/FAN_NS_DELETE
Date: Sat,  7 Mar 2026 12:05:47 +0100
Message-ID: <20260307110550.373762-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307110550.373762-1-amir73il@gmail.com>
References: <20260307110550.373762-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C577422B596
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-79689-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

For the uapi, but keep using FS_CREATE/FS_DELETE internally, because
we do not mix inode events with ns listeners.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 11 +++--
 fs/notify/fanotify/fanotify_user.c | 31 ++++++++++---
 fs/notify/fdinfo.c                 |  9 +++-
 include/linux/fanotify.h           |  5 ++-
 include/uapi/linux/fanotify.h      | 70 +++++++++++++++++-------------
 5 files changed, 81 insertions(+), 45 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 3818b4d53dcad..4b9c89772404e 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -304,9 +304,8 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     const void *data, int data_type,
 				     struct inode *dir)
 {
-	__u32 marks_mask = 0, marks_ignore_mask = 0;
-	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
-				     FANOTIFY_EVENT_FLAGS;
+	__u32 test_mask, marks_mask = 0, marks_ignore_mask = 0;
+	__u64 user_mask = FANOTIFY_OUTGOING_EVENTS | FANOTIFY_EVENT_FLAGS;
 	const struct path *path = fsnotify_data_path(data, data_type);
 	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
 	struct fsnotify_mark *mark;
@@ -980,8 +979,12 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
+	/* NS events live in upper 32 bits; verify the >> 32 round-trip used in copy_event_to_user */
+	BUILD_BUG_ON(upper_32_bits(FAN_NS_CREATE) != FAN_CREATE);
+	BUILD_BUG_ON(upper_32_bits(FAN_NS_DELETE) != FAN_DELETE);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 24);
+	/* ALL_FANOTIFY_EVENT_BITS now spans 64 bits (NS events in upper 32) */
+	BUILD_BUG_ON(HWEIGHT64(ALL_FANOTIFY_EVENT_BITS) != 26);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 126069101669a..3b23ec1ade8fc 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -883,7 +883,15 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
 	metadata.vers = FANOTIFY_METADATA_VERSION;
 	metadata.reserved = 0;
-	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
+	metadata.mask = event->mask;
+	/*
+	 * NS events are stored internally as FS_CREATE/FS_DELETE (lower 32
+	 * bits) but reported to userspace as FAN_NS_CREATE/FAN_NS_DELETE
+	 * (upper 32 bits).  Shift them back up for the UAPI event mask.
+	 */
+	if (fanotify_is_ns_event(event))
+		metadata.mask <<= 32;
+	metadata.mask &= FANOTIFY_OUTGOING_EVENTS;
 	metadata.pid = pid_vnr(event->pid);
 	/*
 	 * For an unprivileged listener, event->pid can be used to identify the
@@ -1916,7 +1924,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	struct fan_fsid __fsid, *fsid = NULL;
 	struct user_namespace *user_ns = NULL;
 	struct mnt_namespace *mntns;
-	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
+	u64 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
 	unsigned int ignore = flags & FANOTIFY_MARK_IGNORE_BITS;
@@ -1928,8 +1936,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	pr_debug("%s: fanotify_fd=%d flags=%x dfd=%d pathname=%p mask=%llx\n",
 		 __func__, fanotify_fd, flags, dfd, pathname, mask);
 
-	/* we only use the lower 32 bits as of right now. */
-	if (upper_32_bits(mask))
+	/*
+	 * NS events (FAN_NS_CREATE/FAN_NS_DELETE) live in the upper 32 bits
+	 * and are only valid for FAN_MARK_USERNS.  Reject any other upper bits.
+	 */
+	if (upper_32_bits(mask) && mark_type != FAN_MARK_USERNS)
 		return -EINVAL;
 
 	if (flags & ~FANOTIFY_MARK_FLAGS)
@@ -2056,7 +2067,8 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	 * point.
 	 */
 	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
-	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&
+	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_NS_EVENTS|
+		     FANOTIFY_EVENT_FLAGS) &&
 	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
 		return -EINVAL;
 
@@ -2178,7 +2190,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			mask |= FAN_EVENT_ON_CHILD;
 	}
 
-	/* create/update an inode mark */
+	/*
+	 * Translate upper-bit UAPI NS events to the internal FS_CREATE/
+	 * FS_DELETE bits used by fsnotify.
+	 */
+	if (obj_type == FSNOTIFY_OBJ_TYPE_USERNS)
+		mask >>= 32;
+
+	/* create/update an fsnotify mark */
 	switch (mark_cmd) {
 	case FAN_MARK_ADD:
 		ret = fanotify_add_mark(group, obj, obj_type, mask, flags,
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 946cffaf16e18..6106fad1dcf1b 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -135,8 +135,13 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 	} else if (mark->connector->type == FSNOTIFY_OBJ_TYPE_USERNS) {
 		struct user_namespace *userns = fsnotify_conn_userns(mark->connector);
 
-		seq_printf(m, "fanotify user_ns_id:%llu mflags:%x mask:%x ignored_mask:%x\n",
-			   userns->ns.ns_id, mflags, mark->mask, mark->ignore_mask);
+		/*
+		 * Userns marks store FS_CREATE/FS_DELETE internally but expose
+		 * FAN_NS_CREATE/FAN_NS_DELETE (upper 32 bits) to userspace.
+		 */
+		seq_printf(m, "fanotify user_ns_id:%llu mflags:%x mask:%llx ignored_mask:%llx\n",
+			   userns->ns.ns_id, mflags,
+			   (u64)mark->mask << 32, (u64)mark->ignore_mask << 32);
 	}
 }
 
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 279082ae40fe2..e85034063a115 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -115,13 +115,14 @@
 #define FANOTIFY_MOUNT_EVENTS	(FAN_MNT_ATTACH | FAN_MNT_DETACH)
 
 /* Events that can be reported with data type FSNOTIFY_EVENT_NS */
-#define FANOTIFY_NS_EVENTS	(FAN_CREATE | FAN_DELETE)
+#define FANOTIFY_NS_EVENTS	(FAN_NS_CREATE | FAN_NS_DELETE)
 
 /* Events that user can request to be notified on */
 #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
 				 FANOTIFY_INODE_EVENTS | \
 				 FANOTIFY_ERROR_EVENTS | \
-				 FANOTIFY_MOUNT_EVENTS)
+				 FANOTIFY_MOUNT_EVENTS | \
+				 FANOTIFY_NS_EVENTS)
 
 /* Extra flags that may be reported with event or control handling of events */
 #define FANOTIFY_EVENT_FLAGS	(FAN_EVENT_ON_CHILD | FAN_ONDIR)
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 6b4f470ee7e01..45ad484ceb473 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -5,37 +5,45 @@
 #include <linux/types.h>
 
 /* the following events that user-space can register for */
-#define FAN_ACCESS		0x00000001	/* File was accessed */
-#define FAN_MODIFY		0x00000002	/* File was modified */
-#define FAN_ATTRIB		0x00000004	/* Metadata changed */
-#define FAN_CLOSE_WRITE		0x00000008	/* Writable file closed */
-#define FAN_CLOSE_NOWRITE	0x00000010	/* Unwritable file closed */
-#define FAN_OPEN		0x00000020	/* File was opened */
-#define FAN_MOVED_FROM		0x00000040	/* File was moved from X */
-#define FAN_MOVED_TO		0x00000080	/* File was moved to Y */
-#define FAN_CREATE		0x00000100	/* Subfile was created */
-#define FAN_DELETE		0x00000200	/* Subfile was deleted */
-#define FAN_DELETE_SELF		0x00000400	/* Self was deleted */
-#define FAN_MOVE_SELF		0x00000800	/* Self was moved */
-#define FAN_OPEN_EXEC		0x00001000	/* File was opened for exec */
-
-#define FAN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
-#define FAN_FS_ERROR		0x00008000	/* Filesystem error */
-
-#define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
-#define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
-#define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
-/* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
-
-#define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
-#define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
-#define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
-
-#define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
-
-#define FAN_RENAME		0x10000000	/* File was renamed */
-
-#define FAN_ONDIR		0x40000000	/* Event occurred against dir */
+#define FAN_ACCESS		0x00000001ULL	/* File was accessed */
+#define FAN_MODIFY		0x00000002ULL	/* File was modified */
+#define FAN_ATTRIB		0x00000004ULL	/* Metadata changed */
+#define FAN_CLOSE_WRITE		0x00000008ULL	/* Writable file closed */
+#define FAN_CLOSE_NOWRITE	0x00000010ULL	/* Unwritable file closed */
+#define FAN_OPEN		0x00000020ULL	/* File was opened */
+#define FAN_MOVED_FROM		0x00000040ULL	/* File was moved from X */
+#define FAN_MOVED_TO		0x00000080ULL	/* File was moved to Y */
+#define FAN_CREATE		0x00000100ULL	/* Subfile was created */
+#define FAN_DELETE		0x00000200ULL	/* Subfile was deleted */
+#define FAN_DELETE_SELF		0x00000400ULL	/* Self was deleted */
+#define FAN_MOVE_SELF		0x00000800ULL	/* Self was moved */
+#define FAN_OPEN_EXEC		0x00001000ULL	/* File was opened for exec */
+
+#define FAN_Q_OVERFLOW		0x00004000ULL	/* Event queued overflowed */
+#define FAN_FS_ERROR		0x00008000ULL	/* Filesystem error */
+
+#define FAN_OPEN_PERM		0x00010000ULL	/* File open in perm check */
+#define FAN_ACCESS_PERM		0x00020000ULL	/* File accessed in perm check */
+#define FAN_OPEN_EXEC_PERM	0x00040000ULL	/* File open/exec in perm check */
+/* #define FAN_DIR_MODIFY	0x00080000ULL */	/* Deprecated (reserved) */
+
+#define FAN_PRE_ACCESS		0x00100000ULL	/* Pre-content access hook */
+#define FAN_MNT_ATTACH		0x01000000ULL	/* Mount was attached */
+#define FAN_MNT_DETACH		0x02000000ULL	/* Mount was detached */
+
+#define FAN_EVENT_ON_CHILD	0x08000000ULL	/* Interested in child events */
+
+#define FAN_RENAME		0x10000000ULL	/* File was renamed */
+
+#define FAN_ONDIR		0x40000000ULL	/* Event occurred against dir */
+
+/*
+ * Namespace lifecycle events use the upper 32 bits of the 64-bit mask
+ * to avoid confusion with the inode-level FAN_CREATE/FAN_DELETE events.
+ * They are only valid with FAN_MARK_USERNS and FAN_REPORT_NSID.
+ */
+#define FAN_NS_CREATE		(FAN_CREATE << 32)	/* Namespace became active */
+#define FAN_NS_DELETE		(FAN_DELETE << 32)	/* Namespace became inactive */
 
 /* helper events */
 #define FAN_CLOSE		(FAN_CLOSE_WRITE | FAN_CLOSE_NOWRITE) /* close */
-- 
2.53.0


