Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24CBE130492
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 22:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgADVQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 16:16:16 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44324 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgADVQQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:16:16 -0500
Received: by mail-io1-f65.google.com with SMTP id b10so44722867iof.11;
        Sat, 04 Jan 2020 13:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snCBX0j5ay9kgj6iZfPL2/aocexXLHXt8hsG7KfcQKY=;
        b=H0NUm63m1Oa+7DyTVnNJc/PlM5/UteN16n7bvwASZASu8wmJEzHg97yJ9jNyu1JFys
         UEzWGhX7D2cAUsw5lwf9q3KwM+AC1hFNyQDDuycsUAWzJJRQsE/aTrfnr43420ebgOoz
         Tf5v9J6K/Lu2NiafplulCkrh42anLxLtoTjRkve4VnLzO/EBakjavSFufAfk9gDamY/f
         TFMKQvcXqoU6ustmDPPDEsB9mgp+EzplBKZtpOUIL2emCqu4Lu6agAWcf6RG8uYMLQCh
         MWI5+wZ1pA2/SHfxX/y/jyFugDX0duj0BoayGr6n8r/dulX03T5djGNYVJwmvFQBwKrx
         m51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snCBX0j5ay9kgj6iZfPL2/aocexXLHXt8hsG7KfcQKY=;
        b=WabzXcWpGb+QK6ymQqDSGjWXweD7RUfgWMoaUIIkMtbYbA8W8PGKgsDO0X6G48xZNT
         h5n71rYe1/xCWAimMNW3zaWxoHgcADv+2lNQA/DbkmZvCRbaGuz5wiqzqXyfGk+ecinJ
         uGcWD0NxMo6fyPGDlWo06ku0yoMaS7HbzI3iNpzYcAwpeRDLqd6+jbfdUnkN5s4htK35
         vVAznoVH+XYdG1uAE2VOqTREAqMck9EZdFzxPLK+Wp57uc52rT2CxYO2W/OQci+Ub4Ox
         zBXHx/krLo7bFabtR21oDio47M3QRbVUUIg7Uhw6oVvI5aRlh+8VSYEEjSmnBkpbvP37
         pVcw==
X-Gm-Message-State: APjAAAVvAugB9CZmLEzMDiZzf31+53AuGCaLk7JtCkM0gVhVF5R/6N6S
        AEiF+19xXt86IBOtDaE2DbgPck4CO5yH4cHJnAw=
X-Google-Smtp-Source: APXvYqwpNX0oJAGFb7plxGj+mrk/pVD85S5jglSWMAHsjkX180fee7do9kPBZ3lFzsuac3e1xHxfVdTrHJ0kodA7IoQ=
X-Received: by 2002:a6b:5904:: with SMTP id n4mr65813651iob.9.1578172575756;
 Sat, 04 Jan 2020 13:16:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578072481.git.chris@chrisdown.name>
In-Reply-To: <cover.1578072481.git.chris@chrisdown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 4 Jan 2020 23:16:04 +0200
Message-ID: <CAOQ4uxhC6L6whNyc6bs99ZcMRxMOt5xNR0HMKmJ8w1thXgO+zw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] fs: inode: shmem: Reduce risk of inum overflow
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Hugh Dickins <hughd@google.com>,
        "zhengbin (A)" <zhengbin13@huawei.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 3, 2020 at 7:30 PM Chris Down <chris@chrisdown.name> wrote:
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
>    (ioctl(...FS_IOC_GETVERSION...) returns ENOTTY on tmpfs);
> 2. Even with generation, there shouldn't be two live inodes with the
>    same inode number on one device.
>
> In order to mitigate this, we take a two-pronged approach:
>
> 1. Moving inum generation from being global to per-sb for tmpfs. This
>    itself allows some reduction in i_ino churn. This works on both 64-
>    and 32- bit machines.
> 2. Adding inode{64,32} for tmpfs. This fix is supported on machines with
>    64-bit ino_t only: we allow users to mount tmpfs with a new inode64
>    option that uses the full width of ino_t, or CONFIG_TMPFS_INODE64.
>
> Chris Down (2):
>   tmpfs: Add per-superblock i_ino support
>   tmpfs: Support 64-bit inums per-sb
>
>  Documentation/filesystems/tmpfs.txt | 11 ++++
>  fs/Kconfig                          | 15 +++++
>  include/linux/shmem_fs.h            |  2 +
>  mm/shmem.c                          | 97 ++++++++++++++++++++++++++++-
>  4 files changed, 124 insertions(+), 1 deletion(-)
>

CC tmpfs maintainer, linux-mm and Andrew Morton, who is the one sending
most of the tmpfs patches to Linus.

Also worth mentioning these previous attempts by zhengbin, which was trying to
address the same problem without the per-sb ino counter approach:

https://patchwork.kernel.org/patch/11254001/
https://patchwork.kernel.org/patch/11023915/

Thanks,
Amir.
