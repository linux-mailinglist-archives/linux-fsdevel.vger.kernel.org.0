Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92AC517C30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 05:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiECD3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 23:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiECD3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 23:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9621CFD7;
        Mon,  2 May 2022 20:25:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6176614BF;
        Tue,  3 May 2022 03:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B38FC385A4;
        Tue,  3 May 2022 03:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651548335;
        bh=A7e6GkrsD6t3Ih8iF1SNUWLZ+lW4kvHJDGyUfS74g5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGLe+RmzBQB0r5KdasMzHRJwsNMItQz3kJKftHx5YU1XlR9NCC6UjIYj2EsQAoIkJ
         Yb7g5oDNQk1jMD202fjBPruJfwlRQ2QQsQBfGcIBAnkKwX3NQ2V4392nXbxgZFrGl2
         CF6KPIvJR4p+b76IP/7uQnU2I6AFgOUvB9vyHvDCFLIhHCxf2Nkokpr00qFJglmGHH
         o3UMmoSXJH6GhKAUOSMrVtfxtJPZ+HKyb3FSePS9DeZ1nzOrp1xxpDbYarVlqS1EsT
         hRUKZX/8SPf2lbLBXlNqTelbEltitKbtz45iOAfQ8O1LCHn11+c5n9jP81hQwyvXh2
         +sC6Wh0RKd6PA==
Date:   Mon, 2 May 2022 20:25:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic/068 crash on 5.18-rc2?
Message-ID: <20220503032534.GC8297@magnolia>
References: <20220413033425.GM16799@magnolia>
 <YlbjOPEQP66gc1WQ@casper.infradead.org>
 <20220418174747.GF17025@magnolia>
 <20220422215943.GC17025@magnolia>
 <Ymq4brjhBcBvcfIs@bfoster>
 <Ymywh003c+Hd4Zu9@casper.infradead.org>
 <Ym2szx2S3ontYsBf@casper.infradead.org>
 <Ym/McFNCTzmsLBak@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym/McFNCTzmsLBak@bfoster>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 02, 2022 at 08:20:00AM -0400, Brian Foster wrote:
> On Sat, Apr 30, 2022 at 10:40:31PM +0100, Matthew Wilcox wrote:
> > On Sat, Apr 30, 2022 at 04:44:07AM +0100, Matthew Wilcox wrote:
> > > (I do not love this, have not even compiled it; it's late.  We may be
> > > better off just storing next_folio inside the folio_iter).
> > 
> > Does anyone have a preference for fixing this between Option A:
> > 
> 
> After seeing the trace in my previous mail and several thousand
> successful iterations of the test hack, I had reworked it into this
> (which survived weekend testing until it ran into some other XFS problem
> that looks unrelated):
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 278cc81cc1e7..aa820e09978e 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -269,6 +269,7 @@ struct folio_iter {
>  	size_t offset;
>  	size_t length;
>  	/* private: for use by the iterator */
> +	struct folio *_next;
>  	size_t _seg_count;
>  	int _i;
>  };
> @@ -279,6 +280,7 @@ static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
>  	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
>  
>  	fi->folio = page_folio(bvec->bv_page);
> +	fi->_next = folio_next(fi->folio);
>  	fi->offset = bvec->bv_offset +
>  			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
>  	fi->_seg_count = bvec->bv_len;
> @@ -290,13 +292,15 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
>  {
>  	fi->_seg_count -= fi->length;
>  	if (fi->_seg_count) {
> -		fi->folio = folio_next(fi->folio);
> +		fi->folio = fi->_next;
> +		fi->_next = folio_next(fi->folio);
>  		fi->offset = 0;
>  		fi->length = min(folio_size(fi->folio), fi->_seg_count);
>  	} else if (fi->_i + 1 < bio->bi_vcnt) {
>  		bio_first_folio(fi, bio, fi->_i + 1);
>  	} else {
>  		fi->folio = NULL;
> +		fi->_next = NULL;
>  	}
>  }
> 
> So FWIW, that is just to say that I find option A to be cleaner and more
> readable.

Me too.  I'll queue up the usual nightly tests with that patch added and
we'll see how that does.

--D

> Brian
> 
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index 49eff01fb829..55e2499beff6 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -269,6 +269,7 @@ struct folio_iter {
> >         size_t offset;
> >         size_t length;
> >         /* private: for use by the iterator */
> > +       struct folio *_next;
> >         size_t _seg_count;
> >         int _i;
> >  };
> > @@ -280,19 +281,23 @@ static inline void bio_first_folio(struct folio_iter *fi,
> > struct bio *bio,
> > 
> >         fi->folio = page_folio(bvec->bv_page);
> >         fi->offset = bvec->bv_offset +
> > -                       PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
> > +                       PAGE_SIZE * folio_page_idx(fi->folio, bvec->bv_page);
> >         fi->_seg_count = bvec->bv_len;
> >         fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
> >         fi->_i = i;
> > +       if (fi->_seg_count > fi->length)
> > +               fi->_next = folio_next(fi->folio);
> >  }
> > 
> >  static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
> >  {
> >         fi->_seg_count -= fi->length;
> >         if (fi->_seg_count) {
> > -               fi->folio = folio_next(fi->folio);
> > +               fi->folio = fi->_next;
> >                 fi->offset = 0;
> >                 fi->length = min(folio_size(fi->folio), fi->_seg_count);
> > +               if (fi->_seg_count > fi->length)
> > +                       fi->_next = folio_next(fi->folio);
> >         } else if (fi->_i + 1 < bio->bi_vcnt) {
> >                 bio_first_folio(fi, bio, fi->_i + 1);
> >         } else {
> > 
> > 
> > and Option B:
> > 
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index 49eff01fb829..554f5fce060c 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -290,7 +290,8 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
> >  {
> >         fi->_seg_count -= fi->length;
> >         if (fi->_seg_count) {
> > -               fi->folio = folio_next(fi->folio);
> > +               fi->folio = __folio_next(fi->folio,
> > +                               (fi->offset + fi->length) / PAGE_SIZE);
> >                 fi->offset = 0;
> >                 fi->length = min(folio_size(fi->folio), fi->_seg_count);
> >         } else if (fi->_i + 1 < bio->bi_vcnt) {
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index de32c0383387..9c5547af8d0e 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1642,6 +1642,12 @@ static inline long folio_nr_pages(struct folio *folio)
> >         return compound_nr(&folio->page);
> >  }
> > 
> > +static inline struct folio *__folio_next(struct folio *folio,
> > +               unsigned long nr_pages)
> > +{
> > +       return (struct folio *)folio_page(folio, nr_pages);
> > +}
> > +
> >  /**
> >   * folio_next - Move to the next physical folio.
> >   * @folio: The folio we're currently operating on.
> > @@ -1658,7 +1664,7 @@ static inline long folio_nr_pages(struct folio *folio)
> >   */
> >  static inline struct folio *folio_next(struct folio *folio)
> >  {
> > -       return (struct folio *)folio_page(folio, folio_nr_pages(folio));
> > +       return __folio_next(folio, folio_nr_pages(folio));
> >  }
> > 
> >  /**
> > 
> > 
> > Currently running Option A through its paces.
> > 
> 
