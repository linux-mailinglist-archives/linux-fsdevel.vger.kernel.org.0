Return-Path: <linux-fsdevel+bounces-66749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D43C2B6C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1265D1896811
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DAA30DD37;
	Mon,  3 Nov 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaZ0aFlr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3730DEAC;
	Mon,  3 Nov 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169275; cv=none; b=R9cbITGTKo/wx4g9rMpHZX6EaDK2M5V3Pe0YTykDT3NgySTJX2Q/xA6kCdOUmdqVSMX4hTNzPGK/1owUbf11N315+vPwitItaVA7N+LT0iWPrXiMiPbzZNzxIehfWkyf4uF2d/rxt2ZpvVxZg+Fgrb2yS3TXKvj6FQURHDu+uYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169275; c=relaxed/simple;
	bh=bCAyE7tmk17boyOhhm5qwpsQaMCqCnHI3pfKUhK/d+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FcU6fghtgD6msLW8OC9/LWEkswRYJ5TUQ0n/nhS5b8pP129jTLcmbLVY499NJi7qSpJfMaUKS18pvfJGueKAhosBg6CLmaEAm7tv02KHzyJJQZT+iPGulV4D3VHUkVA0ZjUiFHYgxsid4MP/bq8yN6n59OiI7jgEHr/FLDC/Ok0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaZ0aFlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2A1C116B1;
	Mon,  3 Nov 2025 11:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169274;
	bh=bCAyE7tmk17boyOhhm5qwpsQaMCqCnHI3pfKUhK/d+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YaZ0aFlrmjLdV5jLyEWA8b2zPj7i9z0dEpY7E7rdwB2Ir37Qxszllxd+LNnnKGHpV
	 7g9uQsnEh6lDmbJfA/j3i7al14HMc1FhKJuhGYP5jeWI4FqTHyNwG4KUR4LgFazakm
	 9U6Bp0/ktbSbl18fmnOeWWaJYtfsjuu5jQIn2cic/xqnanYb+hX8H1N2l7eiHfwRYw
	 WlWwRJueDrp/N+huW0lQhpsaThRzloG3shyGhe98eUpBRrQtTyTnupElathvxWorr+
	 VU2h9Ct67bfNGBcgfYLonCedVqZrKUuW4QK8H0K+yeAQc3FViZrQoKtD29+DH9/Hq9
	 IHBHH4/ABmXuA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:27:04 +0100
Subject: [PATCH 16/16] net/dns_resolver: use credential guards in
 dns_query()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-16-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bCAyE7tmk17boyOhhm5qwpsQaMCqCnHI3pfKUhK/d+4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTOz49t81KnHqZTWdoJ9Fp9KfSbosV32dkH//j7TF6
 wVfllVmdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkoZLhv8td6YzC5sipYZKb
 NNX9Ju62Zvq6u5zZbmpraeA33c0/dzIyHF19l68/b9H/cwesPoX/dN9tnRlh6/AjVdTxeV6q8Y6
 9rAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/dns_resolver/dns_query.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index 82b084cc1cc6..53da62984447 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -78,7 +78,6 @@ int dns_query(struct net *net,
 {
 	struct key *rkey;
 	struct user_key_payload *upayload;
-	const struct cred *saved_cred;
 	size_t typelen, desclen;
 	char *desc, *cp;
 	int ret, len;
@@ -124,9 +123,8 @@ int dns_query(struct net *net,
 	/* make the upcall, using special credentials to prevent the use of
 	 * add_key() to preinstall malicious redirections
 	 */
-	saved_cred = override_creds(dns_resolver_cache);
-	rkey = request_key_net(&key_type_dns_resolver, desc, net, options);
-	revert_creds(saved_cred);
+	scoped_with_creds(dns_resolver_cache)
+		rkey = request_key_net(&key_type_dns_resolver, desc, net, options);
 	kfree(desc);
 	if (IS_ERR(rkey)) {
 		ret = PTR_ERR(rkey);

-- 
2.47.3


