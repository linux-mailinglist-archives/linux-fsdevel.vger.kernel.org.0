Return-Path: <linux-fsdevel+bounces-38861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E0BA08EDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 12:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D23A16426B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7220B7E0;
	Fri, 10 Jan 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHeCkiun"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C8205AB5
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507403; cv=none; b=MGAn5Zue8zqeqFkAuB8Ebv3Q0DON4SrO+/V7iRWcaVND22Cy6g442cC7WiNiauxGFobEFk4yWgVzBBpyW5srM1/+BjIjemuh2+pPdrR4gycZHVCnWT7g9iqs4r1yn8PzxOM6LgwPPYhobsnhkJyPv12IWz3o4z7U+S04weKllRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507403; c=relaxed/simple;
	bh=fYBMx6/W+Y63QdmCsvCX4sRxROZreOBO/jOOtxkMZ8c=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=r7PR+fi/nxCHqbe0ETdnkBhd2Wq4L5xBPxXXCRRVspFdm4gMwjOgxoLaHXwRXaRh+YM9gcEkGBIjzmsopochQZhV11QYGs4okItqVKqILxbDv5zdXIlL/GplRaRFxu0h/L2bF2fF2B3wQbFopKDMPabSGskFn3CtSjh8WTRtWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHeCkiun; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736507400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nD5UCcIZbhJA8p0YUT2WLXyXLAGi/VYDZnjWOeOQtro=;
	b=OHeCkiunQA+72Xur5FtO8xcGuc3hYM5zB1GA7rlJesXWV1j75uREB/BHuV5pkeI+XjQPaB
	sADOTmck2jxYTYqwH1YZSRD/yp0FY1gb84n+wB+/R0/j37dvfPMruKDztlAKFIMT/hdcEL
	O2Ihcxg4BAkvzr+SAkrDXOd7NR98gNk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-pY4G9-5mOHG6UBaCweusXQ-1; Fri,
 10 Jan 2025 06:09:57 -0500
X-MC-Unique: pY4G9-5mOHG6UBaCweusXQ-1
X-Mimecast-MFC-AGG-ID: pY4G9-5mOHG6UBaCweusXQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AE4C195605B;
	Fri, 10 Jan 2025 11:09:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09D6619560AB;
	Fri, 10 Jan 2025 11:09:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Z4D2uC-kcSzQJS-H@gondor.apana.org.au>
References: <Z4D2uC-kcSzQJS-H@gondor.apana.org.au> <Z4Ds9NBiXUti-idl@gondor.apana.org.au> <20250110010313.1471063-1-dhowells@redhat.com> <20250110010313.1471063-3-dhowells@redhat.com> <1485676.1736504798@warthog.procyon.org.uk>
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
Content-ID: <1488633.1736507389.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jan 2025 11:09:49 +0000
Message-ID: <1488634.1736507389@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Fri, Jan 10, 2025 at 10:26:38AM +0000, David Howells wrote:
> >
> > However the point of having a library is to abstract those details fro=
m the
> > callers.  You wanted me to rewrite the library as AEAD algorithms, whi=
ch I
> > have done as far as I can.  This makes the object for each kerberos en=
ctype
> > look the same from the PoV of the clients.
> =

> I think there is some misunderstanding here.  For a library outside
> of the Crypto API you can do whatever you want.
> =

> I only suggested AEAD because I thought you wanted to bring this within
> the Crypto API.

Not precisely.  What I (and Chuck when I discussed it with him) were think=
ing
is that the kerberos crypto stuff probably belongs in the crypto/ *directo=
ry*
rather than in the net/ directory - but not necessarily as part of the cry=
pto
API.  It mediates use of the crypto API on the part of its users (probably
just sunrpc and rxrpc's rxgk).

That said, I kind of like the implementation of the pure crypto part as AE=
AD
crypto algorithms as it provides a number of advantages:

 (1) The client can be given a single AEAD object to use for each usage an=
d
     call the encrypt and decrypt on that directly, no matter what enctype=
 or
     mode of operation it is doing.

     Of course, it's not quite so simple that I can just share the code fo=
r
     encrypt-mode and checksum-mode at the client level (eg. rxgk).  In th=
e
     former, some metadata is placed in the message; in the latter it's ju=
st
     added into the hash.

 (2) The AEAD object looks after inserting the checksum into the right pla=
ce
     for the enctype, which means the client doesn't have to do that and c=
ould
     therefore more easily asynchronise it through the crypto API.

 (3) Since these do just the crypto and not the laying out, it may be feas=
ible
     to substitute the AES2 encrypt-mode kerberos AEAD driver with an
     authenc() AEAD object.

 (4) The possibility exists of providing optimised drivers to directly
     substitute the kerberos AEAD algorithms.

David


