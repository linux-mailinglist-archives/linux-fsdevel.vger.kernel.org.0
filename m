Return-Path: <linux-fsdevel+bounces-32324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F009A37DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 09:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EFB1C23DC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 07:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB5618C337;
	Fri, 18 Oct 2024 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="iRhySdG0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3355013541B;
	Fri, 18 Oct 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238224; cv=none; b=int5YI72DVtgERoJ2wEeRWobBU3rBxn1XBy/JYT429ibBu3mZVuOdkBAvg0FgDsx0o4HZQlGyYVYb2VWbbQOsKSJjwQ6MCDrxXYGAMyAuzqxBRofYpJmgjctVnzN05zilK0lhVW3fhB5O1081wK77N6SaUIwl/FBGOzhde47PKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238224; c=relaxed/simple;
	bh=Jg1ag1/BdOgc3PlSpCwQD5dbKJQeLayQFp6Bx4ijjn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE8uyT96iL42hIdKm1YihyryTQZSsjUV65/14nIYFN4U7cQTdtBOBu0UFXkfOCrvjkhtWVTcEn2yH4msL6BwXraRFI2EnGO1ooQ1i6qhxCXWkHHVPuORWiBS4TrPlmVqRVFG7QwNl9lTzCrBD62aH+3GNlNbaRbzQVIdzMd8YtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=iRhySdG0; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mL32Eki6sjCzVmgt0MNugO7Uxg6dlD8cyllaWHsT1OE=; b=iRhySdG0+HzFT33nV2Qe97Xwxn
	8bFkloSEdrywPJbXjvcdyyB+kUVHdbRid7SJT47MfNNGK9oywgBvQ28dsu7T5zd5+XugG8Sm3auvg
	vz+yFwwk1MAHSlJ+VN4HYkmIImOnOvm3EqQjEqFzkdmZVkI6SJbg4D3SZ47E5cBwXt2elOq4DTbLZ
	wzQPzUPC9Ndb9KxrwpzJEuYmLMNzdb+Ism3vYQueaP9Pvc3BccOmLdYRy9QGH66kesJq2iDJm3WF8
	3Tg5/WS+QqT3avdo3ftalz3kDGqqMjZlyf/rt/09eHPAr/EBk7fZBw0vcTig2oUy6KF4Mi16oNrVf
	2xncK+0A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1t1hpF-00AJtu-1v;
	Fri, 18 Oct 2024 15:55:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Oct 2024 15:55:09 +0800
Date: Fri, 18 Oct 2024 15:55:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
	yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
	usamaarif642@gmail.com, ryan.roberts@arm.com, ying.huang@intel.com,
	21cnbao@gmail.com, akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org, davem@davemloft.net,
	clabbe@baylibre.com, ardb@kernel.org, ebiggers@google.com,
	surenb@google.com, kristen.c.accardi@intel.com, zanussi@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	mcgrof@kernel.org, kees@kernel.org, joel.granados@kernel.org,
	bfoster@redhat.com, willy@infradead.org,
	linux-fsdevel@vger.kernel.org, wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com
Subject: Re: [RFC PATCH v1 01/13] crypto: acomp - Add a poll() operation to
 acomp_alg and acomp_req
Message-ID: <ZxIUXX-FGxOO1qy1@gondor.apana.org.au>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <20241018064101.336232-2-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018064101.336232-2-kanchana.p.sridhar@intel.com>

On Thu, Oct 17, 2024 at 11:40:49PM -0700, Kanchana P Sridhar wrote:
> For async compress/decompress, provide a way for the caller to poll
> for compress/decompress completion, rather than wait for an interrupt
> to signal completion.
> 
> Callers can submit a compress/decompress using crypto_acomp_compress
> and decompress and rather than wait on a completion, call
> crypto_acomp_poll() to check for completion.
> 
> This is useful for hardware accelerators where the overhead of
> interrupts and waiting for completions is too expensive.  Typically
> the compress/decompress hw operations complete very quickly and in the
> vast majority of cases, adding the overhead of interrupt handling and
> waiting for completions simply adds unnecessary delays and cancels the
> gains of using the hw acceleration.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  crypto/acompress.c                  |  1 +
>  include/crypto/acompress.h          | 18 ++++++++++++++++++
>  include/crypto/internal/acompress.h |  1 +
>  3 files changed, 20 insertions(+)

How about just adding a request flag that tells the driver to
make the request synchronous if possible?

Something like

#define CRYPTO_ACOMP_REQ_POLL	0x00000001

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

