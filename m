Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C7E2A1D86
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 12:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgKALJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 06:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgKALJx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 06:09:53 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D07C0617A6;
        Sun,  1 Nov 2020 03:09:53 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4CPCxT5LHFzQjy2;
        Sun,  1 Nov 2020 12:09:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 0NqHY5bM4ywr; Sun,  1 Nov 2020 12:09:42 +0100 (CET)
Date:   Sun, 1 Nov 2020 12:09:35 +0100
From:   Hagen Paul Pfeifer <hagen@jauu.net>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <20201101110935.GA4105325@laniakea>
References: <20200924132904.1391-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924132904.1391-1-rppt@kernel.org>
X-Key-Id: 98350C22
X-Key-Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
X-GPG-Key: gpg --recv-keys --keyserver wwwkeys.eu.pgp.net 98350C22
X-MBO-SPAM-Probability: *
X-Rspamd-Score: 0.32 / 15.00 / 15.00
X-Rspamd-Queue-Id: EBDB416FE
X-Rspamd-UID: bd1d51
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Mike Rapoport | 2020-09-24 16:28:58 [+0300]:

>This is an implementation of "secret" mappings backed by a file descriptor. 
>I've dropped the boot time reservation patch for now as it is not strictly
>required for the basic usage and can be easily added later either with or
>without CMA.

Isn't memfd_secret currently *unnecessarily* designed to be a "one task
feature"? memfd_secret fulfills exactly two (generic) features:

- address space isolation from kernel (aka SECRET_EXCLUSIVE, not in kernel's
  direct map) - hide from kernel, great
- disabling processor's memory caches against speculative-execution vulnerabilities
  (spectre and friends, aka SECRET_UNCACHED), also great

But, what about the following use-case: implementing a hardened IPC mechanism
where even the kernel is not aware of any data and optionally via SECRET_UNCACHED
even the hardware caches are bypassed! With the patches we are so close to
achieving this.

How? Shared, SECRET_EXCLUSIVE and SECRET_UNCACHED mmaped pages for IPC
involved tasks required to know this mapping (and memfd_secret fd). After IPC
is done, tasks can copy sensitive data from IPC pages into memfd_secret()
pages, un-sensitive data can be used/copied everywhere.

One missing piece is still the secure zeroization of the page(s) if the
mapping is closed by last process to guarantee a secure cleanup. This can
probably done as an general mmap feature, not coupled to memfd_secret() and
can be done independently ("reverse" MAP_UNINITIALIZED feature).

PS: thank you Mike for your effort!

See the following pseudo-code as an example:


// simple assume file-descriptor and mapping is inherited
// by child for simplicity, ptr is 
int fd = memfd_secret(SECRETMEM_UNCACHED);
ftruncate(fd, PAGE_SIZE);
uint32_t *ptr = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

pid_t pid_other;

void signal_handler(int sig)
{
	// update IPC data on shared, uncachaed, exclusive mapped page
	*ptr += 1;
	// inform other
	sleep(1);
	kill(pid_other, SIGUSR1);
}

void ipc_loop(void)
{
	signal(SIGUSR1, signal_handler);
	while (1) {
		sleep(1);
	}
}

int main(void)
{
	pid_t child_pid;

	switch (child_pid = fork()) {
	case 0:
		pid_other = getppid();
		break;
	default:
		pid_other = child_pid
		break;
	}
	
	ipc_loop();
}


Hagen
