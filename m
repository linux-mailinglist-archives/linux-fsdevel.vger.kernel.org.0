Return-Path: <linux-fsdevel+bounces-6510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D2F818D0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 17:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADCB1F24A80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 16:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F68520327;
	Tue, 19 Dec 2023 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Co8e1LrE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77A620DC2
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703005006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B719XTWiXIHllaEXvsXPz/Q4Bs162RLSRke3FIDQ97A=;
	b=Co8e1LrEb5zmjZ5SC5l1g1y2bn9A3NulfYY6EUMtsJmnDqDOZBdA+/CgK7gYWWtyp2YhDi
	JFRi5kbIdJ4x8+iLyN3VzoLO0g0odwNTeIsAWaXPD4vDc0qEOPUjBQxM2qJJbNIg5M6Wht
	Ya5Kq2j6PyZIUjo5E4aCCZiPUS/L8mk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-6503fTaVPLqMEr27yNBRTA-1; Tue, 19 Dec 2023 11:56:43 -0500
X-MC-Unique: 6503fTaVPLqMEr27yNBRTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9ED74185A782;
	Tue, 19 Dec 2023 16:56:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D48152026D66;
	Tue, 19 Dec 2023 16:56:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8b9413cc37a231a97059c7d028d404ab35363764.camel@kernel.org>
References: <8b9413cc37a231a97059c7d028d404ab35363764.camel@kernel.org> <20231213152350.431591-1-dhowells@redhat.com> <20231213152350.431591-38-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 37/39] netfs: Optimise away reads above the point at which there can be no data
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1075372.1703004999.1@warthog.procyon.org.uk>
Date: Tue, 19 Dec 2023 16:56:39 +0000
Message-ID: <1075373.1703004999@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Jeff Layton <jlayton@kernel.org> wrote:

> >  (4) On local truncation up, we don't change zero_point.
> > 
> 
> The above seems odd, but I guess the assumption is that if there are any
> writes by a 3rd party above the old zero point, that that would cause an
> invalidation?

All truncating up does is extend the region from which reading would return
zeros, so it doesn't affect the zero_point.

If a third party interferes, then we have to invalidate the local caches and
reset zero_point to the EOF.  But if a third party is writing to the file at
the same time as you without both of you using locking or exclusive direct
writes, your data is probably screwed anyway...

Something cifs and ceph can use leasing to make this work; afs uses the data
version number, notifications and the principle that you should use file
locks.

David


