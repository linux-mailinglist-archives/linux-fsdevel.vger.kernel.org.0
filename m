Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CEB629491
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 10:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiKOJmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 04:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiKOJlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:41:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A168F13D66
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 01:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668505257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/jXxnn30oH1htkAEq4c8BajVXG6A/m7p7p9RvVlC1SI=;
        b=AByuGXOXb2cWWpfFecvzazVzz/MgsN8JnSZWDF8PiCD19xmGkHFQyfDlmAD8SxgD1E2QyF
        aKRWnhHdISX0qXEWp0FFejHOjGhPpQEbmfAIF7VLrzXZTRsFZCCFMe6LcYJvJeqv4l5LrI
        JoE3KT4xHx1FEpf1wTDC+vgPIGyHm/M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-MkvcghZ8OraPCsSquUNZLw-1; Tue, 15 Nov 2022 04:40:54 -0500
X-MC-Unique: MkvcghZ8OraPCsSquUNZLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0E008027EB;
        Tue, 15 Nov 2022 09:40:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9A352024CC0;
        Tue, 15 Nov 2022 09:40:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y3MQ4l1AJOgniprT@casper.infradead.org>
References: <Y3MQ4l1AJOgniprT@casper.infradead.org> <166844174069.1124521.10890506360974169994.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, dwysocha@redhat.com,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1493971.1668505249.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 15 Nov 2022 09:40:49 +0000
Message-ID: <1493972.1668505249@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Nov 14, 2022 at 04:02:20PM +0000, David Howells wrote:
> > +++ b/mm/filemap.c
> > @@ -3941,6 +3941,10 @@ bool filemap_release_folio(struct folio *folio,=
 gfp_t gfp)
> >  	struct address_space * const mapping =3D folio->mapping;
> >  =

> >  	BUG_ON(!folio_test_locked(folio));
> > +	if ((!mapping || !mapping_release_always(mapping))
> > +	    && !folio_test_private(folio) &&
> > +	    !folio_test_private_2(folio))
> > +		return true;
> =

> Why do you need to test 'mapping' here?

Why does the function do:

	if (mapping && mapping->a_ops->release_folio)

later then?  There are callers of the function, such as shrink_folio_list(=
),
that seem to think that folio->mapping might be NULL.

> Also this is the most inconsistent style ...

Yeah, I accidentally pushed the '&&' onto the next line.

> > @@ -276,7 +275,7 @@ static long mapping_evict_folio(struct address_spa=
ce *mapping,
> >  	if (folio_ref_count(folio) >
> >  			folio_nr_pages(folio) + folio_has_private(folio) + 1)
> =

> I think this line is incorrect, right?  You don't increment the folio
> refcount just because the folio has private2 set, do you?

Errr, yes:

	static inline void folio_start_fscache(struct folio *folio)
	{
		VM_BUG_ON_FOLIO(folio_test_private_2(folio), folio);
		folio_get(folio);
		folio_set_private_2(folio);
	}

Someone insisted - might even have been you;-)

I'm working on getting rid of the use of PG_private_2 from the network
filesystems, but it's still in progress.  Kind of blocked on the iov_iter
stuff.

> >  		return 0;
> > -	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
> > +	if (!filemap_release_folio(folio, 0))
> >  		return 0;
> >  =

> >  	return remove_mapping(mapping, folio);
> =

> Can we get rid of folio_has_private()

That would be nice, but there are still places that check it, and until we=
 get
rid of the use of PG_private_2, we can't reduce it to just a check on
PG_private.  Truncate, for example, checks it to see if it should can
->invalidate_folio().

It's only used in mm/, so it could be moved into mm/internal.h.

> / page_has_private() now?

That's used in some a number of places outside of mm/.  The arch/s390/ usa=
ge
is just to calculate the expected refcount.  I wonder if calculation of th=
e
expected refcount could be potted into a function as it's performed in a
number of places - though the expectation isn't always the same.

Ext3 and fuse both use it - but those probably need to check PG_private_2 =
and
could use a "folio_test_private()" function when fully foliated.

David

