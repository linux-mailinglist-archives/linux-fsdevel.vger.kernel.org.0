Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41D6332416
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 12:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhCILbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 06:31:36 -0500
Received: from relay.sw.ru ([185.231.240.75]:53178 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229851AbhCILbb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:Mime-Version:Message-Id:Subject:From
        :Date; bh=BXd1hSVtrD4/uekhnZIaLPAgkTFGGDFt9xqe7bOG5Vo=; b=V8fTybDI1Mx9MdXzCKc
        g6Benb3WzgoGp6+ckV18V3u/JLaNnqegGZBHusRpXhzqgweA7uagbKKzKAMFI5RpwgVJkw93I8QMj
        gyJnXTDcm7i1yiF7yvPnqMnGO96vNhMQnI7PDTi7g0zMByj5q2BwEd+nDz4eq6SSXmnEJ37y6mY=
Received: from [192.168.15.228] (helo=alexm-laptop.lan)
        by relay.sw.ru with smtp (Exim 4.94)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1lJaZk-002rPk-4d; Tue, 09 Mar 2021 14:30:56 +0300
Date:   Tue, 9 Mar 2021 14:31:05 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, Matthew Wilcox <willy@infradead.org>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, autofs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ross Zwisler <zwisler@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biggers <ebiggers@google.com>,
        Mattias Nissler <mnissler@chromium.org>,
        linux-fsdevel@vger.kernel.org, alexander@mihalicyn.com
Subject: Re: [RFC PATCH] autofs: find_autofs_mount overmounted parent
 support
Message-Id: <20210309143105.6ec608dca7764bc58707b213@virtuozzo.com>
In-Reply-To: <YEVvnvFNpfld7MXM@zeniv-ca.linux.org.uk>
References: <20210303152931.771996-1-alexander.mikhalitsyn@virtuozzo.com>
        <832c1a384dc0b71b2902accf3091ea84381acc10.camel@themaw.net>
        <20210304131133.0ad93dee12a17f41f4052bcb@virtuozzo.com>
        <YEVm+KH/R5y2rU7K@zeniv-ca.linux.org.uk>
        <YEVr5jNlpu2jcdzs@zeniv-ca.linux.org.uk>
        <YEVvnvFNpfld7MXM@zeniv-ca.linux.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 8 Mar 2021 00:12:22 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Sun, Mar 07, 2021 at 11:51:20PM +0000, Al Viro wrote:
> > On Thu, Mar 04, 2021 at 01:11:33PM +0300, Alexander Mikhalitsyn wrote:
> > 
> > > That problem connected with CRIU (Checkpoint-Restore in Userspace) project.
> > > In CRIU we have support of autofs mounts C/R. To acheive that we need to use
> > > ioctl's from /dev/autofs to get data about mounts, restore mount as catatonic
> > > (if needed), change pipe fd and so on. But the problem is that during CRIU
> > > dump we may meet situation when VFS subtree where autofs mount present was
> > > overmounted as whole.
> > > 
> > > Simpliest example is /proc/sys/fs/binfmt_misc. This mount present on most
> > > GNU/Linux distributions by default. For instance on my Fedora 33:
> > > 
> > > trigger automount of binfmt_misc
> > > $ ls /proc/sys/fs/binfmt_misc
> > > 
> > > $ cat /proc/1/mountinfo | grep binfmt
> > > 35 24 0:36 / /proc/sys/fs/binfmt_misc rw,relatime shared:16 - autofs systemd-1 rw,...,direct,pipe_ino=223
> > > 632 35 0:56 / /proc/sys/fs/binfmt_misc rw,...,relatime shared:315 - binfmt_misc binfmt_misc rw
> > > 
> > > $ sudo unshare -m -p --fork --mount-proc sh
> > > # cat /proc/self/mountinfo | grep "/proc"
> > > 828 809 0:23 / /proc rw,nosuid,nodev,noexec,relatime - proc proc rw
> > > 829 828 0:36 / /proc/sys/fs/binfmt_misc rw,relatime - autofs systemd-1 rw,...,direct,pipe_ino=223
> > > 943 829 0:56 / /proc/sys/fs/binfmt_misc rw,...,relatime - binfmt_misc binfmt_misc rw
> > > 949 828 0:57 / /proc rw...,relatime - proc proc rw
> > > 
> > > As we can see now autofs mount /proc/sys/fs/binfmt_misc is inaccessible.
> > > If we do something like:
> > > 
> > > struct autofs_dev_ioctl *param;
> > > param = malloc(...);
> > > devfd = open("/dev/autofs", O_RDONLY);
> > > init_autofs_dev_ioctl(param);
> > > param->size = size;
> > > strcpy(param->path, "/proc/sys/fs/binfmt_misc");
> > > param->openmount.devid = 36;
> > > err = ioctl(devfd, AUTOFS_DEV_IOCTL_OPENMOUNT, param)
> > > 
> > > now we get err = -ENOENT.
> > 
> Where does that -ENOENT come from?  AFAICS, pathwalk ought to succeed and
> return you the root of overmounting binfmt_misc.  Why doesn't the loop in
> find_autofs_mount() locate anything it would accept?
> 

Consider our mounts tree:
> > > # cat /proc/self/mountinfo | grep "/proc"
> > > 828 809 0:23 / /proc rw,nosuid,nodev,noexec,relatime - proc proc rw
> > > 829 828 0:36 / /proc/sys/fs/binfmt_misc rw,relatime - autofs systemd-1 rw,...,direct,pipe_ino=223
> > > 943 829 0:56 / /proc/sys/fs/binfmt_misc rw,...,relatime - binfmt_misc binfmt_misc rw
> > > 949 828 0:57 / /proc rw...,relatime - proc proc rw

ENOENT comes from here (current kernel code):
/* Find the topmost mount satisfying test() */
static int find_autofs_mount(const char *pathname,
			     struct path *res,
			     int test(const struct path *path, void *data),
			     void *data)
{
	struct path path;
	int err;

	err = kern_path(pathname, LOOKUP_MOUNTPOINT, &path);
	if (err)
		return err;
<-------- here we successfuly open root dentry (/proc/sys/fs/binfmt_misc) of /proc (mnt_id = 949)

	err = -ENOENT;
<---- set err and start search autofs mount
/*
 here we use follow_up to move through upper dentries and find overmounted autofs.
 But in our case we opened dentry from /proc (mnt_id = 949) and this concrete dentry is *NOT*
overmounted (whole /proc overmounted).
*/
	while (path.dentry == path.mnt->mnt_root) {
		if (path.dentry->d_sb->s_magic == AUTOFS_SUPER_MAGIC) {
			if (test(&path, data)) {
/*
 we never get there
*/
				path_get(&path);
				*res = path;
				err = 0;
				break;
			}
		}
		if (!follow_up(&path))
			break;
	}
/*
loop finished. err stays as it was err = -ENOENT
*/
	path_put(&path);
	return err;
}

Source: https://github.com/torvalds/linux/blob/master/fs/autofs/dev-ioctl.c#L194

> I really dislike the patch - the whole "normalize path" thing is fundamentally
> bogus, not to mention the iterator over all mounts, etc., so I would like to
> understand what the hell is going on before even thinking of *not* NAKing
> it on sight.

I'm not trying to break current API or something similar. I'm just prepared
RFC patch with my proposal. I'm ready to rework all of that to make it good.
But without maintainers/community comments/suggestions it's unreal :)

Please, explain what do you mean by "normalize path thing"?
I'm not changing semantics of current ioctl() I've just trying to extend it to make
it work in case when parent mount of autofs mount is overmounted.

> 
> 	Wait, so you have /proc overmounted, without anything autofs-related on
> /proc/sys/fs/binfmt_misc and still want to have the pathname resolved, just
> because it would've resolved with that overmount of /proc removed?

Something like that.

1. I don't expect that /proc/sys/fs/binfmt_misc path will be resolved
(because, for instance we can overmount /proc by empty tmpfs and in this case after
overmounting we can't even open /proc/sys/fs/binfmt_misc and that's okay).

2. We talking about autofs specific function which is used in several autofs-specific
ioctls. One of that ioctl(AUTOFS_DEV_IOCTL_OPENMOUNT) which is designed to open
overmounted autofs mounts. Because it's frequent case when autofs mount is overmounted
(when we talk about direct mounts). This ioctl allows to open file desciptor
of autofs root dentry and later, autofs daemon use it to manage mount (call another autofs
ioctls on that fd).

I've just meet problem, that this API not works when parent mount of autofs mount is overmounted.
For example:
tmpfs     /some-dir
autofs    /some-dir/autofs1 <-autofs direct mount
nfs       /some-dir/autofs1 <-automounted fs on top of autofs

ioctl(AUTOFS_DEV_IOCTL_OPENMOUNT) will work in this case. Because loop
with follow_up() starts from /some-dir/autofs1 dentry of nfs, then follow_up()
and move to /some-dir/autofs1 dentry of autofs.

But if we change picture to:
tmpfs1     /some-dir
autofs     /some-dir/autofs1 <-autofs direct mount
nfs        /some-dir/autofs1 <-automounted fs on top of autofs
tmpfs2     /some-dir

This will breaks API. Because know we can't even open /some-dir/autofs1
dentry.

Ok. We can create this dentry at first by mkdir /some-dir/autofs1.
But it will not help because our loop:
	while (path.dentry == path.mnt->mnt_root) {
		if (path.dentry->d_sb->s_magic == AUTOFS_SUPER_MAGIC) {
			if (test(&path, data)) {
...
		if (!follow_up(&path))
			break;
	}
will start from dentry /some-dir/autofs1 from tmpfs2. And after follow_up
on that dentry we will move to / dentry => loop finishes => user get ENOENT.

> 
> 	I hope I'm misreading you; in case I'm not, the ABI is extremely
> tasteless and until you manage to document the exact semantics you want
> for param->path, consider it NAKed.
> 
> 	BTW, if that thing would be made to work, what's to stop somebody from
> doing ...at() syscalls with the resulting fd as a starting point and pathnames
> starting with ".."?  "/foo is overmounted, but we can get to anything under
> /foo/bar/ in the underlying tree since there's an autofs mount somewhere in
> /foo/bar/splat/puke/*"?

Interesting point. Thank you!
I'm not sure. But is it serious problem for us? What stop somebody to open
and hold fd to any directory before overmounting?

> 
> 	IOW, the real question (aside of "WTF?") is what are you using the
> resulting descriptor for and what do you need to be able to do with it.
> Details, please.

Sure. I've covered use cases of file descriptor returned by ioctl(AUTOFS_DEV_IOCTL_OPENMOUNT)
above.

Thanks for your reply!
I'm sorry If my patch description is unclear. I'm newbie here :)

Regards,
Alex
