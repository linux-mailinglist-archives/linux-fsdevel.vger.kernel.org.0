Return-Path: <linux-fsdevel+bounces-38859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26625A08E31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 11:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF051885C2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB06920B7E9;
	Fri, 10 Jan 2025 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPqE9zwx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0D20B209
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505581; cv=none; b=U1xy8zY+Xtu+wMHUmqOUgUcpIsWtDMLM9gCskh9+xG8pbhBhBflja0lEFUKXEf/RahaToLtXuVwwrSRWAT07D2FlyD+dYa6KRJp6x6kVYwZVPDrlRzMFpkZUZdYso5Ia3Ro2NKmsrnNADEjW2orWpaKIwV2QBI3hH7GD5k7/PJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505581; c=relaxed/simple;
	bh=nYDjkt082ildk9SUT5EE02LseEO5BIkZJJJ6bwirLvE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=OJE52xR0Ea8q8LMxjdPvevHYJ6lXb7yLq04HoHBmyj1kDEl3xWHLMLVsfe86rJ8scdn0AD0NJScvfghhnRngN+OFZlFHfUuqozSYvFpDRQfnfrh4ikrukyTnBuOsCr+xQJPKM2MdgvFNTA5A3wLZUxS5iLQUM/t9gfsSJQ+Y0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPqE9zwx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736505578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MKaycnXaFEmpfKgijz27DS1Sq3Bh5gIarl2yz5IREPo=;
	b=LPqE9zwxJbXWRKBE+swfjfkoLqIic6ocVtJu5esjIM/dfDjI7Yjw2KKS2VuoBLN223HTLh
	1u4F/fMtL1GfhsvsubEEN+eoUZ1Hm0KbgxIM6pMVm5OCDFUCKUdCA6OQ1KMVSjvZP9U5Yx
	0PfNSWTZQiEFRAgKMKBg/p/zo0Qiah0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-T1V8_oFHP_6PaqDXB6vHkw-1; Fri,
 10 Jan 2025 05:39:35 -0500
X-MC-Unique: T1V8_oFHP_6PaqDXB6vHkw-1
X-Mimecast-MFC-AGG-ID: T1V8_oFHP_6PaqDXB6vHkw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C13319560A2;
	Fri, 10 Jan 2025 10:39:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1769830001BE;
	Fri, 10 Jan 2025 10:39:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Z4DwNPgLFcfy6jdl@gondor.apana.org.au>
References: <Z4DwNPgLFcfy6jdl@gondor.apana.org.au> <20250110010313.1471063-1-dhowells@redhat.com> <20250110010313.1471063-3-dhowells@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, Chuck Lever <chuck.lever@oracle.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    "David S. Miller" <davem@davemloft.net>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] crypto/krb5: Provide Kerberos 5 crypto through AEAD API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1486112.1736505567.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jan 2025 10:39:27 +0000
Message-ID: <1486113.1736505567@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> > Authentication tags are not used at all and should cause EINVAL if use=
d (a
> > later patch does that).
> =

> What do you mean by this? The authentication tag is the checksum
> that you're referring to and you appear to be using it in the rfc8009
> encrypt/decrypt functions.

Is it?  That's entirely unclear.  The algorithm should deal with inserting=
 the
checksum in the appropriate place.  The caller should not need to know abo=
ut
that or where the checksum is or about extra bits of metadata that may nee=
d to
be inserted (as I think the extra gssapi layer does for sunrpc).

One of the reason the library has a number of layout functions is to handl=
e
that stuff transparently.  Unfortunately, I couldn't make it work in the A=
EAD
interface.  The previous library implementation was better in that regard.

> > For the moment, the kerberos encryption algorithms use separate hash a=
nd
> > cipher algorithms internally, but should really use dual hash+cipher a=
nd
> > cipher+hash algorithms if possible to avoid doing these in series.  Of=
fload
> > off this may be possible through something like the Intel QAT.
> =

> Please elaborate on what you mean by this.  For IPsec, the main
> benefit with reframing cbc(aes)+hmac as aead is having a single
> code-path that supports both types of algorithms.

By "dual" I mean, for example, a piece of code that does the cipher and th=
e
hash concurrently.  I think it may be possible to do this using x86 AES an=
d
SHA instructions - if there are sufficient registers.  What I want to do i=
s
avoid having to call a cipher and a hash sequentially.  It appears that th=
e
Intel QAT can actually do this with authenc combos - but the one I have
doesn't offer CTS(CBC(AES)) but only CBC(AES).

> So does your use-case support both standard AEAD algorithms such
> as GCM as well as these legacy algorithms?

At the moment AFS's rxgk does not support GCM.  The same goes for sunrpc i=
n
the kernel.

David


