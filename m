Return-Path: <linux-fsdevel+bounces-71535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 702A6CC679D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8646A3017398
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 08:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8342E339B44;
	Wed, 17 Dec 2025 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iB+nIO6c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709B32571D;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958738; cv=none; b=fx7ySitz6UE46vTqhTVBvx/6dzPQCJXRGtF5Cmbc32wmtIxBcSS8DM8ZJS7NL8ZIvzvM8dxLW0ctgM52GsUxo/bhI5dcsHkZb8LmbSR4kSuDYb/rY3vaNqD3WNYkb+yotETc2fTYVhIC7Yw84W1N84g6A9lGNQJndrcbuS33ft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958738; c=relaxed/simple;
	bh=+2nSENO4UvL2K2wra6VTIYpb0JwlPttl3m8NdXIwoCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hwy8FhIdExigrAc0XfLIdSqwAgmlHtuvNssCLL7YkXDbPvGIiQcyLu1P2w6OoLANFKUWHmhpiZtL41ULn8XbCXvAX2i88c0EkCl2Prb8vYJ9mYK0zTEeR75MHewRV++e+YZ3JPA7WAbS3JGN045tJNu1Wk07ZgJsyQGeA73iP+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iB+nIO6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1D72C19425;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765958737;
	bh=+2nSENO4UvL2K2wra6VTIYpb0JwlPttl3m8NdXIwoCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iB+nIO6caJGeYBVMhb8WSg5ZSIMOlf2WjR671fyPTEqUvYqRxg0VT/sYwMQ1PWnBL
	 XnU7wurFtnQXMu++SFZ+ZzJwzBU6tzwdrlkmNNfPhMoFeWSC5mRgZXOHzHcbALvH5z
	 b+ns02P1LZ5vgoIdO7wzxiKjBHJPIOULpECMjW6P/TZi9M44WA/A69BILJJWYJpsjj
	 OxV6WNms6PmD25v4HoAd2+2i+FhrTCjMNVaaeCqbkocvccSzkI1Zue76FCcNoKRWYI
	 biUKV+TyGZFkPlqtFLdJ4ztjQcvCw2vPc2tEdVJZTA5bZWqYTNiZYl9YEUfMQnQ5tm
	 /DxndliY7Vw2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD5ED6408D;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Wed, 17 Dec 2025 09:04:42 +0100
Subject: [PATCH 4/7] sysctl: Replace UINT converter macros with functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-jag-no-macro-conv-v1-4-6e4252687915@kernel.org>
References: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
In-Reply-To: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10667;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=+2nSENO4UvL2K2wra6VTIYpb0JwlPttl3m8NdXIwoCE=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlCZEuxqD9e4qUpyMHmD/ocR2Q7cM3z+wFAo
 EbZXuVtBwKi0IkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpQmRLAAoJELqXzVK3
 lkFPE0UL/0MY6kN6rnvY6jS+0JLMaYxHRu/+Hv3ENDKuLgcPrbhFYWcGb/MlJdGm1Xj9HgNEhob
 sis9F3mJQdz8tiqIOVJWlwtQQ1jhRKnX1pP2N99z+QONH1nQRHP/Pq4IEBwsJhB4OWri75VUZQf
 YWLk2//IDQEz0Kwqi4Np1OOAqvxTok6+WWtj5bS/qxUKgOnqtzHK7uDeLve3P8LPP56hEbgzM+h
 BqwZs96R72pt+yk+9eBGwMbEWz56yQ+w/TfLgACEJ4SJfT30YAWwgFDS+AXEuB6lLKeZMUW2qva
 7ZXCuDmKvLI2UKo596jMqLDNAi8i8xPYUo9EiO9j0gxGGYHdy50BgpX7a1ZQFUpcHGJ1JLTtUGL
 GWUEX9s4kppzhWTPqZC0dN2WwhtW6OsXknOWVvvE9OU2nnkJRTCFwgciG9Xtlj6R9XYiuRTPlDf
 rE8cmAMKSqcgYxXgxMDJtglj4C/Y2xkhoNmFXIfcN+qJ2yiDhBtLus9t1FxAz7oe+j6lXeY3vF6
 1o=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Replace the SYSCTL_USER_TO_KERN_UINT_CONV and SYSCTL_UINT_CONV_CUSTOM
