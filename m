Return-Path: <linux-fsdevel+bounces-64371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 219F8BE38BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 14:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94E754F8347
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B7337693;
	Thu, 16 Oct 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZsVtwWk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17E3335BB4;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619499; cv=none; b=KJmpEN+Pq6JQev3EnMNtZIvkpbKtMHz7T++ct1d82ERiFP0iEibs+4cyLaMwYe5yjZwG9kJCf0HJbwBM7ddJ6e3XtUI3Tm8OBBFHdNMf8TRcGZ6kRn46xHf0TBm2xIDZTstqRrl60ricR+2zRNm/nZxVsz4Md06zRPjrjPiHYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619499; c=relaxed/simple;
	bh=bFforyaMLZ60YaWnxL6G/HX0VwXmPBjbbd+0+NWBvM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CASrWFCgBTD4Vrrvc6NBEVNCN0R0HEiNpw3WxpJb3WACjGll75gGP4OFWN7pw+2RN+BTIPlgmxzCdHjUpbtJEsRaQco/+MjYlBDWIkzJP9m69DoqXjv208D8kDWyWEuYq4x4HWCtJdmL7zwIX+DyBxXBj8c5xfsOd6vPFAQH2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZsVtwWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE746C19424;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760619499;
	bh=bFforyaMLZ60YaWnxL6G/HX0VwXmPBjbbd+0+NWBvM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cZsVtwWkl4C/fbux0giecztiL9gMB/jl9Bomv5sDc1yQ2m7aUHdL3Ta/K/80HuWd/
	 SovwbGvZ6Tx8HQiJ83q2KFbUx4cdRk1gwfbsLXBOxAIHtJDxeu/2GvJ/5IY9gDJQYz
	 iN0iUujm3wUICdyFBi2QqAhH6LKxUjOgl+Xs9JcVcpg9q9e0u50I6bOi3F9aqtAp3A
	 +ovf+3P2+vKl/V0zyaxkz0K1gplJiFLBbEISesQwtyqE+WtSlG+nusXqQPDjT+3L2M
	 QAlQiaYq3uD1Q5vXjB3Qe6dO5NBKr5fkcD+rLz+3YzuhqwBm+h/WH9KMkjP2+uUOfc
	 khW0ortl2yqAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FCFCCD199;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 16 Oct 2025 14:57:55 +0200
Subject: [PATCH v2 09/11] sysctl: Create unsigned int converter using new
 macro
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-jag-sysctl_conv-v2-9-a2f16529acc4@kernel.org>
References: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
In-Reply-To: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3248;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=bFforyaMLZ60YaWnxL6G/HX0VwXmPBjbbd+0+NWBvM4=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjw6+eyf6O1KoCOlnPYcVu+O6SYEqzjwoQcu
 QvBNyhWJIHxlYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo8OvnAAoJELqXzVK3
 lkFPhVkMAJEs0X7xu7EaiWHJtEJPStbnKXiHmlkjBNMsCRcBDn7UZqKfRK7YPBxwcUkH++u3cti
 zt+TwAjIMjia4IxCmXOQh/CNm/Ys9TP1nXtnkyZ6FJfucQC+LnIEgDs9Y8KgB3BwS6lY+T9zz1k
 xvBnXBufDofsFT4QAQZH9qZqpbrgCMevOin26wRpMunfK/xHviTk3YwCtPXrWAetIb1z+GP+73L
 gfq1g0wApX7/eNjB9VYs5pUgq/vyzKGz8CAn/1YllIo4WEuEx3pK2ABKlFcO9Oo5KwvAVOIJ6RM
 tRBTyII1N+zYccMrwY36xXnd/v5mQeeZSe7doyAKo03vKR2GS9kdmbHbeSO7kb2ezQXtfPIOAA0
 u+nGb0/TJVcXvDn+zIQXwINUW9Oeht7V8JpQOwQFTjHOLFGxtlXggmztkuR5f/2TPzUM0Lola9S
 I3W8ZZ+Nb3WrRlTWIW+MgMcc0iQlBXZ6kQcUXAoYjSDjXXBuBuW3oAZJFMCHp7Pff/AXkkLgBr6
 wA=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Pass sysctl_{user_to_kern,kern_to_user}_uint_conv (unsigned integer
uni-directional converters) to the new SYSCTL_UINT_CONV_CUSTOM macro
to create do_proc_douintvec_conv's replacement (do_proc_uint_conv).

