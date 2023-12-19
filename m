Return-Path: <linux-fsdevel+bounces-6502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1CF818B80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 16:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4012F1C24884
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13771CF8D;
	Tue, 19 Dec 2023 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnPY9AnL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437B1D130
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703000799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wZJGy675CLReZdRFDQqYih3Khpsr0+z+wYGm8WjxUuI=;
	b=QnPY9AnLI5Pmeix/FUNVKNw9PrYtlw8VcFzD9zEbF5EAbvc6FpYwPyAqc9dVjbio4AziI/
	p/c9DDrM6+T1KZPzeESmMyYGT+WN1Nii3uA/l05j2xW6g20IlcP5SWkXzIerTfJVIpykEM
	vhmtVD4i0TxIDFQ123qMwxSS6cqgac8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-IJX7nCWPOzWJ4d7l3Db6MQ-1; Tue,
 19 Dec 2023 10:46:35 -0500
X-MC-Unique: IJX7nCWPOzWJ4d7l3Db6MQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 936DD1C0513E;
	Tue, 19 Dec 2023 15:46:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B5C1E3C25;
	Tue, 19 Dec 2023 15:46:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <36ba1d9f8668e701a9eebcc6cbaa9367e7ccb182.camel@kernel.org>
References: <36ba1d9f8668e701a9eebcc6cbaa9367e7ccb182.camel@kernel.org> <20231213152350.431591-1-dhowells@redhat.com> <20231213152350.431591-29-dhowells@redhat.com>
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
Subject: Re: [PATCH v4 28/39] netfs: Implement support for unbuffered/DIO read
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <844304.1703000788.1@warthog.procyon.org.uk>
Date: Tue, 19 Dec 2023 15:46:28 +0000
Message-ID: <844305.1703000788@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Jeff Layton <jlayton@kernel.org> wrote:

> > +static int netfs_copy_xarray_to_iter(struct netfs_io_request *rreq,
> > +				     struct xarray *xa, struct iov_iter *dst,
> > +				     unsigned long long start, size_t avail)
> ...
> > +	xas_for_each(&xas, folio, ULONG_MAX) {
> > +		size_t offset;
> > +
> > +		if (xas_retry(&xas, folio))
> > +			continue;
> > +
> > +		/* There shouldn't be a need to call xas_pause() as no one else
> > +		 * should be modifying the xarray we're iterating over.
> > +		 * Really, we only need the RCU readlock to keep lockdep happy
> > +		 * inside xas_for_each().
> > +		 */
> > +		rcu_read_unlock();
> > +
> 
> Are you sure it's still safe to access "folio" once you've dropped the
> rcu_read_lock? I wonder if you need to take a reference or something.
> 
> I guess if this is a "private" xarray then nothing should be modifying
> it?

It is a private xarray in this case.  The only reason I need the RCU read lock
is because the xarray code will complain if we're not holding it:-/.

Actually, I can probably excise the bounce buffer code for this series as
nothing in 9p or afs currently uses it.  It's needed for content crypto - so
ceph will need it.

David


