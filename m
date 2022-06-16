Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E702B54DF71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiFPKtI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 06:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiFPKtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:49:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF415DD27
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jun 2022 03:49:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h23so1981045ejj.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jun 2022 03:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdv5HvJdOUS16UfpAYkCSxAdQ5u2uZ4iGAl0EwYrSX8=;
        b=qVh98qSY7GkMzEotZLLP3oRk0j1errP5YUfSlXNDLo9qpFmIlwB930D7w00tTzMbe4
         GAmJrZ0DMBwWJbL7RWEn2IDfz5q/bWLAMpn50hj+wbl6Q0+6c7YtKnC8NoeBrlxl1bt3
         Alx8q9S6tso2FcWciZ6hO0elh1LG9bRCxRsNgl+TNAqqnyMN0i/6QNKfk/E11CUq039t
         yZgoMrvIEKZs25H2fOpTaMjyxSqWejKb8AO/10IdwyoRpIq/0YOSMsvHG0E/J9+EeI2w
         8rCWTsRPuh9Hyjko+RJuZbvcjQGZOdDduX1EzqgCz14r+m1CqMkYt65mUUvOjSDc8BJ/
         Rn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdv5HvJdOUS16UfpAYkCSxAdQ5u2uZ4iGAl0EwYrSX8=;
        b=h1EQ9UZlUL0Lp21m74AD3CB5jMa/acpg5ppRNaCr3wRssqpOI5MDNzgdHjzu75876K
         w9WA6mYJhzzi1vogZYnCFTOKtUuga5wTbbtHnqn5JxpCaryHpwEc0bZq2NN+/FSLO19m
         DA3dTJEhb+4pzda5TeTwYTftfv1kxRD6U1JKmC+H7xIZzbTZZdaoH/i9n+zlNDNTEdDZ
         kbTCuYkrcMUaL6A8N9ZBTDjkwkwkLeiV79BG6rsrVOHSOfUdoAbsfy3Vw/Kue9hC7Pky
         lErzj2KI8DJ8XrprjFOMFyo0oKRSI5THPmu9jgkAhjKhwEU/f0YvQzev8LrXcwtdshTu
         EF6w==
X-Gm-Message-State: AJIora9c+seZyJIW7KocNUrKq6KLtMbWQ0JvzxSmwuEBpB725yKNFggV
        zSXKH7oLg9obksXvHvIhjfC+oZlvEcLbutnaptxZTA==
X-Google-Smtp-Source: AGRyM1vlAyzSwM4XDyHbc1Wtl2T1qv7BOE85nxm0tCoxS79Jm2Gdwwpo4xt2+8ZN/uHiDQ9THPDqUT19/eLYN0UNQoU=
X-Received: by 2002:a17:906:5256:b0:711:ee4d:fbe4 with SMTP id
 y22-20020a170906525600b00711ee4dfbe4mr3722377ejm.312.1655376544294; Thu, 16
 Jun 2022 03:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
 <CAPt2mGNjWXad6e7nSUTu=0ez1qU1wBNegrntgHKm5hOeBs5gQA@mail.gmail.com> <165534094600.26404.4349155093299535793@noble.neil.brown.name>
In-Reply-To: <165534094600.26404.4349155093299535793@noble.neil.brown.name>
From:   Daire Byrne <daire@dneg.com>
Date:   Thu, 16 Jun 2022 11:48:28 +0100
Message-ID: <CAPt2mGOw_PS-5KY-9WFzGOT=ax6PFhVYSTQG-dpXzV5MeGieYg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] Allow concurrent directory updates.
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 16 Jun 2022 at 01:56, NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 15 Jun 2022, Daire Byrne wrote:
> ..
> > However, it is at this point that I started to experience some
> > stability issues with the re-export server that are not present with
> > the vanilla unpatched v5.19-rc2 kernel. In particular the knfsd
> > threads start to lock up with stack traces like this:
> >
> > [ 1234.460696] INFO: task nfsd:5514 blocked for more than 123 seconds.
> > [ 1234.461481]       Tainted: G        W   E     5.19.0-1.dneg.x86_64 #1
> > [ 1234.462289] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [ 1234.463227] task:nfsd            state:D stack:    0 pid: 5514
> > ppid:     2 flags:0x00004000
> > [ 1234.464212] Call Trace:
> > [ 1234.464677]  <TASK>
> > [ 1234.465104]  __schedule+0x2a9/0x8a0
> > [ 1234.465663]  schedule+0x55/0xc0
> > [ 1234.466183]  ? nfs_lookup_revalidate_dentry+0x3a0/0x3a0 [nfs]
> > [ 1234.466995]  __nfs_lookup_revalidate+0xdf/0x120 [nfs]
>
> I can see the cause of this - I forget a wakeup.  This patch should fix
> it, though I hope to find a better solution.
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 54c2c7adcd56..072130d000c4 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2483,17 +2483,16 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
>         if (!(dentry->d_flags & DCACHE_PAR_UPDATE)) {
>                 /* Must have exclusive lock on parent */
>                 did_set_par_update = true;
> +               lock_acquire_exclusive(&dentry->d_update_map, 0,
> +                                      0, NULL, _THIS_IP_);
>                 dentry->d_flags |= DCACHE_PAR_UPDATE;
>         }
>
>         spin_unlock(&dentry->d_lock);
>         error = nfs_safe_remove(dentry);
>         nfs_dentry_remove_handle_error(dir, dentry, error);
> -       if (did_set_par_update) {
> -               spin_lock(&dentry->d_lock);
> -               dentry->d_flags &= ~DCACHE_PAR_UPDATE;
> -               spin_unlock(&dentry->d_lock);
> -       }
> +       if (did_set_par_update)
> +               d_unlock_update(dentry);
>  out:
>         trace_nfs_unlink_exit(dir, dentry, error);
>         return error;
>
> >
> > So all in all, the performance improvements in the knfsd re-export
> > case is looking great and we have real world use cases that this helps
> > with (batch processing workloads with latencies >10ms). If we can
> > figure out the hanging knfsd threads, then I can test it more heavily.
>
> Hopefully the above patch will allow the more heavy testing to continue.
> In any case, thanks a lot for the testing so far,

