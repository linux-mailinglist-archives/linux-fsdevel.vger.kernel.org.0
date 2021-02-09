Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935B13144CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 01:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhBIAVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 19:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhBIAVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:21:03 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10421C061786
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 16:20:23 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id y5so14559883ilg.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 16:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1VHbH38hVd2unS1khB8XzowmfD50y/QcVJ8OqQemiA=;
        b=VXhaa90/Z2Zb+FtG4H/Phr8KuO5zRwT4E6hUNyeaNCRApzVU5EOrIxkZ3bj7hPOm/x
         X8028kcGTs0CQDu0SW7KCA8BCrIf2PvzEVJ9M17EGH+oWSOiuzxw9iZT7tgVqGxXmaEC
         Nr3WHiVepYslkaRCpXoJRqbK6S/XuTS2tgjrc4Un0PgTRkfAFwbRkZpAdL9nbzSE1XXO
         8anhP15uS9tPI/J2kfPkAULPpi973StvEr5MtPquBSpvLShqa8U16N5wb6Mg2MTj/Phh
         0hw9Y3b5WzuwADEmznofiyqJTePWjvi9wI6VzcBCaB8outK3j3OyBCBwwDF+YgMZMu7Q
         N8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1VHbH38hVd2unS1khB8XzowmfD50y/QcVJ8OqQemiA=;
        b=Ub5wGsxaplvfs1oFdSnAU+wNAHxCxuGPcwRjE/aLE6eoEauJ5jJ38QAIA7LeA2plXl
         Z11O9nFVxAyZ7rGaV+Hr0ov/BgF4CnQzeHgO3ljxFcd1fbClvjB7PSGYYqVsesuJLafE
         JTv5cbfYsAxvSvSglz9bZEfQbzamgVI2xlZPb9OKH7vhKzz/SD1nLDtwaKn/TqS4MRCs
         4yPxcx1ZhfpRcv+mK/8wfYfMuiPkskZ+0yYkZNLD8q2rFPObPY/1M4dcNBCKCJO9Sjkh
         YO2NEXRnHeP21RUZfmUtPmx7LBdmfn9u2Qui4xK3TcEfRp67VNhaBbvCR/WL8yrWljGg
         /JlA==
X-Gm-Message-State: AOAM532twEnSB4zbaFMWTaeKo5FtD/jcLDzBcPim0YQuiFLTIJ38D8Mo
        Hqjk2DluQNz6C6Jl1WrL2AkESjNseBXb02DinR+7OQ==
X-Google-Smtp-Source: ABdhPJyPH1R03Nt8wDlrMvtg9sUGZmMpUXU2ipBTH5FZKtV6/hMAlksqAdcXPt8RgulBJ6wBtwFCTKCoYfpE14nFOT8=
X-Received: by 2002:a05:6e02:1246:: with SMTP id j6mr18800954ilq.85.1612830022313;
 Mon, 08 Feb 2021 16:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20210204183433.1431202-1-axelrasmussen@google.com> <20210209000343.GB78818@xz-x1>
In-Reply-To: <20210209000343.GB78818@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 8 Feb 2021 16:19:45 -0800
Message-ID: <CAJHvVcgLCvB7dCyTdGkRK2xVPkKuvXQ3K8SNmNJnXxP4Dp092w@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] userfaultfd: add minor fault handling
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 8, 2021 at 4:03 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Feb 04, 2021 at 10:34:23AM -0800, Axel Rasmussen wrote:
> > - Split out adding #ifdef CONFIG_USERFAULTFD to a separate patch (instead of
> >   lumping it together with adding UFFDIO_CONTINUE). Also, extended it to make
> >   the same change for shmem as well as suggested by Hugh Dickins.
>
> It seems you didn't extend it to shmem yet. :) But I think it's fine - it can
> always be done as a separate patch then when you work on shmem, or even post it
> along.  Thanks,

Ah, indeed, sorry about this.

I had originally planned to only do hugetlb, but then added shmem
based on Hugh's comments. And then, later reverted the shmem parts as
per the original plan, after some additional discussion with Hugh. I
wrote the changelog entry somewhere in the middle of that, and forgot
to update it. :)

>
> --
> Peter Xu
>
