Return-Path: <linux-fsdevel+bounces-61917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF6BB7D8DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0483B5651
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 11:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFD62E041A;
	Wed, 17 Sep 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPBiLHzt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0D28489B
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107281; cv=none; b=b+huKrfHmqkDftq8N8w/Yzwo9iQsKWR4mHxB2Bv07DsKbyYMvKCiXY40Q/uIIgrWX21jtGcOwo0HH5SgofED3fHbjyhyTrKWBfXnt4XawsZP96TaBCzxNf75vEA0LNCMXY4C5bPJHPVDUTckr/wiwpia2NQxX2tDQF3vDQrqQMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107281; c=relaxed/simple;
	bh=pYjQ1XQT/HNuTqn+7b4q9hbNaRNnguSPkHWg1Y4CjWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNzV8fZ7pCWsnXhemq5FvM+dIns045X8KceDrg1Uk7ytWNxwf26LYxPpY+sAdMUbgm9I0LnFY125bgt6pHAA1cZq+dMgHasdaLFsK+M0V5wJEdjQgK9xLH6yOhc0T+xMn5VgBSn6FpcSIRLFVJpzcKJStL2+So02pJU679FwP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPBiLHzt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so12597734a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 04:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758107277; x=1758712077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWIRj9EPAFJ6SDGK2W9Q/BH2SriYdsdu0mVtJzTtwOc=;
        b=HPBiLHztXQEcHy+xD9LHYhE/akuafDFpYHEyzVr2772BF2pV5F5jgsHQHvBnwz8KxS
         2IFMbik9uVIbtcqnWZR3fwtreVy0M5SREGazz0cw7ODtRz34xZbl5/1gJv/V0MQzwTn+
         XZlfR1o6HK00Pr+MdljilwjdivFP+n1ShiFqNoGlWW5syuRVf+wh/G14/fCDQ+IJAWbM
         dYmjEoY9sNCDv8gni3QtrU5O/nYFXlFymIOiPNOLY5P+ulTQe5dmBNJE3BJcW8EMcQmv
         ZAakW++4i72/pUgDbzx8NtN77B3xpq9ZnAw178AT0Sghq7IDcn8+MQE0LmvrnkA5NLya
         cPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758107277; x=1758712077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWIRj9EPAFJ6SDGK2W9Q/BH2SriYdsdu0mVtJzTtwOc=;
        b=JMRTBmWzN2d1bOXe8ri+h9IdQ6L/HCQJw6ruik/iVyps6toXdcfIl1mEv2OgxcmZ7C
         ZBm0Dz4VXmxAImHD6jmVMDB93gX45yJL9oQh3VZasfreWOxQjcQ0y8bBrQ9fO8n5GPMR
         LNAidKHKVVtP3N647b32F4t0AUSwTLqaeR7iaARBuZqgwKvENPqZWTesr4D24KHHZei5
         lV6gULgVJihaZgbA3s1iQJ3fl6y2inxF9OQ1NrJLnVpmgz+Lt1BbJKPudJuMaoF0bblA
         IJdPrk10hHbwjzZ5H3qVqBxRJuaiUJoYtCY6Od+iQDI8RXFqKXOv/hL2I7jL9BqlKxH1
         XN6w==
X-Forwarded-Encrypted: i=1; AJvYcCWrR+q+uZm9gmvCbKoD79Cn+72wqUL0/c32Wwpsj8jSJTh47XPbRNfn2yOIdAu++qyuHKIYNgGi6Qv2aKRt@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvNrX/RfRl3cYUIZMcLygzPkzmgfGU8V20pcs3Jv9nb4SgE99
	F5v0Hxjga3VJgDm5CZaBdSCnTpbXryEm5BhfGOQc1c0n+HTLd3dEUbDkMRucItF1IuxFHJo9+gR
	zvM0r/UgntN5lI1XW9uyO/joKcQ6S1qk=
X-Gm-Gg: ASbGncsBk36FTJHC/er+eaOxYWUHtgEIQ00FqGrVVjP3f1HQm9mOZ41o20hzDWh0eGu
	Z6durqem0rBDfToXP98jOunvNKuhUIxIGuzKIIsMbJ9hGxH+d5oaRXx/V15dL1dRSKevoE4SLL5
	h2XGkEquIzUT9PK5RP8hdrHRdqDDhBqkzeoyqWX6wJgtZp9NaUOaZ15UjIRmcPGgbuuFIbgZd62
	XzFc9lkBtTVEKVDLFEV4kk3J81AGfu4qlVXK8SiuQ==
