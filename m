Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA8F3349AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 22:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhCJVL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 16:11:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:38774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233809AbhCJVL0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:11:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615410684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6GUjnkXjBs1KtZmnlih/UvqUZNGHdMWjAjgw8SoXP3g=;
        b=Gu5UZClhRbGMERTYbpCARsXtae9aRA04srw0EVXmmZO4aQTUCX2Zs0Qbr5Sr8+BDlzEj0G
        l8pGFJa4Vq116BU1/YmH0dqtEFV8fGdw+gKGqh6qXtdxuCdLWa3t6NgoSdAFaYQv3nzoWm
        2XS2v3LzCrH+44JAXJFCIBCsMEkAoLU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B550DAC8C;
        Wed, 10 Mar 2021 21:11:24 +0000 (UTC)
Date:   Wed, 10 Mar 2021 22:11:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: Re: [PATCH v18 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
Message-ID: <YEk1+mDZ4u85RKL3@dhcp22.suse.cz>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-5-songmuchun@bytedance.com>
 <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
 <f9f19d38-f1a7-ac8c-6ba8-3ce0bcc1e6a0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f19d38-f1a7-ac8c-6ba8-3ce0bcc1e6a0@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 10-03-21 10:56:08, Mike Kravetz wrote:
> On 3/10/21 7:19 AM, Michal Hocko wrote:
> > On Mon 08-03-21 18:28:02, Muchun Song wrote:
> > [...]
> >> @@ -1447,7 +1486,7 @@ void free_huge_page(struct page *page)
> >>  	/*
> >>  	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
> >>  	 */
> >> -	if (!in_task()) {
> >> +	if (in_atomic()) {
> > 
> > As I've said elsewhere in_atomic doesn't work for CONFIG_PREEMPT_COUNT=n.
> > We need this change for other reasons and so it would be better to pull
> > it out into a separate patch which also makes HUGETLB depend on
> > PREEMPT_COUNT.
> 
> Yes, the issue of calling put_page for hugetlb pages from any context
> still needs work.  IMO, that is outside the scope of this series.  We
> already have code in this path which blocks/sleeps.
> 
> Making HUGETLB depend on PREEMPT_COUNT is too restrictive.  IIUC,
> PREEMPT_COUNT will only be enabled if we enable:
> PREEMPT "Preemptible Kernel (Low-Latency Desktop)"
> PREEMPT_RT "Fully Preemptible Kernel (Real-Time)"
> or, other 'debug' options.  These are not enabled in 'more common'
> kernels.  Of course, we do not want to disable HUGETLB in common
> configurations.

I haven't tried that but PREEMPT_COUNT should be selectable even without
any change to the preemption model (e.g. !PREEMPT).

-- 
Michal Hocko
SUSE Labs
