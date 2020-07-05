Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F92B214AE7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 09:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgGEH0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 03:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGEH0Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 03:26:16 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7B3C061794;
        Sun,  5 Jul 2020 00:26:16 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id w17so29026401oie.6;
        Sun, 05 Jul 2020 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKw4EpxGN0YdG0VPpIynr/J1EkJpB2HGlu3HY3J+Zvk=;
        b=LtFTmZribUAaCdwyIEUFNXYwJHgjPTnGLn20NUfrHIqEC1c8KqMwnEBhRMxf/n6MJz
         xwg82lZsH2MTD+zSzhgXYQNMX174cC3ouCR19rBLQYwC5ht8pBaZzserIIqxOKRLuWZe
         qq8zvDda+9Y3Crrf43PPHsyDNiKOWmf5TOu4ML2Ce3tW/pn0ryEJ2bVi1MonyfKm9o5m
         KbCeuM4cRQQz5MTwJfbj/Ao5c2mCBM1FYLjno8VxA9q/1JxWN+cbizX4AM+XxhvSsE2v
         bK0s2bN2UGZtmBG9mckhr8PpsWBwhvpwGe8/rSvhXSEMCyhli8KZ1C9Xbo5soGR+4+Aw
         vaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKw4EpxGN0YdG0VPpIynr/J1EkJpB2HGlu3HY3J+Zvk=;
        b=po5skEOSXOlhqO6g0kGu8XUi81B3gGkre4y2bi0IsHiIPI1vuNnBo+aq4b2+JryqUk
         vXrBEtfAB8GCKaowWvH/mWsoZnOVT131gHZyu4fJO+BkYqFrlz/Z49zEhSrniu0bZGKn
         UTESYumeOvTF5/CzV+JqIjwlurwH8mHiqPezVbNZZ/WOYjPpR0Jk2qG55euE3U//pWIR
         KtCEsFgfMutdM8Ws/GHPweSsNe1XwqAtBFE0qaxQepAm0iAYQ2pV4MI8Ey+vV3vyZAgi
         c5v0ujLGO8lf/FsHab6xAIunPFzdOfUST7baDXXApKWP6g7JVThFZjGgYn6O2Utx+jY7
         QFbw==
X-Gm-Message-State: AOAM532Uhb8/wu7ZQDDxMuxAkcYEJGpQIwZQ7PonvPxpGfFGZpHhWrzY
        Qq+CuTVU02F7tA1OB3ggxSm26whXgJun7ghHdOezgnp5ArE=
X-Google-Smtp-Source: ABdhPJw9w+l+t+8XHnfWcnulUprNuPdfKXpniuXmwOiRq9JDCafp1hy2ZINwxadA8jTnzoD4Vz9cmvpWiYaua4eS3uI=
X-Received: by 2002:aca:fc97:: with SMTP id a145mr22033692oii.149.1593933975349;
 Sun, 05 Jul 2020 00:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org> <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
 <37170CC1-C132-40BE-8ABA-B14E3419975C@dilger.ca>
