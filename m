Return-Path: <linux-fsdevel+bounces-3047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607A17EF832
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFFF280FB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE1C43ABF;
	Fri, 17 Nov 2023 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JValne8f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B7BA8
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 12:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700251898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ksp0B0U0jOk91nyenu4kLAdaKIM4KJ+zFPMizD4PhnM=;
	b=JValne8fdK8QQNcT2nF5kA0XzQn137fDEq6GYyM+nOwyug5AhHdtllWbIOvF/YMCtZo8rO
	YU92LDVnEfBH6J5B4oH1wPX4FkhIMLgUQFpL/2xlWtwpnYmdMxa0zCYfQgHQs328HfwpEA
	CQblcxIjs8VslrcOImctktgK6p5OMcI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-QOrKvuqrOWOv0BEUCKU0YQ-1; Fri, 17 Nov 2023 15:11:35 -0500
X-MC-Unique: QOrKvuqrOWOv0BEUCKU0YQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02434848166;
	Fri, 17 Nov 2023 20:11:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4779AC0BDC0;
	Fri, 17 Nov 2023 20:11:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <9d2fc137b4295058ac3f88f1cca7a54bc67f01fd.camel@kernel.org>
References: <9d2fc137b4295058ac3f88f1cca7a54bc67f01fd.camel@kernel.org> <20231013160423.2218093-1-dhowells@redhat.com> <20231013160423.2218093-13-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Christian Brauner <christian@brauner.io>,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: [RFC PATCH 12/53] netfs: Provide tools to create a buffer in an xarray
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1709497.1700251890.1@warthog.procyon.org.uk>
Date: Fri, 17 Nov 2023 20:11:30 +0000
Message-ID: <1709498.1700251890@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Jeff Layton <jlayton@kernel.org> wrote:

> Some kerneldoc comments on these new helpers would be nice. I assume
> that "index" and "to" are "start" and "end" for this, but it'd be nice
> to make that explicit.

These are internal to netfs not API functions, so they shouldn't appear in the
API docs.  That's why the declaration is in internal.h, not netfs.h.

That said, I could describe them better.

> > +	ret = netfs_add_folios_to_buffer(buffer, mapping, want_index,
> > +					 have_index - 1, gfp_mask);
> > +	if (ret < 0)
> > +		return ret;
> > +	have_folios += have_index - want_index;
> > +
> > +	ret = netfs_add_folios_to_buffer(buffer, mapping,
> > +					 have_index + have_folios,
> > +					 want_index + want_folios - 1,
> > +					 gfp_mask);
> 
> I don't get it. Why are you calling netfs_add_folios_to_buffer twice
> here? Why not just make one call? Either way, a comment here explaining
> that would also be nice.

The ranges aren't contiguous.  They bracket the folios spliced from the
mapping.  That being said, I seem to have lost a bit of maths somewhere.

Further, I'm not now using netfs_add_folios_to_buffer(), so I'll remove it.

David


