Return-Path: <linux-fsdevel+bounces-39750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F58AA174F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 00:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8974188A867
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 23:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BF61B414F;
	Mon, 20 Jan 2025 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biaknp+7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45843383
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737414739; cv=none; b=KXYiKNJfSErGvPqzbOxlYfsAy2/7zkh1H8v03aeINnZLKPmcWze9ji1vu++rBy/fDWXBaoZRb2rzkZI1XpXZMN8bXyIADj5+bErV9yW31WMqYEItuo7sYq3i7kolzKvcoPsAW045POjeYSEBu/hYhqxYmLHCohAmSp0uAxeKgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737414739; c=relaxed/simple;
	bh=SBvenXYw8OtPipXuO7LE4YWvoIngH1jvhlR3/7YWChk=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=Ku1VmMZVj0k1Djbv+DF6HHnCHlE7VJBoCPrAy0LgYDZX/VvQ9pj7Dj3F3SDTB9NcTFsJKrxPxAN9oJ/PgKcJkNaCoH3PwkAUYZ9E2GRtuz4yGhJY1YVml6lyYmoyUg539Lc4zBwIhGpBePLyGOz4YaJw7HQYUXwyG7DkYcTHdkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=biaknp+7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737414735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EIJQ5eR7pxgEx6HUdxvMLLK6G12t5XMgFVgt0W5+/MM=;
	b=biaknp+7BvpxtAaNNP/wGd9UU8NE/UDpHj4lkv28cr2dx7K1bzuLwVTKl2yMmDTc607rnd
	X6ain1cntx5+DlkMuE0HAZcAqnmzIVRVwT7sYoZ2bZn2Jwf4qknve1EQ4jqWPxgP3foHbo
	o5jNMUnopmDDHdrFUDJfrrYncTAhkyw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-TiHGSjjiOXOfCzM4ZjoB9Q-1; Mon,
 20 Jan 2025 18:12:12 -0500
X-MC-Unique: TiHGSjjiOXOfCzM4ZjoB9Q-1
X-Mimecast-MFC-AGG-ID: TiHGSjjiOXOfCzM4ZjoB9Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D93631955DB8;
	Mon, 20 Jan 2025 23:12:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 004053003E7F;
	Mon, 20 Jan 2025 23:12:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1201143.1737383111@warthog.procyon.org.uk>
References: <1201143.1737383111@warthog.procyon.org.uk> <20250120135754.GX6206@kernel.org> <20250117183538.881618-1-dhowells@redhat.com> <20250117183538.881618-4-dhowells@redhat.com>
Cc: dhowells@redhat.com, Simon Horman <horms@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Chuck Lever <chuck.lever@oracle.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    "David S. Miller" <davem@davemloft.net>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
    Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
    linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/24] crypto: Add 'krb5enc' hash and cipher AEAD algorithm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1434957.1737414722.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jan 2025 23:12:02 +0000
Message-ID: <1434958.1737414722@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

David Howells <dhowells@redhat.com> wrote:

> > Sparse complains that the second argument to krb5enc_verify_hash shoul=
d be
> > a pointer rather than an integer. So perhaps this would be slightly be=
tter
> > expressed as (completely untested!):
> > =

> > 	err =3D krb5enc_verify_hash(req, NULL);
> =

> Actually, no.  It should be "ahreq->result + authsize" and
> krb5enc_verify_hash() shouldn't calculate ihash, but use its hash parame=
ter.

Ah.  That's wrong also.  I'm going to drop the second parameter and just
calculate the hash pointers directly.

David
---
diff --git a/crypto/krb5enc.c b/crypto/krb5enc.c
index 931387a8ee6f..e5cec47e7e42 100644
--- a/crypto/krb5enc.c
+++ b/crypto/krb5enc.c
@@ -230,7 +230,7 @@ static int krb5enc_encrypt(struct aead_request *req)
 	return krb5enc_dispatch_encrypt(req, aead_request_flags(req));
 }
 =

-static int krb5enc_verify_hash(struct aead_request *req, void *hash)
+static int krb5enc_verify_hash(struct aead_request *req)
 {
 	struct crypto_aead *krb5enc =3D crypto_aead_reqtfm(req);
 	struct aead_instance *inst =3D aead_alg_instance(krb5enc);
@@ -238,11 +238,12 @@ static int krb5enc_verify_hash(struct aead_request *=
req, void *hash)
 	struct krb5enc_request_ctx *areq_ctx =3D aead_request_ctx(req);
 	struct ahash_request *ahreq =3D (void *)(areq_ctx->tail + ictx->reqoff);
 	unsigned int authsize =3D crypto_aead_authsize(krb5enc);
-	u8 *ihash =3D ahreq->result + authsize;
+	u8 *calc_hash =3D areq_ctx->tail;
+	u8 *msg_hash  =3D areq_ctx->tail + authsize;
 =

-	scatterwalk_map_and_copy(ihash, req->src, ahreq->nbytes, authsize, 0);
+	scatterwalk_map_and_copy(msg_hash, req->src, ahreq->nbytes, authsize, 0)=
;
 =

-	if (crypto_memneq(ihash, ahreq->result, authsize))
+	if (crypto_memneq(msg_hash, calc_hash, authsize))
 		return -EBADMSG;
 	return 0;
 }
@@ -254,7 +255,7 @@ static void krb5enc_decrypt_hash_done(void *data, int =
err)
 	if (err)
 		return krb5enc_request_complete(req, err);
 =

-	err =3D krb5enc_verify_hash(req, 0);
+	err =3D krb5enc_verify_hash(req);
 	krb5enc_request_complete(req, err);
 }
 =

@@ -284,7 +285,7 @@ static int krb5enc_dispatch_decrypt_hash(struct aead_r=
equest *req)
 	if (err < 0)
 		return err;
 =

-	return krb5enc_verify_hash(req, hash);
+	return krb5enc_verify_hash(req);
 }
 =

 /*
@@ -352,7 +353,7 @@ static int krb5enc_init_tfm(struct crypto_aead *tfm)
 	crypto_aead_set_reqsize(
 		tfm,
 		sizeof(struct krb5enc_request_ctx) +
-		ictx->reqoff +
+		ictx->reqoff + /* Space for two checksums */
 		umax(sizeof(struct ahash_request) + crypto_ahash_reqsize(auth),
 		     sizeof(struct skcipher_request) + crypto_skcipher_reqsize(enc)));
 =



