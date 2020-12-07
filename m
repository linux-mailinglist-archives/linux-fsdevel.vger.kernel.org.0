Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E582D18A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 19:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgLGSjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 13:39:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:40950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgLGSjB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:39:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89856AD63;
        Mon,  7 Dec 2020 18:38:19 +0000 (UTC)
Date:   Mon, 7 Dec 2020 19:38:14 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, bp@alien8.de, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        pawan.kumar.gupta@linux.intel.com, mchehab+huawei@kernel.org,
        paulmck@kernel.org, viro@zeniv.linux.org.uk,
        Peter Zijlstra <peterz@infradead.org>, luto@kernel.org,
        oneukum@suse.com, jroedel@suse.de,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        anshuman.khandual@arm.com, Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v7 00/15] Free some vmemmap pages of
 hugetlb page
Message-ID: <20201207183814.GA3786@localhost.localdomain>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <CAMZfGtWvLEytN5gBN+OqntrNXNd3eNRWrfnkeCozvARmpTNAXw@mail.gmail.com>
 <600fd7e2-70b4-810f-8d12-62cba80af80d@oracle.com>
 <CAMZfGtX2mu1tyE_898mQeEpmP4Pd+rEKOHpYF=KN=5v4WExpig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtX2mu1tyE_898mQeEpmP4Pd+rEKOHpYF=KN=5v4WExpig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 04, 2020 at 11:39:31AM +0800, Muchun Song wrote:
> On Fri, Dec 4, 2020 at 7:49 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > As previously mentioned, I feel qualified to review the hugetlb changes
> > and some other closely related changes.  However, this patch set is
> > touching quite a few areas and I do not feel qualified to make authoritative
> > statements about them all.  I too hope others will take a look.
> 
> Agree. I also hope others can take a look at other modules(e.g.
> sparse-vmemmap, memory-hotplug). Thanks for everyone's efforts
> on this.

I got sidetracked by some other stuff but I plan to continue reviewing
this series.

One thing that came to my mind is that if we do as David suggested in
patch#4, and we move it towards the end to actually __enable__ this
once all the infrastructure is there (unless hstate->nr_vmemmap_pages
differs from 0 we should not be doing any work AFAIK), we could also
move patch#6 to the end (right before the enablement), kill patch#7
and only leave patch#13.

The reason for that (killing patch#7 and leaving patch#13 only)
is that it does not make much sense to me to disable PMD-mapped vmemmap
depending on the CONFIG_HUGETLB_xxxxx as that is enabled by default
to replace that later by the boot kernel parameter.
It looks more natural to me to disable it when we introduce the kernel
boot parameter, before the actual enablement of the feature.

As I said, I plan to start the review again, but the order above would
make more sense to me.

thanks

-- 
Oscar Salvador
SUSE L3
