Return-Path: <linux-fsdevel+bounces-66734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB28C2B5F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39FBC4F5A2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECA63043C1;
	Mon,  3 Nov 2025 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLdXqD5l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6B303CA0;
	Mon,  3 Nov 2025 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169230; cv=none; b=sdBRIUpisf+ELDfwlO3Z2k3XKVr295zPqudx0IK3UHeskypaW4xKttgETZAh+vMB4XqzdgNogz1taHcAnJJD8wGa3EgaVPEbwYGQZ4ktAegiLCLDAzFUEX6HRQaOQZTAbim6BVEbeghtIYCa1QmjueL10Jz8BxWQBWYWXlZVve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169230; c=relaxed/simple;
	bh=7XvDmuLKWtrG8tCoP/2+H/Ukc4K30gpuVQ4WPA2E0lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DMh8KZmLAxtFN+2x6KRRpwaijoyPkedLxPBWNC0E1omBxVo2ntLixsBajvZmSoy5M/aRLoJ2LeR98l0+hI8QS+w0SHAZv7WSJ7wit+yLHQHy7+b5eCxRdkc39/JBwiU5C+I0UGf42BSJUQBJ1LbjrCQ7ipHX8a/S5gCpwAHxPtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLdXqD5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE21C4CEFD;
	Mon,  3 Nov 2025 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169230;
	bh=7XvDmuLKWtrG8tCoP/2+H/Ukc4K30gpuVQ4WPA2E0lk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jLdXqD5l4Xp7KDST1IF1JQXGHsTch3QsJa+I3ofzc8gfQryyrnneR8N/I6s7hKetC
	 BFrHmiKj1wdpeC76SqGIPoko1Km7hHPkR0s1O3NaEryoOEda10C0l3Fz+TrAzfOIVL
	 E9+YjcIznWS82YD3+WBJDVthx0MkS94g4YuBBDOb1Hb2HKaMQ3z3ZcxhiswtBXTOq0
	 BuAIU/8QYb7SPzY6cnnnMtzMvkGBLGVtaPAstqThfphVP0+oJ6AaodsxzoBrXjnQi5
	 GkRonLkT/Ce79Z7YJzgDK1vTNBiRvcvNm5/AE18gfxbiG1Hlg30QV94YkWb+3I9XJK
	 GnVL/AHRfZe4g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:49 +0100
Subject: [PATCH 01/16] cred: add {scoped_}with_creds() guards
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-1-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7XvDmuLKWtrG8tCoP/2+H/Ukc4K30gpuVQ4WPA2E0lk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGxfdtUr4Hmjparc28LU2KdX86XOvFbRTs9PTr24I
 aZh6+HjHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNRSmb4p7WoYI2EzgP+yo22
 DCdF9vvXv9HlX3Re1yzg203+Q0unuzAyXGhTWzeVqc786WudX0Y3/2ROOMlg5ekSOSkveqPHDt1
 UdgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

and implement with_kernel_creds() and scoped_with_kernel_creds() on top
of them.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cred.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index c4f7630763f4..1778c0535b90 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -192,11 +192,15 @@ DEFINE_CLASS(override_creds,
 	     revert_creds(_T),
 	     override_creds(override_cred), const struct cred *override_cred)
 
-#define with_kernel_creds() \
-	CLASS(override_creds, __UNIQUE_ID(cred))(kernel_cred())
+#define with_creds(cred) \
+	CLASS(override_creds, __UNIQUE_ID(label))(cred)
 
-#define scoped_with_kernel_creds() \
-	scoped_class(override_creds, __UNIQUE_ID(cred), kernel_cred())
+#define scoped_with_creds(cred) \
+	scoped_class(override_creds, __UNIQUE_ID(label), cred)
+
+#define with_kernel_creds() with_creds(kernel_cred())
+
+#define scoped_with_kernel_creds() scoped_with_creds(kernel_cred())
 
 /**
  * get_cred_many - Get references on a set of credentials

-- 
2.47.3


