Return-Path: <linux-fsdevel+bounces-68551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A01C5F877
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 23:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3DD135D182
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 22:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A8B2D1936;
	Fri, 14 Nov 2025 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5fGqDSk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56D261393;
	Fri, 14 Nov 2025 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763160336; cv=none; b=F3GJAPbgsyBAceBhbe+FOkS1Ew4k1b/qUKoiDuGskS2XvM7GZVWUYa60TFFrvb0EJjhgGgPLLCoGvhHgWBNu9FnXh5IPWXR2cpSY9YfSoUrmiRRgFbTvampeWQ5sSVS4UDnLOtnfR5wgcAWeY1s4w8ZWy1weOu1gpym4elg04Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763160336; c=relaxed/simple;
	bh=0miK8ErlsK41Adxa17JA6MgYyaK6bj7KtMkUqHU+0/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p/tkY/fOVUyMIPLYFNTaGbL7gGUSeDs+ztWCCqPgNnm8uTSxnEiGF4IsqgxIApLdBg8dBsbg7AMQaOTgKbi7JbKNdVo3sfRyzrTvEt0+6cIL1AvXfIq9K8HAkVvZW88xFndWyPEwjWjBVKg4h0+abQYTTew2jh3EOPLasjLCiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5fGqDSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0C4C4CEF1;
	Fri, 14 Nov 2025 22:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763160335;
	bh=0miK8ErlsK41Adxa17JA6MgYyaK6bj7KtMkUqHU+0/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M5fGqDSktAWYWQ4VNzRHHV4ZLp/v9Ezagd7jKkXC/eS5IyBIG2C9z5QVJYewTSk6K
	 Tx3BsjelMLmD097N7KV37bWwJOi0Lzquhkqy0SVEnhzC0EKqVMJ8LC+X5ZDMoG282L
	 1XKsZ3F8taAxZZ1eDQu9iB8QuurSKb3B2U5TIIOWdbhYM3yAq27lSBPaqjuX70GB3s
	 kIMPDEZa//GMDVCoy7CGsTdrTF3j064EFo9U0g0JbV9bxSo+J/qiQYx26BJeRpgmRV
	 pH/E+wkrFbRFfiLlKObndGapuRE82OyiJeh8FLTdUWAJIJilS/4xK2QHBwET5Ek1Ya
	 GiBbIh9TZ9IbQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 14 Nov 2025 23:45:24 +0100
Subject: [PATCH 3/5] ovl: mark *_cu_creds() as unused temporarily
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-work-ovl-cred-guard-copyup-v1-3-ea3fb15cf427@kernel.org>
References: <20251114-work-ovl-cred-guard-copyup-v1-0-ea3fb15cf427@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-copyup-v1-0-ea3fb15cf427@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0miK8ErlsK41Adxa17JA6MgYyaK6bj7KtMkUqHU+0/o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKb+SwrNrr4ndeRfdfQpTqpGTLfe4vnGdfdP5i5Xkj5
 nVO+qKKjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8yWVkmCuh+/uCZouy8JSd
 Cw9dmGvrWhlf79G/Mb1++hPm6rhvfQz/3bqOMIr6Vu6K0BTcE9I2Q/qspc2cgz8OrDev/cb3TJ2
 HHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

They will become unused in the next patch and we'll drop them after the
conversion is finished together with the struct. This keeps the changes
small and reviewable.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/copy_up.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 665c5f24e228..9acc1549d46d 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -732,7 +732,7 @@ struct ovl_cu_creds {
 	struct cred *new;
 };
 
-static int ovl_prep_cu_creds(struct dentry *dentry, struct ovl_cu_creds *cc)
+static int __maybe_unused ovl_prep_cu_creds(struct dentry *dentry, struct ovl_cu_creds *cc)
 {
 	int err;
 
@@ -747,7 +747,7 @@ static int ovl_prep_cu_creds(struct dentry *dentry, struct ovl_cu_creds *cc)
 	return 0;
 }
 
-static void ovl_revert_cu_creds(struct ovl_cu_creds *cc)
+static void __maybe_unused ovl_revert_cu_creds(struct ovl_cu_creds *cc)
 {
 	if (cc->new) {
 		revert_creds(cc->old);

-- 
2.47.3


