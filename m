Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0636D39D9B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 12:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhFGKd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 06:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhFGKdz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:33:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3448361153;
        Mon,  7 Jun 2021 10:31:50 +0000 (UTC)
Date:   Mon, 7 Jun 2021 12:31:47 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, johan@kernel.org,
        ojeda@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        joe@perches.com, Menglong Dong <dong.menglong@zte.com.cn>,
        Jan Kara <jack@suse.cz>, hare@suse.de,
        Jens Axboe <axboe@kernel.dk>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Barret Rhoden <brho@google.com>, f.fainelli@gmail.com,
        palmerdabbelt@google.com, wangkefeng.wang@huawei.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        Alexander Potapenko <glider@google.com>, pmladek@suse.com,
        johannes.berg@intel.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, jojing64@gmail.com,
        terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, arnd@arndb.de,
        Chris Down <chris@chrisdown.name>, mingo@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v6 2/2] init/do_mounts.c: create second mount for
 initramfs
Message-ID: <20210607103147.yhniqeulw4pmvjdr@wittgenstein>
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
 <20210605034447.92917-3-dong.menglong@zte.com.cn>
 <20210605115019.umjumoasiwrclcks@wittgenstein>
 <CADxym3bs1r_+aPk9Z_5Y7QBBV_RzUbW9PUqSLB7akbss_dJi_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADxym3bs1r_+aPk9Z_5Y7QBBV_RzUbW9PUqSLB7akbss_dJi_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 05, 2021 at 10:47:07PM +0800, Menglong Dong wrote:
> Hello,
> 
> On Sat, Jun 5, 2021 at 7:50 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Sat, Jun 05, 2021 at 11:44:47AM +0800, menglong8.dong@gmail.com wrote:
> > > From: Menglong Dong <dong.menglong@zte.com.cn>
> > >
> > > If using container platforms such as Docker, upon initialization it
> > > wants to use pivot_root() so that currently mounted devices do not
> > > propagate to containers. An example of value in this is that
> > > a USB device connected prior to the creation of a containers on the
> > > host gets disconnected after a container is created; if the
> > > USB device was mounted on containers, but already removed and
> > > umounted on the host, the mount point will not go away until all
> > > containers unmount the USB device.
> > >
> > > Another reason for container platforms such as Docker to use pivot_root
> > > is that upon initialization the net-namspace is mounted under
> > > /var/run/docker/netns/ on the host by dockerd. Without pivot_root
> > > Docker must either wait to create the network namespace prior to
> > > the creation of containers or simply deal with leaking this to each
> > > container.
> > >
> > > pivot_root is supported if the rootfs is a initrd or block device, but
> > > it's not supported if the rootfs uses an initramfs (tmpfs). This means
> > > container platforms today must resort to using block devices if
> > > they want to pivot_root from the rootfs. A workaround to use chroot()
> > > is not a clean viable option given every container will have a
> > > duplicate of every mount point on the host.
> > >
> > > In order to support using container platforms such as Docker on
> > > all the supported rootfs types we must extend Linux to support
> > > pivot_root on initramfs as well. This patch does the work to do
> > > just that.
> > >
> > > pivot_root will unmount the mount of the rootfs from its parent mount
> > > and mount the new root to it. However, when it comes to initramfs, it
> > > donesn't work, because the root filesystem has not parent mount, which
> > > makes initramfs not supported by pivot_root.
> > >
> > > In order to make pivot_root supported on initramfs, we create a second
> > > mount with type of rootfs before unpacking cpio, and change root to
> > > this mount after unpacking.
> > >
> > > While mounting the second rootfs, 'rootflags' is passed, and it means
> > > that we can set options for the mount of rootfs in boot cmd now.
> > > For example, the size of tmpfs can be set with 'rootflags=size=1024M'.
> > >
> > > Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> > > ---
> > >  init/do_mounts.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> > >  init/do_mounts.h | 17 ++++++++++++++++-
> > >  init/initramfs.c |  8 ++++++++
> > >  usr/Kconfig      | 10 ++++++++++
> > >  4 files changed, 78 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/init/do_mounts.c b/init/do_mounts.c
> > > index a78e44ee6adb..715bdaa89b81 100644
> > > --- a/init/do_mounts.c
> > > +++ b/init/do_mounts.c
> > > @@ -618,6 +618,49 @@ void __init prepare_namespace(void)
> > >  }
> > >
> > >  static bool is_tmpfs;
> > > +#ifdef CONFIG_INITRAMFS_MOUNT
> > > +
> > > +/*
> > > + * Give systems running from the initramfs and making use of pivot_root a
> > > + * proper mount so it can be umounted during pivot_root.
> > > + */
> > > +int __init prepare_mount_rootfs(void)
> > > +{
> > > +     char *rootfs = "ramfs";
> > > +
> > > +     if (is_tmpfs)
> > > +             rootfs = "tmpfs";
> > > +
> > > +     return do_mount_root(rootfs, rootfs,
> > > +                          root_mountflags & ~MS_RDONLY,
> > > +                          root_mount_data);
> > > +}
> > > +
> > > +/*
> > > + * Revert to previous mount by chdir to '/' and unmounting the second
> > > + * mount.
> > > + */
> > > +void __init revert_mount_rootfs(void)
> > > +{
> > > +     init_chdir("/");
> > > +     init_umount(".", MNT_DETACH);
> > > +}
> > > +
> > > +/*
> > > + * Change root to the new rootfs that mounted in prepare_mount_rootfs()
> > > + * if cpio is unpacked successfully and 'ramdisk_execute_command' exist.
> > > + */
> > > +void __init finish_mount_rootfs(void)
> > > +{
> > > +     init_mount(".", "/", NULL, MS_MOVE, NULL);
> > > +     if (likely(ramdisk_exec_exist()))
> > > +             init_chroot(".");
> > > +     else
> > > +             revert_mount_rootfs();
> > > +}
> > > +
> > > +#define rootfs_init_fs_context ramfs_init_fs_context
> >
> > Sorry, I think we're nearly there. What's the rationale for using ramfs
> > when unconditionally when a separate mount for initramfs is requested?
> > Meaning, why do we need this define at all?
> 
> I think it's necessary, as I explained in the third patch. When the rootfs
> is a block device, ramfs is used in init_mount_tree() unconditionally,
> which can be seen from the enable of is_tmpfs.
> 
> That makes sense, because rootfs will not become the root if a block
> device is specified by 'root' in boot cmd, so it makes no sense to use
> tmpfs, because ramfs is more simple.
> 
> Here, I make rootfs as ramfs for the same reason: the first mount is not
> used as the root, so make it ramfs which is more simple.

Ok. If you don't mind I'd like to pull and test this before moving
further. (Btw, I talked about this at Plumbers before btw.)
What did you use for testing this? Any way you can share it?
