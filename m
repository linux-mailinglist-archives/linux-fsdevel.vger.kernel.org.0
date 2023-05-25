Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A657111CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 19:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbjEYRQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 13:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240792AbjEYRQG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 13:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE25E18D
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685034924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L96rFIYpIHHwiFX7796wWwBgjlxyxPuCZajU63kNJnw=;
        b=IpodDNp3b2lMoKrJuU/Fp3npfKbpW17fjZCrfIUGUPAP2PWynhT7EABnzrJdt18hep32u5
        FxEJlZsEHWY2W2WZg4mNvexV5aKAH7Yn1jkHd7mxqeiHgJDVSx5WiuVy4oZUfRiY5hGQ6R
        efrON3Cg9OLyHQbIovDl04eU/99a06s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-ucjSGAbKP2aGgyvrpvU2oQ-1; Thu, 25 May 2023 13:15:19 -0400
X-MC-Unique: ucjSGAbKP2aGgyvrpvU2oQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16E508030D8;
        Thu, 25 May 2023 17:15:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0A8D492B0A;
        Thu, 25 May 2023 17:15:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wgPWUCyhiM+=S3nmh4JK8qtBQteYvtiXpoYpDjfKHnEhQ@mail.gmail.com>
References: <CAHk-=wgPWUCyhiM+=S3nmh4JK8qtBQteYvtiXpoYpDjfKHnEhQ@mail.gmail.com> <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com> <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org> <3215177.1684918030@warthog.procyon.org.uk> <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com> <e00ee9f5-0f02-6463-bc84-b94c17f488bc@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, David Hildenbrand <david@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Extending page pinning into fs/direct-io.c
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <144596.1685034915.1@warthog.procyon.org.uk>
Date:   Thu, 25 May 2023 18:15:15 +0100
Message-ID: <144598.1685034915@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So I suspect we should add that
> 
>     is_zero_pfn(page_to_pfn(page))
> 
> as a helper inline function rather than write it out even more times
> (that "is this 'struct page' a zero page" pattern already exists in
> /proc and a few other places.
> 
> is_longterm_pinnable_page() already has it, so adding it as a helper
> there in <linux/mm.h> is probably a good idea.

I just added:


static inline bool IS_ZERO_PAGE(const struct page *page)
{
	return is_zero_pfn(page_to_pfn(page));
}

static inline bool IS_ZERO_FOLIO(const struct folio *folio)
{
	return is_zero_pfn(page_to_pfn((const struct page *)folio));
}

to include/linux/pgtable.h.  It doesn't seem I can add it to mm.h as an inline
function.

David

