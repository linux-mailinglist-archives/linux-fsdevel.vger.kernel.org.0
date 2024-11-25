Return-Path: <linux-fsdevel+bounces-35825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A7A9D87A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AF0168F75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A1F1D5AAE;
	Mon, 25 Nov 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6g3Z7bA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C81D54E3;
	Mon, 25 Nov 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543885; cv=none; b=BBkSB+CavV9/M4K95RW7Q4wwrTSrnsrVWFlr6fwOOm/ozghvdMYIuFW2NRiNvUMipHuOr6mBkfTLfnaSXpwIlp2kmFMH8Xga6J7XOK62c2ufxTkERqhog9Z8b1EzNmNzEcubyF3z8uQviCSiN/EdeaEqDRLkX8oLvVDjyMpcQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543885; c=relaxed/simple;
	bh=ARjWYSiY5xbhc+gDInx1b2j3Ejo4R74q3V4Z4Ao+Up4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcEFcvrkwCt15S781wM1KwbkKvt/fdcP8wdcvTeP2RlLyUyIjekkVx3kwUUzxZysvezaxG/Ezv1fSLOsbnewnsJPdjKNaIJfMpb1/nIae+fpvc/uX341VecYZN3Q6lLDp5O73HlcA1kVacdJOhLNzCfcVlfz0rTfg4fvW0TrIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6g3Z7bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1D6C4CECE;
	Mon, 25 Nov 2024 14:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543885;
	bh=ARjWYSiY5xbhc+gDInx1b2j3Ejo4R74q3V4Z4Ao+Up4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W6g3Z7bAshjUiLpnsfedyLH5juXVvHnYT4/FzcVri9y8xxzOu9aIZgMfH4TehzLD3
	 o8uAXGWE2+F9jby4L+nY/UOpjPPEyUOaBb+v5/PxRCPme6krMKhq6WiaT5Yo8MAujq
	 HJq9ZNHCaIsB8L7LfNIj4Hs0ftaaqZVJovcN5h+OUIRhc74OCtW1eCXZ4Df8p0nscl
	 e7HGU/glSZNG95UKRO8MyQssJd9KboiTgQGOdRbna28aq6FhVO1T4NVj9VRMqznGpx
	 sJCW+CpQzCl6dfMd2sN1ssmr4fEaNS8GW/X/IaVKQNGbZFFfPrOHtLn4klkCndXb1u
	 hdPs+ko4yEhhA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:24 +0100
Subject: [PATCH v2 28/29] nfsd: avoid pointless cred reference count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-28-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=746; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ARjWYSiY5xbhc+gDInx1b2j3Ejo4R74q3V4Z4Ao+Up4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHpNOJilMfEo63yX/IzC3UFfVspHHfkuKn4ufnZUS
 ev0z+5dHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5GsfwV+Bu6okdpzQfdzr9
 7CtQnrWW9ZxfTu+EMuOpJx1ePhdc48XI8Oi9vbfZKW7u46FcMxdO5X209d7igitv11za1C1sunr
 jGhYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The code already got rid of the extra reference count from the old
version of override_creds().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfsd/auth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/auth.c b/fs/nfsd/auth.c
index c399a5f030afbde6ad7bc9cf28f1e354d74db9a8..4dc327e024567107ac8b08828559c741e0bc89d6 100644
--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -79,8 +79,7 @@ int nfsd_setuser(struct svc_cred *cred, struct svc_export *exp)
 	else
 		new->cap_effective = cap_raise_nfsd_set(new->cap_effective,
 							new->cap_permitted);
-	put_cred(override_creds(get_new_cred(new)));
-	put_cred(new);
+	put_cred(override_creds(new));
 	return 0;
 
 oom:

-- 
2.45.2


