Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E707D6A4B82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjB0Trm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 14:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjB0Tri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:47:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13D228215
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 11:47:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81B16B80DB1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 19:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180BAC433D2;
        Mon, 27 Feb 2023 19:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677527245;
        bh=lzfzDpupVAFg/QPvmyRLydbCbV+3pyAG9XpfpP6HYRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nVoSzA3xh4Syfl7JMJ7t0ZuZoUvaA3/CboWmHYNrAYtvCQ5S6Gmk2uI2dvajY7nL/
         yBkmw8KUD2hRmONgua8cgy1PiUzy2iHE0uBNtI0l1qoPwl6t73LbCHW0mD32Ub+6de
         0f6z8wkZqKHnk+XxpinRQycKwWYdk6SnHexpEAe8SPPmk9L0odbx+CzWk5it7mtMbD
         YCqrOCiNG2CHcHoODs500scqlLaJFCQX1xIWYZw9NhP1xvidDzYXNs7xUDtsXFX3OO
         XpowpH0kea6rFWxZrgBkbwQdgzeLfT3kJl1KJ2hyfdp9y1BbIxLt+OOKU063vjqh55
         hCjsimVLQGk+Q==
Date:   Mon, 27 Feb 2023 11:47:24 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: LSF/MM/BPF 2023 IOMAP conversion status update
Message-ID: <Y/0IzG4S2l52oC7R@magnolia>
References: <20230129044645.3cb2ayyxwxvxzhah@garbanzo>
 <Y9X+5wu8AjjPYxTC@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9X+5wu8AjjPYxTC@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 29, 2023 at 05:06:47AM +0000, Matthew Wilcox wrote:
> On Sat, Jan 28, 2023 at 08:46:45PM -0800, Luis Chamberlain wrote:
> > I'm hoping this *might* be useful to some, but I fear it may leave quite
> > a bit of folks with more questions than answers as it did for me. And
> > hence I figured that *this aspect of this topic* perhaps might be a good
> > topic for LSF.  The end goal would hopefully then be finally enabling us
> > to document IOMAP API properly and helping with the whole conversion
> > effort.
> 
> +1 from me.
> 
> I've made a couple of abortive efforts to try and convert a "trivial"
> filesystem like ext2/ufs/sysv/jfs to iomap, and I always get hung up on
> what the semantics are for get_block_t and iomap_begin().

Yup.  I wrote about it a little bit here:

https://lore.kernel.org/linux-fsdevel/Y%2Fz%2FJrV8qRhUcqE7@magnolia/T/#mda6c3175857d1e4cba88dca042fee030207df4f6

...and promised that I'd get back to writeback.

For buffered IO, iomap does things in a much different order than (I
think) most filesystems.  Traditionally, I think the order is i_rwsem ->
mmap_invalidatelock(?) -> page lock -> get mapping.

iomap relies on the callers to take i_rwsem, asks the filesystem for a
mapping (with whatever locking that entails), and only then starts
locking pagecache folios to operate on them.  IOWs, involving the
filesystem earlier in the process enables it to make better decisions
about space allocations, which in turn should make things faster and
less fragmenty.

OTOH, it also means that we've learned the hard way that pagecache
operations need a means to revalidate mappings to avoid write races.
This applies both to the initial pagecache write and to scheduling
writeback, but the mechanisms for each were developed separately and
years apart.  See iomap::validity_cookie and
xfs_writepage_ctx::{data,cow}_seq for what I'm talking about.
We (xfs developers) ought to figure out if these two mechanisms should
be merged before more filesystems start using iomap for buffered io.

I'd like to have a discussion about how to clean up and clarify the
iomap interfaces, and a separate one about how to port the remaining 35+
filesystems.  I don't know how exactly to split this into LSF sessions,
other than to suggest at least two.

If hch or dchinner show up, I also want to drag them into this. :)

--D

> > Perhaps fs/buffers.c could be converted to folios only, and be done
> > with it. But would we be loosing out on something? What would that be?
> 
> buffer_heads are inefficient for multi-page folios because some of the
> algorthims are O(n^2) for n being the number of buffers in a folio.
> It's fine for 8x 512b buffers in a 4k page, but for 512x 4kb buffers in
> a 2MB folio, it's pretty sticky.  Things like "Read I/O has completed on
> this buffer, can I mark the folio as Uptodate now?"  For iomap, that's a
> scan of a 64 byte bitmap up to 512 times; for BHs, it's a loop over 512
> allocations, looking at one bit in each BH before moving on to the next.
> Similarly for writeback, iirc.
> 
> So +1 from me for a "How do we convert 35-ish block based filesystems
> from BHs to iomap for their buffered & direct IO paths".  There's maybe a
> separate discussion to be had for "What should the API be for filesystems
> to access metadata on the block device" because I don't believe the
> page-cache based APIs are easy for fs authors to use.
> 
> Maybe some related topics are
> "What testing should we require for some of these ancient filesystems?"
> "Whose job is it to convert these 35 filesystems anyway, can we just
> delete some of them?"
> "Is there a lower-performance but easier-to-implement API than iomap
> for old filesystems that only exist for compatibiity reasons?"
> 
