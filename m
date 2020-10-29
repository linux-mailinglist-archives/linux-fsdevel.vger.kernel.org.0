Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D7429F129
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 17:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgJ2QTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 12:19:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35345 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2QTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:19:32 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kYAe2-00056E-O9; Thu, 29 Oct 2020 16:19:22 +0000
Date:   Thu, 29 Oct 2020 17:19:20 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH 00/34] fs: idmapped mounts
Message-ID: <20201029161920.zp7p3335x3q2a36e@wittgenstein>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <20201029022733.GB306023@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029022733.GB306023@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 01:27:33PM +1100, Dave Chinner wrote:
> On Thu, Oct 29, 2020 at 01:32:18AM +0100, Christian Brauner wrote:
> > Hey everyone,
> > 
> > I vanished for a little while to focus on this work here so sorry for
> > not being available by mail for a while.
> > 
> > Since quite a long time we have issues with sharing mounts between
> > multiple unprivileged containers with different id mappings, sharing a
> > rootfs between multiple containers with different id mappings, and also
> > sharing regular directories and filesystems between users with different
> > uids and gids. The latter use-cases have become even more important with
> > the availability and adoption of systemd-homed (cf. [1]) to implement
> > portable home directories.
> > 
> > The solutions we have tried and proposed so far include the introduction
> > of fsid mappings, a tiny overlay based filesystem, and an approach to
> > call override creds in the vfs. None of these solutions have covered all
> > of the above use-cases.
> > 
> > The solution proposed here has it's origins in multiple discussions
> > during Linux Plumbers 2017 during and after the end of the containers
> > microconference.
> > To the best of my knowledge this involved Aleksa, Stéphane, Eric, David,
> > James, and myself. A variant of the solution proposed here has also been
> > discussed, again to the best of my knowledge, after a Linux conference
> > in St. Petersburg in Russia between Christoph, Tycho, and myself in 2017
> > after Linux Plumbers.
> > I've taken the time to finally implement a working version of this
> > solution over the last weeks to the best of my abilities. Tycho has
> > signed up for this sligthly crazy endeavour as well and he has helped
> > with the conversion of the xattr codepaths.
> > 
> > The core idea is to make idmappings a property of struct vfsmount
> > instead of tying it to a process being inside of a user namespace which
> > has been the case for all other proposed approaches.
> > It means that idmappings become a property of bind-mounts, i.e. each
> > bind-mount can have a separate idmapping. This has the obvious advantage
> > that idmapped mounts can be created inside of the initial user
> > namespace, i.e. on the host itself instead of requiring the caller to be
> > located inside of a user namespace. This enables such use-cases as e.g.
> > making a usb stick available in multiple locations with different
> > idmappings (see the vfat port that is part of this patch series).
> > 
> > The vfsmount struct gains a new struct user_namespace member. The
> > idmapping of the user namespace becomes the idmapping of the mount. A
> > caller that is either privileged with respect to the user namespace of
> > the superblock of the underlying filesystem or a caller that is
> > privileged with respect to the user namespace a mount has been idmapped
> > with can create a new bind-mount and mark it with a user namespace. The
> > user namespace the mount will be marked with can be specified by passing
> > a file descriptor refering to the user namespace as an argument to the
> > new mount_setattr() syscall together with the new MOUNT_ATTR_IDMAP flag.
> > By default vfsmounts are marked with the initial user namespace and no
> > behavioral or performance changes should be observed. All mapping
> > operations are nops for the initial user namespace.
> > 
> > When a file/inode is accessed through an idmapped mount the i_uid and
> > i_gid of the inode will be remapped according to the user namespace the
> > mount has been marked with. When a new object is created based on the
> > fsuid and fsgid of the caller they will similarly be remapped according
> > to the user namespace of the mount they care created from.
> > 
> > This means the user namespace of the mount needs to be passed down into
> > a few relevant inode_operations. This mostly includes inode operations
> > that create filesystem objects or change file attributes.
> 
> That's really quite ... messy.

I don't agree. It's changes all across the vfs but it's not hacky in any
way since it cleanly passes down an additional argument (I'm biased of
course.). 

> 
> Maybe I'm missing something, but if you have the user_ns to be used
> for the VFS operation we are about to execute then why can't we use
> the same model as current_fsuid/current_fsgid() for passing the
> filesystem credentials down to the filesystem operations?  i.e.
> attach it to the current->cred->fs_userns, and then the filesystem
> code that actually needs to know the current userns can call
> current_fs_user_ns() instead of current_user_ns().  i.e.
> 
> #define current_fs_user_ns()	\
> 	(current->cred->fs_userns ? current->cred->fs_userns \
> 				  : current->cred->userns)
> 
> At this point, the filesystem will now always have the correct
> userns it is supposed to use for mapping the uid/gid, right?

Thanks for this interesting idea! I have some troubles with it though.

This approach (always) seemed conceptually wrong to me. Like Tycho said
somewhere else this basically would act like a global variable which
isn't great.

There's also a substantial difference between in that the current fsuid
and fsgid are an actual property of the callers creds so to have them in
there makes perfect sense. But the user namespace of the vfsmount is a
property of the mount and as such glueing it to the callers creds when
calling into the vfs is just weird and I would very much like to avoid
this. If inode's wouldn't have an i_sb member we wouldn't suddenly start
to pass down the s_user_ns via the callers creds to the filesystems.

I'm also not fond of having to call prepare_creds() and override_creds()
all across the vfs. It's messy and prepare_creds() is especially
problematic during RCU pathwalk where we can't call it. We could
in path_init() at the start of every every lookup operation call
prepare_creds() and then override them when we need to switch the
fs_userns global variable and then put_creds() at the end of every path
walk in terminate_walk(). But this means penalizing every lookup
operations with an additional prepare_creds() which needs to be called
at least once, I think. Then during lookup we would need to
override/change this new global fs_userns variable potentially at each
mountpoint crossing to switch back to the correct fs_userns for idmapped
and non-idmapped mounts. We'd also need to rearrange a bunch of
terminate_walk() calls and we would like end up with a comparable amount
of changes only that they would indeed be more messy since we're
strapping fs_userns to the caller's creds.

I an alternative might be to have a combined approach where you pass the
user namespace around in the vfs but when calling into the filesystem
use the fs_userns global variable approach but I would very much prefer
to avoid this and instead cleanly pass down the user namespace
correctly. That's more work, it'll take longer but I and others are
around to see these changes through.

> 
> Also, if we are passing work off to worker threads, duplicating
> the current creds will capture this information and won't leave
> random landmines where stuff doesn't work as it should because the
> worker thread is unaware of the userns that it is supposed to be
> doing filesytsem operations under...

That seems like a problem that can be handled by simply keeping the
userns around similar to how we need to already keep creds around.

Christian
