Return-Path: <linux-fsdevel+bounces-71533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E17FCCC6794
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08A773020159
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 08:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF3333891B;
	Wed, 17 Dec 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5sPBtuW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E702C21FA;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958738; cv=none; b=ZC6/Hk4DM6Z4JPotce8Ml+2NajFUR6GQzhFKKSgKV8ZJekc1VgbRbX//TGV5f7mAUdWNO+goZ7Ds24Dx8weZPR7M3uqzTCXFQbBBEuKpx5cKr6TAJbHw2uRVIJg4ud/CoHnxf2hLyZLF7GdJYMnKAFjNZDKKG4/ZaQn0q+YJkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958738; c=relaxed/simple;
	bh=N7Xwq5Z5BoMOd9TzVgbIMWfFv5xGXmLMAU7dBOOPWUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgu+raHc8ZfWeg+E+sfoFWRXNOpsTgpZgfBb+iE5WxOhsyQLrQkY2HAnaYDUqsjR+Edywr/qlp9wPVRFqTU3i56MaPa/OcDh+QMlLTIEHO3RY+dUPOUjdyam0PGAy8UP/wnQEdk/csPF4WizsGKyJzZk3kpj5oqNoSQZbGO/U/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5sPBtuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2FB3C19423;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765958737;
	bh=N7Xwq5Z5BoMOd9TzVgbIMWfFv5xGXmLMAU7dBOOPWUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P5sPBtuWYGyCdZEk4LKzFGtqUpXQ0a11IKu8sNY/LqoU7+Cis6NG73vj81FTbus6Q
	 pULzrY/6AKUsPLmBaz7HaODJ9sgpEnC6OSP6CSNWSf1/Z3xVCu9SSTkY4ZpOzkCvqb
	 8mgmyb+Kpi9plGwczQorxEDqt9//sGc9qoq7xPGE0vfnROgRPH3QONWk5ofE4MUIZL
	 Q9lwYLqYBWvs5RN84ccJVaTtPrKfAK2+I+JDjWivCr0d1Ct5r6fuQw9txgTYOxAiYY
	 3xQWDIAa/nvTTtNTRVY2D0YzwZkWGcnWgbDGYh+LJ63vW1p/hXTWv8bnxTj9pkYJxU
	 9+5T+ObOIdNtA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FA8D6408B;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Wed, 17 Dec 2025 09:04:41 +0100
Subject: [PATCH 3/7] sysctl: Add CONFIG_PROC_SYSCTL guards for converter
 macros
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-jag-no-macro-conv-v1-3-6e4252687915@kernel.org>
References: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
In-Reply-To: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2545;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=N7Xwq5Z5BoMOd9TzVgbIMWfFv5xGXmLMAU7dBOOPWUQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlCZEr9mOFjyMw7gjZmiybtKenWNzwRuobBa
 bpqcMotcuNGKYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpQmRKAAoJELqXzVK3
 lkFPhuEMAJPZlpJwksDL+K9bzUCMVUw7C+m1CEUwWNqhulM302vOjCVfHBgLYQKiaVmyZkYcJxK
 1IZTfJFS1ae864sVGV+QHPD1hdb6e3vCEYC+fxv8gYl7Grnc9ve+m0rt8/OK7YGbIXGzHM+eTP4
 doYXys9S9yolZshNxCcBh8WmicU2FtzSv3xksf18eGLLC77PhMRLIZzZWj39jMg65crYSnA0j0S
 PPx1yph9IJkPucce/rf4nyuZIC5u4n03Xs9OXt9u8fjxfcS9Dm+zyMG+2SKaKRSrj0VwYZSWWCU
 w/JHp/HkHIOP7NRwAvALgVp9ZSgrgq4QKfoeAeHB8ujHoKrp/E9E/Tg1fZuQnwdAlZHfvzC+uBT
 FhAnkKXZYbiCHyhcqd6zWT9Lvn8NabCqIswY9Whu5i3seL/4JSP5+NJzqKuK1veIW2ZOCwuxnLK
 ciLnEctGcy94IfC4tyhvNVWQOekdS90jkpDU4rfQhfCjgSY+11mbAqP4ozBRgQXaOQpuY6TCmg7
 AM=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Wrap sysctl converter macros with CONFIG_PROC_SYSCTL conditional
compilation. When CONFIG_PROC_SYSCTL is disabled, provide stub
implementations that return -ENOSYS to prevent link errors while
maintaining API compatibility.

This ensures converter macros are only compiled when procfs sysctl
support is enabled in the kernel configuration.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/sysctl.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 288fe0055cd5f7bd670a4e9797cc0595f4060e5f..0a64212a0ceb8454ae343831739831a092b6e693 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -73,6 +73,7 @@ extern const int sysctl_vals[];
 #define SYSCTL_USER_TO_KERN(dir) (!!(dir))
 #define SYSCTL_KERN_TO_USER(dir) (!dir)
 
+#ifdef CONFIG_PROC_SYSCTL
 #define SYSCTL_USER_TO_KERN_INT_CONV(name, u_ptr_op)		\
 int sysctl_user_to_kern_int_conv##name(const bool *negp,	\
 				       const unsigned long *u_ptr,\
@@ -173,6 +174,48 @@ int do_proc_uint_conv##name(unsigned long *u_ptr, unsigned int *k_ptr,	\
 	return 0;							\
 }
 
+#else // CONFIG_PROC_SYSCTL
+#define SYSCTL_USER_TO_KERN_INT_CONV(name, u_ptr_op)		\
+int sysctl_user_to_kern_int_conv##name(const bool *negp,	\
+				       const unsigned long *u_ptr,\
+				       int *k_ptr)		\
+{								\
+	return -ENOSYS;						\
+}
+
+#define SYSCTL_KERN_TO_USER_INT_CONV(name, k_ptr_op)		\
+int sysctl_kern_to_user_int_conv##name(bool *negp,		\
+				       unsigned long *u_ptr,	\
+				       const int *k_ptr)	\
+{								\
+	return -ENOSYS;						\
+}
+
+#define SYSCTL_INT_CONV_CUSTOM(name, user_to_kern, kern_to_user,	\
+			       k_ptr_range_check)			\
+int do_proc_int_conv##name(bool *negp, unsigned long *u_ptr, int *k_ptr,\
+			   int dir, const struct ctl_table *tbl)	\
+{									\
+	return -ENOSYS;							\
+}
+
+#define SYSCTL_USER_TO_KERN_UINT_CONV(name, u_ptr_op)		\
+int sysctl_user_to_kern_uint_conv##name(const unsigned long *u_ptr,\
+					unsigned int *k_ptr)	\
+{								\
+	return -ENOSYS;						\
+}
+
+#define SYSCTL_UINT_CONV_CUSTOM(name, user_to_kern, kern_to_user,	\
+				k_ptr_range_check)			\
+int do_proc_uint_conv##name(unsigned long *u_ptr, unsigned int *k_ptr,	\
+			   int dir, const struct ctl_table *tbl)	\
+{									\
+	return -ENOSYS;							\
+}
+
+#endif // CONFIG_PROC_SYSCTL
+
 
 extern const unsigned long sysctl_long_vals[];
 

-- 
2.50.1



