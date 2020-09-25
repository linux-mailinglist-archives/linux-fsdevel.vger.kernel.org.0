Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212312780D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 08:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgIYGnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 02:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgIYGnP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:43:15 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 648B621D91;
        Fri, 25 Sep 2020 06:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601016194;
        bh=w9IKlZIfJMsHxegJ+VLXCONApnJkHjt/WLrJovIxo84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gp4/PTjOTCt6wK+y6cBEuicvnrMX77A7MiRNbWPoUrNLDFWXc7dXI8MhLKiFWXqsv
         W10CVzH2Sh5bikH6aMEPT2GD6WMerz6IjUQAM+CvT/52Z2l6KeVLCZlvbVQ+NG092g
         JDBOaIbH10dUGBs84yFpT+eEft/TvzNhegpH41cU=
Date:   Fri, 25 Sep 2020 09:42:57 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20200925064257.GX2142832@kernel.org>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924193428.6642e0cc3436bb67ddf8024a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924193428.6642e0cc3436bb67ddf8024a@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 07:34:28PM -0700, Andrew Morton wrote:
> On Thu, 24 Sep 2020 16:28:58 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Hi,
> > 
> > This is an implementation of "secret" mappings backed by a file descriptor. 
> > I've dropped the boot time reservation patch for now as it is not strictly
> > required for the basic usage and can be easily added later either with or
> > without CMA.
> > 
> > ...
> > 
> > The file descriptor backing secret memory mappings is created using a
> > dedicated memfd_secret system call The desired protection mode for the
> > memory is configured using flags parameter of the system call. The mmap()
> > of the file descriptor created with memfd_secret() will create a "secret"
> > memory mapping. The pages in that mapping will be marked as not present in
> > the direct map and will have desired protection bits set in the user page
> > table. For instance, current implementation allows uncached mappings.
> > 
> > Although normally Linux userspace mappings are protected from other users, 
> > such secret mappings are useful for environments where a hostile tenant is
> > trying to trick the kernel into giving them access to other tenants
> > mappings.
> > 
> > Additionally, the secret mappings may be used as a mean to protect guest
> > memory in a virtual machine host.
> > 
> > For demonstration of secret memory usage we've created a userspace library
> > [1] that does two things: the first is act as a preloader for openssl to
> 
> I can find no [1].

Oops, sorry. It's

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/secret-memory-preloader.git/

> I'm not a fan of the enumerated footnote thing.  Why not inline the url
> right here so readers don't need to jump around?
> 
> 

-- 
Sincerely yours,
Mike.
