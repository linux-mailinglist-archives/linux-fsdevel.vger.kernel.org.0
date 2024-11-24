Return-Path: <linux-fsdevel+bounces-35692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9CE9D72E2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBE4286245
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE6320C027;
	Sun, 24 Nov 2024 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YipDC/g/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22620C017;
	Sun, 24 Nov 2024 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455891; cv=none; b=K7r3kQ+HFK35fwPTk8D82Oa1ln3At7lON7BArjiMUOmaZIN5u9XfyjfBw6TixikyGA6UOYaDNH9BupoGB7xv2N9N+v/6KHU/MhGcH+5B/v5unkp+DqDDhmAhdkU8NaY3TYL/6PUnPTV8sQ1P0y2ABAJzEI2nJ6r78DF05zocXMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455891; c=relaxed/simple;
	bh=nXqY7H+FrDdF1GL8dP3Sq3a9av6/N4Dvi59BVLXNltw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4+3FO/6ac2bUwMm7w1bIznJBEkSITj3fSdYN5Ig4H4a1mXKQOOwqK9a1eQCTb2K3/RycLGER/n5cXcr+JWuyHt4bKkeagTSBWPZ+NVOFhucvcJgTwm2Hlz5gvaU9TqWHm/bzwkY/9dxwV0O5Im4BTbh11EhqQR2DiJwjA0Em50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YipDC/g/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D9BC4CED7;
	Sun, 24 Nov 2024 13:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455891;
	bh=nXqY7H+FrDdF1GL8dP3Sq3a9av6/N4Dvi59BVLXNltw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YipDC/g/bm/CiuXf0ojbRX3epnqq99kdT/SPd/EhKM6b2KSne8Cv8Lt0ohfQoKEDp
	 EMIr4fSKOnkwcEwv2olG03rChXkkPhsABRM2D0b/sSbQT7OxzsE4zAju4hHvX/1sgZ
	 t55dKS2M1zPaNs0gq1hyCN8u0173pBnPkmtGR8G/x05+rMQc2+8nyRHJu3niWvqYHO
	 LpmzVeAAjq4aQSMUPZfEMBM9D047hNIs4Cgdwuk73+S0l+t4IsFnNkdnoor2oiuiJz
	 qrgpsqcxXwGcD3MG13JmxKOOLrSbYM6ziWiZ+nByPmipybca1MrhFYR3vPwbfZTxIu
	 kXuNz700N2hTQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 17/26] open: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:44:03 +0100
Message-ID: <20241124-work-cred-v1-17-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=786; i=brauner@kernel.org; h=from:subject:message-id; bh=nXqY7H+FrDdF1GL8dP3Sq3a9av6/N4Dvi59BVLXNltw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7685/e8y+4PX2VynyE/dwpxwMet3cuO5A1yLZL8mP/ 3RqsCl7d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEcg4jw8P31SdkKn44TosX 53Zi5Wbd8nQqY0D5LQNdiUmuunuT0hgZZv9cfShip8bVs9ctrzfZr7F3ftuir7xQ3Uxj1+2rs0Q sGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/open.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 0a5cd8e74fb9bb4cc484d84096c6123b21acbf16..74ee5e02d68c590475f18f099b188f052f17f555 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -447,13 +447,7 @@ static const struct cred *access_override_creds(void)
 	 * freeing.
 	 */
 	override_cred->non_rcu = 1;
-
-	old_cred = override_creds(get_new_cred(override_cred));
-
-	/* override_cred() gets its own ref */
-	put_cred(override_cred);
-
-	return old_cred;
+	return override_creds(override_cred);
 }
 
 static long do_faccessat(int dfd, const char __user *filename, int mode, int flags)

-- 
2.45.2


