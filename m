Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEF736CA00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 19:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhD0REk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 13:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbhD0REj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:04:39 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7431CC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 10:03:56 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s16so55047605iog.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Apr 2021 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GR5JD0ns+pkMtnVUKEORcsBQhRfif8pxVKBIY8qVHxA=;
        b=QmLHoLcsn+BCVDfzUQrjwg8Xy2xVvUXFxBBU5ft+H64o4TFVvBIXxXHuqOMECGEcTO
         dtvozDEMUp4GFivPJePB0PbkV52eNybLkucfQwmJgQrhAYuEEpl8ey6u5rr7froL9831
         wYVyAxisrA82rOkudABuC3U8PenfOlk7D+S7mAqWQheynJuG+L6t550RQN2xH3AtQmcj
         YZOVPtow4jaHCIeBDjTYIj5/8GSNps1Fuw/jToYXPcH3cgKCRyqq/rZVHA/3bXXQ2Nve
         2ueglmp/SjvnojiN9svPkpekJLSz97FI7Aop3wlrKzIy55Bwfsy6mB/auPJu3BpBHN4P
         BL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GR5JD0ns+pkMtnVUKEORcsBQhRfif8pxVKBIY8qVHxA=;
        b=Niu2TH3I1KZDa+3mo7UBe/hrPUTMD9BJc16We+0GP8it+nB/uAbdHTGmTagmQ07OSZ
         nVk3X4E+dT2wvOdMZVLiMM+npDjZ/SaRDpY/o+9WbaYrcLPvSZxB9PL2RJnGA+kefhuW
         t1I9B4cBCMobrSUReUjM2VoDQwq8c88I1o1TtAWjcOXwBnqRRs9+h78QXTNptXpmcksv
         z5wjwaSrY1ZjrP/iLl+Hm3T6pDLh+NGwxH8L4B0b5dbPTThTs3cQzfLGIErv5vRLHJe7
         b8eTly2+LPabhDgkphxMfr0s3mIGOBIUrTeedGDYG1Rp3lH08Uy4lzNQ/TwHysnCsund
         XLVA==
X-Gm-Message-State: AOAM532iO28AY5Nnc6DqzAPQU1HXKfXYY3RsYWLOIkU36efiuOfE5Mnr
        JHrqYi1dAMWIJ63E6HkRXEUgmPojkf72/wAD0rb1wA==
X-Google-Smtp-Source: ABdhPJwulj3vaxVO0sHbkW6fF/E/7qJzf+HEs1+HRhzpNXwno9kM3bLiLURQiT9BXMHQwBaFd9a8rHY/eeZXQQ4/jXo=
X-Received: by 2002:a5d:9682:: with SMTP id m2mr20925814ion.20.1619543035845;
 Tue, 27 Apr 2021 10:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-5-axelrasmussen@google.com> <alpine.LSU.2.11.2104261920110.2998@eggly.anvils>
 <20210427155713.GC6820@xz-x1>
In-Reply-To: <20210427155713.GC6820@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 27 Apr 2021 10:03:20 -0700
Message-ID: <CAJHvVciKEu3F3mF3-1AC0hR5FgkKHWdHQvSkKJLwibjsW9Zb0g@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] userfaultfd/shmem: support minor fault
 registration for shmem
To:     Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ah yes, I should have modified the commit message when I swapped them
the first time - sorry for overlooking it.

As I said in the other thread, unless someone strongly objects I'll
just re-order them the other way around, minor faults first and then
CONTINUE, which resolves this concern at least.

I'm not too worried about leaving them split. Clearly we'll never
release a kernel with one but not the other. So the only scenario I
can imagine is, bisecting. But, bisecting across the range where UFFD
shmem minor faults were introduced, if you're using that feature,
won't really work out well no matter what we do. If you aren't using
this feature explicitly, then any of the configurations we've talked
about are fine.

On Tue, Apr 27, 2021 at 8:57 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Apr 26, 2021 at 07:23:57PM -0700, Hugh Dickins wrote:
> > On Tue, 20 Apr 2021, Axel Rasmussen wrote:
> >
> > > This patch allows shmem-backed VMAs to be registered for minor faults.
> > > Minor faults are appropriately relayed to userspace in the fault path,
> > > for VMAs with the relevant flag.
> > >
> > > This commit doesn't hook up the UFFDIO_CONTINUE ioctl for shmem-backed
> > > minor faults, though, so userspace doesn't yet have a way to resolve
> > > such faults.
> > >
> > > Acked-by: Peter Xu <peterx@redhat.com>
> > > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> >
> > And if this "04/10" had been numbered 03/10, I would have said
> > Acked-by: Hugh Dickins <hughd@google.com>
> >
> > Just read the comment above: "so userspace doesn't yet have a way to
> > resolve such faults" - if it doesn't by this stage, we're in trouble.
>
> Right, so merging the two patches might be easier.  Even if we don't merge
> them, we'll need to touch up the commit message since at least above paragraph
> is not true anymore as we've already have UFFDIO_CONTINUE.  Thanks,
>
> --
> Peter Xu
>
