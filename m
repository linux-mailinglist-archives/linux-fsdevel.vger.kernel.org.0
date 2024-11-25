Return-Path: <linux-fsdevel+bounces-35800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD49D9D876D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C702898EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CBD1AF0B8;
	Mon, 25 Nov 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHuHgJD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556401B0F30;
	Mon, 25 Nov 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543828; cv=none; b=UOnpmA8KBUdmqOWYiwhHO71mS5GHqeYE4Tfqmr4aloRTqOKId0uP76aDrBqe4iPsajjl27eaU8wHGffGD3oFjYU/QFShdViFBuFV4RSYPTgHyjWGAtLJg6vDr5QV8qaGKFmw07lBOy1vBQwv31g4B7Tm1Y6yLjm8AK9wewAOoUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543828; c=relaxed/simple;
	bh=SjKEz2+li2uRPamFqPSEXlNbuDaFkAbRJpzDkJXTiBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5w+NTeeaPr+Tu0UvWcBiJoMZy93nvLzcuuUv/0f0ZUDDM1slQe3ZVK7q8KX0zC3EJiYb2F8fXlKorIKQDobYZhcUc3hHshYLgVUYF7z4ghdNvsF0hlswqa/9O3ZBWZLuiW1SkxRarlfZGjvhpmtXOXeaw2QdG/JxtLfdLiz4lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHuHgJD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323B4C4CECF;
	Mon, 25 Nov 2024 14:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543825;
	bh=SjKEz2+li2uRPamFqPSEXlNbuDaFkAbRJpzDkJXTiBM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lHuHgJD1TX58IfXYgJq7eo7Ss0wrhJ2KnZdPwTB0dF5LWyMLyJEYYYC2jsCjRBpXR
	 lFd5ucx3NyHQ3LwGw6Me6Eww4xDsztvEt2NqTONp88AQX2aO03QywYhsTBxYLWQ96w
	 gyR1wqSTGUSR9gOzIv7i+waE8sBEO64OyypSiG108hOPNNtUN/t10zrEf/c0qlTp63
	 fiTZQw88tEd7szlQOwx6uqHspYW80gXMP064V1XARjMGaGPw/nBXtYsK8yuJTeEzcn
	 5cNomuKtaLp2QGmV/xEGuwMCxwzrTbquVi0aYKEoXz4dNQfgmsCGv/Emot/DRfWTwJ
	 AdQeJsn4lga/A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:09:58 +0100
Subject: [PATCH v2 02/29] cred: return old creds from revert_creds_light()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-2-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=899; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SjKEz2+li2uRPamFqPSEXlNbuDaFkAbRJpzDkJXTiBM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHp0bbSay8K/xIbvVA/nzdYDvmVbAtwvBC9+lMUSy
 vFfQGJLRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ+LWb4KzHX6iVzXDPvdE/m
 rhvNn85Zmu756KE/5/17+SIL/gvr4xkZurSOveB88iFSrLDVgeHCtJ2e3LPfPS+dlPItvvtAUV0
 FBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

So we can easily convert revert_creds() callers over to drop the
reference count explicitly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cred.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index b0bc1fea9ca05a26f4fa719f1d4701f010994288..57cf0256ea292b6c981238573658094649c4757a 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -185,9 +185,12 @@ static inline const struct cred *override_creds_light(const struct cred *overrid
 	return old;
 }
 
-static inline void revert_creds_light(const struct cred *revert_cred)
+static inline const struct cred *revert_creds_light(const struct cred *revert_cred)
 {
+	const struct cred *override_cred = current->cred;
+
 	rcu_assign_pointer(current->cred, revert_cred);
+	return override_cred;
 }
 
 /**

-- 
2.45.2


