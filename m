Return-Path: <linux-fsdevel+bounces-46023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F076A8163D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 22:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B456882753
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 20:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD242417D8;
	Tue,  8 Apr 2025 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="bkSnEaEy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7862D22F167
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142474; cv=none; b=pZwy+Mp+vufxdijOxoql9SKafudE5zFCo7ViswTpoLJjYlwyPibC+8sdGsG2yGhlTT4pq5hgMNGNTRMdQu3WepvLrkI/YBWS1aPnoDWZEIwLgxGUciEM45OTfnslr0wywDgBiLzS7RcrBp0wIxDMzBhQuQWVqSsSSzSLC6zy0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142474; c=relaxed/simple;
	bh=HBaRo7J3bLsaCczX1fgsHTy7VFTjf+27fENGEz71BPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqNkNJCz9eZGmTPI+8IPQtcoBUNxdC15u2byGd410LHeCmsDk3paYtQzeXUPdRZzPeXDFA8kM44xW1a+ij5/qdqg3OoG0ALgJ124PoaqUaP7QBgXuaQKXo9iuprS6PJjXTZahaZ+Gf9cQgNGsneLiDCTXj/XTxdPsECIJn43g1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=bkSnEaEy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240b4de10eso11223865ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Apr 2025 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1744142471; x=1744747271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8J0R6yBxzK/GOcJKAqRCfa5wFeOTcS0tlUunoqnNC4w=;
        b=bkSnEaEyCw+eRCfxnGRnHn09OIfbErGyR/3N2qrtotw25hwRbuzY3kEN/h7BrsCXy5
         OVml6B7ayCkie8MfE16D2cXbS4mYG3wzLmeysWFMY5UH8746F4jVi9UfgrvleQNeRyik
         0aVJyISd1UntI2X+iuoKvCAlRreCDIQk/s5/evRP6r/wIAlZaNsRcyUmMD6WBz51tuL+
         qkxk307JRWiMy9cww9LZMRs8kfn1rZVue9d0bk7Qnl5Qw2oTMUMK2I/boZ+JvKT5j3BA
         wlsFzVhkUblienJiVSC2lYsMQL1P7AOCdyw2X7LbFkkaMqOyUZZO5H/zUxrAemHoJ5Ap
         F7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744142471; x=1744747271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8J0R6yBxzK/GOcJKAqRCfa5wFeOTcS0tlUunoqnNC4w=;
        b=I5fOCO+HTB2AtZmj7cbzT9MAC7fOlY+0GYEmL7fYZd92sldQB5W58nae6WXScInTl2
         /QxivA0yjT2Czenii5GZL1/wmUtSPFqtBrrTmoPs/O46nKBa6ltN6UfPiAJPvStEzK6W
         xLmOXu5FZZ7brwh9CljdA30tVSIbPbH8CgKot98vuiUXUv4VOkGbP/lKelV7VDrqEAz1
         0OazN6fOfEZFOOAJ40UJLYlAldiOlx8fc9AbWoH/DJtZc1UsMWVN7kBgngnbTEaO7FK/
         aOtYd5pU9Oddy75/1MhBKYH5Mb/bMMhy+FsHwX91s6N8zR3IDmZrnlSA3fUz4LJqs3Pg
         VLZQ==
X-Gm-Message-State: AOJu0YxxINBkyEgT2Wt5PB1iUvroXRszTSbyqkV0TGQ4wBNLk40K7cX/
	mno+rjmH3BLSORKBP/KwaSykVfFAyk8nTk9Ro5TJychkNcJV9acq4rB25/ghvsrs87f4PqqV0rn
	t
X-Gm-Gg: ASbGnct/ROiX4MDSjKJPdu71vbnxClkZKe+JZdZYz/YZ2cDSw4LCuQm+kyL8jLGKT4L
	LifLS4BTvns661mq2BKydlSimYfLYYXhcRecxFLDRhWB0xDboiSskBLDOmLzCc2Y6neGZcBFWJo
	4plaQi9nnfWvc+heWhMvjR6oOvnJaTce0HyjtdghmGgiHnG6Hcu68Dxvy6LCPuPkXEeit/awYdQ
	2yVYDhE25ofZBS51ymJgK1ddDfz7GFxC77mOsJtBuWI74QNsNZ/T8qF6rc7eCdrpx46/rKshiVu
	vHQ1RejU+nTj0MzLheUzoDENewFwZwWVU0N8X3sId6yId2AQRLqXhg==
