Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C639570E659
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 22:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbjEWURJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 16:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjEWURH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 16:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB34132
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684872979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yBM2BC/T1ufxa3+rehpISkT4UVTxaMeNKJrdmGcTYHE=;
        b=FZF2+7PmxesyVLocBcwttVDErpJT8dN6QzIyP3wf2P2HgR5wX1ofkRKoIfbaOp4S4++aPr
        dDbzpY89OLMwM0g6zd1coJDbgRHNFJWLGs/nu4iGQDqiVPv5BR4nrV91YDH6c9ybCWOWfC
        oJMxVCWQIYZ6PsETdOpOv90r7F2vYYI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-ZyBG9gwjMIOeTqnxB5ImZQ-1; Tue, 23 May 2023 16:16:16 -0400
X-MC-Unique: ZyBG9gwjMIOeTqnxB5ImZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 367763C0F660;
        Tue, 23 May 2023 20:16:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0E5B1121314;
        Tue, 23 May 2023 20:16:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <ZGxfrOLZ4aN9/MvE@infradead.org>
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
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
Subject: Extending page pinning into fs/direct-io.c
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3068544.1684872971.1@warthog.procyon.org.uk>
Date:   Tue, 23 May 2023 21:16:11 +0100
Message-ID: <3068545.1684872971@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

> But can you please also take care of the legacy direct I/O code?  I'd really
> hate to leave yet another unfinished transition around.

I've been poking at it this afternoon, but it doesn't look like it's going to
be straightforward, unfortunately.  The mm folks have been withdrawing access
to the pinning API behind the ramparts of the mm/ dir.  Further, the dio code
will (I think), under some circumstances, arbitrarily insert the zero_page
into a list of things that are maybe pinned or maybe unpinned, but I can (I
think) also be given a pinned zero_page from the GUP code if the page tables
point to one and a DIO-write is requested - so just doing if page == zero_page
isn't sufficient.

What I'd like to do is to make the GUP code not take a ref on the zero_page
if, say, FOLL_DONT_PIN_ZEROPAGE is passed in, and then make the bio cleanup
code always ignore the zero_page.

Alternatively, I can drop the pin immediately if I get given one on the
zero_page - it's not going anywhere, after all.

I also need to be able to take an additional pin on a folio that gets split
across multiple bio submissions to replace the get_page() that's there now.

Alternatively to that, I can decide how much data I'm willing to read/write in
one batch, call something like netfs_extract_user_iter() to decant that
portion of the parameter iterator into an bvec[] and let that look up the
overlapping page multiple times.  However, I'm not sure if this would work
well for a couple of reasons: does a single bio have to refer to a contiguous
range of disk blocks?  and we might expend time on getting pages we then have
to give up because we hit a hole.

Something that I noticed is that the dio code seems to wangle to page bits on
the target pages for a DIO-read, which seems odd, but I'm not sure I fully
understand the code yet.

David

