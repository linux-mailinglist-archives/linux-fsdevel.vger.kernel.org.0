Return-Path: <linux-fsdevel+bounces-41371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA8BA2E612
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 09:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219B916273A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 08:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4431BCA1C;
	Mon, 10 Feb 2025 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="RPntgzGD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442DF18E764;
	Mon, 10 Feb 2025 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175075; cv=none; b=aaGBgFLQ9B1qIN7b7KXlEslqLL2EOSnXIVBqPQS1cIwJxuxrXTPtvZsp8EjjEuxOEXYysBhlF8FOCRi2SO+bsjTz06q/Ca+WXp8WvJikdb/rP5vWCAxm9fpAFqe7nJYJDMgjCQAbek8VM4B+GSLToPl5s0bxvq7MfmOpwazMblY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175075; c=relaxed/simple;
	bh=zuqJQylTq4neHnU/MvGUQZGDKz2jD1Qz4h91sh4A/xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xahue2i4kZtudBnXIJmwUvfTNeJKjJkfM5uhXODXTAoCskYiD9XQ3aHnqElA1SVAAAp9JPa9JjTF+1XHa1Hbq5DD3gUWp9c/ZgVWhaXu9QcNZNezSH2b5KH8+NdRoJipDLt7eqy5BPNbJpnT6/ERID2HqhBxgTMBPJsEK9depF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=RPntgzGD; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=U01uS+0yDujzAsWBjGqN0xojmmeCjhBYgqHkcf2iILk=; b=RPntgzGDU9DUcWxsiRGXCxhrjm
	8T11R3hnBoSCZawmN7ynGlmD6T7Ees+76NCYZwSoEA4EA4SzU2eUzJf2VDY2PCeIEv3MEtEXZAsS5
	+1vTzp705s47EZBPcGuG9KyqZfZyfTHNpC9v0dbjp8mR3Ud1qCNsW7gfN69HzSaW2Hn8UOiqUsOeW
	uO0MryNb80IY7qiEX+1xEhRwgYMpM11RHwUv2gVpYDDWTgBnE9oQ3S1pY/2D4XIdWtIqyAkfURh9X
	I5kGA4n8altY9Avwg8DGHVN9flU+0hdaQuCOY9Z3wXOwlqWT27GOXJBQ1KBAH3y5Ztz4oJIU/9kBL
	848cybXw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1thOfL-00Gd9s-2s;
	Mon, 10 Feb 2025 16:10:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 10 Feb 2025 16:10:36 +0800
Date: Mon, 10 Feb 2025 16:10:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org,
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
Message-ID: <Z6m0fFH2p5YpKiFX@gondor.apana.org.au>
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
>
>  (2) It really needs batching to make it cheap enough to use.  This might
>      actually be less of a problem - at least for rxgk.  The data is split up
>      into fixed-size packets, but for a large amount of data we can end up
>      filling packets faster than we can transmit them.  This offers the
>      opportunity to batch them - up to ~8192 packets in a single batch.

Hopefully this will become a solved problem once my request chaining
work is complete.  This should allow you to provide enough data that
even something slow like PCI offload can work.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

