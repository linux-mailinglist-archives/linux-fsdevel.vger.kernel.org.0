Return-Path: <linux-fsdevel+bounces-38850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD0A08D07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E27E3ABE66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219320B808;
	Fri, 10 Jan 2025 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="f4Xg4moZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F90D20B21D;
	Fri, 10 Jan 2025 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502564; cv=none; b=fGBWZ/XzsbpaISaEXClMNy5copvyd1eWSAQHK397xEdj4iiprQ5wwajV9dg438SM99k+iF2lAnziZNyQJJ426hQcr4SaI73xXOM9+RmBiChnndshMiVO5BUMGARJt8ZxC+43JasfohmRLuQeqZ2r/L81t6oqlCDaOB1SOhn+AlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502564; c=relaxed/simple;
	bh=MZm7JsfukNZTzizqFkl+4BmfBELHFIJk4hrjdZsbZcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plHAaMAmswBC8PpLTzi47FpTiooRPSgdNc6Tc00jV/Ta5J0Yk/UeiHwlqmgZi3HdoJ+dJUvvHDBOjUqqcLrq0VnAf8zp49eFI244Zg1ZL5vcF5z9DUJIS9QVzk6wzXJkuzTOlMUa2w7TRlW/i6KaWSZ4P0TT/sd/FXNJJY3nuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=f4Xg4moZ; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=W6OrZGwU2ohzYLkVhoo1Up0mkLfx9Dld/9qt6ikIX3o=; b=f4Xg4moZcRCldbafjO7Jkm4mrf
	4KQE46rcfqRf99aKwl7v10HhX+QhDSe3jyvbZmWLzSqLgpMDwb37pybH5ZUzl7KQE80ZV2UMdkybr
	x3coHDNfty+DWCDt+hUTI+jLgMmxZSCDWmGFqBZv6+cwPsnoYmX7xmNQ94pOSIpTLJqUzWq8okynE
	brQOpbAlt63JR2pIBOoSUXxUAZizGwvV4nWb4sSjZgqSvXFXRsSESCvWmoTE+84lI+4AGp1mRsDZM
	yeISqT8W7Jjlu3GzqEiCK/NjjPe6PZEoS3uQKokJlTiZanuZnnyCWCbjVaswV/GMyzjHyD4YwdbXI
	PgnuYX0A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tWBQB-007nZ7-23;
	Fri, 10 Jan 2025 17:48:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Jan 2025 17:48:36 +0800
Date: Fri, 10 Jan 2025 17:48:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] crypto/krb5: Provide Kerberos 5 crypto through
 AEAD API
Message-ID: <Z4Ds9NBiXUti-idl@gondor.apana.org.au>
References: <20250110010313.1471063-1-dhowells@redhat.com>
 <20250110010313.1471063-3-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110010313.1471063-3-dhowells@redhat.com>

On Fri, Jan 10, 2025 at 01:03:04AM +0000, David Howells wrote:
>
> +		.etype			= KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
> +		.ctype			= KRB5_CKSUMTYPE_HMAC_SHA256_128_AES128,
> +		.name			= "aes128-cts-hmac-sha256-128",
> +		.encrypt_name		= "cts(cbc(aes))",
> +		.cksum_name		= "hmac(sha256)",
> +		.hash_name		= "sha256",
> +		.key_bytes		= 16,
> +		.key_len		= 16,
> +		.Kc_len			= 16,
> +		.Ke_len			= 16,
> +		.Ki_len			= 16,
> +		.block_len		= 16,
> +		.conf_len		= 16,
> +		.cksum_len		= 16,
> +		.hash_len		= 20,
> +		.prf_len		= 32,
> +		.keyed_cksum		= true,
> +		.random_to_key		= NULL, /* Identity */
> +		.profile		= &rfc8009_crypto_profile,
> +
> +		.aead.setkey		= krb5_setkey,
> +		.aead.setauthsize	= NULL,
> +		.aead.encrypt		= rfc8009_aead_encrypt,
> +		.aead.decrypt		= rfc8009_aead_decrypt,

rfc8009 is basically the same as authenc.  So rather than being an
AEAD algorithm it should really be an AEAD template which takes a
cipher and and a hash as its parameters.

In fact, you could probably use authenc directly.

rfc3691 on the other hand is slightly different from authenc in that
the integrity is computed on the plain text.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

