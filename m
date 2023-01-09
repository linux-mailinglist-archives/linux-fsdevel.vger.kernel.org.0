Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6116621E7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 10:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbjAIJo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 04:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbjAIJoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307EA64CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 01:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673257414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fz0AL8Y6vth0e0/TsVSMgT4T9wTeyk82M0u0xn5LNrE=;
        b=V5OHWZ8rbeP+dD8OHuSU8KX7s+Si7dCVfetpUNQbl6ktF3Y5GlCHqviWFf0V4L9XKtJEA3
        8DfAnuBfw1ISoI4iF0rviieFIw0C7DLSO1vn0ikZUP+K+MxoJwx2M9uG39n+fzr/lCvvA6
        IA1e2GXH2SxrsGYQQUAQKHE+wkF0dz0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-_8k4x7-8MfmxViukzD1sZA-1; Mon, 09 Jan 2023 04:43:28 -0500
X-MC-Unique: _8k4x7-8MfmxViukzD1sZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDE173C14841;
        Mon,  9 Jan 2023 09:43:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D689142238;
        Mon,  9 Jan 2023 09:43:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <d86e6340-534c-c34c-ab1d-6ebacb213bb9@kernel.dk>
References: <d86e6340-534c-c34c-ab1d-6ebacb213bb9@kernel.dk> <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk> <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] iov_iter, block: Make bio structs pin pages rather than ref'ing if appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1880792.1673257404.1@warthog.procyon.org.uk>
Date:   Mon, 09 Jan 2023 09:43:24 +0000
Message-ID: <1880793.1673257404@warthog.procyon.org.uk>
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

Jens Axboe <axboe@kernel.dk> wrote:

> > A field, bi_cleanup_mode, is added to the bio struct that gets set by
> > iov_iter_extract_pages() with FOLL_* flags indicating what cleanup is
> > necessary.  FOLL_GET -> put_page(), FOLL_PIN -> unpin_user_page().  Other
> > flags could also be used in future.
> > 
> > Newly allocated bio structs have bi_cleanup_mode set to FOLL_GET to
> > indicate that attached pages are ref'd by default.  Cloning sets it to 0.
> > __bio_iov_iter_get_pages() overrides it to what iov_iter_extract_pages()
> > indicates.
> 
> What's the motivation for this change?

DIO reads in most filesystems and, I think, the block layer are currently
broken with respect to concurrent fork in the same process because they take
refs (FOLL_GET) on the pages involved which causes the CoW mechanism to
malfunction, leading (I think) the parent process to not see the result of the
DIO.  IIRC, the pages undergoing DIO get forcibly copied by fork - and the
copies given to the parent.  Instead, DIO reads should be pinning the pages
(FOLL_PIN).  Maybe Willy can weigh in on this?

Further, getting refs on pages in, say, a KVEC iterator is the wrong thing to
do as the kvec may point to things that shouldn't be ref'd (vmap'd or
vmalloc'd regions, for example).  Instead, the in-kernel caller should do what
it needs to do to keep hold of the memory and the DIO should not take a ref at
all.

> It's growing struct bio, which we can have a lot of in the system. I read
> the cover letter too and I can tell what the change does, but there's no
> justification really for the change.

The FOLL_* flags I'm getting back from iov_iter_extract_pages() can be mapped
to BIO_* flags in the bio.  For the moment, AFAIK, I think only FOLL_GET and
FOLL_PIN are necessary.  There are three cleanup types: put, unpin and do
nothing.

David

