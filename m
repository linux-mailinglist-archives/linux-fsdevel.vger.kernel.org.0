Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBD31B20F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 10:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgDUIEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 04:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgDUIEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:04:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862C4C061A0F;
        Tue, 21 Apr 2020 01:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yR/SejXRtkIBt5WwaZIjG3MmJx16MtzDVh8+8QsAIfU=; b=YYdCkCk3wYNmvbfwHcGOCH5VNI
        rDDzuuL8y+kn9iTyFcNM5hHfd4KaV7mMEYIqjb2wKPL4bwV6MMV4c2pYCHaAmG3uhCjC6OpEFwwNZ
        gncxeAbJFT0l7qEU4qwl9norHMQZBXFM2TpT/rGdocOHcSl69KRZT4MPSCxdlde+w4E6BrwQJaoUS
        nzW8WT0hd9wAwNsBChudOQks1wyCiBvAtFzH5tdf/7V4WbpY9FnshRsn+j2X0UceVjiiEymaivqoI
        bxAbonyYiljXtAKeDb/fTN4FoRcPr5/UxcM/em+S6ZDles7tatQOdd7Yuf2QJxYwauu9Ihg3AC4rz
        Wxv1NXzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQnsz-0003yQ-Ir; Tue, 21 Apr 2020 08:04:05 +0000
Date:   Tue, 21 Apr 2020 01:04:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        bugzilla-daemon@bugzilla.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [Bug 207367] Accraid / aptec / Microsemi / ext4 / larger then
 16TB
Message-ID: <20200421080405.GA4149@infradead.org>
References: <bug-207367-13602@https.bugzilla.kernel.org/>
 <bug-207367-13602-zdl9QZH6DN@https.bugzilla.kernel.org/>
 <20200421042039.BF8074C046@d06av22.portsmouth.uk.ibm.com>
 <20200421050850.GB27860@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421050850.GB27860@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 03:08:50PM +1000, Dave Chinner wrote:
> > FYI - I do see that bmap() is also used by below APIs/subsystem.
> > Not sure if any of subsystems mentioned below may still fail later
> > if the underlying FS moved to iomap_bmap() interface or for
> > any existing callers of iomap_bmap() :-
> > 
> > 1. mm/page-io.c (generic_swapfile_activate() func)
> 
> Filesystems using iomap infrastructure should be providing
> aops->swap_activate() to map swapfile extents via
> iomap_swapfile_activate() (e.g. see xfs_iomap_swapfile_activate()),
> not using generic_swapfile_activate().

And we also need to eventually phase generic_swapfile_activate out,
maybe by having a version with a get_blocks callback for the non-iomap
case.

> > 4. fs/jbd2/journal.c
> 
> Broken on filesystems where the journal file might be placed beyond
> a 32 bit block number, iomap_bmap() just makes that obvious. Needs
> fixing.

I think this wants to use iomap, as that would solve all the problems.

> And you missed the MD bitmap code uses bmap() to map it's bitmap
> storage file, which means that is broken is the bitmap file is on a
> filesystem/block device > 16TB, too...

This probably needs to use the in-kernel direct I/O interface, just
as it is planned for cachefiles.
