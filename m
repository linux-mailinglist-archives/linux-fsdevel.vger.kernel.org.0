Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EBF337242
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 13:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhCKMSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 07:18:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:37782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232939AbhCKMRt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:17:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615465068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IGYvOm6xWvQaeEAWJ0OJf1VZrE67PWdEBB9r6ELt5bQ=;
        b=ISpFATe/FJR8SDgPYIl1OsuX8oVTZxkzA0m7C2HRWMR84KxvQoNf/GOSUmjDiiv8sSJEfp
        XX3OWibykqurvAv7ae+V+BxHaq/jSHdIAD3Lql56hyVSj+tvsN3v7zk77eIT3YRyECepTE
        Ic1aH0IbDkupFT7gIov7Er0/IPKZqrM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC8FFAB8C;
        Thu, 11 Mar 2021 12:17:47 +0000 (UTC)
Date:   Thu, 11 Mar 2021 13:17:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: Re: [PATCH v18 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
Message-ID: <YEoKa5oSm/hdgt5V@dhcp22.suse.cz>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-5-songmuchun@bytedance.com>
 <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
 <f9f19d38-f1a7-ac8c-6ba8-3ce0bcc1e6a0@oracle.com>
 <YEk1+mDZ4u85RKL3@dhcp22.suse.cz>
 <20210310214909.GY2696@paulmck-ThinkPad-P72>
 <68bc8cc9-a15b-2e97-9a2a-282fe6e9bd3f@oracle.com>
 <20210310232851.GZ2696@paulmck-ThinkPad-P72>
 <YEnXllhPEQhT0CRt@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEnXllhPEQhT0CRt@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 11-03-21 09:40:57, Michal Hocko wrote:
> On Wed 10-03-21 15:28:51, Paul E. McKenney wrote:
> > On Wed, Mar 10, 2021 at 02:10:12PM -0800, Mike Kravetz wrote:
> > > On 3/10/21 1:49 PM, Paul E. McKenney wrote:
> > > > On Wed, Mar 10, 2021 at 10:11:22PM +0100, Michal Hocko wrote:
> > > >> On Wed 10-03-21 10:56:08, Mike Kravetz wrote:
> > > >>> On 3/10/21 7:19 AM, Michal Hocko wrote:
> > > >>>> On Mon 08-03-21 18:28:02, Muchun Song wrote:
> > > >>>> [...]
> > > >>>>> @@ -1447,7 +1486,7 @@ void free_huge_page(struct page *page)
> > > >>>>>  	/*
> > > >>>>>  	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
> > > >>>>>  	 */
> > > >>>>> -	if (!in_task()) {
> > > >>>>> +	if (in_atomic()) {
> > > >>>>
> > > >>>> As I've said elsewhere in_atomic doesn't work for CONFIG_PREEMPT_COUNT=n.
> > > >>>> We need this change for other reasons and so it would be better to pull
> > > >>>> it out into a separate patch which also makes HUGETLB depend on
> > > >>>> PREEMPT_COUNT.
> > > >>>
> > > >>> Yes, the issue of calling put_page for hugetlb pages from any context
> > > >>> still needs work.  IMO, that is outside the scope of this series.  We
> > > >>> already have code in this path which blocks/sleeps.
> > > >>>
> > > >>> Making HUGETLB depend on PREEMPT_COUNT is too restrictive.  IIUC,
> > > >>> PREEMPT_COUNT will only be enabled if we enable:
> > > >>> PREEMPT "Preemptible Kernel (Low-Latency Desktop)"
> > > >>> PREEMPT_RT "Fully Preemptible Kernel (Real-Time)"
> > > >>> or, other 'debug' options.  These are not enabled in 'more common'
> > > >>> kernels.  Of course, we do not want to disable HUGETLB in common
> > > >>> configurations.
> > > >>
> > > >> I haven't tried that but PREEMPT_COUNT should be selectable even without
> > > >> any change to the preemption model (e.g. !PREEMPT).
> > > > 
> > > > It works reliably for me, for example as in the diff below.  So,
> > > > as Michal says, you should be able to add "select PREEMPT_COUNT" to
> > > > whatever Kconfig option you need to.
> > > > 
> > > 
> > > Thanks Paul.
> > > 
> > > I may have been misreading Michal's suggestion of "make HUGETLB depend on
> > > PREEMPT_COUNT".  We could "select PREEMPT_COUNT" if HUGETLB is enabled.
> > > However, since HUGETLB is enabled in most configs, then this would
> > > result in PREEMPT_COUNT also being enabled in most configs.  I honestly
> > > do not know how much this will cost us?  I assume that if it was free or
> > > really cheap it would already be always on?
> > 
> > There are a -lot- of configs out there, so are you sure that HUGETLB is
> > really enabled in most of them?  ;-)
> 
> It certainly is enabled for all distribution kernels and many are
> !PREEMPT so I believe this is what Mike was concerned about.
> 
> > More seriously, I was going by earlier emails in this and related threads
> > plus Michal's "PREEMPT_COUNT should be selectable".  But there are other
> > situations that would like PREEMPT_COUNT.  And to your point, some who
> > would rather PREEMPT_COUNT not be universally enabled.  I haven't seen
> > any performance or kernel-size numbers from any of them, however.
> 
> Yeah per cpu preempt counting shouldn't be noticeable but I have to
> confess I haven't benchmarked it.

But all this seems moot now http://lkml.kernel.org/r/YEoA08n60+jzsnAl@hirez.programming.kicks-ass.net

-- 
Michal Hocko
SUSE Labs
