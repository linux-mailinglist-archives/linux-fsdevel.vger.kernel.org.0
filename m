Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9441951DE0D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 19:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444053AbiEFRHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 13:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347594AbiEFRHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 13:07:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA04754F;
        Fri,  6 May 2022 10:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DA4FB83787;
        Fri,  6 May 2022 17:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596F6C385A8;
        Fri,  6 May 2022 17:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651856625;
        bh=Jkc0GaqjiJuvpxfyZX6knxMQ4G3bqYgbB8GdPi/l7yU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTw6gtppybEjQnC5hICdBgtIQS0PeEY6b4KmPhvXbsHH5JttQP1lepw1z97mHUlRi
         g9Oh/VkkIPXwkDvBXZknCagK7RvJDanKhGHIeR+SLZhOdNMIhphuc8XnH6e90ue47j
         zo2n0bcZghZVOxumvVagqyUtylCY8vyuSP/RmbEr2I6awPYrHTbj9qwGov+zm2Xsm3
         p2j6FzNZeVeE02CcUhmdR2Abkoi0Ppqar+5mzsmXPWqgS8Lq7voS8Du/QrBlCbIrra
         3ZLr1xZKJVEl7RmD4ySXLAfy8yKbGrSN7RqSA700bVCv4L5PNHIqlFXDRENzk52/ne
         oF1hUvdoA96vA==
Date:   Fri, 6 May 2022 10:03:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Brian Foster <bfoster@redhat.com>, xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic/068 crash on 5.18-rc2?
Message-ID: <20220506170344.GS27195@magnolia>
References: <Ymq4brjhBcBvcfIs@bfoster>
 <Ymywh003c+Hd4Zu9@casper.infradead.org>
 <Ym2szx2S3ontYsBf@casper.infradead.org>
 <Ym/McFNCTzmsLBak@bfoster>
 <20220503032534.GC8297@magnolia>
 <YnCwBVdmg3IiGhfD@casper.infradead.org>
 <20220503172532.GA8265@magnolia>
 <20220505024012.GA27195@magnolia>
 <YnNQE6N7MwgLtR12@casper.infradead.org>
 <20220505042405.GB27195@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505042405.GB27195@magnolia>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 04, 2022 at 09:24:05PM -0700, Darrick J. Wong wrote:
> On Thu, May 05, 2022 at 05:18:27AM +0100, Matthew Wilcox wrote:
> > On Wed, May 04, 2022 at 07:40:12PM -0700, Darrick J. Wong wrote:
> > > On Tue, May 03, 2022 at 10:25:32AM -0700, Darrick J. Wong wrote:
> > > > On Tue, May 03, 2022 at 05:31:01AM +0100, Matthew Wilcox wrote:
> > > > > On Mon, May 02, 2022 at 08:25:34PM -0700, Darrick J. Wong wrote:
> > > > > > On Mon, May 02, 2022 at 08:20:00AM -0400, Brian Foster wrote:
> > > > > > > On Sat, Apr 30, 2022 at 10:40:31PM +0100, Matthew Wilcox wrote:
> > > > > > > > On Sat, Apr 30, 2022 at 04:44:07AM +0100, Matthew Wilcox wrote:
> > > > > > > > > (I do not love this, have not even compiled it; it's late.  We may be
> > > > > > > > > better off just storing next_folio inside the folio_iter).
> > > > > > > > 
> > > > > > > > Does anyone have a preference for fixing this between Option A:
> > > > > > > > 
> > > > > > > 
> > > > > > > After seeing the trace in my previous mail and several thousand
> > > > > > > successful iterations of the test hack, I had reworked it into this
> > > > > > > (which survived weekend testing until it ran into some other XFS problem
> > > > > > > that looks unrelated):
> > > > > > > 
> > > > > > > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > > > > > > index 278cc81cc1e7..aa820e09978e 100644
> > > > > > > --- a/include/linux/bio.h
> > > > > > > +++ b/include/linux/bio.h
> > > > > > > @@ -269,6 +269,7 @@ struct folio_iter {
> > > > > > >  	size_t offset;
> > > > > > >  	size_t length;
> > > > > > >  	/* private: for use by the iterator */
> > > > > > > +	struct folio *_next;
> > > > > > >  	size_t _seg_count;
> > > > > > >  	int _i;
> > > > > > >  };
> > > > > > > @@ -279,6 +280,7 @@ static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
> > > > > > >  	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
> > > > > > >  
> > > > > > >  	fi->folio = page_folio(bvec->bv_page);
> > > > > > > +	fi->_next = folio_next(fi->folio);
> > > > > > >  	fi->offset = bvec->bv_offset +
> > > > > > >  			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
> > > > > > >  	fi->_seg_count = bvec->bv_len;
> > > > > > > @@ -290,13 +292,15 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
> > > > > > >  {
> > > > > > >  	fi->_seg_count -= fi->length;
> > > > > > >  	if (fi->_seg_count) {
> > > > > > > -		fi->folio = folio_next(fi->folio);
> > > > > > > +		fi->folio = fi->_next;
> > > > > > > +		fi->_next = folio_next(fi->folio);
> > > > > > >  		fi->offset = 0;
> > > > > > >  		fi->length = min(folio_size(fi->folio), fi->_seg_count);
> > > > > > >  	} else if (fi->_i + 1 < bio->bi_vcnt) {
> > > > > > >  		bio_first_folio(fi, bio, fi->_i + 1);
> > > > > > >  	} else {
> > > > > > >  		fi->folio = NULL;
> > > > > > > +		fi->_next = NULL;
> > > > > > >  	}
> > > > > > >  }
> > > > > > > 
> > > > > > > So FWIW, that is just to say that I find option A to be cleaner and more
> > > > > > > readable.
> > > > > > 
> > > > > > Me too.  I'll queue up the usual nightly tests with that patch added and
> > > > > > we'll see how that does.
> > > > > 
> > > > > I've just pushed essentially that patch to my for-next tree in case
> > > > > anybody does any testing with that.  I'll give it a couple of days
> > > > > before creating a folio-5.18f tag and asking Linus to pull the first two
> > > > > commits on
> > > > > 
> > > > > git://git.infradead.org/users/willy/pagecache.git for-next
> > > > > 
> > > > > That is, commits
> > > > > 
> > > > > 1a4c97e2dd5b ("block: Do not call folio_next() on an unreferenced folio")
> > > > > 095099da208b ("mm/readahead: Fix readahead with large folios")
> > > > 
> > > > Hmm.  Well, I added 1a4c97 to my tree last night, and it seems to have
> > > > cleared up all but two of the problems I saw with the for-next branch.
> > > > 
> > > > generic/388 still fails (40 minutes in) with:
> > > > 
> > > > WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
> > > > VM_BUG_ON_FOLIO(i_blocks_per_folio(inode, folio) > 1 && !iop, folio);
> > > > 
> > > > Which I think is the same problem where the fs goes down, XFS throws an
> > > > error back to iomap_do_writepages, and it tries to discard a folio that
> > > > already had writeback running on it.
> > > > 
> > > > There's also the same problem I reported a few days ago in xfs/501
> > > > on a 64k-page ARM64 VM where:
> > > > 
> > > > run fstests xfs/501 at 2022-05-02 21:17:31
> > > > XFS: Assertion failed: IS_ALIGNED((unsigned long)lv->lv_buf, sizeof(uint64_t)), file: fs/xfs/xfs_log_cil.c, line: 430
> > > > XFS: Assertion failed: IS_ALIGNED((unsigned long)buf, sizeof(uint64_t)), file: fs/xfs/xfs_log.c, line: 137
> > > > XFS: Assertion failed: IS_ALIGNED((unsigned long)buf, sizeof(uint64_t)), file: fs/xfs/xfs_log.c, line: 137
> > > > 
> > > > But I think that's a new bug that came in with all the log buffer
> > > > alignment changes in the 5.19 branch.
> > > > 
> > > > Oh.  My tree still had the "disable large folios" patch in it.  I guess
> > > > the "successful" results are mostly invalid then.
> > > 
> > > Well... with large folios turned back on and those two patches added to
> > > the branch, *most* of the problems go away.  The generic/388 problem
> > > persists, and last night's run showed that the weird xfs_dquot leak that
> > > I"ve occasionally seen on 5.18 with xfs/43[46] also exists in 5.17.
> > 
> > OK, so let me just restate what I understand here ... these two patches
> > cure some, but not all of the currently observed problems with 5.18.
> > The problems that remain with 5.18 were also present in either 5.17
> > or in 5.18 with large folios disabled, so at this point we know of no
> > functional regressions that large folios can be blamed for?
> 
> Not quite -- the generic/388 one is definitely new as of 5.18-rc1.
> Frustratingly, the problems "go away" if you enable KASAN, so I might
> try KFENCE (or whatever the new less molasses memory debugger is named)
> next.

