Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD9011E96F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 18:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfLMRtd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 12:49:33 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42284 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728109AbfLMRtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 12:49:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 640388EE1E0;
        Fri, 13 Dec 2019 09:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576259372;
        bh=7xZ2kdbDdxu/rNwD7Mso7rSnyX4q4gvUIPDh3dxPK/4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vE02NoJOqbWAmcyCVfgwkNSmsBx6ZvkohAWX2vc4sd+aDTgdmvl08pD3iCAsPcxpg
         ruOjbAOGMmKA1fAN7bg7gK4yppu7EHk49KdcxJKQjfhBU4NNOE2NKRF+dIs4O2V1+O
         zP2S+VFMMN35rVZQNZ30p8TUu+7hm/NJQ6R/h9V0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jJ-MljUeyJDL; Fri, 13 Dec 2019 09:49:32 -0800 (PST)
Received: from [9.232.197.95] (unknown [129.33.253.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4AACD8EE0E0;
        Fri, 13 Dec 2019 09:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576259372;
        bh=7xZ2kdbDdxu/rNwD7Mso7rSnyX4q4gvUIPDh3dxPK/4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vE02NoJOqbWAmcyCVfgwkNSmsBx6ZvkohAWX2vc4sd+aDTgdmvl08pD3iCAsPcxpg
         ruOjbAOGMmKA1fAN7bg7gK4yppu7EHk49KdcxJKQjfhBU4NNOE2NKRF+dIs4O2V1+O
         zP2S+VFMMN35rVZQNZ30p8TUu+7hm/NJQ6R/h9V0=
Message-ID: <1576259368.8504.26.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/2] fs: introduce uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri, 13 Dec 2019 12:49:28 -0500
In-Reply-To: <1575384015.3435.16.camel@HansenPartnership.com>
References: <1575335637.24227.26.camel@HansenPartnership.com>
         <1575335700.24227.27.camel@HansenPartnership.com>
         <CAOQ4uxiqc_bsa88kZG2PNLPcTqFojJU_24qL32qw-VVLG+rRFw@mail.gmail.com>
         <1575349974.31937.11.camel@HansenPartnership.com>
         <CAOQ4uxgcD5gwOXJfXaNki8t3=6oq32TB9URDpsoQo9A5tyCfqw@mail.gmail.com>
         <1575384015.3435.16.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-12-03 at 06:40 -0800, James Bottomley wrote:
> On Tue, 2019-12-03 at 08:55 +0200, Amir Goldstein wrote:
> > On Tue, Dec 3, 2019 at 7:12 AM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > 
> > > On Tue, 2019-12-03 at 06:51 +0200, Amir Goldstein wrote:
> > > > [cc: ebiederman]
> 
> [...]
> > > > 4. This is currently not overlayfs (stacked fs) nor nfsd
> > > > friendly. Those modules do not call the path based vfs APIs,
> > > > but
> > > > they do have the mnt stored internally.
> > > 
> > > OK, so I've got to confess that I've only tested it with my
> > > container use case, which doesn't involve overlay or
> > > nfs.  However,
> > > as long as we thread path down to the API that nfds and overlayfs
> > > use, it should easily be made compatible with them ... do we have
> > > any documentation of what API this is?
> > 
> > No proper doc AFAIK, but please take a look at:
> > https://lore.kernel.org/linux-fsdevel/20191025112917.22518-2-mszere
> > di
> > @redhat.com/
> > It is part of a series to make overlayfs an FS_USERNS_MOUNT.
> > 
> > The simplest case goes typically something like this:
> > rmdir -> do_rmdir -(change_userns_creds)-> vfs_rmdir ->
> >     ovl_rmdir -(ovl_override_creds)-> vfs_rmdir -> ext4_rmdir
> 
> Yes, I figured it would mostly be the vfs_ functions.
> 
> > So if you shift mounted the overlayfs mount, you won't end up
> > using shifted creds in ext4 operations.
> > And if you shift mounted ext4 *before* creating the overlay, then
> > still, overlay doesn't go through do_rmdir, so your method won't
> > work either.
> 
> So I think the upper use case (shift above overlay) is fairly easily
> solvable: it involves making ovl_override_creds shift aware, so that
> when it does the override it keeps the shift.  This might involve
> stashing the overlay creds where the shift ones are in the task
> structure so cred_is_shifted() still works.
> 
> The lower use case is more problematic because that would involve
> changing most of the vfs_ API.  I think we can take a phased
> approach:
> 
>    1. Get agreement for the approach using the unstacked case
> (current
>       patch effectively)
>    2. Make the upper case work because it's the low hanging fruit; I
> can
>       start looking at this (although I'll have to figure out how to
> get
>       overlayfs working first).
>    3. Investigate the lower case if there's an actual use.
> 
> > Similar situation with nfsd, although I have no idea if there are
> > plans to make nfsd userns aware.
> 
> It's a similar upper and lower issue, although upper just involves
> playing nicely with the name remapping.
> 
> > > > I suppose you do want to be able to mount overlays and export
> > > > nfs
> > > > out of those shifted mounts, as they are merely the foundation
> > > > for unprivileged container storage stack. right?
> > > 
> > > If the plan of doing this as a bind mount holds, then certainly
> > > because any underlying filesystem has to work with it.
> > > 
> > 
> > I am talking above, not under.
> 
> Hopefully I addressed that above.  I think above is easier and should
> be the first target, but to make this works completely eventually
> needs
> the under case as well.
> 
> > You shift mount an ext4 fs and hand it over to container fake root
> > (or mark it and let fake root shit mount).
> > The container fake root should be able to (after overlayfs unpriv
> > changes) create an overlay from inside container.
> > IOW, try to mount an overlay over your shifted fs and see how it
> > behaves.
> > 
> > > > For overlayfs, you should at least look at ovl_override_creds()
> > > > for incorporating shift mount logic - or more likely at the
> > > > creation of ofs->creator_cred.
> > > 
> > > Well, we had this discussion when I proposed shiftfs as a
> > > superblock based stackable filesytem, I think: the way the shift
> > > needs to use creds is fundamentally different from the way
> > > overlayfs uses them.  The ovl_override_creds is overriding with
> > > the
> > > creator's creds but the shifting bind mound needs to backshift
> > > through the user namespace currently in effect.  Since uid shifts
> > > can stack, we can make them work together, but they are
> > > fundamentally different things.
> > > 
> > 
> > Right.
> > Please take a look at the override_cred code in
> > ovl_create_or_link().
> > This code has some fsuid dance that you need to check for shift
> > friendliness.
> 
> Certainly, I've added it to my todo list.

OK, I've now read through the code and think I know how it will work in
the unprivileged case.  I'm still only looking at the shifting bind
above ... below is still a problem.

> > The entire security model of overlayfs needs to be reexamined in
> > the face of shift mount, but as I wrote, I don't think its going to
> > be too hard to make ovl_override_creds() shift mount aware.
> > Overlayfs mimics vfs behavior in many cases.
> 
> Agreed.

So in the unprivileged case, the lower mount will have its own mounter
override creds for doing the pull up operations.  These will override
any shifted creds we provide, but I think that's OK ... we don't want
the potentially more privileged creds to be active here.

When operating on the upper, we will be using the shifted creds, but
that too is correct because the upper r/w layer is precisely the one we
want the read at fake root, write at real root to work for.

In the usual (not unprivileged) case, of course, the overlayfs mount
creds are privileged, so they likely look the same as the shifted ones
anyway.

James

