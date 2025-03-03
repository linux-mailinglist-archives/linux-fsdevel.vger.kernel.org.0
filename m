Return-Path: <linux-fsdevel+bounces-43124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7113A4E5D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F363A421B4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 16:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E4A293B60;
	Tue,  4 Mar 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNwH16HX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9C293B61
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104199; cv=pass; b=ovz7DWAfRWvhS6kiCtGiLvd3FIOvnR6j8drZ0VPy80MF7VZo5+1aMuIXrXAIxAJBseYQWiF9+UT+/kJHF0cSonzOhe0VdDgz6KriIgxxP8mL0LedbISGqBqG/Ck347L4m9D8BBDd+gIaD4XrgTz4WQymoMwkg6flsXU+0uqLW64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104199; c=relaxed/simple;
	bh=bUWqoIF0RSWTyZWSv8LwMFKJPtmJiM+TMfHwuR+g940=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=e08a+2YC8jOVcyNSxsgqYMeK9Np2KdHKS8akAbqI1QNJ9InyvJzhKFxkdmKb9xdT1CtaIum0eaOSwn8QT/pth9ybuAk5dUG5QGc9hObf1LRZrRiDYsDmX17reuLuHHq3LTu23nQtrHOTnlSy7Sx+53TMdzJi0+9TOSxA/HBKx+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNwH16HX; arc=none smtp.client-ip=170.10.133.124; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id C7A1D40D51D7
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 19:03:15 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hNwH16HX
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g4Q2D0GzG0wt
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 18:45:26 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 8F9AF42740; Tue,  4 Mar 2025 18:45:18 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNwH16HX
X-Envelope-From: <linux-kernel+bounces-541176-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNwH16HX
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 9042B41C5D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:45:42 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id D13B73063EFF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:45:41 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6549D7A4DCF
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E6B1EFFB7;
	Mon,  3 Mar 2025 08:45:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD5B667
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991516; cv=none; b=VqGQiqXGAC+TGq4DzMStUb02Iowr4vlSDLMqRKgFVJmwmJuaOxcScnouJzU4kNloxxrnfMVIA7MlLIPQoOAXnLBnI8S4/ubmcklf6Yq93FIneVjHShupZGgvRgi6uCFtPt+43n68+7q9gKjD8LDw+yeJAfhfDBAmt2N0dou3nh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991516; c=relaxed/simple;
	bh=bUWqoIF0RSWTyZWSv8LwMFKJPtmJiM+TMfHwuR+g940=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=tX7N8yrf/hjm+iESJf6r5ZFoVAp9J8ThgMA71ARicV90sF2Oelfx6SViy18RC4nP0lOhZcPYth6urIKGyn+U/1KxnGozZ4Wyz8P8+oh/dDU9X6J94QuF0WdYuo7SOrnavFBaosSJZXGQ/6NZuZHp6ZNn9ODzcMKSoJgwJoW7oME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNwH16HX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740991513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mzc0zyxynm1zLc8lCgBdxcnpn7S2dpYemCwQOpKEfuk=;
	b=hNwH16HX0osTPn/vOpYMc/EhnVJdpc8E1U+FeQUwz8fIiZ14cUZYMJfMW4CVRyt/rq4yde
	HGeTvQ4QFRjRtr1z6kAj93rZCm1XNV2As+x4z1muHEGJWadGxP24aWbVBvp0AFMgk6WvTg
	aopWuSjQGuDoynrrrDR/KfpRnKwqiHU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-7wrT26BSMJ6P7gbEEUKlQA-1; Mon,
 03 Mar 2025 03:45:00 -0500
X-MC-Unique: 7wrT26BSMJ6P7gbEEUKlQA-1
X-Mimecast-MFC-AGG-ID: 7wrT26BSMJ6P7gbEEUKlQA_1740991498
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D019180087C;
	Mon,  3 Mar 2025 08:44:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E569819560AA;
	Mon,  3 Mar 2025 08:44:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: David Howells <dhowells@redhat.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Chuck Lever <chuck.lever@oracle.com>,
    Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL v2] crypto: Add Kerberos crypto lib
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3709377.1740991489.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Mar 2025 08:44:49 +0000
Message-ID: <3709378.1740991489@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g4Q2D0GzG0wt
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707951.75304@3nbNV1TxLAVyTEpoB2K+NQ
X-ITU-MailScanner-SpamCheck: not spam

Hi Herbert,

