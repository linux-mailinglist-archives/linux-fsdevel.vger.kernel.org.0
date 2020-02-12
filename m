Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 424E615AB5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 15:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgBLOvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 09:51:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59280 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgBLOvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:51:53 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j1tMk-0005B4-AO; Wed, 12 Feb 2020 14:51:50 +0000
Date:   Wed, 12 Feb 2020 15:51:49 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        smbarber@chromium.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 00/24] user_namespace: introduce fsid mappings
Message-ID: <20200212145149.zohmc6d3x52bw6j6@wittgenstein>
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
 <CAG48ez1GKOfXDZFD7-hGGjT8L9YEojn94DU5_=W8HL3pzdrCgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1GKOfXDZFD7-hGGjT8L9YEojn94DU5_=W8HL3pzdrCgg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 09:55:46PM +0100, Jann Horn via Containers wrote:
> On Tue, Feb 11, 2020 at 5:59 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > This is the implementation of shiftfs which was cooked up during lunch at
> > Linux Plumbers 2019 the day after the container's microconference. The
> > idea is a design-stew from Stéphane, Aleksa, Eric, and myself. Back then
> > we all were quite busy with other work and couldn't really sit down and
> > implement it. But I took a few days last week to do this work, including
> > demos and performance testing.
> > This implementation does not require us to touch the vfs substantially
> > at all. Instead, we implement shiftfs via fsid mappings.
> > With this patch, it took me 20 mins to port both LXD and LXC to support
> > shiftfs via fsid mappings.
> >
> > For anyone wanting to play with this the branch can be pulled from:
> > https://github.com/brauner/linux/tree/fsid_mappings
> > https://gitlab.com/brauner/linux/-/tree/fsid_mappings
> > https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=fsid_mappings
> >
> > The main use case for shiftfs for us is in allowing shared writable
> > storage to multiple containers using non-overlapping id mappings.
> > In such a scenario you want the fsids to be valid and identical in both
> > containers for the shared mount. A demo for this exists in [3].
> > If you don't want to read on, go straight to the other demos below in
> > [1] and [2].
> 
> I guess essentially this means that you want to have UID separation
> between containers to prevent the containers - or their owners - from
> interfering between each other, but for filesystem access, you don't
> want to isolate them from each other using DAC controls on the files
> and folders inside the containers' directory hierarchies, instead
> relying on mode-0700 parent directories to restrict access to the
> container owner? Or would you still have separate UIDs for e.g. the
> container's UID range 0-65535, and then map the shared UID range at
> 100000, or something like that?

Yes.
So if you look at the permissions right now for the directory under
which the rootfs for the container and other stuff resides we have
root@wittgenstein|/var/lib/lxd/storage-pools/zfs/containers
> perms *
d--x------ 100 alp1
d--x------ 100 f1
d--x------ 100 f2

We don't really share the rootfs between containers right now since we
treat them as standalone systems but with fsid mappings that's possible
too. Layer-sharing-centric runtimes very much will want something like
that.

> 
> > People not as familiar with user namespaces might not be aware that fsid
> > mappings already exist. Right now, fsid mappings are always identical to
> > id mappings. Specifically, the kernel will lookup fsuids in the uid
> > mappings and fsgids in the gid mappings of the relevant user namespace.
> 
> That's a bit like saying that a kernel without CONFIG_USER_NS still
> has user ID mappings, they just happen to be identity mappings. :P

