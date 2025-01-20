Return-Path: <linux-fsdevel+bounces-39676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C84A16E6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0AA3A7C20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAF11DEFD4;
	Mon, 20 Jan 2025 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5a+Ne4k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E241E2847
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737383127; cv=none; b=elMf8yyTy9au8umirJSWHiPva91SQWceIgxWCCkH51wjUjW5JXx5hYj6Ja3FAp4sZbPKohAbdMU8cugoyDee/I3olc9sq/1DNvwdBaCecbcNdTQQt41oazHHHCCg5RHGz+PrUPMq6LW2bZsDxPNfEZvGjUbIsUJM35QNYZtedWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737383127; c=relaxed/simple;
	bh=1jqY2F+d7VafsuCep+G9kl1oILdjWO4f+217zkn9+7c=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QFj8cbFgXCxM8LHuBvnZBa/Dc4KoCkQGkjybyZHhLdGfw0eq6tGii7o8jv+G7ANNObqN7RybkVf6NpvAF7eJRSmQaHJaOqEkQEMYO/qIkkXw800z86O0f8IEqjehJV0Q2ulrfsiOPVhUl/xsiOAyhtZzH767HcUqoptNxqSkmV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5a+Ne4k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737383124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=91OCaOldgb4lF7g54QI98f4ovcpRBeXwcL2UnR4rY5s=;
	b=g5a+Ne4k3jkQTwJlphEOAaTYql0a7kkDtrpK+7I6Jm+YKlP78Z4Y9VAA7NBMUxSIk3H09t
	9mI4cnikY9hu7Sex14XMzjK13LMHsZgvDPS/aW0yUUuDzBeoBLyWOr2qZHFq2ZosRLPLxM
	Xg/TSVRBQXGTdd8dHS12+R5Oyduv8p0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-_-yZFx4XPyGlmqzgG0ATIg-1; Mon,
 20 Jan 2025 09:25:20 -0500
X-MC-Unique: _-yZFx4XPyGlmqzgG0ATIg-1
X-Mimecast-MFC-AGG-ID: _-yZFx4XPyGlmqzgG0ATIg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAE5B1955F79;
	Mon, 20 Jan 2025 14:25:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D22419560A3;
	Mon, 20 Jan 2025 14:25:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250120135754.GX6206@kernel.org>
References: <20250120135754.GX6206@kernel.org> <20250117183538.881618-1-dhowells@redhat.com> <20250117183538.881618-4-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
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
Content-ID: <1201142.1737383111.1@warthog.procyon.org.uk>
Date: Mon, 20 Jan 2025 14:25:11 +0000
Message-ID: <1201143.1737383111@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Simon Horman <horms@kernel.org> wrote:

> > +static void krb5enc_decrypt_hash_done(void *data, int err)
> > +{
> > +	struct aead_request *req = data;
> > +
> > +	if (err)
> > +		return krb5enc_request_complete(req, err);
> > +
> > +	err = krb5enc_verify_hash(req, 0);
> 
> Hi David,
> 
> Sparse complains that the second argument to krb5enc_verify_hash should be
> a pointer rather than an integer. So perhaps this would be slightly better
> expressed as (completely untested!):
> 
> 	err = krb5enc_verify_hash(req, NULL);

Actually, no.  It should be "ahreq->result + authsize" and
krb5enc_verify_hash() shouldn't calculate ihash, but use its hash parameter.

I wonder if the testmgr driver tests running the algorithms asynchronously...

Thanks,
David


