Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C986EADD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 17:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjDUPPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 11:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjDUPPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:15:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D15A93F6;
        Fri, 21 Apr 2023 08:15:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5069097bac7so3080697a12.0;
        Fri, 21 Apr 2023 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682090115; x=1684682115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3PK1qOBFO8P3MzvQZi6m7wgAQpoMs4tfggDeStRvSI=;
        b=ZyXd8aAAD+thdP7VsfaNJbWGnEkXxaYp037epXaW+svqRpnY/VqWfPdaE7uPRFevqh
         R0d3kk9sU/egKwXaonJykZHGvWYmGvBq+4Xc++TPMskCSVNRrOchnNo7gn3QlQhI9pxN
         w8C3ZCxp8IunByN8DQQXpZ7xmQB3y4ezkxMIDPwWh/Vd4PYQmMvO+bWDP1sBcb48Lwza
         0EOxpVFZAJSgDe0O8T6QXHq1oIny+Tx0WQ2V/izpjU/rwHPltAZHn76PUEeSY9V/SCXB
         BbVF+lHVnakPXf/cUVwYSw//qxA2xj0NS5Ohtd8IPg7FtxYIJ6kZZypsr/lOWwsFHK2p
         tgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682090115; x=1684682115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3PK1qOBFO8P3MzvQZi6m7wgAQpoMs4tfggDeStRvSI=;
        b=kjG241qGNN7/nJYMueTT23mPydE3LLh3EG1bW953We+u9EKkJEk33l/Sdzjqw63eTA
         GSBb1yDssZqvK0DVrMZuCo31419R2svn1SzbQF/5T3StNqXzg+AMXCvTTzF8Z5qXaVk7
         j5TSRjB/gZHnkODKOm/U2FS+9o4eoyJZ4FDuePXWi5Dws8TzVvmNQxdtlRtY/ox4/fbI
         O5mWEVgF0Lgu+pOgerdWfjdSKfIPdQj99+L582PAOKw4Po0/fvJRL/PWI8CDcze2Re3P
         vik1yq1qNo//wP9OPyxEbKt+PdCNTVyjnI8JNt9fNdD/WAWHEp3wOES++BDBg+2jBrAW
         MbRA==
X-Gm-Message-State: AAQBX9cGXSXaeZqH61UUx7sB9+bs4obA3O/ABix0IWQQuw4kHTTBU+n/
        G8wqngV+AMTJqvEa0L+cyBVxgytPNpE6PCUeqRueljzsK34=
X-Google-Smtp-Source: AKy350axwUWmK8HYFxGgA8KJ8TJI4dhynsXE51W+iUMlvnkT8UxABPq4OUDkqMX6vH0ui0lbXK6N6NKk+Mj3A11Dsqw=
X-Received: by 2002:aa7:de92:0:b0:506:c096:18a9 with SMTP id
 j18-20020aa7de92000000b00506c09618a9mr5265190edv.32.1682090114386; Fri, 21
 Apr 2023 08:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b9915d05f9d98bdd@google.com> <CACT4Y+a3J0Z2PThebH6UaUWchKLWec8qApuv1ezYGKjf67Xctg@mail.gmail.com>
In-Reply-To: <CACT4Y+a3J0Z2PThebH6UaUWchKLWec8qApuv1ezYGKjf67Xctg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Apr 2023 08:15:03 -0700
Message-ID: <CAADnVQL4eJw11oHVqy40-9xUg_nWbQVjfAzoxM1z0RAYmeZ_tw@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] [mm?] KCSAN: data-race in strscpy / strscpy (3)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tom Rix <trix@redhat.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 7:43=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com> =
wrote:
>
> On Fri, 21 Apr 2023 at 16:33, syzbot
> <syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    76f598ba7d8e Merge tag 'for-linus' of git://git.kernel.=
org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D133bfbedc80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9c5d44636e9=
1081b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc2de99a72baaa=
06d31f3
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for D=
ebian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/a3654f5f77b9/d=
isk-76f598ba.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/abfb4aaa5772/vmli=
nux-76f598ba.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/789fb5546551=
/bzImage-76f598ba.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com
>
> +bpf maintainers
>
> If I am reading this correctly, this can cause a leak of kernel memory
> and/or crash via bpf_get_current_comm helper.
>
> strcpy() can temporary leave comm buffer non-0 terminated as it
> terminates it only after the copy:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/l=
ib/string.c?id=3D76f598ba7d8e2bfb4855b5298caedd5af0c374a8#n184
>
> If bpf_get_current_comm() observes such non-0-terminated comm, it will
> start reading off bounds.