This is a preparation commit to use the unsigned integer converter from
outside sysctl. No functional change is intended.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 60f7618083516a24530f46f6eabccd108e90c74f..ca657d1bb958060ba72118aa156a43f8a64607eb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -462,24 +462,37 @@ static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies_minmax,
 			      sysctl_user_to_kern_int_conv_ms,
 			      sysctl_kern_to_user_int_conv_ms, true)
 
-static int do_proc_douintvec_conv(unsigned long *u_ptr,
-				  unsigned int *k_ptr, int dir,
-				  const struct ctl_table *table)
+#define SYSCTL_UINT_CONV_CUSTOM(name, user_to_kern, kern_to_user)	\
+int do_proc_uint_conv##name(unsigned long *u_ptr, unsigned int *k_ptr,	\
+			   int dir, const struct ctl_table *tbl)	\
+{									\
+	if (SYSCTL_USER_TO_KERN(dir))					\
+		return user_to_kern(u_ptr, k_ptr);			\
+	return kern_to_user(u_ptr, k_ptr);				\
+}
+
+static int sysctl_user_to_kern_uint_conv(const unsigned long *u_ptr,
+					 unsigned int *k_ptr)
+{
+	if (*u_ptr > UINT_MAX)
+		return -EINVAL;
+	WRITE_ONCE(*k_ptr, *u_ptr);
+	return 0;
+}
+
+static int sysctl_kern_to_user_uint_conv(unsigned long *u_ptr,
+					 const unsigned int *k_ptr)
 {
-	if (SYSCTL_USER_TO_KERN(dir)) {
-		if (*u_ptr > UINT_MAX)
-			return -EINVAL;
-		WRITE_ONCE(*k_ptr, *u_ptr);
-	} else {
-		unsigned int val = READ_ONCE(*k_ptr);
-		*u_ptr = (unsigned long)val;
-	}
+	unsigned int val = READ_ONCE(*k_ptr);
+	*u_ptr = (unsigned long)val;
 	return 0;
 }
 
+static SYSCTL_UINT_CONV_CUSTOM(, sysctl_user_to_kern_uint_conv,
+			       sysctl_kern_to_user_uint_conv)
+
 static const char proc_wspace_sep[] = { ' ', '\t', '\n' };
 
-
 static int do_proc_dointvec(const struct ctl_table *table, int dir,
 		  void *buffer, size_t *lenp, loff_t *ppos,
 		  int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
@@ -660,7 +673,7 @@ int do_proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
 	}
 
 	if (!conv)
-		conv = do_proc_douintvec_conv;
+		conv = do_proc_uint_conv;
 
 	if (SYSCTL_USER_TO_KERN(dir))
 		return do_proc_douintvec_w(table, buffer, lenp, ppos, conv);
@@ -743,7 +756,7 @@ int proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	return do_proc_douintvec(table, dir, buffer, lenp, ppos,
-				 do_proc_douintvec_conv);
+				 do_proc_uint_conv);
 }
 
 /**
@@ -779,7 +792,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *u_ptr,
 	/* When writing to the kernel use a temp local uint for bounds-checking */
 	unsigned int *up = SYSCTL_USER_TO_KERN(dir) ? &tmp : k_ptr;
 
-	ret = do_proc_douintvec_conv(u_ptr, up, dir, table);
+	ret = do_proc_uint_conv(u_ptr, up, dir, table);
 	if (ret)
 		return ret;
 

-- 
2.50.1



