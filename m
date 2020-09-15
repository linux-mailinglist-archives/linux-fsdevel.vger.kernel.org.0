Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD1426B598
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 01:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgIOXrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 19:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgIOOdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:33:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6122AC06174A;
        Tue, 15 Sep 2020 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N/RImaBnXFF3qV4mVIQ9BHL7AM45ePKA2LT5MfLcY7k=; b=isoDWDZijETKPcfACECD40iTGj
        m7dtS99gUE2YIdQKRNawehnEMFycuNrpgVmgOUXa4i3mmp2Cg2XAJvGFO9sj1F9b5LGGrznkLNgp3
        dfra5s1A6jdc2AcvbDqdrtty9bgFwY2fDoLoon1Te/Znm8tdIgGXGr5VZZOMwZRh0/whuaClyUie+
        DX3kDpFozwg/jmJHVFaSZ9QR1de+PsLEW6LxzrpjMaJU/9NkKiBbafGAOjQXeZoyR51HXGXQ4mWre
        ytCoB0y+jPqTEjVZ8jcsclL+LfcnX9bc+6OYQwoWHC2Gj+p0Aax5KQ4ovoyXxrhbNY09DGfXA79YC
        nAXUeo3w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIC0f-00065s-HW; Tue, 15 Sep 2020 14:32:42 +0000
Date:   Tue, 15 Sep 2020 15:32:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 00/24] mm/hugetlb: Free some vmemmap pages of hugetlb
 page
Message-ID: <20200915143241.GH5449@casper.infradead.org>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 08:59:23PM +0800, Muchun Song wrote:
> This patch series will free some vmemmap pages(struct page structures)
> associated with each hugetlbpage when preallocated to save memory.

It would be lovely to be able to do this.  Unfortunately, it's completely
impossible right now.  Consider, for example, get_user_pages() called
on the fifth page of a hugetlb page.

I've spent a lot of time thinking about this, and there's a lot of work
that needs to happen before we can do this, mostly in device drivers.
Do you want to help?  It's a multi-year project.
