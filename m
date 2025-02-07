Return-Path: <linux-fsdevel+bounces-41254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7A4A2CD84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 21:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE959188CA79
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 20:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35EB1A3143;
	Fri,  7 Feb 2025 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5IPLDS1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FC18C930;
	Fri,  7 Feb 2025 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958662; cv=none; b=q6sgQqFxE8LPlBdSD67UoigQV+QkPWEfU5AZGau43yfai0xmyw5IJKdZjMZzHyg8X8qQMCs9zRXcFxQ97lWzelDKPYN2Q6kjyCtZP76atAibNqwXAJMqdYTk/iJA32L5cFOu4py489xTkxXtKjTOrlW21Tw2/bEhV6mVTQa3QjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958662; c=relaxed/simple;
	bh=V/d0cHVmH87BvmOD994J3enMdP4akQHipKqVYK9lI+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKKKSUOkvhAzx34fQAnlCwHcUwpvikTyx65VL1lIT3Mr/BtXT3BrKH2dFUNMwgKIK43p8jWQXdSAzjkkCSANVQLkEJr17WzMJsC5Hn4SozCJL4zh7pVpAWwHBLK0CG0sShTj8HvG9PocWe7rKi9WS360BzvVxOu/GSy2ZTWLgvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5IPLDS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C742C4CED1;
	Fri,  7 Feb 2025 20:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738958661;
	bh=V/d0cHVmH87BvmOD994J3enMdP4akQHipKqVYK9lI+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5IPLDS1OfDoymxXg1xTZN0El7zvLcoyuS18V+fkNQyxEQyMCBRZPn7hbKjNuwYOB
	 brbI/QyMHmPyQnUTKkz6tV7c90QQeIxyYg53bH3NVtJePTiRpjvRVdGJftED+97zMZ
	 aQH1e+IB+APL3n4or51dNWIHUa6VGWa5rzgrfzN79itYImyABatpR9uPwiww/UvhL1
	 kTOiiNoOvG5bScnHYzyDOtWsK3dXk/F9aQLSg5fSbZ+gQsWgKUIcXce0pIqJpHw30b
	 R5fm/5WgoxPIk5fJKM8z8icyI4pjH08MBnD3XK8cTnCzQr3VM8Hsi/y4V6CdFD9KUD
	 3gRfoXesMl7nQ==
Date: Fri, 7 Feb 2025 20:04:19 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 03/24] crypto: Add 'krb5enc' hash and cipher AEAD
 algorithm
Message-ID: <20250207200419.GA2819332@google.com>
References: <20250203142343.248839-1-dhowells@redhat.com>
 <20250203142343.248839-4-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203142343.248839-4-dhowells@redhat.com>

On Mon, Feb 03, 2025 at 02:23:19PM +0000, David Howells wrote:
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

Linux's "cts" is specifically the CS3 variant of CTS (using the terminology of
NIST SP800-38A https://dl.acm.org/doi/pdf/10.5555/2206248) which unconditionally
swaps the last two blocks.  Is that the variant that is needed here?  SP800-38A
mentions that CS3 is the variant used in Kerberos 5, so I assume yes.  If yes,
then you need to use cts(cbc(aes)) unconditionally.  (BTW, I hope you have some
test that shows that you actually implemented the Kerberos protocol correctly?)

x86_64 already has an AES-NI assembly optimized cts(cbc(aes)), as you mentioned.
I will probably add a VAES optimized cts(cbc(aes)) at some point; I've just been
doing other modes first.  I don't see why off-CPU hardware offload support
should deserve much attention here, given the extremely high speed of on-CPU
crypto these days and the great difficulty of integrating off-CPU acceleration
efficiently.  In particular it seems weird to consider Intel QAT a reasonable
thing to use over VAES.  Regardless, absent direct support for cts(cbc(aes)) the
cts template will build it on top of cbc(aes) anyway.

- Eric


