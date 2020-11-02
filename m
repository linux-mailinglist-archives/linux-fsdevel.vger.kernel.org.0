Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7588B2A2E79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 16:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgKBPkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 10:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgKBPkm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:40:42 -0500
Received: from kernel.org (unknown [87.71.17.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 202C12222B;
        Mon,  2 Nov 2020 15:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604331641;
        bh=JULj2YQjQ3lL8L8mphnth/XMQ+6I1NJ7oIH3/fDK0iU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0o11Hfll3daQtruT1vsISN+BbHP9yaMYQE4FQMEMibOkJCKqnhjRxA+eho5Laarv
         OhRwtWZyY8Wy3q5T3/CRffMJ7SInY7t/Bd/Gdm1eHv/y6zMnVypYr0S7YhVNWRGAWn
         75tM+sdcYEOnYl8dKrbNCJbF2bUOfaK/T5JUAaOI=
Date:   Mon, 2 Nov 2020 17:40:28 +0200
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
Message-ID: <20201102154028.GD4879@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20201101110935.GA4105325@laniakea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101110935.GA4105325@laniakea>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 01, 2020 at 12:09:35PM +0100, Hagen Paul Pfeifer wrote:
> * Mike Rapoport | 2020-09-24 16:28:58 [+0300]:
> 
> >This is an implementation of "secret" mappings backed by a file descriptor. 
> >I've dropped the boot time reservation patch for now as it is not strictly
> >required for the basic usage and can be easily added later either with or
> >without CMA.
> 
> Isn't memfd_secret currently *unnecessarily* designed to be a "one task
> feature"? memfd_secret fulfills exactly two (generic) features:
> 
> - address space isolation from kernel (aka SECRET_EXCLUSIVE, not in kernel's
>   direct map) - hide from kernel, great
> - disabling processor's memory caches against speculative-execution vulnerabilities
>   (spectre and friends, aka SECRET_UNCACHED), also great
> 
> But, what about the following use-case: implementing a hardened IPC mechanism
> where even the kernel is not aware of any data and optionally via SECRET_UNCACHED
> even the hardware caches are bypassed! With the patches we are so close to
> achieving this.
> 
> How? Shared, SECRET_EXCLUSIVE and SECRET_UNCACHED mmaped pages for IPC
> involved tasks required to know this mapping (and memfd_secret fd). After IPC
> is done, tasks can copy sensitive data from IPC pages into memfd_secret()
> pages, un-sensitive data can be used/copied everywhere.

As long as the task share the file descriptor, they can share the
secretmem pages, pretty much like normal memfd.

> One missing piece is still the secure zeroization of the page(s) if the
> mapping is closed by last process to guarantee a secure cleanup. This can
> probably done as an general mmap feature, not coupled to memfd_secret() and
> can be done independently ("reverse" MAP_UNINITIALIZED feature).

There are "init_on_alloc" and "init_on_free" kernel parameters that
enable zeroing of the pages on alloc and on free globally.
Anyway, I'll add zeroing of the freed memory to secretmem.

> PS: thank you Mike for your effort!
> 
> See the following pseudo-code as an example:
> 
> 
> // simple assume file-descriptor and mapping is inherited
> // by child for simplicity, ptr is 
> int fd = memfd_secret(SECRETMEM_UNCACHED);
> ftruncate(fd, PAGE_SIZE);
> uint32_t *ptr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 
The ptr here will be visible to both parent and child.

> pid_t pid_other;
> 
> void signal_handler(int sig)
> {
> 	// update IPC data on shared, uncachaed, exclusive mapped page
> 	*ptr += 1;
> 	// inform other
> 	sleep(1);
> 	kill(pid_other, SIGUSR1);
> }
> 
> void ipc_loop(void)
> {
> 	signal(SIGUSR1, signal_handler);
> 	while (1) {
> 		sleep(1);
> 	}
> }
> 
> int main(void)
> {
> 	pid_t child_pid;
> 
> 	switch (child_pid = fork()) {
> 	case 0:
> 		pid_other = getppid();
> 		break;
> 	default:
> 		pid_other = child_pid
> 		break;
> 	}
> 	
> 	ipc_loop();
> }
> 
> 
> Hagen
> 

-- 
Sincerely yours,
Mike.
