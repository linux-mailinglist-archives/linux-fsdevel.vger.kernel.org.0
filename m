Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63233887FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 09:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbhESHOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 May 2021 03:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235329AbhESHOq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 May 2021 03:14:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 306EE6135B;
        Wed, 19 May 2021 07:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621408407;
        bh=Ki50aQXwD1+I3Hw9xcIirZa4MRm+9KRJ+IEPHMwhBkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYyy/RZh+KV4+OBVGMz4vRqytOJ3S6neHrNHLUg1kHLXII61rwPkBThjJAvrsmUZo
         FjnPqLIJ5kAx/qeZGbRsU6kB8hQ4Hhb8cAmXfxBQtvxU8dgEHEV4y4yEtokhAPiKIr
         /MuOkK56iFsIUVMsvkPHddFEnBeu4T4s7c6IPe+YOzaeJb9MlSBih46lnNG19GWJXN
         Dr+Kz+dEZLJXS9T0HxuiavOJs0HPv1T3S1Qsh+y5zhmE6RBkRzoRn73O2mfgQvXLJ6
         Y/WFNcW+0oFbapTux4HghodwAEaeJ7uRFxUxBZQ17d8823037Btr6+DWDVvpylUSU6
         pxMi/n2f2auLQ==
Date:   Wed, 19 May 2021 10:13:09 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v19 5/8] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <YKS6herUjtCDz7ko@kernel.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-6-rppt@kernel.org>
 <b625c5d7-bfcc-9e95-1f79-fc8b61498049@redhat.com>
 <YKDJ1L7XpJRQgSch@kernel.org>
 <YKOP5x8PPbqzcsdK@dhcp22.suse.cz>
 <8e114f09-60e4-2343-1c42-1beaf540c150@redhat.com>
 <YKOXbNWvUsqM4uxb@dhcp22.suse.cz>
 <00644dd8-edac-d3fd-a080-0a175fa9bf13@redhat.com>
 <YKOgK9eQSfgoz6eE@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKOgK9eQSfgoz6eE@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 18, 2021 at 01:08:27PM +0200, Michal Hocko wrote:
> On Tue 18-05-21 12:35:36, David Hildenbrand wrote:
> > On 18.05.21 12:31, Michal Hocko wrote:
> > >
> > > Although I have to say openly that I am not a great fan of VM_FAULT_OOM
> > > in general. It is usually a a wrong way to tell the handle the failure
> > > because it happens outside of the allocation context so you lose all the
> > > details (e.g. allocation constrains, numa policy etc.). Also whenever
> > > there is ENOMEM then the allocation itself has already made sure that
> > > all the reclaim attempts have been already depleted. Just consider an
> > > allocation with GFP_NOWAIT/NO_RETRY or similar to fail and propagate
> > > ENOMEM up the call stack. Turning that into the OOM killer sounds like a
> > > bad idea to me.  But that is a more general topic. I have tried to bring
> > > this up in the past but there was not much of an interest to fix it as
> > > it was not a pressing problem...
> > > 
> > 
> > I'm certainly interested; it would mean that we actually want to try
> > recovering from VM_FAULT_OOM in various cases, and as you state, we might
> > have to supply more information to make that work reliably.
> 
> Or maybe we want to get rid of VM_FAULT_OOM altogether... But this is
> really tangent to this discussion. The only relation is that this would
> be another place to check when somebody wants to go that direction.

If we are to get rid of VM_FAULT_OOM, vmf_error() would be updated and this
place will get the update automagically.

> > Having that said, I guess what we have here is just the same as when our
> > process fails to allocate a generic page table in __handle_mm_fault(), when
> > we fail p4d_alloc() and friends ...
> 
> From a quick look it is really similar in a sense that it effectively never
> happens and if it does then it certainly does the wrong thing. The point
> I was trying to make is that there is likely no need to go that way.

As David pointed out, failure to handle direct map in secretmem_fault() is
like any allocation failure in page fault handling and most of them result
in VM_FAULT_OOM, so I think that having vmf_error() in secretmem_fault() is
more consistent with the rest of the code than using VM_FAULT_SIGBUS.

Besides if the direct map manipulation failures would result in errors
other than -ENOMEM, having vmf_error() may prove useful.

-- 
Sincerely yours,
Mike.
