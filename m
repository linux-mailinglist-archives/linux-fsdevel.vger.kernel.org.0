Return-Path: <linux-fsdevel+bounces-41326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3724FA2DFF6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68A41644C0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A81E2842;
	Sun,  9 Feb 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2lEwSyf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68741E1C26
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739126267; cv=none; b=tsqRq33ChZuXfBkzysxY8mq9ATknFfplnTWvum6Wb/jEHHkWp9uVro6K97ATn/ipOqXTmPqm5BJs8QCf2uAjU+Nre09/ifg5d2vLDma+AFY2S1A0TXmy3oi4CeT5L0pOCil8gTdANnUAqFwuvFQxZGf8zkQJ8FxkOwTpgAApXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739126267; c=relaxed/simple;
	bh=+R5hmvby4rURT6eQvIKzIU/KdJg5Pg2WpoRYG4Nfcwo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=oBKrTvpzskkJoNybXskDXamYIjUEMiQzFDutFvtZnVC1aIKIiCzGS/a/20PUw4mPP0diiY/s1vINfGDjnDiDUE1vMnTIFCmpPLgxTHtMlpwYcspZYKvDnHINP45pCStdiwp8eqVXNaFkLvnRuEbkRILF1iHQtUwZHEmHBbqxzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2lEwSyf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739126264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yeKHY3kqqpKK/oe6W5i7RsCpjq6SzyOE1dYoJ1K3Ffg=;
	b=G2lEwSyfJ/GKbSeBTeke5/ZTJJkXxiy68NYUfru94yPrbOVi6+iDxIRJYYPJ1pj1cYtYw7
	twAxU1MQiSvvF63JMdqu1awb87EoJBVofTELVLdU9F+kDlWIk9hSbaD085hTW5RE2+02f3
	qg2tYBbR/0BmPjImAN2qKQJ1OPnuTNQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-NUQ0wdEmOKu5Q7xu5vcayw-1; Sun,
 09 Feb 2025 13:37:39 -0500
X-MC-Unique: NUQ0wdEmOKu5Q7xu5vcayw-1
X-Mimecast-MFC-AGG-ID: NUQ0wdEmOKu5Q7xu5vcayw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2BB119560AA;
	Sun,  9 Feb 2025 18:37:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4D76180087A;
	Sun,  9 Feb 2025 18:37:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250207200419.GA2819332@google.com>
References: <20250207200419.GA2819332@google.com> <20250203142343.248839-1-dhowells@redhat.com> <20250203142343.248839-4-dhowells@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Herbert Xu <herbert@gondor.apana.org.au>,
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
Subject: Re: [PATCH net 03/24] crypto: Add 'krb5enc' hash and cipher AEAD algorithm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1934771.1739126247.1@warthog.procyon.org.uk>
Date: Sun, 09 Feb 2025 18:37:27 +0000
Message-ID: <1934772.1739126247@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Eric Biggers <ebiggers@kernel.org> wrote:

> Linux's "cts" is specifically the CS3 variant of CTS (using the terminology
> of NIST SP800-38A https://dl.acm.org/doi/pdf/10.5555/2206248) which
> unconditionally swaps the last two blocks.  Is that the variant that is
> needed here?

It's what NFS/SunRPC does and what works with the AuriStor YFS/AFS RxGK
implementation, so I presume so.

> SP800-38A mentions that CS3 is the variant used in Kerberos 5,
> so I assume yes.  If yes, then you need to use cts(cbc(aes))
> unconditionally.  (BTW, I hope you have some test that shows that you
> actually implemented the Kerberos protocol correctly?)

Depends what you mean by "the Kerberos protocol", I suppose.  I took the
kerberos implementation from net/sunrpc/ and genericised it a bit so that I
could also use it for net/rxrpc/ and added AES+SHA2 and Camellia.  It doesn't
use the Kerberos communications protocol per se, just the encryption formats.

To test this, I added test vectors for to crypto/testmgr.h and gave the krb5
lib its own selftests since those can do more comprehensive testing than the
testmgr.  Note that I didn't find test vectors for AES+SHA1 that I could use,
so I haven't added those.  I could generate some, by printing samples
generated by my code - but that's kind of circular:-/

On top of that, I've tested the code by running xfstests, git checkouts and
kernel builds against an AuriStor YFS server with an RxGK key - so it at least
agrees with that server's expectations.

> x86_64 already has an AES-NI assembly optimized cts(cbc(aes)), as you
> mentioned.  I will probably add a VAES optimized cts(cbc(aes)) at some
> point; I've just been doing other modes first.

One of the issues I have with doing it on the CPU is that you have to do two
operations and, currently, they're done synchronously and serially.

Can you implement "auth5enc(hmac(sha256),cts(cbc(aes)))" in assembly and
actually make the assembly do both the AES and SHA at the same time?  It looks
like it *might* be possible - but that you might be an XMM register short of
being able to do it:-/

> I don't see why off-CPU hardware offload support should deserve much
> attention here, given the extremely high speed of on-CPU crypto these days
> and the great difficulty of integrating off-CPU acceleration efficiently.
> In particular it seems weird to consider Intel QAT a reasonable thing to use
> over VAES.

Because some modern CPUs come with on-die crypto offload - and that can do
hash+encrypt or encrypt+hash in parallel.  Now, there are a couple of issues
with using the QAT here:

 (1) It doesn't support CTS.  This means we'd have to impose the CTS from
     above - and that may well make it unusable in doing hash + encrypt
     simultaneously.

 (2) It really needs batching to make it cheap enough to use.  This might
     actually be less of a problem - at least for rxgk.  The data is split up
     into fixed-size packets, but for a large amount of data we can end up
     filling packets faster than we can transmit them.  This offers the
     opportunity to batch them - up to ~8192 packets in a single batch.

For NFS, things are a bit different.  Because that mostly uses a streaming
transport these days, it wants to prepare a single huge message in one go -
and being able to parallellise the encrypt and the hash could be a benefit.

David


