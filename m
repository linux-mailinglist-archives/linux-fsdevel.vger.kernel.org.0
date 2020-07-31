Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBB523486F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbgGaP1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387521AbgGaP1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C35C061574;
        Fri, 31 Jul 2020 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bsi9xPmSMWSxHDG9tcc/ZmIBBdGYL5RzEu0Vz8YRBRg=; b=bUfjRImbe/fazmrVUlDrO7qo7p
        XgRpbbXCL+hV9Dqk/dBw8POrfT022WbSD15UpCQDAUPlUSCj2PAkbM6R27OpRxymm3L7YOi9/BRsE
        bv2W18JgDF5Ly5bKpeM0CCQ7+yi743p5SNM7I+rvEAIj9H9IPF/tng3FU+e05ZLNmFhnNekqIlmza
        vSvqMrer1bN0iDbn5NqpSaCs1kvaVoKWoWUp2Gpx77GizjAvaRAxBEUhnzKvD5XQqPT/XiLxluoz4
        c9QcsZn1yG6uCThYdwdvrosh9soo50ts83HhDciRmV5KgPv5kXW8Xl0ou3kXFg9C6gLHxfHE1RCkv
        ArFe76MA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1Wwa-0002d9-3F; Fri, 31 Jul 2020 15:27:36 +0000
Date:   Fri, 31 Jul 2020 16:27:36 +0100
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
Message-ID: <20200731152736.GP23808@casper.infradead.org>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 31, 2020 at 10:57:44AM -0400, Steven Sistare wrote:
> Matthews sileby/mshare proposal has the same issue.  If a process opts-in
> and mmap's an address in the shared region, then content becomes mapped at
> a VA that was known to the pre-fork or pre-exec process.  Trust must still
> be established.

It's up to the recipient whether they try to map it at the same address
or at a fresh address.  The intended use case is a "semi-shared" address
space between two processes (ie partway between a threaded, fully-shared
address space and a forked un-shared address space), in which case
there's a certain amount of trust and cooperation between the processes.

Your preservation-across-exec use-case might or might not need the
VMA to be mapped at the same address.  I don't know whether qemu stores
pointers in this VMA which are absolute within the qemu address space.
If it's just the emulated process's address space, then everything will
be absolute within its own address space and everything will be opaque
to qemu.  If qemu is storing its own pointers in it, then it has to be
mapped at the same address.

> > Here is another suggestion.
> > 
> > Have a very simple program that does:
> > 
> > 	for (;;) {
> > 		handle = dlopen("/my/real/program");
> > 		real_main = dlsym(handle, "main");
> > 		real_main(argc, argv, envp);
> > 		dlclose(handle);
> > 	}
> > 
> > With whatever obvious adjustments are needed to fit your usecase.
> > 
> > That should give the same level of functionality, be portable to all
> > unices, and not require you to duplicate code.  It belive it limits you
> > to not upgrading libc, or librt but that is a comparatively small
> > limitation.
> > 
> > 
> > Given that in general the interesting work is done in userspace and that
> > userspace has provided an interface for reusing that work already.
> > I don't see the justification for adding anything to exec at this point. 
> 
> Thanks for the suggestion.  That is clever, and would make a fun project,
> but I would not trust it for production.  These few lines are just
> the first of many that it would take to reset the environment to the
> well-defined post-exec initial conditions that all executables expect,
> and incrementally tearing down state will be prone to bugs.  Getting a
> clean slate from a kernel exec is a much more reliable design.  The use
> case is creating long-lived apps that never go down, and the simplest
> implementation will have the fewest bugs and is the best.  MADV_DOEXEC is
> simple, and does not even require a new system call, and the kernel already
> knows how to exec without bugs.

It's a net increase of 200 lines of kernel code.  If 4 lines of userspace
code removes 200 lines of kernel code, I think I know which I prefer ...
