Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2311E8A57D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 20:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfHLSPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 14:15:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40950 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfHLSPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:15:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id c34so22365283otb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPb/gs6AfTEohzM47OUhzZWZx9HN5LoNHZy9Vz7zeGQ=;
        b=FoLztCHZdO9NKDb0KRgLBbqw3LgRtHBnaG3vel+Sg4wz3J5qKqdjr3df9IXmrMURSK
         8S9oDZO+hmHURH5QMo1RdI/FO3L8KpUOLL37dtNtkhu1W+Vm+bLz+2r4al7MYMLdVMJr
         nYSMviZj/p+hQ30H2uaKOZTgXNVEdyeyBghkdG8j38wRRd4eUVEwW6+7HNSLCbXGUChh
         1OtEVK17+qJfOu/BI/EoIbSbNFX1VBzOJCAGp0DLgZj7dcjJb0x/cjbOsfLtBBcOi6Jw
         IY2MDAh2vbNV0JXQACHQWLC/q7e5/IuAwUjq1rVpUEDXFTGQWIGbbh5aCDh+Nir4Fg/O
         Fglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPb/gs6AfTEohzM47OUhzZWZx9HN5LoNHZy9Vz7zeGQ=;
        b=FCs37smHuhTc+vOrvDyCxJskjSOifwNOEKuNRb0br3LY1BP4WPspUzJFh2YuVlMEl8
         krsCCcCao9wPYZf+aU/RnOKYDNhbuPHwRyl86+99ariLsP1GR39wgGC804TgpPctApxn
         vdDF+JWaqMEGawF6PQFBOytiduOie5R1BViUBR8dJXfUl8oTgOVNV/EdiGZi8SxemXUI
         frUc95SvOpVuLiqL4hafmyqDvMyfEwHLFEr1ntujiWrPutUONbQp4YfdLXH/+7HsO+zE
         nYZ+73s5g+puQ3ypAdq6P6siIiZpZWzVX+Scr3rCdK5WyDI+zrQ6nXM/q2QbTuW+oo8X
         V/HQ==
X-Gm-Message-State: APjAAAU0D5nz7i/nVd6gtM7z4LaJYPAMkE2gPH9p018I969KCA/ip+1H
        ohQudp3W71f76FA9V2KAW6URdYO8g9NUexKmg6VG3Q==
X-Google-Smtp-Source: APXvYqyOncFwPFHrT2+x1u/zC3aAjU5upQaF6GEoTS3EcI/IjqSXwDjFlLKtCo9id+H1HUE4ov27FunOURTDJXlBqhY=
X-Received: by 2002:a9d:774a:: with SMTP id t10mr27954353otl.228.1565633704610;
 Mon, 12 Aug 2019 11:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190807171559.182301-1-joel@joelfernandes.org>
In-Reply-To: <20190807171559.182301-1-joel@joelfernandes.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 12 Aug 2019 20:14:38 +0200
Message-ID: <CAG48ez0ysprvRiENhBkLeV9YPTN_MB18rbu2HDa2jsWo5FYR8g@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] mm/page_idle: Add per-pid idle page tracking using
 virtual index
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>,
        Daniel Colascione <dancol@google.com>, fmayer@google.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        kernel-team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>, namhyung@google.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 7, 2019 at 7:16 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
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

What happens when you use this interface on shared pages, like memory
inherited from the zygote, library file mappings and so on? If two
profilers ran concurrently for two different processes that both map
the same libraries, would they end up messing up each other's data?

Can this be used to observe which library pages other processes are
accessing, even if you don't have access to those processes, as long
as you can map the same libraries? I realize that there are already a
bunch of ways to do that with side channels and such; but if you're
adding an interface that allows this by design, it seems to me like
something that should be gated behind some sort of privilege check.

If the heap profiler is only interested in anonymous, process-private
memory, that might be an easy way out? Limit (unprivileged) use of
this interface to pages that aren't shared with any other processes?

