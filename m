Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2701B4D032A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbiCGPox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiCGPow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:44:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E0C70F42;
        Mon,  7 Mar 2022 07:43:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3F8EB815EB;
        Mon,  7 Mar 2022 15:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3107EC340E9;
        Mon,  7 Mar 2022 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646667835;
        bh=pfUclWf7OeQP6fVMwAxfeek4Z/tO6y5WQdf6JL4ro+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGqXs4QUJZlZgCVSTmVIhUyrefWcLiV5XQbqLL4lWUXGjnXK8TQIh8MZmlhlk7Dws
         vymCZmmrecWaK5QsPzl/JEnH42FdMm3knJaE2LeAyUSJ6XKfnw56pF4AeKS+pTp0gM
         5KdvMy04Dnkw4+IxsOcB497JN8wWMBQMp3/kpehP7UKOCvtf1DHR6KqD1XbWMnWqm1
         J5NppGJKVe/xpRZtg5cS5CCRR4+KxGOb1RuKPdZJJ1tfKV82mNLMPHXXAbwf++SaN3
         MlkGhHuxVnfK5PtQGRXqcvD5ziuoeGJJ2APZH4iRWJVk48q3ueX06DQHuMjFgRGo6P
         8lzRQuuKTdedQ==
Date:   Mon, 7 Mar 2022 17:43:14 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, jaharkes@cs.cmu.edu,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        codalist@telemann.coda.cs.cmu.edu, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC v2] mm: Add f_ops->populate()
Message-ID: <YiYoEiBklxQrb8Wj@iki.fi>
References: <20220306032655.97863-1-jarkko@kernel.org>
 <20220306152456.2649b1c56da2a4ce4f487be4@linux-foundation.org>
 <c3083144-bfc1-3260-164c-e59b2d110df8@intel.com>
 <YiYYvAWYgC+PKEx0@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiYYvAWYgC+PKEx0@casper.infradead.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 07, 2022 at 02:37:48PM +0000, Matthew Wilcox wrote:
> On Sun, Mar 06, 2022 at 03:41:54PM -0800, Dave Hansen wrote:
> > In short: page faults stink.  The core kernel has lots of ways of
> > avoiding page faults like madvise(MADV_WILLNEED) or mmap(MAP_POPULATE).
> >  But, those only work on normal RAM that the core mm manages.
> > 
> > SGX is weird.  SGX memory is managed outside the core mm.  It doesn't
> > have a 'struct page' and get_user_pages() doesn't work on it.  Its VMAs
> > are marked with VM_IO.  So, none of the existing methods for avoiding
> > page faults work on SGX memory.
> > 
> > This essentially helps extend existing "normal RAM" kernel ABIs to work
> > for avoiding faults for SGX too.  SGX users want to enjoy all of the
> > benefits of a delayed allocation policy (better resource use,
> > overcommit, NUMA affinity) but without the cost of millions of faults.
> 
> We have a mechanism for dynamically reducing the number of page faults
> already; it's just buried in the page cache code.  You have vma->vm_file,
> which contains a file_ra_state.  You can use this to track where
> recent faults have been and grow the size of the region you fault in
> per page fault.  You don't have to (indeed probably don't want to) use
> the same algorithm as the page cache, but the _principle_ is the same --
> were recent speculative faults actually used; should we grow the number
> of pages actually faulted in, or is this a random sparse workload where
> we want to allocate individual pages.
> 
> Don't rely on the user to ask.  They don't know.

This sounds like a possibility. I'll need to study it properly first
though. Thank you for pointing this out.

BR, Jarkko
