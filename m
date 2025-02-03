Return-Path: <linux-fsdevel+bounces-40593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87B2A25C3E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 15:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B627C3A366B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4173208977;
	Mon,  3 Feb 2025 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWVdh0c2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA62080E3
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592642; cv=none; b=QG7peWuccxHfrkeOQCRb1Zz0SLciFeHmJAQ4O6mBi7sukYMI1d3m3UpPJxKs5eE5P8D9qwywNgAKfcbYQbWAixitnKG1MiLU3MJTfNA3vm6r9l3h6XIoqkG7fvW5DfUXf3sJyc718uoYMQob1T3P+0ZG10Uuc7wf2J87/DjS0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592642; c=relaxed/simple;
	bh=UGF/JT+8VZQfVFZFeVCQEDL8Oi2pcjPwm8ysFfk+a3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sVRO8pNwhptYW/7FR+l68gaBE8YpTboGO1Ug6QrIPXuJYP0S8Ob0Zabun3Q0+lKfycUO7ajqUF2v9Y4RHBaLn2Tj1W1GMLL1Ym6z6ShQyZs/Lz7Oxb/j8UnU0YQToLE54RK8b9C4V2crJJuhPq5861iE0d97vdnV/Y/Pj20vlwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWVdh0c2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=srhJPI+v0JadgvTrFBIm/uuUdap/urFtCyCJkd7uHI4=;
	b=iWVdh0c2Kcfznx0LWX8pDwlqm8fCTEOLxFVJnlo7kMRJa4o6OgEgLdIhK0j+Alb/cptiq2
	Zxmn9efgESbScP+eVWbg0TPy7Im/eNqavFJN/l9Rh+BpHMKJkTzthsUI3Ye4MPIt76uiwk
	3g1jit1QIRWtxOMIUdImmZcX53yi/Yw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-t3UwiEKrP9u1-SLdxksdUQ-1; Mon,
 03 Feb 2025 09:23:55 -0500
X-MC-Unique: t3UwiEKrP9u1-SLdxksdUQ-1
X-Mimecast-MFC-AGG-ID: t3UwiEKrP9u1-SLdxksdUQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3ED1C1955DD0;
	Mon,  3 Feb 2025 14:23:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 06139180097D;
	Mon,  3 Feb 2025 14:23:46 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 00/24] net/rxrpc, crypto: Add Kerberos crypto lib and AF_RXRPC GSSAPI security class
Date: Mon,  3 Feb 2025 14:23:16 +0000
Message-ID: <20250203142343.248839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Here's a set of patches to add basic support for the AF_RXRPC GSSAPI
security class.  It provides transport security for keys that match the
security index 4 (OpenAFS) and security index 6 (YFS) for connections to
the AFS fileserver and VL server.

It can also be used to provide transport security on the callback channel,
but a further set of patches is required to provide the token and key to
set that up when the client responds to the fileserver's challenge.

[!] Note that these patches are on top of two fixes previously posted:

	https://lore.kernel.org/netdev/20250203110307.7265-1-dhowells@redhat.com/

This series of patches consist of four parts:

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

 (3) Push reponding to CHALLENGE packets over to recvmsg() or the kernel
     equivalent so that the application layer can include user-defined
     information in the RESPONSE packet.  In a follow-up patch set, this
     will allow the callback channel to be secured by the AFS filesystem.

 (4) The AF_RXRPC RxGK security class that uses a key obtained from the AFS
     GSS security service to do Kerberos 5-based encryption instead of
     pcbc(fcrypt) and pcbc(des).

Can these all go through the same tree rather than the crypto bits going
via the crypto tree and the rxrpc bits needing to go via the networking
tree?

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=crypto-krb5

David