> +/* Helper to get the start and end frame given a pos and count */
> +static int page_idle_get_frames(loff_t pos, size_t count, struct mm_struct *mm,
> +                               unsigned long *start, unsigned long *end)
> +{
> +       unsigned long max_frame;
> +
> +       /* If an mm is not given, assume we want physical frames */
> +       max_frame = mm ? (mm->task_size >> PAGE_SHIFT) : max_pfn;
> +
> +       if (pos % BITMAP_CHUNK_SIZE || count % BITMAP_CHUNK_SIZE)
> +               return -EINVAL;
> +
> +       *start = pos * BITS_PER_BYTE;
> +       if (*start >= max_frame)
> +               return -ENXIO;
> +
> +       *end = *start + count * BITS_PER_BYTE;
> +       if (*end > max_frame)
> +               *end = max_frame;
> +       return 0;
> +}

You could add some overflow checks for the multiplications. I haven't
seen any place where it actually matters, but it seems unclean; and in
particular, on a 32-bit architecture where the maximum user address is
very high (like with a 4G:4G split), it looks like this function might
theoretically return with `*start > *end`, which could be confusing to
callers.

[...]
>         for (; pfn < end_pfn; pfn++) {
>                 bit = pfn % BITMAP_CHUNK_BITS;
>                 if (!bit)
>                         *out = 0ULL;
> -               page = page_idle_get_page(pfn);
> -               if (page) {
> -                       if (page_is_idle(page)) {
> -                               /*
> -                                * The page might have been referenced via a
> -                                * pte, in which case it is not idle. Clear
> -                                * refs and recheck.
> -                                */
> -                               page_idle_clear_pte_refs(page);
> -                               if (page_is_idle(page))
> -                                       *out |= 1ULL << bit;
> -                       }
> +               page = page_idle_get_page_pfn(pfn);
> +               if (page && page_idle_pte_check(page)) {
> +                       *out |= 1ULL << bit;
>                         put_page(page);
>                 }

The `page && !page_idle_pte_check(page)` case looks like it's missing
a put_page(); you probably intended to write something like this?

    page = page_idle_get_page_pfn(pfn);
    if (page) {
        if (page_idle_pte_check(page))
            *out |= 1ULL << bit;
        put_page(page);
    }

[...]
> +/*  page_idle tracking for /proc/<pid>/page_idle */
> +
> +struct page_node {
> +       struct page *page;
> +       unsigned long addr;
> +       struct list_head list;
> +};
> +
> +struct page_idle_proc_priv {
> +       unsigned long start_addr;
> +       char *buffer;
> +       int write;
> +
> +       /* Pre-allocate and provide nodes to pte_page_idle_proc_add() */
> +       struct page_node *page_nodes;
> +       int cur_page_node;
> +       struct list_head *idle_page_list;
> +};

A linked list is a weird data structure to use if the list elements
are just consecutive array elements.

> +/*
> + * Add page to list to be set as idle later.
> + */
> +static void pte_page_idle_proc_add(struct page *page,
> +                              unsigned long addr, struct mm_walk *walk)
> +{
> +       struct page *page_get = NULL;
> +       struct page_node *pn;
> +       int bit;
> +       unsigned long frames;
> +       struct page_idle_proc_priv *priv = walk->private;
> +       u64 *chunk = (u64 *)priv->buffer;
> +
> +       if (priv->write) {
> +               VM_BUG_ON(!page);
> +
> +               /* Find whether this page was asked to be marked */
> +               frames = (addr - priv->start_addr) >> PAGE_SHIFT;
> +               bit = frames % BITMAP_CHUNK_BITS;
> +               chunk = &chunk[frames / BITMAP_CHUNK_BITS];
> +               if (((*chunk >> bit) & 1) == 0)
> +                       return;

This means that BITMAP_CHUNK_SIZE is UAPI on big-endian systems,
right? My opinion is that it would be slightly nicer to design the
UAPI such that incrementing virtual addresses are mapped to
incrementing offsets in the buffer (iow, either use bytewise access or
use little-endian), but I'm not going to ask you to redesign the UAPI
this late.

[...]
> +ssize_t page_idle_proc_generic(struct file *file, char __user *ubuff,
> +                              size_t count, loff_t *pos, int write)
> +{
[...]
> +       down_read(&mm->mmap_sem);
[...]
> +
> +       if (!write && !walk_error)
> +               ret = copy_to_user(ubuff, buffer, count);
> +
> +       up_read(&mm->mmap_sem);

I'd move the up_read() above the copy_to_user(); copy_to_user() can
block, and there's no reason to hold the mmap_sem across
copy_to_user().

Sorry about only chiming in at v5 with all this.
