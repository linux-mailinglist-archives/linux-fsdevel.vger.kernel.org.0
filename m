Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CC3683577
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 19:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjAaShd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 13:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjAaShb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:37:31 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E11913E;
        Tue, 31 Jan 2023 10:37:30 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso20048194pjj.1;
        Tue, 31 Jan 2023 10:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wve+migYBKDWcs0pRJx6zwJwUe+DYTPKtb9wePfpNco=;
        b=GkcbEkl3vPlEWDbkZ+V4oSymOFgFVrCrhvIqpQ05V7TPrE7VnUjuw5lK063vprP4EY
         pXFN7O6ERxjVyZOcv9P7Q/SpfqM082T29qMbhzn6yXc0FUZLCbcNItKdNngMEhiuHHiu
         Ku1gVmYBQI2E0wB/lHbbKrvXWVJ07o+NvMVyDvT7S9yH/qinJZDDR5fpJIAx912zZwdX
         NdD+MOkqKMnh+njsetaNKjKUXd/KRv4yIXw10VCl2/hexazHJjS6Yh+ve4O33vAce1EX
         /A0rfxKJA87mU5TzM3JUVoEpwNUEcDAo+EhiZcJSAQQWrS4Xq3Png+FcOcLEQLvF14kv
         C8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wve+migYBKDWcs0pRJx6zwJwUe+DYTPKtb9wePfpNco=;
        b=dABCzHEl6W/jl8NF2dKO6wLHtnZzCvr4X2YNOjXVrU0brlegnLHJQlRSCxJyZAKqpW
         bidesF3xfveh8LHJyD+5R0+v4yeYWRvEjMedtct6ulsTWRAz0j8+2Z+bA3T4SO9Gh1XJ
         09xBWm9JAKQvVjamq+aljAu6LdiavLwpKF4lA7CHmkBYb5oxREXvXn3MOqtA/6WJsvUF
         zSABFmpLilwRcAoN5XuDFtu32TXS8JjCCBDaFGjJSnz1C0KPDtuLJtqm+aqXVhktkwiw
         k2AjKiJ3wAKdwUi+3kmaHgKcx6/Egh6oJVfwtCP3IkBSm5Dkhrwsgit3tTc36M9OwR6z
         sQdw==
X-Gm-Message-State: AO0yUKUjxWwluLQSGi6lCsU8gQ2/NRIDrfAPC4QXGw5PGVDlv0SyOd3w
        PUTS00DscCndy+NB/YUzjddlFDnnPy8=
X-Google-Smtp-Source: AK7set8joXtAGgYSflWwrANTasoKHBiG3mhf3qVb9kQ2WjE3AeJyZdgop32rktmvDFKIkz2oDB4j8A==
X-Received: by 2002:a17:90b:1d91:b0:22b:ed4a:c46e with SMTP id pf17-20020a17090b1d9100b0022bed4ac46emr30684524pjb.30.1675190249423;
        Tue, 31 Jan 2023 10:37:29 -0800 (PST)
Received: from localhost ([2406:7400:63:1fd8:5041:db86:706c:f96b])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090a708800b00213202d77d9sm8786557pjk.43.2023.01.31.10.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:37:28 -0800 (PST)
Date:   Wed, 1 Feb 2023 00:07:25 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 1/3] iomap: Move creation of iomap_page early in
 __iomap_write_begin
Message-ID: <20230131183725.m7yoh7st5pplilvq@rh-tp>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <d879704250b5f890a755873aefe3171cbd193ae9.1675093524.git.ritesh.list@gmail.com>
 <Y9f4MFzpFEi73E6P@infradead.org>
 <20230130202150.pfohy5yg6dtu64ce@rh-tp>
 <Y9gv0YV9V6gR9l3F@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gv0YV9V6gR9l3F@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/01/30 09:00PM, Matthew Wilcox wrote:
> On Tue, Jan 31, 2023 at 01:51:50AM +0530, Ritesh Harjani (IBM) wrote:
> > > > Thus the iop structure will only gets allocated at the time of writeback
> > > > in iomap_writepage_map(). This I think, was a not problem till now since
> > > > we anyway only track uptodate status in iop (no support of tracking
> > > > dirty bitmap status which later patches will add), and we also end up
> > > > setting all the bits in iomap_page_create(), if the page is uptodate.
> > >
> > > delayed iop allocation is a feature and not a bug.  We might have to
> > > refine the criteria for sub-page dirty tracking, but in general having
> > > the iop allocates is a memory and performance overhead and should be
> > > avoided as much as possible.  In fact I still have some unfinished
> > > work to allocate it even more lazily.
> >
> > So, what I meant here was that the commit[1] chaged the behavior/functionality
> > without indenting to. I agree it's not a bug.
>
> It didn't change the behaviour or functionality.  It broke your patches,
> but it certainly doesn't deserve its own commit reverting it -- because
> it's not wrong.
>
> > But when I added dirty bitmap tracking support, I couldn't understand for
> > sometime on why were we allocating iop only at the time of writeback.
> > And it was due to a small line change which somehow slipped into this commit [1].
> > Hence I made this as a seperate patch so that it doesn't slip through again w/o
> > getting noticed/review.
>
> It didn't "slip through".  It was intended.
>
> > Thanks for the info on the lazy allocation work. Yes, though it is not a bug, but
> > with subpage dirty tracking in iop->state[], if we end up allocating iop only
> > at the time of writeback, than that might cause some performance degradation
> > compared to, if we allocat iop at ->write_begin() and mark the required dirty
> > bit ranges in ->write_end(). Like how we do in this patch series.
> > (Ofcourse it is true only for bs < ps use case).
> >
> > [1]: https://lore.kernel.org/all/20220623175157.1715274-5-shr@fb.com/
>
> You absolutely can allocate it in iomap_write_begin, but you can avoid
> allocating it until writeback time if (pos, len) entirely overlap the
> folio.  ie:
>
> 	if (pos > folio_pos(folio) ||
> 	    pos + len < folio_pos(folio) + folio_size(folio))
> 		iop = iomap_page_create(iter->inode, folio, iter->flags, false);

Thanks for the suggestion. However do you think it will be better if this is
introduced along with lazy allocation changes which Christoph was mentioning
about?
Why I am thinking that is because, with above approach we delay the allocation
of iop until writeback, for entire folio overlap case. But then later
in __iomap_write_begin(), we require iop if folio is not uptodate.
Hence we again will have to do some checks to see if the iop is not allocated
then allocate it (which is for entire folio overlap case).
That somehow looked like an overkill for a very little gain in the context of
this patch series. Kindly let me know your thoughts on this.

-ritesh
