Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252F64D409B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 06:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbiCJFSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 00:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiCJFSw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:18:52 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F52F7473;
        Wed,  9 Mar 2022 21:17:52 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id bt3so3830051qtb.0;
        Wed, 09 Mar 2022 21:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WrNwnE++yKPfPmSklPNYSNMV5vPC/XCvYVpE3pw0sGc=;
        b=MgD/6ArL2MG44M9RcErryB0EahpsgjLFFEpQRtjBSvNmN43MUPZ9mfnDuSOqzSBQwr
         HQdzJUho/GetyqZ8vc3IUOzZNBNE60c6C/CFxHJgcvq4hHv7Dv/pV+gY26sLJVzlgiaH
         whopaVbfiWtPBBZvs2l0lW+AmoaqaNOgE2wyo8MJ85Rml2nUX0PBRQ0Vg8nAMPJKy6Di
         TJH1FiMdI+eBb0C5nQn3cRY2xg2inxeYUD88bblRdRza3Ejm9IVWHxmdhKd7YBnCf3Rx
         Otj1MzVVhGW4IL8h7fAdZwMp1LtUtSXBP8Z5AvT9beA1lZsOFMcgsqFWFg2kESRPAA6s
         kWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WrNwnE++yKPfPmSklPNYSNMV5vPC/XCvYVpE3pw0sGc=;
        b=umr1tmq3s+F3qgSDP4A2K/p1DRW3kKrUSTsqyc+jiKtnzBguEZpDvw/TZb/kQDZUzv
         bAjm0IzC2CR9ap/4pC06jLWIFROQe4R9nnk4SJxIg7gwI7IGAwIO6ypQ3o1Dz0D672Ii
         6mjYgC3PA4/mceOF61FEHe4F+VD3/hBK9bFEuYq7NW67+JFgYQdNIGDRVpUFuzQ4dU0T
         15GxAfLAGVyq1K1NK80bnI5UGzxyvLYVDTzfYS3zvXCXuu+AsBygl1gBLMYhrwLYJSC/
         68Zc9ZuJCniDmhlga+KHHxFStOFl1gNrEX/fPiOuKs2FN6cUPAfeo1h6ycJHpMgpz0D7
         J7QQ==
X-Gm-Message-State: AOAM531RYgPP0aeLKEe3Xnv2KBo9KuNnrOwU4rsr2jaeFMUBUGZsPcq1
        tLuUK9lM1V9jiH6rrYVBCQ==
X-Google-Smtp-Source: ABdhPJyQE3QVe6fUqSAL/VctNAhWvq4v2xr6euxstRWR3FtOz6FYdUwJCXNlJGEhWdpFaIU/Ry3MBw==
X-Received: by 2002:a05:622a:1903:b0:2dd:a07e:659e with SMTP id w3-20020a05622a190300b002dda07e659emr2566500qtc.360.1646889471294;
        Wed, 09 Mar 2022 21:17:51 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id b13-20020ac85bcd000000b002e06856b04fsm2633960qtb.51.2022.03.09.21.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 21:17:50 -0800 (PST)
Date:   Thu, 10 Mar 2022 00:17:48 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Significant brokenness in DIO loopback path
Message-ID: <YimJ/OrZpMyFOFEl@moria.home.lan>
References: <YilX4PHgulMi3vhb@moria.home.lan>
 <Yiltk3RWTPJvPJph@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yiltk3RWTPJvPJph@T590>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:16:35AM +0800, Ming Lei wrote:
> On Wed, Mar 09, 2022 at 08:44:00PM -0500, Kent Overstreet wrote:
> > So I'm testing bcachefs with the loopback driver in dio mode, and noticing
> > _significant_ brokenness in the bio_iov_iter_get_pages() path and elsewhere.
> > 
> > 1) We don't check that we're not asking for more pages than we're in the
> > original bio
> > 
> > Noticed this because of another bug:
> > 
> > 2) the loopback driver appears to never look at the underlying filesystem's
> > block size, meaning if the filesystem advertises a block size of 4k the loopback
> > device's blocksize will still be 512, and we'll end up issuing IOs the DIO path
> > shouldn't allow due to alignment.
> 
> I tried to fallback to buffered IO for unaligned dio, it was rejected.
> 
> https://lore.kernel.org/linux-block/20211025094437.2837701-1-ming.lei@redhat.com/

I agree with Christoph, mixing buffered and DIO is a bad idea and we should be
rejecting unaligned IO. However, filesystems reject unaligned DIO, I don't think
loopback necessarily needs to be checking for that.

> Also the ahead of time check may not work as expected because of ioctl
> order, I guess that is why you see loop 512 bs even the underlying advertises
> big 4k siz

Ugh... artifact of the old workflow where we create a loopback device, then
attach it to a file. Would be much better if we always created a loopback device
and attached it to a file as part of the same operation.

> Also loop 512 bs is often useful since the upper FS image may need that.

Not a valid rationale here. If 512 aligned DIO doesn't work, then it doesn't
work, it's not loopback's job to fake it.

> 
> > 
> > 3) iov_iter_bvec_advance() looks like utter nonsense. We're synthesizing a fake
> > bvec_iter and never using or even looking at one from the original bio, looking
> > at the construction in iov_iter_bvec().
> > 
> > This is broken; you're assuming you're never going to see bios with partially
> > completed bvec_iters, or things are going to explode.
> > 
> > Try putting a md raid0 on top of two loopback devices with a sub page block
> > size, things are just going to explode.
> > 
> > iov_iter_bvec() needs to be changed to take a bio, not a bvec array, and
> > iov_iter_bvec_advance() should probably just call bio_advance() - and
> > bio_iov_bvec_set() needs to be changed to just copy bi_iter from the original
> > bio into the dest bio. You guys made this way more complicated than it needed to
> > be.
> 
> Can you share the function in loop.c you are talking? Is it lo_rw_aio()? What is
> the exact issue in current way?

So looking at lo_rw_aio() it does look correct, just perverse.

Something's still buggy though, 

Why are we using request queues here at all? Request merging was useful in the
rotating disk era, and especially back when filesystems were block based and not
extent based and sent a lot of mergeable requests - that's not the case so much
anymore.

Might it not be simpler to just skip all that and have dio-mode loopback be bio
based?
