Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B1D759EE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 21:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGSTok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 15:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjGSToj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:44:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB29D1FDC;
        Wed, 19 Jul 2023 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=09gXH5WPLUH/2CplgzC5LRXG+n41z1xeytY52mkD4kk=; b=m+PE/dTTM6VCcwL3b0YBkVYCFM
        RnUKaVfGae71cAmNweNZy6Nyxt6jJ7PHj4eHZ93P7R+SPZ+W8/sc9dndzPM1eJAcZ4fEeDKGrYick
        AEwXOTN1BmSMXPLuJ+xd1G3/rdLNhryhdV2WffAppSEvJ341tuObuAiOSFiRCiQMTRkxqw0s/jNEl
        Z8LQ/9Bqmeia+xH+uoxXnlFlP/GvG/R6Mf5sL2Xvx/RwovZ3hPZVyAIt8zQeanjnpwloY1Vc5HeCn
        7IysHoWWw5mxmqU9IqDXIQQ7jHtSXiDpYphdgr4DbytftBGRRvWcfnKaS/ysIOl40NBZBJqpEOLLr
        rl151uwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMD65-006PmY-2t; Wed, 19 Jul 2023 19:44:29 +0000
Date:   Wed, 19 Jul 2023 20:44:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Matt Whitlock <kernel@mattwhitlock.name>,
        David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
Message-ID: <ZLg9HbhOVnLk1ogA@casper.infradead.org>
References: <20230629155433.4170837-1-dhowells@redhat.com>
 <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name>
 <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 09:35:33PM +0200, Miklos Szeredi wrote:
> On Wed, 19 Jul 2023 at 19:59, Matt Whitlock <kernel@mattwhitlock.name> wrote:
> >
> > On Wednesday, 19 July 2023 06:17:51 EDT, Miklos Szeredi wrote:
> > > On Thu, 29 Jun 2023 at 17:56, David Howells <dhowells@redhat.com> wrote:
> > >>
> > >> Splicing data from, say, a file into a pipe currently leaves the source
> > >> pages in the pipe after splice() returns - but this means that those pages
> > >> can be subsequently modified by shared-writable mmap(), write(),
> > >> fallocate(), etc. before they're consumed.
> > >
> > > What is this trying to fix?   The above behavior is well known, so
> > > it's not likely to be a problem.
> >
> > Respectfully, it's not well-known, as it's not documented. If the splice(2)
> > man page had mentioned that pages can be mutated after they're already
> > ostensibly at rest in the output pipe buffer, then my nightly backups
> > wouldn't have been incurring corruption silently for many months.
> 
> splice(2):
> 
>        Though we talk of copying, actual copies are generally avoided.
> The kernel does this by implementing a pipe buffer as a set  of
> refer‐
>        ence-counted  pointers  to  pages  of kernel memory.  The
> kernel creates "copies" of pages in a buffer by creating new pointers
> (for the
>        output buffer) referring to the pages, and increasing the
> reference counts for the pages: only pointers are copied, not the
> pages of the
>        buffer.
> 
> While not explicitly stating that the contents of the pages can change
> after being spliced, this can easily be inferred from the above
> semantics.

So what's the API that provides the semantics of _copying_?  And, frankly,
this is a "you're holding it wrong" kind of argument.  It only makes
sense if you're read the implementation, which is at best level 2:

https://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html

and worst a level -5:

https://ozlabs.org/~rusty/index.cgi/tech/2008-04-01.html