macros with functions with the same logic. This makes debugging easier
and aligns with the functions preference described in coding-style.rst.
Update the only user of this API: pipe.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 fs/pipe.c              |  22 ++++++--
 include/linux/sysctl.h |  63 +++-------------------
 kernel/sysctl.c        | 140 +++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 148 insertions(+), 77 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9e6a01475815986ea2511868f66f4a8763978578..22647f50b286d3bca024ee4c6de51b100ddc5402 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1481,10 +1481,24 @@ static struct file_system_type pipe_fs_type = {
 };
 
 #ifdef CONFIG_SYSCTL
-static SYSCTL_USER_TO_KERN_UINT_CONV(_pipe_maxsz, round_pipe_size)
-static SYSCTL_UINT_CONV_CUSTOM(_pipe_maxsz,
-			       sysctl_user_to_kern_uint_conv_pipe_maxsz,
-			       sysctl_kern_to_user_uint_conv, true)
+
+static ulong round_pipe_size_ul(ulong size)
+{
+	return round_pipe_size(size);
+}
+
+static int u2k_pipe_maxsz(const ulong *u_ptr, uint *k_ptr)
+{
+	return proc_uint_u2k_conv_uop(u_ptr, k_ptr, round_pipe_size_ul);
+}
+
+static int do_proc_uint_conv_pipe_maxsz(ulong *u_ptr, uint *k_ptr,
+					int dir, const struct ctl_table *table)
+{
+	return proc_uint_conv(u_ptr, k_ptr, dir, table, true,
+			      u2k_pipe_maxsz,
+			      proc_uint_k2u_conv);
+}
 
 static int proc_dopipe_max_size(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 0a64212a0ceb8454ae343831739831a092b6e693..d712992789f0f2f3fe4cec10fb14907b7fd61a7e 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -135,45 +135,6 @@ int do_proc_int_conv##name(bool *negp, unsigned long *u_ptr, int *k_ptr,\
 		return user_to_kern(negp, u_ptr, k_ptr);		\
 	return 0;							\
 }
-
-#define SYSCTL_USER_TO_KERN_UINT_CONV(name, u_ptr_op)		\
-int sysctl_user_to_kern_uint_conv##name(const unsigned long *u_ptr,\
-					unsigned int *k_ptr)	\
-{								\
-	unsigned long u = u_ptr_op(*u_ptr);			\
-	if (u > UINT_MAX)					\
-		return -EINVAL;					\
-	WRITE_ONCE(*k_ptr, u);					\
-	return 0;						\
-}
-
-#define SYSCTL_UINT_CONV_CUSTOM(name, user_to_kern, kern_to_user,	\
-				k_ptr_range_check)			\
-int do_proc_uint_conv##name(unsigned long *u_ptr, unsigned int *k_ptr,	\
-			   int dir, const struct ctl_table *tbl)	\
-{									\
-	if (SYSCTL_KERN_TO_USER(dir))					\
-		return kern_to_user(u_ptr, k_ptr);			\
-									\
-	if (k_ptr_range_check) {					\
-		unsigned int tmp_k;					\
-		int ret;						\
-		if (!tbl)						\
-			return -EINVAL;					\
-		ret = user_to_kern(u_ptr, &tmp_k);			\
-		if (ret)						\
-			return ret;					\
-		if ((tbl->extra1 &&					\
-		     *(unsigned int *)tbl->extra1 > tmp_k) ||		\
-		    (tbl->extra2 &&					\
-		     *(unsigned int *)tbl->extra2 < tmp_k))		\
-			return -ERANGE;					\
-		WRITE_ONCE(*k_ptr, tmp_k);				\
-	} else								\
-		return user_to_kern(u_ptr, k_ptr);			\
-	return 0;							\
-}
-
 #else // CONFIG_PROC_SYSCTL
 #define SYSCTL_USER_TO_KERN_INT_CONV(name, u_ptr_op)		\
 int sysctl_user_to_kern_int_conv##name(const bool *negp,	\
@@ -199,24 +160,8 @@ int do_proc_int_conv##name(bool *negp, unsigned long *u_ptr, int *k_ptr,\
 	return -ENOSYS;							\
 }
 
