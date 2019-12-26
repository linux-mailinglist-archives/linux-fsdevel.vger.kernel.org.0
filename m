Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB1212ADCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 19:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfLZSEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 13:04:12 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42017 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfLZSEL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 13:04:11 -0500
Received: by mail-io1-f67.google.com with SMTP id n11so17112167iom.9;
        Thu, 26 Dec 2019 10:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftEiq2g1C6i1qkX10ktSzMbKjMJjtzyUZBsgYVT1Lxk=;
        b=Wc0FJNndxndkBLZV4POgh5Uc3rCzfhvUDGJky7WJveSJJFHwyWTgP0iB/1jcrYi5/o
         cssU45YXq0fVZftjArJSAFVpPPDtq99n0eJ/RmX9Lx6VE6UE4P9zGduc5wqclDhG9L1t
         fjRSof3yuyYrK1l1RAVC8HPSQiDvQMoqbFz8wQcXNtTIApeUuY2KtYAoxNBmdtk7Gf12
         pjnK39DXZ++v6FmzkwGLo89N9XpsNOdSsSU17CQzLAnWooZ2SEv4W4r22e5VF/kM3PzT
         S4fhYrhb/EiUjZ7dZmuReHwGCHMRaacJ34fyO0lLRp4vd4Rl3rK1AdBltqMe1nijEnT3
         rq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftEiq2g1C6i1qkX10ktSzMbKjMJjtzyUZBsgYVT1Lxk=;
        b=mqC/Zc/AXOZmXTsWFI8ZyVAi6ovSBfujk3TNPbjQCHyRAFdfomdlams+DAK8Mkc8w6
         W2H/yG577Z27RcnpHaIuD/QM+0aVOgV6/3XNu5D4qrFdUm4FxEgKf/9Hk+ThQTLv3Our
         L91hDLZbdv8UGxsZCw8B3rjv3rcRNq9iJzlrCh/wzIvU8nntDjOkibZC6KAvijlIZxbS
         1/it7WJpKP73/spmFnKReo5cOVrQBAQqBPR8Jv8vPBIvtjfD6nKOyDLTww9YRwJmX8Ve
         Coi/J0txYGC3cuDpLCtPohNADa37MbuAmJAVd3exNOIThxchjQiP0Zu329ojCt5ECelX
         oZvg==
X-Gm-Message-State: APjAAAUeJr2hLcMWG6zBeIBPmQCqm3jFWf+tFOT5aoSazs1fRvvNyAy0
        3stXmzix6ODkaZIsxmJUOAweWhyZGNL2hLNA0rnHP7x+
X-Google-Smtp-Source: APXvYqx+5kOxu9osxQO6HzjPbqeFgVy/n0ZQpT5CbOMbuUksbxWq0m/zBFsvNLaiACWV9ngoz5K4ElKirPMbtnA105Q=
X-Received: by 2002:a05:6602:280b:: with SMTP id d11mr31551395ioe.250.1577383451097;
 Thu, 26 Dec 2019 10:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20191226154808.GA418948@chrisdown.name>
In-Reply-To: <20191226154808.GA418948@chrisdown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 26 Dec 2019 20:04:00 +0200
Message-ID: <CAOQ4uxj8NVwrCTswut+icF2t1-7gtW_cmyuGO7WUWdNZLHOBYA@mail.gmail.com>
Subject: Re: [PATCH] fs: inode: Recycle inodenum from volatile inode slabs
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        "zhengbin (A)" <zhengbin13@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 26, 2019 at 5:48 PM Chris Down <chris@chrisdown.name> wrote:
>
> In Facebook production we are seeing heavy i_ino wraparounds on tmpfs.
> On affected tiers, in excess of 10% of hosts show multiple files with
> different content and the same inode number, with some servers even
> having as many as 150 duplicated inode numbers with differing file
> content.
>
> This causes actual, tangible problems in production. For example, we
> have complaints from those working on remote caches that their
> application is reporting cache corruptions because it uses (device,
> inodenum) to establish the identity of a particular cache object, but
> because it's not unique any more, the application refuses to continue
> and reports cache corruption. Even worse, sometimes applications may not
> even detect the corruption but may continue anyway, causing phantom and
> hard to debug behaviour.
>
> In general, userspace applications expect that (device, inodenum) should
> be enough to be uniquely point to one inode, which seems fair enough.
> One might also need to check the generation, but in this case:
>
> 1. That's not currently exposed to userspace
>    (ioctl(...FS_IOC_GETVERSION...) returns ENOTTY);
> 2. Even with generation, there shouldn't be two live inodes with the
>    same inode number on one device.
>
> In order to fix this, we reuse inode numbers from recycled slabs where
> possible, allowing us to significantly reduce the risk of 32 bit
> wraparound.
>
> There are probably some other potential users of this, like some FUSE
> internals, and {proc,sys,kern}fs style APIs, but doing a general opt-out
> codemod requires some thinking depending on the particular callsites and
> how far up the stack they are, we might end up recycling an i_ino value
> that actually does have some semantic meaning. As such, to start with
> this patch only opts in a few get_next_ino-heavy filesystems, and those
> which looked straightforward and without likelihood for corner cases:
>
> - bpffs
> - configfs
> - debugfs
> - efivarfs
> - hugetlbfs
> - ramfs
> - tmpfs
>

I'm confused about this list.
I suggested to convert tmpfs and hugetlbfs because they use a private
inode cache pool, therefore, you can know for sure that a recycled i_ino
was allocated by get_next_ino().

If I am not mistaken, other fs above are using the common inode_cache
pool, so when you recycle i_ino from that pool you don't know where it
came from and cannot trust its uniqueness in the get_next_ino() domain.
Even if *all* filesystems that currently use common inode_cache use
get_next_ino() exclusively to allocate ino numbers, that could change
in the future.

I'd go even further to say that introducing a generic helper for this sort
of thing is asking for trouble. It is best to keep the recycle logic well within
the bounds of the specific filesystem driver, which is the owner of the
private inode cache and the responsible for allocating ino numbers in
this pool.

Thanks and happy holidays,
Amir.
