Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58DF10F825
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 07:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLCGzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 01:55:54 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40875 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfLCGzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:55:54 -0500
Received: by mail-yw1-f67.google.com with SMTP id i126so914145ywe.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2019 22:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nc18I09yB+Mc8wuPxVSss0W24eagOvvGI4YSUAB9G6g=;
        b=rTSRUnF1FwGCIkkrkvlqQJLStZC0vxh3g5+mH9+a+6tc4PBj1YuvvRCa0XRCg+jH/2
         0TMaNpQ05sPBkJon/uuSOHb/gn/PCtNDaZsz5VbXpCG0NJfFYPqHLg/xFydUELCAYDpF
         p3uO8v/hFwrFDP59hjZW2J9GMTUVHnHS5p53T7fdX8JaCRlbHv4nzZ+1GxIt7u6YNo/R
         slCBAk4QYT3Mqt3jIr4/MuAvNC5Lq4du9EClWLNVt5MhOobA/EGK1Bz9tZJka5/F1EcY
         iaZOIPKHlq9Xa+UFxVxTy8sEEQM0LvStLzi79dmgd0/4EJXAahQGc7hO0c8cm6zVNd4F
         regA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nc18I09yB+Mc8wuPxVSss0W24eagOvvGI4YSUAB9G6g=;
        b=Ym6IuPmKlly4u0ibntxfdTs7yllLZnTMHaWi2JiH/fM877QFpiuGhbheiU/E1jc+Or
         /rtOJG/xkpwZkbxYE1XhLmCB7rwz5G+0I8uNYej+pX7VfNwjDq3CAUsamoUiPYqcTK1k
         z+HnakiPw46C9avgELJ/hHONFTGJko5EPbKmFYpaEvN+EiVU6zRtFgK+4+kfML3JPv0C
         V3vErD0fq6f7ZW8myAgZVLFnFwwL0uyhgiPPJxLAmp8vqhMcsxu95pPsNPsrxdl+DpS5
         cJrAh/eXs+kwgT9IX5ZSWD9/9grmtWORP3pQDKNUR6ZnApjg6de9L1OP6g78Th88qAnO
         zAeQ==
X-Gm-Message-State: APjAAAXX+5oTlicZwnX5XnppMr2XwWh5GiVWinAqC62Y17u07Cr5+t13
        Cox2NZC3Xih9LGteiYp1m6DzaM6FgzmnMXxWPeU=
X-Google-Smtp-Source: APXvYqybYsJGGY2ZSwf6ikMWT8HxiI9B7kJJ49oKPF7Q6VGg5h93bu31eHQsCPiHmxhzf2IWHBobum4Bf4T9BOK22Y0=
X-Received: by 2002:a81:1887:: with SMTP id 129mr2528978ywy.25.1575356152525;
 Mon, 02 Dec 2019 22:55:52 -0800 (PST)
MIME-Version: 1.0
References: <1575335637.24227.26.camel@HansenPartnership.com>
 <1575335700.24227.27.camel@HansenPartnership.com> <CAOQ4uxiqc_bsa88kZG2PNLPcTqFojJU_24qL32qw-VVLG+rRFw@mail.gmail.com>
 <1575349974.31937.11.camel@HansenPartnership.com>