David Howells (24):
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
  crypto/krb5: Implement the Kerberos5 rfc3961 encrypt and decrypt
    functions
  crypto/krb5: Implement the Kerberos5 rfc3961 get_mic and verify_mic
  crypto/krb5: Implement the AES enctypes from rfc3962
  crypto/krb5: Implement the AES enctypes from rfc8009
  crypto/krb5: Implement the Camellia enctypes from rfc6803
  crypto/krb5: Implement crypto self-testing
  rxrpc: Pull out certain app callback funcs into an ops table
  rxrpc: Pass CHALLENGE packets to the call for recvmsg() to respond to
  rxrpc: Add the security index for yfs-rxgk
  rxrpc: Add YFS RxGK (GSSAPI) security class
  rxrpc: rxgk: Provide infrastructure and key derivation
  rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)
  rxrpc: rxgk: Implement connection rekeying

 Documentation/crypto/index.rst   |    1 +
 Documentation/crypto/krb5.rst    |  262 ++++++
 crypto/Kconfig                   |   13 +
 crypto/Makefile                  |    3 +
 crypto/krb5/Kconfig              |   26 +
 crypto/krb5/Makefile             |   18 +
 crypto/krb5/internal.h           |  247 ++++++
 crypto/krb5/krb5_api.c           |  452 ++++++++++
 crypto/krb5/krb5_kdf.c           |  145 ++++
 crypto/krb5/rfc3961_simplified.c |  797 +++++++++++++++++
 crypto/krb5/rfc3962_aes.c        |  115 +++
 crypto/krb5/rfc6803_camellia.c   |  237 ++++++
 crypto/krb5/rfc8009_aes2.c       |  362 ++++++++
 crypto/krb5/selftest.c           |  544 ++++++++++++
 crypto/krb5/selftest_data.c      |  291 +++++++
 crypto/krb5enc.c                 |  504 +++++++++++
 crypto/testmgr.c                 |   16 +
 crypto/testmgr.h                 |  351 ++++++++
 fs/afs/Makefile                  |    1 +
 fs/afs/cm_security.c             |   54 ++
 fs/afs/internal.h                |    6 +
 fs/afs/misc.c                    |   13 +
 fs/afs/rxrpc.c                   |   16 +-
 include/crypto/authenc.h         |    2 +
 include/crypto/krb5.h            |  160 ++++
 include/keys/rxrpc-type.h        |   17 +
 include/net/af_rxrpc.h           |   37 +-
 include/trace/events/rxrpc.h     |   53 +-
 include/uapi/linux/rxrpc.h       |   63 +-
 net/rxrpc/Kconfig                |   10 +
 net/rxrpc/Makefile               |    5 +-
 net/rxrpc/af_rxrpc.c             |   45 +-
 net/rxrpc/ar-internal.h          |   57 +-
 net/rxrpc/call_accept.c          |   31 +-
 net/rxrpc/call_object.c          |    5 +-
 net/rxrpc/conn_event.c           |   97 ++-
 net/rxrpc/conn_object.c          |    2 +
 net/rxrpc/insecure.c             |   13 +-
 net/rxrpc/io_thread.c            |    8 +-
 net/rxrpc/key.c                  |  185 ++++
 net/rxrpc/output.c               |   58 +-
 net/rxrpc/protocol.h             |   20 +
 net/rxrpc/recvmsg.c              |  114 ++-
 net/rxrpc/rxgk.c                 | 1360 ++++++++++++++++++++++++++++++
 net/rxrpc/rxgk_app.c             |  285 +++++++
 net/rxrpc/rxgk_common.h          |  138 +++
 net/rxrpc/rxgk_kdf.c             |  287 +++++++
 net/rxrpc/rxkad.c                |  287 ++++---
 net/rxrpc/rxperf.c               |   10 +-
 net/rxrpc/security.c             |    3 +
 net/rxrpc/sendmsg.c              |   69 +-
 net/rxrpc/server_key.c           |   40 +
 52 files changed, 7737 insertions(+), 198 deletions(-)
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
 create mode 100644 fs/afs/cm_security.c
 create mode 100644 include/crypto/krb5.h
 create mode 100644 net/rxrpc/rxgk.c
 create mode 100644 net/rxrpc/rxgk_app.c
 create mode 100644 net/rxrpc/rxgk_common.h
 create mode 100644 net/rxrpc/rxgk_kdf.c


