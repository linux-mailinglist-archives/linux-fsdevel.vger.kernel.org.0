Return-Path: <linux-fsdevel+bounces-24902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B32D946553
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 23:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD17F1C20F18
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 21:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DAD13B580;
	Fri,  2 Aug 2024 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRTXQoxO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084513DDBA;
	Fri,  2 Aug 2024 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635126; cv=none; b=EYm6y+uPUw9flxW+BgWvqnEI/uHTgjQPxCg6YGpyYLAfdQfIalrZqRR0lE2Lr1gi7FP+Xcy1AvUyC6fI5+L6sSCFmjOrQdSL7M3SGuoBXGYjUpiAVMWmDKvFReQG4FJQ2AB+i2m7ZJHLpLUBE+orh+q4OhU6mFLjSlo7in8l6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635126; c=relaxed/simple;
	bh=PJfFAxXqJiTj0TbDik95zZrZzvqxpfVymiA5KUdqD9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F/ltFYp63MD6XeBEetnqxOHUQg42GAFIiOsnp9ZgWrq4X12oYPnQVgb60PnbwrbIJskRuNP5nr+oKtxcj8vf5Ye7bt04UNDMJZolho2bDYFDGSsnXf0ozr6Hs/g0pTJoQJ641UE1xteI61lE/nXPYPuFRsI51hioeAYsKjegum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRTXQoxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC7BC4AF0E;
	Fri,  2 Aug 2024 21:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635126;
	bh=PJfFAxXqJiTj0TbDik95zZrZzvqxpfVymiA5KUdqD9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sRTXQoxONJKIeoMzcg4mrdp4XI3nnn8g0rhCYCtoRHZ4UEGxa6egJi2FJXgu40JV4
	 IH0XV744hqZMMzcU9mpB5Y5ixgDEmFjzfK6oH3uuFo57TSfeSph/qwgq7MI6cwdwAb
	 v6fLA5Tr4O+dUKCr6sRDhoWJmr2gZwttTbq+fJQ+e2+eU7NPB542jkI/04pHfaa8YD
	 qzESgVne/bpKlc9Y31cpYFiFffI0VXoW4Rylinm5CMxGq1MAT91KE80gU98thc8lvH
	 JlfVjKeQGAfn/E6/3XswlO3qE0DLTVBc3YSYVP3g3qoe+gCEYl55nWl5astdHXvB+l
	 sLffw3cyD03jA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 02 Aug 2024 17:45:05 -0400
Subject: [PATCH RFC 4/4] fs: try an opportunistic lookup for O_CREAT opens
 too
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-openfast-v1-4-a1cff2a33063@kernel.org>
References: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
In-Reply-To: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3154; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=PJfFAxXqJiTj0TbDik95zZrZzvqxpfVymiA5KUdqD9k=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmrVNxIhP58dOD7Dtw1/dwb2bJod6sjqh8QafBf
 Ub1KN2jttiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZq1TcQAKCRAADmhBGVaC
 Ff0GEADCM2i95QIKMKfiz52kq9KA+6Y1cXwUto+w0I0y61CVEU5ePeyp26LeoPF3AEpTQS6O4si
 7CrKtcUtW2TnqJkFV+CYfRni0c3QbXGFD6pEuuRPU4SiI6UG+drdR5MQDIQPqFTJIKXf1LsQuwu
 nTD+0PoCLxhEBnmhIALGLDeKhYD8H+Xrz4JS177y+bznWVYAb9pM+vVLwdka8ZsSvDrc5b4Kxdo
 Ia1+T13J2Ke1waVDKPwcfGjMXuIG4hLP9c77w/Q2Ytugr10/iJ8lMMQ6LpRY+31LQ9SKDXB23Nj
 B1nnK5Au6vshRZ9dNXaxT76hLBp1KUSn/AcohwvvTYxBu0dcRsJq6vPHt1bULClBKN59OiKln7X
 kGONNDTEHJr8ez7q9AYd+ITeXqRGZCHYpJGyr41wWaGMKYNCHI2C/JpYZPe8gwfHJ4jjsQhOzIg
 IDviVG1FjmUk+hKyeaFS4cLva+eGnj9Y1ZbNIDF5tfgCIxKP7BfgRi8AYXh7ENKZEVdtCFbL+TG
 DAKq4nITf0m7zLEz08CbhreqrWhVv1N/M6DjaQ1Ru7PQ9H3cxa9XEce34fAXv5C9Zef3ZZi5vsB
 rohrmXcO8j/uXyMn8oAhgfuNrGAsdgM2hjwe/t8ZiSxq4K7wHKQ4bH8t7EikUcdCB6HgwH9t42s
 dg1EkfGm8fYYhbQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Today, when opening a file we'll typically do a fast lookup, but if
