Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF91F9AB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 16:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgFOOqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 10:46:38 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbgFOOqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:46:37 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MZCSt-1jOgo72BxB-00V4an; Mon, 15 Jun 2020 16:46:34 +0200
Received: by mail-qt1-f182.google.com with SMTP id d27so12771588qtg.4;
        Mon, 15 Jun 2020 07:46:33 -0700 (PDT)
X-Gm-Message-State: AOAM531THykdsvYWeYROsFp5ZVN0iaCwLSGhHZI6ysy1KMV7hhAMWOwn
        r5MQklahmE3bq9sT9g4CkPpKzXetrfTfjhCpVC4=
X-Google-Smtp-Source: ABdhPJywD9av6KIiK4BI4ianRw+UdaKCe4ceSIvGZHSPqP74ZiYjfjKkHc+mtmam7/Oo3s0OJJLXSxfo9wqCgBHLYos=
X-Received: by 2002:ac8:1844:: with SMTP id n4mr15871691qtk.142.1592232392794;
 Mon, 15 Jun 2020 07:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de>
 <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com>
 <20200615141239.GA12951@lst.de> <CAK8P3a2MeZhayZWkPbd4Ckq3n410p_n808NJTwN=JjzqHRiAXg@mail.gmail.com>
 <20200615144310.GA15101@lst.de>
In-Reply-To: <20200615144310.GA15101@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Jun 2020 16:46:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a17h782gO65qJ9Mmz0EuiTSKQPEyr_=nvqOtnmQZuh9Kw@mail.gmail.com>
Message-ID: <CAK8P3a17h782gO65qJ9Mmz0EuiTSKQPEyr_=nvqOtnmQZuh9Kw@mail.gmail.com>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VukGuLhjqzqeQbK+BpjSdZoJkre6YMPnw9CqDkZOFFjY07Qjk3l
 q4FPQZnpVeIHA3sqQU20bBS1/WvMARg6Sww8P9YFBHKjIOR6Xp9h1TTB430L0d9krlJejwQ
 eoFsJ3Z1PBi1pkilStIG19xMUD2fJvLPgHQJE8NQsgPF3Zkr+uMTF1OeCgK0ncfD7WAE7gU
 2DJsr7vaRZurLgOYWGY6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v0sTQvxkT8E=:z/rgYBxCVBJLjpO9efYOGC
 IeNqoqJw4KKDB0ztATegC2VtBzBoBuApYNqMBkRvx8wC2H+5gvVyXAvBHt1Hv3Rt6Ssojq5ek
 DN5/r8v88VC21JOmSJ6J14qSQpupf/SYZt8DhicoC/j2u8KmaXpB677ZdvJb7TeQ56uMHdNjy
 Ss5uyRVl17Xn2oCShPwnfmmDn3TNWse0xANFFv3xFFWBa+gUYpca3nuQfnZxIE5I/QDWbP8TN
 H1WOBMbvKwr5Ql4yfWk/4npPZURv1xdIVfuiXS/U/d23Mpvur0+aVgCnaRixUH3AO6EwhWCpU
 ecCMmoogMh//pBFD6JXyJoOctomGTub+irPpsf86q70P1F831QmyhhApec/IVejznTFPBgTM4
 kvuMOZwt8bgBlKRkT6FZMMtBseRGYb33uU6ENXN6vKbbf1YI/ThN6Ye5Nb6/UHudZDRoywqe/
 sSyvKjkTJXsXh/ZiE2qHcs0tH3iYyvyLtUFAxdF/0s/TDK4Qjh0PjW4PumBCGlF6KeBnwAlzf
 sYlgGI9/CGOVmjXaLzKn37IkbV8j1HjRX+OVUzHMN9oqvPrHKBnnRzBP0xAh+kFXqJDS//335
 NnLDo5B4XkiWzOiYT7UADNEnnnUv+OC/w/dmlrIlKaSIWreZ/C/Gi6zwo3rxWZYtRqaBsXF2M
 X+jAzWD7oWHuVt8UKWz+9tyeCBcV7Mh2n2BZMfH8GRpfEdSDWIjIBpSQAnzn56MhO697IG93F
 cBcAV5rw92KyfzF+pxVxoEgS0gqsbm8UmJdTOsN4SZvlYIL9XjxzcFy7aGBWwpTD4/exmSTPT
 PHTNgl6iTwNbj9ktDRliD//GJK9jrgwf6/ZSjTHqd7F2Gt49Co=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 4:43 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 15, 2020 at 04:40:28PM +0200, Arnd Bergmann wrote:
> > > ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1040): undefined reference to
> > > `__x32_sys_execve'
> > > ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1108): undefined reference to
> > > `__x32_sys_execveat'
> > > make: *** [Makefile:1139: vmlinux] Error 1
> >
> > Ah, I see: it's marked x32-only, so arch/x86/entry/syscall_x32.c
> > uses the __x32 prefix instead of the __x64 one. Marking it 'common'
> > instead would make it work, but also create an extra entry point
> > for native processes, something that commit
> > 6365b842aae4 ("x86/syscalls: Split the x32 syscalls into their own table")
> > was trying to avoid.
>
> Marking it common also doesn't compile at all because __NR_execve
> and __NR_execveat get redefined in unistd_64.h.  I then tried to rename
> the x32 versions, which failed in yet another way.  At that point I gave
> up instead of digging myself into a deeper hole..

How about this one:

diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 3d8d70d3896c..0ce15807cf54 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -16,6 +16,9 @@
 #undef __SYSCALL_X32
 #undef __SYSCALL_COMMON

+#define __x32_sys_execve __x64_sys_execve
+#define __x32_sys_execveat __x64_sys_execveat
+
 #define __SYSCALL_X32(nr, sym) [nr] = __x32_##sym,
 #define __SYSCALL_COMMON(nr, sym) [nr] = __x64_##sym,

Still ugly, but much simpler and more localized (if it works).

        Arnd
