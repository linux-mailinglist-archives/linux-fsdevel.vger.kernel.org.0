Return-Path: <linux-fsdevel+bounces-39673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEBCA16DE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 14:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F513A4103
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACBD1E2849;
	Mon, 20 Jan 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuJZpKyP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98041E2838;
	Mon, 20 Jan 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381479; cv=none; b=kIaaZARwrUfzFnRm6Y+w/NxEJKZOT96wIXsPyhXF2bzpDFgB02YuiQUKmn9+yhoVOBgq8IUJqyauO1ybT+QnkRVNgwTylSv6LGweZY8Tn6Rch6rQPzs0tpiGeDhnK6dAQo2yB/pKhHxS/6L2V3jxdUsFX47MXexcQteUPPSIS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381479; c=relaxed/simple;
	bh=mMnF1rH8r/RyTbYhURrLkiK4JarAbi2ujmmaTjR3WKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG590U1NkvHUdC3b0rUhdAnGqj2fr8XjEFr2v7O4u94MKUHnU5EkK4hvmHCB56LvHiS6K895UB7LR8EeLWlZx8WTWr2AccQ9/WeOOOD/ZJXoXxkyLADIqWKGQcaGI/ibOVS1WyqHQ2VBNic8c7e+oIALLJVp7xk66nNdKbwooFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuJZpKyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49094C4CEDD;
	Mon, 20 Jan 2025 13:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737381479;
	bh=mMnF1rH8r/RyTbYhURrLkiK4JarAbi2ujmmaTjR3WKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NuJZpKyPx7ny0GSbeehDbouPHXimJr0RgfJE+hx6Q4fg+QRcvvInO7rf1BGVKvVAJ
	 D2QL3N10JPkWgv6H49sp0CxmdwGPw6gyPkUgyD+yslIxtjv87p35D5gWXVG+vVU7Bj
	 4smk6TeGY9hii3l0EJK+grE6/2JBBod2xX5R02orL23gee8qA55XrCTSDkfCq0fcH7
	 f2wx3JGzMxSLc+0ly6E8I1dYqLg3APFHy3LsiP+NR47Ap3O2RTgOEP3F0vRyMYhhjy
	 2TMc3ZJ/tfL8hh8h3bknAlIEfpYIu9eZ7eeIzG9jmfAxty8suUSUpYqcepx7DwPsAz
	 C/VQhW0CuySUQ==
Date: Mon, 20 Jan 2025 13:57:54 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/24] crypto: Add 'krb5enc' hash and cipher AEAD
 algorithm
Message-ID: <20250120135754.GX6206@kernel.org>
References: <20250117183538.881618-1-dhowells@redhat.com>
 <20250117183538.881618-4-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117183538.881618-4-dhowells@redhat.com>

On Fri, Jan 17, 2025 at 06:35:12PM +0000, David Howells wrote:
> Add an AEAD template that does hash-then-cipher (unlike authenc that does
> cipher-then-hash).  This is required for a number of Kerberos 5 encoding
> types.
> 
> [!] Note that the net/sunrpc/auth_gss/ implementation gets a pair of
> ciphers, one non-CTS and one CTS, using the former to do all the aligned
> blocks and the latter to do the last two blocks if they aren't also
> aligned.  It may be necessary to do this here too for performance reasons -
> but there are considerations both ways:
> 
>  (1) firstly, there is an optimised assembly version of cts(cbc(aes)) on
>      x86_64 that should be used instead of having two ciphers;
> 
>  (2) secondly, none of the hardware offload drivers seem to offer CTS
>      support (Intel QAT does not, for instance).
> 
> However, I don't know if it's possible to query the crypto API to find out
> whether there's an optimised CTS algorithm available.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

...

> diff --git a/crypto/krb5enc.c b/crypto/krb5enc.c

...

> +static int krb5enc_verify_hash(struct aead_request *req, void *hash)
> +{
> +	struct crypto_aead *krb5enc = crypto_aead_reqtfm(req);
> +	struct aead_instance *inst = aead_alg_instance(krb5enc);
> +	struct krb5enc_instance_ctx *ictx = aead_instance_ctx(inst);
> +	struct krb5enc_request_ctx *areq_ctx = aead_request_ctx(req);
> +	struct ahash_request *ahreq = (void *)(areq_ctx->tail + ictx->reqoff);
> +	unsigned int authsize = crypto_aead_authsize(krb5enc);
> +	u8 *ihash = ahreq->result + authsize;
> +
> +	scatterwalk_map_and_copy(ihash, req->src, ahreq->nbytes, authsize, 0);
> +
> +	if (crypto_memneq(ihash, ahreq->result, authsize))
> +		return -EBADMSG;
> +	return 0;
> +}
> +
> +static void krb5enc_decrypt_hash_done(void *data, int err)
> +{
> +	struct aead_request *req = data;
> +
> +	if (err)
> +		return krb5enc_request_complete(req, err);
> +
> +	err = krb5enc_verify_hash(req, 0);

Hi David,

Sparse complains that the second argument to krb5enc_verify_hash should be
a pointer rather than an integer. So perhaps this would be slightly better
expressed as (completely untested!):

	err = krb5enc_verify_hash(req, NULL);

> +	krb5enc_request_complete(req, err);

...
> +}

