Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBC149B71C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 16:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450653AbiAYPAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 10:00:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344040AbiAYO5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643122635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IczQL1YvwZoBijT+ednRWpEpcXI6INviykxL+Hwilow=;
        b=Fs9cwWmUG9NuUxOsutt0dyx0KU9jYGHJ5LdG/OGOYaPP7Ks/aFm+SpLzwUNs9TYA/voCAY
        0rF9aYiJM6wfh5UqrlFu7kBNk79LMlueFr3NJrm7wb8enxde4XsTN762FoYCST2wHs7fcw
        ZQrZVT3tSEE6S1TuytluG+kWB4bQNY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-k1Ci7QWJP3CvO6bs8HVgNQ-1; Tue, 25 Jan 2022 09:57:12 -0500
X-MC-Unique: k1Ci7QWJP3CvO6bs8HVgNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 454AD1923E21;
        Tue, 25 Jan 2022 14:57:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD6B17E2EF;
        Tue, 25 Jan 2022 14:57:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YfAHJcXeSsAE4uMB@casper.infradead.org>
References: <YfAHJcXeSsAE4uMB@casper.infradead.org> <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk> <164311906472.2806745.605202239282432844.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, smfrench@gmail.com, nspmangalore@gmail.com,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] cifs: Transition from ->readpages() to ->readahead()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2810188.1643122623.1@warthog.procyon.org.uk>
Date:   Tue, 25 Jan 2022 14:57:03 +0000
Message-ID: <2810189.1643122623@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Jan 25, 2022 at 01:57:44PM +0000, David Howells wrote:
> > +	while (readahead_count(ractl) - ractl->_batch_count) {
> 
> You do understand that prefixing a structure member with an '_' means
> "Don't use this", right?  If I could get the compiler to prevent you, I
> would.

Yes, I know.  However, as previously discussed, I think that your
implementation of readahead batching doesn't work right - hence the need to
apply compensation to the values returned by the accessor functions.

Btw, I end up doing this:

		for (i = 0; i < nr_pages; i++)
			if (!readahead_folio(ractl))
				BUG();

in patch 5.  I want to create a batch, but I don't want to be given the array
of addresses of the folios as I'm going to use an xarray-class iterator.
Further, _batch_count at this point is some value related to just the last
folio and not the batch as a whole:-/

(Also, the above won't work if any folios retrieved are larger than a page)

Note that cifs_readahead() is removed in patch 7 and readahead functionality
is offloaded to netfslib, so I'm not sure it's worth spending much time on
fixing.

[I should mention that netfs_readahead() also does:

	while (readahead_folio(ractl))
		;
which could probably be replaced with something better that doesn't keep
taking and dropping the RCU readlock.]

Would you object if I added a function like:

	static inline
	unsigned int readahead_commit_batch(struct readahead_control *rac)
	{
		BUG_ON(rac->_batch_count > rac->_nr_pages);
		rac->_nr_pages -= rac->_batch_count;
		rac->_index += rac->_batch_count;
		rac->_batch_count = 0;
	}

It could then be called from both __readahead_folio() and __readahead_batch().
For __readahead_folio(), the duplicate setting of _batch_count should be
optimised away on the path where a folio is returned.  I could then call this
from the loop in cifs before going round again.

I'd also like to consider adding something like:

	static inline
	void readahead_set_batch(struct readahead_control *rac)
	{
		unsigned int i = 0;
		struct page *page;
		XA_STATE(xas, &rac->mapping->i_pages, 0);

		BUG_ON(rac->_batch_count > rac->_nr_pages);
		rac->_nr_pages -= rac->_batch_count;
		rac->_index += rac->_batch_count;
		rac->_batch_count = 0;

		xas_set(&xas, rac->_index);
		rcu_read_lock();
		xas_for_each(&xas, page, rac->_index + rac->_nr_pages - 1) {
			if (xas_retry(&xas, page))
				continue;
			VM_BUG_ON_PAGE(!PageLocked(page), page);
			VM_BUG_ON_PAGE(PageTail(page), page);
			rac->_batch_count += thp_nr_pages(page);
		}
		rcu_read_unlock();
	}

so that netfslib can use it to load all the pages it is given into a batch
without retrieving the page pointers.

David

