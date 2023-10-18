Return-Path: <linux-fsdevel+bounces-680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1347A7CE4D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D54B212F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7813FB3A;
	Wed, 18 Oct 2023 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHqr3PeT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76C93FB2F
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 17:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0865C433CD;
	Wed, 18 Oct 2023 17:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697650894;
	bh=jWmZ1Ravl5cu/wOo4Bog6k1d+CwyPST2G6rAUV4ZYAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vHqr3PeTFpDRNPF3idVxxCdnb1iVi0NE8DkKoUZrVcZEfyflEgmWCoz3c30QBIYgV
	 QHUjC6yzrdbgCryMrV/z8AraieOhCmp5ydSy1Jlqy/frfz3I7YSKlgI5kDCw9W9L0G
	 6wdcPzpynxo6jrP6c7EPrU4xUvOBBF8acqKT80+bwKIiWoG+0FKGZn2rspmzYEp5Uw
	 yczqNkmwK3PiefZQP5RsLlEHZJRaSQCGu1OYDHgU58+Yl+kixzJq6GJmgUYJk5WB9q
	 jGypQFbK++CbII2WD5VXoDWHRSnbQ9wKs9T6uoUfg0c1QygVUa4DSDyJFGF5QUtR0X
	 akQ1ufOzxnSZQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Oct 2023 13:41:08 -0400
Subject: [PATCH RFC 1/9] fs: switch timespec64 fields in inode to discrete
 integers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-mgtime-v1-1-4a7a97b1f482@kernel.org>
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
In-Reply-To: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, 
 David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4674; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jWmZ1Ravl5cu/wOo4Bog6k1d+CwyPST2G6rAUV4ZYAc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlMBjIMZMk9hA0a0rbXtgzOBS8+JUCWebR2P/8J
 wgnb+onjoOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZTAYyAAKCRAADmhBGVaC
 FRN4D/4hg/46V/lM9F5UuttDEfFBixG4KR0EymQEurGFApb4lySZ+KxbxVkqAm7IyL+FGAaylWc
 HWdk3vSQOpB0wg/2wS4ymKQcXH85SVmR/9XEb7cwkGmGji5l1IRuyksbprbUJUoYrd74o3VwZ2J
 FGfFODjJ1z2g8QOi+FPBhSrHSMPe6a+6t1RhTll6jSfUaLC5mT72UQKVTqezrCk3c7BrDg7wF8W
 P3sKppsD3IboBFnqLbTs+9FMukgmOdVC5ot278zCccIfSVSTWJov4PuYGZGg2sxnKJHL00sXNzC
 UpTPwBA06FEZnVVSubHR+v91WVQ9P8C7VgWnpAkNm0CuuoNGtBmtvA7dEM95ePdvysiYdTNgfbL
 lw9ll9YwoDxfKsgg8rC6dm6qHAEDZ4d2yBpi2ytPeV6cosMnf7ABN6v1L7saN4C9DAj43QdvZ0L
 NI9Sf0xSeBKtgKlsAkaKw1vFv9SxFWOvRLr06pyTa7aogQymJeKR714W1uy52Hb7lXCTSQGiDqt
 LBOBs244/a4JkQg0YfaivbgWS4haeHjH/Tc/YCT7wc6YGa+dUSQIviYyiczEXqT1Xvim3WEL+vK
 QXaNIVewLajwOQrViIMfh0wl3NievUibTIxrqaKsoZH9/zvSBivCwxyjO+SU5bOzzJvjm6OM1Zz
 MO1qldTLt22SnAw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This shaves 8 bytes off struct inode with a garden-variety Fedora
Kconfig, but it moves the i_lock into the previous cacheline, away from
the fields it protects. To remedy that, move the i_generation just after
the nanosecond fields, which moves the 4 byte hole down next to
i_fsnotify_mask.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/fs.h | 56 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index cc29518517f7..78786c1c32fd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -671,9 +671,13 @@ struct inode {
 	};
 	dev_t			i_rdev;
 	loff_t			i_size;
