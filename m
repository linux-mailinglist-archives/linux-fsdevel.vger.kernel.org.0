Return-Path: <linux-fsdevel+bounces-64422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E9BE7319
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54BC5563A71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1992C325D;
	Fri, 17 Oct 2025 08:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6P5mPde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD929D26D;
	Fri, 17 Oct 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689990; cv=none; b=gt5Y4shZTC3k83i2uevBIpgGjF8qr9x1R84hFCEyixGzPiMRq4Br1jO+BDuPezKdBi4kAaqSIU11yjR8cZnpPfuKmA9yrPy5Twk/FqoKVI0s9B2YOda8VUXdFkTc4CT52ugyHBPibw8w4pQffS66dn0DY6ZznklVjaV3gaFlOTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689990; c=relaxed/simple;
	bh=J/XuDhivZwKAD66MOrIiPHOdTNhERWxIdJGMnXHbn48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=topTeHqI/1erqYxuJfU/V+M7eQAVekKZMSNtEBTL8ODqOTNYr7hwd1cIElZzlYvOxx/+QJ/aO890ZZG81ZSGe5mzd+wY0kj0syWCYqqBcxP8lqW8fzqCRaXKxhNQO0uVO46vjUFTXcREVt2cWcNTFSmlFkbaD+e0wY+HP/inMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6P5mPde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFE04C19421;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760689989;
	bh=J/XuDhivZwKAD66MOrIiPHOdTNhERWxIdJGMnXHbn48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O6P5mPde7/+qGRjySN5IYoTWp6YWe9DHLZY1lESjpKxslGHpjsxnyktkbH2Wc7mBz
	 LKV4Nu0JLW1vif5fyfk7z5fj5AJTRCbX//09Tn1Gugkx+vrg0NLVEh33vZux4jZbKZ
	 aELrYgay4b9LEsGuoXw/cGv+l4dncGIKkoWKM2X6JtzuvAqGHNvGQhEKLWSD/15Q4E
	 OcFgMCnDcr94eNAwljOuYLZGWS3VLn0UNjFyRdChn32w+iEdJCxA9AZH+znJTkuC6c
	 aLGppTfmaf186wfdAQIU1Xa8REwEJlcRpNWs/Bh3sPNvqTGXge1LKRv+yKVqqP0BU7
	 sAxTs1T+dXytw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4389CCD19A;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 17 Oct 2025 10:32:15 +0200
Subject: [PATCH 5/7] sysctl: Move proc_doulongvec_ms_jiffies_minmax to
 kernel/time/jiffies.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-jag-sysctl_jiffies-v1-5-175d81dfdf82@kernel.org>
References: <20251017-jag-sysctl_jiffies-v1-0-175d81dfdf82@kernel.org>
In-Reply-To: <20251017-jag-sysctl_jiffies-v1-0-175d81dfdf82@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7144;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=J/XuDhivZwKAD66MOrIiPHOdTNhERWxIdJGMnXHbn48=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjx/0E8TjsdffajbstD7fzBD1y+LUuoPfEtq
 IJLT5UuMF5y6YkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo8f9BAAoJELqXzVK3
 lkFPOkcL/0pKG04lC051IyOouW0S2NCBIYo8qz+EJ3zFCqKcd5q7by9D3sq9lRr/V6zBm+vWA18
 HV/tlLwdqRygCuDxMfFTILDlc8bJIlyp7T9mFpxQ6qzM8U4qiZs8t0tfbVN1v79VWiyxa0j7c4L
 9IKiTsj7OQswwytJOiJxu/RubCVOrs6ThM/xKK3aIBG/1QxXYhq2Xq4G518rHKv7wygksRiuJoV
 /zhrA5jyMJJuhxqhXb6QtEbTd4Y6qJXXAvsGJGghYfbyvX3SJxzKXl4ENylRoF5rxSl+N+sq/m6
 nJOEK4Z1umMsrOZF//lm+Z5AsEYg1oTGw7MDe/oGgBdUuU9o8xlNWHieKLuGf5/7Ca0ehiCzXDA
 1Anr4gCbOkgoEppToEIqbAhyiZZjnf9K23tECt4rPoMvwrEJCCjS37zvc19PSMh3ppSpcmQIGJc
 X/7Vny9foeqHuwn04Lyj0dkV3wcZFgEaBdcwcz0zp8ZHbHWqHxOWf92LKhKrh4roo4XxEfbeJe7
 Lo=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move proc_doulongvec_ms_jiffies_minmax to kernel/time/jiffies.c. Create
a non static wrapper function proc_doulongvec_minmax_conv that
forwards the custom convmul and convdiv argument values to the internal
do_proc_doulongvec_minmax. Remove unused linux/times.h include from
kernel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/jiffies.h |  2 ++
 include/linux/sysctl.h  |  5 +++--
 kernel/sysctl.c         | 41 ++++++++++++-----------------------------
 kernel/time/jiffies.c   | 27 ++++++++++++++++++++++++++-
 4 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 09886dcbf718873adf3c24d7eb565f1849fcac04..2687263c31d9b0d575996228d9aa63071bea60b5 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -619,5 +619,7 @@ int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
 				 void *buffer, size_t *lenp, loff_t *ppos);
 int proc_dointvec_ms_jiffies(const struct ctl_table *table, int dir, void *buffer,
 			     size_t *lenp, loff_t *ppos);
