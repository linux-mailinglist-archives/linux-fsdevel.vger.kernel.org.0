Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F080783504
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 17:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbfHFPUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 11:20:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44685 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbfHFPUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:20:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so41651096pfe.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2019 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DLr/S8jU71563TTjt3V9DdQkFNfZZ9GpEDLqJqyThL8=;
        b=WLX9eAV+Do9txkuh9FQp3qtI2mkb3uS6AWtl5v+D2s68dxeCFgLT8Mu0dlFrU308LQ
         sC+N27xnuwSrtm+Fkx/n/0WT6ocS2hECqVMaOg2jUc5fvRrC59LIGmFPN9Vp9gF1OGo6
         EbYSi32+OEJ6Oq5K3W2+BSQeACoJmAG4Q1XEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DLr/S8jU71563TTjt3V9DdQkFNfZZ9GpEDLqJqyThL8=;
        b=foFCv3F0STldNxW/ph7s2TuH/qpZP6i0zRdd4usc9QDVo/T4bCSPZ/o1UEk5/M2k6f
         IphLso8VmAoMsxyFZft86UBvl8NmLTx9aFiLRHTzTK8V7tk1LK90v8iThxgiqmV2MD9H
         NKTdhQcG5J+IkUQjg05luwlHewUw9Yi5QUMs2RWhoklDguDoaxQn/h7MhKAygnpMZTW5
         9iy5t75k5O6LBt95+lqA3bTG9FMOO7L5pje2hSgadu8ovMsIV2jkuq6xxeRCoAVQzdxt
         ZNth6a5Hd3mrCYoOVlOoyDlUJCeYWrJzh14QQNNQD0+nBkcRCC+QUZRkvbyEKVS/ieSy
         tv2A==
X-Gm-Message-State: APjAAAVdfV8aW7JuI+euM3v7pgmdIwqKlntjcJs9weZiI20Rtdr1U9F4
        17rnatO9U+ufhd/Jw6sH26wDNg==
X-Google-Smtp-Source: APXvYqxVQuc55AKHRFXAeMJAi3UPCUUUsl8H3gf0xO9Gg7+Z0EfVEsgvhGQKwjSNvREljAcS14pVrA==
X-Received: by 2002:a17:90a:8d09:: with SMTP id c9mr3784595pjo.131.1565104803991;
        Tue, 06 Aug 2019 08:20:03 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s5sm71081936pfm.97.2019.08.06.08.20.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 08:20:02 -0700 (PDT)
Date:   Tue, 6 Aug 2019 11:20:01 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
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
        Mike Rapoport <rppt@linux.ibm.com>, namhyung@google.com,
        paulmck@linux.ibm.com, Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 3/5] [RFC] arm64: Add support for idle bit in swap PTE
Message-ID: <20190806152001.GA39951@google.com>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-3-joel@joelfernandes.org>
 <20190806084203.GJ11812@dhcp22.suse.cz>
 <20190806103627.GA218260@google.com>
 <20190806104755.GR11812@dhcp22.suse.cz>
 <20190806111446.GA117316@google.com>
 <20190806115703.GY11812@dhcp22.suse.cz>
 <20190806144747.GA72938@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806144747.GA72938@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 11:47:47PM +0900, Minchan Kim wrote:
> On Tue, Aug 06, 2019 at 01:57:03PM +0200, Michal Hocko wrote:
> > On Tue 06-08-19 07:14:46, Joel Fernandes wrote:
> > > On Tue, Aug 06, 2019 at 12:47:55PM +0200, Michal Hocko wrote:
> > > > On Tue 06-08-19 06:36:27, Joel Fernandes wrote:
> > > > > On Tue, Aug 06, 2019 at 10:42:03AM +0200, Michal Hocko wrote:
> > > > > > On Mon 05-08-19 13:04:49, Joel Fernandes (Google) wrote:
> > > > > > > This bit will be used by idle page tracking code to correctly identify
> > > > > > > if a page that was swapped out was idle before it got swapped out.
> > > > > > > Without this PTE bit, we lose information about if a page is idle or not
> > > > > > > since the page frame gets unmapped.
> > > > > > 
> > > > > > And why do we need that? Why cannot we simply assume all swapped out
> > > > > > pages to be idle? They were certainly idle enough to be reclaimed,
> > > > > > right? Or what does idle actualy mean here?
> > > > > 
> > > > > Yes, but other than swapping, in Android a page can be forced to be swapped
> > > > > out as well using the new hints that Minchan is adding?
> > > > 
> > > > Yes and that is effectivelly making them idle, no?
> > > 
> > > That depends on how you think of it.
> > 
> > I would much prefer to have it documented so that I do not have to guess ;)
> > 
> > > If you are thinking of a monitoring
> > > process like a heap profiler, then from the heap profiler's (that only cares
> > > about the process it is monitoring) perspective it will look extremely odd if
> > > pages that are recently accessed by the process appear to be idle which would
> > > falsely look like those processes are leaking memory. The reality being,
> > > Android forced those pages into swap because of other reasons. I would like
> > > for the swapping mechanism, whether forced swapping or memory reclaim, not to
> > > interfere with the idle detection.
> > 
> > Hmm, but how are you going to handle situation when the page is unmapped
> > and refaulted again (e.g. a normal reclaim of a pagecache)? You are
> > losing that information same was as in the swapout case, no? Or am I
> > missing something?
> 
> If page is unmapped, it's not a idle memory any longer because it's
> free memory. We could detect the pte is not present.

I think Michal is not talking of explictly being unmapped, but about the case
where a file-backed mapped page is unmapped due to memory pressure ? This is
similar to the swap situation.

Basically... file page is marked idle, then it is accessed by userspace. Then
memory pressure drops it off the page cache so the idle information is lost.
Next time we check the page_idle, we miss that it was accessed indeed.

It is not an issue for the heap profiler or anonymous memory per-se. But is
similar to the swap situation.

> If page is refaulted, it's not a idle memory any longer because it's
> accessed again. We could detect it because the newly allocated page
> doesn't have a PG_idle page flag.

In the refault case, yes it should not be a problem.

thanks,

 - Joel

