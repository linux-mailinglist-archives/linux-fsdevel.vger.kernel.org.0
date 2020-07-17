Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D572223B7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 14:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgGQMjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 08:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQMjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:39:15 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71700C061755
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 05:39:15 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dg28so7525769edb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8m43ZvjLHj8K9sJfHsZK0vsdYRBAMe/CF7D4HifFsUg=;
        b=T4T2jkpD9Q4Z3GNzd1eQGMSBOGyrvsKblIWzKAeKP4ctsXHo5689KZjTLHNP90wBYl
         +/HqbpISL7aWn+1U35+J7DvycTk1SRqvZFlihkso6CHpDKn+Q7q9wGPa1kj1zIwUsz85
         j5NJj3KsT3HTr6n//7Z5tuHDQcUWW2vWB/ZHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8m43ZvjLHj8K9sJfHsZK0vsdYRBAMe/CF7D4HifFsUg=;
        b=LcUKCFoCtoKmK7BCqacvRexB68yUG3ob4PRqfKNiK65NYOD/bR7K8FuU9POFoVG+SB
         5jWyOqE/xwcrWXMKqo/pioiNYIVrsaxlcKC0qHJ8cpbKzFVKjq58NRFjtzQGRfit9/Rs
         2zpQc2buOfe22Fi7vsiSwTbK8Bg1ScIkFPgiC9WQFThpmNa/MnUdtXLMqnTBp1xMI6Hv
         P05lkjC6hhoyfZ+TxiLjAlNq1BzXPgKQZ/tmsXOVCZecHOiRH+ZxeU7MdDa7MXLXmh9m
         GHpy08PNrf72NxXXi+WmhZqs/2CTuRsnDInmXhhBEjhYIJ01Ky6dT2gXLmY9dc/wLGsK
         UrCQ==
X-Gm-Message-State: AOAM5326jUVDMQHp8ho7bnGobi4c9XHOJATiDjgJzEM6X4VewyQEmH3I
        VVFAey3yDDZdA441DN4yfb5T4fDhMw8i8V5nH5vox0B0IffIeg==
X-Google-Smtp-Source: ABdhPJxUyNY98W5EqDQ4nYcRHBmGnC610+9x1Jt74FeScY/Kv81sxWV4dAx67bh2xjpO6/v1eGCvKDsacDLVB3YwTV8=
X-Received: by 2002:a50:f413:: with SMTP id r19mr9415035edm.17.1594989554177;
 Fri, 17 Jul 2020 05:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <874de72a-e196-66a7-39f7-e7fe8aa678ee@molgen.mpg.de>
In-Reply-To: <874de72a-e196-66a7-39f7-e7fe8aa678ee@molgen.mpg.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 17 Jul 2020 14:39:03 +0200
Message-ID: <CAJfpegs7qxiA+bKvS3_e_QNJEn+5YQxR=kEQ95W0wRFCeunWKw@mail.gmail.com>
Subject: Re: `ls` blocked with SSHFS mount
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-fsdevel@vger.kernel.org, it+linux-fsdevel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:07 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Linux folks,
>
>
> On Debian Sid/unstable with Linux 5.7.6, `ls` hangs sometimes when
> accessing a directory with an SSHFS mount. Linux logs the messages below.

Several solutions:

- kill `pidof sshfs`
- umount -f $MOUNTPOINT
- echo 1 > /sys/fs/fuse/connections/$DEVNUM/abort


>
> ```
> [105591.121285] INFO: task ls:21242 blocked for more than 120 seconds.
> [105591.121293]       Not tainted 5.7.0-1-amd64 #1 Debian 5.7.6-1
> [105591.121295] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [105591.121298] ls              D    0 21242    778 0x00004004
> [105591.121304] Call Trace:
> [105591.121319]  __schedule+0x2da/0x770
> [105591.121326]  schedule+0x4a/0xb0
> [105591.121339]  request_wait_answer+0x122/0x210 [fuse]
> [105591.121349]  ? finish_wait+0x80/0x80
> [105591.121357]  fuse_simple_request+0x198/0x290 [fuse]
> [105591.121366]  fuse_do_getattr+0xcf/0x2c0 [fuse]
> [105591.121376]  vfs_statx+0x96/0xe0
> [105591.121382]  __do_sys_statx+0x3b/0x80
> [105591.121391]  do_syscall_64+0x52/0x180
> [105591.121396]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [105591.121400] RIP: 0033:0x7f948c1c972a
> [105591.121410] Code: Bad RIP value.
> [105591.121412] RSP: 002b:00007ffd94582dd8 EFLAGS: 00000246 ORIG_RAX:
> 000000000000014c
> [105591.121416] RAX: ffffffffffffffda RBX: 0000556c6a957cc8 RCX:
> 00007f948c1c972a
> [105591.121417] RDX: 0000000000000100 RSI: 00007ffd94582f10 RDI:
> 00000000ffffff9c
> [105591.121419] RBP: 000000000000025e R08: 00007ffd94582de0 R09:
> 000000006a95c700
> [105591.121421] R10: 000000000000025e R11: 0000000000000246 R12:
> 0000556c6a95c763
> [105591.121423] R13: 0000000000000003 R14: 00007ffd94582f10 R15:
> 0000556c6a957cc8
> ```
>
> The `ls` process cannot be killed. The SSHFS issue *Fuse sshfs blocks
> standby (Visual Studio Code?)* from 2018 already reported this for Linux
> 4.17, and the SSHFS developers asked to report this to the Linux kernel.


This is a very old and fundamental issue.   Theoretical solution for
killing the stuck process exists, but it's not trivial and since the
above mentioned workarounds work well in all cases it's not high
priority right now.

Thanks,
Miklos
