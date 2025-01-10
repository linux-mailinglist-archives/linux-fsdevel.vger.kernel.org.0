Return-Path: <linux-fsdevel+bounces-38765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F59FA08441
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C3D77A3533
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 01:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B547D3F4;
	Fri, 10 Jan 2025 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1BEcCPj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902861DA3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 01:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471011; cv=none; b=pvVix63EimPehTv+wPGv8w6xyPg5hHCnyjEAf83vsP596bAYWcudGVFViyI1iDMFLkLTTg43q9IKvnraU6yrEBQE2bhDpJ2Nwq4Z5gNrtVIHwYC9YC5qxc5gWs5m+3gfFEjmRLm/U+bBhjifrDg2Zdjn6ajeDzhOlBnZugS2lQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471011; c=relaxed/simple;
	bh=AnfAXcm3rwbFDVeskkWcz79cWy17z6ZuKaDRLJGOdU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DbURHY3BzZFYe/LTk7ThZpvf9m3uJvbFhNjcYi+6dVheeByg3E3oVXlhNCjfGZMQP9XxXUrUWxeQujNKSJSTxV5rGW1aM7GWlCBLn5q5GBvPUU/Yw6VwaT4VcvEYdBOoPVHDRjI5+ZmGHMynPgi2XCT7fvO1CjUwaHu/XRCp2M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1BEcCPj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736471007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JQY/vqL94CZczS7Z4wdPci4XXmHLvDhOXXqWkw72nUA=;
	b=D1BEcCPjS8paCYwg/70aaXzLmJrZOa/NCvMP2ix5VJqDtXYjQI0VfDcbVqgUHxIe/7kLIV
	8FeibJYokPW3eGJWAQ2LjNZ9xC8NpvFTabxLm2v0lOg7EOqz+230vxYkCPUq51Z5fbNsHQ
	YjlwR3JdrgifExrmmvpCpZ+n+y8WGlw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-oVjMjzxjOwq07OTHH_oEmw-1; Thu,
 09 Jan 2025 20:03:24 -0500
X-MC-Unique: oVjMjzxjOwq07OTHH_oEmw-1
X-Mimecast-MFC-AGG-ID: oVjMjzxjOwq07OTHH_oEmw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8481F1956055;
	Fri, 10 Jan 2025 01:03:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B32011955BE3;
	Fri, 10 Jan 2025 01:03:16 +0000 (UTC)
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
	linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/8] crypto: Add generic Kerberos library with crypto as AEAD algorithms
Date: Fri, 10 Jan 2025 01:03:02 +0000
Message-ID: <20250110010313.1471063-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Herbert, Chuck,

Here's my next go at a generic Kerberos crypto library in the kernel so
that I can share code between rxrpc and sunrpc (and cifs?).

I derived some of the parts from the sunrpc gss library and added more
advanced AES and Camellia crypto.  The crypto bits are inside AEAD
algorithms as Herbert required, but there's also a library of supplementary
functions to aid in managing message layout.

You can use:

        const struct krb5_enctype *crypto_krb5_find_enctype(u32 enctype);

to go and get an information table and this will also let you get at the
name of the AEAD algorithm associated with that encoding type number.

Each AEAD algorithm is defined for a particular Kerberos 5 type by name
(not by enctype number) and supports both encryption and checksumming
(MIC) through the AEAD encrypt/decrypt request API.

Note that the plain text may be a different size to the cipher text and
this causes the testmgr some issues as it thinks the extra data is an auth
tag (but this doesn't want auth tags).

A kerberos AEAD object is configured through its setkey method and this
takes a compound structure that indicates the mode of operation (encrypt or
checksum), the usage type and either the transport key or the subkeys.  The
setkey method allocates and keys the constituent ciphers and hashes - but
that's a detail hidden inside the object.

This library has its own self-testing framework that checks more things
than is possible with the testmgr, including subkey derivation.  It also
checks things about the output of encrypt + decrypt that testmgr doesn't.
That said, testmgr is also provisioned with some encryption and
checksumming tests for Camilla and AES2.

Note that, for purposes of illustration, I've included some rxrpc patches
that use this interface to implement the rxgk Rx security class.  The
branch also is based on net-next that carries some rxrpc patches that are a
prerequisite for this, but the crypto patches don't need it.

---
The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=crypto-krb5

David

David Howells (8):
  crypto/krb5: Add some constants out of sunrpc headers
  crypto/krb5: Provide Kerberos 5 crypto through AEAD API
  crypto/krb5: Test manager data
  rxrpc: Add the security index for yfs-rxgk
  rxrpc: Add YFS RxGK (GSSAPI) security class
  rxrpc: rxgk: Provide infrastructure and key derivation
  rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)
  rxrpc: rxgk: Implement connection rekeying

 crypto/Kconfig                   |    1 +
 crypto/Makefile                  |    2 +
 crypto/aead.c                    |    2 +
 crypto/krb5/Kconfig              |   24 +
 crypto/krb5/Makefile             |   17 +
 crypto/krb5/internal.h           |  162 ++++
 crypto/krb5/kdf.c                |  334 ++++++++
 crypto/krb5/krb5_aead.c          |  462 +++++++++++
 crypto/krb5/rfc3961_simplified.c |  815 +++++++++++++++++++
 crypto/krb5/rfc6803_camellia.c   |  190 +++++
 crypto/krb5/rfc8009_aes2.c       |  394 ++++++++++
 crypto/krb5/selftest.c           |  533 +++++++++++++
 crypto/krb5/selftest_data.c      |  370 +++++++++
 crypto/testmgr.c                 |   24 +
 crypto/testmgr.h                 |  456 +++++++++++
 fs/afs/misc.c                    |   13 +
 include/crypto/aead.h            |    2 +
 include/crypto/krb5.h            |  147 ++++
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
 net/rxrpc/rxgk.c                 | 1244 ++++++++++++++++++++++++++++++
 net/rxrpc/rxgk_app.c             |  318 ++++++++
 net/rxrpc/rxgk_common.h          |   58 ++
 net/rxrpc/rxgk_kdf.c             |  260 +++++++
 net/rxrpc/rxkad.c                |    6 +-
 net/rxrpc/security.c             |    3 +
 35 files changed, 6147 insertions(+), 5 deletions(-)
 create mode 100644 crypto/krb5/Kconfig
 create mode 100644 crypto/krb5/Makefile
 create mode 100644 crypto/krb5/internal.h
 create mode 100644 crypto/krb5/kdf.c
 create mode 100644 crypto/krb5/krb5_aead.c
 create mode 100644 crypto/krb5/rfc3961_simplified.c
 create mode 100644 crypto/krb5/rfc6803_camellia.c
 create mode 100644 crypto/krb5/rfc8009_aes2.c
 create mode 100644 crypto/krb5/selftest.c
 create mode 100644 crypto/krb5/selftest_data.c
 create mode 100644 include/crypto/krb5.h
 create mode 100644 net/rxrpc/rxgk.c
 create mode 100644 net/rxrpc/rxgk_app.c
 create mode 100644 net/rxrpc/rxgk_common.h
 create mode 100644 net/rxrpc/rxgk_kdf.c


