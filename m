Return-Path: <linux-fsdevel+bounces-22857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A355B91DC81
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55D41C20316
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AF414F9DA;
	Mon,  1 Jul 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLs4U1yk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14E14E2C1;
	Mon,  1 Jul 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829633; cv=none; b=hIACWm6q+lGGsuaAVPwmslP+ihRPp8FTLOSznPXfEHxCFz2A83RC+cV7ilfNRi3lilIu7Y/Bxq8+WMuhxtS28nsg+ox0MSevK+keH28mn6R9vvo+5r58NY2GDxmhbf8KV8ru2HDpO/ttYn1HyIWL+ZwDdGG/SPhumupU6StcSqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829633; c=relaxed/simple;
	bh=+Ll5hg7fP/HJuANKEHFNQPWIdpLiw73n3t3+REkgl74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Os1rmJ28bnt1t6bFtgpEoNBIyIYGWgMnP7ygx6HwytIbC30lncmBiCeAssHv3Fjs9MsnMYnFVCzsAayZU7pGfpNVt26XgizjMjFW/qtMdvmEH+Or8/m6cXnOkGMhCLoOIfL2waf97bgZKmYaSH8bpLpGcKpG575CHhPExwxsagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLs4U1yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD53C4AF0D;
	Mon,  1 Jul 2024 10:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829632;
	bh=+Ll5hg7fP/HJuANKEHFNQPWIdpLiw73n3t3+REkgl74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YLs4U1yk31/nkByopNeyavqaYbshC2B3idXBrhXHXRo2CcqTf76gc7chybjngqegu
	 4i8ky0uvI81yiLqr3gc1M2z69PEWNKsksBPjh4PM1UpwzLF15an2pnmGEuGQpvVzpM
	 kNtJxzZW27XgO31tmYxQb+sOB8Q/MVNfNcAhRRjFIDF4PGhPTjkeXTRO/h5YyjyFBZ
	 dpaEMVm8YEW1LEFMvaC3h5qSOFDM3Mq/oiRMq60sfJDzXQks7WTbpzUFXvuk0+40F1
	 HP/zsQmVq2PxVJP4pG6RP+3c9ireNOi2t0mSMPi85aMTTXdnal2UTVLJbETSHU4bOp
	 laaBRljmQ3/NA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jul 2024 06:26:38 -0400
Subject: [PATCH v2 02/11] fs: uninline inode_get_ctime and
 inode_set_ctime_to_ts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-mgtime-v2-2-19d412a940d9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=+Ll5hg7fP/HJuANKEHFNQPWIdpLiw73n3t3+REkgl74=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmgoR4Q8RRSxWkQGur2eUnM/gRhrlIRHemdFcK6
 Pl9reaXAbSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZoKEeAAKCRAADmhBGVaC
 Fb2HEACJ1w7tWJnhLJJHKtIkdTLk/MbD2FV/05Q8JpoUDULrSi2uxwNwsZyUcSTvWlJ7jcH5Th0
 dJM6XvoRTYVsd5gyGTJJgTNwCu6GiSbenps/IatnCVH+aGz5ziOxYS4WIYicKw04VP0cxp4oJ34
 pdnfOxTgVlSGiSIdeqy1n4Rjbtz3fRosxKP9Et4XlbzVbyRkbUbwjKYuMLcRESjAh507dfENdAi
 B4fHUsSmf1Sl2IiPZ+kDr/15LDbCqG+nhjQC6ksB+WyYiZE/0VfYXCuJcHJFT9loALbpGS2avhN
 9SKYEAF1LMptopK1PAC/qTr9R9sFAmqF6S+s0HHVcI/RNmOLgr664ZHAdGCgxDjZ1kp1VKN27QQ
 esvHwRRCQaU2cHSGpdg02ajzEQWmtiC3bP4P9XCJJFmsM/pfLRMbQ9WscHTWUUVVThq/56/Lply
 5PnVt9ZZbqq1r9kvwbUii4CBn/Z84D/5nYHYWS+i66DNp6/hIm2kCPBJaN8VrVeY6Wodv5JzIt/
 KPHC/Lyntosv80bsit416E/riPN6u79SOs4HshmdZbJeW/PLyRasc2YRZehXMqh9ufqdsvUhMs0
 Nfc40554ynAy/xY9i1/lZ0v8xjyAgjRsRBl0hxBSKaLqinyOHIsaUoLuwewvhg08NAXaQIGKwuO
 YG+8TUTESXdJNZA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Move both functions to fs/inode.c as they have grown a little large for
inlining.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c         | 25 +++++++++++++++++++++++++
 include/linux/fs.h | 13 ++-----------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index e0815acc5abb..7b0a73ed499d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2501,6 +2501,31 @@ struct timespec64 current_time(struct inode *inode)
 }
 EXPORT_SYMBOL(current_time);
 
+/**
+ * inode_get_ctime - fetch the current ctime from the inode
+ * @inode: inode from which to fetch ctime
+ *
+ * Grab the current ctime tv_nsec field from the inode, mask off the
+ * I_CTIME_QUERIED flag and return it. This is mostly intended for use by
+ * internal consumers of the ctime that aren't concerned with ensuring a
+ * fine-grained update on the next change (e.g. when preparing to store
+ * the value in the backing store for later retrieval).
+ */
+struct timespec64 inode_get_ctime(const struct inode *inode)
+{
+	ktime_t ctime = inode->__i_ctime;
+
+	return ktime_to_timespec64(ctime);
+}
+EXPORT_SYMBOL(inode_get_ctime);
+
+struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
+{
+	inode->__i_ctime = ktime_set(ts.tv_sec, ts.tv_nsec);
+	return ts;
+}
+EXPORT_SYMBOL(inode_set_ctime_to_ts);
+
 /**
  * inode_set_ctime_current - set the ctime to current_time
  * @inode: inode
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7110d6dc9aab..8e271c9e4a00 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1608,10 +1608,8 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
 	return inode_set_mtime_to_ts(inode, ts);
 }
 
-static inline struct timespec64 inode_get_ctime(const struct inode *inode)
-{
-	return ktime_to_timespec64(inode->__i_ctime);
-}
+struct timespec64 inode_get_ctime(const struct inode *inode);
+struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts);
 
 static inline time64_t inode_get_ctime_sec(const struct inode *inode)
 {
@@ -1623,13 +1621,6 @@ static inline long inode_get_ctime_nsec(const struct inode *inode)
 	return inode_get_ctime(inode).tv_nsec;
 }
 
-static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
-						      struct timespec64 ts)
-{
-	inode->__i_ctime = ktime_set(ts.tv_sec, ts.tv_nsec);
-	return ts;
-}
-
 /**
  * inode_set_ctime - set the ctime in the inode
  * @inode: inode in which to set the ctime

-- 
2.45.2


