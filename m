Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A775847618F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 20:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhLOTUa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 14:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231524AbhLOTU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639596029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G7VD3Szyvq25vaNuJ5+4OE3yC8yR7SPHmlrDoqsf1NQ=;
        b=CAYgtBsHO0r4B5qE7qGZhHdNcDb3hTbtnCQCD8HC5AkOb8BMMahLN8CDZKCSIXu4OELE2c
        faS/EG+j41PWdwubTitZRglkVw5/cwVxCja0XRmGjYkelVsOVm4m8Jr7kq7JVW1+Xx5y7A
        fCbVf7apv9Fp7Bf7o0AbHN/aSX5VfQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-YLK-V7NANJmgg6pXjdH-Lw-1; Wed, 15 Dec 2021 14:20:25 -0500
X-MC-Unique: YLK-V7NANJmgg6pXjdH-Lw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 385A710151E0;
        Wed, 15 Dec 2021 19:20:23 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45C475BE12;
        Wed, 15 Dec 2021 19:20:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C89ED2206B8; Wed, 15 Dec 2021 14:20:06 -0500 (EST)
Date:   Wed, 15 Dec 2021 14:20:06 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>,
        Stef Bon <stefbon@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>,
        Nathan Youngman <git@nathany.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Message-ID: <Ybo/5h9umGlinaM4@redhat.com>
References: <20211111173043.GB25491@quack2.suse.cz>
 <CAOQ4uxiOUM6=190w4018w4nJRnqi+9gzzfQTsLh5gGwbQH_HgQ@mail.gmail.com>
 <CANXojcy9JzXeLQ6bz9+UOekkpqo8NkgQbhugmGmPE+x3+_=h3Q@mail.gmail.com>
 <CAO17o21YVczE2-BTAVg-0HJU6gjSUkzUSqJVs9k-_t7mYFNHaA@mail.gmail.com>
 <CAOQ4uxjpGMYZrq74S=EaSO2nvss4hm1WZ_k+Xxgrj2k9pngJgg@mail.gmail.com>
 <YaZC+R7xpGimBrD1@redhat.com>
 <CAO17o21uh3fJHd0gMu-SmZei5et6HJo91DiLk_YyfUqrtHy2pQ@mail.gmail.com>
 <CAOQ4uxjfCs=+Of69U6moOJ9T6_zDb1wcrLXWu4DROVme1cNnfQ@mail.gmail.com>
 <YbobZMGEl6sl+gcX@redhat.com>
 <CAOQ4uxj9XZNhHB3y9LuGcUJYp-i4f-LXQa2tzX8AkZpRERH+8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj9XZNhHB3y9LuGcUJYp-i4f-LXQa2tzX8AkZpRERH+8w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 15, 2021 at 07:29:29PM +0200, Amir Goldstein wrote:
> > >
> > > The mistake in your premise at 1) is to state that "fuse does not
> > > support persistent file handles"
> > > without looking into what that statement means.
> > > What it really means is that user cannot always open_by_handle_at()
> > > from a previously
> > > obtained file handle, which has obvious impact on exporting fuse to NFS (*).
> >
> > Hi Amir,
> >
> > What good is file handle if one can't use it for open_by_handle_at(). I
> > mean, are there other use cases?
> 
> commit 44d705b0:
> "...There are several ways that an application can use this information:
> 
>     1. When watching a single directory, the name is always relative to
>     the watched directory, so application need to fstatat(2) the name
>     relative to the watched directory.
> 
>     2. When watching a set of directories, the application could keep a map
>     of dirfd for all watched directories and hash the map by fid obtained
>     with name_to_handle_at(2).  When getting a name event, the fid in the
>     event info could be used to lookup the base dirfd in the map and then
>     call fstatat(2) with that dirfd.

Ok, so case 1 and 2 still might be doable.

> 
>     3. When watching a filesystem (FAN_MARK_FILESYSTEM) or a large set of
>     directories, the application could use open_by_handle_at(2) with the fid
>     in event info to obtain dirfd for the directory where event happened and
>     call fstatat(2) with this dirfd.
> 
>     The last option scales better for a large number of watched directories.
>     The first two options may be available in the future also for non
>     privileged fanotify watchers, because open_by_handle_at(2) requires
>     the CAP_DAC_READ_SEARCH capability.
> "

This is one is not possible as it needs open_by_handle_at().

> 
> fsnotifywait [1] has an example of use case #2.
> Essentially, when watching inodes, the fanotify file identifier is not very much
> different from the inotify "watch descriptor" - it identifies the watched object
> and the watched object is pinned to cache as long as the inode mark is set
> so file handle would not change also in fuse.

Ok, so if we are maintaining a hash map keyed by file handle, then first
we need to pin down the inode and then call name_to_handle_at() for the
watched object and add to hash table. Something like this.

A. foo_fd = open(foo.txt)
B. name_to_handle_at(.., foo.txt,...)
C. Add info in hash table using foo_handle as key.
D. Add watch on foo.txt (fanotify_mark()).
E. close(foo_fd). 

One could probably skip step A and E. And do this instead.

A. Add watch on foo.txt (fanotify_mark())
B. name_to_handle_at(.., foo.txt,...)
C. Add info in hash table using foo_handle as key.

But this is little bit racy. You might start getting events with file
handles of foo.txt before you could complete B or C.

> 
> [1] https://github.com/inotify-tools/inotify-tools/pull/134
> 
> >
> > IIUC, file handle for the same object can change if inode had been flushed
> > out of guest cache and brought back in later. So if application say
> > generated file handle for an object and saved it and later put a watch
> > on that object, by that time file handle of the object might have changed
> > (as seen by fuse). So one can't even use to match it with previous saved
> > file handle.
> >
> 
> The argument is not applicable for inode watches.

Fair enough. I could see a very limited use case and thought that's not
enough. But looks like you seem to be ok with that.

> Filesystem and mount watches are not going to be supported with virtiofs
> or any filesystem that does not support persistent file handles.

Ok, so no filesystem and mount watches for virtiofs to begin with.

> 
> > So I can't use file handle for open_by_handle_at(). I can't use it to
> > match it with previously saved file handle. So what can I use it for?
> >
> > IOW, I could not imagine supporting fanotify file handles without
> > fixing the file handles properly in fuse. And it needs fixing in
> > virtiofs as well as we can't trust random file handles from guest
> > for regular files.
> >
> 
> Partly correct statements, but when looking at the details, they are
> not relevant to the case of fanotify inode watch.
> 
> Note that at the moment, fuse does not even support local fanotify
> watch with file handles because of fanotify_test_fsid() - fuse does
> not set f_fsid (not s_uuid), so it's not really about supporting fanotify
> on fuse now.

Hmm..., that means we first will have to look into supporting local
fanotify events with file handles on fuse. Without that we can't even
test our remote fsnotify changes looks like.

This sounds like another blocker (or dependency project to complete first)
before one can make progress with remote inotify/fanotify/fsnotify.

> It's about the vfs APIs for remote fsnotify that should not be inotify
> specific.

I understand that part. But at the same time, remote fsnotify API will
probably evolve as you keep on adding more functionality. What if there
is another notification mechanism tomorrow say newfancynotify(), we
might have to modify remote fsnoitfy again to accomodate that.

IOW, fsnotify seems to be just underlying plumbing and whatever you
add today might not be enough to support tomorrow's features. That's
why I wanted to start with a minimal set of functionality and add
more to it later.

Thanks
Vivek

