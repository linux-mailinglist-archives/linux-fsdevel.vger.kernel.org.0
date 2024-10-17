Return-Path: <linux-fsdevel+bounces-32197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D3C9A2448
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E73DBB26422
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5813B1DE2B6;
	Thu, 17 Oct 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FmvSz5Ps"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1201DDC12
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173150; cv=none; b=Grf6jJUajlevPNfPHaqOkWAfL+E5GWNTTCWkcnyhW/B8c4G2+nwcCC7rZfBUiPEnXbIXBUuR2368UKVFpJjCbBA0M5IIP1thEo98bmgMYakLW08I8NIABEB8l/uKPInRxLY1QLRrRAPqEK3OXdwDRunO6C+8vkmtCI7SR8lEZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173150; c=relaxed/simple;
	bh=FMIufTmexYwlXM3Zi/JZasx+dmJgPUeH1ykaaw71dtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyXSKR3ZfnbsnfJXDdtFmjceBirY74tJEVCczl3mFW3I3aErZRtB6Q8Ch6WKHVhxrY5xF3LoH28a0kzC6+2hb05JJXdfXgN1B1DEhYPxe/CxmI5tK05pR/6GEQysOU2DBolM+auPwPjeUjVoeMZ6Zriszos1FzoyQMYpyv/q3vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FmvSz5Ps; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c948c41edeso1226848a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 06:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729173142; x=1729777942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uKIs30LYgioWdpa9DEO8eGzdNdTRv606iZXm8cp8Zwc=;
        b=FmvSz5PsAdoQCEw7KqNTBevWEjz3z95iYafSUf9g6LDC+P2OF/LOEPJG7PmxvYF0AV
         1PiBQsDjsT42/chKZJBEn4H9OXFJZ6IxSS3mPiBloNsteI0W2+VfVBxITpaRB7uMePA9
         0KYYChLJu6zA/1iGL2jrGh3Megn5EzUoI4Dcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729173142; x=1729777942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKIs30LYgioWdpa9DEO8eGzdNdTRv606iZXm8cp8Zwc=;
        b=lJXcGX38MMSUBT1BMKP2VnZZUewa2QTMo/v0vUxssnSw/oJYnEvJc/J7LeimOEQsQy
         cuM52e2d+RPsM2O/m6TUWIW05snuvrb9QZ5j9GAQsWiJf10EE3emvxFZ2Bzmc5eP5Fuh
         8ZjMsUE57w/xVWwmBINKECRhrnlpb8TIpguqorsVAyRnybVGfrKC0qYW9b12wk/BiF9V
         ytGNH95HqpnxFL9jfPXR9I15DckKTnPXdEDF2m4yWl30XWYrK4ST+3ApNKdTco3VhKd2
         i60k/U35heuN23E25v1pOEYyBibbmj71r/UIMHSflCd0cs5CXiW5G9e2BxwoL9KoDhxY
         aWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL8MKiHGektVe7SVBVtWIlbwqpPuxyR4fMG0NQVep7QOKQ1OkxSVYpqIOMgHiXsL2tg+CNM8Jhw2/twV5/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9AaK4WmwvQxgbi2QIkq05vQonuCLZ8BLTTHf2LcRX/Cu+auRK
	buPj+UV9vijgXKhvDc2x8vWwrhWMQ0WLMNko96KaZcNkzwkxxlmozPD8TqtSX7U2IFEkLWk+jwA
	Zz6hZejzUMOGmT/CG+5afRka2vV93eOC8TYbf0d+Izk038QxnoeU=
X-Google-Smtp-Source: AGHT+IEbXMzxu35Ndry7RP4LgLMbja+WTg2ngfod7wgLNENRCGGBH5a9suqtd68f3V0GD5m7Q1xpDN4ZjxWuOgUJ2sc=
X-Received: by 2002:a17:907:940f:b0:a9a:423:3278 with SMTP id
 a640c23a62f3a-a9a0423332emr1338556866b.49.1729173142323; Thu, 17 Oct 2024
 06:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007141925.327055-1-amir73il@gmail.com> <20241017045231.GJ4017910@ZenIV>
 <CAOQ4uxh-P91UN4=jM-CgdGfD929PskvTVbuY0hFAU9N61cUuRA@mail.gmail.com>
