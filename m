Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB63D616F71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 22:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiKBVLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 17:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBVLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:11:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C61E001
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 14:11:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p15-20020a17090a348f00b002141615576dso3294149pjb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Nov 2022 14:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SPWKli0K9g7XkFx6xypne4c3+CX6qdwNxS/7IkeGbtU=;
        b=iIB0p5QgiO8PsfJZ9pQQWVfx3VH3l9pvgluQSfwJJLO9r0FIEUVpRFYz09Rq6k62Pb
         52ZQSAu2nDbq0WUJP4cU4PfwqT0OQAPel3ORu/MUy26Kx4Cj7jbS7+J2lSMN3EpWxB8J
         BaKfU3yAtQ5KZe2GZqSljCbzeqPxCncp1T+cvwwcWhXvvuZUgHEy48rpLCuYRwtjm4bX
         w+giuGil1HKmcdJ5B+0wOeoOVQg15HcN4tDGOeIbvtI3cBq8Sh5FT7HfmAyUZA4v2UzU
         l8ViJKFPgSUjD+1NIcv/nWra7s6vVlkZG2sl/SKaHpt4vvUwdLyrA805WQFbD1gRradC
         5XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPWKli0K9g7XkFx6xypne4c3+CX6qdwNxS/7IkeGbtU=;
        b=bYtE9Dg/rBFwOGHxCpszrNhasAHW8UQBRW8wNcatT5FrP+VyQ8/L0yoblZ6Gdv/vtd
         SwkvYijLEYJXnG6XIUzwBbTOH3AGs7XuHRps85E368qjjXG2NuHdGehLoxxbhyme4b3I
         LGGaxpyJnXVnShiFCWfhI5V3QnvQSaJztNE9yKiZzE5lSpMSohkCO7f1Clvn3DXgW8wr
         WpczuCzr7V8duJrUxJBezeWyN+VsFBoyqVWJNBmSpnQhCPgeS0sQIbYVvR10DEh4LGHc
         UUfWgUZIZAZ/PlOZkfFo+l8Cmle5myfWOFiOK49/wYqfgGTLiN2PYZ5jXv+9ni8aYN80
         upqg==
X-Gm-Message-State: ACrzQf1QDyD2PXhVgw5jV2Wl/YmiCaICIporn49HrJc5xVOs1g2empec
        WCobRIdpp+7YDI33fqSNsP7/mQ==
X-Google-Smtp-Source: AMsMyM5WNBP4EYlCbYTPSywJck0p5G9cCvONx7D9oyz1DdVI9vEGIkhoNqNjYd0I2ofxht7ZAfGuuA==
X-Received: by 2002:a17:902:d592:b0:17a:582:4eb with SMTP id k18-20020a170902d59200b0017a058204ebmr26803155plh.40.1667423506277;
        Wed, 02 Nov 2022 14:11:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id f26-20020aa7969a000000b0056bfd4a2702sm8860859pfk.45.2022.11.02.14.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 14:11:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oqL1S-009WQj-2E; Thu, 03 Nov 2022 08:11:42 +1100
Date:   Thu, 3 Nov 2022 08:11:42 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] xfs: write page faults in iomap are not buffered
 writes
Message-ID: <20221102211142.GA3600936@dread.disaster.area>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-2-david@fromorbit.com>
 <Y2KW1Y0kKvXtZDVr@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2KW1Y0kKvXtZDVr@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:12:05AM -0700, Darrick J. Wong wrote:
> On Tue, Nov 01, 2022 at 11:34:06AM +1100, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > When we reserve a delalloc region in xfs_buffered_write_iomap_begin,
> > we mark the iomap as IOMAP_F_NEW so that the the write context
> > understands that it allocated the delalloc region.
> > 
> > If we then fail that buffered write, xfs_buffered_write_iomap_end()
> > checks for the IOMAP_F_NEW flag and if it is set, it punches out
> > the unused delalloc region that was allocated for the write.
> > 
> > The assumption this code makes is that all buffered write operations
> > that can allocate space are run under an exclusive lock (i_rwsem).
> > This is an invalid assumption: page faults in mmap()d regions call
> > through this same function pair to map the file range being faulted
> > and this runs only holding the inode->i_mapping->invalidate_lock in
> > shared mode.
> > 
> > IOWs, we can have races between page faults and write() calls that
> > fail the nested page cache write operation that result in data loss.
> > That is, the failing iomap_end call will punch out the data that
> > the other racing iomap iteration brought into the page cache. This
> > can be reproduced with generic/34[46] if we arbitrarily fail page
> > cache copy-in operations from write() syscalls.
> > 
> > Code analysis tells us that the iomap_page_mkwrite() function holds
> > the already instantiated and uptodate folio locked across the iomap
> > mapping iterations. Hence the folio cannot be removed from memory
> > whilst we are mapping the range it covers, and as such we do not
> > care if the mapping changes state underneath the iomap iteration
> > loop:
> > 
> > 1. if the folio is not already dirty, there is no writeback races
> >    possible.
> > 2. if we allocated the mapping (delalloc or unwritten), the folio
> >    cannot already be dirty. See #1.
> > 3. If the folio is already dirty, it must be up to date. As we hold
> >    it locked, it cannot be reclaimed from memory. Hence we always
> >    have valid data in the page cache while iterating the mapping.
> > 4. Valid data in the page cache can exist when the underlying
> >    mapping is DELALLOC, UNWRITTEN or WRITTEN. Having the mapping
> >    change from DELALLOC->UNWRITTEN or UNWRITTEN->WRITTEN does not
> >    change the data in the page - it only affects actions if we are
> >    initialising a new page. Hence #3 applies  and we don't care
> >    about these extent map transitions racing with
> >    iomap_page_mkwrite().
> > 5. iomap_page_mkwrite() checks for page invalidation races
> >    (truncate, hole punch, etc) after it locks the folio. We also
> >    hold the mapping->invalidation_lock here, and hence the mapping
> >    cannot change due to extent removal operations while we are
> >    iterating the folio.
> > 
> > As such, filesystems that don't use bufferheads will never fail
> > the iomap_folio_mkwrite_iter() operation on the current mapping,
> > regardless of whether the iomap should be considered stale.
> > 
> > Further, the range we are asked to iterate is limited to the range
> > inside EOF that the folio spans. Hence, for XFS, we will only map
> > the exact range we are asked for, and we will only do speculative
> > preallocation with delalloc if we are mapping a hole at the EOF
> > page. The iterator will consume the entire range of the folio that
> > is within EOF, and anything beyond the EOF block cannot be accessed.
> > We never need to truncate this post-EOF speculative prealloc away in
> > the context of the iomap_page_mkwrite() iterator because if it
> > remains unused we'll remove it when the last reference to the inode
> > goes away.
> 
> Why /do/ we need to trim the delalloc reservations after a failed
> write(), anyway?  I gather it's because we don't want to end up with a
> clean page backed by a delalloc reservation because writeback will never
> get run to convert that reservation into real space, which means we've
> leaked the reservation until someone dirties the page?

Yup, we leak the delalloc reservation and extent until the inode is
evicted from cache. What happens when reads/page faults happen over
that page from that point is now an interesting question - it might
all work correctly, but then again it might not...

> Ah.  Inode eviction also complains about inodes with delalloc
> reservations.  The blockgc code only touches cow fork mappings and
> post-eof blocks, which means it doesn't look for these dead/orphaned
> delalloc reservations either.

Yup, the inode eviction code that detects leaked delalloc blocks is
a useful canary - if it fires, it tends to indicate a bug in the
allocation/free code somewhere. If we allowed leaking delalloc
extents, we lose that canary.

And, yes, we'd need to make xfs_free_eofblocks() now search for
leaked delalloc blocks within EOF and punch them out, but then it
would have to either do the "search page cache for dirty pages" walk
or force writeback first.

None of these things feel like an improvement to me.

-Dave.

-- 
Dave Chinner
david@fromorbit.com
