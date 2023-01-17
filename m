Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CD466D7F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 09:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbjAQIVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 03:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbjAQIVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:21:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7857EC7
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 00:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673943634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qYjsZAmItyxO/xUrcysAZG44bv1fujnhVpm9qnfE2C8=;
        b=WoImxlfvqsVcvoWqM65ytQgKfOBSTtuWHfI3uLrjfjbwHFp2BWS7+PONZQmYmstkXrMg3l
        Vnrl0F/+3TtaD70beDnbB1h5mX1tBtCuNHxdK3DKrgnqk57m+fo2xhAwOstOBfHw7/cfoL
        rvsMtKdlCMu6omNZaUUNkdZ/m15YoWo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-uuAQjnpbN6SzClURILUZzA-1; Tue, 17 Jan 2023 03:20:03 -0500
X-MC-Unique: uuAQjnpbN6SzClURILUZzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44E603C10687;
        Tue, 17 Jan 2023 08:20:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CFD9175AD;
        Tue, 17 Jan 2023 08:20:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y8ZV9x9gawJPbQho@infradead.org>
References: <Y8ZV9x9gawJPbQho@infradead.org> <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk> <167391053207.2311931.16398133457201442907.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/34] iov_iter: Add a function to extract a page list from an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2330482.1673943599.1@warthog.procyon.org.uk>
Date:   Tue, 17 Jan 2023 08:19:59 +0000
Message-ID: <2330483.1673943599@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> > +ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
> > +			       size_t maxsize, unsigned int maxpages,
> > +			       unsigned int gup_flags, size_t *offset0);
> 
> This function isn't actually added in the current patch.

Oh...  It ended up in the wrong patch.

> > +#define iov_iter_extract_mode(iter, gup_flags) \
> > +	(user_backed_iter(iter) ?				\
> > +	 (gup_flags & FOLL_BUF_MASK) == FOLL_SOURCE_BUF ?	\
> > +	 FOLL_GET : FOLL_PIN : 0)
> 
> And inline function would be nice here.  I guess that would require
> moving the FULL flags into mm_types.h, though.

Yeah, the movement of FOLL_* flags is queued in a patch in akpm's tree.

David

