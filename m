Return-Path: <linux-fsdevel+bounces-22856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4004A91DC7B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE01B1F21E3B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB5814B94B;
	Mon,  1 Jul 2024 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH62UWFL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F076A14A605;
	Mon,  1 Jul 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829631; cv=none; b=ot1PcnUQNRQF+ECUWYTgOPdd/hOREarXxdURjumiKZAcErfb0ZV2eAtp7DfVR4wAs5PRzxmZCC2DFDp5BSCtrPo15e/9K6KThacKl5IpprwdWfUqwT01czX0XQDTOQ1Dj5a8IaCFwg4C0xNLAtaD4u3X1IjvDnr4oLV/AtA0hT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829631; c=relaxed/simple;
	bh=ZBKByquYEdSc8HMPTmMqO17BDUigbAna6N8Jb8o7VIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rSydsjo5dTiERTbMQxVjfkUPBoJPkbEerrAx6lpS3qiiAxBVqVSNbf5MAMcIzxgQsdDvtqRt/mcyMUZnDxIQ93YllVTDEC0+3/9rcJSivMNQDpK/ZLD3wrP91hS7OXZj//LhWkaHUdBVfYOd8186Ptx0X0JRWj+Tk8/b9GXLLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH62UWFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61429C4AF0F;
	Mon,  1 Jul 2024 10:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829630;
	bh=ZBKByquYEdSc8HMPTmMqO17BDUigbAna6N8Jb8o7VIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fH62UWFLV1muAZCZ9Uqg8bup5NTWlC8DFd1KVhJmlGrmNURVzr8eb8sA0Ls90voPR
	 BbWcdY9SGonGUlyLLohh8+/QHnD9ygByoLBqltTBBsxFJG8QpTGWgi+DTFDv40qK2k
	 FoaAfg3P+swSTgSp56VoeYVv3XfaKaaOmfXxmuqvBBmKFtikx+s7Yd0In339RLRYtH
	 5DvYLSg6Z+QQFmoaTW5xjJjLvLIoqs0qwKH0u2qrUxflf/dYxqRXZjdcX5xrYSNoD1
	 6Bu6MS8IxZDMSEHAo90bvmQWpynDEH0t3qJ5M+xLfvP0rnFo0ZTsCBL4UM5tjESSK3
	 UbDe+sB/rUbqA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jul 2024 06:26:37 -0400
Subject: [PATCH v2 01/11] fs: turn inode ctime fields into a single ktime_t
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-mgtime-v2-1-19d412a940d9@kernel.org>
References: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
In-Reply-To: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3344; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZBKByquYEdSc8HMPTmMqO17BDUigbAna6N8Jb8o7VIE=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGaChHij2CN1I/zkl//fedCXp9VjMU5Dtw3Kbn8GML+q0mPsf
 4kCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJmgoR4AAoJEAAOaEEZVoIVvDQQAMSY
 w7rzKxq0PvZZk5HYZj1Fd+MbtYtz2FqcFHuKdCL1wNI9qSIh5roycQHJdjwhp7tcgrSW076CBD8
 tEJj4kkd46Nm7jKcMAy2Kv00LGcN29a5c5wnqj9AGRoTXpLf7C5tJBL31pKHj5ignjT4+59wlte
 o5ZuEo+Gm0ijd/j3es9lK7BIJMyMyFR3BDO5e7dg5rdhPOnt90Y8e9OjTkzc1rCeeVWeBCDDGcb
 8LX8+xKrMExJonsClph8lXkxT5LrzJLbSIouBeBicEkm/xh5sbO0sV7fRuNPFZYm7CUyqJNnDJA
 /Olm4VSauOArxzOmuk+e6jPxboFFxHB7AuIWY1i8KcowJ1FQ4sIsGaqrJOiLnDyhrSeDIJAtOHf
 j2vthNwFYecOlAWDma4SRUfGpzuwd9Bxb1VZzZWUeL1PqOU+FIA81Wm88el2cdOV8SN4aH6ZcQF
 E1KZJsOwuDXw/FSgbgFifdijqi3jpaEfiyTiUfOSV/lh4GIYFpHc+1eHkgPOxYO2ty/NxZh35Z6
 NJ/e1UPJRnNiFRMKHvPx16kwE4KAsvREDbAd3SRBhXkwBhw/aL1Sx7nYpQv9JENH+6dZeWBgTd9
 INL5kJ3hGTS8vYlHAU/WeNNJlO44ASLpvswExclby6lH+tUv/o82oJAcjjfCPr/Y7ri/o+HSzLL
 7WR8L
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The ctime is not settable to arbitrary values. It always comes from the
system clock, so we'll never stamp an inode with a value that can't be
represented there. If we disregard people setting their system clock
past the year 2262, there is no reason we can't replace the ctime fields
with a ktime_t.

