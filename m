Return-Path: <linux-fsdevel+bounces-71736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A61CCFC25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44A9A30E1FAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C952233A71D;
	Fri, 19 Dec 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuFj0mDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C2033769C;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146572; cv=none; b=OcuzwIbbtf8wXzEdZf+ZVG4gD21GJZQnhDxGwVc8aTiGxRmLrMOaCcbi673J8BVXnCzJdGRvvCk3xhGTiPopPiQ3T3KFlK9hY8taT6w07F+saDjQ72xIzxi/c0ORD/p02iKINIyYA9pTX005+ERcPhu5VCKFcuKUYa0cV/lwUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146572; c=relaxed/simple;
	bh=mGQWDqMqaGA6etpjh9YzRfJnnV2yEZ4c6MZcDZp1c5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DN8LSCnf8NfB2PwlD2njjUxjiIg8sbATnqF62Il8rKftpDfEaqx/JM+FPtsJOBlwSWuoU7/y0uI53+AhWvvIWMGdnpRqqjBhrKhRGJ3ppJOltavGc51HVFMuNrRMfIeK0gEeOaTendKYiIWYmAvv9AHqaKJ3Nj4fVln1PGj2CmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuFj0mDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B369DC19425;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766146571;
	bh=mGQWDqMqaGA6etpjh9YzRfJnnV2yEZ4c6MZcDZp1c5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nuFj0mDVtoYlAlSLKGyZa073tu3UzU3PpXi2RNnha+zdkIU+V+Sg336T0wGGYrmDj
	 WPiuSRGvP3mIDT/0rLGl+Bw+nsGhXevARD1uphpp7SX1ytmiyj8CU0GjF06hbRnvWJ
	 DS96Ya3oQYnktbi2e5nIC3VPkcQ+fXB/fh+4xenkG77haom7vf+eUngan/udYr4Mxa
	 FRyxGX1OPvtEDOVeYbd/63jYPs90ulwRxMoUYYMA9H3X8gT4jxNWw5yaNBaViQ/eLR
	 DlZgx9Kx+1Vbq9Bh3OWtGp/S9KUElcQ03tHRxLmrXXRQFkgKWukw7UJ7NerPZi9xBk
	 pWuG2Yuv4SBjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76A9D78767;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 19 Dec 2025 13:15:55 +0100
Subject: [PATCH 4/9] sysctl: Add negp parameter to douintvec converter
 functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-jag-dovec_consolidate-v1-4-1413b92c6040@kernel.org>
References: <20251219-jag-dovec_consolidate-v1-0-1413b92c6040@kernel.org>
In-Reply-To: <20251219-jag-dovec_consolidate-v1-0-1413b92c6040@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5249;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=mGQWDqMqaGA6etpjh9YzRfJnnV2yEZ4c6MZcDZp1c5U=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlFQgbUaRFKpbN1T/p5YTjcRXnhtu67NA150
 L6y2lwHDdejUYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpRUIGAAoJELqXzVK3
 lkFP62sL/0ekXjrqWbEUficwKtqfVcs9OwrIfiS7Yq7Q0mkdMS+BoyGAJ9HifYu+7u5mjzI1Ndk
 5+gXYDkosxOw5B9fIKhUvnwDs6dMBJ4Qk/qZ7JgsWjetRQ2G+m23jFZgTLKD/iBmplAl7n5EBQg
 a+haLIQ6qBx8MuAmT6/BcVB8k4CQvP1RiphgALmIt6SvtkphdDC+n9rO5fC6D6AvSKy8DOmZr27
 gf2iroSe84Vil+1e0cp8MdlN76dP7idKQCdE3DDFroI+bLhOmMvHjfMoQJuVdDm+DtKUNyQ4C7g
 LcSFEXLOtBhvUpvAHavuyuFF9tEIrLVQPiGC7oxDdVhQO+GTUZpbE53cj0BX4BsjMrEY/SZY8gD
 akTxqbizrDgkzwv02l6FY5iViXSyVIbI9RtPtTIqeZ274mNx2ve9M47sAqH4SuA98dirZ/DpKLo
 Wsj0wm8LwhtsdXl93o16qCRHS145R2RhYpy3VhDoJ6aV+y1tz00tY18O5LfcEtXt5DV04lNXIc5
 YY=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Updates all douintvec converter function signatures to include a bool
*negp parameter. This is a preparation commit required to eventually
generate do_proc_douintvec with a macro. The negp argument will be
ignored as it is not relevant for the uint type. Note that
do_proc_uint_conv_pipe_maxsz in pipe.c is also modified.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 fs/pipe.c              |  2 +-
 include/linux/sysctl.h |  2 +-
 kernel/sysctl.c        | 25 +++++++++++++------------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 22647f50b286d3bca024ee4c6de51b100ddc5402..e4a8b6d43bee873ceb1928afab9909e6cd6e4418 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1492,7 +1492,7 @@ static int u2k_pipe_maxsz(const ulong *u_ptr, uint *k_ptr)
 	return proc_uint_u2k_conv_uop(u_ptr, k_ptr, round_pipe_size_ul);
 }
 
