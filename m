Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4778121E870
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 08:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgGNGlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 02:41:14 -0400
Received: from verein.lst.de ([213.95.11.211]:52891 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgGNGlO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:41:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CA0668CF0; Tue, 14 Jul 2020 08:41:11 +0200 (CEST)
Date:   Tue, 14 Jul 2020 08:41:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     hpa@zytor.com
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: decruft the early init / initrd / initramfs code v2
Message-ID: <20200714064111.GB32655@lst.de>
References: <20200709151814.110422-1-hch@lst.de> <31944685-7627-43BA-B9A2-A4743AFF0AB7@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31944685-7627-43BA-B9A2-A4743AFF0AB7@zytor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 04:32:07PM -0700, hpa@zytor.com wrote:
> On July 9, 2020 8:17:57 AM PDT, Christoph Hellwig <hch@lst.de> wrote:
> >Hi all,
> >
> >this series starts to move the early init code away from requiring
> >KERNEL_DS to be implicitly set during early startup.  It does so by
> >first removing legacy unused cruft, and the switches away the code
> >from struct file based APIs to our more usual in-kernel APIs.
> >
> >There is no really good tree for this, so if there are no objections
> >I'd like to set up a new one for linux-next.
> >
> >
> >Git tree:
> >
> >    git://git.infradead.org/users/hch/misc.git init-user-pointers
> >
> >Gitweb:
> >
> >http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/init-user-pointers
> >
> >
> >Changes since v1:
> > - add a patch to deprecated "classic" initrd support
> >
> >Diffstat:
> > b/arch/arm/kernel/atags_parse.c |    2 
> > b/arch/sh/kernel/setup.c        |    2 
> > b/arch/sparc/kernel/setup_32.c  |    2 
> > b/arch/sparc/kernel/setup_64.c  |    2 
> > b/arch/x86/kernel/setup.c       |    2 
> > b/drivers/md/Makefile           |    3 
> >b/drivers/md/md-autodetect.c    |  239
> >++++++++++++++++++----------------------
> > b/drivers/md/md.c               |   34 +----
> > b/drivers/md/md.h               |   10 +
> > b/fs/file.c                     |    7 -
> > b/fs/open.c                     |   18 +--
> > b/fs/read_write.c               |    2 
> > b/fs/readdir.c                  |   11 -
> > b/include/linux/initrd.h        |    6 -
> > b/include/linux/raid/detect.h   |    8 +
> > b/include/linux/syscalls.h      |   16 --
> > b/init/Makefile                 |    1 
> > b/init/do_mounts.c              |   70 +----------
> > b/init/do_mounts.h              |   21 ---
> > b/init/do_mounts_initrd.c       |   13 --
> > b/init/do_mounts_rd.c           |  102 +++++++----------
> > b/init/initramfs.c              |  103 +++++------------
> > b/init/main.c                   |   16 +-
> > include/linux/raid/md_u.h       |   13 --
> > 24 files changed, 251 insertions(+), 452 deletions(-)
> 
> I guess I could say something here... ;)

Like adding an ACK? :)
