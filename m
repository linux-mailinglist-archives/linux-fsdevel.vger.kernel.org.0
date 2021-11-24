Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6245CE2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 21:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbhKXUlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 15:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbhKXUlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:41:08 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AC5C061574;
        Wed, 24 Nov 2021 12:37:58 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b40so10407521lfv.10;
        Wed, 24 Nov 2021 12:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EwupdbY0PB4JvA93A03z8JMfsTzehEG1TRHp4ST91mU=;
        b=aHPtsF5pdrfDnRfEapR+kwM43+oueoevP6OkEWkjP0RfxBESUAk5JcJEfGeBEeJeLh
         ekTkoQ3OEuegX4bpBrCqc/uMEex8fr4yAZP9GKT3VoNM096P+lY2c/dekOKFc+z9lbzF
         Wz8pE7D7R+rHKIg72fmRngd31tNjfrRSBAmmI4DjbS6jz7wSvbTiOhxuO78xn6E4LKqA
         9wxH47xDueCiPzGZ5wqc2aymPUCPXQkppgmOuC7r0IrS/pnxa0Pi0HorTKBGjkL9ains
         XIBPx5u0fId6dQncch1PWIxOunIjTO8UX7z+7DXhGBLxqqWogBjG097fvmN3Q4DNtWPp
         h2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EwupdbY0PB4JvA93A03z8JMfsTzehEG1TRHp4ST91mU=;
        b=z7L0+ODVc4rf8tsclzcQOUYVcQlgYJCMpxgTDMmYOzhLZi/NSmXaqSufvOTd/3IBn1
         PRrYdNFIRCt8d1GSH6VobQF8fZ9Lq6+c77bx3Zgx1EdDe/VupdRqyoIUWsZb13fgHcTc
         dFsKhHBuNekhWbyhQSFAsBQhXBKh+MYLiifsJDH5q6GeGkrT+qNN8Y5ilSnnHhw7XHQ4
         tnje7risGZn7YWpmadD/YcE1Rykx3VoLra///8dOJbIQBu3kF0L//9Lch+lPirhPWa/W
         yjil7bEIrOwG8hOhiFEU4wpTUfafLDXWBI+yRXhmgDEgZ32g7PRyR4xTb+1OeUDT5rUa
         NpJA==
X-Gm-Message-State: AOAM5324z6tQnXEfLO+/P1QWb9Iw/OrN34RzI1BUBNTFnULXkfn68351
        TS1Bd5TeIBlo+T9aIx+Pd7o=
X-Google-Smtp-Source: ABdhPJxpSQOKWZdYJXswWChcSrw3zy7D35ooyxk4IDHZQ43EVaoDf0Nyi/C8b32BuGRDs8NxFIxblQ==
X-Received: by 2002:a19:c3d6:: with SMTP id t205mr18211274lff.441.1637786276789;
        Wed, 24 Nov 2021 12:37:56 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t20sm76010lji.44.2021.11.24.12.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 12:37:56 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 24 Nov 2021 21:37:54 +0100
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YZ6iojllRBAAk8LW@pc638.lan>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
 <YZ37IJq3+DrVhAcD@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ37IJq3+DrVhAcD@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 09:43:12AM +0100, Michal Hocko wrote:
> On Tue 23-11-21 17:02:38, Andrew Morton wrote:
> > On Tue, 23 Nov 2021 20:01:50 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > > On Mon, Nov 22, 2021 at 04:32:31PM +0100, Michal Hocko wrote:
> > > > From: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > Dave Chinner has mentioned that some of the xfs code would benefit from
> > > > kvmalloc support for __GFP_NOFAIL because they have allocations that
> > > > cannot fail and they do not fit into a single page.
> > 
> > Perhaps we should tell xfs "no, do it internally".  Because this is a
> > rather nasty-looking thing - do we want to encourage other callsites to
> > start using it?
> 
> This is what xfs is likely going to do if we do not provide the
> functionality. I just do not see why that would be a better outcome
> though. My longterm experience tells me that whenever we ignore
> requirements by other subsystems then those requirements materialize in
> some form in the end. In many cases done either suboptimaly or outright
> wrong. This might be not the case for xfs as the quality of
> implementation is high there but this is not the case in general.
> 
> Even if people start using vmalloc(GFP_NOFAIL) out of lazyness or for
> any other stupid reason then what? Is that something we should worry
> about? Retrying within the allocator doesn't make the things worse. In
> fact it is just easier to find such abusers by grep which would be more
> elaborate with custom retry loops.
>  
> [...]
> > > > +		if (nofail) {
> > > > +			schedule_timeout_uninterruptible(1);
> > > > +			goto again;
> > > > +		}
> > 
> > The idea behind congestion_wait() is to prevent us from having to
> > hard-wire delays like this.  congestion_wait(1) would sleep for up to
> > one millisecond, but will return earlier if reclaim events happened
> > which make it likely that the caller can now proceed with the
> > allocation event, successfully.
> > 
> > However it turns out that congestion_wait() was quietly broken at the
> > block level some time ago.  We could perhaps resurrect the concept at
> > another level - say by releasing congestion_wait() callers if an amount
> > of memory newly becomes allocatable.  This obviously asks for inclusion
> > of zone/node/etc info from the congestion_wait() caller.  But that's
> > just an optimization - if the newly-available memory isn't useful to
> > the congestion_wait() caller, they just fail the allocation attempts
> > and wait again.
> 
> vmalloc has two potential failure modes. Depleted memory and vmalloc
> space. So there are two different events to wait for. I do agree that
> schedule_timeout_uninterruptible is both ugly and very simple but do we
> really need a much more sophisticated solution at this stage?
>
I would say there is at least one more. It is about when users set their
own range(start:end) where to allocate. In that scenario we might never
return to a user, because there might not be any free vmap space on
specified range.

To address this, we can allow __GFP_NOFAIL only for entire vmalloc
address space, i.e. within VMALLOC_START:VMALLOC_END. By doing so
we will guarantee that we will not run out of vmap space, at least
for 64 bit systems, for smaller 32 bit ones we can not guarantee it
but it is populated back when the "lazily free logic" is kicked.

--
Vlad Rezki