-static int do_proc_uint_conv_pipe_maxsz(ulong *u_ptr, uint *k_ptr,
+static int do_proc_uint_conv_pipe_maxsz(bool *negp, ulong *u_ptr, uint *k_ptr,
 					int dir, const struct ctl_table *table)
 {
 	return proc_uint_conv(u_ptr, k_ptr, dir, table, true,
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 5c8c17f98513983a459c54eae99d1cc8bd63b011..8f8e357b1f4d377a0891fbc85d34073cd30469b1 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -102,7 +102,7 @@ int proc_douintvec_minmax(const struct ctl_table *table, int write, void *buffer
 		size_t *lenp, loff_t *ppos);
 int proc_douintvec_conv(const struct ctl_table *table, int write, void *buffer,
 			size_t *lenp, loff_t *ppos,
-			int (*conv)(unsigned long *lvalp, unsigned int *valp,
+			int (*conv)(bool *negp, ulong *lvalp, uint *valp,
 				    int write, const struct ctl_table *table));
 int proc_uint_k2u_conv(ulong *u_ptr, const uint *k_ptr);
 int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d21eeb2bca19ab927a604e8de137958eb08f82a6..8d0796b45b0101096ee395c7ed7c37f7b7199db4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -444,7 +444,7 @@ static int proc_uint_u2k_conv(const ulong *u_ptr, uint *k_ptr)
 	return proc_uint_u2k_conv_uop(u_ptr, k_ptr, NULL);
 }
 
-static int do_proc_uint_conv(ulong *u_ptr, uint *k_ptr, int dir,
+static int do_proc_uint_conv(bool *negp, ulong *u_ptr, uint *k_ptr, int dir,
 			     const struct ctl_table *tbl)
 {
 	return proc_uint_conv(u_ptr, k_ptr, dir, tbl, false,
@@ -652,7 +652,7 @@ do_proc_dotypevec(ulong)
 
 static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
 			       size_t *lenp, loff_t *ppos,
-			       int (*conv)(unsigned long *u_ptr,
+			       int (*conv)(bool *negp, unsigned long *u_ptr,
 					   unsigned int *k_ptr, int dir,
 					   const struct ctl_table *table))
 {
@@ -705,17 +705,18 @@ static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
 
 static int do_proc_douintvec_r(const struct ctl_table *table, void *buffer,
 			       size_t *lenp, loff_t *ppos,
-			       int (*conv)(unsigned long *u_ptr,
+			       int (*conv)(bool *negp, unsigned long *u_ptr,
 					   unsigned int *k_ptr, int dir,
 					   const struct ctl_table *table))
 {
 	unsigned long lval;
 	int err = 0;
 	size_t left;
+	bool negp;
 
 	left = *lenp;
 
-	if (conv(&lval, (unsigned int *) table->data, 0, table)) {
+	if (conv(&negp, &lval, (unsigned int *) table->data, 0, table)) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -735,9 +736,8 @@ static int do_proc_douintvec_r(const struct ctl_table *table, void *buffer,
 
 static int do_proc_douintvec(const struct ctl_table *table, int dir,
 			     void *buffer, size_t *lenp, loff_t *ppos,
-			      int (*conv)(unsigned long *u_ptr,
-					  unsigned int *k_ptr, int dir,
-					  const struct ctl_table *table))
+			     int (*conv)(bool *negp, ulong *u_ptr, uint *k_ptr,
+					 int dir, const struct ctl_table *table))
 {
 	unsigned int vleft;
 
@@ -758,9 +758,6 @@ static int do_proc_douintvec(const struct ctl_table *table, int dir,
 		return -EINVAL;
 	}
 
-	if (!conv)
-		conv = do_proc_uint_conv;
-
 	if (SYSCTL_USER_TO_KERN(dir))
 		return do_proc_douintvec_w(table, buffer, lenp, ppos, conv);
 	return do_proc_douintvec_r(table, buffer, lenp, ppos, conv);
@@ -784,9 +781,13 @@ static int do_proc_douintvec(const struct ctl_table *table, int dir,
  */
 int proc_douintvec_conv(const struct ctl_table *table, int dir, void *buffer,
 			size_t *lenp, loff_t *ppos,
-			int (*conv)(unsigned long *u_ptr, unsigned int *k_ptr,
+			int (*conv)(bool *negp, ulong *u_ptr, uint *k_ptr,
 				    int dir, const struct ctl_table *table))
 {
+
+	if (!conv)
+		conv = do_proc_uint_conv;
+
 	return do_proc_douintvec(table, dir, buffer, lenp, ppos, conv);
 }
 
@@ -1314,7 +1315,7 @@ int proc_douintvec_minmax(const struct ctl_table *table, int dir,
 
 int proc_douintvec_conv(const struct ctl_table *table, int write, void *buffer,
 			size_t *lenp, loff_t *ppos,
-			int (*conv)(unsigned long *lvalp, unsigned int *valp,
+			int (*conv)(bool *negp, ulong *lvalp, uint *valp,
 				    int write, const struct ctl_table *table))
 {
 	return -ENOSYS;

-- 
2.50.1



