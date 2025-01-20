Return-Path: <linux-fsdevel+bounces-39742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABFFA173CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 21:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD51B1885472
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F4D1F0E26;
	Mon, 20 Jan 2025 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMqMYQjM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B701F03DF;
	Mon, 20 Jan 2025 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737406044; cv=none; b=NNJv9Xg9tSgaDdLwnk1S05O6b981wz+lQvxFKx4+1dFaeolcOsEUQG4i7nMdkpIfQUUKauxg2dzpxQlr1Tg48BrRbTn83684WpmuCFn2dkIjfPjmb4bcjC5fqMo/1Z5c0xNJZeQQwxMoUeulfmtixpHxpqCb85hrS/5G1/XI6Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737406044; c=relaxed/simple;
	bh=MoDpvrlbktc0ZMsXkSWxxY4ig0rqpNF5iThW90x655o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzU2Rm0q7qJ+nvaXH1mw7vvAKYu5SKFONbEtYvINnXI2C6mm77efelFQ1K28YUMeq6J+gYpaPTD5Ff4GOUpcyWv8pT4omuzr4aTffWgQda6z/nFJgniZUwysGcOF5OcruGh3Ti0DRFMtZ+HPCjVQ10MpNQqq3GiVcnH7MbN0J6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMqMYQjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C32C4CEE3;
	Mon, 20 Jan 2025 20:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737406043;
	bh=MoDpvrlbktc0ZMsXkSWxxY4ig0rqpNF5iThW90x655o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMqMYQjMaJTRuMTACTw6Wyc8xEn4k+gJEGHaBdNyb2+6mlms2HLtHSjue6lnLaxsc
	 UXtxQSJoN8EKXj9dWA5B/oYvNfhd3sTyhUQMWfQgJPAz43gu90LzOJ3Lix+86N/yZR
	 LcHRurorkvLdGQ+UeW35HHYwMIp8HP6qjr6LunkG1atLLn0cFVQtKCm6sV9oXWTF3C
	 qpwdcChDm5sHrqdPc7P5W2CxSOqdvlu5ds/LWbHqBdbuRGi5CBvwId3pd2zku1/0sv
	 07N6zDqAnNRwQeIcVPJwbP+zRZ6ykBUmwe9S9cOo0m2aPKQO8p3+VAvN01TUVVyGKr
	 9reSJ22Cz+BRw==
Date: Mon, 20 Jan 2025 12:47:21 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/24] crypto: Add 'krb5enc' hash and cipher AEAD
 algorithm
Message-ID: <20250120204721.GA53305@sol.localdomain>
References: <20250120191250.GA39025@sol.localdomain>
 <20250120173937.GA2268@sol.localdomain>
 <20250120135754.GX6206@kernel.org>
 <20250117183538.881618-1-dhowells@redhat.com>
 <20250117183538.881618-4-dhowells@redhat.com>
 <1201143.1737383111@warthog.procyon.org.uk>
 <1212970.1737399580@warthog.procyon.org.uk>
 <1215834.1737404294@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1215834.1737404294@warthog.procyon.org.uk>

On Mon, Jan 20, 2025 at 08:18:14PM +0000, David Howells wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > In any case, why would you need anything to do asynchronous at all here?
> 
> Because authenc, which I copied, passes the asynchronocity mode onto the two
> algos it runs (one encrypt, one hash).  If authenc is run synchronously, then
> the algos are run synchronously and serially; but if authenc is run async,
> then the algos are run asynchronously - but they may still have to be run
> serially[*] and the second is dispatched from the completion handler of the
> first.  So two different paths through the code exist, and rxgk and testmgr
> only test the synchronous path.

No, it goes in the other direction.  The underlying algorithms decide whether
they are asynchronous or not, and that gets passed up.  It sounds like what you
want to do is test your template in the case where the underlying algorithms are
asynchronous.  There is a way to do that by wrapping the underlying algorithms
with cryptd.  For example the following works with gcm:

python3 <<EOF
import socket
s = socket.socket(socket.AF_ALG, 5, 0)
s.bind(("aead", "gcm_base(cryptd(ctr(aes-generic)),cryptd(ghash-generic))"))
EOF

This really should just be thought of as complying with the outdated design of
the crypto API, though.  In practice synchronous is the only case that really
matters.

> [*] Because in authenc-compatible encoding types, the output of the encryption
> is hashed.  Older krb5 encodings hash the plaintext and the hash generation
> and the encrypt can be run in parallel.  For decrypting, the reverse is true;
> authenc may be able to do the decrypt and the hash in parallel...  But
> parallellisation also requires that the input and output buffers are not the
> same.

The right way to optimize cases like that is to interleave the two computations.
Look at how the AES-GCM assembly code interleaves AES-CTR and GHASH for example.
Doing something with async threads is the completely wrong solution here and
would be much slower.  The amount of time needed to process a single message is
simply far too short for multithreading to be appropriate on a per message
basis.

- Eric

