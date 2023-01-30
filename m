Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC25C681B7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 21:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjA3U2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 15:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjA3U2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:28:00 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F45D12877;
        Mon, 30 Jan 2023 12:27:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so4374439pjb.4;
        Mon, 30 Jan 2023 12:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iSU6AbkQ5sm4Ppcmt/5wAQCd6uAfoc4/Jcd5BzCP6Qk=;
        b=UgHSUK4xqasKVhVImOgUgZUjWe6bH3s+XGFHUFYxE4p0em4yLRKGg4mKEPHutmrTV+
         xFR/wuLL1dsRC/S0/AxYdMDEv9mqdEteAptk5qeWC+bOYmFB5yn6eIA0m/FRxzupbEM+
         nILTLqRUMmoWo2b80jDsnjH9uoTcnpFd1Vq5wMF4xvwh3GVqnAKYxWliSN+vp6UwW87Y
         PyxvVWqsjx0abTl9VhZ1RROqK91skf88haADUeiqs1Tp0NzMo0mEwHKpE2M/rzs0WWVm
         XS6ISRrmnItN6+rE2oWUDBFT4MWFbGm+hrxEuVmXQ0LPW/kM5S/uLk9lHlViwAJLYOEs
         R8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSU6AbkQ5sm4Ppcmt/5wAQCd6uAfoc4/Jcd5BzCP6Qk=;
        b=1e0EDX5bVCoIW5eYp1a8Ry9Myoo06xApNsg1OlXSXAe5fieMFkcdMibopMFJQWQzxm
         JfpYRzxKkCl86uNIAdkK+VDInP0p9+WfengRjyPDyi7a2N0jdOCzUBVdGHQvQOpE4p6D
         034kwNf6J3r6UI8HQ6NmmsKHga6Tpr6VR4ypSbjf30WocMvjZYTIkYO145QbpIXrYp7r
         NgNh8gdpCxlxdrMaK47HkU0sNo/QS0nUQIwnoT5x4mbJIppc5oSarPjY7bpcfJzSjoXC
         4uOunxbkMPFL6AqZDM2Nw906qSU/SLQ2LrBMaI5VqCZ9TcVv5vmQq5k4r2HRAZS2/YuR
         Srfw==
X-Gm-Message-State: AO0yUKWOe3HUy0Rju0BnahTGOQNMKW3BVSDxZYZcA7Q9AkKmvC86vmOX
        YuP0TGuA6np8sn6M8pEUy8k=
X-Google-Smtp-Source: AK7set/Ys/oik+OMUiB1fieHE4u5lkyE6AMwNPrBldwc/aWevo2wbJMAcWeqCBk41Fu6KF976DnzjA==
X-Received: by 2002:a17:903:228e:b0:196:2acf:f27a with SMTP id b14-20020a170903228e00b001962acff27amr11738882plh.36.1675110478041;
        Mon, 30 Jan 2023 12:27:58 -0800 (PST)
Received: from localhost ([2406:7400:63:1fd8:5041:db86:706c:f96b])
        by smtp.gmail.com with ESMTPSA id jk15-20020a170903330f00b001960cccc318sm1814718plb.121.2023.01.30.12.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:27:57 -0800 (PST)
Date:   Tue, 31 Jan 2023 01:57:55 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 3/3] iomap: Support subpage size dirty tracking to
 improve write performance
Message-ID: <20230130202755.tsyi3papzpkjzuzy@rh-tp>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <5e49fa975ce9d719f5b6f765aa5d3a1d44d98d1d.1675093524.git.ritesh.list@gmail.com>
 <Y9f7cZxnXbL7x0p+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9f7cZxnXbL7x0p+@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/01/30 09:16AM, Christoph Hellwig wrote:
> On Mon, Jan 30, 2023 at 09:44:13PM +0530, Ritesh Harjani (IBM) wrote:
> > +iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags,
> > +		  bool from_writeback)
> >  {
> >  	struct iomap_page *iop = to_iomap_page(folio);
> >  	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> > @@ -58,12 +59,32 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
> >  	else
> >  		gfp = GFP_NOFS | __GFP_NOFAIL;
> >
> > -	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
> > +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
> >  		      gfp);
> >  	if (iop) {
>
> Please just return early here for the allocation failure case instead of
> adding a lot of code with extra indentation.

Sure. Will do that.


>
> >  		spin_lock_init(&iop->state_lock);
> > -		if (folio_test_uptodate(folio))
> > -			bitmap_fill(iop->state, nr_blocks);
> > +		/*
> > +		 * iomap_page_create can get called from writeback after
> > +		 * a truncate_inode_partial_folio operation on a large folio.
> > +		 * For large folio the iop structure is freed in
> > +		 * iomap_invalidate_folio() to ensure we can split the folio.
> > +		 * That means we will have to let go of the optimization of
> > +		 * tracking dirty bits here and set all bits as dirty if
> > +		 * the folio is marked uptodate.
> > +		 */
> > +		if (from_writeback && folio_test_uptodate(folio))
> > +			bitmap_fill(iop->state, 2 * nr_blocks);
> > +		else if (folio_test_uptodate(folio)) {
>
> This code is very confusing.  First please only check
> folio_test_uptodate one, and then check the from_writeback flag
> inside the branch.  And as mentioned last time I think you really

Ok, sure. I will try and simplify it.


> need some symbolic constants for dealing with dirty vs uptodate
> state and not just do a single fill for them.

Yes, I agree. Sorry my bad. I will add that change in the next rev.


>
> > +			unsigned start = offset_in_folio(folio,
> > +					folio_pos(folio)) >> inode->i_blkbits;
> > +			bitmap_set(iop->state, start, nr_blocks);
>
> Also this code leaves my head scratching.  Unless I'm missing something
> important
>
> 	 offset_in_folio(folio, folio_pos(folio))
>
> must always return 0.

That is true always yes. In the next rev, I can make it explicitly 0 then
(maybe with just a small comment if required).

>
> Also the from_writeback logic is weird.  I'd rather have a
> "bool is_dirty" argument and then pass true for writeback beause
> we know the folio is dirty, false where we know it can't be
> dirty and do the folio_test_dirty in the caller where we don't
> know the state.

Agreed. Thanks.


>
> > +bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
> > +{
> > +	unsigned int nr_blocks = i_blocks_per_folio(mapping->host, folio);
> > +	struct iomap_page *iop = iomap_page_create(mapping->host, folio, 0, false);
>
> Please avoid the overly long line.  In fact with such long function
> calls I'd generally prefer if the initialization was moved out of the
> declaration.

Sure, will do the same.

>
> > +
> > +	iomap_set_range_dirty(folio, iop, offset_in_folio(folio, folio_pos(folio)),
>
> Another overly long line here.

sure. Will do the same.

-ritesh
