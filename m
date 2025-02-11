Return-Path: <linux-fsdevel+bounces-41541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A115A3167A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 21:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D8C1882C87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 20:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FF4261596;
	Tue, 11 Feb 2025 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="ZETmhnSs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BfMxygsL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61382265604
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304868; cv=none; b=WWh9F5EWNKgURpbjHSmOCyi8VYQwHVDzYodYGda6/8iMeJwVURiDJx1foBTl+DMK2zzAbtHflVelGLfh2bvM/WUgdMaLHzww0urFqzi/3+X8S3IFZtKrdteQLzK2ea+rNI6Wm93iZMpoo/RWbQtI9eQ9XN0sLg7ju1JoTSl2F8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304868; c=relaxed/simple;
	bh=KMw9pfooTGVous5kUaiR52At+bOq61GWWBS2TeCbwak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCMVPNt2qYaeS1YJXY1E3Zo2jfpsy1pbv/JWidoAec55F9HuJGQOPmZhxYsKJspZhjSu+Db8Xn/EnWJbl6yFYGhbIVDaMzudBIDgZMOqmjTRnI45HWRPawPoj+MV7Gp0jwBT6uwUYRlw4tyIuZdsSF9+bTmYYhwdbqTdfOxzNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=ZETmhnSs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BfMxygsL; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 5EA15201421;
	Tue, 11 Feb 2025 15:14:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 11 Feb 2025 15:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739304865;
	 x=1739312065; bh=4bVWYFQAQQRyfCohzZe4TFQdtoZ6wBx9DBF0MeK+Nqo=; b=
	ZETmhnSs2RlvVcfXS/6Rh9J4G0CxtUe8BMjV33GHltKivWbQmCxQEA/KzjlJjN7Q
	S2yFNe5ivhNHdahEZKyWXK5R+Tryahl7dWgZLeNAUeFf5vjmEHDxXliTqWHSRm8L
	5JiMryvM773mmKJDqj2ZIe4g+FoatYrDfK0Yh9EupISaEIfDrYsxE4I3cNY5BG0k
	IFWjFU86IOsWKNkU16ZsVQ1ULJvIaCMpyritdB0cfbmU1VzxPeS9bKGHOoQtj0Cr
	VGpF495wuPYX79PbjPq1TwprTm65SlbXflGy6tjBbEege8OFSCbCM6DmERbfQrRn
	HSUhVKaAvVHQ+O6SlKmcpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739304865; x=
	1739312065; bh=4bVWYFQAQQRyfCohzZe4TFQdtoZ6wBx9DBF0MeK+Nqo=; b=B
	fMxygsLPUhmGdJvSQFdvgjomdQEev38+h4C6qPKuKXqUYa6SwAC737sDz33VJw6W
	htC7BeiAJtZaZfgW8tDQw6Gf6HU7GF3e7tFVTGKYmCcC5UoqCtAuW2ZZ1yIKCP2G
	G1R+Vbia5KcuigV801QD56JRdjU55VOChOgVkoZ2FLdiHmZLkOee8YMMWt2aadXm
	J5/2oYUSb79dzSAndaw7fDIl1XubVGbirsMY8skHrk4YJ3UbAoN8DBngX9q6qLNW
	NeZnNQ7qN9Pu0EjdJq4BzOGWHiPQ+TcnpSJ6VPU43KcA7MKhqrrrUhsqMdnd2Dnx
	t8MInYh27JaNXCUINWQwQ==
X-ME-Sender: <xms:oK-rZ3bsPUBgM4w4Z89uIvpj-fchq4LOtZa6d3jeatGjmH3lVqmcaw>
    <xme:oK-rZ2bOjZU035oC-FX7-6jS86YJeuLr-f2dztJKWQImAP_neVNT1ZljxPgcAqfPd
    t5KtgYN4tPGBO7bTSA>
X-ME-Received: <xmr:oK-rZ5_dOMZYRLYutpZkgty1ZxJQn8HBaHcM9iDcg_qX0lTU7X3OQRj5RoDv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgg
    gfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggv
    nhcuoehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evieekueetfeeujedtheeffedvgeffiedvjeejleffhfeggeejuedtjeeulefhvdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvg
    hnsehsrghnuggvvghnrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopeihuhgviihhrghnghdrmhhosehsohhnhidrtghomhdprhgtph
    htthhopehkvghrnhgvlhdqohhrghdquddtsehmrgigghhrrghsshdrvghupdhrtghpthht
    oheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehsjhduheehjedrshgvohesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehl
    ihhnkhhinhhjvghonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oK-rZ9qiyvKQ2OhV4bSBA_FvBrYkasNz6tv4W80D1ehFrF76B6nv9Q>
    <xmx:oK-rZyr30teaap4IOGrdbWxyfQSRKCJkUyIZJCpnQUvSRcNYbrIowA>
    <xmx:oK-rZzSVgTby2FmCZ3r18Y6TfwElv9SJQrHBa35SHlCT2OKvwjbqjQ>
    <xmx:oK-rZ6rQxrdsU2iVAxwvk4TyF7uXi78CVzcVaRlpGUQVsxh_OZ1RDw>
    <xmx:oa-rZ53_kWU3MW9Qt3hl7AxcWgJibnAAbB18yDs8yQURGHHNwQdfOcyi>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 15:14:23 -0500 (EST)
Message-ID: <7d880675-4aba-4081-84af-1cbacaef17ab@sandeen.net>
Date: Tue, 11 Feb 2025 14:14:21 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] exfat: short-circuit zero-byte writes in
 exfat_file_write_iter
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 Noah <kernel-org-10@maxgrass.eu>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: sj1557seo <sj1557.seo@samsung.com>,
 "linkinjeon@kernel.org" <linkinjeon@kernel.org>
References: <bug-219746-228826@https.bugzilla.kernel.org/>
 <bug-219746-228826-lg3LNttcRh@https.bugzilla.kernel.org/>
 <194cd33028e.d4f0541717222.3605915477419792562@maxgrass.eu>
 <PUZPR04MB631698672680CB6AC1529C0F81F62@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <PUZPR04MB631698672680CB6AC1529C0F81F62@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

When generic_write_checks() returns zero, it means that
iov_iter_count() is zero, and there is no work to do.

Simply return success like all other filesystems do, rather than
proceeding down the write path, which today yields an -EFAULT in
generic_perform_write() via the
(fault_in_iov_iter_readable(i, bytes) == bytes) check when bytes
== 0.

Reported-by: Noah <kernel-org-10@maxgrass.eu>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 05b51e721783..807349d8ea05 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -587,7 +587,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	valid_size = ei->valid_size;
 
 	ret = generic_write_checks(iocb, iter);
-	if (ret < 0)
+	if (ret <= 0)
 		goto unlock;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {


