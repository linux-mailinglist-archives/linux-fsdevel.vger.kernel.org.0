Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5792EDFC1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 05:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbfJVDCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 23:02:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35258 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbfJVDCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 23:02:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id c8so4219972pgb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 20:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+jIHf3exWLdaE/fEITwJGVMOa1FtsFec3hIP9SE5QxA=;
        b=ekf2YmyzNeV76EquBCkQM7EgkO9gvNsFcOZiqVtO14jXkstrJxzRe9uNPl62z/IwuO
         7LEP6ZXlAAkRDCfWgYnbeWtYZSpo/Yc9edfxmfemz5h7Mzl26+egHzUJ9Av0EFAAgRBe
         fcf8CLff6mLFlu3mpkuXg9SR4T3yqL9fUSl1yZZ+3Z/k2Qj9PFy/aQRnEj8RZXBlZ82Q
         7kx1VDK3B9xGw2w5R7FCvyXOh757QQlwhTFzDVRyNjbKF2BeqmxjYyoYI6rkKYp+jiCo
         nKqRnj7lOEjh2DZpzsDSUlIGnVNo07kd1w76c8sH/foQ8xi+kJIJ567AZjv4tkdITIvf
         dk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+jIHf3exWLdaE/fEITwJGVMOa1FtsFec3hIP9SE5QxA=;
        b=JOLxI1vRqUsk/ELaWeJHYDjIdAhS7wTphPEcbVhG3oRGUQKBzMdahsG7zykPsZ8EFY
         wY5ByLanzK/nsbpPMKt33OeLyZvHRU0xc21RmXdGnqB3TdD15LPVTxPT6EbPZ36s5aCB
         beWQaA5cfSnh1+ick+FpMXDO4DZJBtLMOyRKgmOtAXMAu5HHv32lW1qsEIrDA0fdrJZS
         DWy8JXgAoH2ZlnskjlIVNDb+b7b2bSsNHspADbdVGiEyKY5qeJJZXJfS2oypP+9+EkQS
         OT4KAPwEN6UL8+ZqZP1KJX6kU7gF0H9cXdbi93nk+dVtyL4i2DrAVx7M9sFKMzpSTZ7f
         NRKw==
X-Gm-Message-State: APjAAAV951ftCGQLHVNWcjs5eP6xuRPkHIwhmhTg9eY8D6urVFltuO+O
        pZ3y+PUBb+zXvqqmNJ0amtBE
X-Google-Smtp-Source: APXvYqyTusBvbiJo3GUpF35u8T90Zre/B23uqJ2lV02p5SSbwTp+3BIAZB/5vZ/T2NJfd0s+Q6kWKA==
X-Received: by 2002:aa7:9467:: with SMTP id t7mr1536126pfq.172.1571713362397;
        Mon, 21 Oct 2019 20:02:42 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id a11sm15650538pgw.64.2019.10.21.20.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 20:02:41 -0700 (PDT)
Date:   Tue, 22 Oct 2019 14:02:35 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 12/12] ext4: introduce direct I/O write using iomap
 infrastructure
Message-ID: <20191022030235.GG5092@athena.bobrowski.net>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <c3438dad66a34a7d4e7509a5dd64c2326340a52a.1571647180.git.mbobrowski@mbobrowski.org>
 <20191021161848.GI25184@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021161848.GI25184@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 06:18:48PM +0200, Jan Kara wrote:
> On Mon 21-10-19 20:20:20, Matthew Bobrowski wrote:
> > This patch introduces a new direct I/O write path which makes use of
> > the iomap infrastructure.
> > 
> > All direct I/O writes are now passed from the ->write_iter() callback
> > through to the new direct I/O handler ext4_dio_write_iter(). This
> > function is responsible for calling into the iomap infrastructure via
> > iomap_dio_rw().
> > 
> > Code snippets from the existing direct I/O write code within
> > ext4_file_write_iter() such as, checking whether the I/O request is
> > unaligned asynchronous I/O, or whether the write will result in an
> > overwrite have effectively been moved out and into the new direct I/O
> > ->write_iter() handler.
> > 
> > The block mapping flags that are eventually passed down to
> > ext4_map_blocks() from the *_get_block_*() suite of routines have been
> > taken out and introduced within ext4_iomap_alloc().
> > 
> > For inode extension cases, ext4_handle_inode_extension() is
> > effectively the function responsible for performing such metadata
> > updates. This is called after iomap_dio_rw() has returned so that we
> > can safely determine whether we need to potentially truncate any
> > allocated blocks that may have been prepared for this direct I/O
> > write. We don't perform the inode extension, or truncate operations
> > from the ->end_io() handler as we don't have the original I/O 'length'
> > available there. The ->end_io() however is responsible fo converting
> > allocated unwritten extents to written extents.
> > 
> > In the instance of a short write, we fallback and complete the
> > remainder of the I/O using buffered I/O via
> > ext4_buffered_write_iter().
> > 
> > The existing buffer_head direct I/O implementation has been removed as
> > it's now redundant.
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > ---
> >  fs/ext4/ext4.h    |   3 -
> >  fs/ext4/extents.c |   4 +-
> >  fs/ext4/file.c    | 236 ++++++++++++++++++--------
> >  fs/ext4/inode.c   | 411 +++++-----------------------------------------
> >  4 files changed, 207 insertions(+), 447 deletions(-)
> 
> The patch looks good to me! You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks Jan! :)

> One nitpick below:
> 
> > +	if (extend) {
> > +		ret = ext4_handle_inode_extension(inode, ret, offset, count);
> > +
> > +		/*
> > +		 * We may have failed to remove the inode from the orphan list
> > +		 * in the case that the i_disksize got update due to delalloc
> > +		 * writeback while the direct I/O was running. We need to make
> > +		 * sure we remove it from the orphan list as if we've
> > +		 * prematurely popped it onto the list.
> > +		 */
> > +		if (!list_empty(&EXT4_I(inode)->i_orphan)) {
> > +			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> > +			if (IS_ERR(handle)) {
> > +				ret = PTR_ERR(handle);
> > +				if (inode->i_nlink)
> > +					ext4_orphan_del(NULL, inode);
> > +				goto out;
> > +			}
> > +
> > +			if (inode->i_nlink)
> 
> This check can be joined with the list_empty() check above to save us from
> unnecessarily starting a transaction.

Yes, easy done.

> Also I was wondering whether it would not make more sense have this
> orphan handling bit also in
> ext4_handle_inode_extension(). ext4_dax_write_iter() doesn't
> strictly need it (as for DAX i_disksize cannot currently change
> while ext4_dax_write_iter() is running) but it would look more
> robust to me for the future users and it certainly doesn't hurt
> ext4_dax_write_iter() case.

I was thinking the same, but to be honest I wasn't entirely sure how
it would pan out for the DAX code path. However, seeing as though you
don't forsee there being any problems, then I can't really think of a
reason not to roll this up into ext4_handle_inode_extension().

So, in ext4_handle_inode_extension() for the initial check against
i_disksize, rather than returning 'written' and then having
ext4_dio_write_iter() perform the cleanup, we could simply jump to a
chunk of code in ext4_handle_inode_extension() and deal with it there,
or quite literally just cleanup if that branch is taken there and then
seeing as though it's not really needed in any other case? What do you
think?

--<M>--