+int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
+				      void *buffer, size_t *lenp, loff_t *ppos);
 
 #endif
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 4894244ade479a84d736e239e33e0a8d3a0f803d..9396bb421cd5e1e9076de0c77c45a870c453aee1 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -193,8 +193,9 @@ int proc_douintvec_minmax(const struct ctl_table *table, int write, void *buffer
 int proc_dou8vec_minmax(const struct ctl_table *table, int write, void *buffer,
 			size_t *lenp, loff_t *ppos);
 int proc_doulongvec_minmax(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int, void *,
-		size_t *, loff_t *);
+int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
+				void *buffer, size_t *lenp, loff_t *ppos,
+				unsigned long convmul, unsigned long convdiv);
 int proc_do_large_bitmap(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_do_static_key(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e00dd55487025fa159eac2f656104c0c843b0519..6750ddbc15b2bb9ee9de0d48ac999a4c3a2ec5d6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -13,7 +13,6 @@
 #include <linux/highuid.h>
 #include <linux/writeback.h>
 #include <linux/initrd.h>
-#include <linux/times.h>
 #include <linux/limits.h>
 #include <linux/syscalls.h>
 #include <linux/capability.h>
@@ -824,6 +823,14 @@ static int do_proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 	return err;
 }
 
+int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
+				void *buffer, size_t *lenp, loff_t *ppos,
+				unsigned long convmul, unsigned long convdiv)
+{
+	return do_proc_doulongvec_minmax(table, dir, buffer, lenp, ppos,
+					 convmul, convdiv);
+}
+
 /**
  * proc_doulongvec_minmax - read a vector of long integers with min/max values
  * @table: the sysctl table
@@ -843,31 +850,7 @@ static int do_proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_doulongvec_minmax(table, dir, buffer, lenp, ppos, 1l, 1l);
-}
-
-/**
- * proc_doulongvec_ms_jiffies_minmax - read a vector of millisecond values with min/max values
- * @table: the sysctl table
- * @dir: %TRUE if this is a write to the sysctl file
- * @buffer: the user buffer
- * @lenp: the size of the user buffer
- * @ppos: file position
- *
- * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
- * values from/to the user buffer, treated as an ASCII string. The values
- * are treated as milliseconds, and converted to jiffies when they are stored.
- *
- * This routine will ensure the values are within the range specified by
- * table->extra1 (min) and table->extra2 (max).
- *
- * Returns 0 on success.
- */
-int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
-				      void *buffer, size_t *lenp, loff_t *ppos)
-{
-	return do_proc_doulongvec_minmax(table, dir, buffer,
-					 lenp, ppos, HZ, 1000l);
+	return proc_doulongvec_minmax_conv(table, dir, buffer, lenp, ppos, 1l, 1l);
 }
 
 int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
@@ -1075,8 +1058,9 @@ int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 	return -ENOSYS;
 }
 
-int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
-				      void *buffer, size_t *lenp, loff_t *ppos)
+int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
+				void *buffer, size_t *lenp, loff_t *ppos,
+				unsigned long convmul, unsigned long convdiv)
 {
 	return -ENOSYS;
 }
@@ -1192,5 +1176,4 @@ EXPORT_SYMBOL(proc_dointvec_minmax);
 EXPORT_SYMBOL_GPL(proc_douintvec_minmax);
 EXPORT_SYMBOL(proc_dostring);
 EXPORT_SYMBOL(proc_doulongvec_minmax);
-EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
 EXPORT_SYMBOL(proc_do_large_bitmap);
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 2289c11c8bfc218304a620a3541109e281b4e581..5fa02fa8d3f45051d8fbbade783e999e9b29a399 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -190,6 +190,7 @@ int proc_dointvec_ms_jiffies(const struct ctl_table *table, int dir, void *buffe
 	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
 				  do_proc_int_conv_ms_jiffies);
 }
+EXPORT_SYMBOL(proc_dointvec_ms_jiffies);
 
 int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 			  void *buffer, size_t *lenp, loff_t *ppos)
@@ -197,5 +198,29 @@ int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
 				  do_proc_int_conv_ms_jiffies_minmax);
 }
-EXPORT_SYMBOL(proc_dointvec_ms_jiffies);
+
+/**
+ * proc_doulongvec_ms_jiffies_minmax - read a vector of millisecond values with min/max values
+ * @table: the sysctl table
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: file position
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
+ * values from/to the user buffer, treated as an ASCII string. The values
+ * are treated as milliseconds, and converted to jiffies when they are stored.
+ *
+ * This routine will ensure the values are within the range specified by
+ * table->extra1 (min) and table->extra2 (max).
+ *
+ * Returns 0 on success.
+ */
+int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
+				      void *buffer, size_t *lenp, loff_t *ppos)
+{
+	return proc_doulongvec_minmax_conv(table, dir, buffer, lenp, ppos,
+					   HZ, 1000l);
+}
+EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
 

-- 
2.50.1



