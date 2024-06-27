Return-Path: <linux-fsdevel+bounces-22577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E527919C8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 03:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C3EB20E7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 01:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A591171C;
	Thu, 27 Jun 2024 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uu9bKpll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B49D299;
	Thu, 27 Jun 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450036; cv=none; b=cDGFIRmO1YJI3WNXQkOLh8znnfBy7EodGlv3mOADFVAa+SegsuNy4lquDEoiUJRhSnytehWhSIDUzxF5t8NP3ai+ZxivE19tc6T45249PA2Aycy1ykWmCt08VuaTTuzf4Y1pF9Y5sCbCOzo1QKhKg0UcF6onkxDJeznaX35OLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450036; c=relaxed/simple;
	bh=G1sIrGm75KvOwnRqj2Qr6NVY9492uXV9G5iKNcaenQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nV7R7hJPUS+4x3MoLMfa5fEyEpL58GO+/fVPs7Ihk6MkYJ4wrEvq4UW8UZ4MOfXVIkHesVnDr+xd71hUsn8MDxpCCTheo8E5LkP7kyZgTEtbv7+K0XpBIHuDzFteoh/PyB/kRMcM7QvLLkaec9eA+TzremttYWeJkU5cE8v38no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uu9bKpll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE4CC4AF07;
	Thu, 27 Jun 2024 01:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719450036;
	bh=G1sIrGm75KvOwnRqj2Qr6NVY9492uXV9G5iKNcaenQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uu9bKpllUfrdSsygooj3Il3q8igpsvcmeAJH22XWhg0c7R4ESyKAy6ypVts8fty9Q
	 A4rOJR86fnWgQq6PivWKbjaJlnw70+VkTI7DxzP60N2Qrir9Ic2bnuGZY/Mn3Kmx5Y
	 5O2ksEpKXnGnV02Ipp03xM+6wdkL/rOB0LvOe1tMB76udcWzWHkFgREjMAvwSO8liD
	 62ifGHWLFKbFpThGH6t5XGg0SqzlkqAPGYdd97REc6rKf9Shq9XTLEajv6JPfzo53X
	 Uxs4hQ1uF5VqaGNENGK+CE6KwJhtX1VVXAPDIijDBZZ6duDZxgFvzxWTznJk0QMxVs
	 KZor/o/3gWLEQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 26 Jun 2024 21:00:21 -0400
Subject: [PATCH 01/10] fs: turn inode ctime fields into a single ktime_t
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-mgtime-v1-1-a189352d0f8f@kernel.org>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
In-Reply-To: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
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
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3344; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=G1sIrGm75KvOwnRqj2Qr6NVY9492uXV9G5iKNcaenQ4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmfLmuOgyuFN9FzwPSoACp7/4FgL4U5ewrxzQPi
 h6LGQNjmoCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZny5rgAKCRAADmhBGVaC
 FX5ZEACvzw0eK1vFpOnF4nZM3s2zL0NqyeFfw2IuIbYubO0XzKfU/GlcdGAVZD1/oDZDN9X2Ntx
 tkSoujXFDXsMigQyoXVvDfxIpYSjogrB25YHg+5iMFM+/GLPQhReln8cY/xzbjx01IVuO0RXKE4
 QCqFhVlV/I1AzaZ+xC2NOv8CXa/Gf1nSyV1llrK8t0wQT048zrREZqwJy2evRRRJ3ecwRRPh4cl
 IEJsjenGZNFF5pqNreGFh5eywBPrseN4m29EXntKoztrVnT8HM9FGHWXYI90hiugYxhtyUMLBl9
 k7VrSVP5poWdnKgzfthiYN1qmCk4JMEVj0HsIcRPmQi+9kO9CtqDiWvTjKnLsTrNgCcvxWA7s3J
 fvxvlclGfrgwuT45eja71AqaiM3GYchiM0VjQebvZ8xZXFmqYsti088EqvJ+wjJH9xJgv9zRC66
 G9eLzUdSnUckzPOx0BwcdvqOXD8/Dj2hrMXaC/2odyLZwF8XteERYsiPxnY88U2mWd5XGSXAouK
 D7d0B/OWH5OAovkc6IwLogJExZW8lY8ce4ubLrVbK8TVE5J1NsCvk2Jtj1jsTPlg/8qmVIWjqTz
 hfSDMcxZZ7/Njq2slc2PrWO+jzycNYolqZgeqH2NlccufsMKSRU4NLkED1LWFh8ynH9T1lR1mMw
 YmEPaOvwMbs8P+g==
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
index 5ff362277834..5139dec085f2 100644
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


