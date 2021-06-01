Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD10B3974B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 15:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhFAN53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 09:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbhFAN53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:57:29 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A750C061574;
        Tue,  1 Jun 2021 06:55:46 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f11so13070906lfq.4;
        Tue, 01 Jun 2021 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1/x96UHDOyz4mo8Dx52Cylgiw8juPxSALX40n8TPCk=;
        b=u1GjTSS+Wsu8wRn3z2JByj4bKIT74WoOKBq//n+U/Dg2jQs1SWiqyT9sedwtjKVqRn
         0U1z9V8gPco4dM/w+iW9pFs0wo/Lkh/1cr38e+B29rx+lPiMDdRaXesVDUPlmVWZTZXj
         dbsIQTwUXWefxOL/wGtJDGx9+GV9FEG1vbMzqyROZXIH+tSCWP5W2m5kNjKgacRWjjvn
         YXD02UZsCKZ/D9uH+nNFFGRAM1RtjXTTcMYu0cDlU03CqLMqO2JQoWDNrGPl7aI+lmUy
         WZOZ4lFC7uGYjsQ+zIc8lLhozYYISZjYtoXWO49en/A4/8w7CWXtwYB+wqoxeKYkwzvx
         E3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1/x96UHDOyz4mo8Dx52Cylgiw8juPxSALX40n8TPCk=;
        b=XXVoV8ZEDwcsC9BBY8okkkIpD4WZvfL5wMt4+cF171XrTYLRv+uExyXctUgtyr4iRL
         xbdR7zdURvT9NAS5k2Iw4FsIo4D8ibFLgheaVpLD9qWi1dvNyfLIr5BBPOC478x6BGxO
         c1yyWzCY3xCGiJkb9Pob5tFx+I7H9YPNgm5ullb9Jgft7yVo2riwhYV1VXYhXIEAZkSb
         PVsiUweEpnsktfJJc3Rvaq2gvIXZwVpKyu7p0eW/X4O4S5pq3czBHA1Jx87ZQLgdLa3G
         M0T/ac8NENDe95/1uA6rlyy6LyhidqaQrs7Wq+Lo8r4L59ZM3qiYrNrLEv6aRu6xNXmc
         z17A==
X-Gm-Message-State: AOAM531aZJQ/utWUtBnJ6wngdv7BTIrsjCReqxcPTWG7rqHwLH28UykI
        PPeVhEBnB58od4mtiq3bgyYQJBoYZcsfKEV4Qbs=
X-Google-Smtp-Source: ABdhPJz2QveIKeaW5IevsO5kSbKCgvt8JDrTYlMlKizZr9/AJ1PzvSVbuMQp68gL1DzLMoLI9FrvpV/w/SKJRM/U0x8=
X-Received: by 2002:a05:6512:3772:: with SMTP id z18mr18821229lft.423.1622555744932;
 Tue, 01 Jun 2021 06:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210528143802.78635-1-dong.menglong@zte.com.cn> <20210529112638.b3a9ec5475ca8e4f51648ff0@kernel.org>
In-Reply-To: <20210529112638.b3a9ec5475ca8e4f51648ff0@kernel.org>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 1 Jun 2021 21:55:33 +0800
Message-ID: <CADxym3Ya3Jv_tUMJyq+ymd8m1_S-KezqNDfsLtMcJCXtDytBzA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] init/initramfs.c: make initramfs support pivot_root
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, ojeda@kernel.org,
        johan@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>, joe@perches.com,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        hare@suse.de, tj@kernel.org, gregkh@linuxfoundation.org,
        song@kernel.org, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        f.fainelli@gmail.com, wangkefeng.wang@huawei.com, arnd@arndb.de,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Barret Rhoden <brho@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        pmladek@suse.com, Alexander Potapenko <glider@google.com>,
        Chris Down <chris@chrisdown.name>, jojing64@gmail.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, mingo@kernel.org,
        terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

What's the status or fate of this patch? Does anyone do an in-depth
study of this field? Knock-knock~

On Sat, May 29, 2021 at 10:26 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Menglong,
>
> On Fri, 28 May 2021 22:37:59 +0800
> menglong8.dong@gmail.com wrote:
>
> > From: Menglong Dong <dong.menglong@zte.com.cn>
> >
> > As Luis Chamberlain suggested, I split the patch:
> > [init/initramfs.c: make initramfs support pivot_root]
> > (https://lore.kernel.org/linux-fsdevel/20210520154244.20209-1-dong.menglong@zte.com.cn/)
> > into three.
> >
> > The goal of the series patches is to make pivot_root() support initramfs.
> >
> > In the first patch, I introduce the function ramdisk_exec_exist(), which
> > is used to check the exist of 'ramdisk_execute_command' in LOOKUP_DOWN
> > lookup mode.
> >
> > In the second patch, I create a second mount, which is called
> > 'user root', and make it become the root. Therefore, the root has a
> > parent mount, and it can be umounted or pivot_root.
> >
> > In the third patch, I fix rootfs_fs_type with ramfs, as it is not used
> > directly any more, and it make no sense to switch it between ramfs and
> > tmpfs, just fix it with ramfs to simplify the code.
> >
> >
> > Changes since V2:
> >
> > In the first patch, I use vfs_path_lookup() in init_eaccess() to make the
> > path lookup follow the mount on '/'. After this, the problem reported by
> > Masami Hiramatsu is solved. Thanks for your report :/
>
> Thank you for the fix, I confirmed that the issue has been solved with this.
>
> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
>
> for this series.
>
> Regards,
>
>
> >
> >
> > Changes since V1:
> >
> > In the first patch, I add the flag LOOKUP_DOWN to init_eaccess(), to make
> > it support the check of filesystem mounted on '/'.
> >
> > In the second patch, I control 'user root' with kconfig option
> > 'CONFIG_INITRAMFS_USER_ROOT', and add some comments, as Luis Chamberlain
> > suggested.
> >
> > In the third patch, I make 'rootfs_fs_type' in control of
> > 'CONFIG_INITRAMFS_USER_ROOT'.
> >
> >
> >
> > Menglong Dong (3):
> >   init/main.c: introduce function ramdisk_exec_exist()
> >   init/do_cmounts.c: introduce 'user_root' for initramfs
> >   init/do_mounts.c: fix rootfs_fs_type with ramfs
> >
> >  fs/init.c            |  11 ++++-
> >  include/linux/init.h |   5 ++
> >  init/do_mounts.c     | 109 +++++++++++++++++++++++++++++++++++++++++++
> >  init/do_mounts.h     |  18 ++++++-
> >  init/initramfs.c     |  10 ++++
> >  init/main.c          |   7 ++-
> >  usr/Kconfig          |  10 ++++
> >  7 files changed, 166 insertions(+), 4 deletions(-)
> >
> > --
> > 2.32.0.rc0
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

Thanks!
Menglong Dong