fyi it's using strscpy_pad() in bpf-next.
See commit f3f213497797 ("bpf: ensure all memory is initialized in
bpf_get_current_comm")
but this race might still exist. not sure.

> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KCSAN: data-race in strscpy / strscpy
> >
> > write to 0xffff88812ed8b730 of 8 bytes by task 16157 on cpu 1:
> >  strscpy+0xa9/0x170 lib/string.c:165
> >  strscpy_pad+0x27/0x80 lib/string_helpers.c:835
> >  __set_task_comm+0x46/0x140 fs/exec.c:1232
> >  set_task_comm include/linux/sched.h:1984 [inline]
> >  __kthread_create_on_node+0x2b2/0x320 kernel/kthread.c:474
> >  kthread_create_on_node+0x8a/0xb0 kernel/kthread.c:512
> >  ext4_run_lazyinit_thread fs/ext4/super.c:3848 [inline]
> >  ext4_register_li_request+0x407/0x650 fs/ext4/super.c:3983
> >  __ext4_fill_super fs/ext4/super.c:5480 [inline]
> >  ext4_fill_super+0x3f4a/0x43f0 fs/ext4/super.c:5637
> >  get_tree_bdev+0x2b1/0x3a0 fs/super.c:1303
> >  ext4_get_tree+0x1c/0x20 fs/ext4/super.c:5668
> >  vfs_get_tree+0x51/0x190 fs/super.c:1510
> >  do_new_mount+0x200/0x650 fs/namespace.c:3042
> >  path_mount+0x498/0xb40 fs/namespace.c:3372
> >  do_mount fs/namespace.c:3385 [inline]
> >  __do_sys_mount fs/namespace.c:3594 [inline]
> >  __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3571
> >  __x64_sys_mount+0x67/0x80 fs/namespace.c:3571
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > read to 0xffff88812ed8b733 of 1 bytes by task 16161 on cpu 0:
> >  strscpy+0xde/0x170 lib/string.c:174
> >  ____bpf_get_current_comm kernel/bpf/helpers.c:260 [inline]
> >  bpf_get_current_comm+0x45/0x70 kernel/bpf/helpers.c:252
> >  ___bpf_prog_run+0x281/0x3050 kernel/bpf/core.c:1822
> >  __bpf_prog_run32+0x74/0xa0 kernel/bpf/core.c:2043
> >  bpf_dispatcher_nop_func include/linux/bpf.h:1124 [inline]
> >  __bpf_prog_run include/linux/filter.h:601 [inline]
> >  bpf_prog_run include/linux/filter.h:608 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2263 [inline]
> >  bpf_trace_run4+0x9f/0x140 kernel/trace/bpf_trace.c:2304
> >  __traceiter_sched_switch+0x3a/0x50 include/trace/events/sched.h:222
> >  trace_sched_switch include/trace/events/sched.h:222 [inline]
> >  __schedule+0x7e7/0x8e0 kernel/sched/core.c:6622
> >  schedule+0x51/0x80 kernel/sched/core.c:6701
> >  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:6760
> >  kthread+0x11c/0x1e0 kernel/kthread.c:369
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> >
> > value changed: 0x72 -> 0x34
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 PID: 16161 Comm: ext4lazyinit Not tainted 6.3.0-rc5-syzkaller-00=
022-g76f598ba7d8e #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 03/30/2023
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
