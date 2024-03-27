Return-Path: <linux-fsdevel+bounces-15475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B77388F042
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 21:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D15A1C2DFAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 20:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF1B14D441;
	Wed, 27 Mar 2024 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmYI8g55"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5431152195
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571882; cv=none; b=PNoGpuSs/LlpOKCmWC16t9lo1Hl3g2vTqc3x/e0DGYf2oI7cmDqrXdmiHpJKbdJYGW/0lw28oxv3wnQxj3re6Ich0tloKd4VShRdg6ayOVVgrAqMTDFVy/uPPGmVSFQ6ocy0gykvhoaIcF7RNMWNS9wVJREzFm9YYMzVq2YUjkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571882; c=relaxed/simple;
	bh=+q1X6OO5OjLhXHnuIwVLwdI8semz6sAtm2DvDrQfzL0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=V8sl7PncDeNzpQ2qzXE8h6y3JKUtZBoYeEr4n3eRJupqsCCfuOlIc2Z6Ts97ARcNLvCIvcAwxVxi/nQSYCRpG93zkk9vfiBype3eIcPoypkuXgnkiuj7Nl1QWrXWK25fhzu7xAvgf0uKOw6h4TVv+rhkxy++mN15jx8HEKTUtq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmYI8g55; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711571879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6qoPQD+VTVHHhRyd75iNpboVK+lvHVLazCUjHaMH4s4=;
	b=PmYI8g55S5qfdXX5X6eeOiLSim66iGBJsYWnk0YTjf1vtjAryVpxo4WDKhwbhEYEnPzM6H
	Mmlo2xV7Ft9WjNsOgApizHz/9r+bUxYLOdNy+tUbXcdrtPULZdUZOY1K48V0yZgS6pfSaM
	gQbNT5bxX0G7AUQU8zW1VMZzoOBk/Wk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-9x-QYYaoNBy5Yt-5m2eKqg-1; Wed, 27 Mar 2024 16:37:55 -0400
X-MC-Unique: 9x-QYYaoNBy5Yt-5m2eKqg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DAB0101A552;
	Wed, 27 Mar 2024 20:37:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A6CBC53360;
	Wed, 27 Mar 2024 20:37:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZgRpPd1Ado-0_iYx@casper.infradead.org>
References: <ZgRpPd1Ado-0_iYx@casper.infradead.org> <2318298.1711551844@warthog.procyon.org.uk> <2506007.1711562145@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Christoph Hellwig <hch@lst.de>,
    Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm, netfs: Provide a means of invalidation without using launder_folio
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2541307.1711571866.1@warthog.procyon.org.uk>
Date: Wed, 27 Mar 2024 20:37:46 +0000
Message-ID: <2541308.1711571866@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Matthew Wilcox <willy@infradead.org> wrote:

> > +	/* Prevent new folios from being added to the inode. */
> > +	filemap_invalidate_lock(mapping);
> 
> I'm kind of surprised that the callers wouldn't want to hold that lock
> over a call to this function.  I guess you're working on the callers,
> so you'd know better than I would, but I would have used lockdep to
> assert that invalidate_lock was held.

I'm not sure.  None of the places that look like they'd be calling this
currently take that lock (though possibly they should).

Also, should I provide it with explicit range, I wonder?

> > +	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
> > +		unmap_mapping_pages(mapping, 0, ULONG_MAX, false);
> 
> Is this optimisation worth it?

Perhaps not.

David


