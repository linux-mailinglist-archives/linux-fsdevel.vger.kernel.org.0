Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DE93796C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 20:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhEJSDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 14:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231499AbhEJSDo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 14:03:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94CA1614A5;
        Mon, 10 May 2021 18:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620669758;
        bh=n42L871tHZ441F87A/b+CutETfOOFwkObERFP9A3pdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jAVU4p1uzu94ulPZBeoZfk4s2+0oKep8O35dEH9B3XGOnfBOez0cqT9O/YPNWcq7K
         T7jehq1COHzvQk562M5QFEuz58iBsW6GnwPXjhA/cVyTt1N3jxE15rCZgZHKILMpn/
         j2uFJ1Qhe2ksUV0APrDOdlb2LHSBV6/yEmdkTakyE7eMIf2Gd3PEcDYmfuilpYxdEE
         J2LthyZVJKGF4qAs0eL5J6Nek5zNOrWq6FoOABkHN+M7vDleC7VZQX3j2kIx/+Qboo
         1/WODQxulH/sCuGBwe0ku+eYg7lCepVzxRaMSgvNWQxZ05b1ox+NqaPNhK7RwoJCp7
         a38PA1z3yoBmQ==
Date:   Mon, 10 May 2021 21:02:21 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <YJl1LQvQuxxfGRnJ@kernel.org>
References: <20210303162209.8609-1-rppt@kernel.org>
 <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
 <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
 <202105060916.ECDEC21@keescook>
 <9e1953a1412fad06a9f7988a280d2d9a74ab0464.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e1953a1412fad06a9f7988a280d2d9a74ab0464.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 06, 2021 at 11:47:47AM -0700, James Bottomley wrote:
> On Thu, 2021-05-06 at 10:33 -0700, Kees Cook wrote:
> > On Thu, May 06, 2021 at 08:26:41AM -0700, James Bottomley wrote:
> 
> > What's happening with O_CLOEXEC in this code? I don't see that
> > mentioned in the cover letter either. Why is it disallowed? That
> > seems a strange limitation for something trying to avoid leaking
> > secrets into other processes.
> 
> I actually thought we forced it, so I'll let Mike address this.  I
> think allowing it is great, so the secret memory isn't inherited by
> children, but I can see use cases where a process would want its child
> to inherit the secrets.

We do not enforce O_CLOEXEC, but if the user explicitly requested O_CLOEXEC
it would be passed to get_unused_fd_flags().

-- 
Sincerely yours,
Mike.
