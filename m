Return-Path: <linux-fsdevel+bounces-64423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676D1BE7349
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF70F42715B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E202D3228;
	Fri, 17 Oct 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A291P+Ha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118A29D279;
	Fri, 17 Oct 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689990; cv=none; b=IbzLXCRZej85dbXzDU681R+Xsf/R0dzPBGIUA+BciLZxVi612+gmBBx3/i673HeAdQ8oaYavaGfsrvYf/2pm318vakdO0N0BAkINkZenOIbBLEiHAI7x9UBDd+22fRH8ZrBmAXy5SXaoGFuPK1IMcSIabCdUNy9ccR6vWlTo0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689990; c=relaxed/simple;
	bh=mWqfj7aYT75N2bYxpf3Zo3oTUcwgYuFyt3SBJHq02zU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgd0g0bpO0Q+L39j8XZII4JbP72RJTpToJ0GBokS8euW3A+0FLTYbKHut39nH2bDPjbECC90XCSWAFGMocX7qgIEPq8usqb11FDbffnf6OEPPSYYbhLPuCH7JbFOuP3X7HEQuppoyJLa2mNx0weR6U3LgIIsEnN1hIDHZ+mqX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A291P+Ha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7E8CC19423;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760689990;
	bh=mWqfj7aYT75N2bYxpf3Zo3oTUcwgYuFyt3SBJHq02zU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A291P+HaWmzhovKlH5FzS7qpOOMNXOBfMWGlL48Phw367hy+ALK0oINmkx4Ld/KKr
	 v0itTRnFL5CCcQfIE97hc8JWGqFKX5YGDIkJvFfvScj9nwRyfOhbciNbvx/QjwR0fD
	 xXKoUiKqESVM4xVBxzc1YQEOEfr4aLdvo+fkqjCPg3VJbjIjZKmGjiHP1nPbphKxI+
	 Uv/jdj0AfhaR71suXwGBZpVe9utxtbMZAjCbP1sJ1CQJkf8AGolrntBqBjnhEyOU4H
	 46EPyNpAqdSkboTj5uF1RysPl5Y2EaFN844NqY/QPU1wi9o3yPSL97s5fPSA+7E5y5
	 72GVlg64tzRbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6F1CCD1A2;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 17 Oct 2025 10:32:17 +0200
Subject: [PATCH 7/7] sysctl: Wrap do_proc_douintvec with the public
 function proc_douintvec_conv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-jag-sysctl_jiffies-v1-7-175d81dfdf82@kernel.org>
References: <20251017-jag-sysctl_jiffies-v1-0-175d81dfdf82@kernel.org>
In-Reply-To: <20251017-jag-sysctl_jiffies-v1-0-175d81dfdf82@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4508;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=mWqfj7aYT75N2bYxpf3Zo3oTUcwgYuFyt3SBJHq02zU=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjx/0NSnPuToqzCq4T5K/jyOYgldzU5gArb+
 vrMeqWF6yqYZYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo8f9DAAoJELqXzVK3
 lkFPDCML/jLcbIA2ClNcrGBP7q/cygtYLu+PcglKO4jiAc1Ay3kVzqDBAHJ5gFZYBPgt2WI5oxa
 tEkZ8rJAS7RgDHZ0jeTmZ9S33WGhNpq5SJmXWxKA9y5jzDGMic/CcynRnWVoV9nTTjlB2zuC2kX
 U54r0bz2Ke13wavvnofxB2WOEZSFMQ8fwhztwbqY2PrYstl/2/qTOefj/8SIMI38FuUVGsn0IV6
 G7DUmQ55oB/A0Lj7T28aSp7QvZ7WKEEcZILTIircuoXN/ABUBv5YpW1KZD5T4Ig/Tp3EcfDLj6q
 sueCceVRPkHvT57cuJM0gI7AltS//2+0J7zPVGqhyBB/s7stZ0h+Wby4yxTcFzVdKq+FAU2lGTu
 e0L6ujAkwE6JhdZ94SlSqNigWqNRWB6WrHyGFgfu2d8i4wXC9DRTp1gCLqsP9O9fPrkprPxPgCK
 bGWMepboVTVxIMw8eEA7R/rmOpZYdcRmzH3CCvr3pPlJVBDfqHOxhLGfLTNNCtWVOHN/KNFaaW6
 gM=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Make do_proc_douintvec static and export proc_douintvec_conv wrapper
