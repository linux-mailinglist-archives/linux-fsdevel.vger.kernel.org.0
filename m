Return-Path: <linux-fsdevel+bounces-38872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F83A09394
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 15:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA24163C0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8551621129D;
	Fri, 10 Jan 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQ5/5lA1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7C210F53
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519631; cv=none; b=W1MFpNQQxabmnFxluH8rw4Znmc0CLEnc2SdGm+iDJThlzTMOYeDEhy5Wy6qtW0ZlMMuXdW0+Cs0+Fi9kp4TwrA0SO/CtqbslVGzrogFn5urMHhBdOwDo/XxcYk7PvUifxdzK+6EDkRFmZueK9riyjqUcN8pkhXJhbjIwCGiBRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519631; c=relaxed/simple;
	bh=sIPxDEapCmOFF0UUJ050CZ52VknWeMjqbJ4QpXvzgJU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ZnB6oAbhQMCDd30dKoUvcA/733vwWPPstk0KOq5P1O7HeCALm0f92himbK9dqITHLc0qjr/Th1vc0glRmKP84oW9dEvGfcKL1iwn2UiReT3CBPCJf1erbVGHLp50YGfGaEQF8B+gSr6cALs/qw05KjwqEZYDfnF8f2f/pDtYiZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQ5/5lA1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736519629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+rt9KmUBZuQERAo92PycxKqQH9U6iO8IHFEaXObSX4=;
	b=WQ5/5lA1aebvyGHe9PdW+8yKnobz/jwoXSNl2fu1X11S2PaMEkujVngYN3VeXnDzX6e+MZ
	mZADpBhXWUTC6z/nVeimBCTw2QDa4EHVxQXE/Haah1v4h1QoRekOOMAYicoLh4KDeTrvFB
	ge9YWQ0qrDnIVd35UKJHhotnh8XYkjc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-Qi0gWsesM1K1XCb9hZkTEg-1; Fri,
 10 Jan 2025 09:33:46 -0500
X-MC-Unique: Qi0gWsesM1K1XCb9hZkTEg-1
X-Mimecast-MFC-AGG-ID: Qi0gWsesM1K1XCb9hZkTEg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF5A51954194;
	Fri, 10 Jan 2025 14:33:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93BE71955BE3;
	Fri, 10 Jan 2025 14:33:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAMj1kXE2mhXJaa9uq==Xki3On9ZKYY+KV-oH0ednqWC6b9BTYw@mail.gmail.com>
References: <CAMj1kXE2mhXJaa9uq==Xki3On9ZKYY+KV-oH0ednqWC6b9BTYw@mail.gmail.com> <20250110010313.1471063-1-dhowells@redhat.com> <20250110010313.1471063-3-dhowells@redhat.com> <20250110055058.GA63811@sol.localdomain> <1478993.1736493228@warthog.procyon.org.uk>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: dhowells@redhat.com, Eric Biggers <ebiggers@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Chuck Lever <chuck.lever@oracle.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    "David S. Miller" <davem@davemloft.net>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-crypto@vger.kernel.org, qat-linux <qat-linux@intel.com>,
    linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] crypto/krb5: Provide Kerberos 5 crypto through AEAD API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1494599.1736519616.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jan 2025 14:33:36 +0000
Message-ID: <1494600.1736519616@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Ard Biesheuvel <ardb@kernel.org> wrote:

> What is the reason for shoehorning any of this into the crypto API?

I was under the impression that that was what Herbert wanted.

> I agree with Eric here: it seems both the user (Kerberos) and the
> crypto API are worse off here, due to mutual API incompatibilities
> that seem rather fundamental.

My original take on this was to take the sunrpc code and turn it into a
library, placing that library in the crypto/ directory:

	https://lore.kernel.org/linux-crypto/160518586534.2277919.144756386536802=
31924.stgit@warthog.procyon.org.uk/

The crypto/ dir seems the right home for it (and not net/ or lib/), but th=
e
way it's implemented here, it's a user of the crypto API, but does not its=
elf
implement it.

That said, it would be convenient if if *could* be part of the crypto API =
in
some way.  As I outlined in one of my responses to Herbert, there are a nu=
mber
of advantages to doing that.

> Are you anticipating other, accelerated implementations of the
> combined algorithms?

I think one can be done with x86 AES and SHA instructions provided there a=
re
sufficient registers.

> Isn't it enough to rely on the existing Camellia and AES code?

The problem is that you have to do *two* crypto operations - and that it m=
ay
not be possible to parallellise them.  With AES+SHA1 and Camellia, they ca=
n be
parallellised as both sides work on the plaintext; but with the AES+SHA2, =
the
encryption is done and then the *encrypted* output is checksummed.

Note that "parallellising" might mean launching an async hash request and =
an
async skcipher request and then waiting for both to finish.  This can't,
however, be done unless the output buffer is separate from the input buffe=
r.

> Mentioning 'something like the Intel QAT' doesn't suggest you have somet=
hing
> specific in mind.

I have an Intel QAT card, and under some circumstances I could offload the
crypto to it...  But the only operations the driver currently makes availa=
ble
are:

	authenc(hmac(sha1),cbc(aes))
	authenc(hmac(sha256),cbc(aes))
	authenc(hmac(sha512),cbc(aes))

The first one can't be used for kerberos's aes128-cts-hmac-sha1-96 as it
hashes the ciphertext, not the plain text.  I don't have anything that use=
s
the third.  The second is a possibility.  I think that could probably do
aes128-cts-hmac-sha256-128.

Now, it's possible that the QAT device range can do more than the driver
offers.  I'm presuming that the driver offers what IPsec wants to support.
Also, waving these ideas in front of Intel devs might expand the range of =
what
future QATs can do ;-)

Mostly, though, by "something like" I was just offering the possibility th=
at
other architectures or crypto cards may also offer usable services - but I
haven't investigated.

> Also, this patch is rather big and therefore hard to review.

Yeah.  Mostly I wanted to wave it in front of Herbert before expending the
effort to slice it up.  Sadly, it doesn't seem that what I came up with is
what he wanted.

David