X-Google-Smtp-Source: AGHT+IEDN9jPuYKDeG/dgpCj4iTQE24St0fQfRf6HYrLuR1j9mZ45NQIK7PGv5FgAol8ZAn8KJ1FAA==
X-Received: by 2002:a17:903:19cd:b0:224:1212:7da1 with SMTP id d9443c01a7336-22ac2c33f08mr2668585ad.13.1744142471250;
        Tue, 08 Apr 2025 13:01:11 -0700 (PDT)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::ae03])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e45fsm104981485ad.135.2025.04.08.13.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 13:01:10 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	linux-debuggers@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] dcache: convert dentry flag macros to enum
Date: Tue,  8 Apr 2025 13:00:53 -0700
Message-ID: <177665a082f048cf536b9cd6af467b3be6b6e6ed.1744141838.git.osandov@fb.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

Commit 9748cb2dc393 ("VFS: repack DENTRY_ flags.") changed the value of
DCACHE_MOUNTED, which broke drgn's path_lookup() helper. drgn is forced
to hard-code it because it's a macro, and macros aren't preserved in
debugging information by default.

Enums, on the other hand, are included in debugging information. Convert
the DCACHE_* flag macros to an enum so that debugging tools like drgn
and bpftrace can make use of them.

Link: https://github.com/osandov/drgn/blob/2027d0fea84d74b835e77392f7040c2a333180c6/drgn/helpers/linux/fs.py#L43-L46
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Hi,

This is based on Linus' tree as of today. If possible, it'd be great to
get this in for 6.15.

Here are a couple of examples of similar changes in the past:

	0b108e83795c ("SUNRPC: convert RPC_TASK_* constants to enum")
	ff202303c398 ("mm: convert page type macros to enum")

There's also an alternative approach that is more verbose but allows for
automatic numbering:

	enum dentry_flags {
		__DCACHE_OP_HASH,
		__DCACHE_OP_COMPARE,
		...
	};
	
	#define DCACHE_OP_HASH BIT(__DCACHE_OP_HASH)
	#define DCACHE_OP_COMPARE BIT(__DCACHE_OP_COMPARE)
	...

Let me know if you'd prefer that approach.

