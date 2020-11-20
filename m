Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1750C2BA65C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 10:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgKTJjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 04:39:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:53966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgKTJjP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:39:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605865153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mzFwa4uF4sflYlaTRsoZJ0QNiCboZylJJW1JEuNMfaQ=;
        b=OIvHhvW5sGymGR+I4Hc9tB/5ZE0OZK1hzZHygovuHVWtTmoOeoHjt4ep613RAIKn5cHD6N
        lqy/sHOYVMDxNu5KV1CfSGqmSWjxGGjsa9bAaBTDiY+WpSFF6neEdR9c0w2fqeoSAZV0iK
        FaOysJ/gsfkk6BqfWjl2dPhEGfgpcVA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 890E6AC23;
        Fri, 20 Nov 2020 09:39:13 +0000 (UTC)
Date:   Fri, 20 Nov 2020 10:39:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/21] Free some vmemmap pages of hugetlb page
Message-ID: <20201120093912.GM3200@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz>
 <6b1533f7-69c6-6f19-fc93-c69750caaecc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b1533f7-69c6-6f19-fc93-c69750caaecc@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 10:27:05, David Hildenbrand wrote:
> On 20.11.20 09:42, Michal Hocko wrote:
> > On Fri 20-11-20 14:43:04, Muchun Song wrote:
> > [...]
> > 
> > Thanks for improving the cover letter and providing some numbers. I have
> > only glanced through the patchset because I didn't really have more time
> > to dive depply into them.
> > 
> > Overall it looks promissing. To summarize. I would prefer to not have
> > the feature enablement controlled by compile time option and the kernel
> > command line option should be opt-in. I also do not like that freeing
> > the pool can trigger the oom killer or even shut the system down if no
> > oom victim is eligible.
> > 
> > One thing that I didn't really get to think hard about is what is the
> > effect of vmemmap manipulation wrt pfn walkers. pfn_to_page can be
> > invalid when racing with the split. How do we enforce that this won't
> > blow up?
> 
> I have the same concerns - the sections are online the whole time and
> anybody with pfn_to_online_page() can grab them
> 
> I think we have similar issues with memory offlining when removing the
> vmemmap, it's just very hard to trigger and we can easily protect by
> grabbing the memhotplug lock.

I am not sure we can/want to span memory hotplug locking out to all pfn
walkers. But you are right that the underlying problem is similar but
much harder to trigger because vmemmaps are only removed when the
physical memory is hotremoved and that happens very seldom. Maybe it
will happen more with virtualization usecases. But this work makes it
even more tricky. If a pfn walker races with a hotremove then it would
just blow up when accessing the unmapped physical address space. For
this feature a pfn walker would just grab a real struct page re-used for
some unpredictable use under its feet. Any failure would be silent and
hard to debug.

[...]
> To keep things easy, maybe simply never allow to free these hugetlb pages
> again for now? If they were reserved during boot and the vmemmap condensed,
> then just let them stick around for all eternity.

Not sure I understand. Do you propose to only free those vmemmap pages
when the pool is initialized during boot time and never allow to free
them up? That would certainly make it safer and maybe even simpler wrt
implementation.

-- 
Michal Hocko
SUSE Labs
