Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067CC401EDB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 19:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbhIFRCN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 13:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhIFRCM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:02:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195ABC061575;
        Mon,  6 Sep 2021 10:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MT10U4Fb2yrV/o7nel8We7nzm4JzOXr+NT/ZqDcuAPU=; b=rcFf6HHcKYcC6WYuRsQUmbf+Co
        BLs3xJOIi/fpxkw21lrBYoykFjlkDHylFfBq4eeiLMCO6vBqvaRuUt/IN/6WInQ95mzV0o0FQ3tnL
        /guKGayuPIuWl6r/g14pwRHusRV03hCBGVlm6FSnyRjVF6tKzounSzfllJMPea3B8trl+c33++r+9
        fYE1Lupo7y3obORedbLu/d4eIvahDQMTYHPxLV1q+t0H5edGA4X/8USfPinDV7fO89O7fcw2/VwU6
        MlfFiXHDTmpteG/qnfsEXiJ/AC2gka0Zz5+8zY8v6S0ziX44BcHowaWQkAQHANhoEB6NQZpJiXVh4
        XB9H+PYw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNHuU-007896-6m; Mon, 06 Sep 2021 16:56:05 +0000
Date:   Mon, 6 Sep 2021 17:55:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, mhocko@suse.com, dave.hansen@intel.com,
        keescook@chromium.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, hannes@cmpxchg.org, corbet@lwn.net,
        viro@zeniv.linux.org.uk, rdunlap@infradead.org,
        kaleshsingh@google.com, peterx@redhat.com, rppt@kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Subject: Re: [PATCH v9 2/3] mm: add a field to store names for private
 anonymous memory
Message-ID: <YTZIGhbSTghbUay+@casper.infradead.org>
References: <20210902231813.3597709-1-surenb@google.com>
 <20210902231813.3597709-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902231813.3597709-2-surenb@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 04:18:12PM -0700, Suren Baghdasaryan wrote:
> On Android we heavily use a set of tools that use an extended version of
> the logic covered in Documentation/vm/pagemap.txt to walk all pages mapped
> in userspace and slice their usage by process, shared (COW) vs.  unique
> mappings, backing, etc.  This can account for real physical memory usage
> even in cases like fork without exec (which Android uses heavily to share
> as many private COW pages as possible between processes), Kernel SamePage
> Merging, and clean zero pages.  It produces a measurement of the pages
> that only exist in that process (USS, for unique), and a measurement of
> the physical memory usage of that process with the cost of shared pages
> being evenly split between processes that share them (PSS).
> 
> If all anonymous memory is indistinguishable then figuring out the real
> physical memory usage (PSS) of each heap requires either a pagemap walking
> tool that can understand the heap debugging of every layer, or for every
> layer's heap debugging tools to implement the pagemap walking logic, in
> which case it is hard to get a consistent view of memory across the whole
> system.
> 
> Tracking the information in userspace leads to all sorts of problems.
> It either needs to be stored inside the process, which means every
> process has to have an API to export its current heap information upon
> request, or it has to be stored externally in a filesystem that
> somebody needs to clean up on crashes.  It needs to be readable while
> the process is still running, so it has to have some sort of
> synchronization with every layer of userspace.  Efficiently tracking
> the ranges requires reimplementing something like the kernel vma
> trees, and linking to it from every layer of userspace.  It requires
> more memory, more syscalls, more runtime cost, and more complexity to
> separately track regions that the kernel is already tracking.

I understand that the information is currently incoherent, but why is
this the right way to make it coherent?  It would seem more useful to
use something like one of the tracing mechanisms (eg ftrace, LTTng,
whatever the current hotness is in userspace tracing) for the malloc
library to log all the useful information, instead of injecting a subset
of it into the kernel for userspace to read out again.
