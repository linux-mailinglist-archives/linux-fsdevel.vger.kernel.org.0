Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C647532D079
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 11:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbhCDKNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 05:13:19 -0500
Received: from relay.sw.ru ([185.231.240.75]:39020 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238194AbhCDKMy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:Mime-Version:Message-Id:Subject:From
        :Date; bh=fO68/0Zp4a2Wcd3siPndThrbByFFZXXQ7aAdpaXX/PU=; b=IhqxV3524nHmw7p6Zg1
        N4NjVbWpeXWe+tw/7aQkRr2uf5UeK8D8Y7JO8qvOztyjW0Po+7vRuWVTL8DBxj9bObfYGMV3gVV8K
        7tu3Q9Kx3AGWC1SL66gAANm1RtACHzgKZA0mbEtwv8WxMUmcLTqFnQcCxq8ItJ58O2kQpQHTXhA=
Received: from [192.168.15.37] (helo=alexm-laptop.lan)
        by relay.sw.ru with smtp (Exim 4.94)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1lHkxB-002h3A-J4; Thu, 04 Mar 2021 13:11:33 +0300
Date:   Thu, 4 Mar 2021 13:11:33 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     Ian Kent <raven@themaw.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
Message-Id: <20210304131133.0ad93dee12a17f41f4052bcb@virtuozzo.com>
In-Reply-To: <832c1a384dc0b71b2902accf3091ea84381acc10.camel@themaw.net>
References: <20210303152931.771996-1-alexander.mikhalitsyn@virtuozzo.com>
        <832c1a384dc0b71b2902accf3091ea84381acc10.camel@themaw.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 04 Mar 2021 14:54:11 +0800
Ian Kent <raven@themaw.net> wrote:

> On Wed, 2021-03-03 at 18:28 +0300, Alexander Mikhalitsyn wrote:
> > It was discovered that find_autofs_mount() function
> > in autofs not support cases when autofs mount
> > parent is overmounted. In this case this function will
> > always return -ENOENT.
> 
> Ok, I get this shouldn't happen.
> 
> > 
> > Real-life reproducer is fairly simple.
> > Consider the following mounts on root mntns:
> > --
> > 35 24 0:36 / /proc/sys/fs/binfmt_misc ... shared:16 - autofs systemd-
> > 1 ...
> > 654 35 0:57 / /proc/sys/fs/binfmt_misc ... shared:322 - binfmt_misc
> > ...
> > --
> > and some process which calls ioctl(AUTOFS_DEV_IOCTL_OPENMOUNT)
> > $ unshare -m -p --fork --mount-proc ./process-bin
> > 
> > Due to "mount-proc" /proc will be overmounted and
> > ioctl() will fail with -ENOENT
> 
> I think I need a better explanation ...

Thank you for the quick reply, Ian.
I'm sorry If my patch description was not sufficiently clear and detailed.

That problem connected with CRIU (Checkpoint-Restore in Userspace) project.
In CRIU we have support of autofs mounts C/R. To acheive that we need to use
ioctl's from /dev/autofs to get data about mounts, restore mount as catatonic
(if needed), change pipe fd and so on. But the problem is that during CRIU
dump we may meet situation when VFS subtree where autofs mount present was
overmounted as whole.

Simpliest example is /proc/sys/fs/binfmt_misc. This mount present on most
GNU/Linux distributions by default. For instance on my Fedora 33:

trigger automount of binfmt_misc
$ ls /proc/sys/fs/binfmt_misc

$ cat /proc/1/mountinfo | grep binfmt
35 24 0:36 / /proc/sys/fs/binfmt_misc rw,relatime shared:16 - autofs systemd-1 rw,...,direct,pipe_ino=223
632 35 0:56 / /proc/sys/fs/binfmt_misc rw,...,relatime shared:315 - binfmt_misc binfmt_misc rw

$ sudo unshare -m -p --fork --mount-proc sh
# cat /proc/self/mountinfo | grep "/proc"
828 809 0:23 / /proc rw,nosuid,nodev,noexec,relatime - proc proc rw
829 828 0:36 / /proc/sys/fs/binfmt_misc rw,relatime - autofs systemd-1 rw,...,direct,pipe_ino=223
943 829 0:56 / /proc/sys/fs/binfmt_misc rw,...,relatime - binfmt_misc binfmt_misc rw
949 828 0:57 / /proc rw...,relatime - proc proc rw

As we can see now autofs mount /proc/sys/fs/binfmt_misc is inaccessible.
If we do something like:

struct autofs_dev_ioctl *param;
param = malloc(...);
devfd = open("/dev/autofs", O_RDONLY);
init_autofs_dev_ioctl(param);
param->size = size;
strcpy(param->path, "/proc/sys/fs/binfmt_misc");
param->openmount.devid = 36;
err = ioctl(devfd, AUTOFS_DEV_IOCTL_OPENMOUNT, param)

now we get err = -ENOENT.

> 
> What's being said here?
> 
> For a start your talking about direct mounts, I'm pretty sure this
> use case can't occur with indirect mounts in the sense that the
> indirect mount base should/must never be over mounted and IIRC that
> base can't be /proc (but maybe that's just mounts inside proc ...),
> can't remember now but from a common sense POV an indirect mount
> won't/can't be on /proc.
> 
> And why is this ioctl be called?

