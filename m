Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0621270F159
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 10:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbjEXIsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 04:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEXIsI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 04:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F78F135
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684918041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CDhpK8+26Y4l0U6FHR/UwNa7pZESmpTlQt8dJppAy50=;
        b=PWU6n06f07jGqHbgC1X3bSsaG0hcL/MQocaDiN8T2TXwa26kWJXtlMQqrVS8AYhnAJJUtg
        Yp5xnPPvMo8kpCkaRZ/Q6XJ6pKlG/79SuGD3y2ILHNtKQhvj6q9STyg78F4pGrJoxKeqQQ
        /LDghhJ42fKqGJrtpQqKo0XXoVLAYDA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-V0pDKK8rM169n3tqu65WWQ-1; Wed, 24 May 2023 04:47:14 -0400
X-MC-Unique: V0pDKK8rM169n3tqu65WWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08EC385A5AA;
        Wed, 24 May 2023 08:47:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CDA840CFD45;
        Wed, 24 May 2023 08:47:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZG2m0PGztI2BZEn9@infradead.org>
References: <ZG2m0PGztI2BZEn9@infradead.org> <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com> <3068545.1684872971@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Extending page pinning into fs/direct-io.c
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3215176.1684918030.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 24 May 2023 09:47:10 +0100
Message-ID: <3215177.1684918030@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > What I'd like to do is to make the GUP code not take a ref on the zero=
_page
> > if, say, FOLL_DONT_PIN_ZEROPAGE is passed in, and then make the bio cl=
eanup
> > code always ignore the zero_page.
> =

> I don't think that'll work, as we can't mix different pin vs get types
> in a bio.  And that's really a good thing.

True - but I was thinking of just treating the zero_page specially and nev=
er
hold a pin or a ref on it.  It can be checked by address, e.g.:

    static inline void bio_release_page(struct bio *bio, struct page *page=
)
    {
	    if (page =3D=3D ZERO_PAGE(0))
		    return;
	    if (bio_flagged(bio, BIO_PAGE_PINNED))
		    unpin_user_page(page);
	    else if (bio_flagged(bio, BIO_PAGE_REFFED))
		    put_page(page);
    }

I'm slightly concerned about the possibility of overflowing the refcount. =
 The
problem is that it only takes about 2 million pins to do that (because the
zero_page isn't a large folio) - which is within reach of userspace.  Crea=
te
an 8GiB anon mmap and do a bunch of async DIO writes from it.  You won't h=
it
ENOMEM because it will stick ~2 million pointers to zero_page into the pag=
e
tables.

> > Something that I noticed is that the dio code seems to wangle to page =
bits on
> > the target pages for a DIO-read, which seems odd, but I'm not sure I f=
ully
> > understand the code yet.
> =

> I don't understand this sentence.

I was looking at this:

    static inline void dio_bio_submit(struct dio *dio, struct dio_submit *=
sdio)
    {
    ...
	    if (dio->is_async && dio_op =3D=3D REQ_OP_READ && dio->should_dirty)
		    bio_set_pages_dirty(bio);
    ...
    }

but looking again, the lock is taken briefly and the dirty bit is set - wh=
ich
is reasonable.  However, should we be doing it before starting the I/O?

David