Thanks,
Omar

 include/linux/dcache.h | 105 ++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 55 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 8d1395f945bf..a945cc86a8f1 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -173,65 +173,60 @@ struct dentry_operations {
  */
 
 /* d_flags entries */
-#define DCACHE_OP_HASH			BIT(0)
-#define DCACHE_OP_COMPARE		BIT(1)
-#define DCACHE_OP_REVALIDATE		BIT(2)
-#define DCACHE_OP_DELETE		BIT(3)
-#define DCACHE_OP_PRUNE			BIT(4)
+enum dentry_flags {
+	DCACHE_OP_HASH = BIT(0),
+	DCACHE_OP_COMPARE = BIT(1),
+	DCACHE_OP_REVALIDATE = BIT(2),
+	DCACHE_OP_DELETE = BIT(3),
+	DCACHE_OP_PRUNE = BIT(4),
+	/*
+	 * This dentry is possibly not currently connected to the dcache tree,
+	 * in which case its parent will either be itself, or will have this
+	 * flag as well.  nfsd will not use a dentry with this bit set, but will
+	 * first endeavour to clear the bit either by discovering that it is
+	 * connected, or by performing lookup operations.  Any filesystem which
+	 * supports nfsd_operations MUST have a lookup function which, if it
+	 * finds a directory inode with a DCACHE_DISCONNECTED dentry, will
+	 * d_move that dentry into place and return that dentry rather than the
+	 * passed one, typically using d_splice_alias.
+	 */
+	DCACHE_DISCONNECTED = BIT(5),
+	DCACHE_REFERENCED = BIT(6),		/* Recently used, don't discard. */
+	DCACHE_DONTCACHE = BIT(7),		/* Purge from memory on final dput() */
+	DCACHE_CANT_MOUNT = BIT(8),
+	DCACHE_GENOCIDE = BIT(9),
+	DCACHE_SHRINK_LIST = BIT(10),
+	DCACHE_OP_WEAK_REVALIDATE = BIT(11),
+	/*
+	 * this dentry has been "silly renamed" and has to be deleted on the
+	 * last dput()
+	 */
+	DCACHE_NFSFS_RENAMED = BIT(12),
+	/* Parent inode is watched by some fsnotify listener */
+	DCACHE_FSNOTIFY_PARENT_WATCHED = BIT(13),
+	DCACHE_DENTRY_KILLED = BIT(14),
+	DCACHE_MOUNTED = BIT(15),		/* is a mountpoint */
+	DCACHE_NEED_AUTOMOUNT = BIT(16),	/* handle automount on this dir */
+	DCACHE_MANAGE_TRANSIT = BIT(17),	/* manage transit from this dirent */
+	DCACHE_LRU_LIST = BIT(18),
+	DCACHE_ENTRY_TYPE = (7 << 19),		/* bits 19..21 are for storing type: */
+	DCACHE_MISS_TYPE = (0 << 19),		/* Negative dentry */
+	DCACHE_WHITEOUT_TYPE = (1 << 19),	/* Whiteout dentry (stop pathwalk) */
+	DCACHE_DIRECTORY_TYPE = (2 << 19),	/* Normal directory */
+	DCACHE_AUTODIR_TYPE = (3 << 19),	/* Lookupless directory (presumed automount) */
+	DCACHE_REGULAR_TYPE = (4 << 19),	/* Regular file type */
+	DCACHE_SPECIAL_TYPE = (5 << 19),	/* Other file type */
+	DCACHE_SYMLINK_TYPE = (6 << 19),	/* Symlink */
+	DCACHE_NOKEY_NAME = BIT(22),		/* Encrypted name encoded without key */
+	DCACHE_OP_REAL = BIT(23),
+	DCACHE_PAR_LOOKUP = BIT(24),		/* being looked up (with parent locked shared) */
+	DCACHE_DENTRY_CURSOR = BIT(25),
+	DCACHE_NORCU = BIT(26),			/* No RCU delay for freeing */
+};
 
-#define	DCACHE_DISCONNECTED		BIT(5)
-     /* This dentry is possibly not currently connected to the dcache tree, in
-      * which case its parent will either be itself, or will have this flag as
-      * well.  nfsd will not use a dentry with this bit set, but will first
-      * endeavour to clear the bit either by discovering that it is connected,
-      * or by performing lookup operations.   Any filesystem which supports
-      * nfsd_operations MUST have a lookup function which, if it finds a
-      * directory inode with a DCACHE_DISCONNECTED dentry, will d_move that
-      * dentry into place and return that dentry rather than the passed one,
-      * typically using d_splice_alias. */
-
-#define DCACHE_REFERENCED		BIT(6) /* Recently used, don't discard. */
-
-#define DCACHE_DONTCACHE		BIT(7) /* Purge from memory on final dput() */
-
-#define DCACHE_CANT_MOUNT		BIT(8)
-#define DCACHE_GENOCIDE			BIT(9)
-#define DCACHE_SHRINK_LIST		BIT(10)
-
-#define DCACHE_OP_WEAK_REVALIDATE	BIT(11)
-
-#define DCACHE_NFSFS_RENAMED		BIT(12)
-     /* this dentry has been "silly renamed" and has to be deleted on the last
-      * dput() */
-#define DCACHE_FSNOTIFY_PARENT_WATCHED	BIT(13)
-     /* Parent inode is watched by some fsnotify listener */
-
-#define DCACHE_DENTRY_KILLED		BIT(14)
-
-#define DCACHE_MOUNTED			BIT(15) /* is a mountpoint */
-#define DCACHE_NEED_AUTOMOUNT		BIT(16) /* handle automount on this dir */
-#define DCACHE_MANAGE_TRANSIT		BIT(17) /* manage transit from this dirent */
 #define DCACHE_MANAGED_DENTRY \
 	(DCACHE_MOUNTED|DCACHE_NEED_AUTOMOUNT|DCACHE_MANAGE_TRANSIT)
 
-#define DCACHE_LRU_LIST			BIT(18)
-
-#define DCACHE_ENTRY_TYPE		(7 << 19) /* bits 19..21 are for storing type: */
-#define DCACHE_MISS_TYPE		(0 << 19) /* Negative dentry */
-#define DCACHE_WHITEOUT_TYPE		(1 << 19) /* Whiteout dentry (stop pathwalk) */
-#define DCACHE_DIRECTORY_TYPE		(2 << 19) /* Normal directory */
-#define DCACHE_AUTODIR_TYPE		(3 << 19) /* Lookupless directory (presumed automount) */
-#define DCACHE_REGULAR_TYPE		(4 << 19) /* Regular file type */
-#define DCACHE_SPECIAL_TYPE		(5 << 19) /* Other file type */
-#define DCACHE_SYMLINK_TYPE		(6 << 19) /* Symlink */
-
-#define DCACHE_NOKEY_NAME		BIT(22) /* Encrypted name encoded without key */
-#define DCACHE_OP_REAL			BIT(23)
-
-#define DCACHE_PAR_LOOKUP		BIT(24) /* being looked up (with parent locked shared) */
-#define DCACHE_DENTRY_CURSOR		BIT(25)
-#define DCACHE_NORCU			BIT(26) /* No RCU delay for freeing */
-
 extern seqlock_t rename_lock;
 
 /*
-- 
2.49.0


