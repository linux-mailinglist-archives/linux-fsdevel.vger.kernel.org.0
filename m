Return-Path: <linux-fsdevel+bounces-2734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCE77E7E24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 18:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1651C20BB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 17:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C93B219FE;
	Fri, 10 Nov 2023 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fl4Z6LeG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4235E1DFEC
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 17:25:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F7B446CB
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 09:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699637148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oM2mXDeA3Wf82Oz0QJWRHggvqKfyd3kHZcBXsRiuhQg=;
	b=Fl4Z6LeG+7eCrinuoMDXwH5FAJVft26hE7mO3KCiM/XNcQoHO6uPmUqX7Y1ff3vcnuSARP
	yMk/ly0Gk5Re+RqRrnxs0pQnLucJXbzfQMpmhdLPMj8NBI8SlzQ3EBSV+zjvwJBUzuLaJx
	IcPvQgmZi0MvqfxqNwnp7zwyLHsAQmg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-pjuAe0pPOSO1_br2upm_yw-1; Fri, 10 Nov 2023 12:25:44 -0500
X-MC-Unique: pjuAe0pPOSO1_br2upm_yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00A4185A5BD;
	Fri, 10 Nov 2023 17:25:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BB18502A;
	Fri, 10 Nov 2023 17:25:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <c19af528-1aad-412c-8362-275c791dd76f@auristor.com>
References: <c19af528-1aad-412c-8362-275c791dd76f@auristor.com> <6fadc6aa-4078-4f12-a4c7-235267d6e0b1@auristor.com> <20231109154004.3317227-1-dhowells@redhat.com> <20231109154004.3317227-2-dhowells@redhat.com> <3327953.1699567608@warthog.procyon.org.uk>
To: Jeffrey E Altman <jaltman@auristor.com>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/41] rxrpc: Fix RTT determination to use PING ACKs as a source
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3399755.1699637142.1@warthog.procyon.org.uk>
Date: Fri, 10 Nov 2023 17:25:42 +0000
Message-ID: <3399756.1699637142@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Jeffrey E Altman <jaltman@auristor.com> wrote:

> > I do ignore ack.serial == 0 for this purpose.
> 
> Zero has the special meaning - this ACK is not explicitly in response to a
> received packet.
> 
> However, as mentioned, the serial number counter wraps frequently and most
> RxRPC implementations
> do not transition from serial 0xffffffff -> 0x00000001 when wrapping.

I don't skip zero serial numbers either.  I'm not sure whether it would be
better to do so.

> Otherwise, acked_serial = 0x01 will be considered smaller than orig_serial =
> 0xfffffffe and the slot will not be marked available.

As you mentioned in your follow up email, after() deals with that by casting
to signed, subtracting and then examining the result.

David



