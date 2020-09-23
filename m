Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D876E2760A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 20:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgIWS7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 14:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgIWS7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:59:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E523C0613CE;
        Wed, 23 Sep 2020 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b12w9z8RoIzPGMOQMxwodI4Kd4EF2wwwEX9LyxbU+y4=; b=cl5OSFuYx3vieMBKbrWE/ACaAE
        CBUeAT6PAykw9YYgMc5EI3LD/veQ7+97jrdN3dUfffrQwgBTnJMyg93d/S/QkOqn0VWhNJnyn5XLz
        6LuISIjyFdzgpJ6Y5fzL+fGIcofF29n/0SLI89FOsPmp1YVMVH1yb8yRB90yvzctdfCEMlaMwrPST
        8rSvKGxuuZqNcN065x5TQL0b5oyELV9bAM7JQXRFdoMQc9wlSOj1Tl5OWJfr0gi6yR4ojkNZKqQV7
        tq35ZEsC4/bsabwdyIjIUhSJeCwL0cbLDkrNp7NRHqwr5xVWamY8DJ31/Pz3F4JsOwSUV6O4msNBn
        6pdz+R/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kL9zU-00052r-Kb; Wed, 23 Sep 2020 18:59:44 +0000
Date:   Wed, 23 Sep 2020 19:59:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Dave Chinner <dchinner@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org
Subject: Re: [PATCH v2 5/9] iomap: Support arbitrarily many blocks per page
Message-ID: <20200923185944.GQ32101@casper.infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-6-willy@infradead.org>
 <163f852ba12fd9de5dec7c4a2d6b6c7cdb379ebc.camel@redhat.com>
 <20200922170526.GK32101@casper.infradead.org>
 <95bd1230f2fcf01f690770eb77696862b8fb607b.camel@redhat.com>
 <20200923024859.GM32101@casper.infradead.org>
 <20200923050001.GE7949@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923050001.GE7949@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:00:01PM -0700, Darrick J. Wong wrote:
