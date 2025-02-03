Return-Path: <linux-fsdevel+bounces-40619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA20A25DB9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 16:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2796B167014
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FCB209F46;
	Mon,  3 Feb 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZwPak+4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0292208965
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594284; cv=none; b=e7Z13WMzD6pknd2jWSa2uDjimsPIlCoTJppHClbE3GPW2VNNIHyryUQeDCw3cahEQCZnFMOEb4A2B2Xw3xPOINP+3SZ0kuWYXv1sLFmCjvhpZmjxDzyPQHHH/mhCD+GayYRdD8EFjHbVmNY+Xiu9xV1xW34l3DMucHAva47O5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594284; c=relaxed/simple;
	bh=uc9jPXSOkJumH2MlKMyRP4Ub4Dtbc0RCc9o6JV0zI/I=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=m5KizBJzXo7EaykSO9MC8MvtGEa+VvAAuGVyVV+pYPmv+bMSZFaUiNpJ1BasWi9ZyQ0/KORuBwNnsEzHUD/G/gkc644PgMUAoIuniF752XIqeWH6rpdkQMTz1fjhYQmul9/jFohipL7rdO1YkLxhnC1vhW23Lztc78yV1LaAIu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZwPak+4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738594282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=263/793DicuReYm8n6LPz47U+pOenJtRCwlDeJnQaDk=;
	b=aZwPak+4vM7bBAwxaRapJGvJYtuOBtXUWslssuOg7wGq6IfTPtbyHSfeVEYMLoCGuIDODe
	LMUAtWEiMufJlPQGeiRKZrmo8RlfnUczuXrMXrkw1JWLuYKz5AXCbKJf7wg/oI3RPE9XQC
	YqoRyCVxLcUhB/on+WvwNMXGzBQOjgg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-nfZ4DFVIMHum5Xd7-j1IbA-1; Mon,
 03 Feb 2025 09:51:18 -0500
X-MC-Unique: nfZ4DFVIMHum5Xd7-j1IbA-1
X-Mimecast-MFC-AGG-ID: nfZ4DFVIMHum5Xd7-j1IbA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 872951956080;
	Mon,  3 Feb 2025 14:51:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 439391956094;
	Mon,  3 Feb 2025 14:51:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250203142343.248839-1-dhowells@redhat.com>
References: <20250203142343.248839-1-dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Chuck Lever <chuck.lever@oracle.com>,
    Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
    linux-crypto@vger.kernel.org, linux-afs@lists.infradead.org,
    linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 00/24] net/rxrpc, crypto: Add Kerberos crypto lib and AF_RXRPC GSSAPI security class
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <252339.1738594267.1@warthog.procyon.org.uk>
Date: Mon, 03 Feb 2025 14:51:07 +0000
Message-ID: <252340.1738594267@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Oops.  This should have been tagged for net-next, not for net.

David