-#define SYSCTL_USER_TO_KERN_UINT_CONV(name, u_ptr_op)		\
-int sysctl_user_to_kern_uint_conv##name(const unsigned long *u_ptr,\
-					unsigned int *k_ptr)	\
-{								\
-	return -ENOSYS;						\
-}
-
-#define SYSCTL_UINT_CONV_CUSTOM(name, user_to_kern, kern_to_user,	\
-				k_ptr_range_check)			\
-int do_proc_uint_conv##name(unsigned long *u_ptr, unsigned int *k_ptr,	\
-			   int dir, const struct ctl_table *tbl)	\
-{									\
-	return -ENOSYS;							\
-}
-
 #endif // CONFIG_PROC_SYSCTL
 
-
 extern const unsigned long sysctl_long_vals[];
 
 typedef int proc_handler(const struct ctl_table *ctl, int write, void *buffer,
@@ -239,6 +184,13 @@ int proc_douintvec_conv(const struct ctl_table *table, int write, void *buffer,
 			size_t *lenp, loff_t *ppos,
 			int (*conv)(unsigned long *lvalp, unsigned int *valp,
 				    int write, const struct ctl_table *table));
+int proc_uint_k2u_conv(ulong *u_ptr, const uint *k_ptr);
+int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
+			   ulong (*u_ptr_op)(const ulong));
+int proc_uint_conv(ulong *u_ptr, uint *k_ptr, int dir,
+		   const struct ctl_table *tbl, bool k_ptr_range_check,
+		   int (*user_to_kern)(const ulong *u_ptr, uint *k_ptr),
+		   int (*kern_to_user)(ulong *u_ptr, const uint *k_ptr));
 
 int proc_dou8vec_minmax(const struct ctl_table *table, int write, void *buffer,
 			size_t *lenp, loff_t *ppos);
