Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0116B6836F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 21:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjAaUA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 15:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjAaUAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:00:25 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E53367C0;
        Tue, 31 Jan 2023 12:00:24 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so7895287pjb.4;
        Tue, 31 Jan 2023 12:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQy9Ff+NEVGlrm7wVXyq3Wf3RjzU5BAdjABffeojp70=;
        b=W61u9o4b9slMDo2AYMkb0JpU2lXs0bKVfemYwXjc4PO74dr7qgy69guHo9pb739wIg
         o4zClp/RsXSePkmnYeFVJLA+8RqNJFS9xfZE2pFAdGP5rMN2KNTCm/KZNB9Gb6czyTrj
         W0UMCkBcv8vsljNBGkIpSFsVFLGiy80TaC1EFhfW/jYLK3Q+mINzea8YhXuRFlgEvP5e
         a9xYR+kwwC8Xq+79t1St1SOscLVH5v05sZcuGUjVLzodzT5BCuwTRnygOiYE3L9i3yW1
         2B1u/XNgWAyH08MCsxTgZE4ykGll7QM1HcFVfy1CiBHkzYDyUHJi6harTOYUgPhRo40O
         A8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQy9Ff+NEVGlrm7wVXyq3Wf3RjzU5BAdjABffeojp70=;
        b=YEUh/fGzCT68NYiIxQSZkJ51iHQoMb7bgZ0dZa2wOUkOV0EDRCTmY5I4sT5X0UgtLg
         bjldBXUTtKYavlHemOQ6s+4CuptHaqBJy/2j7ED9JG2eQWm8VQy1ezBoLZEadNgKnjq+
         KPFHdoHYBWtpH+cRx2VqV09BWo3moWaVmRnrcMrqkUQ4fc/WL9TkQuiDDTv4jrzqBZYB
         5UaHvHiEGJyCUR/K5GCCyLThc/k58dBIKUBBXsnTSv/CVPrWebyK7jYyOfaT7NdKj+5/
         KMh1/QxPVbu4r0dAIj6P8Ns1SxkjfR5FuEvPxYnhL/3B6LYH6jmglgB02HlUj3Otfp/t
         sQwg==
X-Gm-Message-State: AO0yUKXxev/fgIeHmLuZ8hJV8gmEpWeDeWtCfpcewQdRTeE2Bpz56YM+
        96IHfKDTNc1jsDK1Pm8ltB4IXi/Ua4s=
X-Google-Smtp-Source: AK7set9+HnOY/Slv9lUQ11sPE+F7xU4NWx4YexSHBfu2ReCiYS/yDZ9rZHRVw7ptEua4iD5RZdH3YA==
X-Received: by 2002:a05:6a20:441a:b0:be:9629:2cbd with SMTP id ce26-20020a056a20441a00b000be96292cbdmr8871276pzb.14.1675195223945;
        Tue, 31 Jan 2023 12:00:23 -0800 (PST)
Received: from localhost ([2406:7400:63:1fd8:5041:db86:706c:f96b])
        by smtp.gmail.com with ESMTPSA id l2-20020a63be02000000b004e25f1bb85csm6494201pgf.54.2023.01.31.12.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 12:00:23 -0800 (PST)
Date:   Wed, 1 Feb 2023 01:30:20 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 1/3] iomap: Move creation of iomap_page early in
 __iomap_write_begin
Message-ID: <20230131200020.pywjhsvdpeu3lklv@rh-tp>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <d879704250b5f890a755873aefe3171cbd193ae9.1675093524.git.ritesh.list@gmail.com>
 <Y9f4MFzpFEi73E6P@infradead.org>
 <20230130202150.pfohy5yg6dtu64ce@rh-tp>
 <Y9gv0YV9V6gR9l3F@casper.infradead.org>
 <20230131183725.m7yoh7st5pplilvq@rh-tp>
 <Y9lihmePkCHWHrlI@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9lihmePkCHWHrlI@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/01/31 06:48PM, Matthew Wilcox wrote:
> On Wed, Feb 01, 2023 at 12:07:25AM +0530, Ritesh Harjani (IBM) wrote:
> > On 23/01/30 09:00PM, Matthew Wilcox wrote:
> > > On Tue, Jan 31, 2023 at 01:51:50AM +0530, Ritesh Harjani (IBM) wrote:
> > > > > > Thus the iop structure will only gets allocated at the time of writeback
> > > > > > in iomap_writepage_map(). This I think, was a not problem till now since
> > > > > > we anyway only track uptodate status in iop (no support of tracking
> > > > > > dirty bitmap status which later patches will add), and we also end up
> > > > > > setting all the bits in iomap_page_create(), if the page is uptodate.
> > > > >
> > > > > delayed iop allocation is a feature and not a bug.  We might have to
> > > > > refine the criteria for sub-page dirty tracking, but in general having
> > > > > the iop allocates is a memory and performance overhead and should be
> > > > > avoided as much as possible.  In fact I still have some unfinished
> > > > > work to allocate it even more lazily.
> > > >
> > > > So, what I meant here was that the commit[1] chaged the behavior/functionality
> > > > without indenting to. I agree it's not a bug.
> > >
> > > It didn't change the behaviour or functionality.  It broke your patches,
> > > but it certainly doesn't deserve its own commit reverting it -- because
> > > it's not wrong.
> > >
> > > > But when I added dirty bitmap tracking support, I couldn't understand for
> > > > sometime on why were we allocating iop only at the time of writeback.
> > > > And it was due to a small line change which somehow slipped into this commit [1].
> > > > Hence I made this as a seperate patch so that it doesn't slip through again w/o
> > > > getting noticed/review.
> > >
> > > It didn't "slip through".  It was intended.
> > >
> > > > Thanks for the info on the lazy allocation work. Yes, though it is not a bug, but
> > > > with subpage dirty tracking in iop->state[], if we end up allocating iop only
> > > > at the time of writeback, than that might cause some performance degradation
> > > > compared to, if we allocat iop at ->write_begin() and mark the required dirty
> > > > bit ranges in ->write_end(). Like how we do in this patch series.
> > > > (Ofcourse it is true only for bs < ps use case).
> > > >
> > > > [1]: https://lore.kernel.org/all/20220623175157.1715274-5-shr@fb.com/
> > >
> > > You absolutely can allocate it in iomap_write_begin, but you can avoid
> > > allocating it until writeback time if (pos, len) entirely overlap the
> > > folio.  ie:
> > >
> > > 	if (pos > folio_pos(folio) ||
> > > 	    pos + len < folio_pos(folio) + folio_size(folio))
> > > 		iop = iomap_page_create(iter->inode, folio, iter->flags, false);
> >
> > Thanks for the suggestion. However do you think it will be better if this is
> > introduced along with lazy allocation changes which Christoph was mentioning
> > about?
> > Why I am thinking that is because, with above approach we delay the allocation
> > of iop until writeback, for entire folio overlap case. But then later
> > in __iomap_write_begin(), we require iop if folio is not uptodate.
> > Hence we again will have to do some checks to see if the iop is not allocated
> > then allocate it (which is for entire folio overlap case).
> > That somehow looked like an overkill for a very little gain in the context of
> > this patch series. Kindly let me know your thoughts on this.
>
> Look at *why* __iomap_write_begin() allocates an iop.  It's to read in the
> blocks which are going to be partially-overwritten by the write.  If the
> write overlaps the entire folio, there are no parts which need to be read
> in, and we can simply return.

Yes that make sense.

> Maybe we should make that more obvious:

Yes, I think this maybe required. Because otherwise we might end up using
uninitialized iop. generic/156 (funshare), can easily trigger that.
Will spend sometime on the unshare path of iomap.

>
> 	if (folio_test_uptodate(folio))
> 		return 0;
> 	if (pos <= folio_pos(folio) &&
> 	    pos + len >= folio_pos(folio) + folio_size(folio))
> 		return 0;
> 	folio_clear_error(folio);
>
> (I think pos must always be >= folio_pos(), so that <= could be ==, but
> it doesn't hurt anything to use <=)

Thanks for sharing this.

-ritesh
