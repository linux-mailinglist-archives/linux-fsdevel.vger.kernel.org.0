Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EC82C2167
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 10:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgKXJ3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:29:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgKXJ3i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:29:38 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D202073C;
        Tue, 24 Nov 2020 09:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606210177;
        bh=iTkMZLIpRtTWQfDGIB3Vl3mRtp/b8gkTxfVBLDleW2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3bKeuXgUqKvyJMqI2t3WocMqVtq5rV80ChLv9RkXZobErCnfHPcZXypQS/ff8OIc
         k9Yt6nSUwbnDnaqXryHrQQDoC3ltsZJwF2Txq8wR9gdzisTN7cFmPk0qphW+f2nwAw
         8OtVd4ZVVbsESt0E2Fi0gLuo0Co6IDESghVXVkF8=
Date:   Tue, 24 Nov 2020 11:29:19 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [PATCH v10 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20201124092919.GI8537@kernel.org>
References: <20201123095432.5860-1-rppt@kernel.org>
 <CALCETrXr-9ABs7rzXcCrh1VXn-15AfpwjA6bQA7aU9Ta7DR+bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXr-9ABs7rzXcCrh1VXn-15AfpwjA6bQA7aU9Ta7DR+bw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 07:28:22AM -0800, Andy Lutomirski wrote:
> On Mon, Nov 23, 2020 at 1:54 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Hi,
> >
> > This is an implementation of "secret" mappings backed by a file descriptor.
> >
> > The file descriptor backing secret memory mappings is created using a
> > dedicated memfd_secret system call The desired protection mode for the
> > memory is configured using flags parameter of the system call. The mmap()
> > of the file descriptor created with memfd_secret() will create a "secret"
> > memory mapping. The pages in that mapping will be marked as not present in
> > the direct map and will have desired protection bits set in the user page
> > table. For instance, current implementation allows uncached mappings.
> 
> I'm still not ready to ACK uncached mappings on x86.  I'm fine with
> the concept of allowing privileged users to create UC memory on x86
> for testing and experimentation, but it's a big can of worms in
> general. 

Ok, let's move forward without UC. 

-- 
Sincerely yours,
Mike.
