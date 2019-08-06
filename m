Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A9083D47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2019 00:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfHFWTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 18:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfHFWTY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:19:24 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB7B121874;
        Tue,  6 Aug 2019 22:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565129963;
        bh=uggloegaAwke9A4UP4qBuMyVFR/d5SRDz42VgcGIwio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=meFIABtuhORcSvMNLD1Hv0nThWvFZI0Qr53BkMiWwh6sZaACsB8AxS19EWRhOD245
         XPjeM7EQeanIE0mnWrDAF2RVaT5KRg5MyslBzowrxK7IAG3AckB1mYjDZTe7CHOPId
         5LjvjYRK0qyrzcwOxuFdWnbt8prbQySEv0+MClOM=
Date:   Tue, 6 Aug 2019 15:19:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, joelaf@google.com,
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
Message-Id: <20190806151921.edec128271caccb5214fc1bd@linux-foundation.org>
In-Reply-To: <20190805170451.26009-1-joel@joelfernandes.org>
References: <20190805170451.26009-1-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(cc Brendan's other email address, hoping for review input ;))

On Mon,  5 Aug 2019 13:04:47 -0400 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> The page_idle tracking feature currently requires looking up the pagemap
> for a process followed by interacting with /sys/kernel/mm/page_idle.
> Looking up PFN from pagemap in Android devices is not supported by
> unprivileged process and requires SYS_ADMIN and gives 0 for the PFN.
> 
> This patch adds support to directly interact with page_idle tracking at
> the PID level by introducing a /proc/<pid>/page_idle file.  It follows
> the exact same semantics as the global /sys/kernel/mm/page_idle, but now
> looking up PFN through pagemap is not needed since the interface uses
> virtual frame numbers, and at the same time also does not require
> SYS_ADMIN.
> 
> In Android, we are using this for the heap profiler (heapprofd) which
> profiles and pin points code paths which allocates and leaves memory
> idle for long periods of time. This method solves the security issue
> with userspace learning the PFN, and while at it is also shown to yield
> better results than the pagemap lookup, the theory being that the window
> where the address space can change is reduced by eliminating the
> intermediate pagemap look up stage. In virtual address indexing, the
> process's mmap_sem is held for the duration of the access.

Quite a lot of changes to the page_idle code.  Has this all been
runtime tested on architectures where
CONFIG_HAVE_ARCH_PTE_SWP_PGIDLE=n?  That could be x86 with a little
Kconfig fiddle-for-testing-purposes.

> 8 files changed, 376 insertions(+), 45 deletions(-)

Quite a lot of new code unconditionally added to major architectures. 
Are we confident that everyone will want this feature?

>
> ...
>
> +static int proc_page_idle_open(struct inode *inode, struct file *file)
> +{
> +	struct mm_struct *mm;
> +
> +	mm = proc_mem_open(inode, PTRACE_MODE_READ);
> +	if (IS_ERR(mm))
> +		return PTR_ERR(mm);
> +	file->private_data = mm;
> +	return 0;
> +}
> +
> +static int proc_page_idle_release(struct inode *inode, struct file *file)
> +{
> +	struct mm_struct *mm = file->private_data;
> +
> +	if (mm)

I suspect the test isn't needed?  proc_page_idle_release) won't be
called if proc_page_idle_open() failed?

> +		mmdrop(mm);
> +	return 0;
> +}
>
> ...
>
