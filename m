Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E13A8309D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 13:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbfHFL0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 07:26:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34367 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbfHFL0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:26:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so37778545plt.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2019 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eQDxozI2qjukpUkcofnkYlDLvFKSd1P/XqoYuWp8Iko=;
        b=KdWHadNeW6pa2dnhFD6vGAJeFuZ4bU94l8h5hGmJoB6iVklb97AFdq2hkigQMM5/UW
         duwzf5xlAas4hj7F57fOHGW4Fbh0eAqKIwiEUMntWH0rzszBSsXQxg7vmdW0vXnYKvIV
         u177tjd2FQ7ASDBdqt2QwZ/5p/Ocdpipr0UPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eQDxozI2qjukpUkcofnkYlDLvFKSd1P/XqoYuWp8Iko=;
        b=GNlunPwruP5KfhHM+KPOti/Em0SePguK0xYnBVg++82rJVbOLD124+GW1EI1ol0Ops
         +rSbfmSeC3ubkAzsaKQCwzsxJXlDG1pn5hRIferY4+ozkSkAaVVvI3kcwyBzWWuy20Qe
         k5YQIgRkKZHMSCqCXiJuUdXsr7HhYlPA9/z97g/RLYcmGmPlxsTQKPwL1sEKpR4pOpzk
         otOrYpVb6nrrw9BZDXhIFovhXkp+3OfenGKj1Frm7IJt7zzTRLWzpwmChanHSY0IOqU4
         5CA+QFG7zg8k83ukapHwD2CvY9e/a1+OWygr1UzCbELFOEZ7+3l3kW2ya8e6uiNsaBCQ
         LMBg==
X-Gm-Message-State: APjAAAWGmHwiLFBqsnX7OhsIKPuUqDaBmO2g26QRP5hQG1aU3tTcoRGS
        TGeXPPnG+s7eEp4z4UCQXH0EtQ==
X-Google-Smtp-Source: APXvYqyhzcoKkLyUNInxKHTRQ0D58ehVR/MM5voEdZBk61kMSmPqKu2JfV8+IDkI8ipd4TE0B17EDQ==
X-Received: by 2002:a17:902:a413:: with SMTP id p19mr2767311plq.134.1565090768446;
        Tue, 06 Aug 2019 04:26:08 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h14sm113010833pfq.22.2019.08.06.04.26.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 04:26:07 -0700 (PDT)
Date:   Tue, 6 Aug 2019 07:26:06 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20190806112606.GC117316@google.com>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-3-joel@joelfernandes.org>
 <20190806084203.GJ11812@dhcp22.suse.cz>
 <20190806103627.GA218260@google.com>
 <20190806104755.GR11812@dhcp22.suse.cz>
 <20190806110737.GB32615@google.com>
 <20190806111452.GW11812@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806111452.GW11812@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 01:14:52PM +0200, Michal Hocko wrote:
> On Tue 06-08-19 20:07:37, Minchan Kim wrote:
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
> > 1. mark page-A idle which was present at that time.
> > 2. run workload
> > 3. page-A is touched several times
> > 4. *sudden* memory pressure happen so finally page A is finally swapped out
> > 5. now see the page A idle - but it's incorrect.
> 
> Could you expand on what you mean by idle exactly? Why pageout doesn't
> really qualify as "mark-idle and reclaim"? Also could you describe a
> usecase where the swapout distinction really matters and it would lead
> to incorrect behavior?

Michal,
Did you read this post ? :
https://lore.kernel.org/lkml/20190806104715.GC218260@google.com/T/#m4ece68ceaf6e54d4d29e974f5f4c1080e733f6c1

Just wanted to be sure you did not miss it.

thanks,

 - Joel

