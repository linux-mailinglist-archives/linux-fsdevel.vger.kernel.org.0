Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EF645CDAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 21:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245614AbhKXUO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 15:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245315AbhKXUO5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:14:57 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DA4C061574;
        Wed, 24 Nov 2021 12:11:47 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t11so7868190ljh.6;
        Wed, 24 Nov 2021 12:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qo7LDGhCLw1C/RJQYl0tsOOlrBM+qKnIMUTYLFn/vQQ=;
        b=Ni20t8kujf1xCNBvR2ocQhRylwmF7uC76Mvyh2gPUvifqSaIsGREt/f5hIqSG2wiTr
         dQn3LVBT8cHVAJuVkMgFmh6gyr7erO0A06TE9ESc4A6eXZ1Z0meGe+5YVbaJaED8ir5m
         NAih7dCQX5Fj1KRbouiuK8sU0D1u0lr7EKQRbFpxmNvMZ7hp+dD8deN/erEu8uilWZ/D
         oC8XRNSeqfv4E4oZ/oM+OoZrQASYORbihsP98KJeL+MFf59FF1Xij+dPHsgNnXV3ofMU
         InX63UB1ldeQYYH7W60vvf2oU7Ia3Hqa5+DS2fcdmpPvbsRr/qk2FBKwSr026AQQvJiI
         ZAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qo7LDGhCLw1C/RJQYl0tsOOlrBM+qKnIMUTYLFn/vQQ=;
        b=v2dz4FT/7lRDt+kA7zqKJ1V2+mA3R7nxx0kBiAbzakIA8Nvc2pwOMyEV9TCBp0JmUZ
         s7/yP8in1djYpc5tl10djG5VIOcNGMrppMs7nbtbu+rAo1Nkv8Z1PWBmXogRRQ2eCL2d
         9Taxp0jwTi6bBb3PjOUsjp9gSIfF3MvHmkhIwOWZaBwzomivuYvclkDQS30MTOh2Z85U
         70XPa6M382PVGmu7Vf2m2sCJH0WosKOahDk8knUeRF1CGnp2tI5+BjA+q0lFzIxeXiRw
         HtDsZBn67zglL4A2e5pVytP8/ngN7H6MYjOPJVN6Xej3ogFLhrZEly0+P+K0lahC5KAD
         kEQA==
X-Gm-Message-State: AOAM533Rb7j01ndrDvhbu1jDL0/ilq482HCI+HUpaFpHKCNMymfSEQAb
        EjEJ6vCb+htJOwiyVeI0Nec=
X-Google-Smtp-Source: ABdhPJzObzGBkOGhdbTxdRc7AS1CzlPcgd/68XPHDPyMtGRhoDIWH76itaokZ7li1Dq39AFb/lTryQ==
X-Received: by 2002:a2e:2a43:: with SMTP id q64mr19178322ljq.102.1637784705684;
        Wed, 24 Nov 2021 12:11:45 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id r25sm74076lfi.166.2021.11.24.12.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 12:11:44 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 24 Nov 2021 21:11:42 +0100
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YZ6cfoQah8Wo1eSZ@pc638.lan>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 05:02:38PM -0800, Andrew Morton wrote:
> On Tue, 23 Nov 2021 20:01:50 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > On Mon, Nov 22, 2021 at 04:32:31PM +0100, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > Dave Chinner has mentioned that some of the xfs code would benefit from
> > > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > > cannot fail and they do not fit into a single page.
> 
> Perhaps we should tell xfs "no, do it internally".  Because this is a
> rather nasty-looking thing - do we want to encourage other callsites to
> start using it?
> 
> > > The large part of the vmalloc implementation already complies with the
> > > given gfp flags so there is no work for those to be done. The area
> > > and page table allocations are an exception to that. Implement a retry
> > > loop for those.
> > > 
> > > Add a short sleep before retrying. 1 jiffy is a completely random
> > > timeout. Ideally the retry would wait for an explicit event - e.g.
> > > a change to the vmalloc space change if the failure was caused by
> > > the space fragmentation or depletion. But there are multiple different
> > > reasons to retry and this could become much more complex. Keep the retry
> > > simple for now and just sleep to prevent from hogging CPUs.
> > > 
> 
> Yes, the horse has already bolted.  But we didn't want that horse anyway ;)
> 
> I added GFP_NOFAIL back in the mesozoic era because quite a lot of
> sites were doing open-coded try-forever loops.  I thought "hey, they
> shouldn't be doing that in the first place, but let's at least
> centralize the concept to reduce code size, code duplication and so
> it's something we can now grep for".  But longer term, all GFP_NOFAIL
> sites should be reworked to no longer need to do the retry-forever
> thing.  In retrospect, this bright idea of mine seems to have added
> license for more sites to use retry-forever.  Sigh.
> 
> > > +		if (nofail) {
> > > +			schedule_timeout_uninterruptible(1);
> > > +			goto again;
> > > +		}
> 
> The idea behind congestion_wait() is to prevent us from having to
> hard-wire delays like this.  congestion_wait(1) would sleep for up to
> one millisecond, but will return earlier if reclaim events happened
> which make it likely that the caller can now proceed with the
> allocation event, successfully.
> 
> However it turns out that congestion_wait() was quietly broken at the
> block level some time ago.  We could perhaps resurrect the concept at
> another level - say by releasing congestion_wait() callers if an amount
> of memory newly becomes allocatable.  This obviously asks for inclusion
> of zone/node/etc info from the congestion_wait() caller.  But that's
> just an optimization - if the newly-available memory isn't useful to
> the congestion_wait() caller, they just fail the allocation attempts
> and wait again.
> 
> > well that is sad...
> > I have raised two concerns in our previous discussion about this change,
> 
> Can you please reiterate those concerns here?
>
1. I proposed to repeat(if fails) in one solid place, i.e. get rid of
duplication and spreading the logic across several places. This is about
simplification.

2. Second one is about to do an unwinding and release everything what we
have just accumulated in terms of memory consumption. The failure might
occur, if so a condition we are in is a low memory one or high memory
pressure. In this case, since we are about to sleep some milliseconds
in order to repeat later, IMHO it makes sense to release memory:

- to prevent killing apps or possible OOM;
- we can end up looping quite a lot of time or even forever if users do
  nasty things with vmalloc API and __GFP_NOFAIL flag.

--
Vlad Rezki