If you have CONFIG_USER_NS=n then you have (as you're well aware)
[<0, 0>, <1,1>, ..., <n,n>] so yeah that's true and analyzing it like
that makes sense. :P

> 
> > With this patch series we simply introduce the ability to create fsid
> > mappings that are different from the id mappings of a user namespace.
> >
> > In the usual case of running an unprivileged container we will have
> > setup an id mapping, e.g. 0 100000 100000. The on-disk mapping will
> > correspond to this id mapping, i.e. all files which we want to appear as
> > 0:0 inside the user namespace will be chowned to 100000:100000 on the
> > host. This works, because whenever the kernel needs to do a filesystem
> > access it will lookup the corresponding uid and gid in the idmapping
> > tables of the container.
> > Now think about the case where we want to have an id mapping of 0 100000
> > 100000 but an on-disk mapping of 0 300000 100000 which is needed to e.g.
> > share a single on-disk mapping with multiple containers that all have
> > different id mappings.
> > This will be problematic. Whenever a filesystem access is requested, the
> > kernel will now try to lookup a mapping for 300000 in the id mapping
> > tables of the user namespace but since there is none the files will
> > appear to be owned by the overflow id, i.e. usually 65534:65534 or
> > nobody:nogroup.
> >
> > With fsid mappings we can solve this by writing an id mapping of 0
> > 100000 100000 and an fsid mapping of 0 300000 100000. On filesystem
> > access the kernel will now lookup the mapping for 300000 in the fsid
> > mapping tables of the user namespace. And since such a mapping exists,
> > the corresponding files will have correct ownership.
> 
> Sorry to bring up something as disgusting as setuid execution, but:

No that's exactly what this needs. :)

> What happens when there's a setuid root file with ->i_uid==300000? I
> guess the only way to make that work inside the containers would be
> something like make_kuid(current_user_ns(),
> from_kfsuid(current_user_ns(), inode->i_uid)) in the setuid execve
> path?

What's the specific callpath you're thinking about?

So if you look at patch
https://lore.kernel.org/lkml/20200211165753.356508-16-christian.brauner@ubuntu.com/
it does
-	new->suid = new->fsuid = new->euid;
-	new->sgid = new->fsgid = new->egid;
+	fsuid = from_kuid_munged(new->user_ns, new->euid);
+	kfsuid = make_kfsuid(new->user_ns, fsuid);
+	new->suid = new->euid;
+	new->fsuid = kfsuid;
+
+	fsgid = from_kgid_munged(new->user_ns, new->egid);
+	kfsgid = make_kfsgid(new->user_ns, fsgid);
+	new->sgid = new->egid;
+	new->fsgid = kfsgid;

One thing I definitely missed though in the setuid path is to adapt
fs/exec.c:bprm_fill_uid():

diff --git a/fs/exec.c b/fs/exec.c
index 74d88dab98dd..ad839934fdff 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1547,8 +1547,8 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
        inode_unlock(inode);

        /* We ignore suid/sgid if there are no mappings for them in the ns */
-       if (!kuid_has_mapping(bprm->cred->user_ns, uid) ||
-                !kgid_has_mapping(bprm->cred->user_ns, gid))
+       if (!kfsuid_has_mapping(bprm->cred->user_ns, uid) ||
+                !kfsgid_has_mapping(bprm->cred->user_ns, gid))
                return;

        if (mode & S_ISUID) {

> 
> > A note on proc (and sys), the proc filesystem is special in sofar as it
> > only has a single superblock that is (currently but might be about to
> > change) visible in all user namespaces (same goes for sys). This means
> > it has special semantics in many ways, including how file ownership and
> > access works. The fsid mapping implementation does not alter how proc
> > (and sys) ownership works. proc and sys will both continue to lookup
> > filesystem access in id mapping tables.
> 
> In your example, a process with namespaced UID set (0, 0, 0, 0) will
> have kernel UIDs (100000, 100000, 100000, 300000), right? And then if

Yes.

> I want to open /proc/$pid/personality of another process with the same
> UIDs, may_open() will call inode_permission() -> do_inode_permission()
> -> generic_permission() -> acl_permission_check(), which will compare
> current_fsuid() (which is 300000) against inode->i_uid. But
> inode->i_uid was filled by proc_pid_make_inode()->task_dump_owner(),
> which set inode->i_uid to 100000, right?

Yes. That should be fixable by something like below, I think. (And we can
probably shortcut this by adding a helper that does tell us whether there's
been any fsid mapping setup or not for this user namespace.)
 static int acl_permission_check(struct inode *inode, int mask)
 {
+       kuid_t kuid;
        unsigned int mode = inode->i_mode;

-       if (likely(uid_eq(current_fsuid(), inode->i_uid)))
+       if (!is_userns_visible(inode->i_sb->s_iflags)) {
+               kuid = inode->i_uid;
+       } else {
+               kuid = make_kuid(current_user_ns(),
+                                from_kfsuid(current_user_ns(), inode->i_uid));
+       }
+
+       if (likely(uid_eq(current_fsuid(), kuid)))
                mode >>= 6;
        else {&& (mode & S_IRWXG)) {

> 
> Also, e.g. __ptrace_may_access() uses cred->fsuid for a comparison
> with another task's real/effective/saved UID.

Right, you even introduced this check in 2015 iirc.
Both of your points make me think that it'd be easiest to introduce
cred->{kfsuid,kfsgid} and whenever an access decision on a
is_userns_visible() filesystem has to be made those will be used. This avoids
having to do on-the fly translations and ptrace_may_access() can just grow a
flag indicating what fscreds it's supposed to look at?

> 
> [...]
> > # Demos
> > [1]: Create a container with different id and fsid mappings.
> >      https://asciinema.org/a/300233
> > [2]: Create a container with id mappings but without fsid mappings.
> >      https://asciinema.org/a/300234
> > [3]: Share storage between multiple containers with non-overlapping id
> >      mappings.
> >      https://asciinema.org/a/300235
> 
> (I really dislike this asciinema thing; if you want to quickly glance
> through the output instead of reading at the same speed as it was
> typed, a simple pastebin works much better unless you absolutely have
> to show things that use stuff like ncurses UI.)

Hmkay, I went through the trouble of converting the asciinema output to
basic shell for all tree demos. :) I made them available as github gists.
So:
demo1: https://gist.github.com/brauner/8e1117720b3f9fab22e44c17f12184bf
demo2: https://gist.github.com/brauner/41a36026a9a1496af0095dce1545548e
demo3: https://gist.github.com/brauner/4586d6bc680a018bc8e1dd114a45592a
