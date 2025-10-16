Return-Path: <linux-fsdevel+bounces-64376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6112DBE38E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 14:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C34F585B6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698A7338F21;
	Thu, 16 Oct 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAvygFza"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24A3375A2;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619500; cv=none; b=Az3TVds08b7FPA28mJTtVuxDrSsmQrC2U+SafRoZTeBbxito3M/cMy3ijXQQ4cqEh+e5ecE8qbBC+6/OK0rLuPmy8RmCZbklpv7KfapYPZ5W2WUT0KfdtSGvN3WwecCPPOuO9vqYx12iHFzHDisytMULb3Q2tzVlvybY/9L7WXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619500; c=relaxed/simple;
	bh=xP7pIUDrYB9KQ96n73WKDlnF/Xja1RjBW7d+EpQMu6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HiVYLkm4n5w6eqNJR9irphiCQfoIGYT0PWjUh26IVjCFEgwNrary7t02eO15E+38UYBYPWzEn4WWQomBWg10L/xvkkilPvTBLHPOeQpjp198ocAQPrOWnI2VtKEijFI7VtVdw0MX8ymNvOwuRhV63hfb/Xu5E4qArFStjU9dVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAvygFza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6186C113D0;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760619499;
	bh=xP7pIUDrYB9KQ96n73WKDlnF/Xja1RjBW7d+EpQMu6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rAvygFzarRinD4LwRTf47yq/cPKw0bTbsKRZiLjn4Fx31xSSqlyfi3hpstYOfMlyL
	 uHONtz7p4u1l4EsCYIGu04Z7ETt2o0SNzS3XOKlzx5Fu5ewRgNlsZhlzjrHPo4I9pP
	 gaYcUu3XoIoS1V94IQqSfDp7raHA0ObWKOOj+uDOLbC61h62cAyCbVqbG4kcPCmMWl
	 V3lpJ0AM/2VLZPe2FhmbbKfypStR5QYouqpxGNUpTKYYdLqatmsTFhSYeqCuVIZHDr
	 NlqnxhKn0Iop3IlgX5mqgeVZ3yZKzYjs9Ydc/PHKd1mfGTW/d6K3PIItcWuZovrl8/
	 qqdWIRFXKMoVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE73ACCD19A;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 16 Oct 2025 14:57:57 +0200
Subject: [PATCH v2 11/11] sysctl: Create macro for user-to-kernel uint
 converter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-jag-sysctl_conv-v2-11-a2f16529acc4@kernel.org>
References: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
In-Reply-To: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=xP7pIUDrYB9KQ96n73WKDlnF/Xja1RjBW7d+EpQMu6M=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjw6+har3JgRhpb7X+yT2YZZPpLBCCBReffZ
 4u3JcnC1qd+QYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo8OvoAAoJELqXzVK3
 lkFPC0wL/2nGgxIGHWL6XlsbrXL1jKFc+w1KHAEWTglDc1POPTTpP0zMycx8vI8WergoKcGZm0a
 8aT2lbab9gWuYsWRK4OQKgIZtfFNKmVNza80mg6bwPVMvOe8UFUWasZDXxWkhUqND35JfHebMET
 HxjVwILebsi/RFWCkyjpqRdcWUESrGwWQ7jxUj4087BkUmtZ2LXt8FUGTyIUxVktZltIUtHwtm0
 cXQIrDUtT7Dt646yB/2LioExvw64/q68vWZGXmCMoz6r1lHFBRLwaL2DrrezclwqRPjNcAYZVeA
 HjiI9bG5e2y7mOOYP0ZLpbvkobJzMVBDVjNJuPXv6rLy8wTBjXE52k7Uj/uXf/j+IuLB57uANrG
 Wxk66e3TUicvF0V3XVEwHeGrY4oTDt4TQeP6jhhwvfBQ5Uh2cjq+EhxJeVvlgrwmTNLejWIc5Ac
 c3oyCTpJpMF2SGQW3W+ClMH2oAwoKENliAh1ow2rgFEGsdBDPUKSuepPQ6ShlEGg0UnHEDjBiw5
 qI=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Replace sysctl_user_to_kern_uint_conv function with
SYSCTL_USER_TO_KERN_UINT_CONV macro that accepts u_ptr_op parameter for
value transformation. Replacing sysctl_kern_to_user_uint_conv is not
needed as it will only be used from within sysctl.c. This is a
preparation commit for creating a custom converter in fs/pipe.c. No
Functional changes are intended.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 750c94313c1fd23551e03f455585d2dd94f3c758..9b08573bbacdfa0ec036a8043561253c21300c9a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -462,15 +462,19 @@ static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies_minmax,
 			      sysctl_user_to_kern_int_conv_ms,
 			      sysctl_kern_to_user_int_conv_ms, true)
 
-static int sysctl_user_to_kern_uint_conv(const unsigned long *u_ptr,
-					 unsigned int *k_ptr)
-{
-	if (*u_ptr > UINT_MAX)
-		return -EINVAL;
-	WRITE_ONCE(*k_ptr, *u_ptr);
-	return 0;
+#define SYSCTL_USER_TO_KERN_UINT_CONV(name, u_ptr_op)		\
+int sysctl_user_to_kern_uint_conv##name(const unsigned long *u_ptr,\
+					unsigned int *k_ptr)	\
+{								\
+	unsigned long u = u_ptr_op(*u_ptr);			\
+	if (u > UINT_MAX)					\
+		return -EINVAL;					\
+	WRITE_ONCE(*k_ptr, u);					\
+	return 0;						\
 }
 
+static SYSCTL_USER_TO_KERN_UINT_CONV(, SYSCTL_CONV_IDENTITY)
+
 static int sysctl_kern_to_user_uint_conv(unsigned long *u_ptr,
 					 const unsigned int *k_ptr)
 {

-- 
2.50.1



