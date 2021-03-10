Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B84334A1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 22:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhCJVtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 16:49:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231636AbhCJVtK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:49:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E62A764E27;
        Wed, 10 Mar 2021 21:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615412950;
        bh=k4nA3Eis+qAbq10nmWD8z7V/kQBE/rHbRJtN9QWQBw0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P5sKfqEbajEnmE7axLxcCMjxpejmZbLeK/35uQ75J2PTcy2fnAMV4slxTa8XGxp0O
         6M12d7qF70AIb555wieAmHBgSiLAsK5lSUU3DeoewzlfOTT4y0UkJ4zRhwZPYNDRmQ
         E1NS///fOr6Rjo7kiNl8M89ii91dTn5FmQk2B4FA4u4LRt8pEsJBkMFekpVJW8BqXA
         kZzgtbp5pwCUxSUIHIhqirnDaeaF6gn6tQjuUN4mlo6pm41bqlBfNFNJfJ9xr++O/a
         cAJkEKjYuIFGdfkKqeIMidCG0/O19aFeR0P7PkFa03mpo27vHPlgdSIKVMaWYdq+GC
         5eSPUE2QdHLuA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 940603522611; Wed, 10 Mar 2021 13:49:09 -0800 (PST)
Date:   Wed, 10 Mar 2021 13:49:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <20210310214909.GY2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-5-songmuchun@bytedance.com>
 <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
 <f9f19d38-f1a7-ac8c-6ba8-3ce0bcc1e6a0@oracle.com>
 <YEk1+mDZ4u85RKL3@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEk1+mDZ4u85RKL3@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 10:11:22PM +0100, Michal Hocko wrote:
> On Wed 10-03-21 10:56:08, Mike Kravetz wrote:
> > On 3/10/21 7:19 AM, Michal Hocko wrote:
> > > On Mon 08-03-21 18:28:02, Muchun Song wrote:
> > > [...]
> > >> @@ -1447,7 +1486,7 @@ void free_huge_page(struct page *page)
> > >>  	/*
> > >>  	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
> > >>  	 */
> > >> -	if (!in_task()) {
> > >> +	if (in_atomic()) {
> > > 
> > > As I've said elsewhere in_atomic doesn't work for CONFIG_PREEMPT_COUNT=n.
> > > We need this change for other reasons and so it would be better to pull
> > > it out into a separate patch which also makes HUGETLB depend on
> > > PREEMPT_COUNT.
> > 
> > Yes, the issue of calling put_page for hugetlb pages from any context
> > still needs work.  IMO, that is outside the scope of this series.  We
> > already have code in this path which blocks/sleeps.
> > 
> > Making HUGETLB depend on PREEMPT_COUNT is too restrictive.  IIUC,
> > PREEMPT_COUNT will only be enabled if we enable:
> > PREEMPT "Preemptible Kernel (Low-Latency Desktop)"
> > PREEMPT_RT "Fully Preemptible Kernel (Real-Time)"
> > or, other 'debug' options.  These are not enabled in 'more common'
> > kernels.  Of course, we do not want to disable HUGETLB in common
> > configurations.
> 
> I haven't tried that but PREEMPT_COUNT should be selectable even without
> any change to the preemption model (e.g. !PREEMPT).

It works reliably for me, for example as in the diff below.  So,
as Michal says, you should be able to add "select PREEMPT_COUNT" to
whatever Kconfig option you need to.

							Thanx, Paul

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 3128b7c..7d9f989 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -8,6 +8,7 @@ menu "RCU Subsystem"
 config TREE_RCU
 	bool
 	default y if SMP
+	select PREEMPT_COUNT
 	help
 	  This option selects the RCU implementation that is
 	  designed for very large SMP system with hundreds or