In-Reply-To: <CAOQ4uxh-P91UN4=jM-CgdGfD929PskvTVbuY0hFAU9N61cUuRA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 17 Oct 2024 15:52:10 +0200
Message-ID: <CAJfpegtLp0cZp1COp64LFjx0QgBmfWo2C20_kzuNZj5RXBCN3w@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Store overlay real upper file in ovl_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Oct 2024 at 10:18, Amir Goldstein <amir73il@gmail.com> wrote:

> It has been like that since the first upstream version.
> My guess is that it is an attempt to avoid turning wdentry
> into a negative dentry, which is not expected to be useful in
> ovl_clear_empty() situations, but this is just a guess.

Yes.  This was discussed in a private thread before merging overlayfs upstream.

Copying relevant parts here:

----------
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sat, 18 Oct 2014 at 10:18
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
<mszeredi@suse.cz>, David Howells <dhowells@redhat.com>, Sage Weil
<sage@inktank.com>


[Cc to Sage due to interesting ceph bit that has shown up from grepping -
see the very end]

On Sat, Oct 18, 2014 at 06:01:53AM +0100, Al Viro wrote:

First of all, I've just fixed a dumb braino in ovl_clear_empty(); assignment
to upper needed to be moved up to the added test.  Force-pushed to the same
branch - vfs.git#ovl-experimental.

> As for the "what filesystems are we OK with", I wonder if looking into the
> sucker's ->s_d_op (or ->d_op of root of lower tree, for that matter) would
> be a good approximation.  I really think that ->d_{weak_,}revalidate() in
> there is complete no-go, ditto for ->d_manage() and ->d_automount() and
> I would consider ->d_compare() or ->d_hash() as a cause to be _very_ cautious.
>
> Alternatively, we could just go ahead and add FS_OK_FOR_OVERLAY_LOWER into
> fs type flags and mark the obvious good ones.  It's not _that_ much work.
>
> I'd still like to hear details on the plans re d_path(); I don't consider
> that a deal-breaker, but we'd better have some clear idea of what we are
> getting into.

BTW, why on the Earth are you pinning that ->__upperdentry twice?  The
comment about d_delete() makes no sense whatsoever - anything other than
overlayfs itself would have to grab a reference to call that d_delete(),
which would give you refcount greater than 1 automatically.  So it would
have to be overlayfs passing that thing to d_delete() or something that
would call it, right?  Now, d_delete() itself isn't called there at all.
Which leaves passing the sucker to something outside that would call
d_delete().  Now, what would it be?

Here's the full list of d_delete() callers:
arch/s390/hypfs/inode.c:82:     d_delete(dentry);
drivers/infiniband/hw/ipath/ipath_fs.c:318:     d_delete(dir);
drivers/infiniband/hw/qib/qib_fs.c:512: d_delete(dir);
drivers/usb/gadget/function/f_fs.c:1560:
d_delete(epfile->dentry);
drivers/usb/gadget/legacy/inode.c:1611:         d_delete (dentry);
fs/btrfs/ioctl.c:2507:          d_delete(dentry);
fs/ceph/dir.c:893:              d_delete(dentry);
fs/ceph/inode.c:1114:                           d_delete(dn);
fs/ceph/inode.c:1223:                           d_delete(dn);
fs/ceph/inode.c:1395:                   d_delete(dn);
fs/configfs/dir.c:643:          d_delete(child);
fs/configfs/dir.c:834:                  d_delete(dentry);
fs/configfs/dir.c:880:                  d_delete(dentry);
fs/configfs/dir.c:1475:                         d_delete(new_dentry);
fs/configfs/dir.c:1721: d_delete(dentry);
fs/debugfs/inode.c:483:                         d_delete(dentry);
fs/devpts/inode.c:666:  d_delete(dentry);
fs/efivarfs/file.c:50:          d_delete(file->f_dentry);
fs/fuse/dir.c:1061:                     d_delete(entry);
fs/namei.c:3586:                d_delete(dentry);
fs/namei.c:3702:                d_delete(dentry);
fs/nfs/dir.c:1760:              d_delete(dentry);
fs/nfs/nfs4proc.c:2231:                         d_delete(dentry);
fs/ocfs2/dlmglue.c:3752:                d_delete(dentry);
fs/reiserfs/xattr.c:95:         d_delete(dentry);
fs/reiserfs/xattr.c:111:                d_delete(dentry);
net/sunrpc/rpc_pipe.c:607:      d_delete(dentry);
net/sunrpc/rpc_pipe.c:634:      d_delete(dentry);
security/selinux/selinuxfs.c:1212:                      d_delete(d);

