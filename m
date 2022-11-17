Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D662D05E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 02:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiKQBHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 20:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiKQBG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:06:56 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F0462391
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 17:06:55 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k5so256942pjo.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 17:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gU2zkFj/4MP5TNc20vb3DQhOdiasF5SDmuyAS2d911o=;
        b=ET84tYZYgD45j/HvPLS7jmV00d5wT+39K7h72hXkH6eqb8T3nBiI2l/MT8yebR6yhW
         JplkLPHCQufcovqXYbUJcQvng6ICACAdeiKXBQBiXXbqXoiQxVP4blI6FtsfF3yT7PYs
         dWhCd+8MSWrudxqsrnpLjR4UrfXbTO6LXrN2pnZoBjcKN9a9UgEs80B3FMNwZ5PyekKv
         87Ry96axF0UvXukcuMaR9ZFPibIP8577vbig1qMdS/kTzMorAKWsuLJaaNRBXhGnMnlp
         dIz5sTfAgax1jZ6gbxXbDjKtYxB89H/grJ4drw4XSdOiNHANmNM9huvFzuNY3kZaFa6x
         /x6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU2zkFj/4MP5TNc20vb3DQhOdiasF5SDmuyAS2d911o=;
        b=vugQiOF5me6MH+0p7hUXsKjYxirw+N/BY38UWtEbhtWJvSdpLelvR2ymuEaqHwAd46
         kYLSwj/SK9Nwj73fYF5azx+XegO9bZBJmyPGenq0IxOPHsj2OxUPuyEIVPdbKUNAR35w
         lRGl/TKvmW4NZC3zx4FRBxjT5C+0qxlOVoUpgKRLs2CdA0F8NQO2DQCA37At9ADB6F6w
         cL9KT+Fl2HyeUGUuAgtnMVDndnFXrLVOn5MYZdMApyvjRoFq7ehSViHcVUuDxYi8mbwc
         VBEzYP0FFdQT60arcxgxyApeNpUx8u6bm9d8ydyIO4by75Kad0vw6UDYsGISepeMF2sM
         9pQg==
X-Gm-Message-State: ANoB5pm1zdpvUYT+jrD2yqLpXqed9H+520PDBOBnYlHmyCXg8FqR5oy9
        CNUhSA5izhHLkUi4smQEMITIKOSYUKcKcw==
X-Google-Smtp-Source: AA0mqf4pX1MZeCYb8IjWSu2B3O1FAXKmfqkHW0QHlgAQtEueZh8lU15Cm3pMsKDalFuTBDupwgvMyA==
X-Received: by 2002:a17:902:ccc7:b0:17d:8a77:518f with SMTP id z7-20020a170902ccc700b0017d8a77518fmr516965ple.22.1668647215000;
        Wed, 16 Nov 2022 17:06:55 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b001782a0d3eeasm13060421ple.115.2022.11.16.17.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 17:06:54 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ovTMh-00F6oq-Hb; Thu, 17 Nov 2022 12:06:51 +1100
Date:   Thu, 17 Nov 2022 12:06:51 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/9] xfs: buffered write failure should not truncate the
 page cache
Message-ID: <20221117010651.GE3600936@dread.disaster.area>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-6-david@fromorbit.com>
 <Y3QzepGAH+kvgDFE@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3QzepGAH+kvgDFE@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 04:48:58PM -0800, Darrick J. Wong wrote:
> On Tue, Nov 15, 2022 at 12:30:39PM +1100, Dave Chinner wrote:
> > +/*
> > + * Scan the data range passed to us for dirty page cache folios. If we find a
> > + * dirty folio, punch out the preceeding range and update the offset from which
> > + * the next punch will start from.
> > + *
> > + * We can punch out clean pages because they either contain data that has been
> > + * written back - in which case the delalloc punch over that range is a no-op -
> > + * or they have been read faults in which case they contain zeroes and we can
> > + * remove the delalloc backing range and any new writes to those pages will do
> > + * the normal hole filling operation...
> > + *
> > + * This makes the logic simple: we only need to keep the delalloc extents only
> > + * over the dirty ranges of the page cache.
> > + */
> > +static int
> > +xfs_buffered_write_delalloc_scan(
> > +	struct inode		*inode,
> > +	loff_t			*punch_start_byte,
> > +	loff_t			start_byte,
> > +	loff_t			end_byte)
> > +{
> > +	loff_t			offset = start_byte;
> > +
> > +	while (offset < end_byte) {
> > +		struct folio	*folio;
> > +
> > +		/* grab locked page */
> > +		folio = filemap_lock_folio(inode->i_mapping, offset >> PAGE_SHIFT);
> > +		if (!folio) {
> > +			offset = ALIGN_DOWN(offset, PAGE_SIZE) + PAGE_SIZE;
> > +			continue;
> > +		}
> > +
> > +		/* if dirty, punch up to offset */
> > +		if (folio_test_dirty(folio)) {
> > +			if (offset > *punch_start_byte) {
> > +				int	error;
> > +
> > +				error = xfs_buffered_write_delalloc_punch(inode,
> > +						*punch_start_byte, offset);
> 
> This sounds an awful lot like what iomap_writeback_ops.discard_folio()
> does, albeit without the xfs_alert screaming everywhere.

similar, but .discard_folio() is trashing uncommitted written data,
whilst this loop is explicitly preserving uncommitted written
data....

> Moving along... so we punch out delalloc reservations for any part of
> the page cache that is clean.  "punch_start_byte" is the start pos of
> the last range of clean cache, and we want to punch up to the start of
> this dirty folio...
> 
> > +				if (error) {
> > +					folio_unlock(folio);
> > +					folio_put(folio);
> > +					return error;
> > +				}
> > +			}
> > +
> > +			/*
> > +			 * Make sure the next punch start is correctly bound to
> > +			 * the end of this data range, not the end of the folio.
> > +			 */
> > +			*punch_start_byte = min_t(loff_t, end_byte,
> > +					folio_next_index(folio) << PAGE_SHIFT);
> 
> ...and then start a new clean range after this folio (or at the end_byte
> to signal that we're done)...

Yes.

> > +	filemap_invalidate_lock(inode->i_mapping);
> > +	while (start_byte < end_byte) {
> > +		loff_t		data_end;
> > +
> > +		start_byte = mapping_seek_hole_data(inode->i_mapping,
> > +				start_byte, end_byte, SEEK_DATA);
> > +		/*
> > +		 * If there is no more data to scan, all that is left is to
> > +		 * punch out the remaining range.
> > +		 */
> > +		if (start_byte == -ENXIO || start_byte == end_byte)
> > +			break;
> > +		if (start_byte < 0) {
> > +			error = start_byte;
> > +			goto out_unlock;
> > +		}
> > +		ASSERT(start_byte >= punch_start_byte);
> > +		ASSERT(start_byte < end_byte);
> > +
> > +		/*
> > +		 * We find the end of this contiguous cached data range by
> > +		 * seeking from start_byte to the beginning of the next hole.
> > +		 */
> > +		data_end = mapping_seek_hole_data(inode->i_mapping, start_byte,
> > +				end_byte, SEEK_HOLE);
> > +		if (data_end < 0) {
> > +			error = data_end;
> > +			goto out_unlock;
> > +		}
> > +		ASSERT(data_end > start_byte);
> > +		ASSERT(data_end <= end_byte);
> > +
> > +		error = xfs_buffered_write_delalloc_scan(inode,
> > +				&punch_start_byte, start_byte, data_end);
> 
> ...and we use SEEK_HOLE/SEEK_DATA to find the ranges of pagecache where
> there's even going to be folios mapped.  But in structuring the code
> like this, xfs now has to know details about folio state again, and the
> point of iomap/buffered-io.c is to delegate handling of the pagecache
> away from XFS, at least for filesystems that want to manage buffered IO
> the same way XFS does.
> 
> IOWs, I agree with Christoph that these two functions that compute the
> ranges that need delalloc-punching really ought to be in the iomap code.

Which I've already done.

> TBH I wonder if this isn't better suited for being called by
> iomap_write_iter after a short write on an IOMAP_F_NEW iomap, with an
> function pointer in iomap page_ops for iomap to tell xfs to drop the
> delalloc reservations.

IIRC, the whole point of the iomap_begin()/iomap_end() operation
pairs is that the iter functions don't need to concern themselves
with the filesystem operations needed to manipulate extents and
clean up filesystem state as a result of failed operations.

I'm pretty sure we need this same error handling for zeroing and
unshare operations, because they could also detect stale cached
iomaps and have to go remap their extents. Maybe they don't allocate
new extents, but that is beside the point - the error handling that
is necessary is common to multiple functions, and right now they
don't have to care about cleaning up iomap/filesystem state when
short writes/errors occur.

Hence I don't think we want to break the architectural layering by
doing this - I think it would just lead to having to handle the same
issues in multiple places, and we don't gain any extra control over
or information about how to perform the cleanup of the unused
portion of the iomap....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
