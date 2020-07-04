Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF8D2148D4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 23:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGDVPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 17:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgGDVPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 17:15:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E64C08C5DE
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2020 14:15:43 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l12so38165623ejn.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jul 2020 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AxQV0XLt21Bt2qa3UVsf6/Xpy4NyZNMgDnKpCTHN9o=;
        b=czNLBfW47JUp/31wWlzLlX+5Zsw+mjdaFJmkIHDvUHvXVBaNXu5zYhyLdYyTuEZY/y
         90UeJWY3VS3fGtxE7hkitnRGQRtMIWJIpmIwCaSm8Joa31p8xVutRg3FodPnExut0/Z/
         /iNqe2LGnmEMdEwQ9zHmCDY2rBOvGsnt+arSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AxQV0XLt21Bt2qa3UVsf6/Xpy4NyZNMgDnKpCTHN9o=;
        b=jOcnG7u4bxhMTlR0+4jntafGk2lGMl1xgVDaJYvPTV4IDvTv+Eg9cFE5LZI9wJrDba
         e7+MJej6oC+SCakGH7qXIJ/wWDAgu4XxA0sHY3LwaZ7ednS3PLcGcBMp6DaJ1imixM5d
         Hhj944XeSxSct1SqsMURg7v0w1qUiuIaDTjBdETfyAYwRraN8zUa91VFDT3KDDJA+cAa
         1qR3/BtWeTSSF3ohbyPsZNu+TR7+eeSPVKiyRJBBDKEK4ujmddT4JVQglpAL+1YjHxJ7
         MY4/j6UW2rDQtZSlTd92txNZBlXgbSZJkdpocBZWKAfg0strylbbuC2NmOdjQeFeZqsL
         +xvg==
X-Gm-Message-State: AOAM530gLdyCtsDcQEfbOfvlk0BC7sI8Z02Di0UCqnWYC9SzVnsvtt4H
        jb6HOEXzNitUHMsrZcqGbztC2lH/aUSz+z6FuI2Gng==
X-Google-Smtp-Source: ABdhPJzy2OSjftl1uhS18/1JrNcWVe+zl8quZAy/wcvZ0ZkymJWG4u+qXd1UXXPWMWE+/Maw1bj299tIZidJ7XQui0A=
X-Received: by 2002:a17:906:1c05:: with SMTP id k5mr36550842ejg.320.1593897341610;
 Sat, 04 Jul 2020 14:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200704205016.GA192853@localhost.localdomain>
In-Reply-To: <20200704205016.GA192853@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sat, 4 Jul 2020 23:15:29 +0200
Message-ID: <CAJfpegvBxE6WQigKDjM2JgqYeOkuhwDZ=ZEsv88AovHev0ox6A@mail.gmail.com>
Subject: Re: [PATCH 1/3] readfile: implement readfile syscall
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 4, 2020 at 10:50 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Al wrote:
>
> > > On Sat, Jul 04, 2020 at 09:41:09PM +0200, Miklos Szeredi wrote:
> > >  1) just leave the first explanation (it's an open + read + close
> > > equivalent) and leave out the rest
> > >
> > >  2) add a loop around the vfs_read() in the code.
> >
> > 3) don't bother with the entire thing, until somebody manages to demonstrate
> > a setup where it does make a real difference (compared to than the obvious
> > sequence of syscalls, that is).
>
> Ehh? System call overead is trivially measurable.
> https://lwn.net/Articles/814175/
>
> > At which point we'll need to figure out
> > what's going on and deal with the underlying problem of that setup.
>
> Run top?
>
> Teach userspace to read 1 page minimum?
>
>         192803 read(4, "cpu  3718263 4417 342808 7127674"..., 1024) = 1024
>         192803 read(4, " 0 21217 21617 21954 10201 15425"..., 1024) = 1024
>         192803 read(4, " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"..., 1024) = 1024
>         192803 read(4, "", 1024)
>
> Teach userspace to pread?
>
>         192803 openat(AT_FDCWD, "/proc/uptime", O_RDONLY) = 5
>         192803 lseek(5, 0, SEEK_SET)            = 0
>         192803 read(5, "47198.56 713699.82\n", 8191) = 19
>
> Rhetorical question: what is harder: ditch the main source of overhead
> (VFS, seq_file, text) or teach userspace how to read files?
>
> Here is open+read /proc/cpuinfo in python2 and python3.
> Python2 case is terrifying.
>
> BTW is there is something broken with seqfiles and record keeping?
> Why does it return only 2 records per read?

seqfile is weird.  It uses an internal buffer (m->buf) that starts off
with a PAGE_SIZE size (m->size).  The internal buffer is filled with
whole records, if a single record is larger than the bufsize, then the
buffer is expanded until the record fits.  Then this internal buffer
is used to fill the user buffer supplied by read.  If the length of
the internal buffer (m->count) overflows the user buffer, then the
rest is set aside for the next read.  In this case the next read
starts with the tail (m->from) of the internal buffer, then, if
there's still space in the user buffer, it resets the internal buffer
(m->from = 0) and again fills it with at least one whole record and
copies as much of that to the user buffer as it can.

Note how this can lead to unfilled bytes at the end of the user
buffer.  Not sure what's the rationelle, it could just as well loop
back to filling a new buf it there's space left in the user buffer.
Maybe it was: better return whole records whenever possible.  Anyway
that can't be changed now, since it's bound to break something out
there.

Thanks,
Miklos

