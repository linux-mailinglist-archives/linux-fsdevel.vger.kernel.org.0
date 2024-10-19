Return-Path: <linux-fsdevel+bounces-32405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8877D9A4A76
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 02:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E26283D9D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 00:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFACE2AD33;
	Sat, 19 Oct 2024 00:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="PYB9fJvZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA699224CF;
	Sat, 19 Oct 2024 00:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729297246; cv=none; b=S2FjRX9BDssP/hI70Z4cvzVIRRtnSAStyFjVQ1eh+AQEnAG+CT5fK2Pp7zBcsOw2QbRtLwMhHm9ZwkTUv1+wdk/j3oFQNx+t028UAWBwiy7nU1pE/t9masaNX/74cAh3LmzhUCvIVNSAdmpo+2Jdlc8Fk+BDcOsf8N2YeWezODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729297246; c=relaxed/simple;
	bh=qI5l1jsqzoUe0LmaPMq9oX46BlP9hJIre2mnGkMU4CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnFcEAj0H/yW00l1ZXMqqPiCGGjewrVi2B9Rx851wzJbYD+4jKVVrIJOKCO7NLUmonsOZX1uMCLxOqioEcBh71mT4bluv/x8VjPaX9CgjN4aPGe7W0aUYy6UyRE8zK5RPVOTk7mvheyWEEcJyb+FfF8KXiLBcBgaosyvXKltr/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=PYB9fJvZ; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zdDTvBQFkrAbA5UYsiAGy1L58PcaCZM1pS4G5GVb73Q=; b=PYB9fJvZq646VxX9D/D6jU4RSV
	WLOvBXYenBE+50AuDfcfPeNRirfZqz7oH+8dk3oc/5Zaj6H6/Ju+R5yGCtbu8SgfBB2CFvOCKic9M
	pPX0eFVYzLLZuXXaTDRt7lA7b3jkW7eZc4E2tLDSzOPs5aMaGN4JDs1ITCn/y9qu16L738mPm5xDH
	BwYPpZp0yUC8/9oBrPkxcL0/8g4YqpayJbJRA5lV1j1mjGaRfMghyHt47R5aNsgcgxN7vygZeK/jR
	i40azgCN3t7PtUAHwpoBIQ9/bB43LwqBZZdeaHo7qQUkuZMEwOInEbU2oRRTcBWZlhdUzJXC+l8UP
	nUsoHnzQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1t1xCD-00AVu7-2K;
	Sat, 19 Oct 2024 08:19:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 19 Oct 2024 08:19:53 +0800
Date: Sat, 19 Oct 2024 08:19:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"surenb@google.com" <surenb@google.com>,
	"Accardi, Kristen C" <kristen.c.accardi@intel.com>,
	"zanussi@kernel.org" <zanussi@kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"bfoster@redhat.com" <bfoster@redhat.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [RFC PATCH v1 01/13] crypto: acomp - Add a poll() operation to
 acomp_alg and acomp_req
Message-ID: <ZxL7KUGUroiOYssf@gondor.apana.org.au>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
 <20241018064101.336232-2-kanchana.p.sridhar@intel.com>
 <ZxIUXX-FGxOO1qy1@gondor.apana.org.au>
 <SJ0PR11MB5678CE94DDBDEC00EA693293C9402@SJ0PR11MB5678.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB5678CE94DDBDEC00EA693293C9402@SJ0PR11MB5678.namprd11.prod.outlook.com>

On Fri, Oct 18, 2024 at 11:01:10PM +0000, Sridhar, Kanchana P wrote:
>
> Thanks for your code review comments. Are you referring to how the
> async/poll interface is enabled at the level of say zswap (by setting a
> flag in the acomp_req), followed by the iaa_crypto driver testing for
> the flag and submitting the request and returning -EINPROGRESS.
> Wouldn't we still need a separate API to do the polling?

Correct me if I'm wrong, but I think what you want to do is this:

	crypto_acomp_compress(req)
	crypto_acomp_poll(req)

So instead of adding this interface, where the poll essentially
turns the request synchronous, just move this logic into the driver,
based on a flag bit in req.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

