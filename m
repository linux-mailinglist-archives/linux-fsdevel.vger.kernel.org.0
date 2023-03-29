Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6D26CF3E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 21:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjC2T7c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 15:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjC2T73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:59:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB394200;
        Wed, 29 Mar 2023 12:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1497861E1C;
        Wed, 29 Mar 2023 19:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D76C433EF;
        Wed, 29 Mar 2023 19:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680119963;
        bh=BtOV4QdXmU08zsLjDDS5jE8dORnvn4vpQ4oN4Na//R0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g/PATMuGn6dXpfHDdW1EOewhl1x5PDT+IQ1sXYfld01M5k7vlSw0MNp+N9o4Z9//k
         XZnH8xaNrO9A6+B9cw98wgtJUUD0o5U2gdr25NGH63HmrHd3u3O/8CZZxc7OSeRaXp
         0jUnQB8T/aZ4AFyNM9nAXwUWuEYag8FBY0ItB+H/t+XBz9hWHdfUCVM3EOOIlw+1SF
         axwBMkRtonQBiTG3J+h5BopUruTV9iVTWvuzUWeTRrUsNC/N98PVd1fExUlmJsCM5E
         jLCdDy95J5H03XtuOOv9CrldJMPY+4JfzCzBoJhb/JePK9osLJB7hPcLgI43jjI2kR
         5GmhIw3P63xZg==
Message-ID: <e3fb27ce8709c6c6d4d35740fe35b0e9e7a70781.camel@kernel.org>
Subject: Re: [PATCH] consolidate dt_type() helper definitions
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Date:   Wed, 29 Mar 2023 15:59:20 -0400
In-Reply-To: <EE203446-8614-4FE5-8776-0C97D3B72B6A@oracle.com>
References: <20230329192425.194793-1-jlayton@kernel.org>
         <EE203446-8614-4FE5-8776-0C97D3B72B6A@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-03-29 at 19:29 +0000, Chuck Lever III wrote:
