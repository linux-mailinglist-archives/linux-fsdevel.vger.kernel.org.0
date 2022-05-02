Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ADC516F83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 14:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiEBMZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 08:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiEBMZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 08:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28FE6B7F6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 05:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651494098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/MPF4SlHJTSwOs9uq+qeW8/MK0NYqARQeWoIqaF+luw=;
        b=APgFOfIwAl7KNakWojYk3LGUe4EKl5Y8DaCrbZtXgE4QjpT1e07VSguBj08Z/8xT9HbEKk
        VgTyp6Pjdqqh9UBNNa9DoClmb2TZokX4oCrZy2d+IUr1TpVToiB/Ift/XPck2umdVpzCp/
        bFoLe3eWV69Wzufy7C+zeZwZJzhg1pY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-FpBuwnDOMO-RM7YNxLD33w-1; Mon, 02 May 2022 08:18:27 -0400
X-MC-Unique: FpBuwnDOMO-RM7YNxLD33w-1
Received: by mail-qv1-f71.google.com with SMTP id o12-20020a0562140e4c00b0044a67ef728dso10903471qvc.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 May 2022 05:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/MPF4SlHJTSwOs9uq+qeW8/MK0NYqARQeWoIqaF+luw=;
        b=VGxFw7PC3O26guqaOGPYTSsMUpPKXB+QWE0Lquv7Z8P49Mkls477CkjDMmxwIcOznI
         ond5ri68lGU0mDKlli3oZFjUkkfmtCXIgpEEEI3fRbX007LAsotoX1Xs1YUtrVLbEx6e
         QTgHiH4WwpPaCkKv+x2BzbqqXBe2u/2kr1bjMQHL4WgNeQSk9tDUEQe4TlOKT+iIqxBk
         1TLvuM//+g2FDw+x3ch654DwYGFxLloTSbizYm7JbfQ7XnP6fG2l8KFOVaeGsRaliX/i
         O0mzC2ajBFfUTS8VKlxL76P76cODnawERJsB4gXSsbVc5lo9CKE6BoBRNb5ZNjxkHKRv
         xjbQ==
X-Gm-Message-State: AOAM530kALn9RjxvyrjQfRIDpUXym4IjLYBG5bV7Om7SI4z6+cHVKLGu
        epma8RNAo+e0YiIQDDDQknKRgzo6I8eJzYekAuMN/uiNnbGQTvu4KnHEmEvGlZ2R8TE4Qx1KfKe
        rfrj6VgOp1WqIfu9qLo/8pvihpQ==
X-Received: by 2002:a05:622a:1211:b0:2f2:167:55dc with SMTP id y17-20020a05622a121100b002f2016755dcmr9756400qtx.105.1651493907288;
        Mon, 02 May 2022 05:18:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkMF9lcc6DS6FBWLWUIVap+Xc5D8aaV20ZYaG7Q/z0wEek99nyXbS8Zkj7RgwqXcS5qEOKUg==
X-Received: by 2002:a05:622a:1211:b0:2f2:167:55dc with SMTP id y17-20020a05622a121100b002f2016755dcmr9756380qtx.105.1651493907034;
        Mon, 02 May 2022 05:18:27 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id c5-20020ac86605000000b002f39b99f6a0sm4038090qtp.58.2022.05.02.05.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 05:18:26 -0700 (PDT)
Date:   Mon, 2 May 2022 08:18:24 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic/068 crash on 5.18-rc2?
Message-ID: <Ym/MEBfa0szil3hW@bfoster>
References: <20220413033425.GM16799@magnolia>
 <YlbjOPEQP66gc1WQ@casper.infradead.org>
 <20220418174747.GF17025@magnolia>
 <20220422215943.GC17025@magnolia>
 <Ymq4brjhBcBvcfIs@bfoster>
 <Ymywh003c+Hd4Zu9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymywh003c+Hd4Zu9@casper.infradead.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 30, 2022 at 04:44:07AM +0100, Matthew Wilcox wrote:
> On Thu, Apr 28, 2022 at 11:53:18AM -0400, Brian Foster wrote:
> > The above is the variant of generic/068 failure I was reproducing and
> > used to bisect [1]. With some additional tracing added to ioend
> > completion, what I'm seeing is that the bio_for_each_folio_all() bvec
> > iteration basically seems to go off the rails. What happens more
> > specifically is that at some point during the loop, bio_next_folio()
> > actually lands into the second page of the just processed folio instead
> > of the actual next folio (i.e. as if it's walking to the next page from
> > the head page of the folio instead of to the next 16k folio). I suspect
> > completion is racing with some form of truncation/reclaim/invalidation
> > here, what exactly I don't know, that perhaps breaks down the folio and
> > renders the iteration (bio_next_folio() -> folio_next()) unsafe. To test
> > that theory, I open coded and modified the loop to something like the
> > following:
> > 
> >                 for (bio_first_folio(&fi, bio, 0); fi.folio; ) {
> >                         f = fi.folio;
> >                         l = fi.length;
> >                         bio_next_folio(&fi, bio);
> >                         iomap_finish_folio_write(inode, f, l, error);
> >                         folio_count++;
> >                 }
> > 
> > ... to avoid accessing folio metadata after writeback is cleared on it
> > and this seems to make the problem disappear (so far, I'll need to let
> > this spin for a while longer to be completely confident in that).
> 
> _Oh_.
> 
> It's not even a terribly weird race, then.  It's just this:
> 
> CPU 0				CPU 1
> 				truncate_inode_partial_folio()
> 				folio_wait_writeback();
> bio_next_folio(&fi, bio)
> iomap_finish_folio_write(fi.folio)
> folio_end_writeback(folio)
> 				split_huge_page()
> bio_next_folio()
> ... oops, now we only walked forward one page instead of the entire folio.
> 

Yep, though once I noticed and turned on the mm_page_free tracepoint, it
looked like it was actually the I/O completion path breaking down the
compound folio:

   kworker/10:1-440     [010] .....   355.369899: iomap_finish_ioend: 1090: bio 00000000bc8445c7 index 192 fi (00000000dc8c03bd 0 16384 32768 27)
   ...
    kworker/10:1-440     [010] .....   355.369905: mm_page_free: page=00000000dc8c03bd pfn=0x182190 order=2
    kworker/10:1-440     [010] .....   355.369907: iomap_finish_ioend: 1090: bio 00000000bc8445c7 index 1 fi (00000000f8b5d9b3 0 4096 16384 27)

I take that to mean the truncate path executes while the completion side
holds a reference, folio_end_writeback() ends up dropping the last
reference, falls into the free/split path and the iteration breaks from
there. Same idea either way, I think.

Brian

> So ... I think we can fix this with:
> 
> +++ b/include/linux/bio.h
> @@ -290,7 +290,8 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
>  {
>         fi->_seg_count -= fi->length;
>         if (fi->_seg_count) {
> -               fi->folio = folio_next(fi->folio);
> +               fi->folio = (struct folio *)folio_page(fi->folio,
> +                               (fi->offset + fi->length) / PAGE_SIZE);
>                 fi->offset = 0;
>                 fi->length = min(folio_size(fi->folio), fi->_seg_count);
>         } else if (fi->_i + 1 < bio->bi_vcnt) {
> 
> (I do not love this, have not even compiled it; it's late.  We may be
> better off just storing next_folio inside the folio_iter).
> 

