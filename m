Return-Path: <linux-fsdevel+bounces-38854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D30A08D3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 11:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B209167D07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1722D20B1E0;
	Fri, 10 Jan 2025 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="s1YN9F4J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC320ADD7;
	Fri, 10 Jan 2025 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503378; cv=none; b=It8qc6hny1u4pdZIMXXoGkmj+8yEWES2WCHXOV83PgoQadMLu7NyckGABDG+5O0pDYeUe+fC1C1ZS89961FaDBE1sLEMRIOwUQKxZW0DO0ifMMNsyBNrThJe98vBTqcDaezSOAGk34hLpy4MoakVuDYFe1DSR6KUGOPBmnfrI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503378; c=relaxed/simple;
	bh=tqs0+paK0NvHbEBfE2HlZAXYGEfQUXwFsV6dBotUaxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1tv1//2YazckfsI5IzuYwhu6P0eV82fCcF7eXMtHY5Icvw44UqsPXVCa6hhUBXpogHdESddnEZJVyqCy59e8IlbIBztkBu1hI71eerPpMo85fQBpa5scsCWkGGAhZkJTaYzr0prsWFfOcTFqYbiyogwzLQ8b3vDX2N1IWMI1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=s1YN9F4J; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1m1KB9AdbQNDslVOCwIrJ7po0oY3YsOSAHFrY0T0XQ0=; b=s1YN9F4JvRrqu6FDvfABUotkXX
	egyLmcrPJPZfrXr2UQ5Dyr8p7yDTwePCApUywf6STJ3MAex65qemnLMtVseIPKnMr4Ko5xlz/nQtE
	OXW1tCi9yDOao/RKEZ3pychAw8U9DFkZ6h3aq6j7pBwRCIAvv3xCIhInMeav290M8K5t5tQJn3vG/
	X8BKessJ7xqR/J+N03lVm9w8bXBeUoj/NNgqtVLSxJp2g0weFFsxJiMcMTen7RqGIENf1chB6SiO6
	wxhgy2C8Gm/CoDUZ8rcIADN6yxNTll4YV5nw02Wg1xLyTP0z11hqKHS2nY4YQ5vlnCbRtNC65k3dG
	1YuMv73Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tWBdb-007npH-15;
	Fri, 10 Jan 2025 18:02:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Jan 2025 18:02:28 +0800
Date: Fri, 10 Jan 2025 18:02:28 +0800
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
Message-ID: <Z4DwNPgLFcfy6jdl@gondor.apana.org.au>
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
> Authentication tags are not used at all and should cause EINVAL if used (a
> later patch does that).

What do you mean by this? The authentication tag is the checksum
that you're referring to and you appear to be using it in the rfc8009
encrypt/decrypt functions.

> For the moment, the kerberos encryption algorithms use separate hash and
> cipher algorithms internally, but should really use dual hash+cipher and
> cipher+hash algorithms if possible to avoid doing these in series.  Offload
> off this may be possible through something like the Intel QAT.

Please elaborate on what you mean by this.  For IPsec, the main
benefit with reframing cbc(aes)+hmac as aead is having a single
code-path that supports both types of algorithms.

So does your use-case support both standard AEAD algorithms such
as GCM as well as these legacy algorithms?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