In-Reply-To: <1575349974.31937.11.camel@HansenPartnership.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Dec 2019 08:55:41 +0200
Message-ID: <CAOQ4uxgcD5gwOXJfXaNki8t3=6oq32TB9URDpsoQo9A5tyCfqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: introduce uid/gid shifting bind mount
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 3, 2019 at 7:12 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2019-12-03 at 06:51 +0200, Amir Goldstein wrote:
> > [cc: ebiederman]
> >
> > On Tue, Dec 3, 2019 at 3:15 AM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > This implementation reverse shifts according to the user_ns
> > > belonging
> > > to the mnt_ns.  So if the vfsmount has the newly introduced flag
> > > MNT_SHIFT and the current user_ns is the same as the mount_ns-
> > > >user_ns
> > > then we shift back using the user_ns before committing to the
> > > underlying filesystem.
> > >
> > > For example, if a user_ns is created where interior (fake root, uid
> > > 0)
> > > is mapped to kernel uid 100000 then writes from interior root
> > > normally
> > > go to the filesystem at the kernel uid.  However, if MNT_SHIFT is
> > > set,
> > > they will be shifted back to write at uid 0, meaning we can bind
> > > mount
> > > real image filesystems to user_ns protected faker root.
> > >
> > > In essence there are several things which have to be done for this
> > > to
> > > occur safely.  Firstly for all operations on the filesystem, new
> > > credentials have to be installed where fsuid and fsgid are set to
> > > the
> > > *interior* values. Next all inodes used from the filesystem have to
> > > have i_uid and i_gid shifted back to the kernel values and
> > > attributes
> > > set from user space have to have ia_uid and ia_gid shifted from the
> > > kernel values to the interior values.  The capability checks have
> > > to
> > > be done using ns_capable against the kernel values, but the inode
> > > capability checks have to be done against the shifted ids.
> > >
> > > Since creating a new credential is a reasonably expensive
> > > proposition
> > > and we have to shift and unshift many times during path walking, a
> > > cached copy of the shifted credential is saved to a newly created
> > > place in the task structure.  This serves the dual purpose of
> > > allowing
> > > us to use a pre-prepared copy of the shifted credentials and also
> > > allows us to recognise whenever the shift is actually in effect
> > > (the
> > > cached shifted credential pointer being equal to the current_cred()
> > > pointer).
> > >
> > > To get this all to work, we have a check for the vfsmount flag and
> > > the
> > > user_ns gating a shifting of the credentials over all user space
> > > entries to filesystem functions.  In theory the path has to be
> > > present
> > > everywhere we do this, so we can check the vfsmount
> > > flags.  However,
> > > for lower level functions we can cheat this path check of vfsmount
> > > simply to check whether a shifted credential is in effect or not to
> > > gate things like the inode permission check, which means the path
> > > doesn't have to be threaded all the way through the permission
> > > checking functions.  if the credential is shifted check passes, we
> > > can
> > > also be sure that the current user_ns is the same as the mnt-
> > > >user_ns,
> > > so we can use it and thus have no need of the struct mount at the
> > > point of the shift.
> > >
> >
> > 1. Smart
>
> Heh, thanks.
>
> > 2. Needs serious vetting by Eric (cc'ed)
> > 3. A lot of people have been asking me for filtering of "dirent"
> > fsnotify events (i.e. create/delete) by path, which is not available
> > in those vfs functions, so ifthe concept of current->mnt flies,
> > fsnotify is going to want to use it as well.
>
> Just a caveat: current->mnt is used in this patch simply as a tag,
> which means it doesn't need to be refcounted.  I think I can prove that
> it is absolutely valid if the cred is shifted because the reference is
> held by the code that shifted the cred, but it's definitely not valid
> except for a tag comparison outside of that.  Thus, if it is useful for
> fsnotify, more thought will have to be given to refcounting it.
>

Yes. Is there anything preventing us from taking refcount on
current->mnt?

> > 4. This is currently not overlayfs (stacked fs) nor nfsd friendly.
> > Those modules do not call the path based vfs APIs, but they do have
> > the mnt stored internally.
>
> OK, so I've got to confess that I've only tested it with my container
> use case, which doesn't involve overlay or nfs.  However, as long as we
> thread path down to the API that nfds and overlayfs use, it should
> easily be made compatible with them ... do we have any documentation of
> what API this is?

No proper doc AFAIK, but please take a look at:
https://lore.kernel.org/linux-fsdevel/20191025112917.22518-2-mszeredi@redhat.com/
It is part of a series to make overlayfs an FS_USERNS_MOUNT.

The simplest case goes typically something like this:
rmdir -> do_rmdir -(change_userns_creds)-> vfs_rmdir ->
    ovl_rmdir -(ovl_override_creds)-> vfs_rmdir -> ext4_rmdir

So if you shift mounted the overlayfs mount, you won't end up
using shifted creds in ext4 operations.
And if you shift mounted ext4 *before* creating the overlay, then
still, overlay doesn't go through do_rmdir, so your method won't
work either.

Similar situation with nfsd, although I have no idea if there are plans
to make nfsd userns aware.

>
> > I suppose you do want to be able to mount overlays and export nfs out
> > of those shifted mounts, as they are merely the foundation for
> > unprivileged container storage stack. right?
>
> If the plan of doing this as a bind mount holds, then certainly because
> any underlying filesystem has to work with it.
>

I am talking above, not under.
You shift mount an ext4 fs and hand it over to container fake root
(or mark it and let fake root shit mount).
The container fake root should be able to (after overlayfs unpriv changes)
create an overlay from inside container.
IOW, try to mount an overlay over your shifted fs and see how it
behaves.

> > For overlayfs, you should at least look at ovl_override_creds() for
> > incorporating shift mount logic - or more likely at the creation of
> > ofs->creator_cred.
>
> Well, we had this discussion when I proposed shiftfs as a superblock
> based stackable filesytem, I think: the way the shift needs to use
> creds is fundamentally different from the way overlayfs uses them.  The
> ovl_override_creds is overriding with the creator's creds but the
> shifting bind mound needs to backshift through the user namespace
> currently in effect.  Since uid shifts can stack, we can make them work
> together, but they are fundamentally different things.
>

Right.
Please take a look at the override_cred code in ovl_create_or_link().
This code has some fsuid dance that you need to check for shift friendliness.

The entire security model of overlayfs needs to be reexamined in the face
of shift mount, but as I wrote, I don't think its going to be too hard to
make ovl_override_creds() shift mount aware.
Overlayfs mimics vfs behavior in many cases.

Unless you shift mount both overlayfs and underlying (say) ext4, then
you still have only one mnt_cred to cache in any given call stack.

Thanks,
Amir.
