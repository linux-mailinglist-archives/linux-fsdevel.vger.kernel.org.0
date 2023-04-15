Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D166E32C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 19:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDORKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDORKE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 13:10:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC69230C7;
        Sat, 15 Apr 2023 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JEzQCp5ZjGSyHtlxXBCHODnkPIimm3pw3UxVl6Zb3d4=; b=gM8VoT/DE6fH4z/cs3EoSa0IC3
        sKcc8ENS2ZUOAMLvB6QfLTkIMWqMGdtNutLQRjAAYCt8KjB1afgYrAEvjZZC50LIKzPtUN8vOFYhr
        nj9v4rj0fo2lGLSkrPY8N28bB7mKctO04LI8/EJ5VZFJSM6XPGw7xJYvYvbC3it1k5Ovw+teN0wcN
        rCTSzSVku04TFFSu2GZN3/LZnxdDdby6JBDMbla7jfZkIh4Go3qMoXcVs9fx4iFXAAQV9XgODCZ5G
        RzPajiNYFLZ6piYUXfxRzYcmjaH1X7G30D/wOsnQNEhmqPyPMQfCZZ5/voWu/usIV+R+WnxUHKGGJ
        JhEs2J3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnjOi-009kRr-MG; Sat, 15 Apr 2023 17:09:12 +0000
Date:   Sat, 15 Apr 2023 18:09:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gost.dev@samsung.com
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Message-ID: <ZDraOHQHqeabyCvN@casper.infradead.org>
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
 <20230414110821.21548-1-p.raghav@samsung.com>
 <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
 <ZDn3XPMA024t+C1x@bombadil.infradead.org>
 <ZDoMmtcwNTINAu3N@casper.infradead.org>
 <ZDoZCJHQXhVE2KZu@bombadil.infradead.org>
 <ZDodlnm2nvYxbvR4@casper.infradead.org>
 <31765c8c-e895-4207-2b8c-39f6c7c83ece@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31765c8c-e895-4207-2b8c-39f6c7c83ece@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 15, 2023 at 03:14:33PM +0200, Hannes Reinecke wrote:
> On 4/15/23 05:44, Matthew Wilcox wrote:
> > I do wonder how much it's worth doing this vs switching to non-BH methods.
> > I appreciate that's a lot of work still.
> 
> That's what I've been wondering, too.
> 
> I would _vastly_ prefer to switch over to iomap; however, the blasted
> sb_bread() is getting in the way. Currently iomap only runs on entire
> pages / folios, but a lot of (older) filesystems insist on doing 512

Hang on, no, iomap can issue sub-page reads.  eg iomap_read_folio_sync()
will read the parts of the folio which have not yet been read when
called from __iomap_write_begin().

> byte I/O. While this seem logical (seeing that 512 bytes is the
> default, and, in most cases, the only supported sector size) question
> is whether _we_ from the linux side need to do that.
> We _could_ upgrade to always do full page I/O; there's a good
> chance we'll be using the entire page anyway eventually.
> And with storage bandwidth getting larger and larger we might even
> get a performance boost there.

I think we need to look at this from the filesystem side.  What do
filesystems actually want to do?  The first thing is they want to read
the superblock.  That's either going to be immediately freed ("Oh,
this isn't a JFS filesystem after all") or it's going to hang around
indefinitely.  There's no particular need to keep it in any kind of
cache (buffer or page).  Except ... we want to probe a dozen different
filesystems, and half of them keep their superblock at the same offset
from the start of the block device.  So we do want to keep it cached.
That's arguing for using the page cache, at least to read it.

Now, do we want userspace to be able to dd a new superblock into place
and have the mounted filesystem see it?  I suspect that confuses just
about every filesystem out there.  So I think the right answer is to read
the page into the bdev's page cache and then copy it into a kmalloc'ed
buffer which the filesystem is then responsible for freeing.  It's also
responsible for writing it back (so that's another API we need), and for
a journalled filesystem, it needs to fit into the journalling scheme.
Also, we may need to write back multiple copies of the superblock,
possibly with slight modifications.

There are a lot of considerations here, and I don't feel like I have
enough of an appreciation of filesystem needs to come up with a decent
API.  I'd hope we can get a good discussion going at LSFMM.
