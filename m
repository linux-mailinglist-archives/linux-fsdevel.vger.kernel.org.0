Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DDD2337E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 19:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgG3RuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 13:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3RuA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:50:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F311FC061574;
        Thu, 30 Jul 2020 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gAP4m+CrKV+lP4/2WdG6H9Z8PKp+y9plS0lJH0VUElU=; b=YD3S5LnuG1lMCF9/8IGcwSbnE8
        gYaVNKBQw+I6Bf/69qfBh7kMx3E4b8EPUGLl2//otCQX9y9wJuXAaCkzOq9EWu/dhZweLGJj+VMXC
        iGsWGfzXT9d6WKKf8pzPzFlpBC4tj747Xika3t7xfNtRhMg485WQxtgQ9LcxTYtgrCi61uewHQ/I4
        l5JZCP3AXkEJ7PfCLZbHWbecsOgdCkJ1X+VEWxEyvbTL0dN6ShVuZriC2ZrzPMAt814+/rLU9YLId
        D2uW1bH3Qgo0GvAX/9je7qYJBTF/8Z4gpwDahJhLiwIXDYO2/10OJmQ9+0AS9xSn3KCe1kgJgzVkf
        iD3wSxKw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1Cgm-0007Gv-A1; Thu, 30 Jul 2020 17:49:56 +0000
Date:   Thu, 30 Jul 2020 18:49:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        gerg@linux-m68k.org, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <20200730174956.GK23808@casper.infradead.org>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 01:35:51PM -0400, Steven Sistare wrote:
> mshare + VA reservation is another possible solution.
> 
> Or MADV_DOEXEC alone, which is ready now.  I hope we can get back to reviewing that.

We are.  This is the part of the review process where we explore other
solutions to the problem.

> >> Also, we need to support updating legacy processes that already created anon segments.
> >> We inject code that calls MADV_DOEXEC for such segments.
> > 
> > Yes, I was assuming you'd inject code that called mshare().
> 
> OK, mshare works on existing memory and builds a new vma.

Actually, reparents an existing VMA, and reuses the existing page tables.

> > Actually, since you're injecting code, why do you need the kernel to
> > be involved?  You can mmap the new executable and any libraries it depends
> > upon, set up a new stack and jump to the main() entry point, all without
> > calling exec().  I appreciate it'd be a fair amount of code, but it'd all
> > be in userspace and you can probably steal / reuse code from ld.so (I'm
> > not familiar with the details of how setting up an executable is done).
> 
> Duplicating all the work that the kernel and loader do to exec a process would
> be error prone, require ongoing maintenance, and be redundant.  Better to define 
> a small kernel extension and leave exec to the kernel.

Either this is a one-off kind of thing, in which case it doesn't need
ongoing maintenance, or it's something with broad applicability, in
which case it can live as its own userspace project.  It could even
start off life as part of qemu and then fork into its own project.
The idea of tagging an ELF executable to say "I can cope with having
chunks of my address space provided to me by my executor" is ... odd.
