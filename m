Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C082A6B55
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 18:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbgKDRDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 12:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732031AbgKDRDF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:03:05 -0500
Received: from kernel.org (unknown [87.71.17.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FD9C2071A;
        Wed,  4 Nov 2020 17:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604509384;
        bh=rNITg8eagPnFNzCzxObVDyyyLvNDMpMqrDKWRtXNo1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbMszixDY/CCQ4Uoej0yke6wNx2huYgP8NhaGqEXUCQOQ+71BtRjL4UN747/oLhHT
         jlOUbEPtbSsAUpPtJ4TKfNUm3RxZ3UFt+v7azAmQtFc9r46TIiMsgPqIFvZ1tNT9dj
         lpdbGPMmI1FpQwRmAzKJsAvG+FlUBcvCqAD3nWrU=
Date:   Wed, 4 Nov 2020 19:02:47 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v6 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20201104170247.GT4879@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20201101110935.GA4105325@laniakea>
 <20201102154028.GD4879@kernel.org>
 <1547601988.128687.1604411534845@office.mailbox.org>
 <20201103163002.GK4879@kernel.org>
 <1988407921.138656.1604489953944@office.mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1988407921.138656.1604489953944@office.mailbox.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:39:13PM +0100, Hagen Paul Pfeifer wrote:
> > On 11/03/2020 5:30 PM Mike Rapoport <rppt@kernel.org> wrote:
> > 
> > > > As long as the task share the file descriptor, they can share the
> > > > secretmem pages, pretty much like normal memfd.
> > > 
> > > Including process_vm_readv() and process_vm_writev()? Let's take a hypothetical
> > > "dbus-daemon-secure" service that receives data from process A and wants to
> > > copy/distribute it to data areas of N other processes. Much like dbus but without
> > > SOCK_DGRAM rather direct copy into secretmem/mmap pages (ring-buffer). Should be
> > > possible, right?
> > 
> > I'm not sure I follow you here.
> > For process_vm_readv() and process_vm_writev() secremem will be only
> > accessible on the local part, but not on the remote.
> > So copying data to secretmem pages using process_vm_writev wouldn't
> > work.
> 
> A hypothetical "dbus-daemon-secure" service will not be *process related* with communication
> peers. E.g. a password-input process (reading a password into secured-memory page) will
> transfer the password to dbus-daemon-secure and this service will hand-over the password to
> two additional applications: a IPsec process on CPU0 und CPU1 (which itself use a
> secured-memory page).
> 
> So four applications IPC chain:
>  password-input -> dbus-daemon-secure -> {IPsec0, IPsec1}
> 
> - password-input: uses a secured page to read/save the password locally after reading from TTY
> - dbus-daemon-secure: uses a secured page for IPC (legitimate user can write and read into the secured page)
> - IPSecN has secured page to save the password locally (and probably other data as well), IPC memory is memset'ed after copy
> 
> Goal: the whole password is never saved/touched on non secured pages during IPC transfer.
> 
> Question: maybe a *file-descriptor passing* mechanism can do the trick? I.e. dbus-daemon-secure
> allocates via memfd_secret/mmap secure pages and permitted processes will get the descriptor/mmaped-page
> passed so they can use the pages directly?

Yes, this will work. The processes that share the memfd_secret file
descriptor will have access to the same memory pages, pretty much like
with shared memory.

> Hagen

-- 
Sincerely yours,
Mike.
