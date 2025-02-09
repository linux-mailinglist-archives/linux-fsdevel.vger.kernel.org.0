Return-Path: <linux-fsdevel+bounces-41336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7EEA2E020
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 20:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A053A5E77
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E005A1E2602;
	Sun,  9 Feb 2025 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJVgBgpK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D7713B7A3;
	Sun,  9 Feb 2025 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739127928; cv=none; b=XRbPCIfAogwYxvjKAKOxnZMjh+FxYLa/GOw0sPHVOcDH0U3UKUKcsDs6hRzSz+C/mVA6bcaYBuwkdHV7jYJGJ9JA+Zxyz9p2Vt4W0RhtcfqrNaENNWiyPdL+VPvnKFl7tUQXpZOgzUXtqUFRggo4tEsRPXCaeQXBn1WVWwIy8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739127928; c=relaxed/simple;
	bh=natJcidB7q3O8woW65n2ijBytWe0W+0jkr1HKsigs5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKY0+sTGVzcgQZ7XwNUMxyD6zd4UUNke+ajkkAU8vDh1XmTqwFLKgazVQ68BhHJ8aOnAKiR/81UIPFm+VaF5DHYrEpEsEzrR822Onio96YRdtCHxBfOLzDO/JXN8P8/nVF9AG1AojeqA7+uwhDXK51XQLyuUCtpetYWvFjzRdro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJVgBgpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082BAC4CEDD;
	Sun,  9 Feb 2025 19:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739127927;
	bh=natJcidB7q3O8woW65n2ijBytWe0W+0jkr1HKsigs5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJVgBgpK/Wrib4Ot1ITnWyLr/M9lHiSwNDfQztynIRSmG/2QoUlAq3TuVHHLSNpMH
	 17YzI74Zrp+QZm8F1qw2mzEb92pCmSPzdsegZA6Wpd2HvFm67PWAVvxSFnyKy6/++l
	 j76BA8Y+63msoJJYEIJulprPti90jnbJ7DUhQ5q/hZR2mwSVLT9pWV8+dwMgVzcD+Y
	 RqxYHsM207TqKSYdVd8Y/16alDEznDG2zTt8/dBFnLifjEVfvV/pKfgiSydudMC9NV
	 qyjDtrA8NPfijmkQokMfbM7+s8GXffc4PlSVcEs3HyNnMVawIuh6EArXN5kU9BS7Xs
	 4HBcqh+rilkJg==
Date: Sun, 9 Feb 2025 11:05:25 -0800
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
	Ard Biesheuvel <ardb@kernel.org>,
	"Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
	qat-linux <qat-linux@intel.com>, linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 03/24] crypto: Add 'krb5enc' hash and cipher AEAD
 algorithm
Message-ID: <20250209190525.GA6017@sol.localdomain>
References: <20250207200419.GA2819332@google.com>
 <20250203142343.248839-1-dhowells@redhat.com>
 <20250203142343.248839-4-dhowells@redhat.com>
 <1934772.1739126247@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1934772.1739126247@warthog.procyon.org.uk>

On Sun, Feb 09, 2025 at 06:37:27PM +0000, David Howells wrote:
> One of the issues I have with doing it on the CPU is that you have to do two
> operations and, currently, they're done synchronously and serially.
> 
> Can you implement "auth5enc(hmac(sha256),cts(cbc(aes)))" in assembly and
> actually make the assembly do both the AES and SHA at the same time?  It looks
> like it *might* be possible - but that you might be an XMM register short of
> being able to do it:-/

Yes, that would be the proper way to optimize that algorithm.  Someone just
needs to do it.  (And presumably you want this one and not Camellia which you
are also pushing for some reason?)

> > I don't see why off-CPU hardware offload support should deserve much
> > attention here, given the extremely high speed of on-CPU crypto these days
> > and the great difficulty of integrating off-CPU acceleration efficiently.
> > In particular it seems weird to consider Intel QAT a reasonable thing to use
> > over VAES.
> 
> Because some modern CPUs come with on-die crypto offload - and that can do
> hash+encrypt or encrypt+hash in parallel.  Now, there are a couple of issues
> with using the QAT here:
> 
>  (1) It doesn't support CTS.  This means we'd have to impose the CTS from
>      above - and that may well make it unusable in doing hash + encrypt
>      simultaneously.
> 
>  (2) It really needs batching to make it cheap enough to use.  This might
>      actually be less of a problem - at least for rxgk.  The data is split up
>      into fixed-size packets, but for a large amount of data we can end up
>      filling packets faster than we can transmit them.  This offers the
>      opportunity to batch them - up to ~8192 packets in a single batch.
> 
> For NFS, things are a bit different.  Because that mostly uses a streaming
> transport these days, it wants to prepare a single huge message in one go -
> and being able to parallellise the encrypt and the hash could be a benefit.

Right, the batching is always a huge issue for those types of accelerators.  A
much more promising approach is to just fully take advantage of the CPU
instructions that already accelerate the same algorithms very well.

- Eric

