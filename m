Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2E047237F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 10:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhLMJHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 04:07:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34418 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbhLMJHd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:07:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C2C67212B6;
        Mon, 13 Dec 2021 09:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639386451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VMBCo0yj1j9oM+G/voQUxLWpRVVSWcDd3r1fhg7XMuA=;
        b=VNz8dtMQAoK/45IDZsz5r1IojTGxEPlavzLk0/3csqZ6HQvWbcPTKGEHbFjZDQPyJd4+H/
        QSd2CeAE2q8H3Fd4Cx5NMmqbcF7yTtd5ZEP3uOYzgj7oUq5kofmSjnHFRDTOFDuhh1iCdu
        mTSUtesJfiPp1mCPBUnZP9o/g+tHiT4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BD5B9A3B87;
        Mon, 13 Dec 2021 09:07:30 +0000 (UTC)
Date:   Mon, 13 Dec 2021 10:07:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Alexey Avramov <hakavlad@inbox.lv>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        ValdikSS <iam@valdikss.org.ru>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        oleksandr@natalenko.name, kernel@xanmod.org, aros@gmx.com,
        hakavlad@gmail.com, Yu Zhao <yuzhao@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, hdanton@sina.com,
        riel@surriel.com, Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working
 set
Message-ID: <YbcNUEZ08lmbv0RM@dhcp22.suse.cz>
References: <20211130201652.2218636d@mail.inbox.lv>
 <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
 <20211202135824.33d2421bf5116801cfa2040d@linux-foundation.org>
 <20211213051521.21f02dd2@mail.inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213051521.21f02dd2@mail.inbox.lv>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-12-21 05:15:21, Alexey Avramov wrote:
> So, the problem described by Artem S. Tashkinov in 2019 is still easily 
> reproduced in 2021. The assurances of the maintainers that they consider 
> the thrashing and near-OOM stalls to be a serious problems are difficult to 
> take seriously while they ignore the obvious solution: if reclaiming file 
> caches leads to thrashing, then you just need to prohibit deleting the file 
> cache. And allow the user to control its minimum amount.

These are rather strong claims. While this might sound like a very easy
solution/workaround I have already tried to express my concerns [1].

Really, you should realize that such a knob would become carved
into stone as soon as wee merge this and we will need to support it
for ever! It is really painful (if possible at all) to deprecate any
tunable knobs that cannot be supported anymore because the underlying
implementation doesn't allow for that.  So we would absolutely need to
be sure this is the right approach to the problem.  I am not convinced
about that though.

How does the admin know the limit should be set to a certain
workload? What if the workload characteristics change and the existing
setting is just to restrictive? What if the workload istrashing over
something different than anon/file memory (e.g. any other cache that we
have or might have in the future)?

As you have pointed out there were general recommendations to use user
space based oom killer solutions which can be tuned for the specific
workload or used in an environment where the disruptive OOM killer
action is less of a problem because workload can be restarted easily
without too much harm caused by the oom killer.
Please keep in mind that there are many more different workloads that
have different requirements and an oom killer invocation can be really
much worse than a slow progress due to ephemeral, peak or even longer
term trashing or heavy refaults.

The kernel OOM killer acts as the last resort solution and therefore
stays really conservative. I do believe that integrating PSI metrics
into that decision is the right direction. It is not a trivial one
though.

Why is this better approach than a simple limit? Well, for one, it is a
feedback based solution. System knows it is trashing and can estimate
how hard. It is not about a specific type of memory because we can
detect refaults on both file and anonymous memory (it can be extended
should there be a need for future types of caches or reclaimable
memory). Memory reclaim can work with that information and balance
differen resources dynamically based on the available feedback. MM code
will not need to expose implementation details about how the reclaim
works and so we do not bind ourselves into longterm specifics.

See the difference?

If you can live with pre-mature and over-eager OOM killer policy then
all fine. Use existing userspace solutions. If you want to work on an in
kernel solution please try to understand complexity and historical
experience with similar solution first. It also helps to understand that
there are no simple solutions on the table. MM reclaim code has evolved
over many years. I am strongly suspecting we ran out of simple solutions
already. We also got burnt many times. Let's not repeat some errors
again.

[1] http://lkml.kernel.org/r/Ya3fG2rp+860Yb+t@dhcp22.suse.cz

-- 
Michal Hocko
SUSE Labs
