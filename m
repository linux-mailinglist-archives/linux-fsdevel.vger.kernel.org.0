Return-Path: <linux-fsdevel+bounces-35823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 559D79D87BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5F7FB60CA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1851D4615;
	Mon, 25 Nov 2024 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frzXK3Nn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870C1B3725;
	Mon, 25 Nov 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543880; cv=none; b=WZwrmYi/AIOOcF0HnR+nVoKCFPnrdXqKd7XQ4tKOCgVnkMow1GS4DNTKln6EKWge87oSxTm6ZaHakLhLdm+1QmSzZLyyaw1oyuXJHW5DRu5459LLXSPlJvh/XDbES0QPfAQA0it0EQpFrP2BSJ9+yfR1sf80Mxtr+OTG+06G170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543880; c=relaxed/simple;
	bh=+Rz5NK6h9epgNKNwH1bCVeoUhuBFQQSQ8BdA9FLVdr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LqygFpxKCxUlaJl0n1II7Ggb12geiBrms4G+n3TTzlf3OQCy/2TvJsAYCsoi6dqmc+VOr9loraIYDPFTUdLADF4P9QaeZL7G0KJ0vPCpxhn7jSmTAalH1/z1pKUCulvFB4myIJXjwCTPNlhoJLk5/F/0HKedhZOkseAv4M7xDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frzXK3Nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5B4C4CED2;
	Mon, 25 Nov 2024 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543880;
	bh=+Rz5NK6h9epgNKNwH1bCVeoUhuBFQQSQ8BdA9FLVdr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=frzXK3NnNnLBmugX3yTJ4TjKNfMMULPbCCx6nN/H2X80DrETmfN4VUDOgVIYnm68x
	 diDrATBqyS8ANhTCD1INtLg/PpMWDsdAGqCl+xxvInbfCVmihZOmY0h+V26zUmkJhp
	 LWBARCUGWHsnXSPiLO7i7WERPOkMMrX2XHyMhxWpNT/lX/j3JlvFFiAjfRSZf/Y1lh
	 ppK+4u8tzskKC/Hwp+6XR3EG3IqM9/MFlf3acOH/qJu8829HRPaewo0YNY9aRbtYHD
	 GWHHxWIu8IZDn954WZ4Wm9s4oNgeF+44y7YLGIbvF2IGCMQIcWVtCmeHKUKaV3OIFS
	 cbtiaHjW6S/Hw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:22 +0100
Subject: [PATCH v2 26/29] dns_resolver: avoid pointless cred reference
 count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-26-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+Rz5NK6h9epgNKNwH1bCVeoUhuBFQQSQ8BdA9FLVdr0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHrFnv5696dS4un977VWd7nuf/n+4uvfzNn8M9bkP
 i7aXCDj11HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRB4kM/wyXzHPyP1Mtcm3T
 pSN7yxhLpK1SN2l3sd3TlH2pH8vxSJzhn/6qigOZhtuOLD1t9/PO/sVf3HNX+WrF1hbdM/hbHXa
 JkRsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The dns_resolver_cache creds hold a long-term reference that is stable
during the operation.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/dns_resolver/dns_query.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index 0b0789fe2194151102d5234aca3fc2dae9a1ed69..82b084cc1cc6349bb532d5ada555b0bcbb1cdbea 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -124,9 +124,9 @@ int dns_query(struct net *net,
 	/* make the upcall, using special credentials to prevent the use of
 	 * add_key() to preinstall malicious redirections
 	 */
-	saved_cred = override_creds(get_new_cred(dns_resolver_cache));
+	saved_cred = override_creds(dns_resolver_cache);
 	rkey = request_key_net(&key_type_dns_resolver, desc, net, options);
-	put_cred(revert_creds(saved_cred));
+	revert_creds(saved_cred);
 	kfree(desc);
 	if (IS_ERR(rkey)) {
 		ret = PTR_ERR(rkey);

-- 
2.45.2


