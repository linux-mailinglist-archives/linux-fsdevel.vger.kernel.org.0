Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44F6301F2E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Jan 2021 23:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbhAXWTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Jan 2021 17:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbhAXWTg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Jan 2021 17:19:36 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E041C061573;
        Sun, 24 Jan 2021 14:18:56 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5BB366F0B; Sun, 24 Jan 2021 17:18:54 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5BB366F0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611526734;
        bh=+WeIqs20uLR2t89mwWhzLJ7HD1CUH+AoqxAA94UkyAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3knNZXlNMSdp0ZFF271zh05uh8dHtzIU5n+EpzP+DShDIuwCv24ngiDLH3dX2iVG
         Q+/8hT7i78v4LjbweP0IxzBfSSQzshrnzEr/vDeCGI1IjRI4h2ck9ommwbgtFT/5jF
         XuegkZX7zWCzW/QKQGrcLiSurCj4zEDOFTsYQn2c=
Date:   Sun, 24 Jan 2021 17:18:54 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
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
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v6 05/39] namei: make permission helpers idmapped mount
 aware
Message-ID: <20210124221854.GA1487@fieldses.org>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
 <20210121131959.646623-6-christian.brauner@ubuntu.com>
 <20210122222632.GB25405@fieldses.org>
 <20210123130958.3t6kvgkl634njpsm@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123130958.3t6kvgkl634njpsm@wittgenstein>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 23, 2021 at 02:09:58PM +0100, Christian Brauner wrote:
> On Fri, Jan 22, 2021 at 05:26:32PM -0500, J. Bruce Fields wrote:
> > If I NFS-exported an idmapped mount, I think I'd expect idmapped clients
> > to see the mapped IDs.
> > 
> > Looks like that means taking the user namespace from the struct
> > svc_export everwhere, for example:
> > 
> > On Thu, Jan 21, 2021 at 02:19:24PM +0100, Christian Brauner wrote:
> > > index 66f2ef67792a..8d90796e236a 100644
> > > --- a/fs/nfsd/nfsfh.c
> > > +++ b/fs/nfsd/nfsfh.c
> > > @@ -40,7 +40,8 @@ static int nfsd_acceptable(void *expv, struct dentry *dentry)
> > >  		/* make sure parents give x permission to user */
> > >  		int err;
> > >  		parent = dget_parent(tdentry);
> > > -		err = inode_permission(d_inode(parent), MAY_EXEC);
> > > +		err = inode_permission(&init_user_ns,
> > > +				       d_inode(parent), MAY_EXEC);
> > 
> > 		err = inode_permission(exp->ex_path.mnt->mnt_userns,
> > 				      d_inode(parent, MAY_EXEC);
> 
> Hey Bruce, thanks! Imho, the clean approach for now is to not export
> idmapped mounts until we have ported that part of nfs similar to what we
> do for stacking filesystems for now. I've tested and taken this patch
> into my tree:

Oh good, thanks.  My real fear was that we'd fix this up later and leave
users in a situation where the server exposes different IDs depending on
kernel version, which would be a mess.  Looks like this should avoid
that.

As for making idmapped mounts actually work with nfsd--are you planning
to do that, or do you need me to?  I hope the patch is straightforward;
I'm more worried testing it.

--b.

> 
> ---
> >From 7a6a53bca1ecd8db872de1ee81d1a57e1829e525 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Sat, 23 Jan 2021 12:00:02 +0100
> Subject: [PATCH] nfs: do not export idmapped mounts
> 
> Prevent nfs from exporting idmapped mounts until we have ported it to
> support exporting idmapped mounts.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: David Howells <dhowells@redhat.com>
> Cc: "J. Bruce Fields" <bfields@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> 
> /* v3 */
> 
> /* v4 */
> 
> /* v5 */
> 
> /* v5 */
> patch introduced
> base-commit: 19c329f6808995b142b3966301f217c831e7cf31
> ---
>  fs/nfsd/export.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 81e7bb12aca6..e456421f68b4 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -369,8 +369,9 @@ static struct svc_export *svc_export_update(struct svc_export *new,
>  					    struct svc_export *old);
>  static struct svc_export *svc_export_lookup(struct svc_export *);
>  
> -static int check_export(struct inode *inode, int *flags, unsigned char *uuid)
> +static int check_export(struct path *path, int *flags, unsigned char *uuid)
>  {
> +	struct inode *inode = d_inode(path->dentry);
>  
>  	/*
>  	 * We currently export only dirs, regular files, and (for v4
> @@ -394,6 +395,7 @@ static int check_export(struct inode *inode, int *flags, unsigned char *uuid)
>  	 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
>  	 * 2:  We must be able to find an inode from a filehandle.
>  	 *       This means that s_export_op must be set.
> +	 * 3: We must not currently be on an idmapped mount.
>  	 */
>  	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
>  	    !(*flags & NFSEXP_FSID) &&
> @@ -408,6 +410,11 @@ static int check_export(struct inode *inode, int *flags, unsigned char *uuid)
>  		return -EINVAL;
>  	}
>  
> +	if (mnt_user_ns(path->mnt) != &init_user_ns) {
> +		dprintk("exp_export: export of idmapped mounts not yet supported.\n");
> +		return -EINVAL;
> +	}
> +
>  	if (inode->i_sb->s_export_op->flags & EXPORT_OP_NOSUBTREECHK &&
>  	    !(*flags & NFSEXP_NOSUBTREECHECK)) {
>  		dprintk("%s: %s does not support subtree checking!\n",
> @@ -636,8 +643,7 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
>  				goto out4;
>  		}
>  
> -		err = check_export(d_inode(exp.ex_path.dentry), &exp.ex_flags,
> -				   exp.ex_uuid);
> +		err = check_export(&exp.ex_path, &exp.ex_flags, exp.ex_uuid);
>  		if (err)
>  			goto out4;
>  		/*
> -- 
> 2.30.0
