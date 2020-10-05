Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12217283FD9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 21:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgJETr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 15:47:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:41704 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727834AbgJETr0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:47:26 -0400
Received: from [192.168.15.249] (helo=alex-laptop)
        by relay3.sw.ru with smtp (Exim 4.94)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1kPWRO-003AoN-Ss; Mon, 05 Oct 2020 22:46:34 +0300
Date:   Mon, 5 Oct 2020 22:46:42 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        David Howells <dhowells@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] overlayfs: C/R enhancments (RFC)
Message-Id: <20201005224642.0c23dbb66a637c7581be725f@virtuozzo.com>
In-Reply-To: <CAOQ4uxjot9f=XZEchRuNopVyZtKGzp7R7j5i2GxO_OuxUE8KMg@mail.gmail.com>
References: <20201004192401.9738-1-alexander.mikhalitsyn@virtuozzo.com>
        <CAOQ4uxjot9f=XZEchRuNopVyZtKGzp7R7j5i2GxO_OuxUE8KMg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir,

On Mon, 5 Oct 2020 10:56:50 +0300
Amir Goldstein <amir73il@gmail.com> wrote:

> On Sun, Oct 4, 2020 at 10:25 PM Alexander Mikhalitsyn
> <alexander.mikhalitsyn@virtuozzo.com> wrote:
> >
> > Some time ago we discussed about the problem of Checkpoint-Restoring
> > overlayfs mounts [1]. Big thanks to Amir for review and suggestions.
> >
> > Brief from previous discussion.
> > Problem statement: to checkpoint-restore overlayfs mounts we need
> > to save overlayfs mount state and save it into the image. Basically,
> > this state for us it's just mount options of overlayfs mount. But
> > here we have two problems:
> >
> > I. during mounting overlayfs user may specify relative paths in upperdir,
> > workdir, lowerdir options
> >
> > II. also user may unmount mount from which these paths was opened during mounting
> >
> > This is real problems for us. My first patch was attempt to address both problems.
> > 1. I've added refcnt get for mounts from which overlayfs was mounted.
> > 2. I've changed overlayfs mountinfo show algorithm, so overlayfs started to *always*
> > show full paths for upperdir,workdir,lowerdirs.
> > 3. I've added mnt_id show-time only option which allows to determine from which mnt_id
> > we opened options paths.
> >
> > Pros:
> > - we can determine full information about overlayfs mount
> > - we hold refcnt to mount, so, user may unmount source mounts only
> > with lazy flag
> >
> > Cons:
> > - by adding refcnt get for mount I've changed possible overlayfs usecases
> > - by showing *full* paths we can more easily reache PAGE_SIZE limit of
> > mounts options in procfs
> > - by adding mnt_id show-only option I've added inconsistency between
> > mount-time options and show-time mount options
> >
> > After very productive discussion with Amir and Pavel I've decided to write new
> > implementation. In new approach we decided *not* to take extra refcnts to mounts.
> > Also we decided to use exportfs fhandles instead of full paths. To determine
> > full path we plan to use the next algo:
> > 1. Export {s_dev; fhandle} from overlayfs for *all* sources
> > 2. User open_by_handle_at syscall to open all these fhandles (we need to
> > determine mount for each fhandle, looks like we can do this by s_dev by linear
> > search in /proc/<pid>/mountinfo)
> > 3. Then readlink /proc/<pid>/fd/<opened fd>
> > 4. Dump this full path+mnt_id
> >
> 
> Hi Alex,
> 
> The general concept looks good to me.
> I will not provide specific comment on the implementation (it looks
> fine) until the
> concept API is accepted by the maintainer.
> 
> The main thing I want to make sure is that if we add this interface it can
> serve other use cases as well.

Yes, let's create universal interface.

> 
> During my talk on LPC, I got a similar request from two developers for two
> different use cases. They wanted a safe method to iterate "changes
> since baseline"
> from either within the container or from the host.

This discussions was on lkml or in private room?

> 
> Your proposed API is a step in the direction for meeting their requirement.
> The major change is that ioctl (or whatever method) should expose the
> layers topology of a specific object, not only the overlay instance.
> 
> For C/R you would query the layers topology of the overlay root dir.
> 
> My comments of the specific methods below are not meant to
> object to the choice of ioctl, but they are meant to give the alternative
> a fair chance. I am kind of leaning towards ioctl myself.
> 
> > But there is question. How to export this {s_dev; fhandle} from kernel to userspace?
> > - We decided not to use procfs.
> 
> Why not?
> C/R already uses procfs to export fhandle for fanotify/inotify
> I kind of like the idea of having /sys/fs/overlay/instances etc.
> It could be useful to many things.

Ah, sorry. For some reason I've decided that we excluded procfs/sysfs option :)
Let's take this option into account too.

> 
> > - Amir proposed solution - use xattrs. But after diving into it I've meet problem
> > where I can set this xattrs?
> > If I set this xattrs on overlayfs dentries then during rsync, or cp -p=xattr we will copy
> > this temporary information.
> 
> No you won't.
> rsync, cp will only copy xattrs listed with listxattr.
> Several filesystems, such as cifs and nfs export "object properties"
> via private xattrs
> that are not listed in listxattr (e.g. CIFS_XATTR_CIFS_ACL).
> You are not limited in what you can do in the "trusted.overlay" namespace, for
> example "trusted.overlay.layers.0.fh"
> 
> The advantage is that it is very easy to implement and requires
> less discussions about ABI, but I agree it does feel a bit like a hack.

Ack. I can try to write some draft implementation with xattrs.

> 
> > - ioctls? (this patchset implements this approach)
> > - fsinfo subsystem (not merged yet) [2]
> >
> > Problems with ioctls:
> > 1. We limited in output data size (16 KB AFAIK)
> > but MAX_HANDLE_SZ=128(bytes), OVL_MAX_STACK=500(num lowerdirs)
> > So, MAX_HANDLE_SZ*OVL_MAX_STACK = 64KB which is bigger than limit.
> > So, I've decided to give user one fhandle by one call. This is also
> > bad from the performance point of view.
> > 2. When using ioctls we need to have *fixed* size of input and output.
> > So, if MAX_HANDLE_SZ will change in the future our _IOR('o', 2, struct ovl_mnt_opt_fh)
> > will also change with struct ovl_mnt_opt_fh.
> >
> 
> The choice of API with fixed output size for a variable length info seems weird.

Yes, and I've proposed option with ioctl syscall where we open file descriptor
instead of doing direct copy_from_user/copy_to_user.

> 
> I am tempted to suggest extending name_to_handle_at(), for example
> name_to_handle_at(ovl_root_fd, path, &fhandle, &layer_id, AT_LAYER)
> 
> Where layer_id can be input/output arg.
> 
> But I acknowledge this is going to be a much harder sell...

Looks interesting. I'll need to dive and think about it.

> 
> Thanks,
> Amir.

Thanks for your attention and review of patchset!

Regards,
Alex.
