Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED38E21F722
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 18:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgGNQVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 12:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNQVB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:21:01 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4080E22464;
        Tue, 14 Jul 2020 16:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594743660;
        bh=E38vMsAxFSlFIo4drOGuYd3sCAjrfVUhzMuB2wxIj68=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nlKMLOTOIWpAiZl2ssQXoOhdwG9xzjVorrZSyzIdyNiik4/KKe5K3SQeDp4mSdDXS
         y4mCyyBus0LI1oJv5TfEGfar1NvLcJ5169esYN2OMAHmcHny9osmBuQerzM1XD37nS
         /b9IkrdeFDkv3wdvF2xYhqImg1GR1ErevzBAh6eA=
Received: by mail-lf1-f47.google.com with SMTP id k15so12157141lfc.4;
        Tue, 14 Jul 2020 09:21:00 -0700 (PDT)
X-Gm-Message-State: AOAM533/dHooVDLl1hChadUmPgOLsViVcyfDI/lv35whYS0VMlewzTbt
        Lk5IMMwnlf6ClgocuDEZ/toVQW+jQxSUl2MbVgw=
X-Google-Smtp-Source: ABdhPJxZLAV4S9WCT3ZxkF8ZklvWBJDIbNjfx6VOSVHC8MJht7x0CSXrUU77WMEWA8atRs+0j7CJIuAcKapTxJQ0gqU=
X-Received: by 2002:a19:701:: with SMTP id 1mr2529140lfh.138.1594743658597;
 Tue, 14 Jul 2020 09:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200709151814.110422-1-hch@lst.de> <31944685-7627-43BA-B9A2-A4743AFF0AB7@zytor.com>
 <20200714064111.GB32655@lst.de>
In-Reply-To: <20200714064111.GB32655@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 14 Jul 2020 09:20:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4bNTXE3CTLthUNtnnwf2f9K57gcBxPAjyvgziLrUvyDw@mail.gmail.com>
Message-ID: <CAPhsuW4bNTXE3CTLthUNtnnwf2f9K57gcBxPAjyvgziLrUvyDw@mail.gmail.com>
Subject: Re: decruft the early init / initrd / initramfs code v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        open list <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 11:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 09, 2020 at 04:32:07PM -0700, hpa@zytor.com wrote:
> > On July 9, 2020 8:17:57 AM PDT, Christoph Hellwig <hch@lst.de> wrote:
> > >Hi all,
> > >
> > >this series starts to move the early init code away from requiring
> > >KERNEL_DS to be implicitly set during early startup.  It does so by
> > >first removing legacy unused cruft, and the switches away the code
> > >from struct file based APIs to our more usual in-kernel APIs.
> > >
> > >There is no really good tree for this, so if there are no objections
> > >I'd like to set up a new one for linux-next.
> > >
> > >
> > >Git tree:
> > >
> > >    git://git.infradead.org/users/hch/misc.git init-user-pointers
> > >
> > >Gitweb:
> > >
> > >http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/init-user-pointers
> > >
> > >
> > >Changes since v1:
> > > - add a patch to deprecated "classic" initrd support
> > >
> > >Diffstat:
> > > b/arch/arm/kernel/atags_parse.c |    2
> > > b/arch/sh/kernel/setup.c        |    2
> > > b/arch/sparc/kernel/setup_32.c  |    2
> > > b/arch/sparc/kernel/setup_64.c  |    2
> > > b/arch/x86/kernel/setup.c       |    2
> > > b/drivers/md/Makefile           |    3
> > >b/drivers/md/md-autodetect.c    |  239
> > >++++++++++++++++++----------------------
> > > b/drivers/md/md.c               |   34 +----
> > > b/drivers/md/md.h               |   10 +
> > > b/fs/file.c                     |    7 -
> > > b/fs/open.c                     |   18 +--
> > > b/fs/read_write.c               |    2
> > > b/fs/readdir.c                  |   11 -
> > > b/include/linux/initrd.h        |    6 -
> > > b/include/linux/raid/detect.h   |    8 +
> > > b/include/linux/syscalls.h      |   16 --
> > > b/init/Makefile                 |    1
> > > b/init/do_mounts.c              |   70 +----------
> > > b/init/do_mounts.h              |   21 ---
> > > b/init/do_mounts_initrd.c       |   13 --
> > > b/init/do_mounts_rd.c           |  102 +++++++----------
> > > b/init/initramfs.c              |  103 +++++------------
> > > b/init/main.c                   |   16 +-
> > > include/linux/raid/md_u.h       |   13 --
> > > 24 files changed, 251 insertions(+), 452 deletions(-)
> >
> > I guess I could say something here... ;)
>
> Like adding an ACK? :)

For the md bits:
Acked-by: Song Liu <song@kernel.org>

Thanks!
