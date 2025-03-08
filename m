Return-Path: <linux-fsdevel+bounces-43512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD07A57944
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 09:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F9E3B5488
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 08:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34C81AA1DA;
	Sat,  8 Mar 2025 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="MHdXaqv3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9171AA1E0;
	Sat,  8 Mar 2025 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741422611; cv=none; b=Y86JFlQHcWxoI9gdQAze2/prMsbZjEV5cfhWYWq3SDNZqjM4lOxf2fEWgsPkSlj7mF2nD0o+piH/ojaM05rwnlo+b57RddopIQg9CYHa/WqZMr2ORzRju9zMHYlfrzFi38JfqjvSDv5dsxESdElU0Gb6nSwoK3lJf6EsnbuZewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741422611; c=relaxed/simple;
	bh=ztakW5nBpih7iAkXfJC3k9aEMbM1EWSUb87mpX7JfjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcYvVVszYppuVKXbD7K4TbZURXlsCEITA7Gm+T2HD5IKC9DH7/QQ/ZWC/tbHNTtNARn+CxBBcIWAcrJR2Pz/M+TvVIKSGL1KImK+7rPymv1WV5Tct1TN4o1PSvUYG3SmeRoQdKDAbHlPiywTW09H5rJy+M2pe6GI2SpCzdMythw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=MHdXaqv3; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PM0R2H24/cyZow7Z8RgpWoqPF7f/4ZANkzPJR+Kf3go=; b=MHdXaqv3iIB/h4xkEgnIzDRGPv
	ITgSYgd00gAYunNpiBEtly4ou5J66MJxKkFrE577M+cEaWeuVrMqUEIRBL4uGsWMs/qd2Omk/sXfn
	NpytJ2gU/LF2CbD2nd8kNqDK1Pw0IkKFYYcZdyZ3MuGNMHHVhM8e4qhRM2c1dzbWvAsNoRDUdl9QZ
	WyRTpP8XvqH/UO1MeCyMBRVBoWCJejPX4G3JcFGvF0B01BVE3tH3x5AufgsFlXF1L0v99fLejNx7r
	BZU39PTdDk3Z1JOLP/jLBODnk/ionC9gDATpqf3YtWBHqqV28GPBvAvFqaIMzwuZlcvnyAodO5sd/
	43U68Ytw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tqpYo-004odt-22;
	Sat, 08 Mar 2025 16:29:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 08 Mar 2025 16:29:30 +0800
Date: Sat, 8 Mar 2025 16:29:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] crypto: Add Kerberos crypto lib
Message-ID: <Z8v_6nEEHdNrYWhL@gondor.apana.org.au>
References: <3709378.1740991489@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3709378.1740991489@warthog.procyon.org.uk>

