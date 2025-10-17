Return-Path: <linux-fsdevel+bounces-64419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F95BE7334
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8013F5E32E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EC02BE62D;
	Fri, 17 Oct 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuNhT99h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E05C299AAF;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689990; cv=none; b=K8woLtn+a1yWRMhqK41DRE9YHB2LDFlcrZJh8HiXpw2fUeHCSL100CfrMTb5WTJSjwT6rPseHOsyyKhXtM4PXNiteXUsIsAaZeLjKZTRrxfNEgpwrWD8ZUYmjCuH3SLvaEBkUmfHZxsA7NYiz0u0sOtP5d+tHMUcgjDGseBmZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689990; c=relaxed/simple;
	bh=62Ezf+MMoxaxr6Uds+Kh8ORxtthu1fTbCWYlsyLGDk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jh/+TmG3PjyaO8NWJiK6B5QW4LCle8thGG1OULN7JY1aIVkJo6epa9uNmjkjPO6/3EWnJE8YuaTa2f2d4s+FhJGXPbf44FifZlkY+Hl+xJI8uh46tcgjO5t5gVh85CzHy1zIOqKtC7BAg5MRPMz777XhSmythlR+wTwmn99gPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuNhT99h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0198C4CEFE;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760689989;
	bh=62Ezf+MMoxaxr6Uds+Kh8ORxtthu1fTbCWYlsyLGDk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UuNhT99hd4VHpYVGyyRQqIkt9AmpOi7TQeolzf4FVFo3rmwySwJx2Tax+UJnd5n3o
	 45ihYDTb9jQAiDPusHtmoRXRzQgvNd22kNVIP+K3+DN0Driki9ynDpz0fYC0ZutfWl
	 jlPX+DduRl0ruEVI3swq0aFF4sGKiIOGNQR1UUfF9+X6WpSOKz3uJnALMt9nn2wn6Z
	 druwbjy8bVPbwUY6J3s4owXkUO6X+nDk3WTnFnsY5G9UGk23O87mWK+ruC/RjnarZN
	 ohX0CDQnUU0lXaa9rpig1aibih1/R1sXUeM/toi44D2iQsZsDrfkaUHGlImLBmzQwP
	 g+GBoFhJW6+ZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF5DCCD195;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 17 Oct 2025 10:32:11 +0200
Subject: [PATCH 1/7] sysctl: Allow custom converters from outside sysctl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-jag-sysctl_jiffies-v1-1-175d81dfdf82@kernel.org>
References: <20251017-jag-sysctl_jiffies-v1-0-175d81dfdf82@kernel.org>
In-Reply-To: <20251017-jag-sysctl_jiffies-v1-0-175d81dfdf82@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4391;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=62Ezf+MMoxaxr6Uds+Kh8ORxtthu1fTbCWYlsyLGDk0=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjx/z9NEUgQEQzHTjm/71z/VPH7DVf7miKo+
 MtN5Ieh8pkeJIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo8f8/AAoJELqXzVK3
 lkFPmAsL/RydnP2jRvrlF7N38ELiPG1k6N7zk5JbfzgLHYglKH48TywEaONCNKqjyi5NHm4pKKw
 GwVZ0BsDYsDTi4xEDDhIqjF3b7afOzlZc9zw+GEbLtgvlVzEcIBgc/63G4eNm7eiCP4tR6VIjGz
 YR4I7gbZx4kjCL+ZytQTr7yRTmVVQPn3S0TdEKBSjf+dFcyJ4bJxhXVBJ/Yq1Qv5EpF2ibcHowG
 5RXXAs/8E5YohVPmyJN8DifO5lw8/am7+jkLJiwNC8pc0Lotus9A3pBvT73me0oobWXEm8NIpzO
 qK3MZVmc7chn1SNyJ/aFB7r8SoR4xyp8+4ecmGH1iiOgCr1wmRq0t94NX4e7cFPrHlzMsuA0w7V
 95FdJVR4hohx7TpQ3+n2LnzleV8xfaz4J9yuiAJLyynu3cHOx1hCkzQW8fWMAnDyLovq0q/7hxn
 LBeze2V4Qv6vmWk1VsMaO6z2VV5y20zB0+xeYykMBmBUB4ZD7BE6gsDoVZlkcfA9S8FHi7R+VQ5
 sk=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

The new non-static proc_dointvec_conv forwards a custom converter
function to do_proc_dointvec from outside the sysctl scope. Rename the
do_proc_dointvec call points so any future changes to proc_dointvec_conv
are propagated in sysctl.c This is a preparation commit that allows the
integer jiffie converter functions to move out of kernel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/sysctl.h |  4 ++++
 kernel/sysctl.c        | 32 ++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 2d3d6c141b0b0aee21f2708450b7b41d8041a8cb..ecc8d2345006ab12520f2f6ec37379419e9295d4 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -68,6 +68,10 @@ int proc_dostring(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dobool(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 int proc_dointvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
+		       size_t *lenp, loff_t *ppos,
+		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
+				   int dir, const struct ctl_table *table));
 int proc_douintvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dointvec_minmax(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_douintvec_minmax(const struct ctl_table *table, int write, void *buffer,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 55d12d22a3cc476c6595b50100eef53251dac80a..6a6a2a6421f8debf75089548c82374619af32d61 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1005,6 +1005,14 @@ int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 					 lenp, ppos, HZ, 1000l);
 }
 
+int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
+		       size_t *lenp, loff_t *ppos,
+		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
+				   int dir, const struct ctl_table *table))
+{
+	return do_proc_dointvec(table, dir, buffer, lenp, ppos, conv);
+}
+
 /**
  * proc_dointvec_jiffies - read a vector of integers as seconds
  * @table: the sysctl table
@@ -1023,15 +1031,15 @@ int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 int proc_dointvec_jiffies(const struct ctl_table *table, int dir,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
-				do_proc_int_conv_jiffies);
+	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
+				  do_proc_int_conv_jiffies);
 }
 
 int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
-			do_proc_int_conv_ms_jiffies_minmax);
+	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
+				  do_proc_int_conv_ms_jiffies_minmax);
 }
 
 /**
@@ -1054,8 +1062,8 @@ int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
 {
 	if (USER_HZ < HZ)
 		return -EINVAL;
-	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
-				do_proc_int_conv_userhz_jiffies);
+	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
+				  do_proc_int_conv_userhz_jiffies);
 }
 
 /**
@@ -1076,8 +1084,8 @@ int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
 int proc_dointvec_ms_jiffies(const struct ctl_table *table, int dir, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
-				do_proc_int_conv_ms_jiffies);
+	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
+				  do_proc_int_conv_ms_jiffies);
 }
 
 /**
@@ -1307,6 +1315,14 @@ int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 	return -ENOSYS;
 }
 
+int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
+		       size_t *lenp, loff_t *ppos,
+		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
+				   int dir, const struct ctl_table *table))
+{
+	return -ENOSYS;
+}
+
 int proc_do_large_bitmap(const struct ctl_table *table, int dir,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {

-- 
2.50.1



