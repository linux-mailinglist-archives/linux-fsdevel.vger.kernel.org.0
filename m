Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982DD749B71
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjGFMKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 08:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjGFMKm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:10:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C5F1FC1;
        Thu,  6 Jul 2023 05:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B5CE618F2;
        Thu,  6 Jul 2023 12:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11E9C433C9;
        Thu,  6 Jul 2023 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688645426;
        bh=oncNPSetGabHpTGypY8fF/NW++cFGCu6H76WVOyEv2c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HMao07/X48H+yKw3KMnj3Paf8p7/KBCgc9xdhhY3KVzmdr+jYbWAqHKPrp8PcBCcM
         UKfxz1oEgpHT8YXY3a1/0X8fIwn8QwIrEpJ0MGmKeWx+MuTtmdOkM5CkZo4G2P3ZUk
         guIlYCz34mVD2tsN/McaI9k3WzZ8OUacOSe3eBezXB7hrS9FcpqVHtqB7wlf8soinJ
         YO9pIWkvmTTEns4T7tX3+2iqRazZMqeTKoOrUX78VZMrSkj83r73mpnYvIuRVBQHzs
         agxtebMl+Ys2iMeSU7f/PaBo+6DkyqgaI/dftYiXPxXi22eSvnvoLCzLXZswehK6BC
         n4GVnjjVuIMjw==
Message-ID: <7f2bbca046f120d6dc6f64c22f94dafa0becace3.camel@kernel.org>
Subject: Re: [PATCH v2 78/92] ubifs: convert to ctime accessor functions
From:   Jeff Layton <jlayton@kernel.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Christian Brauner <brauner@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Date:   Thu, 06 Jul 2023 08:10:24 -0400
In-Reply-To: <13131dc7-c823-e65f-9bf0-4f8fe907e58b@huawei.com>
References: <20230705185755.579053-1-jlayton@kernel.org>
         <20230705190309.579783-1-jlayton@kernel.org>
         <20230705190309.579783-76-jlayton@kernel.org>
         <13131dc7-c823-e65f-9bf0-4f8fe907e58b@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-07-06 at 20:07 +0800, Zhihao Cheng wrote:
