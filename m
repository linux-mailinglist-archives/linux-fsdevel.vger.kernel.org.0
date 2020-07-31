Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8C234A37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 19:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbgGaRXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732970AbgGaRXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:23:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46667C061574;
        Fri, 31 Jul 2020 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1mijjRYuRlV1nsas7+RkkJeUm22srBJgqC/kjl8CxTo=; b=VfUjSEfRmnrJ+EhnkKqaubP8LY
        bPDymb+ADlyxt4KSFmNG0Kdi9f0XdEd3AGurw1Iq1LfD3qNEFLgZg5KXh3fjBauS+N3hpvaoF2KCz
        6qDSKlY6nElZV7JEGX5vEWwcXkW7KdWomh3ez+xbuveQumtBN9ETF65jZxsfubRxRYSE6KC2QY9Jz
        l4SdO5PEVzXiyZge4/yp5ddWWP8TqXfSoXy2ce0B7OsiSsK4zXCJSVCtfK8jPJQtcpzJ2+Ep3YeXh
        JmGNgfodGHSCuxWnen/BJOFvJKpMd4185WrTmsN7H330wpeVTaZ/nCYJRedW3ux9Tqh3wXb6H5Vd9
        T3UAQkyA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1Ykr-0008T6-G9; Fri, 31 Jul 2020 17:23:37 +0000
Date:   Fri, 31 Jul 2020 18:23:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <20200731172337.GQ23808@casper.infradead.org>
References: <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <20200731152736.GP23808@casper.infradead.org>
 <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 31, 2020 at 12:11:52PM -0400, Steven Sistare wrote:
> On 7/31/2020 11:27 AM, Matthew Wilcox wrote:
> > On Fri, Jul 31, 2020 at 10:57:44AM -0400, Steven Sistare wrote:
> >> Matthews sileby/mshare proposal has the same issue.  If a process opts-in
> >> and mmap's an address in the shared region, then content becomes mapped at
> >> a VA that was known to the pre-fork or pre-exec process.  Trust must still
> >> be established.
> > 
> > It's up to the recipient whether they try to map it at the same address
> > or at a fresh address.  The intended use case is a "semi-shared" address
> > space between two processes (ie partway between a threaded, fully-shared
> > address space and a forked un-shared address space), in which case
> > there's a certain amount of trust and cooperation between the processes.
> 
> Understood, but if the recipient does map at any of the same, which is the whole
> point because you want to share the page table.  The trust relationship is no
> different than for the live update case.  

You don't have to map at the same address to share the page tables.
For example, on x86 if you share an 8GB region, that must be aligned at
1GB in both the donor and the recipient, but they need not be mapped at
the same address.

> > It's a net increase of 200 lines of kernel code.  If 4 lines of userspace
> > code removes 200 lines of kernel code, I think I know which I prefer ...
> 
> It will be *far* more than 4 lines.
> Much of the 200 lines is mostly for the elf opt in, and much of the elf code is from
> anthony reviving an earlier patch that use MAP_FIXED_NOREPLACE during segment setup.

It doesn't really matter how much of it is for the opt-in and how much
is for the exec path itself.  The MAP_FIXED_NOREPLACE patch is only net
+16 lines, so that's not the problem.
