Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BCE41E847
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 09:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhJAHYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 03:24:53 -0400
Received: from out2.migadu.com ([188.165.223.204]:29995 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352464AbhJAHYw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 03:24:52 -0400
Date:   Fri, 1 Oct 2021 16:23:00 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633072987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ymfgiYvTlJ3AQGX94b1sSvkk9jsxxsuG2lLJcwnPHCo=;
        b=rqf1nYtN4SSLByWt0acEMV39Uq8aX7PCQTdJEG0XpnxSKHWodaJOaMJTMmm2ooZnAdd0O7
        NtF8R/UrBhknWFSHuDXNfOxzmwsN4GZESadxdACEuAjYeedQmotJ8FpD1XDj8BxKFatkHr
        EKSkJuMS7qGRFa/w9j/L1qpi7deXeFY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <20211001072300.GC1364952@u2004>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930215311.240774-3-shy828301@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> When handling shmem page fault the THP with corrupted subpage could be PMD
> mapped if certain conditions are satisfied.  But kernel is supposed to
> send SIGBUS when trying to map hwpoisoned page.
> 
> There are two paths which may do PMD map: fault around and regular fault.
> 
> Before commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
> the thing was even worse in fault around path.  The THP could be PMD mapped as
> long as the VMA fits regardless what subpage is accessed and corrupted.  After
> this commit as long as head page is not corrupted the THP could be PMD mapped.
> 
> In the regular fault path the THP could be PMD mapped as long as the corrupted
> page is not accessed and the VMA fits.
> 
> This loophole could be fixed by iterating every subpage to check if any
> of them is hwpoisoned or not, but it is somewhat costly in page fault path.
> 
> So introduce a new page flag called HasHWPoisoned on the first tail page.  It
> indicates the THP has hwpoisoned subpage(s).  It is set if any subpage of THP
> is found hwpoisoned by memory failure and cleared when the THP is freed or
> split.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Cc: <stable@vger.kernel.org>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
...
> @@ -668,6 +673,20 @@ PAGEFLAG_FALSE(DoubleMap)
>  	TESTSCFLAG_FALSE(DoubleMap)
>  #endif
>  
> +#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +/*
> + * PageHasPoisoned indicates that at least on subpage is hwpoisoned in the

Maybe you meant as follow?

+ * PageHasHWPoisoned indicates that at least one subpage is hwpoisoned in the

Thanks,
Naoya Horiguchi