We are talking about the *upper* layer; that excludes most of those
guys.  At the very least, you want that fs to support rename and xattrs.
So hypfs, infinibarf ones, gadgetfs, configfs, debugfs, devpts, efivarfs,
sunrpc and selinuxfs are right out.  Moreover, all of those are not in
the codepaths reachable from overlayfs - all of that is removal of
object driven by external event.  And we end up using a reference other
than what overlayfs would be holding.  The same goes for reiserfs
xattr code (it calls d_delete() for references it has acquired itself)
and for ocfs2.  NFS is also not an option for upper layer, according to
overlayfs docs.  FUSE is in the same boat as ocfs2 and reiserfs - we acquire
the reference by d_lookup() in the same function.  The same goes for
btrfs caller (s/d_lookup/lookup_one_len/), not to mention that this code
won't be called by overlayfs.  What's left?

fs/ceph/dir.c:893:              d_delete(dentry);
ceph_unlink().

fs/ceph/inode.c:1114:                           d_delete(dn);
ceph_fill_trace(), dn comes from d_lookup().  Not an issue.

fs/ceph/inode.c:1395:                   d_delete(dn);
ceph_readdir_prepopulate(), dn comes from d_lookup().  Not an issue.

fs/ceph/inode.c:1223:                           d_delete(dn);
ceph_fill_trace(), again.  Hell knows - it's really hard to read ;-/

fs/namei.c:3586:                d_delete(dentry);
vfs_rmdir()

fs/namei.c:3702:                d_delete(dentry);
vfs_unlink()

Now, ceph_unlink() can come only from vfs_unlink().  So we are down to
the following: victim of vfs_unlink(), victim of vfs_rmdir(), _maybe_
something strange coming from that ceph_fill_trace() callsite.

We definitely do have vfs_unlink() and vfs_rmdir() calls in overlayfs.
Not many, though - there's ovl_remove_upper(), calling them directly,
and there's ovl_cleanup(), calling them via ovl_do_{unlink,rmdir}()
wrappers.  For one thing, we could do dget()/dput() in both of those guys.
However, looking at the callers of ovl_cleanup() shows that with two
exceptions we have already grabbed/dropped dentry around the callsite.
Exceptions are ovl_clear_empty() and ovl_remove_and_whiteout().
Could as well put that dget()/dput() in those two, rather than in
ovl_clear_empty()...

IOW, modulo that ceph thing we could trivially avoid that double reference
to ->__upperdentry, just by doing a temporary dget()/dput() in a few
places in fs/overlayfs/dir.c.  Objections?  A bunch of code becomes simpler
that way, IMO...

Question to Sage: what's that d_delete() in ceph_fill_trace() about?
It's this bit:
                /* null dentry? */
                if (!rinfo->head->is_target) {
                        dout("fill_trace null dentry\n");
                        if (dn->d_inode) {
                                dout("d_delete %p\n", dn);
                                d_delete(dn);
                        } else {
                                dout("d_instantiate %p NULL\n", dn);
                                d_instantiate(dn, NULL);
                                if (have_lease && d_unhashed(dn))
                                        d_rehash(dn);
                                update_dentry_lease(dn, rinfo->dlease,
                                                    session,
                                                    req->r_request_started);
                        }
                        goto done;
                }
What codepaths could lead us there and where could that dentry have come
from?  Overlayfs aside, the things can get rather interesting if it could,
e.g. turn out to be an existing mountpoint...


