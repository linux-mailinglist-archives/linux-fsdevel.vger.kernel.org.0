Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB9A23354F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgG3P1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 11:27:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54880 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3P1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:27:13 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k1ASY-0005n8-GX; Thu, 30 Jul 2020 15:27:06 +0000
Date:   Thu, 30 Jul 2020 17:27:05 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        gerg@linux-m68k.org, ktkhai@virtuozzo.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <20200730152705.ol42jppnl4xfhl32@wittgenstein>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730152250.GG23808@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 04:22:50PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 27, 2020 at 10:11:22AM -0700, Anthony Yznaga wrote:
> > This patchset adds support for preserving an anonymous memory range across
> > exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
> > sharing memory in this manner, as opposed to re-attaching to a named shared
> > memory segment, is to ensure it is mapped at the same virtual address in
> > the new process as it was in the old one.  An intended use for this is to
> > preserve guest memory for guests using vfio while qemu exec's an updated
> > version of itself.  By ensuring the memory is preserved at a fixed address,
> > vfio mappings and their associated kernel data structures can remain valid.
> > In addition, for the qemu use case, qemu instances that back guest RAM with
> > anonymous memory can be updated.
> 
> I just realised that something else I'm working on might be a suitable
> alternative to this.  Apologies for not realising it sooner.
> 
> http://www.wil.cx/~willy/linux/sileby.html

Just skimming: make it O_CLOEXEC by default. ;)

> 
> To use this, you'd mshare() the anonymous memory range, essentially
> detaching the VMA from the current process's mm_struct and reparenting
> it to this new mm_struct, which has an fd referencing it.
> 
> Then you call exec(), and the exec'ed task gets to call mmap() on that
> new fd to attach the memory range to its own address space.
> 
> Presto!
