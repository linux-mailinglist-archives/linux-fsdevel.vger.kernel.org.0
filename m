Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C9D30F39E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 14:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhBDNDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 08:03:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:60492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235605AbhBDNDS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:03:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612443751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wV8EqN+aFKtqheOmivykKqrk3VRFPc84lBWqlqC5mhU=;
        b=S7Xu1febLmS5kX17RFiu9leCmCOiW9bK6FTrsMR2Jq0CsMxFWmSj/7op1/f5ZRchTgMx+j
        uSPvUPPXzRr5VU/1T1ZLM4jeXWSC2IFbCMDFHTmNpt6au1H3cEF5IIgqfbC1nYh3XxULs8
        p/mDOwECvwFm5KBo63/LgBI2SMBdvnU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9EA16AC97;
        Thu,  4 Feb 2021 13:02:31 +0000 (UTC)
Date:   Thu, 4 Feb 2021 14:02:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <YBvwXmYt7vJ4tvuv@dhcp22.suse.cz>
References: <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
 <73738cda43236b5ac2714e228af362b67a712f5d.camel@linux.ibm.com>
 <YBPF8ETGBHUzxaZR@dhcp22.suse.cz>
 <6de6b9f9c2d28eecc494e7db6ffbedc262317e11.camel@linux.ibm.com>
 <YBkcyQsky2scjEcP@dhcp22.suse.cz>
 <20210202124857.GN242749@kernel.org>
 <YBlTMqjB06aqyGbT@dhcp22.suse.cz>
 <20210202191040.GP242749@kernel.org>
 <YBpo9mC5feVQ0mpG@dhcp22.suse.cz>
 <20210204095855.GQ242749@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204095855.GQ242749@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 04-02-21 11:58:55, Mike Rapoport wrote:
> On Wed, Feb 03, 2021 at 10:12:22AM +0100, Michal Hocko wrote:
[...]
> > Wrt to the specific syscall, please document why existing interfaces are
> > not a good fit as well. It would be also great to describe interaction
> > with mlock itself (I assume the two to be incompatible - mlock will fail
> > on and mlockall will ignore it).
> 
> The interaction with mlock() belongs more to the man page, but I don't mind
> adding this to changelog as well.

I would expect this to be explicitly handled in the patch - thus the
changelog rationale.
-- 
Michal Hocko
SUSE Labs
