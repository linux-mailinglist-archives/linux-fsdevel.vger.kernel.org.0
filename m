Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9103681BB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 21:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjA3UpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 15:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjA3UpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:45:05 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C199302BC;
        Mon, 30 Jan 2023 12:45:03 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z1so5407147plg.6;
        Mon, 30 Jan 2023 12:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UMK3eYG7MeIwiFpTwGnDEYMK+p+6nEkAFcTAtChjdQ=;
        b=iwTBObwhqnkNabia4MviFsgEPKqXYZqClGJfuovW+qcUYFQe+IZT0Z82tES9dora5u
         PSftgrZs4lRsJW7JaTEjHlQBBt+OTE+GAwE3MW+Kr9qxv/66VjPmLYZ/4ozbZgCtEV//
         KTCia+4mzkBLqXiQZ/xJfTESdY9GIHc9F+mGmacLzSNqhj8vj8++bM6awY80FfUX9TQU
         LQLF3doQWCY8kBkkkoVF84BqrSxTwu76ZUAyepv05EvK+D5wFbiqACLVSDobdAJdljyI
         YKwLYLRfglhFSMbKXICxLP47LWJVXOALzgVI9P4fdiuFSezxvbkCouyOkhkAeL62EcuV
         wF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UMK3eYG7MeIwiFpTwGnDEYMK+p+6nEkAFcTAtChjdQ=;
        b=W3H1uRhmNLzal+3lAA9VrA5P34ME5reKcipcM8tm3O6489zoDVY41H4MaEUy3XMbn6
         8+XBIz+0wIz0XPl2bITztbfQAucJjo5blVZ0n3X3WzsEWsxX6FQ0E7+Nfl0U0URHCtsc
         yC4lA+mta0H5nMlr2ST1gdd7hKzth69+xVaUgsrT+xh8zqH+JHTRktJssKb4g57caCvP
         WrbDl41txQHxkBpD0E1MUR4oB9CiSXrhMYXjPZHD/HVE3Rt+VKIuUDGTymO2QBHHfXvF
         9CAyhpwH81VNaJB1aFAsEWeVqfhOBjIKcnm5gBHAjGA8LR2s/KyJ33Ndq25V9UXFHQRj
         MTLg==
X-Gm-Message-State: AFqh2konBHQDHrQPAEmlTIJnY1Oeh75iRwexd7sZqBt6mfIR7Zwyecbx
        K0Thvggihv6mv2QNPM/KaTo=
X-Google-Smtp-Source: AMrXdXvYjW+GWNSSFC5b+8NWInxq4i8/q1s4IMWpuu0Ptp6el/8QyupRPrKs6ZfAsEsxU5gEi2PA7g==
X-Received: by 2002:a05:6a20:7fa5:b0:b9:4afb:1472 with SMTP id d37-20020a056a207fa500b000b94afb1472mr62273517pzj.13.1675111502728;
        Mon, 30 Jan 2023 12:45:02 -0800 (PST)
Received: from localhost ([2406:7400:63:1fd8:5041:db86:706c:f96b])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090aae0400b00213c7cf21c0sm7456180pjq.5.2023.01.30.12.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 12:45:02 -0800 (PST)
Date:   Tue, 31 Jan 2023 02:14:59 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 3/3] iomap: Support subpage size dirty tracking to
 improve write performance
Message-ID: <20230130204459.fcfisawoh7jc62ej@rh-tp>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <5e49fa975ce9d719f5b6f765aa5d3a1d44d98d1d.1675093524.git.ritesh.list@gmail.com>
 <Y9f7cZxnXbL7x0p+@infradead.org>
 <Y9gF6RVxDkvEgQoG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gF6RVxDkvEgQoG@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/01/30 06:01PM, Matthew Wilcox wrote:
> On Mon, Jan 30, 2023 at 09:16:33AM -0800, Christoph Hellwig wrote:
> > > +		if (from_writeback && folio_test_uptodate(folio))
> > > +			bitmap_fill(iop->state, 2 * nr_blocks);
> > > +		else if (folio_test_uptodate(folio)) {
> >
> > This code is very confusing.  First please only check
> > folio_test_uptodate one, and then check the from_writeback flag
> > inside the branch.  And as mentioned last time I think you really
> > need some symbolic constants for dealing with dirty vs uptodate
> > state and not just do a single fill for them.
>
> And I don't think this 'from_writeback' argument is well-named.
> Presumably it's needed because folio_test_dirty() will be false
> at this point in the writeback path because it got cleared by the VFS?

Yes, folio_test_dirty() is false. We clear it in write_cache_pages() by calling
clear_page_dirty_for_io() before calling iomap_do_writepage().

> But in any case, it should be called 'dirty' or something, not tell me
> where the function was called from.  I think what this should really
> do is:
>
> 		if (dirty)
> 			iop_set_dirty(iop, 0, nr_blocks);
> 		if (folio_test_uptodate(folio))
> 			iop_set_uptodate(iop, 0, nr_blocks);

Sure I got the idea. I will use "bool is_dirty".

>
> > > +			unsigned start = offset_in_folio(folio,
> > > +					folio_pos(folio)) >> inode->i_blkbits;
> > > +			bitmap_set(iop->state, start, nr_blocks);
> >
> > Also this code leaves my head scratching.  Unless I'm missing something
> > important
> >
> > 	 offset_in_folio(folio, folio_pos(folio))
> >
> > must always return 0.
>
> You are not missing anything.  I don't understand the mental process
> that gets someone to writing that.  It should logically be 0.

Sorry about the confusion. Yes, that is correct. I ended up using above at some
place and 0 at others. Then for final cleanup I ended up using the above call.

I will correct it in the next rev.

>
> > Also the from_writeback logic is weird.  I'd rather have a
> > "bool is_dirty" argument and then pass true for writeback beause
> > we know the folio is dirty, false where we know it can't be
> > dirty and do the folio_test_dirty in the caller where we don't
> > know the state.
>
> hahaha, you think the same.  ok, i'm leaving my above comment though ;-)
>
No problem ;)

Thanks for your review!!
-ritesh

