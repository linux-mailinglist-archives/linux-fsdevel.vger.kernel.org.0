Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0766631A14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 08:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKUHRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 02:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUHRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:17:10 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E5213DFA;
        Sun, 20 Nov 2022 23:17:08 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2E4FB68AA6; Mon, 21 Nov 2022 08:17:05 +0100 (CET)
Date:   Mon, 21 Nov 2022 08:17:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] afs: Stop implementing ->writepage()
Message-ID: <20221121071704.GC23882@lst.de>
References: <166876785552.222254.4403222906022558715.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166876785552.222254.4403222906022558715.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 18, 2022 at 10:37:35AM +0000, David Howells wrote:
> A hint flag is added to the writeback_control struct so that a filesystem
> can say that the write is triggered by write_begin seeing a conflicting
> write.  This causes do_writepages() to do a single pass of the loop only.

Not a huge fan of that, especially as write_begin is not really a
method, but just an awkward hook in legacy write implementations.

I'd much rather have a private pointer in the writeback_control and
make the behavior implementation specific.  It will need to be split
into a separate patch with proper documentation and a CC to linux-mm.

>  (1) afs_write_back_from_locked_folio() could be called directly rather
>      than calling filemap_fdatawrite_wbc(), but that would avoid the
>      control group stuff that wbc_attach_and_unlock_inode() and co. seem to
>      do.  Do I actually need to do this?

That would be much preferred over the for_write_begin hack, given that
write_begin really isn't a well defined method but a hacky hook for
legacy write implementations.

>  (2) afs_writepages_region() has a loop in it to generate multiple writes.
>      do_writepages() also acquired a loop[2] which will also generate
>      multiple writes.  Should I remove the loop from
>      afs_writepages_region() and leave it to the caller of ->writepages()?

Dropping out of ->writpages inside a page does seem a bit problematic,
so you probably want to keep the loop.

