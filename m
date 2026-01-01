Return-Path: <linux-fsdevel+bounces-72310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A561CED045
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 13:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57068301AD3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 12:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B3025783C;
	Thu,  1 Jan 2026 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTC9dWze"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90027220F3E;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767272242; cv=none; b=PTmVcv1qjyf74PiVkf+3j+RkFR+C9fo5fJ27/mgGF6DCwxjJHVxfRxv1spwfiflLLu3JKTc7R7X2waQcdeagU9MQxXRGgAie5xRW/R+N6j0YOmKd5Dz3RuHiTVFsDqQoscZ70l3W+4PLbm9wzsnnZIlWG5XXx6R1BqB9eGl+LKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767272242; c=relaxed/simple;
	bh=gGY7DWYnYmsF86+DmOH72RVF1PosapGq/aYwNvDGIFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8+eOzKXkb7LU5B02PnTqdQyNkU7abOHDoRuBenJUkMcEEuzHrplxEtm0CIshuPfFdLQuLhcVhIAaDcCP7TpiJbxxWqwIBIsNOmVFr97Btwqr8kCGx/QvLggZvhcnu0mSwesRuIKoRXVr/95bY4PYw9M+6UGemki5q3AHzjLEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTC9dWze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3558EC2BC87;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767272242;
	bh=gGY7DWYnYmsF86+DmOH72RVF1PosapGq/aYwNvDGIFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QTC9dWzeHrdDLRC/a35fzS0uD8DvZAt6kYoztR5iJkyqMydzBa69VFdsAhEKDyJvK
	 qHOPqC8wdz+wnPnLYRotV3MDXbtBw/2XAlH0aFV72ZiO5XPqmd8FVunNZMVBtIaG26
	 tdFSmyySDBvI+yXjVGQNyFvbCytdRJbZOmYAWZRkxejRnQBZznfSA0mKk66ZLORQ6g
	 ZDeHmpQ30ESUeE8KdMpbWq+0gW3UsCNv2MoZ40w+izsxAbxWvlrA+EHo9j+hGlhnZv
	 NEmgQeXdjYprKS6mhDsaxw8gBPOuPG69DPcw0A+Bi2fGC02TKwon0Eue09w1XHmAry
	 ztWOmM7vZae2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F4AEED603;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 01 Jan 2026 13:57:08 +0100
Subject: [PATCH v2 4/9] sysctl: Add negp parameter to douintvec converter
 functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-jag-dovec_consolidate-v2-4-ff918f753ba9@kernel.org>
References: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
In-Reply-To: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5249;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=gGY7DWYnYmsF86+DmOH72RVF1PosapGq/aYwNvDGIFs=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlWbywPg9aGF/T8cCrGZo+yLl5cW6IwCELE3
 0SPDgWLmLz0e4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpVm8sAAoJELqXzVK3
 lkFP3OYMAJPu4Q9nxsg0WyyLR5s58tGaIK5HhUKFIkrqvO3zGrhAooUkPFvnAs4fx1OWn2YoKSD
 VSDwduhQeLxIji3SUXwsYq9/3HA88L/QNNRfHpmKfivzIUGl4KiaddHrraUS6XS3Rj5/xC/4pKN
 rrx2I8VclLEiAMR9gMI/iF8BSeBwaFixhtlBs0VKClPhGgeF0FIK4AQpcoxqVaUYPke1rVdehzZ
 gmHVwPBaj4Rlcyqf7H7ZAwt3FP4n3Z8o/2pPmI0sC0HhX4w2I0OGEMx9BYqTCiTq0rRtGTKB7j1
 EosPTqYb0FdzT9jQEZAYVhk4jwS0wzUIyLwiBh9WgjjMWi0viyR1UMnBNDNlDQNPhW9fG6v+F8S
 G9bIGm0hRIYm/8rr+84TfbZYzf7zf/20lJ646HT6v0PdEkvdPqxJ4lx0YoztFejWLkMqUw/blno
 xUm9bc8mthtt8l4o+ygmB2XTJSaRRBsNOkOSWERJAJ++hBVuskryNaWV8h2q55BupP0zSpOYk72
 Qk=
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
index 53babebd65f401244d15dc53a8b7e7b2f73473b3..8c0bbb82cfcbc8830a0f3a68326c002ac51d41a6 100644
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
@@ -654,7 +654,7 @@ do_proc_dotypevec(ulong)
 
 static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
 			       size_t *lenp, loff_t *ppos,
-			       int (*conv)(unsigned long *u_ptr,
+			       int (*conv)(bool *negp, unsigned long *u_ptr,
 					   unsigned int *k_ptr, int dir,
 					   const struct ctl_table *table))
 {
@@ -707,17 +707,18 @@ static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
 
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
@@ -737,9 +738,8 @@ static int do_proc_douintvec_r(const struct ctl_table *table, void *buffer,
 
 static int do_proc_douintvec(const struct ctl_table *table, int dir,
 			     void *buffer, size_t *lenp, loff_t *ppos,
-			      int (*conv)(unsigned long *u_ptr,
-					  unsigned int *k_ptr, int dir,
-					  const struct ctl_table *table))
+			     int (*conv)(bool *negp, ulong *u_ptr, uint *k_ptr,
+					 int dir, const struct ctl_table *table))
 {
 	unsigned int vleft;
 
@@ -760,9 +760,6 @@ static int do_proc_douintvec(const struct ctl_table *table, int dir,
 		return -EINVAL;
 	}
 
-	if (!conv)
-		conv = do_proc_uint_conv;
-
 	if (SYSCTL_USER_TO_KERN(dir))
 		return do_proc_douintvec_w(table, buffer, lenp, ppos, conv);
 	return do_proc_douintvec_r(table, buffer, lenp, ppos, conv);
@@ -786,9 +783,13 @@ static int do_proc_douintvec(const struct ctl_table *table, int dir,
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
 
@@ -1316,7 +1317,7 @@ int proc_douintvec_minmax(const struct ctl_table *table, int dir,
 
 int proc_douintvec_conv(const struct ctl_table *table, int write, void *buffer,
 			size_t *lenp, loff_t *ppos,
-			int (*conv)(unsigned long *lvalp, unsigned int *valp,
+			int (*conv)(bool *negp, ulong *lvalp, uint *valp,
 				    int write, const struct ctl_table *table))
 {
 	return -ENOSYS;

-- 
2.50.1



