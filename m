Return-Path: <linux-fsdevel+bounces-43742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1971A5D305
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 00:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA5E3B2A25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 23:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2532356AA;
	Tue, 11 Mar 2025 23:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DooT6gto"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE023370B
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734912; cv=none; b=Fu07TjJjBKFXZ+PbAWZrChQ49iolr3QfrPeuaWEzVanug8F7N3Clih5MDYlL4yFb0cmrPLhz/Ak8NUy2KZSkdllpvzHqqpvOArXVVLjQtIZRf/rMPXgDtFz6H9yu4zaeKvEP0jobdgnEGspx9zBFFtc+Pg8RaEa2nMadSPP2y74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734912; c=relaxed/simple;
	bh=dn4yPhL5avHiqtNfeTaKE69bgTDdHt4EMpDz5juIA4M=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=uzhQ/j328NCR5YNSNFgLOug4v9mTeW2ARvD9Sp7QAWD04tb+pOCUTmg52Q4w1KvUqqRi0YpzVJf/nd3N2p3bdEjBjpqhNTeJx5ZuRJHqIsGvmslN7PoRir9iokkP74jwnxHROI6rKOMdQbVivpyLQxizTGDtWMIvtifXBGH5Gho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DooT6gto; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741734909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YtUFGu6o0/J9RvV/h3s9K30gUjjCCkNCcQynXOmfbNQ=;
	b=DooT6gtoegrILwo3YNxA0H7LowX+oo6wM4c3CXTSFu/CeYa35wynBsgNGhFvjsuuv+uwOT
	YiijB/X9kTvjv76GFwCWUTbbZjRwKcUKHKS5QjmVBYn5wr9VE+BjGF+IdPED+Vs+MvK/BL
	zAp0yBA9C/kHPfcZMhLC7AX8wvO4x8U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-AgbKgPtGMVetziY0cnJATw-1; Tue,
 11 Mar 2025 19:15:04 -0400
X-MC-Unique: AgbKgPtGMVetziY0cnJATw-1
X-Mimecast-MFC-AGG-ID: AgbKgPtGMVetziY0cnJATw_1741734902
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D01361809CA3;
	Tue, 11 Mar 2025 23:15:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0F43180094A;
	Tue, 11 Mar 2025 23:14:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <953587.1741611236@warthog.procyon.org.uk>
References: <953587.1741611236@warthog.procyon.org.uk>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
    Chuck Lever <chuck.lever@oracle.com>, linux-crypto@vger.kernel.org,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL net-next] crypto: Add Kerberos crypto lib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1199600.1741734896.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Mar 2025 23:14:56 +0000
Message-ID: <1199601.1741734896@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Sigh.  I used the old tag by accident.  Attached is a pull request for one
that got pulled Herbert.  The only difference was that I rebased it on the
cryptodev tree - no other changes were made.

Apologies for that.
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