----------
From: David Howells <dhowells@redhat.com>
Date: Sun, 19 Oct 2014 at 11:32
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: <dhowells@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Linus
Torvalds <torvalds@linux-foundation.org>, <mszeredi@suse.cz>


Al Viro <viro@ZenIV.linux.org.uk> wrote:

> David, could you give a braindump on selinux issues?  I hadn't watched your
> conversation with Ian closely, so I'd rather avoid doing second-hand
> retelling...

The problem boils down to this: When they fall through from the top layer to a
lower source layer, Overlayfs and unionmount both set up struct file to point
directly to the file in the lower layer.  This is then passed to various
security_xxx() functions.

For labelled-inode-based LSM's this means they see the label on the lower
inode, not the label on the overlay/union inode - indeed in unionmount, there
*is* no upper/union inode.

Overlayfs is more complicated than unionmount in that there are three layers
and it falls through from the overlay layer to the upper layer (ie. the change
stash) too.  In this case also the overlay inode is unavailable to the LSM.

Unionmount mitigates the lower-layer label problem by pointing file->f_path at
the union dentry and file->f_inode at the lower inode (and
file->f_path->dentry->d_fallthru at the lower dentry).

Further, unionmount has no upper layer problem since the changes are stored in
the union layer itself.


Having discussed this with various people in the context of docker, a tentative
consensus has been reached:

 (1) The docker source tree (ie. the lower layer) will all be under a single
     label.

 (2) The docker root (ie. the overlay/union layer) will all be under a single,
     but different label set on the overlay mount (and each docker root may be
     under its own label).

 (3) Inodes in the overlayfs upper layer will be given the overlay label.

 (4) A security_copy_up() operation will be provided to set the label on the
     upper inode when it is created.

 (5) A security_copy_up_xattr() operation will be provided to vet (and maybe
     modify) each xattr as it is copied up.

 (6) An extra label slot will be placed in struct file_security_struct to hold
     the overlay label.

 (7) security_file_open() will need to be given both the overlay and lower
     dentries.

     For overlayfs, the way this probably should be done is file->f_path should
     be set to point to the overlay dentry (thus getting /proc right) and
     file->f_inode to the lower file and make use of d_fallthru in the overlay
     dentry in common with unionmount.

 (8) When the lower file is accessed, both the lower and overlay labels should
     be checked and audited.

 (9) When the upper file is accessed, only the overlay label needs to be
     checked and audited.

David


----------
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Mon, 20 Oct 2014 at 17:47
To: David Howells <dhowells@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds
<torvalds@linux-foundation.org>, <mszeredi@suse.cz>


On Sun, Oct 19, 2014 at 10:31:52AM +0100, David Howells wrote:

>      For overlayfs, the way this probably should be done is file->f_path should
>      be set to point to the overlay dentry (thus getting /proc right) and
>      file->f_inode to the lower file and make use of d_fallthru in the overlay
>      dentry in common with unionmount.

To elaborate a bit: a _lot_ of places in filesystems that used to use
->f_path.dentry->d_inode had been eliminated in favour of file_inode(...)
and all the remaining ones ought to follow.  With that done (I was actually
planning to do whack-a-mole session on those guys after most of this cycle
merges would be done - Linus, would you accept that in -rc2?) we get
surprisingly few places that even look at ->f_path.dentry.

Some of those are refering to ->d_name; we need to review those for other
reasons (potential rename() races), but for unionmount/overlayfs purposes
we couldn't care less which of dentries is used - both overlayfs and
underlying fs dentry have the same name.  FWIW, a bunch of uses are in
printks, and those should become %pD...

A bunch of places uses ->f_path.dentry->d_sb to get the superblock by
file; file_inode()->i_sb would do just fine in filesystems.  And places
like that *outside* of filesystems need a bit of review - the question is
which superblock do we want?  That of overlayfs or that of the layer?
The latter would be file_inode()->i_sb, again.  The former would be a problem
with overlayfs in its current form; with leaving f_path to point to overlayfs
it would work fine.

dir_emit_dot() and dir_emit_dotdot() use ->f_path.dentry, but those are not
problem - overlayfs explicitly opens directory in a layer.

