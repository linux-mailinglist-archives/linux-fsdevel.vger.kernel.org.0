Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C8447096C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 19:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245641AbhLJS51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 13:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbhLJS51 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:57:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A287CC061746;
        Fri, 10 Dec 2021 10:53:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65EAEB82989;
        Fri, 10 Dec 2021 18:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9AEC341C7;
        Fri, 10 Dec 2021 18:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639162429;
        bh=bO7Eu3iI1mbIHn+UhTqDFncjxb1MxBZo/63BiidDSgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=enP6e6yrBJzzWDZVNBZMeRr8z53jVofjrs9af14ggw4htEIAwoC2OKdhCMYJAnTq/
         6+dBQR3aRThEKUIb/meXolz7WPZMxLZFkhLV2zAo72Fg92tSDT3HihuWleytrsX93t
         WnJD4TeG43i66YbrYPHZ7e3QYUZP/CDmcsvpqpwf7L261Ib/CS6fJCv2ztx7x8UhJO
         v/cpmC+vteyr5ozj5ti1yqp9YppP56FADZw6SJgpMr+muTn84Pocl1pj6820ugWxZw
         HjTZqNo8z+iqEoMUp3VVqiJeJD8RS4+NnBd1A4wW7+VbC0P1G21Pf24DS7CmwYqfeo
         LnKKiWzblD1Kw==
Date:   Fri, 10 Dec 2021 10:53:47 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     bcrl@kvack.org, viro@zeniv.linux.org.uk, tglx@linutronix.de,
        axboe@kernel.dk, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Fix incorrect usage of eventfd_signal_allowed()
Message-ID: <YbOiO7xlOL0kkuYF@sol.localdomain>
References: <20210913111928.98-1-xieyongji@bytedance.com>
 <Ya/vW/eGXCzbmvAC@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya/vW/eGXCzbmvAC@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 03:33:47PM -0800, Eric Biggers wrote:
> On Mon, Sep 13, 2021 at 07:19:28PM +0800, Xie Yongji wrote:
> > We should defer eventfd_signal() to the workqueue when
> > eventfd_signal_allowed() return false rather than return
> > true.
> > 
> > Fixes: b542e383d8c0 ("eventfd: Make signal recursion protection a task bit")
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  fs/aio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/aio.c b/fs/aio.c
> > index 51b08ab01dff..8822e3ed4566 100644
> > --- a/fs/aio.c
> > +++ b/fs/aio.c
> > @@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
> >  		list_del(&iocb->ki_list);
> >  		iocb->ki_res.res = mangle_poll(mask);
> >  		req->done = true;
> > -		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
> > +		if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
> >  			iocb = NULL;
> >  			INIT_WORK(&req->work, aio_poll_put_work);
> >  			schedule_work(&req->work);
> > -- 
> > 2.11.0
> > 
> 
> Since I was just working with this file...:
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> 
> I don't know who is taking aio fixes these days, but whoever does so probably
> should take this one at the same time as mine
> (https://lore.kernel.org/linux-fsdevel/20211207095726.169766-1-ebiggers@kernel.org).

Apparently no one is, so I've included this patch in the pull request I've sent
(https://lore.kernel.org/r/YbOdV8CPbyPAF234@sol.localdomain).

- Eric
