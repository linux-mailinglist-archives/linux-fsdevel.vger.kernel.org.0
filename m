Return-Path: <linux-fsdevel+bounces-41322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8B1A2DFA0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33C73A2732
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 17:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A841E0DBA;
	Sun,  9 Feb 2025 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEKD6kur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D92243374
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739123648; cv=none; b=YuN1hDXHPDGmuATCguciyr5CEdBFJH3/tpzUw/R0MJ6FPfic4UMIceQ7xlHA2WjwWbw2JfGFscTOmibuMX3iig4otlJXdOAx0cf7YaQKFsyACRNsWI0C6xRMQznJcRvXRVaSXgnJaEosthlScTI5Sg5AezohTknlsqyB+3CVyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739123648; c=relaxed/simple;
	bh=k99UAQAdKzxoqi1fK05SSQ9xO4q/5wpfZNfxu+vdzsc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=t+H4CagYNnrPCoI3xe3jpnikv/AwvdFx8mOqkNIHAKFchJUFRGy/oEb1NA33NnFTcnMx0X+p1ZAy9jyhAMU5YYlN1n1noxPZmaOV5+cQCg9d6LgHVabnFN9wvvG0F7vL5idHEDMk/3wIfy+Oc5bzL+5I+pPiiFe76e0eMitdXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEKD6kur; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739123646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZy+2KXL+332PNbEE4REP74hQEw249CGirMqJVtIdAE=;
	b=XEKD6kurxWhD6P7+l6j0I+APihIJG8X9KQY2D5jzZUmkPJV0zYVax291TqrQzNGwp7MX1Z
	hnR0O+DEwLMqQrXCsaeaacXSN2jMROitnOxOl54WJM/R4cepRjUU1TRG2LFrgUYAt342QM
	3Kgt4WJHAc1QK+4Wd39Bqsw4hFzfF1o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-fiKubr2EN-OLiH49vN8dyQ-1; Sun,
 09 Feb 2025 12:54:03 -0500
X-MC-Unique: fiKubr2EN-OLiH49vN8dyQ-1
X-Mimecast-MFC-AGG-ID: fiKubr2EN-OLiH49vN8dyQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72BCF180036F;
	Sun,  9 Feb 2025 17:54:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 794E51800360;
	Sun,  9 Feb 2025 17:53:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Z6XKtPKryJsRfYvK@gondor.apana.org.au>
References: <Z6XKtPKryJsRfYvK@gondor.apana.org.au> <20250203142343.248839-1-dhowells@redhat.com> <20250203142343.248839-4-dhowells@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Chuck Lever <chuck.lever@oracle.com>,
    Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 03/24] crypto: Add 'krb5enc' hash and cipher AEAD algorithm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1934017.1739123634.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Feb 2025 17:53:54 +0000
Message-ID: <1934018.1739123634@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> > [!] Note that the net/sunrpc/auth_gss/ implementation gets a pair of
> > ciphers, one non-CTS and one CTS, using the former to do all the align=
ed
> > blocks and the latter to do the last two blocks if they aren't also
> > aligned.  It may be necessary to do this here too for performance reas=
ons -
> > but there are considerations both ways:
> =

> The CTS template will take any hardware accelerated CBC implementation
> and turn it into CTS.
> =

> So there is no reason to do the CTS/CBC thing by hand at all.

Glad to hear it.  I'm just reporting what net/sunrpc/ does now.  My suspic=
ion
is that this is from before a lot of cpu crypto-based optimisations were m=
ade
available in the crypto layer.

David