I have some semi-good news for willy -- I've created an iomap-5.19-merge
candidate branch with Andreas' iomap fixes and willy's two folio
patches, and it tests cleanly on x64.

Unfortunately, I still see arm64 vms tripping over:

WARN_ON(i_blocks_per_folio(inode, folio) > 1 && !iop)

with the same weird pattern where we try to discard an entire folio
even though the (n>1)th block in the folio is under writeback.  I added
even more debug info, and captured this:

ino 0x87 ibpf 0x40 mapping 0xfffffc0164c8c0e8 index 0x8
page:ffffffff004a0f00 refcount:4 mapcount:0 mapping:fffffc0164c8c0e8 index:0x8 pfn:0x1683c
head:ffffffff004a0f00 order:2 compound_mapcount:0 compound_pincount:0
memcg:fffffc0106c7c000
aops:xfs_address_space_operations [xfs] ino:87 dentry name:"file2"
flags: 0x1ffe000000018116(error|referenced|uptodate|lru|writeback|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 1ffe000000018116 ffffffff00399808 ffffffff003bc408 fffffc0164c8c0e8
raw: 0000000000000008 0000000000000000 00000004ffffffff fffffc0106c7c000
page dumped because: VM_BUG_ON_FOLIO(i_blocks_per_folio(inode, folio) > 1 && !iop)

Looks like we have a single-page folio experiencing this problem.  I'm
not sure if we've simply been tripping over this all along and I just
never noticed until I turned the WARN_ON into a VM_BUG_ON, which
actually takes down the system... but I suspect this is a problem with
writeback (albeit on a shut down filesystem) that has been around for a
while.

I also have some not so good news for Dave -- I think this implies that
something in the xfs 5.19 merge branch might be behind all of these
weird dquot leaks in xfs/43[46] and the blowups in generic/388.  I'll
try to get to bisecting that next week.

--D

> I suspect the xfs/43[46] problems are probably more of the ongoing log
> abend whackamole, since every time we change something in the logging
> code, weird latent bugs from 20 years ago start pouring out like spiders
> fleeing the first winter rains.
> 
> > I'll send these patches to Linus tomorrow then, since they fix problems
> > that have been observed, and I don't think there's any reason to keep
> > them from him.
> 
> Right, I don't think there's a reason to hang on to those any longer.
> 
> --D
