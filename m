Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC2046BCE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 14:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhLGNvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 08:51:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237179AbhLGNvo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638884893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WyBeZZ1ZcILJZUI8pies6VTu9FLLmBjrF9ykx/ImufE=;
        b=dLjNvG6d32jOsk+gPGEZ1yFkRsSvvzH+dBhWH4SwdgZU9dUoEifZzNMJGM1ltuFj9ZnV55
        4GUvX6oiObTrUDU9hIoL+wj5QOlOy9GZf+esdEYZNesRh0NzaO24Dr2weWt8kmRyT04q3C
        LCAFHGdj3rdhUgG0EufEoQH/omZsnd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-MUjMWYODP1mEUoYwu3fQyA-1; Tue, 07 Dec 2021 08:48:12 -0500
X-MC-Unique: MUjMWYODP1mEUoYwu3fQyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D97C1014B7F;
        Tue,  7 Dec 2021 13:48:08 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68A2D1002390;
        Tue,  7 Dec 2021 13:48:08 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id F0F3E225F1A; Tue,  7 Dec 2021 08:48:07 -0500 (EST)
Date:   Tue, 7 Dec 2021 08:48:07 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Eric Wong <normalperson@yhbt.net>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org
Subject: Re: per-inode locks in FUSE (kernel vs userspace)
Message-ID: <Ya9mF98V3hlOkHxK@redhat.com>
References: <20211203000534.M766663@dcvr>
 <Ya6OkznJxzAFe8fT@redhat.com>
 <CAJfpegs2o+TSxOSB2GFOzrMcrSvBcz0RDwWkJ-TyPyYM1hf5nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs2o+TSxOSB2GFOzrMcrSvBcz0RDwWkJ-TyPyYM1hf5nQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 09:38:10AM +0100, Miklos Szeredi wrote:
> On Mon, 6 Dec 2021 at 23:29, Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Fri, Dec 03, 2021 at 12:05:34AM +0000, Eric Wong wrote:
> > > Hi all, I'm working on a new multi-threaded FS using the
> > > libfuse3 fuse_lowlevel.h API.  It looks to me like the kernel
> > > already performs the necessary locking on a per-inode basis to
> > > save me some work in userspace.
> > >
> > > In particular, I originally thought I'd need pthreads mutexes on
> > > a per-inode (fuse_ino_t) basis to protect userspace data
> > > structures between the .setattr (truncate), .fsync, and
> > > .write_buf userspace callbacks.
> > >
> > > However upon reading the kernel, I can see fuse_fsync,
> > > fuse_{cache,direct}_write_iter in fs/fuse/file.c all use
> > > inode_lock.  do_truncate also uses inode_lock in fs/open.c.
> > >
> > > So it's look like implementing extra locking in userspace would
> > > do nothing useful in my case, right?
> >
> > I guess it probably is a good idea to implement proper locking
> > in multi-threaded fs and not rely on what kind of locking
> > kernel is doing. If kernel locking changes down the line, your
> > implementation will be broken.
> 
> Thing is, some fuse filesystem implementations already do rely on
> kernel locking.   So while it shouldn't hurt to have an extra layer of
> locking (except complexity and performance) it's not necessary.

I am wondering if same applies to virtiofs. In that case guest kernel
is untrusted entity. So we don't want to run into a situation where
guest kernel can somehow corrupt shared data structures of virtiofsd
and that somehow opens the door for some other bad outcome. May be in
that case it is safer to not rely on guest kernel locking.
> 
> See for example FUSE_PARALLEL_DIROPS which was added due to kernel
> locking changes to avoid breaking backward compatibility.

Good to know about this option. I checked that fuse_lowlevel.c enables
it by default. So I should be fine from virtiofsd point of view.

Thanks
Vivek

