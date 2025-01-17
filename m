Return-Path: <linux-fsdevel+bounces-39518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F83A156DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D08169717
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735F61A3056;
	Fri, 17 Jan 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSApLURM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C71A83EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138956; cv=none; b=d5v0iBKd2hcLtiZrX8svtXiwGR0hwvfYSjlfYTuPTW5iV6T5WGLicVwkTxX/iQxThopIl0WqRQYm4YPmvfpVlD3ne8MmCq4v3ZCl/2i0tnfZ/+P6t1rBn/MSU8Vt6m/O96doaMETY7cHByMEBasN+SwsTQuV5kIxN9xHbT2Dncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138956; c=relaxed/simple;
	bh=EwaRsGvoytuEXQaeAnAsS+1qSte4kmJYn5CXdcJQ8CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W92N1geBVXJJqX90tWUY1sB3jJIi47PK7SDZ3W/RkYd1HoBq/NkKmG2081C1J0ArDZ7IhNkb5pNcQWwkJL7LMHlgQM+yCb6Lz+gwyd42rk+a9BVHAq51lFpvbgWhcl1zPfyqMGYf4NkrPdlMFrPFXROPVUK1oV+v//mCgtxY6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSApLURM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737138954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IC/vjHgPbYSN2fnGkdfn27W/+JiuRdUwuEhUGD/2C8M=;
	b=gSApLURMC4dTOB2X7fFHLjie+JRtExzQFnzBDQtNnQu/vH+cf/4SsZMOaUk98oQVCyl4W+
	7lkZolE/rynuFkb6ZMIuYthugfLi2qy1Etjw9hd6bNnZz/Hd/QkeeBNPCWYBjuugZBajfV
	NHQLXtlYqvU0lRdTAIlbY2DMYbpwMq8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-gbL1jXDYP1e480UuFa8zEg-1; Fri,
 17 Jan 2025 13:35:48 -0500
X-MC-Unique: gbL1jXDYP1e480UuFa8zEg-1
X-Mimecast-MFC-AGG-ID: gbL1jXDYP1e480UuFa8zEg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF5111956048;
	Fri, 17 Jan 2025 18:35:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D71A195608A;
	Fri, 17 Jan 2025 18:35:40 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: David Howells <dhowells@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/24] crypto: Add generic Kerberos library with AEAD template for hash-then-crypt
Date: Fri, 17 Jan 2025 18:35:09 +0000
Message-ID: <20250117183538.881618-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Herbert, Chuck,

Here's yet another go at a generic Kerberos crypto library in the kernel so
that I can share code between rxrpc and sunrpc (and cifs?).  I derived some
of the parts from the sunrpc gss library and added more advanced AES and
Camellia crypto.

I added an addition AEAD template type, derived from authenc, that does
hash-then-crypt rather than crypt-then-hash as authenc does.  I called it
"krb5enc" for want of a better name.  Possibly I should call it "hashenc"
or something like that.

I went back to my previous more library-based approach, but for encrypt
mode, I replaced the separate skcipher and shash objects with a single
templated AEAD object - either krb5enc (AES+SHA1 and Camellia) or authenc
(AES+SHA2).

Apart from that, things are much as they were previously from the point of
view of someone using the API.  There's a new pair of functions that, given
an encoding type, a key and a usage value, will derive the necessary keys
and return an AEAD or hash handle.  These handles can then be passed to
operation functions that will do the actual work of performing an
encryption, a decryption, MIC generation or MIC verification.

Querying functions are also available to look up an encoding type table by
kerberos protocol number and to help manage message layout.

This library has its own self-testing framework that checks more things
than is possible with the testmgr, including subkey derivation.  It also
checks things about the output of encrypt + decrypt that testmgr doesn't.
That said, testmgr is also provisioned with some encryption and
checksumming tests for Camilla and AES2, though these have to be
provisioned with the intermediate subkeys rather than the transport key.

Note that, for purposes of illustration, I've included some rxrpc patches
that use this interface to implement the rxgk Rx security class.  The
branch also is based on net-next that carries some rxrpc patches that are a
prerequisite for this, but the crypto patches don't need it.

---
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
  crypto/krb5: Implement the AES encrypt/decrypt from rfc8009
  crypto/krb5: Implement crypto self-testing
  crypto/krb5: Add the AES self-testing data from rfc8009
  crypto/krb5: Implement the Camellia enctypes from rfc6803
  rxrpc: Add the security index for yfs-rxgk
  rxrpc: Add YFS RxGK (GSSAPI) security class
  rxrpc: rxgk: Provide infrastructure and key derivation
  rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)
  rxrpc: rxgk: Implement connection rekeying

 Documentation/crypto/index.rst   |    1 +
 Documentation/crypto/krb5.rst    |  262 +++++++
 crypto/Kconfig                   |   13 +
 crypto/Makefile                  |    3 +
 crypto/krb5/Kconfig              |   26 +
 crypto/krb5/Makefile             |   18 +
 crypto/krb5/internal.h           |  257 +++++++
 crypto/krb5/krb5_api.c           |  452 ++++++++++++
 crypto/krb5/krb5_kdf.c           |  145 ++++
 crypto/krb5/rfc3961_simplified.c |  791 ++++++++++++++++++++
 crypto/krb5/rfc3962_aes.c        |  115 +++
 crypto/krb5/rfc6803_camellia.c   |  237 ++++++
 crypto/krb5/rfc8009_aes2.c       |  431 +++++++++++
 crypto/krb5/selftest.c           |  544 ++++++++++++++
 crypto/krb5/selftest_data.c      |  291 ++++++++
 crypto/krb5enc.c                 |  491 +++++++++++++
 crypto/testmgr.c                 |   16 +
 crypto/testmgr.h                 |  401 ++++++++++
 fs/afs/misc.c                    |   13 +
 include/crypto/krb5.h            |  167 +++++
 include/keys/rxrpc-type.h        |   17 +
 include/trace/events/rxrpc.h     |   36 +
 include/uapi/linux/rxrpc.h       |   17 +
 net/rxrpc/Kconfig                |   10 +
 net/rxrpc/Makefile               |    5 +-
 net/rxrpc/ar-internal.h          |   22 +
 net/rxrpc/conn_event.c           |    2 +-
 net/rxrpc/conn_object.c          |    1 +
 net/rxrpc/key.c                  |  183 +++++
 net/rxrpc/output.c               |    2 +-
 net/rxrpc/protocol.h             |   20 +
 net/rxrpc/rxgk.c                 | 1170 ++++++++++++++++++++++++++++++
 net/rxrpc/rxgk_app.c             |  284 ++++++++
 net/rxrpc/rxgk_common.h          |  140 ++++
 net/rxrpc/rxgk_kdf.c             |  287 ++++++++
 net/rxrpc/rxkad.c                |    6 +-
 net/rxrpc/security.c             |    3 +
 37 files changed, 6874 insertions(+), 5 deletions(-)
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
 create mode 100644 net/rxrpc/rxgk.c
 create mode 100644 net/rxrpc/rxgk_app.c
 create mode 100644 net/rxrpc/rxgk_common.h
 create mode 100644 net/rxrpc/rxgk_kdf.c