-	struct timespec64	__i_atime;
-	struct timespec64	__i_mtime;
-	struct timespec64	__i_ctime; /* use inode_*_ctime accessors! */
+	time64_t		i_atime_sec;
+	time64_t		i_mtime_sec;
+	time64_t		i_ctime_sec;
+	u32			i_atime_nsec;
+	u32			i_mtime_nsec;
+	u32			i_ctime_nsec;
+	u32			i_generation;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	unsigned short          i_bytes;
 	u8			i_blkbits;
@@ -730,10 +734,10 @@ struct inode {
 		unsigned		i_dir_seq;
 	};
 
-	__u32			i_generation;
 
 #ifdef CONFIG_FSNOTIFY
 	__u32			i_fsnotify_mask; /* all events this inode cares about */
+	/* 32bit hole reserved for expanding i_fsnotify_mask to 64bit */
 	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
 #endif
 
@@ -1513,23 +1517,27 @@ struct timespec64 inode_set_ctime_current(struct inode *inode);
 
 static inline time64_t inode_get_atime_sec(const struct inode *inode)
 {
-	return inode->__i_atime.tv_sec;
+	return inode->i_atime_sec;
 }
 
 static inline long inode_get_atime_nsec(const struct inode *inode)
 {
-	return inode->__i_atime.tv_nsec;
+	return inode->i_atime_nsec;
 }
 
 static inline struct timespec64 inode_get_atime(const struct inode *inode)
 {
-	return inode->__i_atime;
+	struct timespec64 ts = { .tv_sec  = inode_get_atime_sec(inode),
+				 .tv_nsec = inode_get_atime_nsec(inode) };
+
+	return ts;
 }
 
 static inline struct timespec64 inode_set_atime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->__i_atime = ts;
+	inode->i_atime_sec = ts.tv_sec;
+	inode->i_atime_nsec = ts.tv_nsec;
 	return ts;
 }
 
@@ -1538,28 +1546,32 @@ static inline struct timespec64 inode_set_atime(struct inode *inode,
 {
 	struct timespec64 ts = { .tv_sec  = sec,
 				 .tv_nsec = nsec };
+
 	return inode_set_atime_to_ts(inode, ts);
 }
 
 static inline time64_t inode_get_mtime_sec(const struct inode *inode)
 {
-	return inode->__i_mtime.tv_sec;
+	return inode->i_mtime_sec;
 }
 
 static inline long inode_get_mtime_nsec(const struct inode *inode)
 {
-	return inode->__i_mtime.tv_nsec;
+	return inode->i_mtime_nsec;
 }
 
 static inline struct timespec64 inode_get_mtime(const struct inode *inode)
 {
-	return inode->__i_mtime;
+	struct timespec64 ts = { .tv_sec  = inode_get_mtime_sec(inode),
+				 .tv_nsec = inode_get_mtime_nsec(inode) };
+	return ts;
 }
 
 static inline struct timespec64 inode_set_mtime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->__i_mtime = ts;
+	inode->i_mtime_sec = ts.tv_sec;
+	inode->i_mtime_nsec = ts.tv_nsec;
 	return ts;
 }
 
@@ -1573,34 +1585,30 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
 
 static inline time64_t inode_get_ctime_sec(const struct inode *inode)
 {
-	return inode->__i_ctime.tv_sec;
+	return inode->i_ctime_sec;
 }
 
 static inline long inode_get_ctime_nsec(const struct inode *inode)
 {
-	return inode->__i_ctime.tv_nsec;
+	return inode->i_ctime_nsec;
 }
 
 static inline struct timespec64 inode_get_ctime(const struct inode *inode)
 {
-	return inode->__i_ctime;
+	struct timespec64 ts = { .tv_sec  = inode_get_ctime_sec(inode),
+				 .tv_nsec = inode_get_ctime_nsec(inode) };
+
+	return ts;
 }
 
 static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->__i_ctime = ts;
+	inode->i_ctime_sec = ts.tv_sec;
+	inode->i_ctime_nsec = ts.tv_nsec;
 	return ts;
 }
 
-/**
- * inode_set_ctime - set the ctime in the inode
- * @inode: inode in which to set the ctime
- * @sec: tv_sec value to set
- * @nsec: tv_nsec value to set
- *
- * Set the ctime in @inode to { @sec, @nsec }
- */
 static inline struct timespec64 inode_set_ctime(struct inode *inode,
 						time64_t sec, long nsec)
 {

-- 
2.41.0