>
> Python 3:
>
> openat(AT_FDCWD, "/proc/cpuinfo", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> ioctl(3, TCGETS, 0x7ffe6f1f0850) = -1 ENOTTY (Inappropriate ioctl for device)
> lseek(3, 0, SEEK_CUR)            = 0
> ioctl(3, TCGETS, 0x7ffe6f1f0710) = -1 ENOTTY (Inappropriate ioctl for device)
> lseek(3, 0, SEEK_CUR)            = 0
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> read(3, "processor\t: 0\nvendor_id\t: Genuin"..., 8192) = 3038
> read(3, "processor\t: 2\nvendor_id\t: Genuin"..., 5154) = 3038
> read(3, "processor\t: 4\nvendor_id\t: Genuin"..., 2116) = 2116
> read(3, "clmulqdq dtes64 monitor ds_cpl v"..., 8448) = 3966
> read(3, "processor\t: 8\nvendor_id\t: Genuin"..., 4482) = 3038
> read(3, "processor\t: 10\nvendor_id\t: Genui"..., 1444) = 1444
> read(3, "t\t: 64\naddress sizes\t: 46 bits p"..., 16896) = 3116
> read(3, "processor\t: 13\nvendor_id\t: Genui"..., 13780) = 3044
> read(3, "processor\t: 15\nvendor_id\t: Genui"..., 10736) = 1522
> read(3, "", 9214)                = 0
>
>
> Python 2
>
> openat(AT_FDCWD, "/proc/cpuinfo", O_RDONLY) = 3
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 0
> lseek(3, 0, SEEK_CUR)            = 0
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> read(3, "processor\t: 0\nvendor_id\t: Genuin"..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 1024
> lseek(3, 0, SEEK_CUR)            = 1024
> read(3, " cqm_occup_llc cqm_mbm_total cqm"..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 2048
> lseek(3, 0, SEEK_CUR)            = 2048
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 2048
> lseek(3, 0, SEEK_CUR)            = 2048
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 2048
> lseek(3, 0, SEEK_CUR)            = 2048
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 2048
> lseek(3, 0, SEEK_CUR)            = 2048
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 2048
> lseek(3, 0, SEEK_CUR)            = 2048
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 2048
> lseek(3, 0, SEEK_CUR)            = 2048
> read(3, "ebs bts rep_good nopl xtopology "..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 3072
> lseek(3, 0, SEEK_CUR)            = 3072
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 3072
> lseek(3, 0, SEEK_CUR)            = 3072
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 3072
> lseek(3, 0, SEEK_CUR)            = 3072
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 3072
> lseek(3, 0, SEEK_CUR)            = 3072
> read(3, "ntel\ncpu family\t: 6\nmodel\t\t: 79\n"..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 4096
> lseek(3, 0, SEEK_CUR)            = 4096
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 4096
> lseek(3, 0, SEEK_CUR)            = 4096
> read(3, "bm_local dtherm ida arat pln pts"..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 5120
> lseek(3, 0, SEEK_CUR)            = 5120
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 5120
> lseek(3, 0, SEEK_CUR)            = 5120
> read(3, "nstop_tsc cpuid aperfmperf pni p"..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 6144
> lseek(3, 0, SEEK_CUR)            = 6144
> read(3, "del name\t: Intel(R) Xeon(R) CPU "..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 7168
> lseek(3, 0, SEEK_CUR)            = 7168
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 7168
> lseek(3, 0, SEEK_CUR)            = 7168
> read(3, "d_clear flush_l1d\nvmx flags\t: vn"..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 8192
> lseek(3, 0, SEEK_CUR)            = 8192
> read(3, "clmulqdq dtes64 monitor ds_cpl v"..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 9216
> lseek(3, 0, SEEK_CUR)            = 9216
> read(3, "E5-2620 v4 @ 2.10GHz\nstepping\t: "..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 10240
> lseek(3, 0, SEEK_CUR)            = 10240
> read(3, "vnmi preemption_timer posted_int"..., 1024) = 1024
> read(3, " vmx smx est tm2 ssse3 sdbg fma "..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 12288
> lseek(3, 0, SEEK_CUR)            = 12288
> read(3, ": 1\nmicrocode\t: 0xb000038\ncpu MH"..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 13312
> lseek(3, 0, SEEK_CUR)            = 13312
> read(3, "r invvpid ept_x_only ept_ad ept_"..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 14336
> lseek(3, 0, SEEK_CUR)            = 14336
> read(3, "16 xtpr pdcm pcid dca sse4_1 sse"..., 1024) = 1024
> read(3, "\t\t: 1326.352\ncache size\t: 20480 "..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 16384
> lseek(3, 0, SEEK_CUR)            = 16384
> read(3, "gb flexpriority apicv tsc_offset"..., 1024) = 1024
> read(3, "4_2 x2apic movbe popcnt tsc_dead"..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 18432
> lseek(3, 0, SEEK_CUR)            = 18432
> read(3, "KB\nphysical id\t: 0\nsiblings\t: 16"..., 1024) = 1024
> read(3, " vtpr mtf vapic ept vpid unrestr"..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 20480
> lseek(3, 0, SEEK_CUR)            = 20480
> read(3, "adline_timer aes xsave avx f16c "..., 2048) = 2048
> read(3, "estricted_guest vapic_reg vid pl"..., 1024) = 1024
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> lseek(3, 0, SEEK_CUR)            = 23552
> lseek(3, 0, SEEK_CUR)            = 23552
> read(3, "16c rdrand lahf_lm abm 3dnowpref"..., 2048) = 770
> read(3, "", 1024)                = 0
> close(3)                         = 0