AFAICS, nothing of what remains is on paths hot enough to really care about
an extra dereference.  So I think that after the dust from cleanups settles,
we'll be able to add an inlined helper usable for accesses to file's dentries,
and ban open-coded ->f_path.dentry in filesystems.


----------
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed, 22 Oct 2014 at 05:36
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, <mszeredi@suse.cz>


On Fri, Oct 17, 2014 at 05:30:52PM +0200, Miklos Szeredi wrote:

> Will do patches ASAP (which probably means next week) for all but having proper
> d_path() on the leaves.

Ping?  d_path() will obviously have to wait (my preference would be to leave
proper overlayfs dentry in ->f_path.dentry, set ->f_inode to one from the
layer and make sure that all filesystem code will DTRT; we are *very* close
to that already), but that's
        a) doable after the thing went in (it's not that much rewrite and
VFS-side it will probably just mean death to ->dentry_open() - sure, it's
not nice to put the method in just for one cycle, but it's not particulary
tragic, especially if it's clearly marked as "it's going away very soon,
do not rely on it") and
        b) is next cycle fodder

The same goes for the weirdness with double dget() on __upperdentry - it's
absolutely self-contained and we can deal with it later.  I would obviously
prefer fewer odd warts when it goes in, but this one isn't a bug per se.

rmdir() failure, OTOH, is one.  So's the memory footprint of cached
union of directories, seeing that every struct file over a directory
gets a copy of its own.  So's accepting layers with non-trivial ->d_revalidate,
->d_compare, ->d_hash, ->d_automount and ->d_manage.

The interim branch is in vfs.git#ovl-experimental; do you want me to post it
as-is same way you posted previous iterations?

Another thing: one more mail in that thread had bounced from google
mailsewers.  This time it claimed that delivery to Linus has failed.
I've no idea if they report all addresses; I've put the bounce message on
ftp.linux.org.uk/pub/viro/bounced2.  I really wonder what's going on
with those filters...


----------
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Oct 2014 at 10:12
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, <mszeredi@suse.cz>


On Wed, Oct 22, 2014 at 04:35:58AM +0100, Al Viro wrote:
> On Fri, Oct 17, 2014 at 05:30:52PM +0200, Miklos Szeredi wrote:
>
> > Will do patches ASAP (which probably means next week) for all but having proper
> > d_path() on the leaves.
>
> Ping?  d_path() will obviously have to wait (my preference would be to leave
> proper overlayfs dentry in ->f_path.dentry, set ->f_inode to one from the
> layer and make sure that all filesystem code will DTRT; we are *very* close
> to that already), but that's
>       a) doable after the thing went in (it's not that much rewrite and
> VFS-side it will probably just mean death to ->dentry_open() - sure, it's
> not nice to put the method in just for one cycle, but it's not particulary
> tragic, especially if it's clearly marked as "it's going away very soon,
> do not rely on it") and
>       b) is next cycle fodder
>
> The same goes for the weirdness with double dget() on __upperdentry - it's
> absolutely self-contained and we can deal with it later.

Done, but not terribly urgent for me either.

>  I would obviously
> prefer fewer odd warts when it goes in, but this one isn't a bug per se.
>
> rmdir() failure, OTOH, is one.

I looked at this, and found no bug: it does raise CAP_DAC_OVERRIDE in both
callers (ovl_do_remove() and ovl_rename2()).

>  So's the memory footprint of cached
> union of directories, seeing that every struct file over a directory
> gets a copy of its own.

Done, at the cost of 100 or so extra lines *and* is still DoS-able if the
directory is changed between reading it from the different file instances.

I've been poring over this last night, and the proper solution would be to
update the cache as it changes, so we have only one cache.  Not hard to do
conceptually, but not a small change either.

I'm wondering if it's OK to get i_mutex in ->release().  It would simplify the
locking...

>  So's accepting layers with non-trivial ->d_revalidate,
> ->d_compare, ->d_hash, ->d_automount and ->d_manage.

Done.

Also moved notify_change() into copy-up for setattr, so the attribute update is
atomic.

And a few other cleanups and fixes.

Updated the overlayfs.current branch here:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
overlayfs.current

Thanks,
Miklos

