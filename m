Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6041C83D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 09:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgEGHx0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 03:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGHx0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 03:53:26 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFD8C061A10
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 00:53:25 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id d128so2467401ybb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 00:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgTNxE5V/BIoY+I2iej30rSKy2BONiHOg6xHs9/0haE=;
        b=VCVIOMQ+K00QYE9ISlJoTypjvzNFrWABj7QekDFf12RqWKRjdx7Kpz16H7FyREAFNC
         WtxTlKuz1PgB8QOnv6dh+GARbk9hYdmybcuDpYgds7N1S4nwdjMiFtwQw4lGDeFKQuTr
         R8Vj8AHdkJOsV8b3umhNzNYuiFP6vSD+y5KWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgTNxE5V/BIoY+I2iej30rSKy2BONiHOg6xHs9/0haE=;
        b=lENMhykdeIru6WgbVWxylDUL5G/6FZAYmqIypib5Zuqnn8S+hX+E+8aSDusCjT9hIj
         z5iS8CWU2sPVNCH51rulUXGLx5ssOW0QWvM/eiSe97AQ0lGGKNapFi5FHwohpeZLy5Wt
         czpReR7JCQqosD1ylMHyGGpo+POn4nf1G9XuHLJUeCDwKvExBLZk3QY5Y7sj+8hUuyKo
         AXXqyf4yhmFSEi5H0wUwUA9u9kgspKV3mJ8qrbP8099vGNPpD4IyfiiY8r7YbvSw41xd
         /DkXAlzg1PBJlZiXX+1ln2KHoWeBq8QW48cBJFtj5Tk/oXeWZLYfqiltJ/O9srcwqJbU
         Sfcg==
X-Gm-Message-State: AGi0PuZ4DyYGK8L44BOSruAEY5mnl8GRW5nq9VnzmJf+WApuKB+HQmK0
        Fv3Z4BiB3McP7FM/a9bFWN69VxC6dyiWT5hIBoTLp2LmRks=
X-Google-Smtp-Source: APiQypKzxvACMqP5AxY1MoY/SHW7V+qfJxu1YY5t126G9oMUC4ly5Vbyts90wjdKdQ+7rz3EWChXHiOQ9BIBo2yyB9I=
X-Received: by 2002:a5b:383:: with SMTP id k3mr19517913ybp.51.1588838004820;
 Thu, 07 May 2020 00:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFHJroyC8SAFJZuQxcwHqph5EQRg=MqFdvfnwbK35Cv-A-neA@mail.gmail.com>
 <CAJfpegtWEMd_bCeULG13PACqPq5G5HbwKjMOnCoXyFQViXE0yQ@mail.gmail.com> <CAEjxPJ56JXRr0MWxtekBhfNS7i8hFex2oiwqGYrh=m1cH9X4kg@mail.gmail.com>
In-Reply-To: <CAEjxPJ56JXRr0MWxtekBhfNS7i8hFex2oiwqGYrh=m1cH9X4kg@mail.gmail.com>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Thu, 7 May 2020 16:53:13 +0900
Message-ID: <CAJFHJrppbb1cUTq9w7G7E2RrV5CbYx54dAfk62tiZYCewcwXhg@mail.gmail.com>
Subject: Re: fuse doesn't use security_inode_init_security?
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        LSM <linux-security-module@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 2, 2020 at 12:46 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> I am wondering how would fuse initialize the security context of newly
> created file. One way seems to be that it passes that information
> as part of FUSE_CREATE/FUSE_MKNOD calls to server and server sets
> its "fscreate" accordingly and then creates new file. This is similar
> to virtiofsd changing its effective uid/gid to the fuse client so that
> file is created with caller's uid/gid. Seems to be selinux context for
> file creation probably should be handled similiarly.
>

How would the fuse driver get the correct context without going
through security_inode_init_security?

> Other method could be to first create new file and then new fuse
> commands to do setxattrs. But that will be racy as file will have
> some default label for sometime between creation and setxattr.
>
> Having said that, I have a question. How do you reconcile host selinux
> policy and guest selinux labels. I am assuming host selinux policy
> will have to know about guest labels so that it allows virtiofsd do
> set those labels? Dan, you might have more thoughts on this.
>

My understanding is that we currently merge the guest and host
policies so that all types in the guest are available on the host.
The host itself uses selinux in permissive mode.  The top-level
directory is also owned exclusively by the guest and host processes
don't have access to it.


On Sat, May 2, 2020 at 3:32 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
>
> (cc selinux list)
>
> security_inode_init_security() calls the initxattrs callback to
> actually set each xattr in the backing store (if any), so unless you
> have a way to pass that to the daemon along with the create request
> the attribute won't be persisted with the file.  Setting the xattrs is
> supposed to be atomic with the file creation, not a separate
> setxattr() operation after creating the file, similar to ACL
> inheritance on new files.
>

But it's not truly atomic, is it?  The underlying file system creates
the inode and then the inode_init_security selinux hook actually sets
the attributes.  What would happen if the computer lost power after
the file system driver created the inode but before the selinux hook
set the attributes?

> Also possibly related
> https://lore.kernel.org/selinux/6df9b58c-fe9b-28f3-c151-f77aa6dd67e7@tycho.nsa.gov/.

Interesting.  Let me pull out the relevant bits and respond inline.

> - deadlock during mount with userspace waiting for mount(2) to complete
> and the kernel blocked on requesting the security.selinux xattr of the
> root directory as part of superblock setup during mount

I haven't personally run into this.  It Just Works, except for the
fscreate issue.

> - there was an attempt to introduce distinctions based on filesystem
> "subtype" so that whitelisted fuse filesystems could have xattr support
> enabled when it was known that their userspace would handle mount(2)
> safely [3] but this was apparently always broken and later reverted [4].

I think we kind of side-stepped this issue.  The fstype for virtiofs
is "virtiofs" instead of something like "fuse.virtiofs" so there is no
subtype handling required.

> - there is the issue of trusting the fuse filesystem for its labeling
> information and for domain/context transitions

This is definitely an issue for regular fuse file systems.  However,
the virtiofs device has read/write access to all the VM's memory so
there isn't much the VM can do if it doesn't trust the device.



I guess what I'm trying to understand is: what are the issues with
having the fuse driver call the inode_init_security hooks?  Even if
it's not something that can be turned on by default in mainline, I'd
like to evaluate whether we can turn it on locally in our restricted
environment.

One issue is the lack of atomicity guarantees.  This is likely a
deal-breaker for general fuse usage.  However, I don't think it's an
issue for our restricted use of virtiofs because the attributes will
be set "atomically" from the guest userspace's perspective.  It won't
be atomic on the host side, but host processes don't have access to
those directories anyway.

Are there any other issues?

Thank you,
Chirantan
