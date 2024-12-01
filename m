Return-Path: <linux-fsdevel+bounces-36198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1FE9DF58F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 13:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84603B21AFE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B6E1B6CF2;
	Sun,  1 Dec 2024 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxurlaju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A61B5ED2;
	Sun,  1 Dec 2024 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733057071; cv=none; b=dKzX9zPVah12dHiM7kaY167y1z4r50R82B6s+by/4oksqhsP/a8D9XslakftsaRQ4JLpkZA5rPOOqJb2ZiQ8LqZivgmMmtODLzyCeoB+1WfuB/q8BbqIbyWGtDFIBoirVgzz1DClZmSlv/vnyWODKQfkdTa+nAo35y6Y32DX634=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733057071; c=relaxed/simple;
	bh=nQhuu5MfVqbZIpR7AYSOP+J9kx/Y1gcr7gzCBGZE8B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW2zWAldKWdPUwWoskcfMJ5cnx7FZT3ZIjzpz24gK8Dm3yIaSIr5eSC2tyvSfgQJzPgvtIsjyNraJowRw2LsudzrKlMK9bUxAU90F8I/9J51MtxPF6G2eESf/4dZhoNvDxRr/7FqqKwrLR70YG0GynYUJBVgdk8Hf2VVeItPz3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxurlaju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890BCC4CED2;
	Sun,  1 Dec 2024 12:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733057071;
	bh=nQhuu5MfVqbZIpR7AYSOP+J9kx/Y1gcr7gzCBGZE8B8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxurlajuwmmgABTrDYYkcmKxJ2EHc6tLaPaxFDIGYfJnT3ATi653kH01JIsWGCOWM
	 mg9/xxJJoKztb5i1ys/lrrj+hpato7zmeuQNxE5zlglOGaX8rC630tlITYajetJJVr
	 vmwrifTpZOlDEYcPEd3DHqkeICY8k1Q9qgfBO+UYGz94R8qCjcmL/r/NV9NX7T7qyo
	 3N4l5PwAdWG7yq+kjR20t52fH5Ipey3v1gwcCuH9n2vi/2SSxg22MI/+D502Zqj+hS
	 mJZFD4NXnUMchte1HyeQ48V/87uXn3TqrYSsZIjlhUYUst/Bh2fTQVSkfRh6zBN7UR
	 13aDGr9g7Bdgw==
Date: Sun, 1 Dec 2024 13:44:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Erin Shepherd <erin.shepherd@e43.eu>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH RFC 0/6] pidfs: implement file handle support
Message-ID: <20241201-mehreinnahmen-unehrlich-3a980ecbdfdc@brauner>
References: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org>
 <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
 <CAOQ4uxhKVkaWm_Vv=0zsytmvT0jCq1pZ84dmrQ_buhxXi2KEhw@mail.gmail.com>
 <20241130-witzbold-beiwagen-9b14358b7b17@brauner>
 <CAOQ4uxh2yfa_OeUYgrxc6nZqyZF4edx3pswPJkHPh5x=KOzj8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh2yfa_OeUYgrxc6nZqyZF4edx3pswPJkHPh5x=KOzj8w@mail.gmail.com>

On Sun, Dec 01, 2024 at 01:09:17PM +0100, Amir Goldstein wrote:
> On Sun, Dec 1, 2024 at 9:43 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Sat, Nov 30, 2024 at 01:22:05PM +0100, Amir Goldstein wrote:
> > > On Fri, Nov 29, 2024 at 2:39 PM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > Hey,
> > > >
> > > > Now that we have the preliminaries to lookup struct pid based on its
> > > > inode number alone we can implement file handle support.
> > > >
> > > > This is based on custom export operation methods which allows pidfs to
> > > > implement permission checking and opening of pidfs file handles cleanly
> > > > without hacking around in the core file handle code too much.
> > > >
> > > > This is lightly tested.
> > >
> > > With my comments addressed as you pushed to vfs-6.14.pidfs branch
> > > in your tree, you may add to the patches posted:
> > >
> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > HOWEVER,
> > > IMO there is still one thing that has to be addressed before merge -
> > > We must make sure that nfsd cannot export pidfs.
> > >
> > > In principal, SB_NOUSER filesystems should not be accessible to
> > > userspace paths, so exportfs should not be able to configure nfsd
> > > export of pidfs, but maybe this limitation can be worked around by
> > > using magic link paths?
> >
> > I don't see how. I might be missing details.
> 
> AFAIK, nfsd gets the paths to export from userspace via
> svc_export_parse() =>  kern_path(buf, 0, &exp.ex_path)
> afterwards check_export() validates exp.ex_path and I see that regular
> files can be exported.
> I suppose that a pidfs file can have a magic link path no?
> The question is whether this magic link path could be passed to nfsd
> via the exportfs UAPI.

Ah, ok. I see what you mean. You're thinking about specifying
/proc/<pid>/fd/<pidfd> in /etc/exports. Yes, that would work.

