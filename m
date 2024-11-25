Return-Path: <linux-fsdevel+bounces-35824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1059D879E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AA228C8D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F29B1D5162;
	Mon, 25 Nov 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsYD5nQ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F631B392B;
	Mon, 25 Nov 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543882; cv=none; b=t0fLvRUNye4YwWJ68oqJOpGrBEV79hvdJkK0cm0uwdrcOhMrnDWcGNHAATtyq5XHf9sEY4ZndEkr/jHI6w//N4J3iYmqoybiKHJbDvNK5XTY9iqRTiQCrUWwvP19259Bjd76JX8HGuVR0RL2XIr0Y+x5zSJbKxjbSLBbfLRoaVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543882; c=relaxed/simple;
	bh=5EYYXg0CTcaKcNVDKPWAP/w4kmhOJ/D6n9A7vR1vqfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d5t3hmXfcMH4TlHCr8ikJLf/qxWz3WlPy456rkgxzxkBCD2bq8eZoq4SstvAQ5A2b4QWdXOXA3oWlx1KEQqxozLC3RG1K0JnmUZeh0mKEDMUSrFphPiuq1cqSd3MPz7ILkRIK494TXVApS32p+mMcXaaKATYUGoSkB4reMu9tE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsYD5nQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3026C4CECE;
	Mon, 25 Nov 2024 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543882;
	bh=5EYYXg0CTcaKcNVDKPWAP/w4kmhOJ/D6n9A7vR1vqfo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XsYD5nQ5lVvAVly92Y54URgO5HAIT7UbElNo+uz70TCvTJnaXpvCmIsm10LnhXD7G
	 I3QfxVzZ03x2SjETKQCX7+0fNMJlfHV5ymffRi4sKX5V602VbewylSoUiUNf2hrg9L
	 C4Rye5cBxQGZPnUzL7yw5rE7lmTA5KV9NQMFpSSz2c7LJLj3c8pyXqKAUcki+CYn1o
	 Jdm6xlitKDpS3lv1D1AUOCpRiCz4LKlQDK4s+dDORKNCDoXgqp1yfpImvTT0aHcBaj
	 k1RHeWVDguiYMg7fzBBtTlF0wPrZ0AYOTWhN2jXIl9zTbjSeLI0ie3MOD+u68xcvdX
	 hMD119kkFMjrQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:23 +0100
Subject: [PATCH v2 27/29] cachefiles: avoid pointless cred reference count
 bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-27-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5EYYXg0CTcaKcNVDKPWAP/w4kmhOJ/D6n9A7vR1vqfo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHpFT4v7OPnPjrnaiq/VmApMRaKrYjLsCtm65Q+eO
 DVNVbm4o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLzRBj+Ry2ZU/Hb60LPyldL
 wk9EqPo8Wyr7YpbxtUlfhHgznV+dWM7IcOXWrVRjm/atT1awN/m+rJBOT6mYWfRhgd3/u9uZ1ry
 Yzg0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The cache holds a long-term reference to the credentials that's taken
when the cache is created and put when the cache becomes unused.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/cachefiles/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 1cfeb3b3831900b7c389c55c59fc7e3b84acfca6..7b99bd98de75b8d95e09da1ca7cd1bb3378fcc62 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -393,13 +393,13 @@ extern int cachefiles_determine_cache_security(struct cachefiles_cache *cache,
 static inline void cachefiles_begin_secure(struct cachefiles_cache *cache,
 					   const struct cred **_saved_cred)
 {
-	*_saved_cred = override_creds(get_new_cred(cache->cache_cred));
+	*_saved_cred = override_creds(cache->cache_cred);
 }
 
 static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
 					 const struct cred *saved_cred)
 {
-	put_cred(revert_creds(saved_cred));
+	revert_creds(saved_cred);
 }
 
 /*

-- 
2.45.2


