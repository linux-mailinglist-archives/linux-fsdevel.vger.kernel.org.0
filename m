Return-Path: <linux-fsdevel+bounces-52586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46071AE46A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EB816E05B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EF6259C93;
	Mon, 23 Jun 2025 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxsbl3N2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86E2580D7
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688234; cv=none; b=B7ec295+c+IMs+Aw1du7YLwflL+8K9MBh8ouGTdx7v6bkjpnxGCMDtV3jRg2+5+JVLOUDXfscbZSziO1whrlJcTHyxUSeuicsOrdgR5s63B2NWVZ1nd1LrWHftdz/kakQeTBnWIz1bt/cmh8fWgxVR4CXisiiWk5FlWJYwDEV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688234; c=relaxed/simple;
	bh=yxh7ilQonYBUqypJb67+dDP3F/Z9G9zjb1heS+hjcYw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=bep3t9EzUQxCKC4p+1WxZ+UfxiR1aU2mGM3RlnBjFjd1omPQeZ9/sFu4+ykyQ/L4y79CLxCPPoaI/iTiYdshsuScwtcDZenIpwOIrr05OnN+RTDf7xoX36q1Tedw1g2U39HrmUdTJlY3wGqbbRIr+V0dzgfdvaClRhoIkqYoWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxsbl3N2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750688232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DENPfef9k5KPGfxCMnb/tEj2yf0fmCOohO51w/ehSyg=;
	b=dxsbl3N28t2PBiU53JuQkEIGR1Vt6wSLbLnz/Kl8q0ft/w07ItQ85JO5jVr5T6Ayemw4CM
	nt0m2bmz5+68MJrVILsfScrT0iVfXQXm2UJ9Q4GluR28jUEfhJK1IKEjYtjmv+62l+u81i
	hVjSZM+JKD7IjN37iTIJOmZPt8nS7Uk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-rkV28ZGCPsW3UDW4tgao9A-1; Mon,
 23 Jun 2025 10:17:08 -0400
X-MC-Unique: rkV28ZGCPsW3UDW4tgao9A-1
X-Mimecast-MFC-AGG-ID: rkV28ZGCPsW3UDW4tgao9A_1750688226
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8303418011FB;
	Mon, 23 Jun 2025 14:17:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A2CB1800284;
	Mon, 23 Jun 2025 14:16:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aFlcPOpajICfVlFE@infradead.org>
References: <aFlcPOpajICfVlFE@infradead.org> <1069540.1746202908@warthog.procyon.org.uk> <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch> <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch> <1015189.1746187621@warthog.procyon.org.uk> <1021352.1746193306@warthog.procyon.org.uk> <2135907.1747061490@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, Andrew Lunn <andrew@lunn.ch>,
    Eric Dumazet <edumazet@google.com>,
    "David
 S. Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>,
    David Hildenbrand <david@redhat.com>,
    John Hubbard <jhubbard@nvidia.com>, willy@infradead.org,
    Christian Brauner <brauner@kernel.org>,
    Al Viro <viro@zeniv.linux.org.uk>,
    Miklos Szeredi <mszeredi@redhat.com>, torvalds@linux-foundation.org,
    netdev@vger.kernel.org, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: AF_UNIX/zerocopy/pipe/vmsplice/splice vs FOLL_PIN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1111402.1750688218.1@warthog.procyon.org.uk>
Date: Mon, 23 Jun 2025 15:16:58 +0100
Message-ID: <1111403.1750688218@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Christoph Hellwig <hch@infradead.org> wrote:

> > The question is what should happen here to a memory span for which the
> > network layer or pipe driver is not allowed to take reference, but rather
> > must call a destructor?  Particularly if, say, it's just a small part of a
> > larger span.
> 
> What is a "span" in this context?

In the first case, I was thinking along the lines of a bio_vec that says
{physaddr,len} defining a "span" of memory.  Basically just a contiguous range
of physical addresses, if you prefer.

However, someone can, for example, vmsplice a span of memory into a pipe - say
they add a whole page, all nicely aligned, but then they splice it out a byte
at a time into 4096 other pipes.  Each of those other pipes now has a small
part of a larger span and needs to share the cleanup information.

Now, imagine that a network filesystem writes a message into a TCP socket,
where that message corresponds to an RPC call request and includes a number of
kernel buffers that the network layer isn't permitted to look at the refcounts
on, but rather a destructor must be called.  The request message may transit
through the loopback driver and get placed on the Rx queue of another TCP
socket - from whence it may be spliced off into a pipe.

Alternatively, if virtual I/O is involved, this message may get passed down to
a layer outside of the system (though I don't think this is, in principle, any
different from DMA being done by a NIC).

And then there's relayfs and fuse, which seem to do weird stuff.

For the splicing of a loop-backed kernel message out of a TCP socket, it might
make sense just to copy the message at that point.  The problem is that the
kernel doesn't know what's going to happen next to it.

> In general splice unlike direct I/O relies on page reference counts inside
> the splice machinery.  But that is configurable through the
> pipe_buf_operations.  So if you want something to be handled by splice that
> does not use simple page refcounts you need special pipe_buf_operations for
> it.  And you'd better have a really good use case for this to be worthwhile.

Yes.  vmsplice, is the equivalent of direct I/O and should really do the same
pinning thing that, say, write() to an O_DIRECT file does.

David