On Mon, Mar 03, 2025 at 08:44:49AM +0000, David Howells wrote:
> Hi Herbert,
> 
> Could you pull this into the crypto tree please?  v2 is just a rebase onto
> your cryptodev/master branch.  It does a couple of things:
> 
>  (1) Provide an AEAD crypto driver, krb5enc, that mirrors the authenc
>      driver, but that hashes the plaintext, not the ciphertext.  This was
>      made a separate module rather than just being a part of the authenc
>      driver because it has to do all of the constituent operations in the
>      opposite order - which impacts the async op handling.
> 
>      Testmgr data is provided for AES+SHA2 and Camellia combinations of
>      authenc and krb5enc used by the krb5 library.  AES+SHA1 is not
>      provided as the RFCs don't contain usable test vectors.
> 
>  (2) Provide a Kerberos 5 crypto library.  This is an extract from the
>      sunrpc driver as that code can be shared between sunrpc/nfs and
>      rxrpc/afs.  This provides encryption, decryption, get MIC and verify
>      MIC routines that use and wrap the crypto functions, along with some
>      functions to provide layout management.
> 
>      This supports AES+SHA1, AES+SHA2 and Camellia encryption types.
> 
>      Self-testing is provided that goes further than is possible with
>      testmgr, doing subkey derivation as well.
> 
> The patches were previously posted here:
> 
>     https://lore.kernel.org/r/20250203142343.248839-1-dhowells@redhat.com/
> 
> as part of a larger series, but the networking guys would prefer these to
> go through the crypto tree.  If you want them reposting independently, I
> can do that.
> 
> David
> ---
> The following changes since commit 17ec3e71ba797cdb62164fea9532c81b60f47167:
> 
>   crypto: lib/Kconfig - Hide arch options from user (2025-03-02 15:21:47 +0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/crypto-krb5-20250303
> 
> for you to fetch changes up to fc0cf10c04f49ddba1925b630467f49ea993569e:
> 
>   crypto/krb5: Implement crypto self-testing (2025-03-02 21:56:47 +0000)
> 
> ----------------------------------------------------------------
> crypto: Add Kerberos crypto lib
> 
> ----------------------------------------------------------------
> David Howells (17):
>       crypto/krb5: Add API Documentation
>       crypto/krb5: Add some constants out of sunrpc headers
>       crypto: Add 'krb5enc' hash and cipher AEAD algorithm
>       crypto/krb5: Test manager data
>       crypto/krb5: Implement Kerberos crypto core
>       crypto/krb5: Add an API to query the layout of the crypto section
>       crypto/krb5: Add an API to alloc and prepare a crypto object
>       crypto/krb5: Add an API to perform requests
>       crypto/krb5: Provide infrastructure and key derivation
>       crypto/krb5: Implement the Kerberos5 rfc3961 key derivation
>       crypto/krb5: Provide RFC3961 setkey packaging functions
>       crypto/krb5: Implement the Kerberos5 rfc3961 encrypt and decrypt functions
>       crypto/krb5: Implement the Kerberos5 rfc3961 get_mic and verify_mic
>       crypto/krb5: Implement the AES enctypes from rfc3962
>       crypto/krb5: Implement the AES enctypes from rfc8009
>       crypto/krb5: Implement the Camellia enctypes from rfc6803
>       crypto/krb5: Implement crypto self-testing
> 
>  Documentation/crypto/index.rst   |   1 +
>  Documentation/crypto/krb5.rst    | 262 +++++++++++++
>  crypto/Kconfig                   |  13 +
>  crypto/Makefile                  |   3 +
>  crypto/krb5/Kconfig              |  26 ++
>  crypto/krb5/Makefile             |  18 +
>  crypto/krb5/internal.h           | 247 ++++++++++++
>  crypto/krb5/krb5_api.c           | 452 ++++++++++++++++++++++
>  crypto/krb5/krb5_kdf.c           | 145 +++++++
>  crypto/krb5/rfc3961_simplified.c | 797 +++++++++++++++++++++++++++++++++++++++
>  crypto/krb5/rfc3962_aes.c        | 115 ++++++
>  crypto/krb5/rfc6803_camellia.c   | 237 ++++++++++++
>  crypto/krb5/rfc8009_aes2.c       | 362 ++++++++++++++++++
>  crypto/krb5/selftest.c           | 544 ++++++++++++++++++++++++++
>  crypto/krb5/selftest_data.c      | 291 ++++++++++++++
>  crypto/krb5enc.c                 | 504 +++++++++++++++++++++++++
>  crypto/testmgr.c                 |  16 +
>  crypto/testmgr.h                 | 351 +++++++++++++++++
>  include/crypto/authenc.h         |   2 +
>  include/crypto/krb5.h            | 160 ++++++++
>  20 files changed, 4546 insertions(+)
>  create mode 100644 Documentation/crypto/krb5.rst
>  create mode 100644 crypto/krb5/Kconfig
>  create mode 100644 crypto/krb5/Makefile
>  create mode 100644 crypto/krb5/internal.h
>  create mode 100644 crypto/krb5/krb5_api.c
>  create mode 100644 crypto/krb5/krb5_kdf.c
>  create mode 100644 crypto/krb5/rfc3961_simplified.c
>  create mode 100644 crypto/krb5/rfc3962_aes.c
>  create mode 100644 crypto/krb5/rfc6803_camellia.c
>  create mode 100644 crypto/krb5/rfc8009_aes2.c
>  create mode 100644 crypto/krb5/selftest.c
>  create mode 100644 crypto/krb5/selftest_data.c
>  create mode 100644 crypto/krb5enc.c
>  create mode 100644 include/crypto/krb5.h

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