Patch applied but unfortunately I'm still getting the same trace, but
this time I also captured a preceding stack for a hung process local
to the reexport server - I wonder if it's happening somewhere in the
VFS changes rather than nfsd which then exports the path?

[  373.930506] INFO: task XXXX:5072 blocked for more than 122 seconds.
[  373.931410]       Tainted: G        W   E     5.19.0-3.dneg.x86_64 #1
[  373.932313] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  373.933442] task:XXXX          state:D stack:    0 pid: 5072 ppid:
   1 flags:0x00000000
[  373.934639] Call Trace:
[  373.935007]  <TASK>
[  373.935306]  __schedule+0x2a9/0x8a0
[  373.935844]  schedule+0x55/0xc0
[  373.936294]  ? nfs_lookup_revalidate_dentry+0x3a0/0x3a0 [nfs]
[  373.937137]  __nfs_lookup_revalidate+0xdf/0x120 [nfs]
[  373.937875]  ? put_prev_task_stop+0x170/0x170
[  373.938525]  nfs_lookup_revalidate+0x15/0x20 [nfs]
[  373.939226]  lookup_fast+0xda/0x150
[  373.939756]  path_openat+0x12a/0x1090
[  373.940293]  ? __filemap_fdatawrite_range+0x54/0x70
[  373.941100]  do_filp_open+0xb2/0x120
[  373.941635]  ? hashlen_string+0xd0/0xd0
[  373.942190]  ? _raw_spin_unlock+0xe/0x30
[  373.942766]  do_sys_openat2+0x245/0x320
[  373.943305]  do_sys_open+0x46/0x80
[  373.943839]  __x64_sys_open+0x21/0x30
[  373.944428]  do_syscall_64+0x3b/0x90
[  373.944979]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  373.945688] RIP: 0033:0x7fcd80ceeeb0
[  373.946226] RSP: 002b:00007fff90fd8298 EFLAGS: 00000246 ORIG_RAX:
0000000000000002
[  373.947330] RAX: ffffffffffffffda RBX: 00007fcd81d6e981 RCX: 00007fcd80ceeeb0
[  373.947333] RDX: 00000000000001b6 RSI: 0000000000000000 RDI: 00007fff90fd8360
[  373.947334] RBP: 00007fff90fd82f0 R08: 00007fcd81d6e986 R09: 0000000000000000
[  373.947335] R10: 0000000000000024 R11: 0000000000000246 R12: 0000000000cd6110
[  373.947337] R13: 0000000000000008 R14: 00007fff90fd8360 R15: 00007fff90fdb580
[  373.947339]  </TASK>
[  373.947421] INFO: task nfsd:5696 blocked for more than 122 seconds.
[  373.947423]       Tainted: G        W   E     5.19.0-3.dneg.x86_64 #1
[  373.947424] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  373.947425] task:nfsd            state:D stack:    0 pid: 5696
ppid:     2 flags:0x00004000
[  373.947428] Call Trace:
[  373.947429]  <TASK>
[  373.947430]  __schedule+0x2a9/0x8a0
[  373.947434]  schedule+0x55/0xc0
[  373.947436]  ? nfs_lookup_revalidate_dentry+0x3a0/0x3a0 [nfs]
[  373.947451]  __nfs_lookup_revalidate+0xdf/0x120 [nfs]
[  373.947464]  ? put_prev_task_stop+0x170/0x170
[  373.947466]  nfs_lookup_revalidate+0x15/0x20 [nfs]
[  373.947478]  lookup_dcache+0x5a/0x80
[  373.947481]  lookup_one_unlocked+0x59/0xa0
[  373.947484]  lookup_one_len_unlocked+0x1d/0x20
[  373.947487]  nfsd_lookup_dentry+0x190/0x470 [nfsd]
[  373.947509]  nfsd_lookup+0x88/0x1b0 [nfsd]
[  373.947522]  nfsd3_proc_lookup+0xb4/0x100 [nfsd]
[  373.947537]  nfsd_dispatch+0x161/0x290 [nfsd]
[  373.947551]  svc_process_common+0x48a/0x620 [sunrpc]
[  373.947589]  ? nfsd_svc+0x330/0x330 [nfsd]
[  373.947602]  ? nfsd_shutdown_threads+0xa0/0xa0 [nfsd]
[  373.947621]  svc_process+0xbc/0xf0 [sunrpc]
[  373.951088]  nfsd+0xda/0x190 [nfsd]
[  373.951136]  kthread+0xf0/0x120
[  373.951138]  ? kthread_complete_and_exit+0x20/0x20
[  373.951140]  ret_from_fork+0x22/0x30
[  373.951149]  </TASK>

I double checked that the patch had been applied and I hadn't made a
mistake with installation.

I could perhaps try running with just the VFS patches to see if I can
still reproduce the "local" VFS hang without the nfsd patches? Your
previous VFS only patchset was stable for me.

Daire
