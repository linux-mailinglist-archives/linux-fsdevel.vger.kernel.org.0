Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4293C8BD6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 17:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfHMPl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 11:41:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34496 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbfHMPl0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:41:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id c7so1598769otp.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTdtKCAFd9Jy/7ibMRAuyCjCVrja1NtEGRgDRccZP3s=;
        b=uw9/eV5N0ZExRUVoCgJf8G+srilhjSZQGDy5IBC5b4v/wcuzr+Uw4cZNlYPOWtRP+l
         3o5dtvf03dScoKE2SWAEtOoXv0C9YjnC0pVbiJQifIrMpUSH/roSYaqja1BcWza3cNqn
         tmQ70HlvmL5aGUkwVK4o0q2+NXAi3mdOjN/SjouEdsZmGxcCFsCYBAfdP0Vz0NoXuURd
         AkEbJUG2f5dTQNDs3ypBfxleNmvcO65GGXpuhvQZ4i3yRffgE/U5TP19aBcLzVtQVxu/
         oAv467iy4QAb744hHdwVvgVVHO1RAhbxc35afTD2zkqXAXWulAa0c4vJA27HYjBSRElo
         5e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTdtKCAFd9Jy/7ibMRAuyCjCVrja1NtEGRgDRccZP3s=;
        b=GhAumHyuFXek7cs50cFQNs6+MGg+xuwdG4TdY4Xjl9RlXDv7HoJkJ7wFu0UohSsBeg
         ewMu5uvS5Hel1VySVHKkY1ssMTiWqB10iJIUfu1DIozb9dy9ZelgrvTPwxcDvBLaWdlo
         FJMWgZZdZothv+0pNU09+5R/WUYODXu7xLH+kLpNgpc8F87XZntwsTbwANNr9vbSpwaD
         NZAidRIJkMqJYHnUyZCp8VKObZ9E4mPYghoUWlmn7/qef+XqGgGqWoIzxdTsiSzO+eOI
         Ycui3HIIhjkRdHntGKGxxDasZPdjC0q3i93mPLgcWMVA0ABoy0skH7wHecDyWhjpaJvv
         Gn5A==
X-Gm-Message-State: APjAAAXP14EcRgn/3nSiTojSGLdSvDvZnKNK38Sd4omqNvgx0MRu8JuY
        DjWPYpgmWZG+KLiYEYi4+RkStGXKGJOMRavFZ2dqAA==
X-Google-Smtp-Source: APXvYqy0Gr24iQpZBx4GGZNCq6qo1HJdpVtqntwwwEkKInWAr7LkPZicBlh5Px02dy2tsSSNvomzY4JkCTDDIxQJ/k8=
X-Received: by 2002:aca:dd55:: with SMTP id u82mr2003223oig.68.1565710885153;
 Tue, 13 Aug 2019 08:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <CAG48ez0ysprvRiENhBkLeV9YPTN_MB18rbu2HDa2jsWo5FYR8g@mail.gmail.com> <20190813153020.GC14622@google.com>
In-Reply-To: <20190813153020.GC14622@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 13 Aug 2019 17:40:58 +0200
Message-ID: <CAG48ez1xEt1zyMjwqS4Ysy7Vwtf4M1OOtYiPTdAmOGjViRCDvQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] mm/page_idle: Add per-pid idle page tracking using
 virtual index
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>,
        Daniel Colascione <dancol@google.com>, fmayer@google.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
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

On Tue, Aug 13, 2019 at 5:30 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> On Mon, Aug 12, 2019 at 08:14:38PM +0200, Jann Horn wrote:
> [snip]
> > > +/* Helper to get the start and end frame given a pos and count */
> > > +static int page_idle_get_frames(loff_t pos, size_t count, struct mm_struct *mm,
> > > +                               unsigned long *start, unsigned long *end)
> > > +{
> > > +       unsigned long max_frame;
> > > +
> > > +       /* If an mm is not given, assume we want physical frames */
> > > +       max_frame = mm ? (mm->task_size >> PAGE_SHIFT) : max_pfn;
> > > +
> > > +       if (pos % BITMAP_CHUNK_SIZE || count % BITMAP_CHUNK_SIZE)
> > > +               return -EINVAL;
> > > +
> > > +       *start = pos * BITS_PER_BYTE;
> > > +       if (*start >= max_frame)
> > > +               return -ENXIO;
> > > +
> > > +       *end = *start + count * BITS_PER_BYTE;
> > > +       if (*end > max_frame)
> > > +               *end = max_frame;
> > > +       return 0;
> > > +}
> >
> > You could add some overflow checks for the multiplications. I haven't
> > seen any place where it actually matters, but it seems unclean; and in
> > particular, on a 32-bit architecture where the maximum user address is
> > very high (like with a 4G:4G split), it looks like this function might
> > theoretically return with `*start > *end`, which could be confusing to
> > callers.
>
> I could store the multiplication result in unsigned long long (since we are
> bounds checking with max_frame, start > end would not occur). Something like
> the following (with extraneous casts). But I'll think some more about the
> point you are raising.

check_mul_overflow() exists and could make that a bit cleaner.


> > This means that BITMAP_CHUNK_SIZE is UAPI on big-endian systems,
> > right? My opinion is that it would be slightly nicer to design the
> > UAPI such that incrementing virtual addresses are mapped to
> > incrementing offsets in the buffer (iow, either use bytewise access or
> > use little-endian), but I'm not going to ask you to redesign the UAPI
> > this late.
>
> That would also be slow and consume more memory in userspace buffers.
> Currently, a 64-bit (8 byte) chunk accounts for 64 pages worth or 256KB.

I still wanted to use one bit per page; I just wanted to rearrange the
bits. So the first byte would always contain 8 bits corresponding to
the first 8 pages, instead of corresponding to pages 56-63 on some
systems depending on endianness. Anyway, this is a moot point, since
as you said...

> Also I wanted to keep the interface consistent with the global
> /sys/kernel/mm/page_idle interface.

Sorry, I missed that this is already UAPI in the global interface. I
agree, using a different API for the per-process interface would be a
bad idea.
