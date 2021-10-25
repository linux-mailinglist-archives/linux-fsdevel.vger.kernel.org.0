Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D785439301
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbhJYJvI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 05:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhJYJvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:51:07 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAD9C061745;
        Mon, 25 Oct 2021 02:48:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j21so10087247lfe.0;
        Mon, 25 Oct 2021 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QqMsyiItk1CJUMLvyAB7oSGHiADomdsKstyP5G3/bD4=;
        b=BQBx13oTsSRi0WotZ6RouoyPwz+KDAthgNX+I1SY+ZScstqpndlFGw/fDOiQxcmMJI
         aly2HJXmdYLUQEBIbwABDStH7F9eYP0XsfAJ7bvZ3GiECTjhHZw6Cygc3ppgmgblANRA
         E1M0/nT3FM+1QPJpXKI5DZYgUSNECm/aX+7YyWabbG+Fg6imXbE8TklInmq/a5+kfTlY
         uJqijtaxyaphvlZAdfAd1iijZbulcM0tOBu+MZmm0KQ2lIO6as06SGmPtgTxy03bUGF1
         330STbtZDXl14qZrXt9xzN3y0EzRxHg5KwGAqqjHJ2ZDg/vV0Bwk/qwsr08fVGrl1gRn
         YdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QqMsyiItk1CJUMLvyAB7oSGHiADomdsKstyP5G3/bD4=;
        b=SIcBcTvdmYgigADY38ohmvMrZ5+pu346duLJ1xUp6FX1gOuuLGaxlBAnQk7nqhOmK/
         VNvrLZA2EeRWs6Y+25XDrS0TaWYaGyqwvU2nFXntBGO7V94AsliML9YtmOkvgf2jsw81
         htkhtQtEXJyJw9+aOyEyPmJ6Xt7QCuTjvEWxAITJaJ8/Af102gxhoDIhmEHzN6PNeXIm
         WGkhh/CbojpFIMzZ/18aRh7KZVxQ8pAC2Pl74+w7fP/b4r7p4LFtrSSMbxWE408L8vXv
         Bl5r+pmm5KfQFYXBPijmIWYgNdpb0qZwKCn66BSbkJ165/crMC4GhUe9VkRXh2TyQ4Vv
         ZbvQ==
X-Gm-Message-State: AOAM530i0eWlTmnoSp45BxD3FqhyDqtSeboz60Hl3MRJaqA39WIblz7R
        8atXcq40aNqf+i7GlIP33qO9c1ZWeXewHw==
X-Google-Smtp-Source: ABdhPJxdegWrzpwWbMEBfHHyQe0pC8DZVIbVEnnaJD0GfN2N62Z6nPDzF8N35T6dFYy6LNaQZWAHtQ==
X-Received: by 2002:ac2:4c56:: with SMTP id o22mr15995166lfk.196.1635155323376;
        Mon, 25 Oct 2021 02:48:43 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id b29sm323084lfv.160.2021.10.25.02.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 02:48:42 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 25 Oct 2021 11:48:41 +0200
To:     NeilBrown <neilb@suse.de>, Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <20211025094841.GA1945@pc638.lan>
References: <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com>
 <YXAiZdvk8CGvZCIM@dhcp22.suse.cz>
 <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>
 <YXAtYGLv/k+j6etV@dhcp22.suse.cz>
 <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>
 <20211020192430.GA1861@pc638.lan>
 <163481121586.17149.4002493290882319236@noble.neil.brown.name>
 <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz>
 <20211021104038.GA1932@pc638.lan>
 <163485654850.17149.3604437537345538737@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163485654850.17149.3604437537345538737@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 09:49:08AM +1100, NeilBrown wrote:
> On Thu, 21 Oct 2021, Uladzislau Rezki wrote:
> > > On Thu 21-10-21 21:13:35, Neil Brown wrote:
> > > > On Thu, 21 Oct 2021, Uladzislau Rezki wrote:
> > > > > On Wed, Oct 20, 2021 at 05:00:28PM +0200, Uladzislau Rezki wrote:
> > > > > > >
> > > > > > > On Wed 20-10-21 16:29:14, Uladzislau Rezki wrote:
> > > > > > > > On Wed, Oct 20, 2021 at 4:06 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > > [...]
> > > > > > > > > As I've said I am OK with either of the two. Do you or anybody have any
> > > > > > > > > preference? Without any explicit event to wake up for neither of the two
> > > > > > > > > is more than just an optimistic retry.
> > > > > > > > >
> > > > > > > > From power perspective it is better to have a delay, so i tend to say
> > > > > > > > that delay is better.
> > > > > > >
> > > > > > > I am a terrible random number generator. Can you give me a number
> > > > > > > please?
> > > > > > >
> > > > > > Well, we can start from one jiffy so it is one timer tick: schedule_timeout(1)
> > > > > > 
> > > > > A small nit, it is better to replace it by the simple msleep() call: msleep(jiffies_to_msecs(1));
> > > > 
> > > > I disagree.  I think schedule_timeout_uninterruptible(1) is the best
> > > > wait to sleep for 1 ticl
> > > > 
> > > > msleep() contains
> > > >   timeout = msecs_to_jiffies(msecs) + 1;
> > > > and both jiffies_to_msecs and msecs_to_jiffies might round up too.
> > > > So you will sleep for at least twice as long as you asked for, possible
> > > > more.
> > > 
> > > That was my thinking as well. Not to mention jiffies_to_msecs just to do
> > > msecs_to_jiffies right after which seems like a pointless wasting of
> > > cpu cycle. But maybe I was missing some other reasons why msleep would
> > > be superior.
> > >
> > 
> > To me the msleep is just more simpler from semantic point of view, i.e.
> > it is as straight forward as it can be. In case of interruptable/uninteraptable
> > sleep it can be more confusing for people.
> 
> I agree that msleep() is more simple.  I think adding the
> jiffies_to_msec() substantially reduces that simplicity.
> 
> > 
> > When it comes to rounding and possibility to sleep more than 1 tick, it
> > really does not matter here, we do not need to guarantee exact sleeping
> > time.
> > 
> > Therefore i proposed to switch to the msleep().
> 
> If, as you say, the precision doesn't matter that much, then maybe
>    msleep(0)
> which would sleep to the start of the next jiffy.  Does that look a bit
> weird?  If so, the msleep(1) would be ok.
> 
Agree, msleep(1) looks much better rather then converting 1 jiffy to
milliseconds. Result should be the same.

> However now that I've thought about some more, I'd much prefer we
> introduce something like
>     memalloc_retry_wait();
> 
> and use that everywhere that a memory allocation is retried.
> I'm not convinced that we need to wait at all - at least, not when
> __GFP_DIRECT_RECLAIM is used, as in that case alloc_page will either
>   - succeed
>   - make some progress a reclaiming or
>   - sleep
> 
> However I'm not 100% certain, and the behaviour might change in the
> future.  So having one place (the definition of memalloc_retry_wait())
> where we can change the sleeping behaviour if the alloc_page behavour
> changes, would be ideal.  Maybe memalloc_retry_wait() could take a
> gfpflags arg.
> 
At sleeping is required for __get_vm_area_node() because in case of lack
of vmap space it will end up in tight loop without sleeping what is
really bad.

Thanks!

--
Vlad Rezki