Switch the ctime fields to a single ktime_t. Move the i_generation down
above i_fsnotify_mask and then move the i_version into the resulting 8
byte hole. This shrinks struct inode by 8 bytes total, and should
improve the cache footprint as the i_version and ctime are usually
updated together.

The one downside I can see to switching to a ktime_t is that if someone
has a filesystem with files on it that has ctimes outside the ktime_t
range (before ~1678 AD or after ~2262 AD), we won't be able to display
them properly in stat() without some special treatment in the
filesystem. The operating assumption here is that that is not a
practical problem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/fs.h | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2fa06a4d197a..7110d6dc9aab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -662,11 +662,10 @@ struct inode {
 	loff_t			i_size;
 	time64_t		i_atime_sec;
 	time64_t		i_mtime_sec;
-	time64_t		i_ctime_sec;
 	u32			i_atime_nsec;
 	u32			i_mtime_nsec;
-	u32			i_ctime_nsec;
-	u32			i_generation;
+	ktime_t			__i_ctime;
+	atomic64_t		i_version;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	unsigned short          i_bytes;
 	u8			i_blkbits;
@@ -701,7 +700,6 @@ struct inode {
 		struct hlist_head	i_dentry;
 		struct rcu_head		i_rcu;
 	};
-	atomic64_t		i_version;
 	atomic64_t		i_sequence; /* see futex */
 	atomic_t		i_count;
 	atomic_t		i_dio_count;
@@ -724,6 +722,8 @@ struct inode {
 	};
 
 
+	u32			i_generation;
+
 #ifdef CONFIG_FSNOTIFY
 	__u32			i_fsnotify_mask; /* all events this inode cares about */
 	/* 32-bit hole reserved for expanding i_fsnotify_mask */
@@ -1608,29 +1608,25 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
 	return inode_set_mtime_to_ts(inode, ts);
 }
 
-static inline time64_t inode_get_ctime_sec(const struct inode *inode)
+static inline struct timespec64 inode_get_ctime(const struct inode *inode)
 {
-	return inode->i_ctime_sec;
+	return ktime_to_timespec64(inode->__i_ctime);
 }
 
-static inline long inode_get_ctime_nsec(const struct inode *inode)
+static inline time64_t inode_get_ctime_sec(const struct inode *inode)
 {
-	return inode->i_ctime_nsec;
+	return inode_get_ctime(inode).tv_sec;
 }
 
-static inline struct timespec64 inode_get_ctime(const struct inode *inode)
+static inline long inode_get_ctime_nsec(const struct inode *inode)
 {
-	struct timespec64 ts = { .tv_sec  = inode_get_ctime_sec(inode),
-				 .tv_nsec = inode_get_ctime_nsec(inode) };
-
-	return ts;
+	return inode_get_ctime(inode).tv_nsec;
 }
 
 static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->i_ctime_sec = ts.tv_sec;
-	inode->i_ctime_nsec = ts.tv_nsec;
+	inode->__i_ctime = ktime_set(ts.tv_sec, ts.tv_nsec);
 	return ts;
 }
 

-- 
2.45.2


