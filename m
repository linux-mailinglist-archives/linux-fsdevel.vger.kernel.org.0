Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0B127D28D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 17:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgI2PQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 11:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgI2PQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:16:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F58C061755;
        Tue, 29 Sep 2020 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rt/gWACyTIQuj5nIeNUdzNcwr8s1YVFasvFCFOsspG0=; b=C1EjOj6Mt1xdWZh3XPn8rkOVq0
        OxLNUps2Qyz7f+SRn0b0qVlwpJY3G1qjZJrXsr79+xSJN576WRyGRCJBvE33ahL+K3bAl6J52zeHS
        wSJqYA3kcEN4r81o5iv8mrkQNdTtpmXlgU0m94t4jobUJQw63e2MEofWlPsisf6M5B5+P7V7uo9JR
        L+B8gNbZ5jGR4O4c1ouioTzYDVNXI11/fjGCnBu9osfq4flDd/ZImbGrL1Nb/QcxcZUrcloACztpk
        f+A0BvS7dJrAKnyy1KN+GuPecThd5yRmSmk4dIzSCm/hex1K24N5dt/nnCwUMW+yOhjXGoH3qt8AN
        HBl2N0ng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNHMC-0000zG-2k; Tue, 29 Sep 2020 15:15:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 191E5300F7A;
        Tue, 29 Sep 2020 17:15:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 004CF210E84D8; Tue, 29 Sep 2020 17:15:52 +0200 (CEST)
Date:   Tue, 29 Sep 2020 17:15:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200929151552.GS2628@hirez.programming.kicks-ass.net>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <20200929130529.GE2142832@kernel.org>
 <20200929141216.GO2628@hirez.programming.kicks-ass.net>
 <20200929145813.GA3226834@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929145813.GA3226834@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 29, 2020 at 05:58:13PM +0300, Mike Rapoport wrote:
> On Tue, Sep 29, 2020 at 04:12:16PM +0200, Peter Zijlstra wrote:

> > It will drop them down to 4k pages. Given enough inodes, and allocating
> > only a single sekrit page per pmd, we'll shatter the directmap into 4k.
> 
> Why? Secretmem allocates PMD-size page per inode and uses it as a pool
> of 4K pages for that inode. This way it ensures that
> __kernel_map_pages() is always called on PMD boundaries.

Oh, you unmap the 2m page upfront? I read it like you did the unmap at
the sekrit page alloc, not the pool alloc side of things.

Then yes, but then you're wasting gobs of memory. Basically you can pin
2M per inode while only accounting a single page.
