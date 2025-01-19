Return-Path: <linux-fsdevel+bounces-39606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E90A1620A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 14:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CAA164A5C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 13:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE15D1DE3A7;
	Sun, 19 Jan 2025 13:36:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7BB674
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2025 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737293789; cv=none; b=jNzEw2/OTkxPrA3YAWzCwVVQ41x24F+rNBCoYzZvrkru66+twD6oEI6lYbVxJeC+k7pg+U3yfEqkjIGeGOPoTfPviPT+ZVG1g/cVUJnw0PFlP+Asnl3ksYivmAogUZPe/vaETpOEnJwzCjv0A/a1sQ96d6VhJpd4Rsc1wWyiVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737293789; c=relaxed/simple;
	bh=0rQQjjGLP1l7cST3uxKf9fm7yd12+ESXQyXo9+Ero1Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rknShTOsWS6L3My2GykAz/hx4eIHQIZSSiJvhq+zg9LLPI97r5R70kEccW/vPmAy5bBCMvy4uny34ZMgzHEuQZXPcEkgNhi25FH4UppW0GBqU9qKmY56OGfJUuSoVbVDYNFTX7Fdqp96S106qzWwdnArHNfvZzjYSCcFpx6hES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E47CA2B8740;
	Sun, 19 Jan 2025 14:36:17 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id AwCqhX2vHDqG; Sun, 19 Jan 2025 14:36:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 13E192B8741;
	Sun, 19 Jan 2025 14:36:17 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zE0df5_FnQC8; Sun, 19 Jan 2025 14:36:17 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E971D2B8740;
	Sun, 19 Jan 2025 14:36:16 +0100 (CET)
Date: Sun, 19 Jan 2025 14:36:16 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <1595202043.249250399.1737293776824.JavaMail.zimbra@nod.at>
In-Reply-To: <20250117230913.GS1977892@ZenIV>
References: <20250117230913.GS1977892@ZenIV>
Subject: Re: [PATCH] hostfs: fix string handling in __dentry_name()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF133 (Linux)/8.8.12_GA_3809)
Thread-Topic: hostfs: fix string handling in __dentry_name()
Thread-Index: wPeoYBxf0bRbYOKou83hfnIuiIUm6A==

----- Urspr=C3=BCngliche Mail -----
> Von: "Al Viro" <viro@zeniv.linux.org.uk>
> An: "richard" <richard@nod.at>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-fsdevel" <linux-fsd=
evel@vger.kernel.org>
> Gesendet: Samstag, 18. Januar 2025 00:09:13
> Betreff: [PATCH] hostfs: fix string handling in __dentry_name()

> [in viro/vfs.git#fixes, going to Linus unless anyone objects]
>=20
> strcpy() should not be used with destination potentially overlapping
> the source; what's more, strscpy() in there is pointless - we already
> know the amount we want to copy; might as well use memcpy().
>=20
> Fixes: c278e81b8a02 "hostfs: Remove open coded strcpy()"

Hmm, AFAICT the open coded strcpy() was also never safe wrt. overlapping st=
rings.

Beside of that:
Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