> On Wed, Sep 23, 2020 at 03:48:59AM +0100, Matthew Wilcox wrote:
> > On Tue, Sep 22, 2020 at 09:06:03PM -0400, Qian Cai wrote:
> > > On Tue, 2020-09-22 at 18:05 +0100, Matthew Wilcox wrote:
> > > > On Tue, Sep 22, 2020 at 12:23:45PM -0400, Qian Cai wrote:
> > > > > On Fri, 2020-09-11 at 00:47 +0100, Matthew Wilcox (Oracle) wrote:
> > > > > > Size the uptodate array dynamically to support larger pages in the
> > > > > > page cache.  With a 64kB page, we're only saving 8 bytes per page today,
> > > > > > but with a 2MB maximum page size, we'd have to allocate more than 4kB
> > > > > > per page.  Add a few debugging assertions.
> > > > > > 
> > > > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > > > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > > > > 
> > > > > Some syscall fuzzing will trigger this on powerpc:
> > > > > 
> > > > > .config: https://gitlab.com/cailca/linux-mm/-/blob/master/powerpc.config
> > > > > 
> > > > > [ 8805.895344][T445431] WARNING: CPU: 61 PID: 445431 at fs/iomap/buffered-
> > > > > io.c:78 iomap_page_release+0x250/0x270
> > > > 
> > > > Well, I'm glad it triggered.  That warning is:
> > > >         WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> > > >                         PageUptodate(page));
> > > > so there was definitely a problem of some kind.
> > > > 
> > > > truncate_cleanup_page() calls
> > > > do_invalidatepage() calls
> > > > iomap_invalidatepage() calls
> > > > iomap_page_release()
> > > > 
> > > > Is this the first warning?  I'm wondering if maybe there was an I/O error
> > > > earlier which caused PageUptodate to get cleared again.  If it's easy to
> > > > reproduce, perhaps you could try something like this?
> > > > 
> > > > +void dump_iomap_page(struct page *page, const char *reason)
> > > > +{
> > > > +       struct iomap_page *iop = to_iomap_page(page);
> > > > +       unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
> > > > +
> > > > +       dump_page(page, reason);
> > > > +       if (iop)
> > > > +               printk("iop:reads %d writes %d uptodate %*pb\n",
> > > > +                               atomic_read(&iop->read_bytes_pending),
> > > > +                               atomic_read(&iop->write_bytes_pending),
> > > > +                               nr_blocks, iop->uptodate);
> > > > +       else
> > > > +               printk("iop:none\n");
> > > > +}
> > > > 
> > > > and then do something like:
> > > > 
> > > > 	if (bitmap_full(iop->uptodate, nr_blocks) != PageUptodate(page))
> > > > 		dump_iomap_page(page, NULL);
> > > 
> > > This:
> > > 
> > > [ 1683.158254][T164965] page:000000004a6c16cd refcount:2 mapcount:0 mapping:00000000ea017dc5 index:0x2 pfn:0xc365c
> > > [ 1683.158311][T164965] aops:xfs_address_space_operations ino:417b7e7 dentry name:"trinity-testfile2"
> > > [ 1683.158354][T164965] flags: 0x7fff8000000015(locked|uptodate|lru)
> > > [ 1683.158392][T164965] raw: 007fff8000000015 c00c0000019c4b08 c00c0000019a53c8 c000201c8362c1e8
> > > [ 1683.158430][T164965] raw: 0000000000000002 0000000000000000 00000002ffffffff c000201c54db4000
> > > [ 1683.158470][T164965] page->mem_cgroup:c000201c54db4000
> > > [ 1683.158506][T164965] iop:none
> > 
> > Oh, I'm a fool.  This is after the call to detach_page_private() so
> > page->private is NULL and we don't get the iop dumped.
> > 
> > Nevertheless, this is interesting.  Somehow, the page is marked Uptodate,
> > but the bitmap is deemed not full.  There are three places where we set
> > an iomap page Uptodate:
> > 
> > 1.      if (bitmap_full(iop->uptodate, i_blocks_per_page(inode, page)))
> >                 SetPageUptodate(page);
> > 
> > 2.      if (page_has_private(page))
> >                 iomap_iop_set_range_uptodate(page, off, len);
> >         else
> >                 SetPageUptodate(page);
> > 
> > 3.      BUG_ON(page->index);
> > ...
> >         SetPageUptodate(page);
> > 
> > It can't be #2 because the page has an iop.  It can't be #3 because the
> > page->index is not 0.  So at some point in the past, the bitmap was full.
> > 
> > I don't think it's possible for inode->i_blksize to change, and you
> > aren't running with THPs, so it's definitely not possible for thp_size()
> > to change.  So i_blocks_per_page() isn't going to change.
> > 
> > We seem to have allocated enough memory for ->iop because that's also
> > based on i_blocks_per_page().
> > 
> > I'm out of ideas.  Maybe I'll wake up with a better idea in the morning.
> > I've been trying to reproduce this on x86 with a 1kB block size
> > filesystem, and haven't been able to yet.  Maybe I'll try to setup a
> > powerpc cross-compilation environment tomorrow.
> 
> FWIW I managed to reproduce it with the following fstests configuration
> on a 1k block size fs on a x86 machinE:
> 
> SECTION      -- -no-sections-
> FSTYP        -- xfs
> MKFS_OPTIONS --  -m reflink=1,rmapbt=1 -i sparse=1 -b size=1024
> MOUNT_OPTIONS --  -o usrquota,grpquota,prjquota
> HOST_OPTIONS -- local.config
> CHECK_OPTIONS -- -g auto
> XFS_MKFS_OPTIONS -- -bsize=4096
> TIME_FACTOR  -- 1
> LOAD_FACTOR  -- 1
> TEST_DIR     -- /mnt
> TEST_DEV     -- /dev/sde
> SCRATCH_DEV  -- /dev/sdd
> SCRATCH_MNT  -- /opt
> OVL_UPPER    -- ovl-upper
> OVL_LOWER    -- ovl-lower
> OVL_WORK     -- ovl-work
> KERNEL       -- 5.9.0-rc4-djw

It just survived another 3-hour run for me:

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 bobo-kvm 5.9.0-rc4 #40 SMP Tue Sep 22 14:18:21 EDT 2020
MKFS_OPTIONS  -- -f -m reflink=1,rmapbt=1 -i sparse=1 -b size=1024 /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /mnt/scratch

The only warning I hit was in generic/019:

0172 WARNING: CPU: 1 PID: 6933 at fs/iomap/buffered-io.c:997 iomap_page_mkwrite_actor+0x72/0x80

which is the:
                WARN_ON_ONCE(!PageUptodate(page));
that happens as a result of the ClearPageUptodate() in iomap_writepage_map()
which has been happening approximately forever.