O_CREAT is set, the kernel always takes the exclusive inode lock. I'm
sure this was done with the expectation that O_CREAT being set means
that we expect to do the create, but that's often not the case. Many
programs set O_CREAT even in scenarios where the file already exists.

This patch rearranges the pathwalk-for-open code to also attempt a
fast_lookup in the O_CREAT case.  Have the code always do a fast_lookup
(unless O_EXCL is set), and return that without taking the inode_lock
when a positive dentry is found in the O_CREAT codepath.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index b9bdb8e6214a..1793ed090314 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3538,7 +3538,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
 	bool got_write = false;
-	struct dentry *dentry;
+	struct dentry *dentry = NULL;
 	const char *res;
 
 	nd->flags |= op->intent;
@@ -3549,28 +3549,57 @@ static const char *open_last_lookups(struct nameidata *nd,
 		return handle_dots(nd, nd->last_type);
 	}
 
-	if (!(open_flag & O_CREAT)) {
-		if (nd->last.name[nd->last.len])
+	/*
+	 * We _can_ be in RCU mode here. For everything but O_EXCL case, do a
+	 * fast lookup for the dentry first. For O_CREAT case, we are only
+	 * interested in positive dentries. If nothing suitable is found,
+	 * fall back to locked codepath.
+	 */
+	if ((open_flag & (O_CREAT | O_EXCL)) != (O_CREAT | O_EXCL)) {
+		/* Trailing slashes? */
+		if (unlikely(nd->last.name[nd->last.len]))
 			nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
-		/* we _can_ be in RCU mode here */
+
 		dentry = lookup_fast(nd);
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
+	}
+
+	if (!(open_flag & O_CREAT)) {
 		if (likely(dentry))
 			goto finish_lookup;
 
 		if (WARN_ON_ONCE(nd->flags & LOOKUP_RCU))
 			return ERR_PTR(-ECHILD);
 	} else {
-		/* create side of things */
+		/* If negative dentry was found earlier,
+		 * discard it as we'll need to use the slow path anyway.
+		 */
 		if (nd->flags & LOOKUP_RCU) {
-			if (!try_to_unlazy(nd))
+			bool unlazied;
+
+			/* discard negative dentry if one was found */
+			if (dentry && !dentry->d_inode)
+				dentry = NULL;
+
+			unlazied = dentry ? try_to_unlazy_next(nd, dentry) :
+					    try_to_unlazy(nd);
+			if (!unlazied)
 				return ERR_PTR(-ECHILD);
+		} else if (dentry && !dentry->d_inode) {
+			/* discard negative dentry if one was found */
+			dput(dentry);
+			dentry = NULL;
 		}
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
+
 		/* trailing slashes? */
-		if (unlikely(nd->last.name[nd->last.len]))
+		if (unlikely(nd->last.name[nd->last.len])) {
+			dput(dentry);
 			return ERR_PTR(-EISDIR);
+		}
+		if (dentry)
+			goto finish_lookup;
 	}
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {

-- 
2.45.2


