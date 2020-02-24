Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26531169CFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 05:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgBXEd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 23:33:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgBXEd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oZOe8S6XU8WPAzzWKK+7v8HQwuSfqOL+eNbf+Acq4Wc=; b=ALNrh1EBEZbPI0eohwoy43k7IJ
        XJ2e9816/Cs/vRrqDf3S6gKYY5tNTkWN4kjJFPML+eVKwmz8Ej5/NJIR097xCbOVGT4n/3FVCtY3O
        gn/yNbyTTS/qLVvgD8a/9uv4J4ws/6B3fng445cylTypcWambS3YaUfmoMD+/TOtojzWbjZpE6/zo
        ghV8g3yRtNrjP80Aoo51Pd9fIJz1CgBzZuRDbL9STCkWsJuA7Fz9M8l7mClCERunvUnwRHI/iy7J0
        DR9XgSFpwQPqfjwVfkmT0/g0k3jsyI3Efuhg2HSWlBcxnyFp7l7jjt1QI9lutMTR51+hhwlnhGP9z
        +ZZz/7SQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j65RL-0000Cd-GT; Mon, 24 Feb 2020 04:33:55 +0000
Date:   Sun, 23 Feb 2020 20:33:55 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v7 22/24] iomap: Convert from readpages to readahead
Message-ID: <20200224043355.GL24185@bombadil.infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-23-willy@infradead.org>
 <20200220154912.GC19577@infradead.org>
 <20200220165734.GZ24185@bombadil.infradead.org>
 <20200222010013.GH9506@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222010013.GH9506@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 05:00:13PM -0800, Darrick J. Wong wrote:
> On Thu, Feb 20, 2020 at 08:57:34AM -0800, Matthew Wilcox wrote:
> > On Thu, Feb 20, 2020 at 07:49:12AM -0800, Christoph Hellwig wrote:
> > +/**
> > + * iomap_readahead - Attempt to read pages from a file.
> > + * @rac: Describes the pages to be read.
> > + * @ops: The operations vector for the filesystem.
> > + *
> > + * This function is for filesystems to call to implement their readahead
> > + * address_space operation.
> > + *
> > + * Context: The file is pinned by the caller, and the pages to be read are
> > + * all locked and have an elevated refcount.  This function will unlock
> > + * the pages (once I/O has completed on them, or I/O has been determined to
> > + * not be necessary).  It will also decrease the refcount once the pages
> > + * have been submitted for I/O.  After this point, the page may be removed
> > + * from the page cache, and should not be referenced.
> > + */
> > 
> > > Isn't the context documentation something that belongs into the aop
> > > documentation?  I've never really seen the value of duplicating this
> > > information in method instances, as it is just bound to be out of date
> > > rather sooner than later.
> > 
> > I'm in two minds about it as well.  There's definitely no value in
> > providing kernel-doc for implementations of a common interface ... so
> > rather than fixing the nilfs2 kernel-doc, I just deleted it.  But this
> > isn't just the implementation, like nilfs2_readahead() is, it's a library
> > function for filesystems to call, so it deserves documentation.  On the
> > other hand, there's no real thought to this on the part of the filesystem;
> > the implementation just calls this with the appropriate ops pointer.
> > 
> > Then again, I kind of feel like we need more documentation of iomap to
> > help filesystems convert to using it.  But maybe kernel-doc isn't the
> > mechanism to provide that.
> 
> I think we need more documentation of the parts of iomap where it can
> call back into the filesystem (looking at you, iomap_dio_ops).
> 
> I'm not opposed to letting this comment stay, though I don't see it as
> all that necessary since iomap_readahead implements a callout that's
> documented in vfs.rst and is thus subject to all the constraints listed
> in the (*readahead) documentation.

Right.  And that's not currently in kernel-doc format, but should be.
Something for a different patchset, IMO.

What we need documenting _here_ is the conditions under which the
iomap_ops are called so the filesystem author doesn't need to piece them
together from three different places.  Here's what I currently have:

 * Context: The @ops callbacks may submit I/O (eg to read the addresses of
 * blocks from disc), and may wait for it.  The caller may be trying to
 * access a different page, and so sleeping excessively should be avoided.
 * It may allocate memory, but should avoid large allocations.  This
 * function is called with memalloc_nofs set, so allocations will not cause
 * the filesystem to be reentered.

