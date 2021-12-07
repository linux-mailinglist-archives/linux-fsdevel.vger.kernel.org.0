Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A210146B633
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 09:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhLGIl6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 03:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhLGIlw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:41:52 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DE8C061746
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 00:38:22 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id 70so8740244vkx.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Dec 2021 00:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gByimeem3OTNaLpINNUmlIACGqRevPY9Zk80f+aJchc=;
        b=dGxLSUqXhH6Sf+cdRgas4nd2kl+UdZNqg8EbcbkxCG/hGoqLibRLHRAWF9HRq8pbBE
         rtc7GKcGextmuksqJabqrN3Slag61gRD7AQx/XefsKSW4EcsW8vzqcm2xOcPpO//fC/m
         ztkzTutYv7EOWQIxSekAdKdHP2ZZqMo8FmWBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gByimeem3OTNaLpINNUmlIACGqRevPY9Zk80f+aJchc=;
        b=fzh3xB1hLgtvgGzXLAPdV1FQNX0g3CuOcgU+JCOzC217vKzGBfial4wqYQz3BVAcqq
         1W3702UUulgvH4D1aizq7acbx68zo7cV0J3atE0hVSh2G4OBnGYkdFOcXGbRfbdfvl/K
         HdTGy50YG35SpXwg74jxn4zYxpPE4krdEX/utQ+l2PC8ul/A2MYnFyfnUD3QdfLYhHsn
         NrepvJdsOpstHgkAxdXvqTBzXEQoK5EGVNqjmRpqSDIpBKgIzicxmErusSU/uVt+hGUy
         4ir5oPf4QfUXh7hMxkps+slFdE7H24THbOAcMMuaFotXHio31y1pdfq3IpDlrr4dvcdj
         40Zg==
X-Gm-Message-State: AOAM532cMeP1avrKM2c72Md7GvmnKvT/lzg00G2/IDQBdohoLTFwdpro
        stx2AtQJpPEGR50ID4iNkCN3pfRGuy3PRrdRbQD9clhKDLC94w==
X-Google-Smtp-Source: ABdhPJwKeCJDHfue2QbxQCrks+PlFLhVl/C84Hm7LW4vKsmmUldv2LqNZO1gCdDCq0GvZOMocqszyBt4UQLaL1QSFqE=
X-Received: by 2002:a1f:52c7:: with SMTP id g190mr47914833vkb.1.1638866301328;
 Tue, 07 Dec 2021 00:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20211203000534.M766663@dcvr> <Ya6OkznJxzAFe8fT@redhat.com>
In-Reply-To: <Ya6OkznJxzAFe8fT@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Dec 2021 09:38:10 +0100
Message-ID: <CAJfpegs2o+TSxOSB2GFOzrMcrSvBcz0RDwWkJ-TyPyYM1hf5nQ@mail.gmail.com>
Subject: Re: per-inode locks in FUSE (kernel vs userspace)
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Eric Wong <normalperson@yhbt.net>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Dec 2021 at 23:29, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Dec 03, 2021 at 12:05:34AM +0000, Eric Wong wrote:
> > Hi all, I'm working on a new multi-threaded FS using the
> > libfuse3 fuse_lowlevel.h API.  It looks to me like the kernel
> > already performs the necessary locking on a per-inode basis to
> > save me some work in userspace.
> >
> > In particular, I originally thought I'd need pthreads mutexes on
> > a per-inode (fuse_ino_t) basis to protect userspace data
> > structures between the .setattr (truncate), .fsync, and
> > .write_buf userspace callbacks.
> >
> > However upon reading the kernel, I can see fuse_fsync,
> > fuse_{cache,direct}_write_iter in fs/fuse/file.c all use
> > inode_lock.  do_truncate also uses inode_lock in fs/open.c.
> >
> > So it's look like implementing extra locking in userspace would
> > do nothing useful in my case, right?
>
> I guess it probably is a good idea to implement proper locking
> in multi-threaded fs and not rely on what kind of locking
> kernel is doing. If kernel locking changes down the line, your
> implementation will be broken.

Thing is, some fuse filesystem implementations already do rely on
kernel locking.   So while it shouldn't hurt to have an extra layer of
locking (except complexity and performance) it's not necessary.

See for example FUSE_PARALLEL_DIROPS which was added due to kernel
locking changes to avoid breaking backward compatibility.
