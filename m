Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE3B83345
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 15:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfHFNs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 09:48:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37952 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHFNs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:48:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id az7so37878007plb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2019 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UkgbsLvaM9M+9IVDtc/oOOdmfQ/azKwIM6sOgM9Uo6A=;
        b=v5SqwqpAWWpP6genLek7yXSgtt0oPKJl2yiJUqIkB+Hk2eUQj7QLyIcD1XsDGstAc5
         IJkt3gp1qpEOfjNBQpPOwAd5yNG05Ffu4XLeiSvOoI0x7cPpb94LS72yjIf2hnzn6YOx
         2eAXCFGilolW4vTWkjq9c+4jJit9X65nKibSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UkgbsLvaM9M+9IVDtc/oOOdmfQ/azKwIM6sOgM9Uo6A=;
        b=tUcDhnNETAP1P2/aqwsK/K8HnHLnJd3XAVxqihqBv1OMPsqYOcMqJnNRP4BY+tpQ3o
         AvTM17+dyXHG4c8Gray3hY38BZEVrFDoAhKaX+6zeVKvFU/pKh8LtF84Z+C9F8XtwctJ
         nwCJ+pQ3lPEi8jVN6/Uarga3pv4te6nix17x12U8ia3PMLgur2kF8DJmpFxRCMgMU7mZ
         RtZE6a4JL6wLUASMrqrUetFqfHNy8U0Bn57wgiho4B/YHMfIfBEi6k3VBgiGs2imiuNa
         6rI7D5rrTd9xnO/EIHl9sS5800pqV0v4Kf0m4lynbumQYBD1qmLz7QT4BS6f5RPjqbPx
         Hm/g==
X-Gm-Message-State: APjAAAXNGM3bn5Rnw6PmlmUURf6dW8NcTSxm4DN6RiFE3UoitewEjF/R
        TUd9yjEqwPHblEy56yo6I9KsFg==
X-Google-Smtp-Source: APXvYqxgW81Bh2gp7NfuMEuRgXEMzo82PKr8YV24UjJAd/l8I+5fzMkYsTUGjI8mWOY9506/uxTouQ==
X-Received: by 2002:a17:902:7c05:: with SMTP id x5mr3338168pll.321.1565099336115;
        Tue, 06 Aug 2019 06:48:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a3sm22037629pje.3.2019.08.06.06.48.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 06:48:55 -0700 (PDT)
Date:   Tue, 6 Aug 2019 09:48:53 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
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
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 4/5] page_idle: Drain all LRU pagevec before idle
 tracking
Message-ID: <20190806134853.GB15167@google.com>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-4-joel@joelfernandes.org>
 <20190806084357.GK11812@dhcp22.suse.cz>
 <20190806104554.GB218260@google.com>
 <20190806105149.GT11812@dhcp22.suse.cz>
 <20190806111921.GB117316@google.com>
 <20190806114402.GX11812@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806114402.GX11812@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 01:44:02PM +0200, Michal Hocko wrote:
[snip]
> > > > This operation even if expensive is only done once during the access of the
> > > > page_idle file. Did you have a better fix in mind?
> > > 
> > > Can we set the idle bit also for non-lru pages as long as they are
> > > reachable via pte?
> > 
> > Not at the moment with the current page idle tracking code. PageLRU(page)
> > flag is checked in page_idle_get_page().
> 
> yes, I am aware of the current code. I strongly suspect that the PageLRU
> check was there to not mark arbitrary page looked up by pfn with the
> idle bit because that would be unexpected. But I might be easily wrong
> here.

Yes, quite possible.

> > Even if we could set it for non-LRU, the idle bit (page flag) would not be
> > cleared if page is not on LRU because page-reclaim code (page_referenced() I
> > believe) would not clear it.
> 
> Yes, it is either reclaim when checking references as you say but also
> mark_page_accessed. I believe the later might still have the page on the
> pcp LRU add cache. Maybe I am missing something something but it seems
> that there is nothing fundamentally requiring the user mapped page to be
> on the LRU list when seting the idle bit.
> 
> That being said, your big hammer approach will work more reliable but if
> you do not feel like changing the underlying PageLRU assumption then
> document that draining should be removed longterm.

Yes, at the moment I am in preference of keeping the underlying assumption
same. I am Ok with adding of a comment on the drain call that it is to be
removed longterm.

thanks,

 - Joel