In-Reply-To: <37170CC1-C132-40BE-8ABA-B14E3419975C@dilger.ca>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Sun, 5 Jul 2020 09:25:39 +0200
Message-ID: <CAODFU0qT07ERWVH7F3rO1CK6CckmoF4p8ArHk09S9DCojD8M4w@mail.gmail.com>
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close faster
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Matthew Wilcox <willy@infradead.org>, gregkh@linuxfoundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        shuah@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 5, 2020 at 8:32 AM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Jul 4, 2020, at 8:46 PM, Jan Ziak <0xe2.0x9a.0x9b@gmail.com> wrote:
> >
> > On Sun, Jul 5, 2020 at 4:16 AM Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >> On Sun, Jul 05, 2020 at 04:06:22AM +0200, Jan Ziak wrote:
> >>> Hello
> >>>
> >>> At first, I thought that the proposed system call is capable of
> >>> reading *multiple* small files using a single system call - which
> >>> would help increase HDD/SSD queue utilization and increase IOPS (I/O
> >>> operations per second) - but that isn't the case and the proposed
> >>> system call can read just a single file.
> >>>
> >>> Without the ability to read multiple small files using a single system
> >>> call, it is impossible to increase IOPS (unless an application is
> >>> using multiple reader threads or somehow instructs the kernel to
> >>> prefetch multiple files into memory).
> >>
> >> What API would you use for this?
> >>
> >> ssize_t readfiles(int dfd, char **files, void **bufs, size_t *lens);
> >>
> >> I pretty much hate this interface, so I hope you have something better
> >> in mind.
> >
> > I am proposing the following:
> >
> > struct readfile_t {
> >  int dirfd;
> >  const char *pathname;
> >  void *buf;
> >  size_t count;
> >  int flags;
> >  ssize_t retval; // set by kernel
> >  int reserved; // not used by kernel
> > };
>
> If you are going to pass a struct from userspace to the kernel, it
> should not mix int and pointer types (which may be 64-bit values,
> so that there are not structure packing issues, like:
>
> struct readfile {
>         int     dirfd;
>         int     flags;
>         const char *pathname;
>         void    *buf;
>         size_t  count;
>         ssize_t retval;
> };
>
> It would be better if "retval" was returned in "count", so that
> the structure fits nicely into 32 bytes on a 64-bit system, instead
> of being 40 bytes per entry, which adds up over many entries, like.

I know what you mean and it is a valid point, but in my opinion it
shouldn't (in most cases) be left to the programmer to decide what the
binary layout of a data structure is - instead it should be left to an
optimizing compiler to decide it. Just like code optimization,
determining the physical layout of data structures can be subject to
automatic optimizations as well. It is kind of unfortunate that in
C/C++, and in many other statically compiled languages (even recent
ones), the physical layout of all data structures is determined by the
programmer rather than the compiler. Also, tagging fields as "input",
"output", or both (the default) would be helpful in obtaining smaller
sizes:

struct readfile_t {
  input int dirfd;
  input const char *pathname;
  input void *buf;
  input size_t count;
  input int flags;
  output ssize_t retval; // set by kernel
  output int reserved; // not used by kernel
};

int readfiles(struct readfile_t *requests, size_t count);

struct readfile_t r[10];
// Write r[i] inputs
int status = readfiles(r, nelem(r));
// Read r[i] outputs

A data-layout optimizing compiler should be able to determine that the
optimal layout of readfile_t is UNION(INPUT: 2*int+2*pointer+1*size_t,
OUTPUT: 1*ssize_t+1*int).

In the unfortunate case of the non-optimizing C language and if it is
just a micro-optimization (optimizing readfile_t is a
micro-optimization), it is better to leave the data structure in a
form that is appropriate for being efficiently readable by programmers
rather than to micro-optimize it and make it confusing to programmers.

> struct readfile {
>         int     dirfd;
>         int     flags;
>         const char *pathname;
>         void    *buf;
>         ssize_t count;  /* input: bytes requested, output: bytes read or -errno */
> };
>
>
> However, there is still an issue with passing pointers from userspace,
> since they may be 32-bit userspace pointers on a 64-bit kernel.
>
> > int readfiles(struct readfile_t *requests, size_t count);
>
> It's not clear why count is a "size_t" since it is not a size.
> An unsigned int is fine here, since it should never be negative.

Generally speaking, size_t reflects the size of the address space
while unsigned int doesn't and therefore it is easier for unsigned int
to overflow on very large data sets.

> > Returns zero if all requests succeeded, otherwise the returned value
> > is non-zero (glibc wrapper: -1) and user-space is expected to check
> > which requests have succeeded and which have failed. retval in
> > readfile_t is set to what the single-file readfile syscall would
> > return if it was called with the contents of the corresponding
> > readfile_t struct.
> >
> > The glibc library wrapper of this system call is expected to store the
> > errno in the "reserved" field. Thus, a programmer using glibc sees:
> >
> > struct readfile_t {
> >  int dirfd;
> >  const char *pathname;
> >  void *buf;
> >  size_t count;
> >  int flags;
> >  ssize_t retval; // set by glibc (-1 on error)
> >  int errno; // set by glibc if retval is -1
> > };
>
> Why not just return the errno directly in "retval", or in "count" as
> proposed?  That avoids further bloating the structure by another field.
>
> > retval and errno in glibc's readfile_t are set to what the single-file
> > glibc readfile would return (retval) and set (errno) if it was called
> > with the contents of the corresponding readfile_t struct. In case of
> > an error, glibc will pick one readfile_t which failed (such as: the
> > 1st failed one) and use it to set glibc's errno.
>
>
> Cheers, Andreas
