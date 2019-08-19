Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B103C9502C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 23:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfHSVwU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 17:52:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47049 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfHSVwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:52:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so1958314pfc.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2019 14:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1NM94xksOiht8RmgWrLEcFY3PgSHOoB3FnNWuwtEkT8=;
        b=ZIz4IZobyazBKzjPdPXduiU9VmQv41GRQbby3Zhrveo6Tz9PhO7CfVQSbB/TBOqzVV
         HKeoTTvO+/pPOZ6NjxPybqIoS90KhiOlS45PxA7pJUrdFjv/+xi3aMSn2GcoZjntjeft
         Q/tWStO+V0j/UbB2Xya/5GYUIAa/rOxLiAaAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1NM94xksOiht8RmgWrLEcFY3PgSHOoB3FnNWuwtEkT8=;
        b=RR/7QBvIbxloZJ72/et+BDVwGiprmISdjxT9fPyiPvDQDbINkJh624rNBoa9e6xiZp
         FAfNymdcXg7V73e807a5KTeAt77/u6sDhNnbG1Z19u7F79bAtFoQ2CaP4jzil5Yb7z85
         238BwnSTl+OqwOINwY4HfvYoDZTof5zSAqSLsbqhqum95+WxhLTe4CEADpbiCej/Px0E
         ehlxs8zHMZTW9HPax/6Mm1MT1ibAKsLwzluPjbjaeNuScYxiERQEvLofLdZW/i/bvTws
         gMJV37CaXTtcfapH02zqeVK229IbZ9J9RshVHWdsAFGJ5E8oCgzGnhdOTs/pEOGmJlMd
         PMow==
X-Gm-Message-State: APjAAAUpVtKmrjZnU0wrZceI856PhOS0zQ3CcfknlnvahvxMn3I6NXoN
        QMgeOT+vAZK9+BMeRoIpULvoug==
X-Google-Smtp-Source: APXvYqwUvaI7TTB3Cq1JrLcXYfbfWpzlEsBG0HdCSLwtiPUe8V7Jo54+xeveGTu2L+fiSxLgsLREgA==
X-Received: by 2002:a17:90a:3321:: with SMTP id m30mr23192445pjb.2.1566251538929;
        Mon, 19 Aug 2019 14:52:18 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id v8sm19341824pjb.6.2019.08.19.14.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 14:52:18 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:52:01 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        kernel list <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>,
        Daniel Colascione <dancol@google.com>, fmayer@google.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        kernel-team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>, namhyung@google.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 1/6] mm/page_idle: Add per-pid idle page tracking
 using virtual index
Message-ID: <20190819215201.GG117548@google.com>
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <CAG48ez0ysprvRiENhBkLeV9YPTN_MB18rbu2HDa2jsWo5FYR8g@mail.gmail.com>
 <20190813100856.GF17933@dhcp22.suse.cz>
 <CAG48ez2cuqe_VYhhaqw8Hcyswv47cmz2XmkqNdvkXEhokMVaXg@mail.gmail.com>
 <20190814075601.GO17933@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814075601.GO17933@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 09:56:01AM +0200, Michal Hocko wrote:
[snip]
> > > > Can this be used to observe which library pages other processes are
> > > > accessing, even if you don't have access to those processes, as long
> > > > as you can map the same libraries? I realize that there are already a
> > > > bunch of ways to do that with side channels and such; but if you're
> > > > adding an interface that allows this by design, it seems to me like
> > > > something that should be gated behind some sort of privilege check.
> > >
> > > Hmm, you need to be priviledged to get the pfn now and without that you
> > > cannot get to any page so the new interface is weakening the rules.
> > > Maybe we should limit setting the idle state to processes with the write
> > > status. Or do you think that even observing idle status is useful for
> > > practical side channel attacks? If yes, is that a problem of the
> > > profiler which does potentially dangerous things?
> > 
> > I suppose read-only access isn't a real problem as long as the
> > profiler isn't writing the idle state in a very tight loop... but I
> > don't see a usecase where you'd actually want that? As far as I can
> > tell, if you can't write the idle state, being able to read it is
> > pretty much useless.
> > 
> > If the profiler only wants to profile process-private memory, then
> > that should be implementable in a safe way in principle, I think, but
> > since Joel said that they want to profile CoW memory as well, I think
> > that's inherently somewhat dangerous.
> 
> I cannot really say how useful that would be but I can see that
> implementing ownership checks would be really non-trivial for
> shared pages. Reducing the interface to exclusive pages would make it
> easier as you noted but less helpful.
> 
> Besides that the attack vector shouldn't be really much different from
> the page cache access, right? So essentially can_do_mincore model.
> 
> I guess we want to document that page idle tracking should be used with
> care because it potentially opens a side channel opportunity if used
> on sensitive data.

I have been thinking of this, and discussing with our heap profiler folks.
Not being able to track shared pages would be a limitation, but I don't see
any way forward considering this security concern so maybe we have to
limit what we can do.

I will look into implementing this without doing the rmap but still make it
work on shared pages from the point of view of the process being tracked. It
just would no longer through the PTEs of *other* processes sharing the page.

My current thought is to just rely on the PTE accessed bit, and not use the
PageIdle flag at all. But we'd still set the PageYoung flag so that the
reclaim code still sees the page as accessed. The reason I feel like avoiding
the PageIdle flag is:

1. It looks like mark_page_accessed() can be called from other paths which
can also result in some kind of side-channel issue if a page was shared.

2. I don't think I need the PageIdle flag since the access bit alone should
let me know, although it could be a bit slower. Since previously, I did not
need to check every PTE and if the PageIdle flag was already cleared, then
the page was declared as idle.

At least this series resulted in a bug fix and a tonne of learning, so thank
you everyone!

Any other thoughts?

thanks,

 - Joel

