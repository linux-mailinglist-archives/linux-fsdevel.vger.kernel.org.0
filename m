Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD84778C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 14:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfG0MhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jul 2019 08:37:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56986 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfG0MhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jul 2019 08:37:15 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hrLwf-00082Q-M3; Sat, 27 Jul 2019 12:37:05 +0000
Date:   Sat, 27 Jul 2019 13:37:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Regression in 5.3 for some FS_USERNS_MOUNT (aka
 user-namespace-mountable) filesystems
Message-ID: <20190727123705.GP1131@ZenIV.linux.org.uk>
References: <20190726115956.ifj5j4apn3tmwk64@brauner.io>
 <CAHk-=wgK254RkZg9oAv+Wt4V9zqYJMm3msTofvTUfA9dJw6piQ@mail.gmail.com>
 <20190726232220.GM1131@ZenIV.linux.org.uk>
 <878sskqp7p.fsf@xmission.com>
 <20190727022826.GO1131@ZenIV.linux.org.uk>
 <87h877pvv1.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h877pvv1.fsf@xmission.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 27, 2019 at 06:20:18AM -0500, Eric W. Biederman wrote:

> > In principle I like killing FS_USERNS_MOUNT flag, but when a method
> > is always either NULL or exact same function...
> 
> Either you are being dramatic or you read the patch much too quickly.

Or you've done the same to my reply.  I'm not saying that in the
posted form the instances are the same; I'm saying that they are
all equivalent to exact same code - ns_capable(fc->user_ns, CAP_SYS_ADMIN),
that is.

> userns_mount_permission covers the common case of FS_USERNS_MOUNT.
> Then there are the cases where you need to know how the filesystem is
> going to map current into the filesystem that will be mounted.  Those
> are: proc_mount_permission, sysfs_mount_permission,
> mqueue_mount_permission, cgroup_mount_permission,

+static int proc_mount_permission(void)
+{
+       struct pid_namespace *ns = task_active_pid_ns(current);
+       return ns_capable(ns->user_ns, CAP_SYS_ADMIN) ? 0 : -EPERM;
+}

compare with
        ctx->pid_ns = get_pid_ns(task_active_pid_ns(current));
        put_user_ns(fc->user_ns);
        fc->user_ns = get_user_ns(ctx->pid_ns->user_ns);
in proc_init_fs_context().  Notice anything?  With those 'orrible
API changes proc_mount_permissions() and userns_mount_permission()
can actually become identical.  Because the default case is
to leave fc->user_ns set to current_user_ns().

cgroup case:
+static int cgroup_mount_permission(void)
+{
+       struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
+       return ns_capable(ns->user_ns, CAP_SYS_ADMIN) ? 0 : -EPERM;
+}

with
        ctx->ns = current->nsproxy->cgroup_ns;
...
        put_user_ns(fc->user_ns);
        fc->user_ns = get_user_ns(ctx->ns->user_ns);
in cgroup_init_fs_context().  IOW, again your instances fold together.

mqueue:
        ctx->ipc_ns = get_ipc_ns(current->nsproxy->ipc_ns);
        put_user_ns(fc->user_ns);
        fc->user_ns = get_user_ns(ctx->ipc_ns->user_ns);
in mqueue_init_fs_context() and
+static int mqueue_mount_permission(void)
+{
+       struct ipc_namespace *ns = current->nsproxy->ipc_ns;
+       return ns_capable(ns->user_ns, CAP_SYS_ADMIN) ? 0 : -EPERM;
+}

Same situation.

+static int sysfs_mount_permission(void)
+{
+       struct net *net = current->nsproxy->net_ns;
+       return ns_capable(net->user_ns, CAP_SYS_ADMIN) ? 0 : -EPERM;
+}

with
        kfc->ns_tag = netns = kobj_ns_grab_current(KOBJ_NS_TYPE_NET);
...
        if (netns) {
                put_user_ns(fc->user_ns);
                fc->user_ns = get_user_ns(netns->user_ns);
        }
Now, _that_ is interesting.  Here the variants diverge - in case
USER_NS && !NET_NS fc->user_ns is left at current_user_ns().

That, BTW, is the only case where the old checks are left in:
        if (!(fc->sb_flags & SB_KERNMOUNT)) {
                if (!kobj_ns_current_may_mount(KOBJ_NS_TYPE_NET))
                        return -EPERM;
        }
in sysfs_init_fs_context() papers over that case and I'd love to
get rid of that irregularity.  Which, AFAICS, can be done by
unconditional
	put_user_ns(fc->user_ns);
	fc->user_ns = get_user_ns(current->nsproxy->net_ns->user_ns);
whatever the .config we have.  On NET_NS ones it'll be identical
to ->user_ns of what kobj_ns_grab_current(KOBJ_NS_TYPE_NET) returns,
on !NET_NS it'll get mount_capable() do the right thing without
that wart with init_fs_context() doing that extra check.

> So yes I agree the function of interest is always capable in some form,
> we just need the filesystem specific logic to check to see if we will
> have capable over the filesystem that will be mounted.
> 
> I don't doubt that the new mount api has added a few new complexities.

So far it looks like *in this particular case* complexities would be
reduced - with one exception all your ->permission() instances become
identical.

Moreover, even in that case we still get the right overall behaviour
with the same instance...

So do you have any specific objections to behaviour in vfs.git #fixes
and/or to adding

diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index db81cfbab9d6..c5b3c7d4d360 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -57,11 +57,6 @@ static int sysfs_init_fs_context(struct fs_context *fc)
 	struct kernfs_fs_context *kfc;
 	struct net *netns;
 
-	if (!(fc->sb_flags & SB_KERNMOUNT)) {
-		if (!kobj_ns_current_may_mount(KOBJ_NS_TYPE_NET))
-			return -EPERM;
-	}
-
 	kfc = kzalloc(sizeof(struct kernfs_fs_context), GFP_KERNEL);
 	if (!kfc)
 		return -ENOMEM;
@@ -71,10 +66,8 @@ static int sysfs_init_fs_context(struct fs_context *fc)
 	kfc->magic = SYSFS_MAGIC;
 	fc->fs_private = kfc;
 	fc->ops = &sysfs_fs_context_ops;
-	if (netns) {
-		put_user_ns(fc->user_ns);
-		fc->user_ns = get_user_ns(netns->user_ns);
-	}
+	put_user_ns(fc->user_ns);
+	fc->user_ns = get_user_ns(current->nsproxy->net_ns->user_ns);
 	fc->global = true;
 	return 0;
 }

on top of that?  The last one shouldn't change the behaviour, but it
certainly looks like a nice wartectomy; not #fixes material, though.
