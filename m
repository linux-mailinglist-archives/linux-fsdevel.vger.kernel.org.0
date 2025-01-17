Return-Path: <linux-fsdevel+bounces-39467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74250A14AC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 09:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BCC162C81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9D81F891F;
	Fri, 17 Jan 2025 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3Qm+MgS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE21F8902
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737101645; cv=none; b=B0C6ZAg5F7IiRDrQUE7R6oMBrSxwYpvahf/E1zfYotCdKK5e8mjlwrPvMAOB0xPQfynBgeEk9MnLWJbqw91REQgW59wUkF571ZmNHovy62p1ED1DQ9iIT62BopvVtx3E1he5RcTPc/fQbuqUe5C5yhcaf+6aebLJnPzohS2DxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737101645; c=relaxed/simple;
	bh=3+9EXq8c69zlapwyGKd0faqxS2tr4mse1g9KpcBCpek=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=UrwJEScx0NMVsp92CgpjBR6dtrJKmuLSgY8v2jPGkxJsZ4cbwJ01tgEa2VybE1Sx9JPGAODRI+VzQCSiD87UcdUFrRuTCjVQdw2AyS6jtbZBYJljis1cDhBj8GQMjbUxcKVUg4nWMOantYONbHudmrcC6lgQec7lqQO5ZWwBbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3Qm+MgS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737101643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNATCbmWLUR77OPC8BefAZNQQT/tPVMfTchLVGd8Ygs=;
	b=M3Qm+MgSpjDCdOhZtOTSbmUQ9kIo4tQgsl0Ps2T+ZVgu5uG4v3HMbf4NHqT7FJ7Z4NADbO
	yVb8v1+cqON0QQyWJlkA3WQPfgtHws3YT3OH99eDMAPVycZE8VmbGz2NWLUFIIld8/dCmf
	7KkDPm4pq5OBFs708TkmKH9ep2FpAoY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-5bCMvOPrOQGG7Zl88GVNeQ-1; Fri,
 17 Jan 2025 03:13:57 -0500
X-MC-Unique: 5bCMvOPrOQGG7Zl88GVNeQ-1
X-Mimecast-MFC-AGG-ID: 5bCMvOPrOQGG7Zl88GVNeQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22D8019560B3;
	Fri, 17 Jan 2025 08:13:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FA3519560AE;
	Fri, 17 Jan 2025 08:13:50 +0000 (UTC)
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
Content-ID: <477968.1737101629.1@warthog.procyon.org.uk>
Date: Fri, 17 Jan 2025 08:13:49 +0000
Message-ID: <477969.1737101629@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Herbert Xu <herbert@gondor.apana.org.au> wrote:

> rfc8009 is basically the same as authenc.

Actually, it's not quite the same :-/

rfc8009 chucks the IV from the encryption into the hash first, but authenc()
does not.  It may be possible to arrange the buffer so that the assoc data is
also the IV buffer.

David


