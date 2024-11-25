Return-Path: <linux-fsdevel+bounces-35826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 391CA9D882E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD860B6193F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C651D5CE0;
	Mon, 25 Nov 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQMEcg97"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9C1D5ADD;
	Mon, 25 Nov 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543887; cv=none; b=c+XvYzrXs7p52ePYSGffuPnraZDKRMguFFu8hJpvCZREFMfacpM05b5vm5dp9ByyuiVhRfKT2AB3KJVZ2Lq/GgWj6rzuJei975If9ldE1aozgUTcxG6bb2PRQg0UFwb+GcHDIJSkpMedVBeKcJttjAPGDJ73Qx5+xqf4hE6Lgzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543887; c=relaxed/simple;
	bh=Z8CIq8mdbUKG4he8prOindcVT3zUf3cgGXDWEtNgmBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fefwg0kNClZe/mopVsNwV/BpHw/Ylb8kEuHGW1/5x8KhKFqxHhi3QWTvab20jElcqFsNNxYSptWgFk6Q86M5InNCi70VQONzSNXqVhjnkG+bZd+/aCEI9fIWqoKGjMbH2oJj3mxpnoR6JzeFAd/Dege41uAWZN6jdmZmJvmtTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQMEcg97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2DCC4CED2;
	Mon, 25 Nov 2024 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543887;
	bh=Z8CIq8mdbUKG4he8prOindcVT3zUf3cgGXDWEtNgmBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OQMEcg974dbG/mmpFBZkWOYRO2yzypusDz383ve4yRhCMwz+MZtIqyVwteN+xx+Rf
	 rntSMWpPZJReg7OJpGL+v+q9i6RafE6nrS7BkQLb0l4ya1H9rjwDsIFpbAOCHudNHp
	 3CiqJWam/wx+TVztSiOREBJ7dDBNIGOOkvC4qnkXgN533Zo2qGXJHEwt69+bdWluj/
	 tzdg6QuDxmrVnpODURTSBKj4HSannKOYQi3UBm4GBQTr2LwVQXZ1VGSUYRF5hlw29/
	 OtWxa8Vx1nN9zlPQA6m5YBdtNtDMoUwl/Z9q0Lm05rIrDTJQBcrI1k1/M7vBtL7JmI
	 M+O//Yj67rLyQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:25 +0100
Subject: [PATCH v2 29/29] cred: remove unused get_new_cred()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-29-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Z8CIq8mdbUKG4he8prOindcVT3zUf3cgGXDWEtNgmBQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHrNnrXyouC3rDw2sT/fGUM6DkmXrZ233uwQc51NN
 c+cnuxXHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN51cvI8CbpFfP1gMO7DZJ1
 32a5dp/g/9b06lf3W+GpE/w0/0zb/Z6R4fzaLRcZKieLxR76vfR2lLr2ntQOQQ+WIzYqNquff6j
 4zAkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This helper is not used anymore so remove it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 Documentation/security/credentials.rst |  5 -----
 include/linux/cred.h                   | 13 -------------
 2 files changed, 18 deletions(-)

diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
index 357328d566c803d3d7cde4536185b73a472309bb..2aa0791bcefe4c4a9de149317ffd55921f91a1be 100644
--- a/Documentation/security/credentials.rst
+++ b/Documentation/security/credentials.rst
@@ -527,11 +527,6 @@ There are some functions to help manage credentials:
      This gets a reference on a live set of credentials, returning a pointer to
      that set of credentials.
 
- - ``struct cred *get_new_cred(struct cred *cred);``
-
-     This gets a reference on a set of credentials that is under construction
-     and is thus still mutable, returning a pointer to that set of credentials.
-
 
 Open File Credentials
 =====================
diff --git a/include/linux/cred.h b/include/linux/cred.h
index a7df1c759ef00a91ddf3fc448cf05dda843ea5b7..360f5fd3854bddf866abef141cb633ea95c38d73 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -200,19 +200,6 @@ static inline struct cred *get_new_cred_many(struct cred *cred, int nr)
 	return cred;
 }
 
-/**
- * get_new_cred - Get a reference on a new set of credentials
- * @cred: The new credentials to reference
- *
- * Get a reference on the specified set of new credentials.  The caller must
- * release the reference.
- */
-static inline struct cred *get_new_cred(const struct cred *cred)
-{
-	struct cred *nonconst_cred = (struct cred *) cred;
-	return get_new_cred_many(nonconst_cred, 1);
-}
-
 /**
  * get_cred_many - Get references on a set of credentials
  * @cred: The credentials to reference

-- 
2.45.2


