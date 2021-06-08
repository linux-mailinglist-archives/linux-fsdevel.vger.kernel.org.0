Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA939FABF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 17:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhFHPcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 11:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhFHPcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:32:51 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EC6C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Jun 2021 08:30:58 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id w5so11702331uaq.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Jun 2021 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLC1VscdPqSJYVpzQ5Bq3gu0Xgl1STx2OEc2dy3w/yU=;
        b=WwKDnaaLZobVffpwehInls8xm4rZL8a9mJC8aXHaD5gIpng4pwjkd88XF0FOtVuy0D
         klHCljG8yyk83fAJlbKH6pQGAeZX7o4UNqolSOF3AZ/qySis3n8eCE750oNouNlIg/K/
         5YkRSwH0H3mgHcxLfUbpjRMTYAHroDHPyccMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLC1VscdPqSJYVpzQ5Bq3gu0Xgl1STx2OEc2dy3w/yU=;
        b=kQCHHu8JDfJ2ftbgSsCzWKOvgyrWwiQNA8MONrwAMGHl9u7MIGQGeI9Cw8UIX6M/hJ
         xw+vjBYsKNUWN9d0r53m1PaMkgba5OWEHepE45ucLyk0aLXhCj16s5Uhxi0AfYRnLBkE
         UJ95+ZC0e95azn67B6gBIJA9DKpAAcHEK1iswIHkBv55QMj1vvzSv9MY7C3VLxHeIgFr
         zNHLL73mNpnChEQ44hH9v7+jrIwgjrrHzJokeGakopGyAy6laZO7pYn/brrksj/N+Dtl
         9iIZ75jMzOYdChmrMXaoB53j08aKkLxnmesigK32CEFMyjexcuHiCu7ek2UpgLhDhx+R
         3BDg==
X-Gm-Message-State: AOAM533uFPwz1bsVpBUHiQ7TrDhVBvoVGbCqG86dQKK1HnkCc2slWGpe
        YDD4I+quTsSgzsNt9wZU3w2OmMb8VszZ5oKvjDp96A==
X-Google-Smtp-Source: ABdhPJxQO4phSvS/Z2lJXUgYisvb4QdtPKPM4phw/8wJQrgFm1SgaS43gE8GKFPZdKWGmJmP5LrWOGXgGQnPWN8Hp4g=
X-Received: by 2002:ab0:6448:: with SMTP id j8mr13777868uap.13.1623166255614;
 Tue, 08 Jun 2021 08:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210603125242.31699-1-chenguanyou@xiaomi.com>
In-Reply-To: <20210603125242.31699-1-chenguanyou@xiaomi.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 8 Jun 2021 17:30:44 +0200
Message-ID: <CAJfpegsEkRnU26Vvo4BTQUmx89Hahp6=RTuyEcPm=rqz8icwUQ@mail.gmail.com>
Subject: Re: [PATCH] [fuse] alloc_page nofs avoid deadlock
To:     chenguanyou <chenguanyou9338@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenguanyou <chenguanyou@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 3 Jun 2021 at 14:52, chenguanyou <chenguanyou9338@gmail.com> wrote:
>
> ABA deadlock
>
> PID: 17172 TASK: ffffffc0c162c000 CPU: 6 COMMAND: "Thread-21"
> 0 [ffffff802d16b400] __switch_to at ffffff8008086a4c
> 1 [ffffff802d16b470] __schedule at ffffff80091ffe58
> 2 [ffffff802d16b4d0] schedule at ffffff8009200348
> 3 [ffffff802d16b4f0] bit_wait at ffffff8009201098
> 4 [ffffff802d16b510] __wait_on_bit at ffffff8009200a34
> 5 [ffffff802d16b5b0] inode_wait_for_writeback at ffffff800830e1e8
> 6 [ffffff802d16b5e0] evict at ffffff80082fb15c
> 7 [ffffff802d16b620] iput at ffffff80082f9270
> 8 [ffffff802d16b680] dentry_unlink_inode at ffffff80082f4c90
> 9 [ffffff802d16b6a0] __dentry_kill at ffffff80082f1710
> 10 [ffffff802d16b6d0] shrink_dentry_list at ffffff80082f1c34
> 11 [ffffff802d16b750] prune_dcache_sb at ffffff80082f18a8
> 12 [ffffff802d16b770] super_cache_scan at ffffff80082d55ac
> 13 [ffffff802d16b860] shrink_slab at ffffff8008266170
> 14 [ffffff802d16b900] shrink_node at ffffff800826b420
> 15 [ffffff802d16b980] do_try_to_free_pages at ffffff8008268460
> 16 [ffffff802d16ba60] try_to_free_pages at ffffff80082680d0
> 17 [ffffff802d16bbe0] __alloc_pages_nodemask at ffffff8008256514
> 18 [ffffff802d16bc60] fuse_copy_fill at ffffff8008438268
> 19 [ffffff802d16bd00] fuse_dev_do_read at ffffff8008437654
> 20 [ffffff802d16bdc0] fuse_dev_splice_read at ffffff8008436f40
> 21 [ffffff802d16be60] sys_splice at ffffff8008315d18
> 22 [ffffff802d16bff0] __sys_trace at ffffff8008084014
>
> PID: 9652 TASK: ffffffc0c9ce0000 CPU: 4 COMMAND: "kworker/u16:8"
> 0 [ffffff802e793650] __switch_to at ffffff8008086a4c
> 1 [ffffff802e7936c0] __schedule at ffffff80091ffe58
> 2 [ffffff802e793720] schedule at ffffff8009200348
> 3 [ffffff802e793770] __fuse_request_send at ffffff8008435760
> 4 [ffffff802e7937b0] fuse_simple_request at ffffff8008435b14
> 5 [ffffff802e793930] fuse_flush_times at ffffff800843a7a0
> 6 [ffffff802e793950] fuse_write_inode at ffffff800843e4dc
> 7 [ffffff802e793980] __writeback_single_inode at ffffff8008312740
> 8 [ffffff802e793aa0] writeback_sb_inodes at ffffff80083117e4
> 9 [ffffff802e793b00] __writeback_inodes_wb at ffffff8008311d98
> 10 [ffffff802e793c00] wb_writeback at ffffff8008310cfc
> 11 [ffffff802e793d00] wb_workfn at ffffff800830e4a8
> 12 [ffffff802e793d90] process_one_work at ffffff80080e4fac
> 13 [ffffff802e793e00] worker_thread at ffffff80080e5670
> 14 [ffffff802e793e60] kthread at ffffff80080eb650

The issue is real.

The fix, however, is not the right one.  The fundamental problem is
that fuse_write_inode() blocks on a request to userspace.

This is the same issue that fuse_writepage/fuse_writepages face.  In
that case the solution was to copy the page contents to a temporary
buffer and return immediately as if the writeback already completed.

Something similar needs to be done here: send the FUSE_SETATTR request
asynchronously and return immediately from fuse_write_inode().  The
tricky part is to make sure that multiple time updates for the same
inode aren't mixed up...

Thanks,
Miklos
