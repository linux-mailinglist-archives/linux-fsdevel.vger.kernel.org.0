Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0094230039C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 14:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbhAVNAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 08:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbhAVM7q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:59:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16C16230FC;
        Fri, 22 Jan 2021 12:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611320346;
        bh=KOC8i4h1phIqdtjvrL9AXOG1eCZg1fJIiF3yQKhxk/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKwMLC7OELm1PbA4JHPkLogTkoeY7R76FpH0BAn7Ij2QjRx7SUJgilab19RUDzBY2
         ekl0NLm2XESpjNZs48mIRcmB7L8Ye+RjI1Wj3SAAFLoI7m5rXPBAgvZZimJmmB0Nlr
         I8lbf5rObXUcg3OT7WUgkXnw8TWOCy6KgvjHQhQ9obeL/KDb6nXGa6dPqx7vPkN8Rj
         22VOj370oOZQh5t5OQwMZWOMNk3VmbjwJWatKGkxEgdGTRSXjwx4+zLRz06Yq9i8i8
         IXkwpi7O8D7aN/KibydQfqrjQJqkRjZKEAOFpm10/90zwkcNOR4+kDPmcrp3nuNSTO
         RSPWPXMyMKZtA==
Date:   Fri, 22 Jan 2021 12:58:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 6/6] mm: Forbid splitting special mappings
Message-ID: <20210122125858.GC24102@willie-the-truck>
References: <20201013013416.390574-1-dima@arista.com>
 <20201013013416.390574-7-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013013416.390574-7-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 02:34:16AM +0100, Dmitry Safonov wrote:
> Don't allow splitting of vm_special_mapping's.
> It affects vdso/vvar areas. Uprobes have only one page in xol_area so
> they aren't affected.
> 
> Those restrictions were enforced by checks in .mremap() callbacks.
> Restrict resizing with generic .split() callback.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/arm/kernel/vdso.c    |  9 ---------
>  arch/arm64/kernel/vdso.c  | 41 +++------------------------------------
>  arch/mips/vdso/genvdso.c  |  4 ----
>  arch/s390/kernel/vdso.c   | 11 +----------
>  arch/x86/entry/vdso/vma.c | 17 ----------------
>  mm/mmap.c                 | 12 ++++++++++++
>  6 files changed, 16 insertions(+), 78 deletions(-)

For arm64:

Acked-by: Will Deacon <will@kernel.org>

Will
