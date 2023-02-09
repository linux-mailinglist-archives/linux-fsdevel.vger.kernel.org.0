Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B53A690C6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 16:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjBIPHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 10:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBIPHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:07:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B545CBDF
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Feb 2023 07:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675955231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2bykY5ltudiFVwAjrX3Al4RUFY4iK7RUW76wSPYzOKs=;
        b=e49mOixrr0oy7rOkevC0QOROcabqU4jpUTClnVhJ7LX60oHBUcIeWc7SKmTRM47TQh85Aq
        X6wcrKoe/RxqkHH1t1Eshmq6XjDvjr1EGBhaejo7oNVmpPdg8QPbD7ogRVZGp1066XA5da
        AsP2F7vG0T80mZ/FPWNYSvm1DrS/8Nc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-sQ-OEzM-NNunWl4RcBiL1A-1; Thu, 09 Feb 2023 10:07:05 -0500
X-MC-Unique: sQ-OEzM-NNunWl4RcBiL1A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3429857D07;
        Thu,  9 Feb 2023 15:07:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E2F1140EBF6;
        Thu,  9 Feb 2023 15:07:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+UJAdnllBw+uxK+@casper.infradead.org>
References: <Y+UJAdnllBw+uxK+@casper.infradead.org> <20230209102954.528942-1-dhowells@redhat.com> <20230209102954.528942-2-dhowells@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v13 01/12] splice: Fix O_DIRECT file read splice to avoid reversion of ITER_PIPE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <757357.1675955219.1@warthog.procyon.org.uk>
Date:   Thu, 09 Feb 2023 15:06:59 +0000
Message-ID: <757358.1675955219@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> On Thu, Feb 09, 2023 at 10:29:43AM +0000, David Howells wrote:
> > +	npages = alloc_pages_bulk_list(GFP_USER, npages, &pages);
> 
> Please don't use alloc_pages_bulk_list().  If nobody uses it, it can go
> away again soon.  Does alloc_pages_bulk_array() work for you?  It's
> faster.

Sure.

> > +	/* Free any pages that didn't get touched at all. */
> > +	for (; reclaim >= PAGE_SIZE; reclaim -= PAGE_SIZE)
> > +		__free_page(bv[--npages].bv_page);
> 
> If you have that array, you can then use release_pages() to free
> them, which will be faster.

Um.  I would normally overlay the array on end of the bvec[] so that I could
save on an allocation (I have to fill in the bvec[] anyway) - which means I
wouldn't still have the array at release time.  But in this case I can make an
exception, though I would've thought that the expectation would be that all
the requested data would be fetched.

David

