Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E022A04EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 13:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgJ3MCJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 08:02:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39709 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3MCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:02:09 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kYT6V-0006JV-Px; Fri, 30 Oct 2020 12:01:59 +0000
Date:   Fri, 30 Oct 2020 13:01:57 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andy Lutomirski <luto@amacapital.net>
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
        James Bottomley <james.bottomley@hansenpartnership.com>,
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
Message-ID: <20201030120157.exz4rxmebruh7bgp@wittgenstein>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <8E455D54-FED4-4D06-8CB7-FC6291C64259@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8E455D54-FED4-4D06-8CB7-FC6291C64259@amacapital.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 02:58:55PM -0700, Andy Lutomirski wrote:
> 
> 
> > On Oct 28, 2020, at 5:35 PM, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > 
> > ﻿Hey everyone,
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
> > with can create a new bind-mount and mark it with a user namespace.
> 
> So one way of thinking about this is that a user namespace that has an idmapped mount can, effectively, create or chown files with *any* on-disk uid or gid by doing it directly (if that uid exists in-namespace, which is likely for interesting ids like 0) or by creating a new userns with that id inside.
> 
> For a file system that is private to a container, this seems moderately safe, although this may depend on what exactly “private” means. We probably want a mechanism such that, if you are outside the namespace, a reference to a file with the namespace’s vfsmnt does not confer suid privilege.
> 
> Imagine the following attack: user creates a namespace with a root user and arranges to get an idmapped fs, e.g. by inserting an ext4 usb stick or using whatever container management tool does this.  Inside the namespace, the user creates a suid-root file.
> 
> Now, outside the namespace, the user has privilege over the namespace.  (I’m assuming there is some tool that will idmap things in a namespace owned by an unprivileged user, which seems likely.). So the user makes a new bind mount and if maps it to the init namespace. Game over.
> 
> So I think we need to have some control to mitigate this in a comprehensible way. A big hammer would be to require nosuid. A smaller hammer might be to say that you can’t create a new idmapped mount unless you have privilege over the userns that you want to use for the idmap and to say that a vfsmnt’s paths don’t do suid outside the idmap namespace.  We already do the latter for the vfsmnt’s mntns’s userns.

With this series, in order to create an idmapped mount the user must
either be cap_sys_admin in the superblock of the underlying filesystem
or if the mount is already idmapped and they want to create another
idmapped mount from it they must have cap_sys_admin in the userns that
the mount is currrently marked with. It is also not possible to change
an idmapped mount once it has been idmapped, i.e. the user must create a
new detached bind-mount first.

> 
> Hmm.  What happens if we require that an idmap userns equal the vfsmnt’s mntns’s userns?  Is that too limiting?
> 
> I hope that whatever solution gets used is straightforward enough to wrap one’s head around.
> 
> > When a file/inode is accessed through an idmapped mount the i_uid and
> > i_gid of the inode will be remapped according to the user namespace the
> > mount has been marked with. When a new object is created based on the
> > fsuid and fsgid of the caller they will similarly be remapped according
> > to the user namespace of the mount they care created from.
> 
> By “mapped according to”, I presume you mean that the on-disk uid/gid is the gid as seen in the user namespace in question.

If I understand you correctly, then yes.
