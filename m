Return-Path: <linux-fsdevel+bounces-20180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BE18CF433
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 14:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9CE1F217E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 12:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6026EDDDC;
	Sun, 26 May 2024 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVfmAuCT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF356C2D6;
	Sun, 26 May 2024 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716726023; cv=none; b=h9iJ+r00cUOrrB0T5/yJWDd1PYYjF0n0l7zj6qy5PjNKbailO3wScb18TP9o3R+JDBT95nnKaLUx3HN0bDeNILM8lKbwdCmXGciswC6PC9mgNU8wr2qo31QSnw6hrWFwrPAPPSxxoOWvTFpYJtJLhzDbaZUwohlzu0UxHV3wRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716726023; c=relaxed/simple;
	bh=vaox6C/5vKHxXFGk4CEyr/LzDKIY/J0CIiuiJyykHek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IZtGDx6T/vvJolazyCisJnJkINiPcFcv9YaSubjl8jU6KIZhZVWu7XLAPT9A8XxC2vY8OtUEoeLZ/zv6xhRNq2LjkvwR073qLqkrQa1iUyqyIi8QZ+uIfnyrNbL8HcBC+1mj7CDVgsWY0wF+jS0QtBJSzjuqSuaGgsnOQYeuneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVfmAuCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFF2C2BD10;
	Sun, 26 May 2024 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716726023;
	bh=vaox6C/5vKHxXFGk4CEyr/LzDKIY/J0CIiuiJyykHek=;
	h=From:Date:Subject:To:Cc:From;
	b=GVfmAuCTDm2k7wjoJMrE/Y5Jx3RFofSI/A+9FRFhlJFDYROLSINICrlsTJ/rMvE+2
	 lvPQXx7zZCVnPBdPZDcXEZPPGCrp9L6OzLNI5R1M2ScsUHYtd/4PMc1C9snikOf8Jp
	 6/cxSJ2gj42idZlhbPDuF/w+LkhNkpp4ScGsACqtgEdROOT10FDv6OystyBirh2kPM
	 CN6bCdTgU1cuUMSg2zJjHX23hNFRC9pgSprAVNNy/6KwpzFk8Z2XmRu51NH4RJQOYd
	 4JxK7muJMc5tiuqu0Q78IAVCm5gf6jwMJw9Er5kj2OApfIJo8sZnQtUkJGgtVPGmDd
	 ansdfY1fT1AeA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sun, 26 May 2024 08:20:16 -0400
Subject: [PATCH RFC] fs: turn inode->i_ctime into a ktime_t
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240526-ctime-ktime-v1-1-016ca6c1e19a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAP8oU2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyMz3eSSzNxU3WwwmWJiaGqUkmphaGhqrATUUVCUmpZZATYtWinIzVk
 ptrYWADLB4TZiAAAA
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3692; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vaox6C/5vKHxXFGk4CEyr/LzDKIY/J0CIiuiJyykHek=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmUykFGfWXjogqlx0kTGbCIxPDMLJ/+LnSVWox/
 /9P0qRBgruJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZlMpBQAKCRAADmhBGVaC
 FZg/D/9Ouih6Qb8A825LnXh8eyDl7mGgk/t1bSuTnuW7mlJ52hqLVDyFfOS6PsxuBsj/4qJUsmT
 I15VLG2/i0mfOLWEQfxyPScT9L8HKuVHbd0iZsqV2SLboBjuDvc7kTHYv9IIChhRW0YZMrIPRLN
 6g5wXq58I+SHciw5eo/hAmGlNwL787u8dQTVQg+vhsP0M25+4vt40NwptD/cLbMBlbFoUsg8Xpx
 exSNPoFU46sE1draokpTL7nlujNc9O/Gi75s+k34U7v03SVSJekzPMsLXIikF424FnBuoCRwc/I
 y7KF8kjMWSqhUoL8y5lD4XU84iYhNiT2PzKXsgWRmYQQcS95Z+iA69S2E1nycoYGqZK3b3A2mbp
 hXs9qGgz671EGpDkfTtr26ZBgN90QWjkwMfxqmcFtDSSQClwwjX3QNbrQ2goPYGREmk52S05eVL
 j4KGiF2SSFEMuiROqgphZG/9YnPlr0sxtwMVxM8tf+Ns2hlu3Lo1uwXaoA2BF/7q1+XQjO9qcJU
 WV2tqBDtHfZ/v1v/DF65sVQubkRnRx7WXMISBtUiLNH8us0LNXf8OKOdMslAuEWagYJuvLxAqbh
 gOx9x96EoVQXd3XAx1H5haoYKGzBMOJCagjWjAKrbnwUgqkAU8oeqOZgzyb6IdP8uEQV8+SpmW5
 oqxkcvGLCLcPasw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The ctime is not settable to arbitrary values. It always comes from the
system clock, so we'll never stamp an inode with a value that can't be
represented there. If we disregard people setting their system clock
past the year 2262, there is no reason we can't replace the ctime fields
with a ktime_t.

Switch the __i_ctime fields to a single ktime_t. Move the i_generation
down above i_fsnotify_mask and then move the i_version into the
resulting 8 byte hole. This shrinks struct inode by 8 bytes total, and
should improve the cache footprint as the i_version and __i_ctime are
usually updated together.

The one downside I can see to switching to a ktime_t is that if someone
has a filesystem with files on it that has ctimes outside the ktime_t
range (before ~1678 AD or after ~2262 AD), we won't be able to display
them properly in stat() without some special treatment. I'm operating
under the assumption that this is not a practical problem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I've been looking at this as part of trying to resurrect the multigrain
timestamp work, as Linus mentioned it in passing in an earlier
discussion, but then Willy threw down the gauntlet.

Thoughts?
---
 include/linux/fs.h | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 639885621608..6b9ed7dff6d5 100644
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
 

---
base-commit: a6f48ee9b741a6da6a939aa5c58d879327f452e1
change-id: 20240526-ctime-ktime-d4152de81153

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


