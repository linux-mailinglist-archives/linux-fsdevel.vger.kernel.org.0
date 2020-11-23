Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02F12C0ED7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 16:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbgKWP2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 10:28:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732043AbgKWP2k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:28:40 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97678221F1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606145319;
        bh=brIo8Xk+cpg0T6s0IpQa46LwLk4mVPqFLLwG7n90WGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NQZmlnHOZiaM7ybcSwWzusNQy1pIzNLZhcrN2FxiI5VI77KySCK6gXqHvbc4GeRrP
         YSCkK4YhIEwNNqxjz0cYUoQdSP0hpYXSadkkeXAKDctf0PJDujPReGf2go++Ttg8qu
         rA7cZa4607GuG26Tp3k6RmHtRqCHyFe1H0bZsEVY=
Received: by mail-wm1-f44.google.com with SMTP id h21so17621387wmb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 07:28:39 -0800 (PST)
X-Gm-Message-State: AOAM531lZBhQpQVrftL+cYRaXDWzRPcWw1Sq+rub6JTdoDyvovg7SAP+
        0RUik/gs9Rj9n9IbaTj76ty4OpjI5FBKlz1x/rMMpw==
X-Google-Smtp-Source: ABdhPJzEhjqlImvathm/jOwbcq17IbRsly+UVqGOW3wf5Zw5ZyQfK4pkOn8rE+oX1x7EWd6oQaZF3bxA3Eqxcxk30tI=
X-Received: by 2002:a1c:e0c3:: with SMTP id x186mr24542133wmg.21.1606145315717;
 Mon, 23 Nov 2020 07:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20201123095432.5860-1-rppt@kernel.org>
In-Reply-To: <20201123095432.5860-1-rppt@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Nov 2020 07:28:22 -0800
X-Gmail-Original-Message-ID: <CALCETrXr-9ABs7rzXcCrh1VXn-15AfpwjA6bQA7aU9Ta7DR+bw@mail.gmail.com>
Message-ID: <CALCETrXr-9ABs7rzXcCrh1VXn-15AfpwjA6bQA7aU9Ta7DR+bw@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
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
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-riscv@lists.infradead.org, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 1:54 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Hi,
>
> This is an implementation of "secret" mappings backed by a file descriptor.
>
> The file descriptor backing secret memory mappings is created using a
> dedicated memfd_secret system call The desired protection mode for the
> memory is configured using flags parameter of the system call. The mmap()
> of the file descriptor created with memfd_secret() will create a "secret"
> memory mapping. The pages in that mapping will be marked as not present in
> the direct map and will have desired protection bits set in the user page
> table. For instance, current implementation allows uncached mappings.

I'm still not ready to ACK uncached mappings on x86.  I'm fine with
the concept of allowing privileged users to create UC memory on x86
for testing and experimentation, but it's a big can of worms in
general.  The issues that immediately come to mind are:

- Performance and DoS potential.  UC will have bizarre, architecture-
and platform-dependent performance characteristics.  For all I know,
even the access semantics might be architecture dependent.  I'm not
convinced it's possible to write portable code in C using the uncached
feature.  I'm also concerned that certain operation (unaligned locks,
for example, and possibly any locked access) will trigger bus locks on
x86, which, depending on CPU and kernel config will either DoS all
other CPUs or send signals.  (Or cause the hypervisor to terminate or
otherwise penalize the the VM, which would be nasty.)

 - Correctness.  I have reports that different x86 hypervisors do
different things with UC mappings, including treating them as regular
WB mappings.  So the memory type you get out when you ask for
"uncached" might not actually be uncached.

UC is really an MMIO feature, not a "protect my data" feature.
Abusing it to protect data is certainly interesting, but I'm far from
convinced that it's wise.  I'm especially unconvinced that
monkey-patching a program to use uncached memory when it expects
regular malloced memory is a reasonable thing to do.
