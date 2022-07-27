Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE747581F8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 07:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiG0FfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 01:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiG0FfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:35:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13AABE05
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 22:35:15 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a23so23219531lfm.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 22:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wRe/ujwX7WAUOa08pI9D7wlz0834bY/rUKQYvH3I+A=;
        b=SasZc+CZGY/ofJJ1JcFBqzmuyPEOfJLFir2oKGRdvvQBzKr9sjwbb9uUX1yr+YSSl9
         yXVixkxlP9eNGqlRkbBdPsY2FsNTPh8P8XU+OCKc/gwW+eZ2JTPo98oFJ7LKeYMlzCc3
         dmvS/ElbEuP48K/xS92ImYw5RoNCj13B4aX3bnFI4QSBB78UhwKe838z+cIIpUh4NIQg
         tP1cpJ7lwCAmk9rEYqceCRBrwhRnsZPGsfeRe2dSqAqAFvx3KQoCG6nG+YgHjsph7etF
         B9zuCAmtiI2GB65E7q1LyW5jK4D32Q2JjC8k7nRUFzS2MlubUcAf4v6hrTwIgWo220R3
         hhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wRe/ujwX7WAUOa08pI9D7wlz0834bY/rUKQYvH3I+A=;
        b=5fRI8iBm2C/4Z95kFL2HLtydwXVzw2eOdgGWogDrdikWhu6+UpUb0/3dbW3FgW0Q0U
         noNgvIOz2pF2bejmVQeedXkvxB9VsSeP41gEJlcuASONRNBVM79k7E36BOZ/tXWMvsTF
         jbO0cG0U20ZRwPl92pd/WBHxwWczNBP7SbRiHsft5bvVhPQOiO5WbVeIynam0NU+Jqrn
         pUpQ2CKnuw/x8bmaYaaUiJtL/dX8rWtYhZ5+Io8QzWSqGRM5/zFGs379MyYJHMsDyxtb
         JLp1InkPs4nWcmAY1DamnPDNKBRxQAfT/860/dJF6XdXZvHCI1RO1Y+cvNoar7jIGl0H
         6ZMA==
X-Gm-Message-State: AJIora8U92l55fmOBsdFl3PIUzMYMA9d77y1tWF8Bc8c+Uvlz7rQILDs
        hINZvsXR1IXtGL6FTLpNZbCYXipvrcmgEBNDmF0XsW8fRqhJ+g==
X-Google-Smtp-Source: AGRyM1t9IkNGK0Bo7fnavrRuklxg3uFZ9e1cDHXdj1D683YZ5RBGpyHOfzpNFq0HWxHfAtkFUbcnXdF0JVPJeAcS5a4=
X-Received: by 2002:a05:6512:1093:b0:48a:7c08:8d29 with SMTP id
 j19-20020a056512109300b0048a7c088d29mr7658345lfg.540.1658900113713; Tue, 26
 Jul 2022 22:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAC6jXv3PE3rxk3NJv83jjmXLF9rVg2wLTBjB8+ZkDZWB0oLUHg@mail.gmail.com>
