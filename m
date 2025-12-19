Return-Path: <linux-fsdevel+bounces-71739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C429BCCFC3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68AC8307DA6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC733B6DC;
	Fri, 19 Dec 2025 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGaQ6VxY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E60A33970C;
	Fri, 19 Dec 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146572; cv=none; b=IhQHV+F/QxkOK6bz/VoQ/CRXzBpmG0PeAFUzPbU1bDxWLWliXk1AzynLwkqCgtnhvGytylOWydHZFSVnPxqe2zHFrwanSqaWnl1Bjz9AdfZVeY5T1AZr7hcG3LEZmopeUb4grb7+22PHfNqmPdb9bu3aWHo2RW2HCjDfozhAHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146572; c=relaxed/simple;
	bh=PIAQtecICUqPpS+GwLLx44WXYsf3diE+/qtx8X2p5C0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DCpqlcENGvAdT6Ub3ZZOFupIbfeufw3ojg1dmKXI58UdkAKE6iK7mEwBMjEEEIgFCMu1Ogn0fShNe7RlAFOWz59hzBy14zXFxwN/1ZkEvp3OgqlPOLKH/NLHRgX5Pn6GWyISW501zjzMHzZc1brrEePa6pKa/ersuLkq589KeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGaQ6VxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD070C2BC87;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766146571;
	bh=PIAQtecICUqPpS+GwLLx44WXYsf3diE+/qtx8X2p5C0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JGaQ6VxYvnNa/xlO6FBJ8GU6thqnHnfEyhG6k5Dezj8CWE0g6FUeZjHhTMolJDxaz
	 C8VmiFRUoDSQQqX+4jDLHX7PjfL7iq9z3xvoNJDh7/2yemePyOaH3KCDEqzAeJrIQR
	 iNsv4TPztTz8lLbIcw9FquTFcTDiu+p9IfI3/JGv5hAeVpzIkpcJJslpYhKdNkskLc
	 EcBEHnKoXkcb3x9eJNDDvulOMQNwb/8mEFebwQ+1SFT0FJdP5/OA1mj83no7jLW+YO
	 xbzaSoNIQVxMkTtSJsUdObP8rTzQDZDSiwazzn3z/faggkFSWFyIkra4qn/p9TokB0
	 6seHwt4x+2DhA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C51D78762;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 19 Dec 2025 13:15:58 +0100
Subject: [PATCH 7/9] sysctl: Group proc_handler declarations and document
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-jag-dovec_consolidate-v1-7-1413b92c6040@kernel.org>
References: <20251219-jag-dovec_consolidate-v1-0-1413b92c6040@kernel.org>
In-Reply-To: <20251219-jag-dovec_consolidate-v1-0-1413b92c6040@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8609;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=PIAQtecICUqPpS+GwLLx44WXYsf3diE+/qtx8X2p5C0=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlFQghNxbNE0xp+zkXK+eCJcGGdb1yg2BWNc
 wJoHAKW/A+2bokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpRUIIAAoJELqXzVK3
 lkFPvi0L/iBM2N+2I9pEm4kzOd7bJy56+p8OEtVTzVSuM9Kl3BjiItPv2xK2QJSA+o9iE2rFjhH
 1xPGl11hBXjaUE1pgRorIvvAXOUItMKGTVOJg/PcpK+72Mrxc7g0IDFN68iATrE8nySch/RGJDS
 ESVqk27uoEKTJV/8xmBfL+nCx6h2bjjz0A3hX13JoFfLeHy8kraSJ8qIRvaT3gqC6VsfPD5kqqm
 zluFu8ua7Ilwq/SAv+kalZRRT05t4pqU78SxGM8f5hbVhtEnv63zOFUq1Za9dJjBz23PIeLNfeM
 io4uqRzM92mKke2FJxt7Fm0Gae2bOhnct0hP0fNTozNKC280ElI5OLswWZ85DLTiwSXoZkk9MNZ
 xzvbWxv5m3UpK4+ZrsRwKlZ0SMRv+1YyCoSc1y+qTt+PXDV4koCo4zlz7hQRY+LiqO5GM0DSxEU
 bc2QO8PjYpt4xTAFX/u3XwKXQVjHV3risaV4WBEOJFY2k+ZB6h5YYVstm6I/jfp/3wodU5pI9l5
 jA=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Make four groups in the sysctl header and document each group with an
