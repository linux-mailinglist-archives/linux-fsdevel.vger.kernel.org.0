Return-Path: <linux-fsdevel+bounces-39725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC33A172F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296EF16AEE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 19:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983F61F03C4;
	Mon, 20 Jan 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0F9KKCk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC411F193D
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399599; cv=none; b=taw9MNJrQrwtEAm9Z2Qtcf2RN0ivS0kKco6u9KnstcGV4wm6S06iKo+9AlAGr97MmtW4frAM8RfkdiGCciVYtN0QA5U2JGwUNxq1vFEnHDO0YHPa9B+hGwHOIwzpoSqObixoZF3xJMifAjnvEKirobFeHytKMyuLVIP/kOOPy2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399599; c=relaxed/simple;
	bh=Ls1w6WAZHqAu+rKTuk9SnEmg6HlNyISTMJ4PCXdFLCM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=q7K1V+Usw9RLfSTMxPUEHK8JQn1H+j2dShZcst8cmJvKNVZ0aIUievqbrbJSruW2ohih85lvchyXfmW2omwMzF2OMYyfztbz9+PRByruFrTpAfbLNaEPugizbNtdSmmeaFf2FlvDn5CkyeQc9Aj45H8MpgmpdzA78G1avhABeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0F9KKCk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737399596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+iwfJA5iVvxl+Bip7TYLzvSBg2GTpA1L9rYj66ARLZ4=;
	b=Y0F9KKCkK41HGBzU59vHux+5673Gqin9mZGnPZ6K34Egdr3YS6d0ki+Khgc+cuvOdPM4eG
	5tbHSrvok7DRj3m6TFgoqRGqfD2wTBd7VmJVuTvBiUqcoWRPGObuM2dhHDyprpo0bwI4Tq
	0SR+JnzFW+dnDuP2CPA5GtnyzFANLi8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-iEfANEuSOWKUq3mmmokOjQ-1; Mon,
 20 Jan 2025 13:59:49 -0500
X-MC-Unique: iEfANEuSOWKUq3mmmokOjQ-1
X-Mimecast-MFC-AGG-ID: iEfANEuSOWKUq3mmmokOjQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5B93195608A;
	Mon, 20 Jan 2025 18:59:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8816919560A7;
	Mon, 20 Jan 2025 18:59:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250120173937.GA2268@sol.localdomain>
References: <20250120173937.GA2268@sol.localdomain> <20250120135754.GX6206@kernel.org> <20250117183538.881618-1-dhowells@redhat.com> <20250117183538.881618-4-dhowells@redhat.com> <1201143.1737383111@warthog.procyon.org.uk>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, Simon Horman <horms@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Chuck Lever <chuck.lever@oracle.com>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    "David S. Miller" <davem@davemloft.net>,
    Marc Dionne <marc.dionne@auristor.com>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/24] crypto: Add 'krb5enc' hash and cipher AEAD algorithm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1212969.1737399580.1@warthog.procyon.org.uk>
Date: Mon, 20 Jan 2025 18:59:40 +0000
Message-ID: <1212970.1737399580@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Eric Biggers <ebiggers@kernel.org> wrote:

> Multiple requests in parallel, I think you mean?  No, it doesn't, but it
> should.

Not so much.  This bug is on the asynchronous path and not tested by my
rxrpc/rxgk code which only exercises the synchronous path.  I haven't tried to
make that asynchronous yet.  I presume testmgr also only tests the sync path.

David


