Return-Path: <linux-fsdevel+bounces-35814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3052F9D8788
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E2D289D4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3761CCEE2;
	Mon, 25 Nov 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcapAW4m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC91CBEAA;
	Mon, 25 Nov 2024 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543861; cv=none; b=pIAmjuOOxLGmBwByQJBwRYVf7M38HrxFguhrI9antiqvK8scuzUI4cM5GqktMLtKIIZWXiOvb4cQVXK4WN2mfZH2480gRwMEzwjV4VsWhPYp31396AEGPpKzNWm0uPgRsvKV3A3RjPmOYWt1bn/WJJbzYzpKBD2xU2YAGDJnfBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543861; c=relaxed/simple;
	bh=yv6/Dvqanrk3w463KbC21JBdeY18xPTOfLBMKCFqXI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bKueQo3NWKYmgDmQkTv6+KhSk3yQQtouxELm0SPXJ71MitVhfCx9ktjZRDaDZlkJBYqoCVs5zbQs1mbec9dIx+wCCka9/1oE5TXAnYlCYGV8dCo+zDaaII7eOe96NBCMF/8+5zQid5iDO2XhlRQ0k7l73CtzC2+Tck35ws/1D+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcapAW4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6287BC4CECE;
	Mon, 25 Nov 2024 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543860;
	bh=yv6/Dvqanrk3w463KbC21JBdeY18xPTOfLBMKCFqXI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VcapAW4mWsthD+8bctfjLPUftvUAAVgB/4bv0hX9uWFGF/PKRxS1+CaRMe2b0bZNI
	 pz/FFxBnWIBRTCWtMcPwEaj5cHME7IwWUqx3ncHlXkkkkQlnUX83ZyRSttewMXojBD
	 LUIIMSN9rmZriDoaNXaIlTU8Z8WxtU4r2U9V86rNRT9J6fUnEvLTv8u4GS7p7JPscm
	 gIxpNfOGYlweUHxlfy4lEpTuZWTOdcOKNn59PoK3DFqZ0hEO/w/FPxpW5SSkKpoG+Q
	 l3ZH9UgD/T8Hwu8prelHh2b33SLf1eZXW1IyEF3bO/4ZiUp8xKLviJ3mbI6I3j81ZX
	 0K2PQzchmwbbQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:13 +0100
Subject: [PATCH v2 17/29] open: avoid pointless cred reference count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-17-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yv6/Dvqanrk3w463KbC21JBdeY18xPTOfLBMKCFqXI4=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGdEhUmg61gacRFkk6N3JYFavR+OdTJiCvWOQClkgn/xgXEyb
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmdEhUkACgkQkcYbwGV43KJunQD8CDX3
 mYbIgH8r0DSFu3ww2szScGM3uCCFQj7ssG+41L0A/ikf0BCNQz1g+mD9rI16N/BtELkQFaMln5I
 wBywgbvgF
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The code already got rid of the extra reference count from the old
version of override_creds().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/open.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 0a5cd8e74fb9bb4cc484d84096c6123b21acbf16..ffcfef67ac864c8ddaf9719cbc2762d5575597f3 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -402,7 +402,6 @@ static bool access_need_override_creds(int flags)
 
 static const struct cred *access_override_creds(void)
 {
-	const struct cred *old_cred;
 	struct cred *override_cred;
 
 	override_cred = prepare_creds();
@@ -447,13 +446,7 @@ static const struct cred *access_override_creds(void)
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


