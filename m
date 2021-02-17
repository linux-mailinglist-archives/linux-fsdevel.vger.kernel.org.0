Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5807531D96F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 13:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhBQMbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 07:31:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:32790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhBQMby (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:31:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613565067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qCkWcaAIuGTOOzMzdQxcjrBbYQwzwohyHCld2DLzlo4=;
        b=hh+tsDg+FIBbpUSHQMfb7zlfE5pOiF3gulNxaSo443OCHghvQqPq7Vr2xB1AfHk9jN9nWu
        ndNZVR3Nh9don4KIexkJuV39C/FVEAPTC+fbJCaLUR6yjDzxXs0TL7+5+icb//OfeGbmGS
        5/ddq8XqsIY0aKRw4Tq5/mPjWD63Ct0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40A7BB9E4;
        Wed, 17 Feb 2021 12:31:07 +0000 (UTC)
Date:   Wed, 17 Feb 2021 13:31:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
Message-ID: <YC0MiqwCGp90Oj4N@dhcp22.suse.cz>
References: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
 <YCt+cVvWPbWvt2rG@dhcp22.suse.cz>
 <bb3508e7-48d1-fa1b-f1a0-7f42be55ed9c@oracle.com>
 <YCzMVa5QSyUtlmnI@dhcp22.suse.cz>
 <D66DC6A7-C708-4888-8FCF-E4EB0F90ED48@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D66DC6A7-C708-4888-8FCF-E4EB0F90ED48@nutanix.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-02-21 10:42:24, Eiichi Tsukata wrote:
> Hi All,
> 
> Firstly, thank you for your careful review and attention to my patch
> (and apologies for top-posting!).  Let me first explain why our use
> case requires hugetlb over THP and then elaborate on the difficulty we
> have to maintain the correct number of hugepages in the pool, finally
> concluding with why the proposed approach would help us. Hopefully you
> can extend it to other use cases and justify the proposal.
> 
> We use Linux to operate a KVM-based hypervisor. Using hugepages to
> back VM memory significantly increases performance and density. Each
> VM incurs a 4k regular page overhead which can vary drastically even
> at runtime (eg. depending on network traffic). In addition, the
> software doesn't know upfront if users will power on one large VM or
> several small VMs.
> 
> To manage the varying balance of 4k pages vs. hugepages, we originally
> leveraged THP. However, constant fragmentation due to VM power cycles,
> the varying overhead I mentioned above, and other operations like
> reconfiguration of NIC RX buffers resulted in two problems:
> 1) There were no guarantees hugepages would be used; and
> 2) Constant memory compaction incurred a measurable overhead.
> 
> Having a userspace service managing hugetlb gave us significant
> performance advantages and much needed determinism. It chooses when to
> try and create more hugepages as well as how many hugepages to go
> after. Elements like how many hugepages it actually gets, combined
> with what operations are happening on the host, allow our service to
> make educated decisions about when to compact memory, drop caches, and
> retry growing (or shrinking) the pool.

OK, thanks for the clarification. Just to make sure I understand. This
means that you are pro-activelly and optimistically pre-allocate hugetlb
pages even when there is no immediate need for those, right?

> But that comes with a challenge: despite listening on cgroup for
> pressure notifications (which happen from those runtime events we do
> not control),

We do also have global pressure (PSI) counters. Have you tried to look
into those and try to back off even when the situation becomes critical?

> the service is not guaranteed to sacrifice hugepages
> fast enough and that causes an OOM. The killer will normally take out
> a VM even if there are plenty of unused hugepages and that's obviously
> disruptive for users. For us, free hugepages are almost always expendable.
> 
> For the bloat cases which are predictable, a memory management service
> can adjust the hugepage pool size ahead of time. But it can be hard to
> anticipate all scenarios, and some can be very volatile. Having a
> failsafe mechanism as proposed in this patch offers invaluable
> protection when things are missed.
> 
> The proposal solves this problem by sacrificing hugepages inline even
> when the pressure comes from kernel allocations. The userspace service
> can later readjust the pool size without being under pressure. Given
> this is configurable, and defaults to being off, we thought it would
> be a nice addition to the kernel and appreciated by other users that
> may have similar requirements.

Thanks for your usecase description. It helped me to understand what you
are doing and how this can be really useful for your particular setup.
This is really a very specific situation from my POV. I am not yet sure
this is generic enough to warrant for a yet another tunable. One thing
you can do [1] is to
hook into oom notifiers interface (register_oom_notifier) and release
pages from the callback. Why is that batter than a global tunable?
For one thing you can make the implementation tailored to your specific
usecase. As the review feedback has shown this would be more tricky to
be done in a general case. Unlike a generic solution it would allow you
to coordinate with your userspace if you need. Would something like that
work for you?

---
[1] and I have to say I hate myself for suggesting that because I was
really hoping this interface would go away. But the reality disagrees so
I gave up on that goal...
-- 
Michal Hocko
SUSE Labs
