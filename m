Return-Path: <linux-fsdevel+bounces-42836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F88AA49611
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 10:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707F41895F35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD99025A32B;
	Fri, 28 Feb 2025 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEojE2vl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A525A34F
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736566; cv=none; b=tcUmTowW+BrxsdPo8KOBlUhqdLdKLK1sFeJ+6RFwFs9zp7zLjI2ylriK8xtqb7WRJwuoDAOH2YUVxCHOTgSX4hXMInTlJ2WA9+inTzyJOh4jbzUp3qecbrfzFZZTsVAQ6LkR3dGG6Km4TOuHjDv+RFUITPWGcmW/pExEiKd/Ajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736566; c=relaxed/simple;
	bh=GDvWHbsfDV5zNWiJP1XmiPoJi4z6ZQmYIcUg8lclOGw=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=YZU7oO68+7aJ1ny6KN+BlQsUvMffjMUi/LRXjBUlQiF5KgOZkGTv4euljqh0TcfUHPQb/JlhCfSFt7tXgo/Brne3vPTQXsQ5zybykHbaKbgGiWyqKiiXYImPAK+8asmYo1Hm/rIyNAJ1tzBYs0BaIHSEUHYAJ5u9h07E3Kb/sNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEojE2vl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740736563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O08f6gdA0KrLInA95FMEo2ZIg0CleDMWQyitTzKQIpg=;
	b=fEojE2vl/f7ihYNFRZy4VkTglJmSjJ7m4GQ5ZXv9XK9elRCvwV37d8eB/QOdusksJYTi1K
	NIB52FlFAQDHikwcxh89KVFVIocHsJMNhG8gY/ZFsN/yVK4mHQchvuXA5ka2Lr05DMoSRq
	1Nf07HakqAqi9zXEzf9CJDd4SvSwVWU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-svBPWvA2PHCXbUP18jwtKQ-1; Fri,
 28 Feb 2025 04:55:57 -0500
X-MC-Unique: svBPWvA2PHCXbUP18jwtKQ-1
X-Mimecast-MFC-AGG-ID: svBPWvA2PHCXbUP18jwtKQ_1740736555
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D1E61955BFC;
	Fri, 28 Feb 2025 09:55:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1E59180087F;
	Fri, 28 Feb 2025 09:55:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Chuck Lever <chuck.lever@oracle.com>,
    Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] crypto: Add Kerberos crypto lib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3193935.1740736547.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Feb 2025 09:55:47 +0000
Message-ID: <3193936.1740736547@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Herbert,

Could you pull this into the crypto tree please?  It does a couple of
things:

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
The following changes since commit 1e15510b71c99c6e49134d756df91069f7d1814=
1:

  Merge tag 'net-6.14-rc5' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/netdev/net (2025-02-27 09:32:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/crypto-krb5-20250228

for you to fetch changes up to 0dd8f8533a833eeb8e51034072a59930bcbec725:

  crypto/krb5: Implement crypto self-testing (2025-02-28 09:42:42 +0000)

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


