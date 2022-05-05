Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912A651B6F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 06:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbiEEEWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 00:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiEEEWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 00:22:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CB61FCC8;
        Wed,  4 May 2022 21:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oG9KmQax5k2tmeoj0qduKrQqezQKzNj35UKH0VjdL/s=; b=bHEYK7xPlluuOv/d4NvHpjCxHh
        OkgHDX2MvrnDkRKu6QIvVH+Jg7AU/2r9NM2zZ3Em+kSyRQkCJbiOZig4ks8bpPg8EBd2qSDXIZG2R
        BWlbQTBzTbBHF54SB1QRZM94YTaSMDPIqspRhkXCwnSd+b1BqChSodhiL6D05535gRYDO5ZCojqyB
        vwCBueYoQBYXqAD6XYq12yFYYKEhZRQFhNVYR1h3QTWfZuNrvykmJt7BBbVzCzS5PwRzEaHmEIJUj
        hEfeAzeprVrHGPH1ZHd4IrooXoTr2fDgzmYEt0r+g+st0v7Pl3BIlBT0DYMhCXUlCt1Nhed5wMXKO
        f4TcZ7rQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmSwd-00HFmn-Mh; Thu, 05 May 2022 04:18:27 +0000
Date:   Thu, 5 May 2022 05:18:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Brian Foster <bfoster@redhat.com>, xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic/068 crash on 5.18-rc2?
Message-ID: <YnNQE6N7MwgLtR12@casper.infradead.org>
References: <20220418174747.GF17025@magnolia>
 <20220422215943.GC17025@magnolia>
 <Ymq4brjhBcBvcfIs@bfoster>
 <Ymywh003c+Hd4Zu9@casper.infradead.org>
 <Ym2szx2S3ontYsBf@casper.infradead.org>
 <Ym/McFNCTzmsLBak@bfoster>
 <20220503032534.GC8297@magnolia>
 <YnCwBVdmg3IiGhfD@casper.infradead.org>
 <20220503172532.GA8265@magnolia>
 <20220505024012.GA27195@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505024012.GA27195@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 04, 2022 at 07:40:12PM -0700, Darrick J. Wong wrote:
