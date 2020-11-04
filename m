Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CCE2A6376
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 12:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgKDLj1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 06:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgKDLj0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:39:26 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52422C0613D3;
        Wed,  4 Nov 2020 03:39:26 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4CR4SB2rQLzQlRc;
        Wed,  4 Nov 2020 12:39:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id F5663DCtL8CE; Wed,  4 Nov 2020 12:39:18 +0100 (CET)
Date:   Wed, 4 Nov 2020 12:39:13 +0100 (CET)
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
Message-ID: <1988407921.138656.1604489953944@office.mailbox.org>
In-Reply-To: <20201103163002.GK4879@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20201101110935.GA4105325@laniakea> <20201102154028.GD4879@kernel.org>
 <1547601988.128687.1604411534845@office.mailbox.org>
 <20201103163002.GK4879@kernel.org>
Subject: Re: [PATCH v6 0/6] mm: introduce memfd_secret system call to create
 "secret" memory areas
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-SPAM-Probability: **
X-Rspamd-Score: 1.58 / 15.00 / 15.00
X-Rspamd-Queue-Id: B8AE3182D
X-Rspamd-UID: 15b699
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 11/03/2020 5:30 PM Mike Rapoport <rppt@kernel.org> wrote:
> 
> > > As long as the task share the file descriptor, they can share the
> > > secretmem pages, pretty much like normal memfd.
> > 
> > Including process_vm_readv() and process_vm_writev()? Let's take a hypothetical
> > "dbus-daemon-secure" service that receives data from process A and wants to
> > copy/distribute it to data areas of N other processes. Much like dbus but without
> > SOCK_DGRAM rather direct copy into secretmem/mmap pages (ring-buffer). Should be
> > possible, right?
> 
> I'm not sure I follow you here.
> For process_vm_readv() and process_vm_writev() secremem will be only
> accessible on the local part, but not on the remote.
> So copying data to secretmem pages using process_vm_writev wouldn't
> work.

A hypothetical "dbus-daemon-secure" service will not be *process related* with communication
peers. E.g. a password-input process (reading a password into secured-memory page) will
transfer the password to dbus-daemon-secure and this service will hand-over the password to
two additional applications: a IPsec process on CPU0 und CPU1 (which itself use a
secured-memory page).

So four applications IPC chain:
 password-input -> dbus-daemon-secure -> {IPsec0, IPsec1}

- password-input: uses a secured page to read/save the password locally after reading from TTY
- dbus-daemon-secure: uses a secured page for IPC (legitimate user can write and read into the secured page)
- IPSecN has secured page to save the password locally (and probably other data as well), IPC memory is memset'ed after copy

Goal: the whole password is never saved/touched on non secured pages during IPC transfer.

Question: maybe a *file-descriptor passing* mechanism can do the trick? I.e. dbus-daemon-secure
allocates via memfd_secret/mmap secure pages and permitted processes will get the descriptor/mmaped-page
passed so they can use the pages directly?

Hagen
