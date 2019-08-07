Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E586F8490A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 12:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfHGKAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 06:00:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42826 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbfHGKAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:00:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so40071131plb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2019 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZzlW9YyeiJ854Q1Ko1IPtbBbq0BYDBiTFOQHxFAcEc0=;
        b=tCgJHesT9hyuTLNhA2JU2/UNk19RK2nU5AFtCBJaYk5S3w1NDvpmaFeth5Yo8wYH0s
         oM4Lnuq7N9b9hZ/RVsWSEyFtN0JZddKU9+yGb3onrTbH8MixdAzzdFWXDrrSZxkzHWDG
         kUybN6h9P7J8OPDKxwZ6UTFwzfLKIdRbmfvNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZzlW9YyeiJ854Q1Ko1IPtbBbq0BYDBiTFOQHxFAcEc0=;
        b=CbTZp5a6A4Ix4mMxevcmO4mDu/lHLhKYtMOpq9fclJm+L5TZe/oF2YXorT3LFsWUcY
         gTw9sVySHgZM81T3mxRT02QZpSvD+4G4z7XsSl+mNgG9WaLgWov+zVFC/ktN8qHdzz2t
         II1fbv/S3cvi3dP0MtAxk7HtTbWyu5i6lrp9DjbP5PUHw/8990FUkzzIIx1wYW2sII0b
         2/Mjx+JJFVUJFod7gcDl/aLH69ZP7C6fAQCcihizHk0/UindhEek6Y67jEHUkf0pfK6S
         BoT/JtKIm/R+jAtQk9t9DVV1O2gmnxKON7hJgusnr4WRMMhEHd/BVrd5R3R5ieIBQsrz
         OwUg==
X-Gm-Message-State: APjAAAVsoYYmfTHNZBygK9BcBXXuxO7A983xokv11CLb9/aia5KAbHVA
        moM9wGnKONAjQzXhu/tI75PEDQ==
X-Google-Smtp-Source: APXvYqy9F4k99hNGDmUxs4p0Ff8mjnfF/NFd08nAV9/aNP72bhh+a9yeZ5zU0WZFHIFPpVKE8BbX4A==
X-Received: by 2002:aa7:9117:: with SMTP id 23mr8530297pfh.206.1565172015496;
        Wed, 07 Aug 2019 03:00:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b136sm120273213pfb.73.2019.08.07.03.00.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 03:00:14 -0700 (PDT)
Date:   Wed, 7 Aug 2019 06:00:13 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: [PATCH v4 1/5] mm/page_idle: Add per-pid idle page tracking
 using virtual indexing
Message-ID: <20190807100013.GC169551@google.com>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190806151921.edec128271caccb5214fc1bd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806151921.edec128271caccb5214fc1bd@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 03:19:21PM -0700, Andrew Morton wrote:
> (cc Brendan's other email address, hoping for review input ;))

;)

> On Mon,  5 Aug 2019 13:04:47 -0400 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > The page_idle tracking feature currently requires looking up the pagemap
> > for a process followed by interacting with /sys/kernel/mm/page_idle.
> > Looking up PFN from pagemap in Android devices is not supported by
> > unprivileged process and requires SYS_ADMIN and gives 0 for the PFN.
> > 
> > This patch adds support to directly interact with page_idle tracking at
> > the PID level by introducing a /proc/<pid>/page_idle file.  It follows
> > the exact same semantics as the global /sys/kernel/mm/page_idle, but now
> > looking up PFN through pagemap is not needed since the interface uses
> > virtual frame numbers, and at the same time also does not require
> > SYS_ADMIN.
> > 
> > In Android, we are using this for the heap profiler (heapprofd) which
> > profiles and pin points code paths which allocates and leaves memory
> > idle for long periods of time. This method solves the security issue
> > with userspace learning the PFN, and while at it is also shown to yield
> > better results than the pagemap lookup, the theory being that the window
> > where the address space can change is reduced by eliminating the
> > intermediate pagemap look up stage. In virtual address indexing, the
> > process's mmap_sem is held for the duration of the access.
> 
> Quite a lot of changes to the page_idle code.  Has this all been
> runtime tested on architectures where
> CONFIG_HAVE_ARCH_PTE_SWP_PGIDLE=n?  That could be x86 with a little
> Kconfig fiddle-for-testing-purposes.

I will do this Kconfig fiddle test with CONFIG_HAVE_ARCH_PTE_SWP_PGIDLE=n and test
the patch as well.

In previous series, this flag was not there (which should have been
equivalent to the above test), and things are working fine.

> > 8 files changed, 376 insertions(+), 45 deletions(-)
> 
> Quite a lot of new code unconditionally added to major architectures. 
> Are we confident that everyone will want this feature?

I did not follow, could you clarify more? All of this diff stat is not to
architecture code:

 arch/Kconfig                  |   3 ++
 fs/proc/base.c                |   3 ++
 fs/proc/internal.h            |   1 +
 fs/proc/task_mmu.c            |  43 +++++++++++++++++++++
 include/asm-generic/pgtable.h |   6 +++
 include/linux/page_idle.h     |   4 ++
 mm/page_idle.c                | 359 +++++++++++++++++++++++++++++..
 mm/rmap.c                     |   2 +
 8 files changed, 376 insertions(+), 45 deletions(-)

The arcitecture change is in a later patch, and is not that many lines.

Also, I am planning to split the swap functionality of the patch into a
separate one for easier review.

> > +static int proc_page_idle_open(struct inode *inode, struct file *file)
> > +{
> > +	struct mm_struct *mm;
> > +
> > +	mm = proc_mem_open(inode, PTRACE_MODE_READ);
> > +	if (IS_ERR(mm))
> > +		return PTR_ERR(mm);
> > +	file->private_data = mm;
> > +	return 0;
> > +}
> > +
> > +static int proc_page_idle_release(struct inode *inode, struct file *file)
> > +{
> > +	struct mm_struct *mm = file->private_data;
> > +
> > +	if (mm)
> 
> I suspect the test isn't needed?  proc_page_idle_release) won't be
> called if proc_page_idle_open() failed?

Yes you are right, will remove the test.

thanks,

 - Joel

