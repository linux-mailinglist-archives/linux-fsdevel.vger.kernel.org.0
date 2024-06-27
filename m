Return-Path: <linux-fsdevel+bounces-22578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EFB919C93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 03:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B741F23745
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 01:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCFA1A29A;
	Thu, 27 Jun 2024 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwls8z49"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C058A17984;
	Thu, 27 Jun 2024 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450038; cv=none; b=YA1uD6iRmovsiWirvhBi3iW0qd9NozbHVTTZ89dnERvM68OG4iMvMjbT9Zz8O+6zx/9eOHzu3lg0bnplYZyLjzFxupHewfr17u03JHIWsdthhy35+Bpu/fWRMuuhXs9q7zurBF9QBQ6hpFWBzQ9QaFLQHii0m+ZZZ/pvxumhY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450038; c=relaxed/simple;
	bh=nUcEwSwalHgLZDUtP3erKKCOQirbIJlYfFYWIa0nODA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mx2Jj19rw9NuGBM1Oy7dY76IZjA9gWjv2j3bgnx920GzQhGO3mlO9rDo9X462qxpiUAEIl3UZu1IFREZS7byIUggnQ/YL78L2l5tIXuqajrGuy0OwVVOcbvh0ZOF7l4ZsWil4zoU7xnN8quSIyiz6JSLquZrrupOqFzLzbgYJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwls8z49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D1CC116B1;
	Thu, 27 Jun 2024 01:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719450038;
	bh=nUcEwSwalHgLZDUtP3erKKCOQirbIJlYfFYWIa0nODA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gwls8z49Bh6Z5E9hFJjXsBHm9SIs3cp2ZvAOef69OmFSUYxfKHGAVuX7LlJovim/5
	 SOafG37Usb6GgKtzkT0nz61+eEqb8xuu4hcpr7Hp8uXmTD9dHHTJYoJky7EOIrUzKS
	 xPXP68NHYs6kL5d2drislL3eImS37sOgVS5w8cIee2N1ffPopUER5AIJKrYBI9CUTa
	 H/cCqB0eyQLUc4dFwsYoUV9Tu5W9/EX4j4y82h1eqmSF3IEsqTMRSRDxFEa8dZBvhF
	 Bvu5d61LKLUifHm4lGDnvgWLQDNH+VloCxi+AOd2FGnxxOkPj4PKblhSCxJVwkWDiK
	 Bezx1LULDHrag==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 26 Jun 2024 21:00:22 -0400
Subject: [PATCH 02/10] fs: uninline inode_get_ctime and
 inode_set_ctime_to_ts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-mgtime-v1-2-a189352d0f8f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=nUcEwSwalHgLZDUtP3erKKCOQirbIJlYfFYWIa0nODA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmfLmu8R1wuP4JGpygk6wU7fHbGTPeS3QYH6KLh
 UBB5zc49iOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZny5rgAKCRAADmhBGVaC
 FabcD/4mM1N+8adbvf5i1jdMSPTFwAr4F+w2yWSohHk9014i/dOuMmEmBpgENJ9AtMK5P2y/bv+
 P4MY+eEzXnZ05buHgOs0fdObTEpWuMllwhp2KLU68Z2WG+m11BNai7RUYL0EBU31kOwlFLhRVbq
 ZTMo+6ORcgl4cWZXadf1Tn01l3772cp/xMeDoyS7kDe3MjgcYqxBwzIiLLAXLiBuqbpAXS5rrnP
 QEn6NCAGzt+LK1V+YTfi1YVsfMyHmROqpLaQ1XzN7SwmwPErX+ZAy/Cc5aImHBmQcaaTE9hq4Bm
 s6Tc+KRNHo9U75RN/LaCGPOfbOchz4QB78rXLAOEGt2GHWzBb2Djp3g81jLUpVNRajBNPmlVUdw
 +HqFECfXB6Mo3uUmG8pJo6++cuB9YZaGG+XVolyOHgH8THScVWV8qKc3XWA5Gph32Xgp34I0g+v
 rUqtcNJdxkVIThR5M0aJP7NBzNupu/cXUq4GzXMB465v30QcD9xvBcknMCWM18UgfD2x33oRuHV
 SNxQLu6ZlxnzkGbki8odyQYjD/cDeYIwq2kiQNrxlG+y5m7q1ypr6sfh41VWgY9xHiHNSCZOoPr
 ZNw8ruynyO9s8OBJfE2sgYZvJw7bRXa69ctiGQGq0u0sbxgokuiDD/3m1oody4GB9YB7nDqAI0u
 W20ZxJx5YHBWvEg==
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
index 5139dec085f2..4b10db12725d 100644
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