We call this ioctl during criu dump stage to open fd from autofs
mount dentry. This fd is used later to call ioctl(AUTOFS_IOC_CATATONIC)
(we do that on criu dump if we see that control process of autofs mount
is dead or pipe is dead).

> 
> If the mount is over mounted should that prevent expiration of the
> over mounted /proc anyway, so maybe the return is correct ... or
> not ...

I agree that case with overmounted subtree with autofs mount is weird case.
But it may be easily created by user and we in CRIU try to handle that.

> 
> I get that the mount namespaces should be independent and intuitively
> this is a bug but what is the actual use and expected result.
> 
> But anyway, aren't you saying that the VFS path walk isn't handling
> mount namespaces properly or are you saying that a process outside
> this new mount namespace becomes broken because of it?

No-no, it's only about opening autofs mount by device id + path.

> 
> Either way the solution looks more complicated than I'd expect so
> some explanation along these lines would be good.
> 
> Ian

Regards,
Alex

> > 
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> > Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> > Cc: autofs@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Alexander Mikhalitsyn <
> > alexander.mikhalitsyn@virtuozzo.com>
> > ---
> >  fs/autofs/dev-ioctl.c | 127 +++++++++++++++++++++++++++++++++++++---
> > --
> >  fs/namespace.c        |  44 +++++++++++++++
> >  include/linux/mount.h |   5 ++
> >  3 files changed, 162 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
> > index 5bf781ea6d67..55edd3eba8ce 100644
> > --- a/fs/autofs/dev-ioctl.c
> > +++ b/fs/autofs/dev-ioctl.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/fdtable.h>
> >  #include <linux/magic.h>
> >  #include <linux/nospec.h>
> > +#include <linux/nsproxy.h>
> >  
> >  #include "autofs_i.h"
> >  
> > @@ -179,32 +180,130 @@ static int autofs_dev_ioctl_protosubver(struct
> > file *fp,
> >  	return 0;
> >  }
> >  
> > +struct filter_autofs_data {
> > +	char *pathbuf;
> > +	const char *fpathname;
> > +	int (*test)(const struct path *path, void *data);
> > +	void *data;
> > +};
> > +
> > +static int filter_autofs(const struct path *path, void *p)
> > +{
> > +	struct filter_autofs_data *data = p;
> > +	char *name;
> > +	int err;
> > +
> > +	if (path->mnt->mnt_sb->s_magic != AUTOFS_SUPER_MAGIC)
> > +		return 0;
> > +
> > +	name = d_path(path, data->pathbuf, PATH_MAX);
> > +	if (IS_ERR(name)) {
> > +		err = PTR_ERR(name);
> > +		pr_err("d_path failed, errno %d\n", err);
> > +		return 0;
> > +	}
> > +
> > +	if (strncmp(data->fpathname, name, PATH_MAX))
> > +		return 0;
> > +
> > +	if (!data->test(path, data->data))
> > +		return 0;
> > +
> > +	return 1;
> > +}
> > +
> >  /* Find the topmost mount satisfying test() */
> >  static int find_autofs_mount(const char *pathname,
> >  			     struct path *res,
> >  			     int test(const struct path *path, void
> > *data),
> >  			     void *data)
> >  {
> > -	struct path path;
> > +	struct filter_autofs_data mdata = {
> > +		.pathbuf = NULL,
> > +		.test = test,
> > +		.data = data,
> > +	};
> > +	struct mnt_namespace *mnt_ns = current->nsproxy->mnt_ns;
> > +	struct path path = {};
> > +	char *fpathbuf = NULL;
> >  	int err;
> >  
> > +	/*
> > +	 * In most cases user will provide full path to autofs mount
> > point
> > +	 * as it is in /proc/X/mountinfo. But if not, then we need to
> > +	 * open provided relative path and calculate full path.
> > +	 * It will not work in case when parent mount of autofs mount
> > +	 * is overmounted:
> > +	 * cd /root
> > +	 * ./autofs_mount /root/autofs_yard/mnt
> > +	 * mount -t tmpfs tmpfs /root/autofs_yard/mnt
> > +	 * mount -t tmpfs tmpfs /root/autofs_yard
> > +	 * ./call_ioctl /root/autofs_yard/mnt <- all fine here because
> > we
> > +	 * 					 have full path and
> > don't
> > +	 * 					 need to call
> > kern_path()
> > +	 * 					 and d_path()
> > +	 * ./call_ioctl autofs_yard/mnt <- will fail because
> > kern_path()
> > +	 * 				   can't lookup
> > /root/autofs_yard/mnt
> > +	 * 				   (/root/autofs_yard
> > directory is
> > +	 * 				    empty)
> > +	 *
> > +	 * TO DISCUSS: we can write special algorithm for relative path
> > case
> > +	 * by getting cwd path combining it with relative path from
> > user. But
> > +	 * is it worth it? User also may use paths with symlinks in
> > components
> > +	 * of path.
> > +	 *
> > +	 */
> >  	err = kern_path(pathname, LOOKUP_MOUNTPOINT, &path);
> > -	if (err)
> > -		return err;
> > -	err = -ENOENT;
> > -	while (path.dentry == path.mnt->mnt_root) {
> > -		if (path.dentry->d_sb->s_magic == AUTOFS_SUPER_MAGIC) {
> > -			if (test(&path, data)) {
> > -				path_get(&path);
> > -				*res = path;
> > -				err = 0;
> > -				break;
> > -			}
> > +	if (err) {
> > +		if (pathname[0] == '/') {
> > +			/*
> > +			 * pathname looks like full path let's try to
> > use it
> > +			 * as it is when searching autofs mount
> > +			 */
> > +			mdata.fpathname = pathname;
> > +			err = 0;
> > +			pr_debug("kern_path failed on %s, errno %d.
> > Will use path as it is to search mount\n",
> > +				 pathname, err);
> > +		} else {
> > +			pr_err("kern_path failed on %s, errno %d\n",
> > +			       pathname, err);
> > +			return err;
> > +		}
> > +	} else {
> > +		pr_debug("find_autofs_mount: let's resolve full path
> > %s\n",
> > +			 pathname);
> > +
> > +		fpathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> > +		if (!fpathbuf) {
> > +			err = -ENOMEM;
> > +			goto err;
> > +		}
> > +
> > +		/*
> > +		 * We have pathname from user but it may be relative,
> > we need to
> > +		 * have full path because we want to compare it with
> > mountpoints
> > +		 * paths later.
> > +		 */
> > +		mdata.fpathname = d_path(&path, fpathbuf, PATH_MAX);
> > +		if (IS_ERR(mdata.fpathname)) {
> > +			err = PTR_ERR(mdata.fpathname);
> > +			pr_err("d_path failed, errno %d\n", err);
> > +			goto err;
> >  		}
> > -		if (!follow_up(&path))
> > -			break;
> >  	}
> > +
> > +	mdata.pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> > +	if (!mdata.pathbuf) {
> > +		err = -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	err = lookup_mount_path(mnt_ns, res, filter_autofs, &mdata);
> > +
> > +err:
> >  	path_put(&path);
> > +	kfree(fpathbuf);
> > +	kfree(mdata.pathbuf);
> >  	return err;
> >  }
> >  
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 56bb5a5fdc0d..e1d006dbdfe2 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -1367,6 +1367,50 @@ void mnt_cursor_del(struct mnt_namespace *ns,
> > struct mount *cursor)
> >  }
> >  #endif  /* CONFIG_PROC_FS */
> >  
> > +/**
> > + * lookup_mount_path - traverse all mounts in mount namespace
> > + *                     and filter using test() probe callback
> > + * As a result struct path will be provided.
> > + * @ns: root of mount tree
> > + * @res: struct path pointer where resulting path will be written
> > + * @test: filter callback
> > + * @data: will be provided as argument to test() callback
> > + *
> > + */
> > +int lookup_mount_path(struct mnt_namespace *ns,
> > +		      struct path *res,
> > +		      int test(const struct path *mnt, void *data),
> > +		      void *data)
> > +{
> > +	struct mount *mnt;
> > +	int err = -ENOENT;
> > +
> > +	down_read(&namespace_sem);
> > +	lock_ns_list(ns);
> > +	list_for_each_entry(mnt, &ns->list, mnt_list) {
> > +		struct path tmppath;
> > +
> > +		if (mnt_is_cursor(mnt))
> > +			continue;
> > +
> > +		tmppath.dentry = mnt->mnt.mnt_root;
> > +		tmppath.mnt = &mnt->mnt;
> > +
> > +		if (test(&tmppath, data)) {
> > +			path_get(&tmppath);
> > +			*res = tmppath;
> > +			err = 0;
> > +			break;
> > +		}
> > +	}
> > +	unlock_ns_list(ns);
> > +	up_read(&namespace_sem);
> > +
> > +	return err;
> > +}
> > +
> > +EXPORT_SYMBOL(lookup_mount_path);
> > +
> >  /**
> >   * may_umount_tree - check if a mount tree is busy
> >   * @mnt: root of mount tree
> > diff --git a/include/linux/mount.h b/include/linux/mount.h
> > index 5d92a7e1a742..a79e6392e38e 100644
> > --- a/include/linux/mount.h
> > +++ b/include/linux/mount.h
> > @@ -118,6 +118,11 @@ extern unsigned int sysctl_mount_max;
> >  
> >  extern bool path_is_mountpoint(const struct path *path);
> >  
> > +extern int lookup_mount_path(struct mnt_namespace *ns,
> > +			     struct path *res,
> > +			     int test(const struct path *mnt, void
> > *data),
> > +			     void *data);
> > +
> >  extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int
> > num);
> >  
> >  #endif /* _LINUX_MOUNT_H */
> 
