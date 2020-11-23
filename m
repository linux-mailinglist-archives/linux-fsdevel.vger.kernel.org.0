Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8002C00AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 08:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgKWHiz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 02:38:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:43526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgKWHiz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 02:38:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606117133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DAbMhd58MepnJ3wMNvb/zcTlCSLnBv7xL56Vesu5R1o=;
        b=lZJNaK+zKvjftgQ9k5+/adyl3XY7aEfdiOJ+dAXhG8va60Zactln2x6BiRwuIU5QSiP+dD
        6Z4L18p2ngk3lSmCPyCYLT8jYUt8r1AYwVRlGbE49ILwX3ecjFTvGnwhpaMvOj9bf/OWtJ
        VM5o7sQcwiSv3lWFCvjBQAGKju6BcZs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7EB96ABDE;
        Mon, 23 Nov 2020 07:38:53 +0000 (UTC)
Date:   Mon, 23 Nov 2020 08:38:42 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/21] Free some vmemmap pages of hugetlb page
Message-ID: <20201123073842.GA27488@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz>
 <6b1533f7-69c6-6f19-fc93-c69750caaecc@redhat.com>
 <20201120093912.GM3200@dhcp22.suse.cz>
 <eda50930-05b5-0ad9-2985-8b6328f92cec@redhat.com>
 <55e53264-a07a-a3ec-4253-e72c718b4ee6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e53264-a07a-a3ec-4253-e72c718b4ee6@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 09:45:12, Mike Kravetz wrote:
> On 11/20/20 1:43 AM, David Hildenbrand wrote:
[...]
> >>> To keep things easy, maybe simply never allow to free these hugetlb pages
> >>> again for now? If they were reserved during boot and the vmemmap condensed,
> >>> then just let them stick around for all eternity.
> >>
> >> Not sure I understand. Do you propose to only free those vmemmap pages
> >> when the pool is initialized during boot time and never allow to free
> >> them up? That would certainly make it safer and maybe even simpler wrt
> >> implementation.
> > 
> > Exactly, let's keep it simple for now. I guess most use cases of this (virtualization, databases, ...) will allocate hugepages during boot and never free them.
> 
> Not sure if I agree with that last statement.  Database and virtualization
> use cases from my employer allocate allocate hugetlb pages after boot.  It
> is shortly after boot, but still not from boot/kernel command line.

Is there any strong reason for that?

> Somewhat related, but not exactly addressing this issue ...
> 
> One idea discussed in a previous patch set was to disable PMD/huge page
> mapping of vmemmap if this feature was enabled.  This would eliminate a bunch
> of the complex code doing page table manipulation.  It does not address
> the issue of struct page pages going away which is being discussed here,
> but it could be a way to simply the first version of this code.  If this
> is going to be an 'opt in' feature as previously suggested, then eliminating
> the  PMD/huge page vmemmap mapping may be acceptable.  My guess is that
> sysadmins would only 'opt in' if they expect most of system memory to be used
> by hugetlb pages.  We certainly have database and virtualization use cases
> where this is true.

Would this simplify the code considerably? I mean, the vmemmap page
tables will need to be updated anyway. So that code has to stay. PMD
entry split shouldn't be the most complex part of that operation.  On
the other hand dropping large pages for all vmemmaps will likely have a
performance.
-- 
Michal Hocko
SUSE Labs
