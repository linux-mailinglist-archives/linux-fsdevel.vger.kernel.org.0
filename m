Return-Path: <linux-fsdevel+bounces-38857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C787CA08DF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 11:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF377A1A4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840F020ADFF;
	Fri, 10 Jan 2025 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmHpSO5O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211AF20B1E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504812; cv=none; b=KFbEKwi1JTTCGFojk7PCTt5f0/s5c7lppSqNE6WeZdGbYagPtGg+KsXjkSlC/rUBmCU5woX/v95UVytta/lSXbV29NRqCseaznZDUqbXm33YGLpnfNfpQJ7OqK6g26kvLmtUt98EJVmDUVmeRbt5IF8pN5re+Xjz0v2XNW0wq+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504812; c=relaxed/simple;
	bh=gKm53QOMWednHvAn1Hp5E76TzULEEfoZAQo0enSMdCM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=W9Xb3e5ehXd9OeE0PvMriz0Op/4/M6iQ0OB8Uz/8KIoZfvQBs/xkQupWNvRSSrtVfKPIycplbYKxnLIcEAZbgRDGZSueHoebtjfqmr0v26GeksCYH4wWhLmo1D4EIjTh47V+T0/QVH/F4h4rTEILfQrWZU3yfd0sSPGdF7Od8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmHpSO5O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736504810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzzZT1Zke9zTlj6zvMnlZUkmOGaTmsD4VeGtYVxbpAk=;
	b=TmHpSO5Osw9XwopgdsM4bmWRrbX/2drre2zmWwMlT7YFZrOUOnhb7ane7r5MVk+lHQSJR/
	I6/3FmMBH4cpd5UiWFhAfRp1L89uZy1YBwhrTj+W/zNYb5/ka9Iz7pvPtP3a5/GAPSj7x+
	WAoB9ERxnLMoUPZBRBVvlyeU0uAjrDA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-WQhH6MOHPOmFQNYc8wv7Ng-1; Fri,
 10 Jan 2025 05:26:46 -0500
X-MC-Unique: WQhH6MOHPOmFQNYc8wv7Ng-1
X-Mimecast-MFC-AGG-ID: WQhH6MOHPOmFQNYc8wv7Ng
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D8491956053;
	Fri, 10 Jan 2025 10:26:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F31291954B24;
	Fri, 10 Jan 2025 10:26:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Z4Ds9NBiXUti-idl@gondor.apana.org.au>
References: <Z4Ds9NBiXUti-idl@gondor.apana.org.au> <20250110010313.1471063-1-dhowells@redhat.com> <20250110010313.1471063-3-dhowells@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, Chuck Lever <chuck.lever@oracle.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    "David S. Miller" <davem@davemloft.net>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] crypto/krb5: Provide Kerberos 5 crypto through AEAD API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1485675.1736504798.1@warthog.procyon.org.uk>
Date: Fri, 10 Jan 2025 10:26:38 +0000
Message-ID: <1485676.1736504798@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> rfc8009 is basically the same as authenc.  So rather than being an
> AEAD algorithm it should really be an AEAD template which takes a
> cipher and and a hash as its parameters.

That's only half true.  If it's acting in checksum mode then it's not an
authenc() algo.

> In fact, you could probably use authenc directly.

However the point of having a library is to abstract those details from the
callers.  You wanted me to rewrite the library as AEAD algorithms, which I
have done as far as I can.  This makes the object for each kerberos enctype
look the same from the PoV of the clients.

I have plans to make the kerberos AEAD use an authenc behind the scenes rather
than a cipher plus hash where appropriate as a future evolution, but the
optimised authenc drivers (QAT for example) that I can find don't appear to
support CTS.

So I'm not sure what it is you were envisioning.

David


