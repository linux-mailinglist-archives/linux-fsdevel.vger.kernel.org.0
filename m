Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851F17405ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 23:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjF0Vtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 17:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjF0Vtb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:49:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D483E4
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 14:49:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666eb03457cso2751316b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 14:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687902569; x=1690494569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAitsm6SZsUHqyk7mTtn8a0zsyDJISdfgKAdGcrbE30=;
        b=Kr/75T+LOB5eh8qVq/S6t1tDyfJxBhK2RxsgJJz1RvKEF2FJpiQ/nr/+ppq1qy+b33
         aHi4gF7xiYe3P9JQjaNBJIxyjYdUOdiRVVzfOoZAtbHIAHAVwZp9dxHQqwxdXgh//Dnk
         +fCxBgnTCag8fIDwSrfifR7zm+OCQW2+rTBy3XCSgrroIyFd5C2/BjRN7zdxucMWlNJq
         VsYZEUgeip78l32GrSZWF10Udot6chx42uNbq9McxOVKvj6g0q26pJMNNUJ+7CcfEjRv
         G7quQh6jTf/lJaaVIo42/AzF5wAFmgF4kObFTVlZP6HUQAKvjhgBR2d0r7rI04IOe3hu
         7kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687902569; x=1690494569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAitsm6SZsUHqyk7mTtn8a0zsyDJISdfgKAdGcrbE30=;
        b=iGHWr+vxWAdJ0IEPAcpxG6w92vBKH825JwBc2Q8+2K/MEXEwllRnB12eUTD9ZodjZu
         Z9iatoQY6GOPJ80WFHK0T01R0Wk63L+8c57QD6T5yM31V6c+zlikRyaVTCg0zEvIQ8Pd
         KNvVoBdH/4txB4R4Bv6q/+y4rKCzDMtLwRWRz6sqtNwkewVPT0garkIWY0KjxLd81C8T
         j6xiluEPe+kq4kx8dKBn2gycXG1e26OAMkeHubi+fJkhWGCxdZemvPJdHsfn0KcTF5EX
         rPnLbMnERKjvOTM9CvXDnZEvvtMrKwaGK/Bnz3aQXUbq78fMfkrCmqAdYHJTHXPjFjpx
         kO+A==
X-Gm-Message-State: AC+VfDzeIExEschhPaVfYAfN9GM4lmmVG9mb9YrG4q6HWmQ9Q4Gm3j1c
        dbL08XLEkHI3SscAIXHO1SiKgg==
X-Google-Smtp-Source: ACHHUZ7Pc4FnbnSc+QBeFs68r6Mhwa6Od1lRpr7DH1nYqe9YFVdx+aBApJyQ0oNzV9qQYwAfOzO+fg==
X-Received: by 2002:a05:6a00:2e23:b0:666:66c0:fd5b with SMTP id fc35-20020a056a002e2300b0066666c0fd5bmr28236053pfb.18.1687902569513;
        Tue, 27 Jun 2023 14:49:29 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id m17-20020aa78a11000000b00668738796b6sm1947773pfa.52.2023.06.27.14.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 14:49:28 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qEGYw-00Gyv2-15;
        Wed, 28 Jun 2023 07:49:26 +1000
Date:   Wed, 28 Jun 2023 07:49:26 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Matt Whitlock <kernel@mattwhitlock.name>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Reproducer] Corruption, possible race between splice and
 FALLOC_FL_PUNCH_HOLE
Message-ID: <ZJtZZuc4DPErgKTZ@dread.disaster.area>
References: <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
 <ZJp4Df8MnU8F3XAt@dread.disaster.area>
 <ZJq6nJBoX1m6Po9+@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJq6nJBoX1m6Po9+@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 11:31:56AM +0100, Matthew Wilcox wrote:
> On Tue, Jun 27, 2023 at 03:47:57PM +1000, Dave Chinner wrote:
> > On Mon, Jun 26, 2023 at 09:12:52PM -0400, Matt Whitlock wrote:
> > > Hello, all. I am experiencing a data corruption issue on Linux 6.1.24 when
> > > calling fallocate with FALLOC_FL_PUNCH_HOLE to punch out pages that have
> > > just been spliced into a pipe. It appears that the fallocate call can zero
> > > out the pages that are sitting in the pipe buffer, before those pages are
> > > read from the pipe.
> > > 
> > > Simplified code excerpt (eliding error checking):
> > > 
> > > int fd = /* open file descriptor referring to some disk file */;
> > > for (off_t consumed = 0;;) {
> > >   ssize_t n = splice(fd, NULL, STDOUT_FILENO, NULL, SIZE_MAX, 0);
> > >   if (n <= 0) break;
> > >   consumed += n;
> > >   fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, consumed);
> > > }
> > 
> > Huh. Never seen that pattern before - what are you trying to
> > implement with this?
> > 
> > > Expected behavior:
> > > Punching holes in a file after splicing pages out of that file into a pipe
> > > should not corrupt the spliced-out pages in the pipe buffer.
> > 
> > splice is a nasty, tricky beast that should never have been
> > inflicted on the world...
> 
> Indeed.  I understand the problem, I just don't know if it's a bug.
> 
> > > Observed behavior:
> > > Some of the pages that have been spliced into the pipe get zeroed out by the
> > > subsequent fallocate call before they can be consumed from the read side of
> > > the pipe.
> > 
> > Which implies the splice is not copying the page cache pages but
> > simply taking a reference to them.
> 
> Yup.
> 
> > Hmmm. the corruption, more often than not, starts on a high-order
> > aligned file offset. Tracing indicates data is being populated in
> > the page cache by readahead, which would be using high-order folios
> > in XFS.
> > 
> > All the splice operations are return byte counts that are 4kB
> > aligned, so punch is doing filesystem block aligned punches. The
> > extent freeing traces indicate the filesystem is removing exactly
> > the right ranges from the file, and so the page cache invalidation
> > calls it is doing are also going to be for the correct ranges.
> > 
> > This smells of a partial high-order folio invalidation problem,
> > or at least a problem with splice working on pages rather than
> > folios the two not being properly coherent as a result of partial
> > folio invalidation.
> > 
> > To confirm, I removed all the mapping_set_large_folios() calls in
> > XFS, and the data corruption goes away. Hence, at minimum, large
> > folios look like a trigger for the problem.
> 
> If you do a PUNCH HOLE, documented behaviour is:
> 
>        Specifying the FALLOC_FL_PUNCH_HOLE flag (available since Linux 2.6.38)
>        in mode deallocates space (i.e., creates a  hole)  in  the  byte  range
>        starting  at offset and continuing for len bytes.  Within the specified
>        range, partial filesystem  blocks  are  zeroed,  and  whole  filesystem
>        blocks  are removed from the file.  After a successful call, subsequent
>        reads from this range will return zeros.
> 
> So we have, let's say, an order-4 folio and the user tries to PUNCH_HOLE
> page 3 of it.  We try to split it, but that fails because the pipe holds
> a reference.  The filesystem has removed the underlying data from the
> storage medium.  What is the page cache to do?  It must memset() so that
> subsequent reads return zeroes.  And now the page in the pipe has the
> hole punched into it.

Ok, that's what I suspected.

> I think you can reproduce this problem without large folios by using a
> 512-byte block size filesystem and punching holes that are sub page
> size.  The page cache must behave similarly.

Not on XFS. See xfs_flush_unmap_range(), that is run on fallocate
ranges before we do the operation:

	rounding = max_t(xfs_off_t, mp->m_sb.sb_blocksize, PAGE_SIZE);
	start = round_down(offset, rounding);
	end = round_up(offset + len, rounding) - 1;
	....
	truncate_pagecache_range(inode, start, end);

The invalidation rounded to the larger of the PAGE_SIZE or
filesystem block size, so that we, at minimum, invalidate entire
pages in the page cache. The block size case is for doing the right
thing with block size > page size.

Hence XFS will not do sub-page invalidations and so avoids touching
the contents of the page in this case. However, with large folios,
we cannot invalidate entire objects in the page cache like this any
more, so invalidation touches the page contents and that shows up in
the pages that are held in the pipe...

> Perhaps the problem is that splice() appears to copy, but really just
> takes the reference.  Perhaps splice needs to actually copy if it
> sees a multi-page folio and isn't going to take all of it.  I'm not
> an expert in splice-ology, so let's cc some people who know more about
> splice than I do.

Yup, that's pretty much my conclusion - if the destination is page
based, we copy the data. If the destination is a pipe, we simply
take references to the source pages instead of copying the data -
see my followup email.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