@@ -249,7 +201,6 @@ int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
 int proc_do_large_bitmap(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_do_static_key(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
-int sysctl_kern_to_user_uint_conv(unsigned long *u_ptr, const unsigned int *k_ptr);
 
 /*
  * Register a set of sysctl names by calling register_sysctl
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e82716b7c13840cadc3b19a7c9d05b167abebcf6..5901196a52f98cdd5aba4f50899a58d9bd9d10f9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -354,6 +354,110 @@ static void proc_put_char(void **buf, size_t *size, char c)
 	}
 }
 
+/**
+ * proc_uint_u2k_conv_uop - Assign user value to a kernel pointer
+ *
+ * @u_ptr: pointer to user space variable
+ * @k_ptr: pointer to kernel variable
+ * @u_ptr_op: execute this function before assigning to k_ptr
+ *
+ * Uses WRITE_ONCE to assign value to k_ptr. Executes u_ptr_op if
+ * not NULL. Check that the values are less than UINT_MAX to avoid
+ * having to support wrap around from userspace.
+ *
+ * returns 0 on success.
+ */
+int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
+			   ulong (*u_ptr_op)(const ulong))
+{
+	ulong u = u_ptr_op ? u_ptr_op(*u_ptr) : *u_ptr;
+
+	if (u > UINT_MAX)
+		return -EINVAL;
+	WRITE_ONCE(*k_ptr, u);
+	return 0;
+}
+
+/**
+ * proc_uint_k2u_conv - Assign kernel value to a user space pointer
+ *
+ * @u_ptr: pointer to user space variable
+ * @k_ptr: pointer to kernel variable
+ *
+ * Uses READ_ONCE to assign value to u_ptr.
+ *
+ * returns 0 on success.
+ */
+int proc_uint_k2u_conv(ulong *u_ptr, const uint *k_ptr)
+{
+	uint val = READ_ONCE(*k_ptr);
+	*u_ptr = (ulong)val;
+	return 0;
+}
+
+/**
+ * proc_uint_conv - Change user or kernel pointer based on direction
+ *
+ * @u_ptr: pointer to user variable
+ * @k_ptr: pointer to kernel variable
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @tbl: the sysctl table
+ * @k_ptr_range_check: Check range for k_ptr when %TRUE
+ * @user_to_kern: Callback used to assign value from user to kernel var
+ * @kern_to_user: Callback used to assign value from kernel to user var
+ *
+ * When direction is kernel to user, then the u_ptr is modified.
+ * When direction is user to kernel, then the k_ptr is modified.
+ *
+ * Returns 0 on success
+ */
+int proc_uint_conv(ulong *u_ptr, uint *k_ptr, int dir,
+		   const struct ctl_table *tbl, bool k_ptr_range_check,
+		   int (*user_to_kern)(const ulong *u_ptr, uint *k_ptr),
+		   int (*kern_to_user)(ulong *u_ptr, const uint *k_ptr))
+{
+	if (SYSCTL_KERN_TO_USER(dir))
+		return kern_to_user(u_ptr, k_ptr);
+
+	if (k_ptr_range_check) {
+		uint tmp_k;
+		int ret;
+
+		if (!tbl)
+			return -EINVAL;
+		ret = user_to_kern(u_ptr, &tmp_k);
+		if (ret)
+			return ret;
+		if ((tbl->extra1 &&
+		     *(uint *)tbl->extra1 > tmp_k) ||
+		    (tbl->extra2 &&
+		     *(uint *)tbl->extra2 < tmp_k))
+			return -ERANGE;
+		WRITE_ONCE(*k_ptr, tmp_k);
+	} else
+		return user_to_kern(u_ptr, k_ptr);
+	return 0;
+}
+
+static int proc_uint_u2k_conv(const ulong *u_ptr, uint *k_ptr)
+{
+	return proc_uint_u2k_conv_uop(u_ptr, k_ptr, NULL);
+}
+
+static int do_proc_uint_conv(ulong *u_ptr, uint *k_ptr, int dir,
+			     const struct ctl_table *tbl)
+{
+	return proc_uint_conv(u_ptr, k_ptr, dir, tbl, false,
+			      proc_uint_u2k_conv, proc_uint_k2u_conv);
+}
+
+static int do_proc_uint_conv_minmax(ulong *u_ptr, uint *k_ptr, int dir,
+				    const struct ctl_table *tbl)
+{
+	return proc_uint_conv(u_ptr, k_ptr, dir, tbl, true,
+			      proc_uint_u2k_conv, proc_uint_k2u_conv);
+}
+
 static SYSCTL_USER_TO_KERN_INT_CONV(, SYSCTL_CONV_IDENTITY)
 static SYSCTL_KERN_TO_USER_INT_CONV(, SYSCTL_CONV_IDENTITY)
 
@@ -362,22 +466,6 @@ static SYSCTL_INT_CONV_CUSTOM(, sysctl_user_to_kern_int_conv,
 static SYSCTL_INT_CONV_CUSTOM(_minmax, sysctl_user_to_kern_int_conv,
 			      sysctl_kern_to_user_int_conv, true)
 
-
-static SYSCTL_USER_TO_KERN_UINT_CONV(, SYSCTL_CONV_IDENTITY)
-
-int sysctl_kern_to_user_uint_conv(unsigned long *u_ptr,
-				  const unsigned int *k_ptr)
-{
-	unsigned int val = READ_ONCE(*k_ptr);
-	*u_ptr = (unsigned long)val;
-	return 0;
-}
-
-static SYSCTL_UINT_CONV_CUSTOM(, sysctl_user_to_kern_uint_conv,
-			       sysctl_kern_to_user_uint_conv, false)
-static SYSCTL_UINT_CONV_CUSTOM(_minmax, sysctl_user_to_kern_uint_conv,
-			       sysctl_kern_to_user_uint_conv, true)
-
 static const char proc_wspace_sep[] = { ' ', '\t', '\n' };
 
 static int do_proc_dointvec(const struct ctl_table *table, int dir,
@@ -576,7 +664,6 @@ int proc_douintvec_conv(const struct ctl_table *table, int dir, void *buffer,
 	return do_proc_douintvec(table, dir, buffer, lenp, ppos, conv);
 }
 
-
 /**
  * proc_dobool - read/write a bool
  * @table: the sysctl table
@@ -1063,6 +1150,25 @@ int proc_douintvec_conv(const struct ctl_table *table, int write, void *buffer,
 	return -ENOSYS;
 }
 
+int proc_uint_k2u_conv(ulong *u_ptr, const uint *k_ptr)
+{
+	return -ENOSYS;
+}
+
+int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
+			   ulong (*u_ptr_op)(const ulong))
+{
+	return -ENOSYS;
+}
+
+int proc_uint_conv(ulong *u_ptr, uint *k_ptr, int dir,
+		   const struct ctl_table *tbl, bool k_ptr_range_check,
+		   int (*user_to_kern)(const ulong *u_ptr, uint *k_ptr),
+		   int (*kern_to_user)(ulong *u_ptr, const uint *k_ptr))
+{
+	return -ENOSYS;
+}
+
 int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {

-- 
2.50.1



