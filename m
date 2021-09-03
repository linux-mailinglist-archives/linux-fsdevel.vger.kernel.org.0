Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3DB4004FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 20:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349070AbhICSmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 14:42:02 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:36678 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbhICSmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:42:01 -0400
Received: by mail-pf1-f174.google.com with SMTP id m26so199608pff.3;
        Fri, 03 Sep 2021 11:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9kPuIw929oCM1hqjF6X0SykrffHZeMAV4qwiEqQpqlM=;
        b=BgjtggZTslnnwvdyD/SXLFxsloepagk62cv0/tzYi77T3haRXMH5Yagbmy0bRDBDjK
         MxEzKXwZOwnX7VTk4laTRXNH5uYQ7u5AWecSD6GTfON0d19Kr+EC0jka7Cy/JkK8UmRw
         ukzhfpfXqKp9lu7gfTiH0u0ekw4/2cVXtrSPsNT984XtDsOKhifg2eiybBZVu0ftVqqR
         XtHk5DhBcLRml5Cr7wPyw/PHLHi5GVNdbpRF2ZT3QsQOmqx9ZxjvX5Sd8C7UW1i1QQdK
         a5gbYddxEjOoV3fbYzfcF/USVCBbk6tPyr2u9jVBhChi4hOUrJL4JV8iPmd5bo8Knfrs
         zpAA==
X-Gm-Message-State: AOAM5306MnVj6nvmB5xkirtWth+gZSXdCXOFXIROhFbLGYvl1YOO1b3h
        JWj3lY/C4eaQG8Qw2wi+jaWBIE5ZoeQ=
X-Google-Smtp-Source: ABdhPJyz1h2DoGc/xJZP3bPKJyUeJuf87D1bJQ4ZAsjg4pOPDrls990UTw78VYyy+bxgODCmcNmpCg==
X-Received: by 2002:aa7:8d46:0:b029:3cd:c2fd:fea5 with SMTP id s6-20020aa78d460000b02903cdc2fdfea5mr218631pfe.31.1630694460564;
        Fri, 03 Sep 2021 11:41:00 -0700 (PDT)
Received: from fedora ([104.192.206.22])
        by smtp.gmail.com with ESMTPSA id c26sm109821pgl.10.2021.09.03.11.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 11:40:59 -0700 (PDT)
Date:   Fri, 3 Sep 2021 14:40:58 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] xfs: new code for 5.15
Message-ID: <YTJsOoqaI3FiTkZD@fedora>
References: <20210831211847.GC9959@magnolia>
 <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Thu, Sep 02, 2021 at 08:47:42AM -0700, Linus Torvalds wrote:
> On Tue, Aug 31, 2021 at 2:18 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > As for new features: we now batch inode inactivations in percpu
> > background threads, which sharply decreases frontend thread wait time
> > when performing file deletions and should improve overall directory tree
> > deletion times.
> 
> So no complaints on this one, but I do have a reaction: we have a lot
> of these random CPU hotplug events, and XFS now added another one.
> 
> I don't see that as a problem, but just the _randomness_ of these
> callbacks makes me go "hmm". And that "enum cpuhp_state" thing isn't
> exactly a thing of beauty, and just makes me think there's something
> nasty going on.
> 
> For the new xfs usage, I really get the feeling that it's not that XFS
> actually cares about the CPU states, but that this is literally tied
> to just having percpu state allocated and active, and that maybe it
> would be sensible to have something more specific to that kind of use.
> 
> We have other things that are very similar in nature - like the page
> allocator percpu caches etc, which for very similar reasons want cpu
> dead/online notification.
> 
> I'm only throwing this out as a reaction to this - I'm not sure
> another interface would be good or worthwhile, but that "enum
> cpuhp_state" is ugly enough that I thought I'd rope in Thomas for CPU
> hotplug, and the percpu memory allocation people for comments.
> 
> IOW, just _maybe_ we would want to have some kind of callback model
> for "percpu_alloc()" and it being explicitly about allocations
> becoming available or going away, rather than about CPU state.
> 
> Comments?
> 

I think there are 2 pieces here from percpu's side:
A) Onlining and offlining state related to a percpu alloc.
B) Freeing backing memory of an allocation wrt hot plug.

An RFC was sent out for B) in [1] and you need A) for B).
I can see percpu having a callback model for basic allocations that are
independent, but for anything more complex, that subsystem would need to
register with hotplug anyway. It appears percpu_counter already has hot
plug support. percpu_refcount could be extended as well, but more
complex initialization like the runqueues and slab related allocations
would require work. In short, yes I think A) is doable/reasonable.

Freeing the backing memory for A) seems trickier. We would have to
figure out a clean way to handle onlining/offlining racing with new
percpu allocations (adding or removing pages for the corresponding cpu's
chunk). To support A), init and onlining/offlining can be separate
phases, but for B) init/freeing would have to be rolled into
onlining/offlining.

Without freeing, it's not incorrect for_each_online_cpu() to read a dead
cpu's percpu values, but with freeing it does.

I guess to summarize, A) seems like it might be a good idea with
init/destruction happening at allocation/freeing times. I'm a little
skeptical of B) in terms of complexity. If y'all think it's a good idea
I can look into it again.

[1] https://lore.kernel.org/lkml/20210601065147.53735-1-bharata@linux.ibm.com/

Thanks,
Dennis

> > Lastly, with this release, two new features have graduated to supported
> > status: inode btree counters (for faster mounts), and support for dates
> > beyond Y2038.
> 
> Oh, I had thought Y2038 was already a non-issue for xfs. Silly me.
> 
>               Linus