>=20
> > On Mar 29, 2023, at 3:24 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > There are 4 functions named dt_type() in the kernel. Consolidate the 3
> > that are basically identical into one helper function in fs.h that
> > takes a umode_t argument. The v9fs helper is renamed to distinguish it
> > from the others.
> >=20
> > Cc: Chuck Lever <chuck.lever@oracle.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>=20
> One (non-blocking) comment below.
>=20
>=20
> > ---
> > fs/9p/vfs_dir.c    | 6 +++---
> > fs/configfs/dir.c  | 8 +-------
> > fs/kernfs/dir.c    | 8 +-------
> > fs/libfs.c         | 9 ++-------
> > include/linux/fs.h | 6 ++++++
> > 5 files changed, 13 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> > index 3d74b04fe0de..80b331f7f446 100644
> > --- a/fs/9p/vfs_dir.c
> > +++ b/fs/9p/vfs_dir.c
> > @@ -41,12 +41,12 @@ struct p9_rdir {
> > };
> >=20
> > /**
> > - * dt_type - return file type
> > + * v9fs_dt_type - return file type
> >  * @mistat: mistat structure
> >  *
> >  */
> >=20
> > -static inline int dt_type(struct p9_wstat *mistat)
> > +static inline int v9fs_dt_type(struct p9_wstat *mistat)
> > {
> > 	unsigned long perm =3D mistat->mode;
> > 	int rettype =3D DT_REG;
> > @@ -128,7 +128,7 @@ static int v9fs_dir_readdir(struct file *file, stru=
ct dir_context *ctx)
> > 			}
> >=20
> > 			over =3D !dir_emit(ctx, st.name, strlen(st.name),
> > -					 v9fs_qid2ino(&st.qid), dt_type(&st));
> > +					 v9fs_qid2ino(&st.qid), v9fs_dt_type(&st));
> > 			p9stat_free(&st);
> > 			if (over)
> > 				return 0;
> > diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> > index 4afcbbe63e68..43863a1696eb 100644
> > --- a/fs/configfs/dir.c
> > +++ b/fs/configfs/dir.c
> > @@ -1599,12 +1599,6 @@ static int configfs_dir_close(struct inode *inod=
e, struct file *file)
> > 	return 0;
> > }
> >=20
> > -/* Relationship between s_mode and the DT_xxx types */
> > -static inline unsigned char dt_type(struct configfs_dirent *sd)
> > -{
> > -	return (sd->s_mode >> 12) & 15;
> > -}
> > -
> > static int configfs_readdir(struct file *file, struct dir_context *ctx)
> > {
> > 	struct dentry *dentry =3D file->f_path.dentry;
> > @@ -1654,7 +1648,7 @@ static int configfs_readdir(struct file *file, st=
ruct dir_context *ctx)
> > 		name =3D configfs_get_name(next);
> > 		len =3D strlen(name);
> >=20
> > -		if (!dir_emit(ctx, name, len, ino, dt_type(next)))
> > +		if (!dir_emit(ctx, name, len, ino, dt_type(next->s_mode)))
> > 			return 0;
> >=20
> > 		spin_lock(&configfs_dirent_lock);
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index ef00b5fe8cee..0b7e9b8ee93e 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -1748,12 +1748,6 @@ int kernfs_rename_ns(struct kernfs_node *kn, str=
uct kernfs_node *new_parent,
> > 	return error;
> > }
> >=20
> > -/* Relationship between mode and the DT_xxx types */
> > -static inline unsigned char dt_type(struct kernfs_node *kn)
> > -{
> > -	return (kn->mode >> 12) & 15;
> > -}
> > -
> > static int kernfs_dir_fop_release(struct inode *inode, struct file *fil=
p)
> > {
> > 	kernfs_put(filp->private_data);
> > @@ -1831,7 +1825,7 @@ static int kernfs_fop_readdir(struct file *file, =
struct dir_context *ctx)
> > 	     pos;
> > 	     pos =3D kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
> > 		const char *name =3D pos->name;
> > -		unsigned int type =3D dt_type(pos);
> > +		unsigned int type =3D dt_type(pos->mode);
> > 		int len =3D strlen(name);
> > 		ino_t ino =3D kernfs_ino(pos);
> >=20
> > diff --git a/fs/libfs.c b/fs/libfs.c
> > index 4eda519c3002..d0f0cdae9ff7 100644
> > --- a/fs/libfs.c
> > +++ b/fs/libfs.c
> > @@ -174,12 +174,6 @@ loff_t dcache_dir_lseek(struct file *file, loff_t =
offset, int whence)
> > }
> > EXPORT_SYMBOL(dcache_dir_lseek);
> >=20
> > -/* Relationship between i_mode and the DT_xxx types */
> > -static inline unsigned char dt_type(struct inode *inode)
> > -{
> > -	return (inode->i_mode >> 12) & 15;
> > -}
> > -
> > /*
> >  * Directory is locked and all positive dentries in it are safe, since
> >  * for ramfs-type trees they can't go away without unlink() or rmdir(),
> > @@ -206,7 +200,8 @@ int dcache_readdir(struct file *file, struct dir_co=
ntext *ctx)
> >=20
> > 	while ((next =3D scan_positives(cursor, p, 1, next)) !=3D NULL) {
> > 		if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
> > -			      d_inode(next)->i_ino, dt_type(d_inode(next))))
> > +			      d_inode(next)->i_ino,
> > +			      dt_type(d_inode(next)->i_mode)))
> > 			break;
> > 		ctx->pos++;
> > 		p =3D &next->d_child;
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index c85916e9f7db..777a3641fc5d 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2885,6 +2885,12 @@ extern void iterate_supers(void (*)(struct super=
_block *, void *), void *);
> > extern void iterate_supers_type(struct file_system_type *,
> > 			        void (*)(struct super_block *, void *), void *);
> >=20
> > +/* Relationship between i_mode and the DT_xxx types */
> > +static inline unsigned char dt_type(umode_t mode)
> > +{
> > +	return (mode >> 12) & 15;
>=20
> Was wondering if there are appropriate symbolic constants
> that could be used instead of naked integers? NBD if not.
>=20

If there is a way to express that with well-known constants, I don't
know it. It looks like Linus added this to libfs.c back in 2002 (from
linux-fullhistory tree):

commit a12662634bf285a5350a2106301e754652875d2f
Author: Linus Torvalds <torvalds@home.transmeta.com>
Date:   Tue Jul 2 01:37:41 2002 -0700

    Make ramfs/driverfs maintain directory nlink counts.
   =20
    Make dcache filesystems export directory entry types
    to readdir.

Linus, are there symbolic constants that you know of that we could use
here instead?


>=20
> > +}
> > +
> > extern int dcache_dir_open(struct inode *, struct file *);
> > extern int dcache_dir_close(struct inode *, struct file *);
> > extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
> > --=20
> > 2.39.2
> >=20
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