> =E5=9C=A8 2023/7/6 3:01, Jeff Layton =E5=86=99=E9=81=93:
> > In later patches, we're going to change how the inode's ctime field is
> > used. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/ubifs/debug.c   |  4 ++--
> >   fs/ubifs/dir.c     | 24 +++++++++++-------------
> >   fs/ubifs/file.c    | 16 +++++++++-------
> >   fs/ubifs/ioctl.c   |  2 +-
> >   fs/ubifs/journal.c |  4 ++--
> >   fs/ubifs/super.c   |  4 ++--
> >   fs/ubifs/xattr.c   |  6 +++---
> >   7 files changed, 30 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
> > index 9c9d3f0e36a4..eef9e527d9ff 100644
> > --- a/fs/ubifs/debug.c
> > +++ b/fs/ubifs/debug.c
> > @@ -243,8 +243,8 @@ void ubifs_dump_inode(struct ubifs_info *c, const s=
truct inode *inode)
> >   	       (unsigned int)inode->i_mtime.tv_sec,
> >   	       (unsigned int)inode->i_mtime.tv_nsec);
> >   	pr_err("\tctime          %u.%u\n",
> > -	       (unsigned int)inode->i_ctime.tv_sec,
> > -	       (unsigned int)inode->i_ctime.tv_nsec);
> > +	       (unsigned int) inode_get_ctime(inode).tv_sec,
> > +	       (unsigned int) inode_get_ctime(inode).tv_nsec);
> >   	pr_err("\tcreat_sqnum    %llu\n", ui->creat_sqnum);
> >   	pr_err("\txattr_size     %u\n", ui->xattr_size);
> >   	pr_err("\txattr_cnt      %u\n", ui->xattr_cnt);
> > diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> > index 7ec25310bd8a..3a1ba8ba308a 100644
> > --- a/fs/ubifs/dir.c
> > +++ b/fs/ubifs/dir.c
> > @@ -96,8 +96,7 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, s=
truct inode *dir,
> >   	inode->i_flags |=3D S_NOCMTIME;
> >  =20
> >   	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
> > -	inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =3D
> > -			 current_time(inode);
> > +	inode->i_mtime =3D inode->i_atime =3D inode_set_ctime_current(inode);
> >   	inode->i_mapping->nrpages =3D 0;
> >  =20
> >   	if (!is_xattr) {
> > @@ -325,7 +324,7 @@ static int ubifs_create(struct mnt_idmap *idmap, st=
ruct inode *dir,
> >   	mutex_lock(&dir_ui->ui_mutex);
> >   	dir->i_size +=3D sz_change;
> >   	dir_ui->ui_size =3D dir->i_size;
> > -	dir->i_mtime =3D dir->i_ctime =3D inode->i_ctime;
> > +	dir->i_mtime =3D inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
> >   	err =3D ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
> >   	if (err)
> >   		goto out_cancel;
> > @@ -765,10 +764,10 @@ static int ubifs_link(struct dentry *old_dentry, =
struct inode *dir,
> >  =20
> >   	inc_nlink(inode);
> >   	ihold(inode);
> > -	inode->i_ctime =3D current_time(inode);
> > +	inode_set_ctime_current(inode);
> >   	dir->i_size +=3D sz_change;
> >   	dir_ui->ui_size =3D dir->i_size;
> > -	dir->i_mtime =3D dir->i_ctime =3D inode->i_ctime;
> > +	dir->i_mtime =3D inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
> >   	err =3D ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
> >   	if (err)
> >   		goto out_cancel;
> > @@ -838,11 +837,11 @@ static int ubifs_unlink(struct inode *dir, struct=
 dentry *dentry)
> >   	}
> >  =20
> >   	lock_2_inodes(dir, inode);
> > -	inode->i_ctime =3D current_time(dir);
> > +	inode_set_ctime_current(inode);
> >   	drop_nlink(inode);
> >   	dir->i_size -=3D sz_change;
> >   	dir_ui->ui_size =3D dir->i_size;
> > -	dir->i_mtime =3D dir->i_ctime =3D inode->i_ctime;
> > +	dir->i_mtime =3D inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
> >   	err =3D ubifs_jnl_update(c, dir, &nm, inode, 1, 0);
> >   	if (err)
> >   		goto out_cancel;
> > @@ -940,12 +939,12 @@ static int ubifs_rmdir(struct inode *dir, struct =
dentry *dentry)
> >   	}
> >  =20
> >   	lock_2_inodes(dir, inode);
> > -	inode->i_ctime =3D current_time(dir);
> > +	inode_set_ctime_current(inode);
> >   	clear_nlink(inode);
> >   	drop_nlink(dir);
> >   	dir->i_size -=3D sz_change;
> >   	dir_ui->ui_size =3D dir->i_size;
> > -	dir->i_mtime =3D dir->i_ctime =3D inode->i_ctime;
> > +	dir->i_mtime =3D inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
> >   	err =3D ubifs_jnl_update(c, dir, &nm, inode, 1, 0);
> >   	if (err)
> >   		goto out_cancel;
> > @@ -1019,7 +1018,7 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, s=
truct inode *dir,
> >   	inc_nlink(dir);
> >   	dir->i_size +=3D sz_change;
> >   	dir_ui->ui_size =3D dir->i_size;
> > -	dir->i_mtime =3D dir->i_ctime =3D inode->i_ctime;
> > +	dir->i_mtime =3D inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
> >   	err =3D ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
> >   	if (err) {
> >   		ubifs_err(c, "cannot create directory, error %d", err);
> > @@ -1110,7 +1109,7 @@ static int ubifs_mknod(struct mnt_idmap *idmap, s=
truct inode *dir,
> >   	mutex_lock(&dir_ui->ui_mutex);
> >   	dir->i_size +=3D sz_change;
> >   	dir_ui->ui_size =3D dir->i_size;
> > -	dir->i_mtime =3D dir->i_ctime =3D inode->i_ctime;
> > +	dir->i_mtime =3D inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
> >   	err =3D ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
> >   	if (err)
> >   		goto out_cancel;
> > @@ -1210,7 +1209,7 @@ static int ubifs_symlink(struct mnt_idmap *idmap,=
 struct inode *dir,
> >   	mutex_lock(&dir_ui->ui_mutex);
> >   	dir->i_size +=3D sz_change;
> >   	dir_ui->ui_size =3D dir->i_size;
> > -	dir->i_mtime =3D dir->i_ctime =3D inode->i_ctime;
> > +	dir->i_mtime =3D inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
> >   	err =3D ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
> >   	if (err)
> >   		goto out_cancel;
> > @@ -1298,7 +1297,6 @@ static int do_rename(struct inode *old_dir, struc=
t dentry *old_dentry,
> >   	struct ubifs_budget_req ino_req =3D { .dirtied_ino =3D 1,
> >   			.dirtied_ino_d =3D ALIGN(old_inode_ui->data_len, 8) };
> >   	struct ubifs_budget_req wht_req;
> > -	struct timespec64 time;
> >   	unsigned int saved_nlink;
> >   	struct fscrypt_name old_nm, new_nm;
> >  =20
>=20
> It would be better to put the change of do_rename in '[PATCH v2 10/92]=
=20
> ubifs: convert to simple_rename_timestamp'.
>=20
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
>=20

Good catch. I'll fix that up in my tree.

Thanks!

> > diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> > index 6738fe43040b..436b27d7c58f 100644
> > --- a/fs/ubifs/file.c
> > +++ b/fs/ubifs/file.c
> > @@ -1092,7 +1092,7 @@ static void do_attr_changes(struct inode *inode, =
const struct iattr *attr)
> >   	if (attr->ia_valid & ATTR_MTIME)
> >   		inode->i_mtime =3D attr->ia_mtime;
> >   	if (attr->ia_valid & ATTR_CTIME)
> > -		inode->i_ctime =3D attr->ia_ctime;
> > +		inode_set_ctime_to_ts(inode, attr->ia_ctime);
> >   	if (attr->ia_valid & ATTR_MODE) {
> >   		umode_t mode =3D attr->ia_mode;
> >  =20
> > @@ -1192,7 +1192,7 @@ static int do_truncation(struct ubifs_info *c, st=
ruct inode *inode,
> >   	mutex_lock(&ui->ui_mutex);
> >   	ui->ui_size =3D inode->i_size;
> >   	/* Truncation changes inode [mc]time */
> > -	inode->i_mtime =3D inode->i_ctime =3D current_time(inode);
> > +	inode->i_mtime =3D inode_set_ctime_current(inode);
> >   	/* Other attributes may be changed at the same time as well */
> >   	do_attr_changes(inode, attr);
> >   	err =3D ubifs_jnl_truncate(c, inode, old_size, new_size);
> > @@ -1239,7 +1239,7 @@ static int do_setattr(struct ubifs_info *c, struc=
t inode *inode,
> >   	mutex_lock(&ui->ui_mutex);
> >   	if (attr->ia_valid & ATTR_SIZE) {
> >   		/* Truncation changes inode [mc]time */
> > -		inode->i_mtime =3D inode->i_ctime =3D current_time(inode);
> > +		inode->i_mtime =3D inode_set_ctime_current(inode);
> >   		/* 'truncate_setsize()' changed @i_size, update @ui_size */
> >   		ui->ui_size =3D inode->i_size;
> >   	}
> > @@ -1364,8 +1364,10 @@ int ubifs_fsync(struct file *file, loff_t start,=
 loff_t end, int datasync)
> >   static inline int mctime_update_needed(const struct inode *inode,
> >   				       const struct timespec64 *now)
> >   {
> > +	struct timespec64 ctime =3D inode_get_ctime(inode);
> > +
> >   	if (!timespec64_equal(&inode->i_mtime, now) ||
> > -	    !timespec64_equal(&inode->i_ctime, now))
> > +	    !timespec64_equal(&ctime, now))
> >   		return 1;
> >   	return 0;
> >   }
> > @@ -1396,7 +1398,7 @@ int ubifs_update_time(struct inode *inode, struct=
 timespec64 *time,
> >   	if (flags & S_ATIME)
> >   		inode->i_atime =3D *time;
> >   	if (flags & S_CTIME)
> > -		inode->i_ctime =3D *time;
> > +		inode_set_ctime_to_ts(inode, *time);
> >   	if (flags & S_MTIME)
> >   		inode->i_mtime =3D *time;
> >  =20
> > @@ -1432,7 +1434,7 @@ static int update_mctime(struct inode *inode)
> >   			return err;
> >  =20
> >   		mutex_lock(&ui->ui_mutex);
> > -		inode->i_mtime =3D inode->i_ctime =3D current_time(inode);
> > +		inode->i_mtime =3D inode_set_ctime_current(inode);
> >   		release =3D ui->dirty;
> >   		mark_inode_dirty_sync(inode);
> >   		mutex_unlock(&ui->ui_mutex);
> > @@ -1570,7 +1572,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm=
_fault *vmf)
> >   		struct ubifs_inode *ui =3D ubifs_inode(inode);
> >  =20
> >   		mutex_lock(&ui->ui_mutex);
> > -		inode->i_mtime =3D inode->i_ctime =3D current_time(inode);
> > +		inode->i_mtime =3D inode_set_ctime_current(inode);
> >   		release =3D ui->dirty;
> >   		mark_inode_dirty_sync(inode);
> >   		mutex_unlock(&ui->ui_mutex);
> > diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
> > index 67c5108abd89..d79cabe193c3 100644
> > --- a/fs/ubifs/ioctl.c
> > +++ b/fs/ubifs/ioctl.c
> > @@ -118,7 +118,7 @@ static int setflags(struct inode *inode, int flags)
> >   	ui->flags &=3D ~ioctl2ubifs(UBIFS_SETTABLE_IOCTL_FLAGS);
> >   	ui->flags |=3D ioctl2ubifs(flags);
> >   	ubifs_set_inode_flags(inode);
> > -	inode->i_ctime =3D current_time(inode);
> > +	inode_set_ctime_current(inode);
> >   	release =3D ui->dirty;
> >   	mark_inode_dirty_sync(inode);
> >   	mutex_unlock(&ui->ui_mutex);
> > diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> > index dc52ac0f4a34..ffc9beee7be6 100644
> > --- a/fs/ubifs/journal.c
> > +++ b/fs/ubifs/journal.c
> > @@ -454,8 +454,8 @@ static void pack_inode(struct ubifs_info *c, struct=
 ubifs_ino_node *ino,
> >   	ino->creat_sqnum =3D cpu_to_le64(ui->creat_sqnum);
> >   	ino->atime_sec  =3D cpu_to_le64(inode->i_atime.tv_sec);
> >   	ino->atime_nsec =3D cpu_to_le32(inode->i_atime.tv_nsec);
> > -	ino->ctime_sec  =3D cpu_to_le64(inode->i_ctime.tv_sec);
> > -	ino->ctime_nsec =3D cpu_to_le32(inode->i_ctime.tv_nsec);
> > +	ino->ctime_sec  =3D cpu_to_le64(inode_get_ctime(inode).tv_sec);
> > +	ino->ctime_nsec =3D cpu_to_le32(inode_get_ctime(inode).tv_nsec);
> >   	ino->mtime_sec  =3D cpu_to_le64(inode->i_mtime.tv_sec);
> >   	ino->mtime_nsec =3D cpu_to_le32(inode->i_mtime.tv_nsec);
> >   	ino->uid   =3D cpu_to_le32(i_uid_read(inode));
> > diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> > index 32cb14759796..b08fb28d16b5 100644
> > --- a/fs/ubifs/super.c
> > +++ b/fs/ubifs/super.c
> > @@ -146,8 +146,8 @@ struct inode *ubifs_iget(struct super_block *sb, un=
signed long inum)
> >   	inode->i_atime.tv_nsec =3D le32_to_cpu(ino->atime_nsec);
> >   	inode->i_mtime.tv_sec  =3D (int64_t)le64_to_cpu(ino->mtime_sec);
> >   	inode->i_mtime.tv_nsec =3D le32_to_cpu(ino->mtime_nsec);
> > -	inode->i_ctime.tv_sec  =3D (int64_t)le64_to_cpu(ino->ctime_sec);
> > -	inode->i_ctime.tv_nsec =3D le32_to_cpu(ino->ctime_nsec);
> > +	inode_set_ctime(inode, (int64_t)le64_to_cpu(ino->ctime_sec),
> > +			le32_to_cpu(ino->ctime_nsec));
> >   	inode->i_mode =3D le32_to_cpu(ino->mode);
> >   	inode->i_size =3D le64_to_cpu(ino->size);
> >  =20
> > diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> > index 349228dd1191..406c82eab513 100644
> > --- a/fs/ubifs/xattr.c
> > +++ b/fs/ubifs/xattr.c
> > @@ -134,7 +134,7 @@ static int create_xattr(struct ubifs_info *c, struc=
t inode *host,
> >   	ui->data_len =3D size;
> >  =20
> >   	mutex_lock(&host_ui->ui_mutex);
> > -	host->i_ctime =3D current_time(host);
> > +	inode_set_ctime_current(host);
> >   	host_ui->xattr_cnt +=3D 1;
> >   	host_ui->xattr_size +=3D CALC_DENT_SIZE(fname_len(nm));
> >   	host_ui->xattr_size +=3D CALC_XATTR_BYTES(size);
> > @@ -215,7 +215,7 @@ static int change_xattr(struct ubifs_info *c, struc=
t inode *host,
> >   	ui->data_len =3D size;
> >  =20
> >   	mutex_lock(&host_ui->ui_mutex);
> > -	host->i_ctime =3D current_time(host);
> > +	inode_set_ctime_current(host);
> >   	host_ui->xattr_size -=3D CALC_XATTR_BYTES(old_size);
> >   	host_ui->xattr_size +=3D CALC_XATTR_BYTES(size);
> >  =20
> > @@ -474,7 +474,7 @@ static int remove_xattr(struct ubifs_info *c, struc=
t inode *host,
> >   		return err;
> >  =20
> >   	mutex_lock(&host_ui->ui_mutex);
> > -	host->i_ctime =3D current_time(host);
> > +	inode_set_ctime_current(host);
> >   	host_ui->xattr_cnt -=3D 1;
> >   	host_ui->xattr_size -=3D CALC_DENT_SIZE(fname_len(nm));
> >   	host_ui->xattr_size -=3D CALC_XATTR_BYTES(ui->data_len);
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
