Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4AA8332D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 15:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732907AbfHFNnk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 09:43:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32868 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732835AbfHFNnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:43:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so41545113pfq.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2019 06:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IvbA0Qi9ZdVQqNSbxozysL3Fqa9OBFyiiqy53wDpULw=;
        b=UuDLXvSXeYwo63iVf+Lu0ahwvUcYOzu27p9dcgydbmlpy6nzua+tt9PNukjSS6Be4q
         vRcxA4E5INCnPKwSUPg3krigp8ll/UXfu4lFBciOfQ91x+tJtxsbDAGtnGkpWU6B/HJH
         mkzPwEGTE+qSwX2QK3R1MvFtovwBfdLF5sBXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IvbA0Qi9ZdVQqNSbxozysL3Fqa9OBFyiiqy53wDpULw=;
        b=KWPm+AvtlVOb5U5ZDwR8GuPQ7mGB6AQQxz1RE1mr052grnkMih5CrIGBYR7aMeA9i1
         NG4V5fJuElRKdgc0Srq6u9qB/XZUvh/uPLoCyLTNW6votiyjLysUM5b0gxMTA1pMv6pO
         /i51mClHW0k467pkhGuICT98j07w0PniO1oGJD/VDECM0FeahNTkCFXz1IjE92fAQ0w1
         OOLDb5hDpIJ+VC9JvFDFz2jhfEt+RqUL38LaMN8RpozQz+pUpzLsXjPJ67GqbzJZN9IK
         k2xQPY/Qie1CSU8hppRrm5qvfYbL4BNTvfAL5+CcofRZUgj+ebD4ORhmBkfxPcUkuQDS
         zlQA==
X-Gm-Message-State: APjAAAUwsBsiTCrvcFzlGIyxpLkFdBKil1nvnB+9BdKx63V9mie0UXN8
        qrif+UnGTTVkjT3Ho0nj36gmvQ==
X-Google-Smtp-Source: APXvYqw8mKqZ/XeNBFb/10DncPVZsFq6EPDftOF3wo4TDqzt8e9GiUU74z85gx7FrtAqaFlq2j2rPw==
X-Received: by 2002:a62:6454:: with SMTP id y81mr3622264pfb.13.1565099003926;
        Tue, 06 Aug 2019 06:43:23 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b37sm44764722pjc.15.2019.08.06.06.43.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 06:43:23 -0700 (PDT)
Date:   Tue, 6 Aug 2019 09:43:21 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 3/5] [RFC] arm64: Add support for idle bit in swap PTE
Message-ID: <20190806134321.GA15167@google.com>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-3-joel@joelfernandes.org>
 <20190806084203.GJ11812@dhcp22.suse.cz>
 <20190806103627.GA218260@google.com>
 <20190806104755.GR11812@dhcp22.suse.cz>
 <20190806111446.GA117316@google.com>
 <20190806115703.GY11812@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806115703.GY11812@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 01:57:03PM +0200, Michal Hocko wrote:
> On Tue 06-08-19 07:14:46, Joel Fernandes wrote:
> > On Tue, Aug 06, 2019 at 12:47:55PM +0200, Michal Hocko wrote:
> > > On Tue 06-08-19 06:36:27, Joel Fernandes wrote:
> > > > On Tue, Aug 06, 2019 at 10:42:03AM +0200, Michal Hocko wrote:
> > > > > On Mon 05-08-19 13:04:49, Joel Fernandes (Google) wrote:
> > > > > > This bit will be used by idle page tracking code to correctly identify
> > > > > > if a page that was swapped out was idle before it got swapped out.
> > > > > > Without this PTE bit, we lose information about if a page is idle or not
> > > > > > since the page frame gets unmapped.
> > > > > 
> > > > > And why do we need that? Why cannot we simply assume all swapped out
> > > > > pages to be idle? They were certainly idle enough to be reclaimed,
> > > > > right? Or what does idle actualy mean here?
> > > > 
> > > > Yes, but other than swapping, in Android a page can be forced to be swapped
> > > > out as well using the new hints that Minchan is adding?
> > > 
> > > Yes and that is effectivelly making them idle, no?
> > 
> > That depends on how you think of it.
> 
> I would much prefer to have it documented so that I do not have to guess ;)

Sure :)

> > If you are thinking of a monitoring
> > process like a heap profiler, then from the heap profiler's (that only cares
> > about the process it is monitoring) perspective it will look extremely odd if
> > pages that are recently accessed by the process appear to be idle which would
> > falsely look like those processes are leaking memory. The reality being,
> > Android forced those pages into swap because of other reasons. I would like
> > for the swapping mechanism, whether forced swapping or memory reclaim, not to
> > interfere with the idle detection.
> 
> Hmm, but how are you going to handle situation when the page is unmapped
> and refaulted again (e.g. a normal reclaim of a pagecache)? You are
> losing that information same was as in the swapout case, no? Or am I
> missing something?

Yes you are right, it would have the same issue, thanks for bringing it up.
Should we rename this bit to PTE_IDLE and do the same thing that we are doing
for swap?

i.e. if (page_idle(page)) and page is a file page, then we write state
into the PTE of the page. Later on refault, the PTE bit would automatically
get cleared (just like it does on swap-in). But before refault, the idle
tracking code sees the page as still marked idle. Do you see any issue with that?


> > This is just an effort to make the idle tracking a little bit better. We
> > would like to not lose the 'accessed' information of the pages.
> > 
> > Initially, I had proposed what you are suggesting as well however the above
> > reasons made me to do it like this. Also Minchan and Konstantin suggested
> > this, so there are more people interested in the swap idle bit. Minchan, can
> > you provide more thoughts here? (He is on 2-week vacation from today so
> > hopefully replies before he vanishes ;-)).
> 
> We can move on with the rest of the series in the mean time but I would
> like to see a proper justification for the swap entries and why they
> should be handled special.

Ok, I will improve the changelog.


> > Also assuming all swap pages as idle has other "semantic" issues. It is quite
> > odd if a swapped page is automatically marked as idle without userspace
> > telling it to. Consider the following set of events: 1. Userspace marks only
> > a certain memory region as idle. 2. Userspace reads back the bits
> > corresponding to a bigger region. Part of this bigger region is swapped.
> > Userspace expects all of the pages it did not mark, to have idle bit set to
> > '0' because it never marked them as idle. However if it is now surprised by
> > what it read back (not all '0' read back). Since a page is swapped, it will
> > be now marked "automatically" as idle as per your proposal, even if userspace
> > never marked it explicity before. This would be quite confusing/ambiguous.
> 
> OK, I see. I guess the primary question I have is how do you distinguish
> Idle page which got unmapped and faulted in again from swapped out page
> and refaulted - including the time the pte is not present.

Ok, lets discuss more.

thanks Michal!

 - Joel

