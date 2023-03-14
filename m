Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95886B9BEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 17:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjCNQnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 12:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCNQnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:43:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594457302E;
        Tue, 14 Mar 2023 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=gjXIkZzK9eKcsdx4ghLE0EciyRLq1m3GlTeawRmpUUA=; b=pK5R28ZJkzuHPxskO0nobwwjY9
        K7ZaCEN/3XvyZSHeJweJDhKMCKdkrRA41vYQOdiUU/YRzCrFmnEBpFW916YBy7vgtxrlBFFZItIRY
        oVxwEU1op+XlMbbixbUCsWNJjbO/ij0PTFabPTsrNfS2Jp4xk/yFKvl3nF8JD9rRBLxUE6Rmk5kTZ
        oQJVdKhFkufEauztmeqNyoINoGgY2Jtj0GOR5iM30KtyBv+OqoHEUMhOdzvlIrLqBDwF2ROhl7J2F
        YDWrZAZZ7CQYK5kneKa8UOEBavS4G+nW5lKSlHgDROeit/52rqKuWkh1Zwmbiie9tst61OEm3eu24
        sdKz02Ug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pc7ji-00D3j5-AF; Tue, 14 Mar 2023 16:42:54 +0000
Date:   Tue, 14 Mar 2023 16:42:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
Message-ID: <ZBCkDvveAIJENA0G@casper.infradead.org>
References: <20230308165251.2078898-1-dhowells@redhat.com>
 <20230308165251.2078898-4-dhowells@redhat.com>
 <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 08, 2023 at 02:39:00PM -0800, Linus Torvalds wrote:
> On Wed, Mar 8, 2023 at 8:53 AM David Howells <dhowells@redhat.com> wrote:
> >
> > The new filemap_splice_read() has an implicit expectation via
> > filemap_get_pages() that ->read_folio() exists if ->readahead() doesn't
> > fully populate the pagecache of the file it is reading from[1], potentially
> > leading to a jump to NULL if this doesn't exist.  shmem, however, (and by
> > extension, tmpfs, ramfs and rootfs), doesn't have ->read_folio(),
> 
> This patch is the only one in your series that I went "Ugh, that's
> really ugly" for.
> 
> Do we really want to basically duplicate all of filemap_splice_read()?
> 
> I get the feeling that the zeropage case just isn't so important that
> we'd need to duplicate filemap_splice_read() just for that, and I
> think that the code should either
> 
>  (a) just make a silly "read_folio()" for shmfs that just clears the page.
> 
>      Ugly but maybe simple and not horrid?

The problem is that we might have swapped out the shmem folio.  So we
don't want to clear the page, but ask swap to fill the page.  The way
that currently works (see shmem_get_folio_gfp()) is to fetch the swap
entry from the page cache, allocate a new folio inside the shmem code,
then replace the swap entry with the new folio.

What I'd like to see is the generic code say "Ah, this is a shmem
inode, so it's special and the xa_value entry is swap information,
not workingset information, so I'll allocate the folio and restore
the folio->private swap information to let the shmem_read_folio
function do its job correctly".

Either that or we completely overhaul the shmem code to store the
location of its swapped data somewhere that's not the page cache.

>  (b) teach filemap_splice_read() that a NULL 'read_folio' function
> means "use the zero page"

Same problem as (a).

>  (c) go even further, and teach read_folio() in general about file
> holes, and allow *any* filesystem to read zeroes that way in general
> without creating a folio for it.

I've had thoughts along those lines in the past.  It's pretty major
surgery, I think.  At the moment, we allocate the pages and add them
to the page cache in a locked state before asking the filesystem to
populate them.  So the fs doesn't even have the file layout (eg the
get_block or iomap info) that would tell it where the holes are until
the page has already been allocated and inserted.  We could of course
free the page and replace it with a special 'THIS_IS_A_HOLE' entry.
It's just never seemed important enuogh to me to do this surgery.

> in a perfect world, if done well I think shmem_file_read_iter() should
> go away, and it could use generic_file_read_iter too.
> 
> I dunno. Maybe shm really is *so* special that this is the right way
> to do things, but I did react quite negatively to this patch. So not a
> complete NAK, but definitely a "do we _really_ have to do this?"

I'd really like to see shmem have a read_folio implementation.  I
don't know how much work it's going to be.