> On Tue, May 03, 2022 at 10:25:32AM -0700, Darrick J. Wong wrote:
> > On Tue, May 03, 2022 at 05:31:01AM +0100, Matthew Wilcox wrote:
> > > On Mon, May 02, 2022 at 08:25:34PM -0700, Darrick J. Wong wrote:
> > > > On Mon, May 02, 2022 at 08:20:00AM -0400, Brian Foster wrote:
> > > > > On Sat, Apr 30, 2022 at 10:40:31PM +0100, Matthew Wilcox wrote:
> > > > > > On Sat, Apr 30, 2022 at 04:44:07AM +0100, Matthew Wilcox wrote:
> > > > > > > (I do not love this, have not even compiled it; it's late.  We may be
> > > > > > > better off just storing next_folio inside the folio_iter).
> > > > > > 
> > > > > > Does anyone have a preference for fixing this between Option A:
> > > > > > 
> > > > > 
> > > > > After seeing the trace in my previous mail and several thousand
> > > > > successful iterations of the test hack, I had reworked it into this
> > > > > (which survived weekend testing until it ran into some other XFS problem
> > > > > that looks unrelated):
> > > > > 
> > > > > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > > > > index 278cc81cc1e7..aa820e09978e 100644
> > > > > --- a/include/linux/bio.h
> > > > > +++ b/include/linux/bio.h
> > > > > @@ -269,6 +269,7 @@ struct folio_iter {
> > > > >  	size_t offset;
> > > > >  	size_t length;
> > > > >  	/* private: for use by the iterator */
> > > > > +	struct folio *_next;
> > > > >  	size_t _seg_count;
> > > > >  	int _i;
> > > > >  };
> > > > > @@ -279,6 +280,7 @@ static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
> > > > >  	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
> > > > >  
> > > > >  	fi->folio = page_folio(bvec->bv_page);
> > > > > +	fi->_next = folio_next(fi->folio);
> > > > >  	fi->offset = bvec->bv_offset +
> > > > >  			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
> > > > >  	fi->_seg_count = bvec->bv_len;
> > > > > @@ -290,13 +292,15 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
> > > > >  {
> > > > >  	fi->_seg_count -= fi->length;
> > > > >  	if (fi->_seg_count) {
> > > > > -		fi->folio = folio_next(fi->folio);
> > > > > +		fi->folio = fi->_next;
> > > > > +		fi->_next = folio_next(fi->folio);
> > > > >  		fi->offset = 0;
> > > > >  		fi->length = min(folio_size(fi->folio), fi->_seg_count);
> > > > >  	} else if (fi->_i + 1 < bio->bi_vcnt) {
> > > > >  		bio_first_folio(fi, bio, fi->_i + 1);
> > > > >  	} else {
> > > > >  		fi->folio = NULL;
> > > > > +		fi->_next = NULL;
> > > > >  	}
> > > > >  }
> > > > > 
> > > > > So FWIW, that is just to say that I find option A to be cleaner and more
> > > > > readable.
> > > > 
> > > > Me too.  I'll queue up the usual nightly tests with that patch added and
> > > > we'll see how that does.
> > > 
> > > I've just pushed essentially that patch to my for-next tree in case
> > > anybody does any testing with that.  I'll give it a couple of days
> > > before creating a folio-5.18f tag and asking Linus to pull the first two
> > > commits on
> > > 
> > > git://git.infradead.org/users/willy/pagecache.git for-next
> > > 
> > > That is, commits
> > > 
> > > 1a4c97e2dd5b ("block: Do not call folio_next() on an unreferenced folio")
> > > 095099da208b ("mm/readahead: Fix readahead with large folios")
> > 
> > Hmm.  Well, I added 1a4c97 to my tree last night, and it seems to have
> > cleared up all but two of the problems I saw with the for-next branch.
> > 
> > generic/388 still fails (40 minutes in) with:
> > 
> > WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
> > VM_BUG_ON_FOLIO(i_blocks_per_folio(inode, folio) > 1 && !iop, folio);
> > 
> > Which I think is the same problem where the fs goes down, XFS throws an
> > error back to iomap_do_writepages, and it tries to discard a folio that
> > already had writeback running on it.
> > 
> > There's also the same problem I reported a few days ago in xfs/501
> > on a 64k-page ARM64 VM where:
> > 
> > run fstests xfs/501 at 2022-05-02 21:17:31
> > XFS: Assertion failed: IS_ALIGNED((unsigned long)lv->lv_buf, sizeof(uint64_t)), file: fs/xfs/xfs_log_cil.c, line: 430
> > XFS: Assertion failed: IS_ALIGNED((unsigned long)buf, sizeof(uint64_t)), file: fs/xfs/xfs_log.c, line: 137
> > XFS: Assertion failed: IS_ALIGNED((unsigned long)buf, sizeof(uint64_t)), file: fs/xfs/xfs_log.c, line: 137
> > 
> > But I think that's a new bug that came in with all the log buffer
> > alignment changes in the 5.19 branch.
> > 
> > Oh.  My tree still had the "disable large folios" patch in it.  I guess
> > the "successful" results are mostly invalid then.
> 
> Well... with large folios turned back on and those two patches added to
> the branch, *most* of the problems go away.  The generic/388 problem
> persists, and last night's run showed that the weird xfs_dquot leak that
> I"ve occasionally seen on 5.18 with xfs/43[46] also exists in 5.17.

OK, so let me just restate what I understand here ... these two patches
cure some, but not all of the currently observed problems with 5.18.
The problems that remain with 5.18 were also present in either 5.17
or in 5.18 with large folios disabled, so at this point we know of no
functional regressions that large folios can be blamed for?

I'll send these patches to Linus tomorrow then, since they fix problems
that have been observed, and I don't think there's any reason to keep
them from him.
