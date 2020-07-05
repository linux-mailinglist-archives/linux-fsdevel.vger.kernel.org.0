Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335FA214C49
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 14:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGEMAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 08:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGEMAB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 08:00:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5834C20708;
        Sun,  5 Jul 2020 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593950400;
        bh=EYV4BEyFaXQt1VRsg7oCnvXDXA2qdM5fANKa6Er1s9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLiuvOSW5tG3I+Wl+TUTcoFnA88jTQg7/nqpmOXC/AOuyKSf8z0A8iFO0gkgmV5NT
         iwFKSFGaeJ+WICwzHmBK6zmyuJpKw6mKFTopQjG3V0/abiELcEa5OyomHym4mEF2hh
         q+A8071zcTBOofSS9H3c3eg2HLN3c6XvNhTcwGnI=
Date:   Sun, 5 Jul 2020 14:00:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Matthew Wilcox <willy@infradead.org>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200705120003.GC1227929@kroah.com>
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org>
 <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
 <37170CC1-C132-40BE-8ABA-B14E3419975C@dilger.ca>
 <CAODFU0qT07ERWVH7F3rO1CK6CckmoF4p8ArHk09S9DCojD8M4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODFU0qT07ERWVH7F3rO1CK6CckmoF4p8ArHk09S9DCojD8M4w@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 05, 2020 at 09:25:39AM +0200, Jan Ziak wrote:
> On Sun, Jul 5, 2020 at 8:32 AM Andreas Dilger <adilger@dilger.ca> wrote:
> >
> > On Jul 4, 2020, at 8:46 PM, Jan Ziak <0xe2.0x9a.0x9b@gmail.com> wrote:
> > >
> > > On Sun, Jul 5, 2020 at 4:16 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >>
> > >> On Sun, Jul 05, 2020 at 04:06:22AM +0200, Jan Ziak wrote:
> > >>> Hello
> > >>>
> > >>> At first, I thought that the proposed system call is capable of
> > >>> reading *multiple* small files using a single system call - which
> > >>> would help increase HDD/SSD queue utilization and increase IOPS (I/O
> > >>> operations per second) - but that isn't the case and the proposed
> > >>> system call can read just a single file.
> > >>>
> > >>> Without the ability to read multiple small files using a single system
> > >>> call, it is impossible to increase IOPS (unless an application is
> > >>> using multiple reader threads or somehow instructs the kernel to
> > >>> prefetch multiple files into memory).
> > >>
> > >> What API would you use for this?
> > >>
> > >> ssize_t readfiles(int dfd, char **files, void **bufs, size_t *lens);
> > >>
> > >> I pretty much hate this interface, so I hope you have something better
> > >> in mind.
> > >
> > > I am proposing the following:
> > >
> > > struct readfile_t {
> > >  int dirfd;
> > >  const char *pathname;
> > >  void *buf;
> > >  size_t count;
> > >  int flags;
> > >  ssize_t retval; // set by kernel
> > >  int reserved; // not used by kernel
> > > };
> >
> > If you are going to pass a struct from userspace to the kernel, it
> > should not mix int and pointer types (which may be 64-bit values,
> > so that there are not structure packing issues, like:
> >
> > struct readfile {
> >         int     dirfd;
> >         int     flags;
> >         const char *pathname;
> >         void    *buf;
> >         size_t  count;
> >         ssize_t retval;
> > };
> >
> > It would be better if "retval" was returned in "count", so that
> > the structure fits nicely into 32 bytes on a 64-bit system, instead
> > of being 40 bytes per entry, which adds up over many entries, like.
> 
> I know what you mean and it is a valid point, but in my opinion it
> shouldn't (in most cases) be left to the programmer to decide what the
> binary layout of a data structure is - instead it should be left to an
> optimizing compiler to decide it.

We don't get that luxury when creating user/kernel apis in C, sorry.

I suggest using the pahole tool if you are interested in seeing the
"best" way a structure can be layed out, it can perform that
optimization for you so that you know how to fix your code.

thanks,

greg k-h