> 
> >
> > > I think it may be worth explicitly disallowing nfsd export of SB_NOUSER
> > > filesystems and we could also consider blocking SB_KERNMOUNT,
> > > but may there are users exporting ramfs?
> >
> > No need to restrict it if it's safe, I guess.
> >
> > > Jeff has mentioned that he thinks we are blocking export of cgroupfs
> > > by nfsd, but I really don't see where that is being enforced.
> > > The requirement for FS_REQUIRES_DEV in check_export() is weak
> > > because user can overrule it with manual fsid argument to exportfs.
> > > So maybe we disallow nfsd export of kernfs and backport to stable kernels
> > > to be on the safe side?
> >
> > File handles and nfs export have become two distinct things and there
> > filesystems based on kernfs, and pidfs want to support file handles
> > without support nfs export.
> >
> > So I think instead of having nfs check what filesystems may be exported
> > we should let the filesystems indicate that they cannot be exported and
> > make nfs honour that.
> 
> Yes, I agree, but...
> 
> >
> > So something like the untested sketch:
> >
> > diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> > index 1358c21837f1..a5c75cb1c812 100644
> > --- a/fs/kernfs/mount.c
> > +++ b/fs/kernfs/mount.c
> > @@ -154,6 +154,7 @@ static const struct export_operations kernfs_export_ops = {
> >         .fh_to_dentry   = kernfs_fh_to_dentry,
> >         .fh_to_parent   = kernfs_fh_to_parent,
> >         .get_parent     = kernfs_get_parent_dentry,
> > +       .flags          = EXPORT_OP_FILE_HANDLE,
> >  };
> >
> >  /**
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index eacafe46e3b6..170c5729e7f2 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -417,6 +417,7 @@ static struct svc_export *svc_export_lookup(struct svc_export *);
> >  static int check_export(struct path *path, int *flags, unsigned char *uuid)
> >  {
> >         struct inode *inode = d_inode(path->dentry);
> > +       const struct export_operations *nop;
> >
> >         /*
> >          * We currently export only dirs, regular files, and (for v4
> > @@ -449,11 +450,16 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
> >                 return -EINVAL;
> >         }
> >
> > -       if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
> > +       if (!exportfs_can_decode_fh(nop)) {
> >                 dprintk("exp_export: export of invalid fs type.\n");
> >                 return -EINVAL;
> >         }
> >
> > +       if (nop && nop->flags & EXPORT_OP_FILE_HANDLE) {
> > +               dprintk("exp_export: filesystem only supports non-exportable file handles.\n");
> > +               return -EINVAL;
> > +       }
> > +
> >         if (is_idmapped_mnt(path->mnt)) {
> >                 dprintk("exp_export: export of idmapped mounts not yet supported.\n");
> >                 return -EINVAL;
> > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > index 9aa7493b1e10..d1646c0789e1 100644
> > --- a/fs/overlayfs/util.c
> > +++ b/fs/overlayfs/util.c
> > @@ -83,10 +83,15 @@ void ovl_revert_creds(const struct cred *old_cred)
> >   */
> >  int ovl_can_decode_fh(struct super_block *sb)
> >  {
> > +       const struct export_operations *nop = sb->s_export_op;
> > +
> >         if (!capable(CAP_DAC_READ_SEARCH))
> >                 return 0;
> >
> > -       if (!exportfs_can_decode_fh(sb->s_export_op))
> > +       if (!exportfs_can_decode_fh(nop))
> > +               return 0;
> > +
> > +       if (nop && nop->flags & EXPORT_OP_FILE_HANDLE)
> >                 return 0;
> >
> >         return sb->s_export_op->encode_fh ? -1 : FILEID_INO32_GEN;
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index dde3e4e90ea9..9d98b5461dc7 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -570,6 +570,7 @@ static const struct export_operations pidfs_export_operations = {
> >         .fh_to_dentry   = pidfs_fh_to_dentry,
> >         .open           = pidfs_export_open,
> >         .permission     = pidfs_export_permission,
> > +       .flags          = EXPORT_OP_FILE_HANDLE,
> >  };
> >
> >  static int pidfs_init_inode(struct inode *inode, void *data)
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index a087606ace19..98f7cb17abee 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -280,6 +280,7 @@ struct export_operations {
> >                                                 */
> >  #define EXPORT_OP_FLUSH_ON_CLOSE       (0x20) /* fs flushes file data on close */
> >  #define EXPORT_OP_ASYNC_LOCK           (0x40) /* fs can do async lock request */
> > +#define EXPORT_OP_FILE_HANDLE          (0x80) /* fs only supports file handles, no proper export */
> 
> This is a bad name IMO, since pidfs clearly does support file handles
> and supports the open_by_handle_at() UAPI.
> 
> I was going to suggest EXPORT_OP_NO_NFS_EXPORT, but it also
> sounds silly, so maybe:
> 
> #define EXPORT_OP_LOCAL_FILE_HANDLE          (0x80) /* fs only
> supports local file handles, no nfs export */

Thank you. I'll send a reply with a proper patch to this thread in a second.

> With that you may add:
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> Thanks,
> Amir.