X-Google-Smtp-Source: AGHT+IFCZrDxRyDuF19zB+0I4pu2/v9rmtKq82MHbh7mP5cn+VDFD1mqV8V5UWGcn/V+qarK8JVVe8IWCUPBfnenwls=
X-Received: by 2002:a05:6402:34c2:b0:62d:e044:4a5a with SMTP id
 4fb4d7f45d1cf-62f834b2c31mr2034219a12.0.1758107276976; Wed, 17 Sep 2025
 04:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915101510.7994-1-acsjakub@amazon.de> <CAOQ4uxgXvwumYvJm3cLDFfx-TsU3g5-yVsTiG=6i8KS48dn0mQ@mail.gmail.com>
 <x4q65t5ar5bskvinirqjbrs4btoqvvvdsce2bdygoe33fnwdtm@eqxfv357dyke>
 <CAOQ4uxhbDwhb+2Brs1UdkoF0a3NSdBAOQPNfEHjahrgoKJpLEw@mail.gmail.com>
 <gdovf4egsaqighoig3xg4r2ddwthk2rujenkloqep5kdub75d4@7wkvfnp4xlxx>
 <CAOQ4uxhOMcaVupVVGXV2Srz_pAG+BzDc9Gb4hFdwKUtk45QypQ@mail.gmail.com> <scmyycf2trich22v25s6gpe3ib6ejawflwf76znxg7sedqablp@ejfycd34xvpa>
In-Reply-To: <scmyycf2trich22v25s6gpe3ib6ejawflwf76znxg7sedqablp@ejfycd34xvpa>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 17 Sep 2025 13:07:45 +0200
X-Gm-Features: AS18NWAyG-Lbgs8NF1KctS3y1dROL3-UVQmiQF_4Pa3SBteksXQOKH4-h04JDS0
Message-ID: <CAOQ4uxgSQPQ6Vx4MLECPPxn35m8--1iL7_rUFEobBuROfEzq_A@mail.gmail.com>
Subject: Re: [PATCH] ovl: check before dereferencing s_root field
To: Jan Kara <jack@suse.cz>
Cc: Jakub Acs <acsjakub@amazon.de>, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:25=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 16-09-25 15:29:35, Amir Goldstein wrote:
> > On Tue, Sep 16, 2025 at 1:30=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 15-09-25 17:29:40, Amir Goldstein wrote:
> > > > On Mon, Sep 15, 2025 at 4:07=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > > > > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > > > > > > index 83f80fdb1567..424c73188e06 100644
> > > > > > > --- a/fs/overlayfs/export.c
> > > > > > > +++ b/fs/overlayfs/export.c
> > > > > > > @@ -195,6 +195,8 @@ static int ovl_check_encode_origin(struct=
 inode *inode)
> > > > > > >         if (!ovl_inode_lower(inode))
> > > > > > >                 return 0;
> > > > > > >
> > > > > > > +       if (!inode->i_sb->s_root)
> > > > > > > +               return -ENOENT;
> > > > > >
> > > > > > For a filesystem method to have to check that its own root is s=
till alive sounds
> > > > > > like the wrong way to me.
> > > > > > That's one of the things that should be taken for granted by fs=
 code.
