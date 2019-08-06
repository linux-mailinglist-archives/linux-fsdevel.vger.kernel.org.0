Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB6982FF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 12:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbfHFKp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 06:45:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34400 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732515AbfHFKp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:45:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so35163884pgc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2019 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ABKgADdiGa23iy+5xy09f6OBQqR3I/07f0qdbQrp2Ug=;
        b=BK0x5edz5Iheer/fK6xR02+EYpWEe73+fBNaVu3psDyEfFgQR4iTDEjMX3llLyVbBQ
         oo5c2wtKKMdHq+s0dbGvvCrA28tZJ7WgRbNvmF9B9TCPhzQEMI365I16VRvzSe8CiyqZ
         ulIdft17U/LPUUnWy2+R0724GxrzxbZjJPUj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ABKgADdiGa23iy+5xy09f6OBQqR3I/07f0qdbQrp2Ug=;
        b=svCUw1hWFn/5Qm4nx0bP4xEw2vD7ZjjVFlubQDiD8ELbRNv9526AtfRDS9V0J5kzcE
         rwfVA/9T13c8hNek4poT1vX+eNd5g6YZ90LL2gcGpXLvcAKVf56t++WkAkaL2ro+5T4/
         obSWYR0hMkSFPuHed0JwHaaX5DPd86wdUJ4xqjJijfjuwhQ93ngzpf9lhUyHdQfbLOB+
         8exYBoyL1cj6tb2gEOYMMCIbgfplEoNkIkZG9CnQ2zVtqom4d1818bjJlzhfN7RwdFcy
         EOHvFmQpniAeZxdHRA/gKUmFGYkc1HhSE+JnPZ1Y2/LLfw48Yeb2AjuYkFEJFNAUOLXI
         V3IA==
X-Gm-Message-State: APjAAAVofxwMFCm5AW3XUuuKENU3wiNAlPRqug/5gwyxe3y3FHC5TVRd
        f4u5ZrjsEoQjYWhoOlZtc+ZzGg==
X-Google-Smtp-Source: APXvYqyKhAOOvSnRzmdX9OiAK7Cu7h4b/c73qpWbsn3JUV5APW6ELiBP2MjwevD8QijB6PWnNqvwJA==
X-Received: by 2002:aa7:90d4:: with SMTP id k20mr2919746pfk.78.1565088356112;
        Tue, 06 Aug 2019 03:45:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b126sm126571952pfa.126.2019.08.06.03.45.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 03:45:55 -0700 (PDT)
Date:   Tue, 6 Aug 2019 06:45:54 -0400
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
Message-ID: <20190806104554.GB218260@google.com>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-4-joel@joelfernandes.org>
 <20190806084357.GK11812@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806084357.GK11812@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 10:43:57AM +0200, Michal Hocko wrote:
> On Mon 05-08-19 13:04:50, Joel Fernandes (Google) wrote:
> > During idle tracking, we see that sometimes faulted anon pages are in
> > pagevec but are not drained to LRU. Idle tracking considers pages only
> > on LRU. Drain all CPU's LRU before starting idle tracking.
> 
> Please expand on why does this matter enough to introduce a potentially
> expensinve draining which has to schedule a work on each CPU and wait
> for them to finish.

Sure, I can expand. I am able to find multiple issues involving this. One
issue looks like idle tracking is completely broken. It shows up in my
testing as if a page that is marked as idle is always "accessed" -- because
it was never marked as idle (due to not draining of pagevec).

The other issue shows up as a failure in my "swap test", with the following
sequence:
1. Allocate some pages
2. Write to them
3. Mark them as idle                                    <--- fails
4. Introduce some memory pressure to induce swapping.
5. Check the swap bit I introduced in this series.      <--- fails to set idle
                                                             bit in swap PTE.

Draining the pagevec in advance fixes both of these issues.

This operation even if expensive is only done once during the access of the
page_idle file. Did you have a better fix in mind?

thanks,

 - Joel


> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  mm/page_idle.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/mm/page_idle.c b/mm/page_idle.c
> > index a5b00d63216c..2972367a599f 100644
> > --- a/mm/page_idle.c
> > +++ b/mm/page_idle.c
> > @@ -180,6 +180,8 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
> >  	unsigned long pfn, end_pfn;
> >  	int bit, ret;
> >  
> > +	lru_add_drain_all();
> > +
> >  	ret = page_idle_get_frames(pos, count, NULL, &pfn, &end_pfn);
> >  	if (ret == -ENXIO)
> >  		return 0;  /* Reads beyond max_pfn do nothing */
> > @@ -211,6 +213,8 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
> >  	unsigned long pfn, end_pfn;
> >  	int bit, ret;
> >  
> > +	lru_add_drain_all();
> > +
> >  	ret = page_idle_get_frames(pos, count, NULL, &pfn, &end_pfn);
> >  	if (ret)
> >  		return ret;
> > @@ -428,6 +432,8 @@ ssize_t page_idle_proc_generic(struct file *file, char __user *ubuff,
> >  	walk.private = &priv;
> >  	walk.mm = mm;
> >  
> > +	lru_add_drain_all();
> > +
> >  	down_read(&mm->mmap_sem);
> >  
> >  	/*
> > -- 
> > 2.22.0.770.g0f2c4a37fd-goog
> 
> -- 
> Michal Hocko
> SUSE Labs
