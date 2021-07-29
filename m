Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D82C3D9D10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 07:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhG2F1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 01:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhG2F1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 01:27:30 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51F8C061757;
        Wed, 28 Jul 2021 22:27:26 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id z3so4539188ile.12;
        Wed, 28 Jul 2021 22:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DTeAbs9nCmz6V+eczywLnOWUpZGnm+DncT63ZiRo/lo=;
        b=vgPiyoKHxgAtrVNGmkH1dEGA6gNBDTvrHhAdmFug/wiS6g7ntg2E93RFZ4QOes4Vo8
         +0x1SOMR0eqfSFFKT3aDg5BMcaE41kCCtXMwwR7XhbqRGC2IhMk9mxeQUEwPg9KoB/7U
         DE9HnWFvKOW4CL2IQBTbDFZwl9CBQCssQRF27S4DOS4NcLXsOKseeznJ1Jmsuer2+eoB
         0BJ9kX+3anmoIPTnBzSLQ16yy0RkK2PVggQEbqD7WO/Fizdj+XIT84+XntA6loJCrx2X
         gJrcEz1rCEgdIvydUw4/nxqN334RVnfSXImiZzj2enf/VQVAaAMGNPgZRHcvoYwL+TEx
         oDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTeAbs9nCmz6V+eczywLnOWUpZGnm+DncT63ZiRo/lo=;
        b=lZ8K16efaDzIHPuRWsAiVcszQjTzeCKok0G0CVQ+oS9UbQgA+hu2W0Xgjfef9Q7L23
         DAh75SuaIW37h+KPS6eWDgGbpmCpgX7kK3aR7Xdw/J0TscFSqQEvrKmnR+WXKc5QkGMp
         u3/nWWcAnWov/FgWdS8z0QAJsizaxeasYldOrmbLBtZxwoI/cvTwLK181YqlTDonuQwO
         ydIgxS4KYynlkeyMAOovSpGX/Tm+Oo8EDE8c/Pbvy9WwFwoNjkob6aqKIFxa1yQDlsAc
         TmD6rYvyH7Ctssb/tSlHY+m+oznmuhV5urty7xLLWu3+szwIlwUOi/j/Nq+7/cc9RMy1
         kd6A==
X-Gm-Message-State: AOAM530UPeXQaqxwumBWpOLHHK8rV9xfBvgZYm8RCuoC06t8727hmZak
        b5PwexD3v5RqiIJ5omxytzxrgxlD3KRXOoXrpgc=
X-Google-Smtp-Source: ABdhPJxwG8Kc8HTWidT5R4osTYLwPRtVaXbXue0evzaiEyiHCcYn2tC/reoBc53O68HGysKNO3P3GDu+AC8Vc9tIpbQ=
X-Received: by 2002:a05:6e02:1c02:: with SMTP id l2mr2417307ilh.9.1627536446171;
 Wed, 28 Jul 2021 22:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546554.32498.9309110546560807513.stgit@noble.brown>
 <CAOQ4uxjXcVE=4K+3uSYXLsvGgi0o7Nav=DsV=0qG_DanjXB18Q@mail.gmail.com> <162751852209.21659.13294658501847453542@noble.neil.brown.name>
In-Reply-To: <162751852209.21659.13294658501847453542@noble.neil.brown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 29 Jul 2021 08:27:15 +0300
Message-ID: <CAOQ4uxj9DW2SHqWCMXy4oRdazbODMhtWeyvNsKJm__0fuuspyQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] exportfs: Allow filehandle lookup to cross internal
 mount points.
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 3:28 AM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 28 Jul 2021, Amir Goldstein wrote:
> > On Wed, Jul 28, 2021 at 1:44 AM NeilBrown <neilb@suse.de> wrote:
> > >
> > > When a filesystem has internal mounts, it controls the filehandles
> > > across all those mounts (subvols) in the filesystem.  So it is useful to
> > > be able to look up a filehandle again one mount, and get a result which
> > > is in a different mount (part of the same overall file system).
> > >
> > > This patch makes that possible by changing export_decode_fh() and
> > > export_decode_fh_raw() to take a vfsmount pointer by reference, and
> > > possibly change the vfsmount pointed to before returning.
> > >
> > > The core of the change is in reconnect_path() which now not only checks
> > > that the dentry is fully connected, but also that the vfsmnt reported
> > > has the same 'dev' (reported by vfs_getattr) as the dentry.
> > > If it doesn't, we walk up the dparent() chain to find the highest place
> > > where the dev changes without there being a mount point, and trigger an
> > > automount there.
> > >
> > > As no filesystems yet provide local-mounts, this does not yet change any
> > > behaviour.
> > >
> > > In exportfs_decode_fh_raw() we previously tested for DCACHE_DISCONNECT
> > > before calling reconnect_path().  That test is dropped.  It was only a
> > > minor optimisation and is now inconvenient.
> > >
> > > The change in overlayfs needs more careful thought than I have yet given
> > > it.
> >
> > Just note that overlayfs does not support following auto mounts in layers.
> > See ovl_dentry_weird(). ovl_lookup() fails if it finds such a dentry.
> > So I think you need to make sure that the vfsmount was not crossed
> > when decoding an overlayfs real fh.
>
> Sounds sensible - thanks.
> Does this mean that my change would cause problems for people using
> overlayfs with a btrfs lower layer?
>

It sounds like it might :-/
I assume that enabling automount in btrfs in opt-in?
Otherwise you will be changing behavior for users of existing systems.

I am not sure, but I think it may be possible to remove the AUTOMOUNT
check from the ovl_dentry_weird() condition with an explicit overlayfs
config/module/mount option so that we won't change behavior by
default, but distro may change the default for overlayfs.

Then, when admin changes the btrfs options on the system to perform
automounts, it will also need to change the overlayfs options to not
error on automounts.

Given that today, subvolume mounts (or any mounts) on the lower layer
are not followed by overlayfs, I don't really see the difference
if mounts are created manually or automatically.
Miklos?

> >
> > Apart from that, I think that your new feature should be opt-in w.r.t
> > the exportfs_decode_fh() vfs api and that overlayfs should not opt-in
> > for the cross mount decode.
>
> I did consider making it opt-in, but it is easy enough for the caller
> to ignore the changed vfsmount, and only one (of 4) callers that it
> really makes a difference for.
>

Which reminds me. Please ignore the changed vfsmount in
do_handle_to_path() (or do not opt-in to changed vfsmount).

I have an application that uses a bind mount to filter file handles
of directories by subtree. It opens by the file handles that were
acquired from fanotify DFID info record using a mountfd in the
bind mount and readlink /proc/self/fd to determine the path
relative to that subtree bind mount.

Your change, IIUC, is going to change the semantics of
open_by_handle_at(2) and is going to break my application.

If you need this change for nfsd, please keep it as an internal api
used only by nfsd.

TBH, I think it would also be nice to have an internal api to limit
reconnect_path() walk up to mnt->mnt_root, which is what overlayfs
really wants, so here is another excuse for you to introduce
"reconnect flags" to exportfs_decode_fh_raw() ;-)

Note that I had already added support for one implicit "reconnect
flag" (i.e. "don't reconnect") in commit 8a22efa15b46
("ovl: do not try to reconnect a disconnected origin dentry").

Thanks,
Amir.
