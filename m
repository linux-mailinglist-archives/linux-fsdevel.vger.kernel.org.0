Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABF546BD43
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 15:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbhLGOLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 09:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhLGOLl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:11:41 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB500C061574
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 06:08:11 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id 70so9347198vkx.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 06:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zqsHzBWYzM84hSQlH8UJWwpGB/b5bWE+JndADUkKDI=;
        b=RC6tT0DIuknbtSHbEIxK6l3PbvVKPszTX/qmZNewHDPGjZYGlvzhPlf6hKeR2yWBCf
         NC1I8oJMc/KN2CsZzF7oufNJ9FbP2DLCfHdfDN8Ve0DiqgYz1bVVdgUeZLDVk4B2xqi0
         Uol1TTov2uyL40aX9LhIUbUt54ztyCnqAFFM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zqsHzBWYzM84hSQlH8UJWwpGB/b5bWE+JndADUkKDI=;
        b=0jZjPa0kJWEwoNqLjMDjlFyjGppQE4SykOOynT8hCiM0WCXMUl6c3Jfbb89K1WSvbp
         fM0sNnIeU8eRdAuWcsNFjgGUTsu3uLU7edB3HmBDZs+gvJjLOmm8rp5teiBteE1u0FjS
         +LUPZnlAA1t4Jp9z0q398FV2vj6nkkhmwYdt6ORR3NryEmDujI16v03MOYBbsNyncBKX
         0YroNo1xOsanJekk6gmgd5Nvp4/0yOCFDPWuTs7KwIPcDWwpbbNZaZyFQguxfPDLlXJ+
         NjJ3jqqDY+sOaIQXVFQkAZEzpnt/OCggLSK+wE0CeH5TtPzKgpikMyUCWd7CGS10STli
         CPvA==
X-Gm-Message-State: AOAM530rhp9Ve0S8ewX+tFPRHAvPwx1TOTwC8LhMPPuVJwlm+tfFFic8
        ONXNu2+RX3bXv7yujt5YNzApzXuXCGgQyCUV+XVcOg==
X-Google-Smtp-Source: ABdhPJwIvpWjNBWWKwphN3PHxLdPWshS3rLXyf3OeoNTFoBBcmq/ST1fu1FAG5TtP95pncHQlEOWJQ9hDy4UoQp+u20=
X-Received: by 2002:a05:6122:a02:: with SMTP id 2mr53588837vkn.6.1638886090813;
 Tue, 07 Dec 2021 06:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20211203000534.M766663@dcvr> <Ya6OkznJxzAFe8fT@redhat.com>
 <CAJfpegs2o+TSxOSB2GFOzrMcrSvBcz0RDwWkJ-TyPyYM1hf5nQ@mail.gmail.com> <Ya9mF98V3hlOkHxK@redhat.com>
In-Reply-To: <Ya9mF98V3hlOkHxK@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Dec 2021 15:07:59 +0100
Message-ID: <CAJfpegv1eDv062nnfXragUcMvb7ksonWwAB6J14-9_kxLtsa9g@mail.gmail.com>
Subject: Re: per-inode locks in FUSE (kernel vs userspace)
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Eric Wong <normalperson@yhbt.net>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 7 Dec 2021 at 14:48, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Dec 07, 2021 at 09:38:10AM +0100, Miklos Szeredi wrote:
> > On Mon, 6 Dec 2021 at 23:29, Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Fri, Dec 03, 2021 at 12:05:34AM +0000, Eric Wong wrote:
> > > > Hi all, I'm working on a new multi-threaded FS using the
> > > > libfuse3 fuse_lowlevel.h API.  It looks to me like the kernel
> > > > already performs the necessary locking on a per-inode basis to
> > > > save me some work in userspace.
> > > >
> > > > In particular, I originally thought I'd need pthreads mutexes on
> > > > a per-inode (fuse_ino_t) basis to protect userspace data
> > > > structures between the .setattr (truncate), .fsync, and
> > > > .write_buf userspace callbacks.
> > > >
> > > > However upon reading the kernel, I can see fuse_fsync,
> > > > fuse_{cache,direct}_write_iter in fs/fuse/file.c all use
> > > > inode_lock.  do_truncate also uses inode_lock in fs/open.c.
> > > >
> > > > So it's look like implementing extra locking in userspace would
> > > > do nothing useful in my case, right?
> > >
> > > I guess it probably is a good idea to implement proper locking
> > > in multi-threaded fs and not rely on what kind of locking
> > > kernel is doing. If kernel locking changes down the line, your
> > > implementation will be broken.
> >
> > Thing is, some fuse filesystem implementations already do rely on
> > kernel locking.   So while it shouldn't hurt to have an extra layer of
> > locking (except complexity and performance) it's not necessary.
>
> I am wondering if same applies to virtiofs. In that case guest kernel
> is untrusted entity. So we don't want to run into a situation where
> guest kernel can somehow corrupt shared data structures of virtiofsd
> and that somehow opens the door for some other bad outcome. May be in
> that case it is safer to not rely on guest kernel locking.

That's true, virtiofs has inverted trust model, so the server must not
assume anything from the client.

Thanks,
Miklos