Could you pull this into the crypto tree please?  v2 is just a rebase onto
your cryptodev/master branch.  It does a couple of things:

 (1) Provide an AEAD crypto driver, krb5enc, that mirrors the authenc
     driver, but that hashes the plaintext, not the ciphertext.  This was
     made a separate module rather than just being a part of the authenc
     driver because it has to do all of the constituent operations in the
     opposite order - which impacts the async op handling.

     Testmgr data is provided for AES+SHA2 and Camellia combinations of
     authenc and krb5enc used by the krb5 library.  AES+SHA1 is not
     provided as the RFCs don't contain usable test vectors.

 (2) Provide a Kerberos 5 crypto library.  This is an extract from the
     sunrpc driver as that code can be shared between sunrpc/nfs and
     rxrpc/afs.  This provides encryption, decryption, get MIC and verify
     MIC routines that use and wrap the crypto functions, along with some
     functions to provide layout management.

     This supports AES+SHA1, AES+SHA2 and Camellia encryption types.

     Self-testing is provided that goes further than is possible with
     testmgr, doing subkey derivation as well.

The patches were previously posted here:

    https://lore.kernel.org/r/20250203142343.248839-1-dhowells@redhat.com/

as part of a larger series, but the networking guys would prefer these to
go through the crypto tree.  If you want them reposting independently, I
can do that.

David
---
The following changes since commit 17ec3e71ba797cdb62164fea9532c81b60f4716=
7:

  crypto: lib/Kconfig - Hide arch options from user (2025-03-02 15:21:47 +=
0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/crypto-krb5-20250303

for you to fetch changes up to fc0cf10c04f49ddba1925b630467f49ea993569e:

  crypto/krb5: Implement crypto self-testing (2025-03-02 21:56:47 +0000)

----------------------------------------------------------------
crypto: Add Kerberos crypto lib

----------------------------------------------------------------
David Howells (17):
      crypto/krb5: Add API Documentation
      crypto/krb5: Add some constants out of sunrpc headers
      crypto: Add 'krb5enc' hash and cipher AEAD algorithm
      crypto/krb5: Test manager data
      crypto/krb5: Implement Kerberos crypto core
      crypto/krb5: Add an API to query the layout of the crypto section
      crypto/krb5: Add an API to alloc and prepare a crypto object
      crypto/krb5: Add an API to perform requests
      crypto/krb5: Provide infrastructure and key derivation
      crypto/krb5: Implement the Kerberos5 rfc3961 key derivation
      crypto/krb5: Provide RFC3961 setkey packaging functions
      crypto/krb5: Implement the Kerberos5 rfc3961 encrypt and decrypt fun=
ctions
      crypto/krb5: Implement the Kerberos5 rfc3961 get_mic and verify_mic
      crypto/krb5: Implement the AES enctypes from rfc3962
      crypto/krb5: Implement the AES enctypes from rfc8009
      crypto/krb5: Implement the Camellia enctypes from rfc6803
      crypto/krb5: Implement crypto self-testing

 Documentation/crypto/index.rst   |   1 +
 Documentation/crypto/krb5.rst    | 262 +++++++++++++
 crypto/Kconfig                   |  13 +
 crypto/Makefile                  |   3 +
 crypto/krb5/Kconfig              |  26 ++
 crypto/krb5/Makefile             |  18 +
 crypto/krb5/internal.h           | 247 ++++++++++++
 crypto/krb5/krb5_api.c           | 452 ++++++++++++++++++++++
 crypto/krb5/krb5_kdf.c           | 145 +++++++
 crypto/krb5/rfc3961_simplified.c | 797 ++++++++++++++++++++++++++++++++++=
+++++
 crypto/krb5/rfc3962_aes.c        | 115 ++++++
 crypto/krb5/rfc6803_camellia.c   | 237 ++++++++++++
 crypto/krb5/rfc8009_aes2.c       | 362 ++++++++++++++++++
 crypto/krb5/selftest.c           | 544 ++++++++++++++++++++++++++
 crypto/krb5/selftest_data.c      | 291 ++++++++++++++
 crypto/krb5enc.c                 | 504 +++++++++++++++++++++++++
 crypto/testmgr.c                 |  16 +
 crypto/testmgr.h                 | 351 +++++++++++++++++
 include/crypto/authenc.h         |   2 +
 include/crypto/krb5.h            | 160 ++++++++
 20 files changed, 4546 insertions(+)
 create mode 100644 Documentation/crypto/krb5.rst
 create mode 100644 crypto/krb5/Kconfig
 create mode 100644 crypto/krb5/Makefile
 create mode 100644 crypto/krb5/internal.h
 create mode 100644 crypto/krb5/krb5_api.c
 create mode 100644 crypto/krb5/krb5_kdf.c
 create mode 100644 crypto/krb5/rfc3961_simplified.c
 create mode 100644 crypto/krb5/rfc3962_aes.c
 create mode 100644 crypto/krb5/rfc6803_camellia.c
 create mode 100644 crypto/krb5/rfc8009_aes2.c
 create mode 100644 crypto/krb5/selftest.c
 create mode 100644 crypto/krb5/selftest_data.c
 create mode 100644 crypto/krb5enc.c
 create mode 100644 include/crypto/krb5.h



