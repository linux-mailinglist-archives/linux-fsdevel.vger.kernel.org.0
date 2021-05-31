Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A95A39671D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 May 2021 19:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhEaRdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 May 2021 13:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhEaRdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 May 2021 13:33:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBF1C021991
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 09:30:49 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i10so5559549lfj.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD1cRRRxJ2EzPfJboyLphgi4kVVClR9Hk5LXwRtjq5E=;
        b=gR2e7GWNWXNfbMIlZg3sJ5r6uzjbQprXL315nC/CWrnzpu9R9fj+gWh9tvlJ5F+x+4
         7I+usEyEWCvJPoR2K7gdkYVyfnuxfbdcWEFddqNlZDHTC5lZbZ0o9+kXUV+GllmkLpXp
         RiWVYgthIGZir2tXKR7P815ZOu6sYxpwf6IRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD1cRRRxJ2EzPfJboyLphgi4kVVClR9Hk5LXwRtjq5E=;
        b=QRUXgdp6/rD5R05tzou+/WTRr+v5tvX1lQLlzxeEqByOY6h+0StW9l4L5ivwM7Cu7P
         QtKqQj0NV5hnRmWCwX7jjvHqDKlUw2YeTo8Zy9tVudZ5CgycyR8UMFq3UMU9pZ8MF5PZ
         AXsnw9N+KD1vxHFGdqGeytlLITxuSvEHyePAZ/bFucEhVd53FzAEM46qlqq+RTcpCkV2
         MBLKn9Dfc9AZGiKl3XEvkygYQMqKtgF7UH5ik+AMMwgYpYqnwVHpRWC/WUwD2kVv2nj4
         fOMFYQS1+lQIxhBhclhxV0GB75AY/D8kLXl2PBNhyHc9nhvfrlQKxVQkH/Yy0NJbGz7z
         XrVg==
X-Gm-Message-State: AOAM532cPku+Gok8LMG0Fnb/uRUZovdC9bi5Q1t7HQDH7SU8ohdfqGke
        noUC4xx6m8a4Yu8UjjxiqXxpIcrjHDuJoiw8
X-Google-Smtp-Source: ABdhPJxxuvK3vBX7Yej++bYUKbdh7cU1tqnziNwQOKUs2+m4BH+hntUn3Qgc1fivqcQmyB5qr6jH3w==
X-Received: by 2002:a19:4cd5:: with SMTP id z204mr11734496lfa.74.1622478647364;
        Mon, 31 May 2021 09:30:47 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id h12sm1388913lft.289.2021.05.31.09.30.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 09:30:43 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id b18so13496264lfv.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 May 2021 09:30:41 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr14981484lfs.377.1622478640992;
 Mon, 31 May 2021 09:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210531105606.228314-1-agruenba@redhat.com>
In-Reply-To: <20210531105606.228314-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 May 2021 06:30:25 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj8EWr_D65i4oRSj2FTbrc6RdNydNNCGxeabRnwtoU=3Q@mail.gmail.com>
Message-ID: <CAHk-=wj8EWr_D65i4oRSj2FTbrc6RdNydNNCGxeabRnwtoU=3Q@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fixes for v5.13-rc5
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Adding fsdevel, because this is not limited to gfs2 ]

On Mon, May 31, 2021 at 12:56 AM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> Andreas Gruenbacher (2):
>       gfs2: Fix mmap locking for write faults

This is bogus.

I've pulled it, but this is just wrong.

A write fault on a mmap IS NOT A WRITE to the filesystem.

It's a read.

Yes, it will later then allow writes to the page, but that's entirely
immaterial - because the write is going to happen not at fault time,
but long *after* the fault, and long *after* the filesystem has
installed the page.

The actual write will happen when the kernel returns from the user space.

And no, the explanation in that commit makes no sense either:

   "When a write fault occurs, we need to take the inode glock of the underlying
    inode in exclusive mode.  Otherwise, there's no guarantee that the
dirty page
    will be written back to disk"

the thing is, FAULT_FLAG_WRITE only says that the *currently* pending
access that triggered the fault was a write. That's entirely
irrelevant to a filesystem, because

 (a) it might be a private mapping, and a write to a page will cause a
COW by the VM layer, and it's not actually a filesystem write at all

AND

 (b) if it's a shared mapping, the first access that paged things in
is likely a READ, and the page will be marked writable (because it's a
shared mapping!) and subsequent writes will not cause any faults at
all.

In other words, a filesystem that checks for FAULT_FLAG_WRITE is
_doubly_ wrong. It's absolutely never the right thing to do. It
*cannot* be the right thing to do.

And yes, some other filesystems do this crazy thing too. If your
friends jumped off a bridge, would you jump too?

The xfs and ext3/ext4 cases are wrong too - but at least they spent
five seconds (but no more) thinking about it, and they added the check
for VM_SHARED. So they are only wrong for reason (b)

But wrong is wrong. The new code is not right in gfs2, and the old
code in xfs/ext4 is not right either.

Yeah, yeah, you can - and people do - do things like "always mark the
page readable on initial page fault, use mkwrite to catch when it
becomes writable, and do timestamps carefully, at at least have full
knowledge of "something might become dirty"

But even then it is ENTIRELY BOGUS to do things like write locking.

Really.

Because the actual write HASN'T HAPPENED YET, AND YOU WILL RELEASE THE
LOCK BEFORE IT EVER DOES! So the lock? It does nothing. If you think
it protects anything at all, you're wrong.

So don't do write locking. At an absolute most, you can do things like

 - update file times (and honestly, that's quite questionable -
because again - THE WRITE HASN'T HAPPENED YET - so any tests that
depend on exact file access times to figure out when the last write
was done is not being helped by your extra code, because you're
setting the WRONG time.

 - set some "this inode will have dirty pages" flag just for some
possible future use. But honestly, if this is about consistency etc,
you need to do it not for a fault, but across the whole mmap/munmap.

So some things may be less bogus - but still very very questionable.

But locking? Bogus. Reads and writes aren't really any different from
a timestamp standpoint (if you think you need to mtime for write
accesses, you should do atime for reads, so from a filesystem
timestamp standpoint read and write faults are exactly the same - and
both are bogus, because by definition for a mmap both the reads and
the writes can then happen long long long afterwards, and repeatedly).

And if that "set some flag" thing needs a write lock, but a read
doesn't, you're doing something wrong and odd.

Look at the VM code. The VM code does this right. The mmap_sem is
taken for writing for mmap and for munmap. But a page fault is always
a read lock, even if the access that caused the page fault is a write.

The actual real honest-to-goodness *write* happens much later, and the
only time the filesystem really knows when it is done is at writeback
time. Not at fault time. So if you take locks, logically you should
take them when the fault happens, and release them when the writeback
is done.

Are you doing that? No. So don't do the write lock over the read
portion of the page fault. It is not a sensible operation.

             Linus
