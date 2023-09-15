Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A234A7A1BD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 12:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjIOKLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 06:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbjIOKLu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9ADE273C
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694772634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5U61MhzJI73OJTFzPfDsmy/XLiTcwMLxEtjvstIs+RY=;
        b=QloqV7EGOosWqkgkmCqKgxT8H3o4J3SjYpFr3vUuaNbOGvuhnpWH5/0GGG3hhCppkU96HO
        AGBNKVAx74dm5RY+3/JNFDtg0itd/paH9rRddT1FLz21618HnbX/24V9PLWPo+WNU/v8V1
        eP8Jl3ahkKwG8NK6v5HKPIgTHtFL11M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-u5N0xklJP8-lgLuGgb9A3w-1; Fri, 15 Sep 2023 06:10:32 -0400
X-MC-Unique: u5N0xklJP8-lgLuGgb9A3w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B637A85A5A8;
        Fri, 15 Sep 2023 10:10:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 388F240C2070;
        Fri, 15 Sep 2023 10:10:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <dcc6543d71524ac488ca2a56dd430118@AcuMS.aculab.com>
References: <dcc6543d71524ac488ca2a56dd430118@AcuMS.aculab.com> <20230914221526.3153402-1-dhowells@redhat.com> <20230914221526.3153402-10-dhowells@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Christian Brauner" <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "Brendan Higgins" <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 9/9] iov_iter: Add benchmarking kunit tests for UBUF/IOVEC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3370514.1694772627.1@warthog.procyon.org.uk>
Date:   Fri, 15 Sep 2023 11:10:27 +0100
Message-ID: <3370515.1694772627@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> > Add kunit tests to benchmark 256MiB copies to a UBUF iterator and an IOVEC
> > iterator.  This attaches a userspace VM with a mapped file in it
> > temporarily to the test thread.
> 
> Isn't that going to be completely dominated by the cache fills
> from memory?

Yes...  but it should be consistent in the amount of time that consumes since
no device drivers are involved.  I can try adding the same folio to the
anon_file multiple times - it might work especially if I don't put the pages
on the LRU (if that's even possible) - but I wanted separate pages for the
extraction test.

> I'd have thought you'd need to use something with a lot of
> small fragments so that the iteration code dominates the copy.

That would actually be a separate benchmark case which I should try also.

> Some measurements can be made using readv() and writev()
> on /dev/zero and /dev/null.

Forget /dev/null; that doesn't actually engage any iteration code.  The same
for writing to /dev/zero.  Reading from /dev/zero does its own iteration thing
rather than using iterate_and_advance(), presumably because it checks for
signals and resched.

David