function for external use. This is to keep with the design in sysctl.c.
Update fs/pipe.c to use the new public API.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 fs/pipe.c              |  4 ++--
 include/linux/sysctl.h | 13 +++++++------
 kernel/sysctl.c        | 18 ++++++++++++++----
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 974faf06a3136fff7a382e575514d84fcf86183c..59b60a9374e671f7e129f5ebfde066c1756c00b3 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1487,8 +1487,8 @@ static SYSCTL_UINT_CONV_CUSTOM(_pipe_maxsz,
 static int proc_dopipe_max_size(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_douintvec(table, write, buffer, lenp, ppos,
-				 do_proc_uint_conv_pipe_maxsz);
+	return proc_douintvec_conv(table, write, buffer, lenp, ppos,
+				   do_proc_uint_conv_pipe_maxsz);
 }
 
 static const struct ctl_table fs_pipe_sysctls[] = {
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ee5e2b3f47db834b084ac0fc4108bf28177b6949..727dfc7771de1b7a562e9b930f6851873574b532 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -183,14 +183,20 @@ int proc_dostring(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dobool(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 int proc_dointvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_dointvec_minmax(const struct ctl_table *table, int dir, void *buffer,
+			 size_t *lenp, loff_t *ppos);
 int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
 		       size_t *lenp, loff_t *ppos,
 		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
 				   int dir, const struct ctl_table *table));
 int proc_douintvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_dointvec_minmax(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_douintvec_minmax(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
+int proc_douintvec_conv(const struct ctl_table *table, int write, void *buffer,
+			size_t *lenp, loff_t *ppos,
+			int (*conv)(unsigned long *lvalp, unsigned int *valp,
+				    int write, const struct ctl_table *table));
+
 int proc_dou8vec_minmax(const struct ctl_table *table, int write, void *buffer,
 			size_t *lenp, loff_t *ppos);
 int proc_doulongvec_minmax(const struct ctl_table *, int, void *, size_t *, loff_t *);
@@ -349,11 +355,6 @@ extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
 bool sysctl_is_alias(char *param);
-int do_proc_douintvec(const struct ctl_table *table, int write,
-		      void *buffer, size_t *lenp, loff_t *ppos,
-		      int (*conv)(unsigned long *lvalp,
-				  unsigned int *valp, int write,
-				  const struct ctl_table *table));
 
 extern int unaligned_enabled;
 extern int no_unaligned_warning;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d2e756ee3717b07fd848871267656ee0ed7d9268..b7c0c78417020d9c7525d4e542be79e8e61bb88a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -534,10 +534,11 @@ static int do_proc_douintvec_r(const struct ctl_table *table, void *buffer,
 	return err;
 }
 
-int do_proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
-		      size_t *lenp, loff_t *ppos,
-		      int (*conv)(unsigned long *u_ptr, unsigned int *k_ptr,
-				  int dir, const struct ctl_table *table))
+static int do_proc_douintvec(const struct ctl_table *table, int dir,
+			     void *buffer, size_t *lenp, loff_t *ppos,
+			      int (*conv)(unsigned long *u_ptr,
+					  unsigned int *k_ptr, int dir,
+					  const struct ctl_table *table))
 {
 	unsigned int vleft;
 
@@ -566,6 +567,15 @@ int do_proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
 	return do_proc_douintvec_r(table, buffer, lenp, ppos, conv);
 }
 
+int proc_douintvec_conv(const struct ctl_table *table, int dir, void *buffer,
+			size_t *lenp, loff_t *ppos,
+			int (*conv)(unsigned long *u_ptr, unsigned int *k_ptr,
+				    int dir, const struct ctl_table *table))
+{
+	return do_proc_douintvec(table, dir, buffer, lenp, ppos, conv);
+}
+
+
 /**
  * proc_dobool - read/write a bool
  * @table: the sysctl table

-- 
2.50.1



