Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8621926D333
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 07:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIQFq3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 01:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIQFq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 01:46:26 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8320C06174A;
        Wed, 16 Sep 2020 22:46:24 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id v20so1153977oiv.3;
        Wed, 16 Sep 2020 22:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=03zgBdOmJo+1h1F3YVTbbY3y6xnSeDHzXEapmphTwIw=;
        b=bbKl9UWPeRhmTphLackrhk80UEzUzcPTNe72QmMk7/fs5a/LxCxtV+mb6MSWQFVDmC
         F22yt5hvhiNFb2j/gFnw8yxBQviOrz2mlbiqk83dwMA7AkjqITFQd1eVdq1X39tqelCL
         VQYLiT8PHgFrLapRSXmMmT+MgfubVdogkhnR8iaU9CBQieW2dO0skkpZLwguhZi/JnBV
         GroqbGpDUZEjnODXLPHpOPwc0N7/cjNeafIH1QgpKVpeU6uH1eY/RuZkMDyTnjr9U7fb
         tviHseO3/70GTW4fSLc2vk/vqzCFhAHroNAVb0ANnf+lzN+TxeDA/upoZku1GEWDb8D1
         7Ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=03zgBdOmJo+1h1F3YVTbbY3y6xnSeDHzXEapmphTwIw=;
        b=R63WZ7Pzj6zQil9s3NhYYqO1MpyQ2wCRpNXtmAfUZv7Q8ehJclRc8if4sCNYjCGUTl
         tXMclYOKG/ViwaMXgz6qDslAaLv63WPsh5P4zHYzCTT/TLUFnKn3iESbIxtdOr//S5GU
         Ls8jdSa69Us4+27kpx/EZVHW7NaDytvbT6oKY2Gqf9RtZw0N/dGVJpBWjaGGizFr7TTQ
         pZ4kNBjCOBdYO3qzMikJZMmSeI7Gml7dAg39opXlTxC13kIN2otPC/Qvhpf0jtCdb/IY
         7vaAapMgH+2qow6eeHSSRoZLEpC5WOt+Y53kFUJlkYm0wm89+H7M1YJ3bu26VweqRdFX
         ZwiQ==
X-Gm-Message-State: AOAM533N2117Cm/diQzdCogRlWEGnMZsD5QYh32kEx86Yt3xaKQJSEJO
        SapTjwU+UWd4VdK8gPu0SCslKxQc404eIbpUnkA=
X-Google-Smtp-Source: ABdhPJzQezUvckVK0wvtjtSXJuH78/qLicEZ94e9jzpjFRfX1+eKqEzksVrp0ORp5rdZVfo95r94sEe5o2dL6iEln5E=
X-Received: by 2002:a54:458f:: with SMTP id z15mr3791761oib.148.1600321584018;
 Wed, 16 Sep 2020 22:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200916073539.3552-1-rppt@kernel.org> <20200916162020.0d68c2bd6711024cfcaa8bd7@linux-foundation.org>
In-Reply-To: <20200916162020.0d68c2bd6711024cfcaa8bd7@linux-foundation.org>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 17 Sep 2020 07:46:12 +0200
Message-ID: <CAKgNAkiSRDoZWKkBLB03X_knOeoeKVTy2oLmMopZ5vK8UZSAPg@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] mm: introduce memfd_secret system call to create
 "secret" memory areas
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
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
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 17 Sep 2020 at 01:20, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 16 Sep 2020 10:35:34 +0300 Mike Rapoport <rppt@kernel.org> wrote:
>
> > This is an implementation of "secret" mappings backed by a file descriptor.
> > I've dropped the boot time reservation patch for now as it is not strictly
> > required for the basic usage and can be easily added later either with or
> > without CMA.
>
> It seems early days for this, especially as regards reviewer buyin.
> But I'll toss it in there to get it some additional testing.
>
> A test suite in tools/testging/selftests/ would be helpful, especially
> for arch maintainers.
>
> I assume that user-facing manpage alterations are planned?

I was just about to write a mail into this thread when I saw this :-).

So far, I don't think I saw a manual page patch. Mike, how about it?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