example of how to use them.
1. proc_handler : All functions that can be passed to the proc_handler
   pointer in ctl_table
2. proc handler aggregators: Functions to create proc handlers with
   custom converters
3. bi-directional converters: Functions to create read/write custom
   converters. Can be passed to proc handler aggregators
4. uni-directional converters: Functions to create read or write custom
   converters. Can be passed as args to bi-directional converters

Use just one naming convention in the declarations: 'write' becomes
'dir' and 'buffer' becomes 'buf'.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/sysctl.h | 128 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 41 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 8f8e357b1f4d377a0891fbc85d34073cd30469b1..ad268dfd9e79f5540a4a85a9a439819fb3172640 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -74,63 +74,109 @@ extern const int sysctl_vals[];
 
 extern const unsigned long sysctl_long_vals[];
 
-typedef int proc_handler(const struct ctl_table *ctl, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
-
-int proc_dostring(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_dobool(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
+typedef int proc_handler(const struct ctl_table *ctl, int dir, void *buf,
+			 size_t *lenp, loff_t *ppos);
 
-int proc_dointvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_dointvec_minmax(const struct ctl_table *table, int dir, void *buffer,
+/* proc_handler functions */
+int proc_dostring(const struct ctl_table *ctl, int dir, void *buf, size_t *lenp,
+		  loff_t *ppos);
+int proc_dobool(const struct ctl_table *ctl, int dir, void *buf, size_t *lenp,
+		loff_t *ppos);
+int proc_dointvec(const struct ctl_table *ctl, int dir, void *buf, size_t *lenp,
+		  loff_t *ppos);
+int proc_dointvec_minmax(const struct ctl_table *ctl, int dir, void *buf,
 			 size_t *lenp, loff_t *ppos);
-int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
+int proc_douintvec(const struct ctl_table *ctl, int dir, void *buf, size_t *lenp,
+		   loff_t *ppos);
+int proc_douintvec_minmax(const struct ctl_table *ctl, int dir, void *buf,
+			  size_t *lenp, loff_t *ppos);
+int proc_dou8vec_minmax(const struct ctl_table *ctl, int dir, void *buf,
+			size_t *lenp, loff_t *ppos);
+int proc_doulongvec_minmax(const struct ctl_table *ctl, int dir, void *buf,
+			   size_t *lenp, loff_t *ppos);
+int proc_do_large_bitmap(const struct ctl_table *ctl, int dir, void *buf,
+			 size_t *lenp, loff_t *ppos);
+int proc_do_static_key(const struct ctl_table *ctl, int dir, void *buf,
+		       size_t *lenp, loff_t *ppos);
+
+/*
+ * proc_handler aggregators
+ *
+ * Create a proc_handler with a custom converter. Use when the user space
+ * value is a transformation of the kernel value. Cannot be passed as
+ * proc_handlers.
+ *
+ * Example of creating your custom proc handler:
+ * int custom_converter(bool *negp, ulong *u_ptr, uint *k_ptr,
+ *                      int dir, const struct ctl_table *ctl) {...}
+ * int custom_proc_handler(const struct ctl_table *ctl, int dir,
+ *                         void *buf, size_t *lenp, loff_t *ppos
+ * { return proc_dointvec_conv(ctl, dir, buf, lenp, ppos, custom_converter); }
+ */
+int proc_dointvec_conv(const struct ctl_table *ctl, int dir, void *buf,
 		       size_t *lenp, loff_t *ppos,
 		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
-				   int dir, const struct ctl_table *table));
-int proc_int_k2u_conv_kop(ulong *u_ptr, const int *k_ptr, bool *negp,
-			  ulong (*k_ptr_op)(const ulong));
-int proc_int_u2k_conv_uop(const ulong *u_ptr, int *k_ptr, const bool *negp,
-			  ulong (*u_ptr_op)(const ulong));
+				   int dir, const struct ctl_table *ctl));
+int proc_douintvec_conv(const struct ctl_table *ctl, int dir, void *buf,
+			size_t *lenp, loff_t *ppos,
+			int (*conv)(bool *negp, ulong *u_ptr, uint *k_ptr,
+				    int dir, const struct ctl_table *ctl));
+int proc_doulongvec_minmax_conv(const struct ctl_table *ctl, int dir, void *buf,
+				size_t *lenp, loff_t *ppos,
+				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
+					    int dir, const struct ctl_table *ctl));
+
+/*
+ * bi-directional converter functions
+ *
+ * Specify the converter function for both directions (user to kernel & kernel
+ * to user). Use when you want to change the value of the variable before
+ * assignment. Used to create custom proc_handler aggregators.
+ *
+ * Example of creating your custom bi-directional converter:
+ * int custom_u2k(ulong *u_ptr, const uint *k_ptr) { ... }
+ * int custom_converter(bool *negp, ulong *u_ptr, uint *k_ptr,
+ *                      int dir, const struct ctl_table *ctl)
+ * { return proc_uint_conv(u_ptr, k_ptr, dir, ctl, true,
+ *                         custom_u2k, proc_uint_k2u_conv}
+ */
 int proc_int_conv(bool *negp, ulong *u_ptr, int *k_ptr, int dir,
 		  const struct ctl_table *tbl, bool k_ptr_range_check,
 		  int (*user_to_kern)(const bool *negp, const ulong *u_ptr, int *k_ptr),
 		  int (*kern_to_user)(bool *negp, ulong *u_ptr, const int *k_ptr));
