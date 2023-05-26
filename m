Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A8271228C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbjEZIo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbjEZIom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED63E4E
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 01:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685090624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rO5u1LT/DkSYeKOoJRR+C9ZUgArTLbgJfPbLRFgEFXo=;
        b=b59M1NGd1hODhNSLixFFto2feuyHJ0m9Tj0UJSZbQwLV+3rvuTGPc2bgCo7HJHSUyoz/t9
        m4VBz8w+FLrY1FP1uzwy7nqRnDdaUhWSFeVSN3JzqVuxfuFZnNdKL6WiwPoVpnr3OyyySg
        13owpzdlE+lHFyxyO04eyQXhdYhPKGw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-R5eE5ngcPYCRxtk71bmDRg-1; Fri, 26 May 2023 04:43:40 -0400
X-MC-Unique: R5eE5ngcPYCRxtk71bmDRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB26D8007D9;
        Fri, 26 May 2023 08:43:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A07FA1121314;
        Fri, 26 May 2023 08:43:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <89c7f535-8fc5-4480-845f-de94f335d332@lucifer.local>
References: <89c7f535-8fc5-4480-845f-de94f335d332@lucifer.local> <20230525223953.225496-1-dhowells@redhat.com> <20230525223953.225496-2-dhowells@redhat.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <520729.1685090615.1@warthog.procyon.org.uk>
Date:   Fri, 26 May 2023 09:43:35 +0100
Message-ID: <520730.1685090615@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> I guess we're not quite as concerned about FOLL_GET because FOLL_GET should
> be ephemeral and FOLL_PIN (horrifically) adds GUP_PIN_COUNTING_BIAS each
> time?

It's not that - it's that iov_iter_get_pages*() is a lot more commonly used at
the moment, and we'd have to find *all* the places that things using that hand
refs around.

iov_iter_extract_pages(), on the other hand, is only used in two places with
these patches and the pins are always released with unpin_user_page*() so it's
a lot easier to audit.

I could modify put_page(), folio_put(), etc. to ignore the zero pages, but
that might have a larger performance impact.

> > +		if (is_zero_page(page))
> > +			return page_folio(page);
> > +
> 
> This will capture huge page cases too which have folio->_pincount and thus
> don't suffer the GUP_PIN_COUNTING_BIAS issue, however it is equally logical
> to simply skip these when pinning.

I'm not sure I understand.  The zero page(s) is/are single-page folios?

> This does make me think that we should just skip pinning for FOLL_GET cases
> too - there's literally no sane reason we should be pinning zero pages in
> any case (unless I'm missing something!)

As mentioned above, there's a code auditing issue and a potential performance
issue, depending on how it's done.

> Another nitty thing that I noticed is, in is_longterm_pinnable_page():-
> 
> 	/* The zero page may always be pinned */
> 	if (is_zero_pfn(page_to_pfn(page)))
> 		return true;
> 
> Which, strictly speaking I suppose we are 'pinning' it or rather allowing
> the pin to succeed without actually pinning, but to be super pedantic
> perhaps it's worth updating this comment too.

Yeah.  It is "pinnable" but no pin will actually be added.

David