In-Reply-To: <CAC6jXv3PE3rxk3NJv83jjmXLF9rVg2wLTBjB8+ZkDZWB0oLUHg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Jul 2022 07:35:01 +0200
Message-ID: <CACT4Y+aPy+Fc5Wz_d_WNh9J0KNBjMAe0eJ5OFKCg9_RP4tXk-Q@mail.gmail.com>
Subject: Re: help with a fuse-overlayfs hang please
To:     Nikhil Kshirsagar <nkshirsagar@gmail.com>
Cc:     miklos@szeredi.hu, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 27 Jul 2022 at 07:20, Nikhil Kshirsagar <nkshirsagar@gmail.com> wrote:
>
> Hello Mikolos and Dmitri!
>
> I'm trying to debug a fuse-overlayfs hang in the Ubuntu kernel, with versions,
>
> fuse_overlayfs: 1.7.1-1 (universe)
> kernel: 5.15.0-40-generic (server)
>
> This happens when fuse-overlayfs
> (https://github.com/containers/fuse-overlayfs) is stacked on top of
> squashfuse (https://github.com/vasi/squashfuse) to allow users to
> quickly start a container from a squashfs file without any privileges.
>
> The hang looks like this
>
> Jul 26 17:46:31  kernel: INFO: task fuse-overlayfs:326111 blocked for
> more than 120 seconds.
> Jul 26 17:46:31  kernel: Tainted: P OE 5.15.0-40-generic #43-Ubuntu
> Jul 26 17:46:31  kernel: "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Jul 26 17:46:31  kernel: task:fuse-overlayfs state:D stack: 0
> pid:326111 ppid:326103 flags:0x00000002
> Jul 26 17:46:31  kernel: Call Trace:
> Jul 26 17:46:31  kernel: <TASK>
> Jul 26 17:46:31  kernel: __schedule+0x23d/0x590
> Jul 26 17:46:31  kernel: ? update_load_avg+0x82/0x620
> Jul 26 17:46:31  kernel: schedule+0x4e/0xb0
> Jul 26 17:46:31  kernel: schedule_preempt_disabled+0xe/0x10
> Jul 26 17:46:31  kernel: __mutex_lock.constprop.0+0x263/0x490
> Jul 26 17:46:31  kernel: ? kmem_cache_alloc+0x1ab/0x2e0
> Jul 26 17:46:31  kernel: __mutex_lock_slowpath+0x13/0x20
> Jul 26 17:46:31  kernel: mutex_lock+0x34/0x40
> Jul 26 17:46:31  kernel: fuse_lock_inode+0x2f/0x40
> Jul 26 17:46:31  kernel: fuse_lookup+0x48/0x1b0
> Jul 26 17:46:31  kernel: ? d_alloc_parallel+0x235/0x4b0
> Jul 26 17:46:31  kernel: ? __legitimize_path+0x2d/0x60
> Jul 26 17:46:31  kernel: __lookup_slow+0x81/0x150
> Jul 26 17:46:31  kernel: walk_component+0x141/0x1b0
> Jul 26 17:46:31  kernel: link_path_walk.part.0.constprop.0+0x23b/0x360
> Jul 26 17:46:31  kernel: ? path_init+0x2bc/0x3e0
> Jul 26 17:46:31  kernel: path_lookupat+0x3e/0x1b0
> Jul 26 17:46:31  kernel: filename_lookup+0xcf/0x1d0
> Jul 26 17:46:31  kernel: ? __check_object_size+0x19/0x20
> Jul 26 17:46:31  kernel: ? strncpy_from_user+0x44/0x140
> Jul 26 17:46:31  kernel: ? getname_flags.part.0+0x4c/0x1b0
> Jul 26 17:46:31  kernel: user_path_at_empty+0x3f/0x60
> Jul 26 17:46:31  kernel: path_getxattr+0x4a/0xb0
> Jul 26 17:46:31  kernel: ? __secure_computing+0xa5/0x110
> Jul 26 17:46:31  kernel: __x64_sys_lgetxattr+0x21/0x30
> Jul 26 17:46:31  kernel: do_syscall_64+0x59/0xc0
> Jul 26 17:46:31  kernel: ? do_syscall_64+0x69/0xc0
> Jul 26 17:46:31  kernel: ? do_syscall_64+0x69/0xc0
> Jul 26 17:46:31  kernel: ? irqentry_exit+0x19/0x30
> Jul 26 17:46:31  kernel: ? exc_page_fault+0x89/0x160
> Jul 26 17:46:31  kernel: ? asm_exc_page_fault+0x8/0x30
> Jul 26 17:46:31  kernel: entry_SYSCALL_64_after_hwframe+0x44/0xae
> Jul 26 17:46:31  kernel: RIP: 0033:0x7ffff7e6d2ae
> Jul 26 17:46:31  kernel: RSP: 002b:00007fffffff7528 EFLAGS: 00000202
> ORIG_RAX: 00000000000000c0
> Jul 26 17:46:31  kernel: RAX: ffffffffffffffda RBX: 000055555556d6f0
> RCX: 00007ffff7e6d2ae
> Jul 26 17:46:31  kernel: RDX: 00007fffffff8570 RSI: 0000555555566190
> RDI: 00007fffffff7530
> Jul 26 17:46:31  kernel: RBP: 0000555555566190 R08: 0000000000000010
> R09: 0000555555579cf0
> Jul 26 17:46:31  kernel: R10: 0000000000000010 R11: 0000000000000202
> R12: 00007fffffff8570
> Jul 26 17:46:31  kernel: R13: 0000000000000010 R14: 00007fffffff7530
> R15: 0000000000000000
> Jul 26 17:46:31  kernel: </TASK>
>
> Seems to me the &get_fuse_inode(inode)->mutex cannot be locked,
>
> bool fuse_lock_inode(struct inode *inode)
> {
>         bool locked = false;
>
>         if (!get_fuse_conn(inode)->parallel_dirops) {
>                 mutex_lock(&get_fuse_inode(inode)->mutex);
>                 locked = true;
>         }
>
>         return locked;
> }
>
> Please would you be able to help me understand if this is a
> known/reported issue, and has any fix/patch?
>
> Regards,
> Nikhil.

+linux-fsdevel, syzkaller

Hi Nikhil,

Re known bugs: we have 5 open bugs that mention "fuse" in the title,
including some task hangs with reproducers:
https://syzkaller.appspot.com/upstream
These may be the easiest to check first.

There were also some fixed task hangs in fuse:
https://syzkaller.appspot.com/upstream/fixed
But they look old enough, so fixes are probably already in your kernel.