-
-int proc_douintvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_douintvec_minmax(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
-int proc_douintvec_conv(const struct ctl_table *table, int write, void *buffer,
-			size_t *lenp, loff_t *ppos,
-			int (*conv)(bool *negp, ulong *lvalp, uint *valp,
-				    int write, const struct ctl_table *table));
-int proc_uint_k2u_conv(ulong *u_ptr, const uint *k_ptr);
-int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
-			   ulong (*u_ptr_op)(const ulong));
 int proc_uint_conv(ulong *u_ptr, uint *k_ptr, int dir,
 		   const struct ctl_table *tbl, bool k_ptr_range_check,
 		   int (*user_to_kern)(const ulong *u_ptr, uint *k_ptr),
 		   int (*kern_to_user)(ulong *u_ptr, const uint *k_ptr));
-
-int proc_dou8vec_minmax(const struct ctl_table *table, int write, void *buffer,
-			size_t *lenp, loff_t *ppos);
-int proc_doulongvec_minmax(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
-				void *buffer, size_t *lenp, loff_t *ppos,
-				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
-					    int dir, const struct ctl_table *table));
-int proc_do_large_bitmap(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_do_static_key(const struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
-
-int proc_ulong_u2k_conv_uop(const ulong *u_ptr, ulong *k_ptr,
-			    ulong (*u_ptr_op)(const ulong));
-int proc_ulong_k2u_conv_kop(ulong *u_ptr, const ulong *k_ptr,
-			    ulong (*k_ptr_op)(const ulong));
 int proc_ulong_conv(ulong *u_ptr, ulong *k_ptr, int dir,
 		    const struct ctl_table *tbl, bool k_ptr_range_check,
 		    int (*user_to_kern)(const ulong *u_ptr, ulong *k_ptr),
 		    int (*kern_to_user)(ulong *u_ptr, const ulong *k_ptr));
+
+/*
+ * uni-directional converter functions
+ *
+ * Specify the converter function for one directions (user to kernel or
+ * kernel to user). Use to call the actual value conversion. Used to Create
+ * bi-directional converters.
+ *
+ * Example of creating a uni-directional converter:
+ * ulong op(const ulong val) { ... }
+ * int custom_unidir_conv(ulong *u_ptr, const uint *k_ptr)
+ * { return proc_uint_k2u_conv_kop(u_ptr, k_ptr, op); }
+ */
+int proc_int_k2u_conv_kop(ulong *u_ptr, const int *k_ptr, bool *negp,
+			  ulong (*k_ptr_op)(const ulong));
+int proc_int_u2k_conv_uop(const ulong *u_ptr, int *k_ptr, const bool *negp,
+			  ulong (*u_ptr_op)(const ulong));
+int proc_uint_k2u_conv(ulong *u_ptr, const uint *k_ptr);
+int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
+			   ulong (*u_ptr_op)(const ulong));
+int proc_ulong_u2k_conv_uop(const ulong *u_ptr, ulong *k_ptr,
+			    ulong (*u_ptr_op)(const ulong));
+int proc_ulong_k2u_conv_kop(ulong *u_ptr, const ulong *k_ptr,
+			    ulong (*k_ptr_op)(const ulong));
+
 /*
  * Register a set of sysctl names by calling register_sysctl
  * with an initialised array of struct ctl_table's.

-- 
2.50.1



