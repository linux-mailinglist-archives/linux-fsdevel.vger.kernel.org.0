Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8165851B609
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 04:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiEECoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 22:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbiEECnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 22:43:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6291087;
        Wed,  4 May 2022 19:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC227B82A9E;
        Thu,  5 May 2022 02:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73637C385A5;
        Thu,  5 May 2022 02:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651718413;
        bh=qY4KmXLzLDJbFRydh6JicSuMK3vMZp0aSGlP21fPJGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkUTG5WLBHaxwkKCi4GUy+4L/PBlhzjjkgAFnLOGijc9nS3s+CIjHaS7WE38RjLiB
         ckwRW5mLeJOaA2cGJl0D61aW5HbFPJAxQYGUetGb+3ojsxZO0eB2wL87Ei29G9GJ0I
         MDPPBj8rmYYSdbIzCWCb1bRJBTrUTEAJvv2PtmPuMbedU8faq5QcUPALsh3gdu+s7K
         Yiid7Ao38dRUkkTwLMiiI7YeeBXnwTBLNsguFo8L5fkd2+gwVF5j666QWIgfDxGvnQ
         zaGPrbkizfEjcxBn13qz8s1C2VqoBst71vSHbV4irmmSQP73xXuldd1fbW6yKgiGqL
         qFp95wbChuBWw==
Date:   Wed, 4 May 2022 19:40:12 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Brian Foster <bfoster@redhat.com>, xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic/068 crash on 5.18-rc2?
Message-ID: <20220505024012.GA27195@magnolia>
References: <YlbjOPEQP66gc1WQ@casper.infradead.org>
 <20220418174747.GF17025@magnolia>
 <20220422215943.GC17025@magnolia>
 <Ymq4brjhBcBvcfIs@bfoster>
 <Ymywh003c+Hd4Zu9@casper.infradead.org>
 <Ym2szx2S3ontYsBf@casper.infradead.org>
 <Ym/McFNCTzmsLBak@bfoster>
 <20220503032534.GC8297@magnolia>
 <YnCwBVdmg3IiGhfD@casper.infradead.org>
 <20220503172532.GA8265@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503172532.GA8265@magnolia>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 10:25:32AM -0700, Darrick J. Wong wrote:
> On Tue, May 03, 2022 at 05:31:01AM +0100, Matthew Wilcox wrote:
> > On Mon, May 02, 2022 at 08:25:34PM -0700, Darrick J. Wong wrote:
> > > On Mon, May 02, 2022 at 08:20:00AM -0400, Brian Foster wrote:
> > > > On Sat, Apr 30, 2022 at 10:40:31PM +0100, Matthew Wilcox wrote:
> > > > > On Sat, Apr 30, 2022 at 04:44:07AM +0100, Matthew Wilcox wrote:
> > > > > > (I do not love this, have not even compiled it; it's late.  We may be
> > > > > > better off just storing next_folio inside the folio_iter).
> > > > > 
> > > > > Does anyone have a preference for fixing this between Option A:
> > > > > 
> > > > 
> > > > After seeing the trace in my previous mail and several thousand
> > > > successful iterations of the test hack, I had reworked it into this
> > > > (which survived weekend testing until it ran into some other XFS problem
> > > > that looks unrelated):
> > > > 
> > > > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > > > index 278cc81cc1e7..aa820e09978e 100644
> > > > --- a/include/linux/bio.h
> > > > +++ b/include/linux/bio.h
> > > > @@ -269,6 +269,7 @@ struct folio_iter {
> > > >  	size_t offset;
> > > >  	size_t length;
> > > >  	/* private: for use by the iterator */
> > > > +	struct folio *_next;
> > > >  	size_t _seg_count;
> > > >  	int _i;
> > > >  };
> > > > @@ -279,6 +280,7 @@ static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
> > > >  	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
> > > >  
> > > >  	fi->folio = page_folio(bvec->bv_page);
> > > > +	fi->_next = folio_next(fi->folio);
> > > >  	fi->offset = bvec->bv_offset +
> > > >  			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
> > > >  	fi->_seg_count = bvec->bv_len;
> > > > @@ -290,13 +292,15 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
> > > >  {
> > > >  	fi->_seg_count -= fi->length;
> > > >  	if (fi->_seg_count) {
> > > > -		fi->folio = folio_next(fi->folio);
> > > > +		fi->folio = fi->_next;
> > > > +		fi->_next = folio_next(fi->folio);
> > > >  		fi->offset = 0;
> > > >  		fi->length = min(folio_size(fi->folio), fi->_seg_count);
> > > >  	} else if (fi->_i + 1 < bio->bi_vcnt) {
> > > >  		bio_first_folio(fi, bio, fi->_i + 1);
> > > >  	} else {
> > > >  		fi->folio = NULL;
> > > > +		fi->_next = NULL;
> > > >  	}
> > > >  }
> > > > 
> > > > So FWIW, that is just to say that I find option A to be cleaner and more
> > > > readable.
> > > 
> > > Me too.  I'll queue up the usual nightly tests with that patch added and
> > > we'll see how that does.
> > 
> > I've just pushed essentially that patch to my for-next tree in case
> > anybody does any testing with that.  I'll give it a couple of days
> > before creating a folio-5.18f tag and asking Linus to pull the first two
> > commits on
> > 
> > git://git.infradead.org/users/willy/pagecache.git for-next
> > 
> > That is, commits
> > 
> > 1a4c97e2dd5b ("block: Do not call folio_next() on an unreferenced folio")
> > 095099da208b ("mm/readahead: Fix readahead with large folios")
> 
> Hmm.  Well, I added 1a4c97 to my tree last night, and it seems to have
> cleared up all but two of the problems I saw with the for-next branch.
> 
> generic/388 still fails (40 minutes in) with:
> 
> WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
> VM_BUG_ON_FOLIO(i_blocks_per_folio(inode, folio) > 1 && !iop, folio);
> 
> Which I think is the same problem where the fs goes down, XFS throws an
> error back to iomap_do_writepages, and it tries to discard a folio that
> already had writeback running on it.
> 
> There's also the same problem I reported a few days ago in xfs/501
> on a 64k-page ARM64 VM where:
> 
> run fstests xfs/501 at 2022-05-02 21:17:31
> XFS: Assertion failed: IS_ALIGNED((unsigned long)lv->lv_buf, sizeof(uint64_t)), file: fs/xfs/xfs_log_cil.c, line: 430
> XFS: Assertion failed: IS_ALIGNED((unsigned long)buf, sizeof(uint64_t)), file: fs/xfs/xfs_log.c, line: 137
> XFS: Assertion failed: IS_ALIGNED((unsigned long)buf, sizeof(uint64_t)), file: fs/xfs/xfs_log.c, line: 137
> 
> But I think that's a new bug that came in with all the log buffer
> alignment changes in the 5.19 branch.
> 
> Oh.  My tree still had the "disable large folios" patch in it.  I guess
> the "successful" results are mostly invalid then.

Well... with large folios turned back on and those two patches added to
the branch, *most* of the problems go away.  The generic/388 problem
persists, and last night's run showed that the weird xfs_dquot leak that
I"ve occasionally seen on 5.18 with xfs/43[46] also exists in 5.17.

--D

> --D
> 
> > (more than happy to update anything about those patches)
