Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6084A45AE9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 22:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbhKWVuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 16:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbhKWVux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:50:53 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CF9C06173E
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:47:45 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id v23so476837iom.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 13:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sUEg3QUrs08YDU9iOTMIC5pKNmifc7FDR8i4cnVmNs0=;
        b=Kqk5rqIHb4VmUjsfbj+vrwZJKE7Qq/16jkHloGZBr1jHYNXR0RQmEujqCodkmvGEGY
         AHDXxe/tMVE6D2KiYbytml65hQvnKYqqxw5NTCd0TqeExkdH0owqk2J22cO/9pslJvzG
         8gm53ZVBv8NQ1C2zxdNc+Vh3d5bEPmJYsBXidkNXSIQEE1cB70m1r6y5RPiVdkRMl57w
         t1zFJibeGrSt+MlMaboYTcYXDrWcwma4z9LkNK8KsWfRAqc1iPDH44h2WkGwqPezoYFQ
         W1ChPSI19vCnFWAe+JpExzD5SjlWle75UDVd8R0Rmg6elfFfsHHrVpa9hHGlKpd5fftO
         XbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUEg3QUrs08YDU9iOTMIC5pKNmifc7FDR8i4cnVmNs0=;
        b=7UEwwpfWycZiQyjtmA+6qftB3V1k4OXE1lkROQFd1A7vaccIGxUK6cd2T9xcabYH6+
         nDivBsUSejiLnpKwQdfpKuyR+Sp+rvNDopCrc37cnoEUcIDYomtNHXEjoDOuRbSSMTn/
         JvZVHy733EJeI6HSaX626gw8FfAkhEsavo3QI/RCuTtGTb47B96dE1c2Coml5Ji51Hxo
         /SiAuJiSly7gHoTtpiYfQEEPOUqJ4lPjzHLZksm7aIL/3gsHle7AjAvvVpp8xNv/31iY
         hXgU7RCX4IAnF4C76yNkdmxllAkh9gt3QNEYWLCBDuipsLIOUDg8cnedv3zAuk8JSSST
         2R9w==
X-Gm-Message-State: AOAM532uR+vp2kiasC/nwp4xfTYEa0qX/tt9I6RHzPy49ceNXGVa+YXN
        pvPtYtRKcm6PPSI8lLnYfOnwXBSHwgS9kqXYKVGKqA==
X-Google-Smtp-Source: ABdhPJw+V82TF1qaBVXuuWYkWY+rm9HiymOEqRm4BrdYNvCzBYJJ7rbPIH8GxSbo8QMjXkLN06+9zP0krMBu6nE5ecA=
X-Received: by 2002:a5e:cb0d:: with SMTP id p13mr8904638iom.71.1637704064568;
 Tue, 23 Nov 2021 13:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20211123000102.4052105-1-almasrymina@google.com>
 <YZ1USY+zB1PP24Z1@casper.infradead.org> <CAHS8izOhi45RqCACGGXYyB8UAmMo-85TyuNX8Myzdh81xOkBTA@mail.gmail.com>
 <YZ1ddl3FA43NijmX@casper.infradead.org>
In-Reply-To: <YZ1ddl3FA43NijmX@casper.infradead.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 23 Nov 2021 13:47:33 -0800
Message-ID: <CAHS8izMmcbXQ0xCDVYx8JW54sbbLXwNnK6pHgf9Ztn=XPFEsWA@mail.gmail.com>
Subject: Re: [PATCH v7] mm: Add PM_THP_MAPPED to /proc/pid/pagemap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 1:30 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Nov 23, 2021 at 01:10:37PM -0800, Mina Almasry wrote:
> > On Tue, Nov 23, 2021 at 12:51 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Nov 22, 2021 at 04:01:02PM -0800, Mina Almasry wrote:
> > > > Add PM_THP_MAPPED MAPPING to allow userspace to detect whether a given virt
> > > > address is currently mapped by a transparent huge page or not.  Example
> > > > use case is a process requesting THPs from the kernel (via a huge tmpfs
> > > > mount for example), for a performance critical region of memory.  The
> > > > userspace may want to query whether the kernel is actually backing this
> > > > memory by hugepages or not.
> > >
> > > So you want this bit to be clear if the memory is backed by a hugetlb
> > > page?
> > >
> >
> > Yes I believe so. I do not see value in telling the userspace that the
> > virt address is backed by a hugetlb page, since if the memory is
> > mapped by MAP_HUGETLB or is backed by a hugetlb file then the memory
> > is backed by hugetlb pages and there is no vagueness from the kernel
> > here.
> >
> > Additionally hugetlb interfaces are more size based rather than PMD or
> > not. arm64 for example supports 64K, 2MB, 32MB and 1G 'huge' pages and
> > it's an implementation detail that those sizes are mapped CONTIG PTE,
> > PMD, CONITG PMD, and PUD respectively, and the specific mapping
> > mechanism is typically not exposed to the userspace and might not be
> > stable. Assuming pagemap_hugetlb_range() == PMD_MAPPED would not
> > technically be correct.
>
> What I've been trying to communicate over the N reviews of this
> patch series is that *the same thing is about to happen to THPs*.
> Only more so.  THPs are going to be of arbitrary power-of-two size, not
> necessarily sizes supported by the hardware.  That means that we need to
> be extremely precise about what we mean by "is this a THP?"  Do we just
> mean "This is a compound page?"  Do we mean "this is mapped by a PMD?"
> Or do we mean something else?  And I feel like I haven't been able to
> get that information out of you.
>

Yes, I'm very sorry for the trouble, but I'm also confused what the
disconnect is. To allocate hugepages I can do like so:

mount -t tmpfs -o huge=always tmpfs /mnt/mytmpfs

or

madvise(..., MADV_HUGEPAGE)

Note I don't ask the kernel for a specific size, or a specific mapping
mechanism (PMD/contig PTE/contig PMD/PUD), I just ask the kernel for
'huge' pages. I would like to know whether the kernel was successful
in allocating a hugepage or not. Today a THP hugepage AFAICT is PMD
mapped + is_transparent_hugepage(), which is the check I have here. In
the future, THP may become an arbitrary power of two size, and I think
I'll need to update this querying interface once/if that gets merged
to the kernel. I.e, if in the future I allocate pages by using:

mount -t tmpfs -o huge=2MB tmpfs /mnt/mytmpfs

I need the kernel to tell me whether the mapping is 2MB size or not.

If I allocate pages by using:

mount -t tmpfs -o huge=pmd tmpfs /mnt/mytmps,

Then I need the kernel to tell me whether the pages are PMD mapped or
not, as I'm doing here.

The current implementation is based on what the current THP
implementation is in the kernel, and depending on future changes to
THP I may need to update it in the future. Does that make sense?
