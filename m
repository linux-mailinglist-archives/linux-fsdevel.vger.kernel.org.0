Return-Path: <linux-fsdevel+bounces-38803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A590CA08706
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 06:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA7E7A34C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 05:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26571206F06;
	Fri, 10 Jan 2025 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5QK1Yek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659932066C5;
	Fri, 10 Jan 2025 05:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488261; cv=none; b=DherLUb55GCkOWcj/OzKG/hON1xAKVV3MQHIiBY1gDPtNJOvoawfChC1XALYhXFmg9DUavebzEOGObFwMpH8nTbYjFBzojOhMWUzM4jfu8SryH3D0DS6+X3tjfvczBFKzyLdk44sZo0rnKqmx/i3VpUaTxqQePe39i6FSYdCDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488261; c=relaxed/simple;
	bh=7sJiEOL3Ux62LKGv8xXhL54o9Pz33Hn7gDl29c46DwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5/1a+/Dh7ujepSWwISMi1KXZk6FD5dqXvFbXDr2B/2lG7cuFdAd8IHnnh5i+qgHNtHXiUGalzf2Koq2D74lnJsJIKcDwB4ufocCXtmJOD5/zXFh6CLNCl6QnGl9BVj3EpyhLfUDyjR/zxeF5MrWr9wb002xFEPnUBIipvNjo4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5QK1Yek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67469C4CED6;
	Fri, 10 Jan 2025 05:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736488260;
	bh=7sJiEOL3Ux62LKGv8xXhL54o9Pz33Hn7gDl29c46DwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5QK1Yek3RTfhgGNF+pIqM2veo1fVnghWV3IiY68a3TMzmAMwyydTgNyyUlfcgRqK
	 nVKsg5tnSUua0yHK7R12kH7lTu4dm5z9A2rLP8ajDlIWSRp5VCxaPsyIu7PaboUF0T
	 vWcKdKkfmun11iexfHJ2E4E7SY11SVuRsuGfx6yit82fq4HecqpIYq34JKuPtID03n
	 YK+aNE8o8pbsUA7D38V6wSclxKtGXTDTy1a+f5Ezi2gDeKmZOv/d0M+5msvJteEuuy
	 TpzBQIYuCDEXM8NGVZ4lDJYkh8LjcUKF5ZxN7HOzGeMbfZ/6WJ/mPy5mPqblYtaUoO
	 JHQDeoK7haarA==
Date: Thu, 9 Jan 2025 21:50:58 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Chuck Lever <chuck.lever@oracle.com>,
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
Message-ID: <20250110055058.GA63811@sol.localdomain>
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
> Use the AEAD crypto API to provide Kerberos 5 crypto, plus some
> supplementary library functions that lie outside of the AEAD API.
> 
> The crypto algorithms only perform the actual crypto operations; they do
> not do any laying out of the message and nor do they insert any metadata or
> padding.  Everything is done by dead-reckoning as the AEAD API does not
> provide a useful way to pass the extra parameters required.
> 
> When setting the key on a crypto algorithm, setkey takes a composite
> structure consisting of an indication of the mode of transformation to be
> applied to the message (checksum only or full encryption); the usage type
> to be used in deriving the keys; an indicator indicating what key is being
> presented (K0 or Kc/Ke+Ki); and the material for those key(s).  Based on
> this, the setkey code allocates and keys the appropriate ciphers and
> hashes.
> 
> When dispatching a request, both checksumming (MIC) and encryption use the
> encrypt and decrypt methods.  A source message, prelaid out with
> confounders or other metadata inserted is provided in the source buffer.
> The cryptolen indicates the amount of source message data, not including
> the trailer after the data (which includes the integrity checksum) and not
> including any associated data.
> 
> Associated data is only used by checksumming encrypt/decrypt.  The
> associated data is added to the checksum hash before the data in the
> message, but does not occupy any part of the output message.
> 
> Authentication tags are not used at all and should cause EINVAL if used (a
> later patch does that).
> 
> For the moment, the kerberos encryption algorithms use separate hash and
> cipher algorithms internally, but should really use dual hash+cipher and
> cipher+hash algorithms if possible to avoid doing these in series.  Offload
> off this may be possible through something like the Intel QAT.

It sounds like a lot of workarounds had to be implemented to fit these protocols
into the crypto_aead API.

It also seems unlikely that there will be other implementations of these
protocols added to the kernel, besides the one you're adding in crypto/krb5/.

Given that, providing this functionality as library functions instead would be
much simpler.  Take a look at how crypto/kdf_sp800108.c works, for example.

- Eric