> > > > > >
> > > > > > I don't think this is an overlayfs specific issue, because othe=
r fs would be
> > > > > > happy if encode_fh() would be called with NULL sb->s_root.
> > > > >
> > > > > Actually, I don't see where that would blow up? Generally referen=
ces to
> > > > > sb->s_root in filesystems outside of mount / remount code are pre=
tty rare.
> > > > > Also most of the code should be unreachable by the time we set sb=
->s_root
> > > > > to NULL because there are no open files at that moment, no export=
s etc. But
> > > > > as this report shows, there are occasional surprises (I remember =
similar
> > > > > issue with ext4 sysfs files handlers using s_root without checkin=
g couple
> > > > > years back).
> > > > >
> > > >
> > > > I am not sure that I understand what you are arguing for.
> > > > I did a very naive grep s_root fs/*/export.c and quickly found:
> > >
> > > You're better with grep than me ;). I was grepping for '->s_root' as =
well
> > > but all the hits I had looked into were related to mounting and simil=
ar and
> > > eventually I got bored. Restricting the grep to export ops indeed sho=
ws
> > > ceph, gfs2 and overlayfs are vulnerable to this kind of problem.

As far as I can tell, ceph uses s_root only in decode_fh methods.

ovl and gfs2 only want to know for an inode if it is the root inode,
they do not strictly need to dereference s_root for that purpose.
(see patch below)

> > >
> > > > static int gfs2_encode_fh(struct inode *inode, __u32 *p, int *len,
> > > >                           struct inode *parent)
> > > > {
> > > > ...
> > > >         if (!parent || inode =3D=3D d_inode(sb->s_root))
> > > >                 return *len;
> > > >
> > > > So it's not an overlayfs specific issue, just so happens that zysbo=
t
> > > > likes to test overlayfs.
> > > >
> > > > Are you suggesting that we fix all of those one by one?
> > >
> > > No. I agree we need to figure out a way to make sure export ops are n=
ot
> > > called on a filesystem being unmounted. Standard open_by_handle() or =
NFS
> > > export cannot race with generic_shutdown_super() (they hold the fs mo=
unted)
> > > so fsnotify is a special case here.
> > >
> > > I actually wonder if fanotify event (e.g. from inode deletion postpon=
ed to
> > > some workqueue or whatever) cannot race with umount as well and cause=
 the
> > > same problem...
> > >
> >
> > Oy. I was thinking that all event happen when holding some mnt ref
> > but yeh fsnotify_inoderemove() does look like it could be a problem
> > from sb shutdown context.
>
> Well, but there's also fun like fs/kernfs/file.c: kernfs_notify() which
> queues work which calls fsnotify for some inodes and, frankly, proper
> exclusion with umount seems non-existent there (but I can be missing
> something).

Ouch!

>
> Also we have fsnotify_sb_error() which can happen practically anytime
> before the fs gets fully shutdown in ->kill_sb() and may try to encode fh
> of an inode.
>

Bigger ouch because silencing this event is not an option.

> So there are not many cases where this can happen but enough that I'd say
> that handling some events specially to avoid encoding fh on fs while it i=
s
> unmounted is fragile and prone to breaking again sooner or later.
>
> > How about skipping fsnotify_inoderemove() in case sb is in shutdown?
>
> Also how would you like to handle that in a race-free manner? We'd need t=
o
> hold s_umount for that which we cannot really afford in that context. But
> maybe you have some better idea...
>

I was only thinking about this code path:

generic_shutdown_super()
  shrink_dcache_for_umount()
    ...
      __dentry_kill()
        dentry_unlink_inode()

This is supposed to be the last dput of all remaining dentries
and I don't think a deferred unlink should be expected in that case.

But I realize now that you mean delayed unlink from another context
which races with shutdown.

> > > > > > Can we change the order of generic_shutdown_super() so that
> > > > > > fsnotify_sb_delete(sb) is called before setting s_root to NULL?
> > > > > >
> > > > > > Or is there a better solution for this race?
> > > > >
> > > > > Regarding calling fsnotify_sb_delete() before setting s_root to N=
ULL:
> > > > > In 2019 (commit 1edc8eb2e9313 ("fs: call fsnotify_sb_delete after
> > > > > evict_inodes")) we've moved the call after evict_inodes() because=
 otherwise
> > > > > we were just wasting cycles scanning many inodes without watches.=
 So moving
> > > > > it earlier wouldn't be great...
> > > >
> > > > Yes, I noticed that and I figured there were subtleties.
> > >
> > > Right. After thinking more about it I think calling fsnotify_sb_delet=
e()
> > > earlier is the only practical choice we have (not clearing sb->s_root=
 isn't
> > > much of an option - we need to prune all dentries to quiesce the file=
system
> > > and leaving s_root alive would create odd corner cases). But you don'=
t want
> > > to be iterating millions of inodes just to clear couple of marks so w=
e'll
> > > have to figure out something more clever there.
> >
> > I think we only need to suppress the fsnotify_inoderemove() call.
> > It sounds doable and very local to fs/super.c.
> >
> > Regarding show_mark_fhandle() WDYT about my suggestion to
> > guard it with super_trylock_shared()?
>
> Yes, super_trylock_shared() for that callsite looks like a fine solution
> for that call site. Occasional random failures in encoding fh because the
> trylock fails are unlikely to have any bad consequences there. But I thin=
k
> we need to figure out other possibly racing call-sites as well first.
>

Might something naive as this be enough?

Thanks,
Amir.

diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d514..8c9d0d6bb0045 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1999,10 +1999,12 @@ struct dentry *d_make_root(struct inode *root_inode=
)

        if (root_inode) {
                res =3D d_alloc_anon(root_inode->i_sb);
-               if (res)
+               if (res) {
+                       root_inode->i_opflags |=3D IOP_ROOT;
                        d_instantiate(res, root_inode);
-               else
+               } else {
                        iput(root_inode);
+               }
        }
        return res;
 }
diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
index 3334c394ce9cb..809a09c6a89e0 100644
--- a/fs/gfs2/export.c
+++ b/fs/gfs2/export.c
@@ -46,7 +46,7 @@ static int gfs2_encode_fh(struct inode *inode, __u32
*p, int *len,
        fh[3] =3D cpu_to_be32(ip->i_no_addr & 0xFFFFFFFF);
        *len =3D GFS2_SMALL_FH_SIZE;

-       if (!parent || inode =3D=3D d_inode(sb->s_root))
+       if (!parent || is_root_inode(inode))
                return *len;

        ip =3D GFS2_I(parent);
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 83f80fdb15674..7827c63354ad5 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -199,7 +199,7 @@ static int ovl_check_encode_origin(struct inode *inode)
         * Root is never indexed, so if there's an upper layer, encode uppe=
r for
         * root.
         */
-       if (inode =3D=3D d_inode(inode->i_sb->s_root))
+       if (is_root_inode(inode))
                return 0;

        /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec867f112fd5f..ed84379aa06ca 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -665,6 +665,7 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_DEFAULT_READLINK   0x0010
 #define IOP_MGTIME     0x0020
 #define IOP_CACHED_LINK        0x0040
+#define IOP_ROOT       0x0080
  /*
  * Keep mostly read-only and often accessed (especially for
@@ -2713,6 +2714,11 @@ static inline bool is_mgtime(const struct inode *ino=
de)
        return inode->i_opflags & IOP_MGTIME;
 }

+static inline bool is_root_inode(const struct inode *inode)
+{
+       return inode->i_opflags & IOP_ROOT;
+}
+
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
        int flags, const char *dev_name, void *data,
        int (*fill_super)(struct super_block *, void *, int));

