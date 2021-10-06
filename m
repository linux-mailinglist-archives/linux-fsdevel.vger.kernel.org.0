Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68CF4239BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 10:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhJFI3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 04:29:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45894 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhJFI3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:29:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 44FB4224C1;
        Wed,  6 Oct 2021 08:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633508877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E/6HtAb0SdSz7BkiP3vnxEjZN89ZpTwbmcif+6QXT1Q=;
        b=nYikioOxXuZDyMI2sYHhQLYKpRyOPJyfYTgw8c4byiW5NZrEE2NXTV2v+Bmy/HAV0eGbWh
        Xb0WUCm2D+Nwnl/kBGP8MWT+q7SF+YsECSF9OALaQJASEGMuTqOPL8jKW/pXEXlSd+uZ94
        bWI8FW7y+23ZFbOJnkXy9RhICCpPsIg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 38B8DA3B8A;
        Wed,  6 Oct 2021 08:27:55 +0000 (UTC)
Date:   Wed, 6 Oct 2021 10:27:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Message-ID: <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
References: <20211001205657.815551-1-surenb@google.com>
 <20211001205657.815551-3-surenb@google.com>
 <20211005184211.GA19804@duo.ucw.cz>
 <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
 <20211005200411.GB19804@duo.ucw.cz>
 <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
 <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 05-10-21 23:57:36, John Hubbard wrote:
[...]
> 1) Yes, just leave the strings in the kernel, that's simple and
> it works, and the alternatives don't really help your case nearly
> enough.

I do not have a strong opinion. Strings are easier to use but they
are more involved and the necessity of kref approach just underlines
that. There are going to be new allocations and that always can lead
to surprising side effects.  These are small (80B at maximum) so the
overall footpring shouldn't all that large by default but it can grow
quite large with a very high max_map_count. There are workloads which
really require the default to be set high (e.g. heavy mremap users). So
if anything all those should be __GFP_ACCOUNT and memcg accounted.

I do agree that numbers are just much more simpler from accounting,
performance and implementation POV.

> The kernel changes at a different rate than distros and
> user space, and keeping number->string mappings updated and correct
> is just basically hopeless.

I am not sure I follow here. This all looks like a userspace policy. No
matter what kind of id you use. It is userspace to set and consume those
ids. Why is it different to use strings from numbers. All parties have
to agree in a naming/numbering convention anyway. Those might differ on
Android or other userspaces. What am I missing?

> And you've beaten down the perf problems with kref, so it's fine.
> 
> 2) At the same time, this feature is Just Not Needed! ...usually.
> So the config option seems absolutely appropriate.

This is not really an answer. Most users are using a distro kernel so
this would need to be enabled in those configs just in case.

-- 
Michal Hocko
SUSE Labs
