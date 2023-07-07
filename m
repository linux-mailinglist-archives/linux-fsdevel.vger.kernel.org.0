Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A72474AE85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 12:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjGGKIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 06:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjGGKHz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4738A210A;
        Fri,  7 Jul 2023 03:07:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DEF7618E6;
        Fri,  7 Jul 2023 10:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBE7C433C7;
        Fri,  7 Jul 2023 10:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688724467;
        bh=kzGPfVgAvaDeY9hWrtluqtk55LZVLbnfjmW+3X6ycmg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Mad+T2+9VvpKPErs4ByJnei/ja9o4eYk+/MLuPICXnw28+DG6llMZJeAxISdsnpcv
         h233C9v3a9Zy1NvMWXsGG+MWeYtzn+2kTHO52W4zUOzoKg1fZbhYYJEi/DDgjq6GX9
         Q6vARbt3c5UhAaCrWxD15W5hnYvs2DaLUiZiHlQuLRjicp/2ex3JU5r57jM9klD2KT
         xfWIMqgz6WdTENM4PupD8T/y5ka0+ebCLpaPDqBYcOy6S/fj9kWOEZIaANAEZnaPFJ
         ZE5hwsDpg3Lyxyj4wlacZX0+bZUVBfpT1kMvUdDqMKkmV6KmlBMDt9sis0Muq5gtEX
         an71zo5F/oq7g==
Message-ID: <4f7d791d516897e4b281a5bd3889e83ef7e2b52e.camel@kernel.org>
Subject: Re: [PATCH v2 62/92] ocfs2: convert to ctime accessor functions
From:   Jeff Layton <jlayton@kernel.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christian Brauner <brauner@kernel.org>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@lists.linux.dev
Date:   Fri, 07 Jul 2023 06:07:45 -0400
In-Reply-To: <2033ce6a-761e-b891-42e0-2659506eb61d@linux.alibaba.com>
References: <20230705185755.579053-1-jlayton@kernel.org>
         <20230705190309.579783-1-jlayton@kernel.org>
         <20230705190309.579783-60-jlayton@kernel.org>
         <2033ce6a-761e-b891-42e0-2659506eb61d@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-07-07 at 11:15 +0800, Joseph Qi wrote:
>=20
> On 7/6/23 3:01 AM, Jeff Layton wrote:
> > In later patches, we're going to change how the inode's ctime field is
> > used. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ocfs2/acl.c          |  6 +++---
> >  fs/ocfs2/alloc.c        |  6 +++---
> >  fs/ocfs2/aops.c         |  2 +-
> >  fs/ocfs2/dir.c          |  8 ++++----
> >  fs/ocfs2/dlmfs/dlmfs.c  |  4 ++--
> >  fs/ocfs2/dlmglue.c      |  7 +++++--
> >  fs/ocfs2/file.c         | 16 +++++++++-------
> >  fs/ocfs2/inode.c        | 12 ++++++------
> >  fs/ocfs2/move_extents.c |  6 +++---
> >  fs/ocfs2/namei.c        | 21 +++++++++++----------
> >  fs/ocfs2/refcounttree.c | 14 +++++++-------
> >  fs/ocfs2/xattr.c        |  6 +++---
> >  12 files changed, 57 insertions(+), 51 deletions(-)
> >=20
> > diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
> > index 9fd03eaf15f8..e75137a8e7cb 100644
> > --- a/fs/ocfs2/acl.c
> > +++ b/fs/ocfs2/acl.c
> > @@ -191,10 +191,10 @@ static int ocfs2_acl_set_mode(struct inode *inode=
, struct buffer_head *di_bh,
> >  	}
> > =20
> >  	inode->i_mode =3D new_mode;
> > -	inode->i_ctime =3D current_time(inode);
> > +	inode_set_ctime_current(inode);
> >  	di->i_mode =3D cpu_to_le16(inode->i_mode);
> > -	di->i_ctime =3D cpu_to_le64(inode->i_ctime.tv_sec);
> > -	di->i_ctime_nsec =3D cpu_to_le32(inode->i_ctime.tv_nsec);
> > +	di->i_ctime =3D cpu_to_le64(inode_get_ctime(inode).tv_sec);
> > +	di->i_ctime_nsec =3D cpu_to_le32(inode_get_ctime(inode).tv_nsec);
> >  	ocfs2_update_inode_fsync_trans(handle, inode, 0);
> > =20
> >  	ocfs2_journal_dirty(handle, di_bh);
> > diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> > index 51c93929a146..aef58f1395c8 100644
> > --- a/fs/ocfs2/alloc.c
> > +++ b/fs/ocfs2/alloc.c
> > @@ -7436,10 +7436,10 @@ int ocfs2_truncate_inline(struct inode *inode, =
struct buffer_head *di_bh,
> >  	}
> > =20
> >  	inode->i_blocks =3D ocfs2_inode_sector_count(inode);
> > -	inode->i_ctime =3D inode->i_mtime =3D current_time(inode);
> > +	inode->i_mtime =3D inode_set_ctime_current(inode);
> > =20
> > -	di->i_ctime =3D di->i_mtime =3D cpu_to_le64(inode->i_ctime.tv_sec);
> > -	di->i_ctime_nsec =3D di->i_mtime_nsec =3D cpu_to_le32(inode->i_ctime.=
tv_nsec);
> > +	di->i_ctime =3D di->i_mtime =3D cpu_to_le64(inode_get_ctime(inode).tv=
_sec);
> > +	di->i_ctime_nsec =3D di->i_mtime_nsec =3D cpu_to_le32(inode_get_ctime=
(inode).tv_nsec);
> > =20
> >  	ocfs2_update_inode_fsync_trans(handle, inode, 1);
> >  	ocfs2_journal_dirty(handle, di_bh);
> > diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> > index 8dfc284e85f0..0fdba30740ab 100644
> > --- a/fs/ocfs2/aops.c
> > +++ b/fs/ocfs2/aops.c
> > @@ -2048,7 +2048,7 @@ int ocfs2_write_end_nolock(struct address_space *=
mapping,
> >  		}
> >  		inode->i_blocks =3D ocfs2_inode_sector_count(inode);
> >  		di->i_size =3D cpu_to_le64((u64)i_size_read(inode));
> > -		inode->i_mtime =3D inode->i_ctime =3D current_time(inode);
> > +		inode->i_mtime =3D inode_set_ctime_current(inode);
> >  		di->i_mtime =3D di->i_ctime =3D cpu_to_le64(inode->i_mtime.tv_sec);
> >  		di->i_mtime_nsec =3D di->i_ctime_nsec =3D cpu_to_le32(inode->i_mtime=
.tv_nsec);
> >  		if (handle)
> > diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
> > index 694471fc46b8..8b123d543e6e 100644
> > --- a/fs/ocfs2/dir.c
> > +++ b/fs/ocfs2/dir.c
> > @@ -1658,7 +1658,7 @@ int __ocfs2_add_entry(handle_t *handle,
> >  				offset, ocfs2_dir_trailer_blk_off(dir->i_sb));
> > =20
> >  		if (ocfs2_dirent_would_fit(de, rec_len)) {
> > -			dir->i_mtime =3D dir->i_ctime =3D current_time(dir);
> > +			dir->i_mtime =3D inode_set_ctime_current(dir);
> >  			retval =3D ocfs2_mark_inode_dirty(handle, dir, parent_fe_bh);
> >  			if (retval < 0) {
> >  				mlog_errno(retval);
> > @@ -2962,11 +2962,11 @@ static int ocfs2_expand_inline_dir(struct inode=
 *dir, struct buffer_head *di_bh,
> >  	ocfs2_dinode_new_extent_list(dir, di);
> > =20
> >  	i_size_write(dir, sb->s_blocksize);
> > -	dir->i_mtime =3D dir->i_ctime =3D current_time(dir);
> > +	dir->i_mtime =3D inode_set_ctime_current(dir);
> > =20
> >  	di->i_size =3D cpu_to_le64(sb->s_blocksize);
> > -	di->i_ctime =3D di->i_mtime =3D cpu_to_le64(dir->i_ctime.tv_sec);
> > -	di->i_ctime_nsec =3D di->i_mtime_nsec =3D cpu_to_le32(dir->i_ctime.tv=
_nsec);
> > +	di->i_ctime =3D di->i_mtime =3D cpu_to_le64(inode_get_ctime(dir).tv_s=
ec);
> > +	di->i_ctime_nsec =3D di->i_mtime_nsec =3D cpu_to_le32(inode_get_ctime=
(dir).tv_nsec);
> >  	ocfs2_update_inode_fsync_trans(handle, dir, 1);
> > =20
> >  	/*
> > diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> > index ba26c5567cff..81265123ce6c 100644
> > --- a/fs/ocfs2/dlmfs/dlmfs.c
> > +++ b/fs/ocfs2/dlmfs/dlmfs.c
> > @@ -337,7 +337,7 @@ static struct inode *dlmfs_get_root_inode(struct su=
per_block *sb)
> >  	if (inode) {
> >  		inode->i_ino =3D get_next_ino();
> >  		inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
> > -		inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_tim=
e(inode);
> > +		inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_current(inode)=
;
> >  		inc_nlink(inode);
> > =20
> >  		inode->i_fop =3D &simple_dir_operations;
> > @@ -360,7 +360,7 @@ static struct inode *dlmfs_get_inode(struct inode *=
parent,
> > =20
> >  	inode->i_ino =3D get_next_ino();
> >  	inode_init_owner(&nop_mnt_idmap, inode, parent, mode);
> > -	inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time=
(inode);
> > +	inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_current(inode);
> > =20
> >  	ip =3D DLMFS_I(inode);
> >  	ip->ip_conn =3D DLMFS_I(parent)->ip_conn;
> > diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> > index c28bc983a7b1..c3e2961ee5db 100644
> > --- a/fs/ocfs2/dlmglue.c
> > +++ b/fs/ocfs2/dlmglue.c
> > @@ -2162,6 +2162,7 @@ static void __ocfs2_stuff_meta_lvb(struct inode *=
inode)
> >  	struct ocfs2_inode_info *oi =3D OCFS2_I(inode);
> >  	struct ocfs2_lock_res *lockres =3D &oi->ip_inode_lockres;
> >  	struct ocfs2_meta_lvb *lvb;
> > +	struct timespec64 ctime =3D inode_get_ctime(inode);
> > =20
> >  	lvb =3D ocfs2_dlm_lvb(&lockres->l_lksb);
> > =20
> > @@ -2185,7 +2186,7 @@ static void __ocfs2_stuff_meta_lvb(struct inode *=
inode)
> >  	lvb->lvb_iatime_packed  =3D
> >  		cpu_to_be64(ocfs2_pack_timespec(&inode->i_atime));
> >  	lvb->lvb_ictime_packed =3D
> > -		cpu_to_be64(ocfs2_pack_timespec(&inode->i_ctime));
> > +		cpu_to_be64(ocfs2_pack_timespec(&ctime));
> >  	lvb->lvb_imtime_packed =3D
> >  		cpu_to_be64(ocfs2_pack_timespec(&inode->i_mtime));
> >  	lvb->lvb_iattr    =3D cpu_to_be32(oi->ip_attr);
> > @@ -2208,6 +2209,7 @@ static int ocfs2_refresh_inode_from_lvb(struct in=
ode *inode)
> >  	struct ocfs2_inode_info *oi =3D OCFS2_I(inode);
> >  	struct ocfs2_lock_res *lockres =3D &oi->ip_inode_lockres;
> >  	struct ocfs2_meta_lvb *lvb;
> > +	struct timespec64 ctime;
> > =20
> >  	mlog_meta_lvb(0, lockres);
> > =20
> > @@ -2238,8 +2240,9 @@ static int ocfs2_refresh_inode_from_lvb(struct in=
ode *inode)
> >  			      be64_to_cpu(lvb->lvb_iatime_packed));
> >  	ocfs2_unpack_timespec(&inode->i_mtime,
> >  			      be64_to_cpu(lvb->lvb_imtime_packed));
> > -	ocfs2_unpack_timespec(&inode->i_ctime,
> > +	ocfs2_unpack_timespec(&ctime,
> >  			      be64_to_cpu(lvb->lvb_ictime_packed));
> > +	inode_set_ctime_to_ts(inode, ctime);
>=20
> A quick glance, it seems not an equivalent replace.
>=20


How so?

The old code unpacked the time directly into the inode->i_ctime. The new
one unpacks it into a local timespec64 variable and then sets the
inode->i_ctime to that value. The result should still be the same.


> >  	spin_unlock(&oi->ip_lock);
> >  	return 0;
> >  }
> > diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> > index 9e417cd4fd16..e8c78d16e815 100644
> > --- a/fs/ocfs2/file.c
> > +++ b/fs/ocfs2/file.c
> > @@ -232,8 +232,10 @@ int ocfs2_should_update_atime(struct inode *inode,
> >  		return 0;
> > =20
> >  	if (vfsmnt->mnt_flags & MNT_RELATIME) {
> > +		struct timespec64 ctime =3D inode_get_ctime(inode);
> > +
> >  		if ((timespec64_compare(&inode->i_atime, &inode->i_mtime) <=3D 0) ||
> > -		    (timespec64_compare(&inode->i_atime, &inode->i_ctime) <=3D 0))
> > +		    (timespec64_compare(&inode->i_atime, &ctime) <=3D 0))
> >  			return 1;
> > =20
> >  		return 0;
> > @@ -294,7 +296,7 @@ int ocfs2_set_inode_size(handle_t *handle,
> > =20
> >  	i_size_write(inode, new_i_size);
> >  	inode->i_blocks =3D ocfs2_inode_sector_count(inode);
> > -	inode->i_ctime =3D inode->i_mtime =3D current_time(inode);
> > +	inode->i_mtime =3D inode_set_ctime_current(inode);
> > =20
> >  	status =3D ocfs2_mark_inode_dirty(handle, inode, fe_bh);
> >  	if (status < 0) {
> > @@ -415,12 +417,12 @@ static int ocfs2_orphan_for_truncate(struct ocfs2=
_super *osb,
> >  	}
> > =20
> >  	i_size_write(inode, new_i_size);
> > -	inode->i_ctime =3D inode->i_mtime =3D current_time(inode);
> > +	inode->i_mtime =3D inode_set_ctime_current(inode);
> > =20
> >  	di =3D (struct ocfs2_dinode *) fe_bh->b_data;
> >  	di->i_size =3D cpu_to_le64(new_i_size);
> > -	di->i_ctime =3D di->i_mtime =3D cpu_to_le64(inode->i_ctime.tv_sec);
> > -	di->i_ctime_nsec =3D di->i_mtime_nsec =3D cpu_to_le32(inode->i_ctime.=
tv_nsec);
> > +	di->i_ctime =3D di->i_mtime =3D cpu_to_le64(inode_get_ctime(inode).tv=
_sec);
> > +	di->i_ctime_nsec =3D di->i_mtime_nsec =3D cpu_to_le32(inode_get_ctime=
(inode).tv_nsec);
> >  	ocfs2_update_inode_fsync_trans(handle, inode, 0);
> > =20
> >  	ocfs2_journal_dirty(handle, fe_bh);
> > @@ -819,7 +821,7 @@ static int ocfs2_write_zero_page(struct inode *inod=
e, u64 abs_from,
> >  	i_size_write(inode, abs_to);
> >  	inode->i_blocks =3D ocfs2_inode_sector_count(inode);
> >  	di->i_size =3D cpu_to_le64((u64)i_size_read(inode));
> > -	inode->i_mtime =3D inode->i_ctime =3D current_time(inode);
> > +	inode->i_mtime =3D inode_set_ctime_current(inode);
> >  	di->i_mtime =3D di->i_ctime =3D cpu_to_le64(inode->i_mtime.tv_sec);
> >  	di->i_ctime_nsec =3D cpu_to_le32(inode->i_mtime.tv_nsec);
> >  	di->i_mtime_nsec =3D di->i_ctime_nsec;
> > @@ -2038,7 +2040,7 @@ static int __ocfs2_change_file_space(struct file =
*file, struct inode *inode,
> >  		goto out_inode_unlock;
> >  	}
> > =20
> > -	inode->i_ctime =3D inode->i_mtime =3D current_time(inode);
> > +	inode->i_mtime =3D inode_set_ctime_current(inode);
> >  	ret =3D ocfs2_mark_inode_dirty(handle, inode, di_bh);
> >  	if (ret < 0)
> >  		mlog_errno(ret);
> > diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> > index bb116c39b581..e8771600b930 100644
> > --- a/fs/ocfs2/inode.c
> > +++ b/fs/ocfs2/inode.c
> > @@ -306,8 +306,8 @@ void ocfs2_populate_inode(struct inode *inode, stru=
ct ocfs2_dinode *fe,
> >  	inode->i_atime.tv_nsec =3D le32_to_cpu(fe->i_atime_nsec);
> >  	inode->i_mtime.tv_sec =3D le64_to_cpu(fe->i_mtime);
> >  	inode->i_mtime.tv_nsec =3D le32_to_cpu(fe->i_mtime_nsec);
> > -	inode->i_ctime.tv_sec =3D le64_to_cpu(fe->i_ctime);
> > -	inode->i_ctime.tv_nsec =3D le32_to_cpu(fe->i_ctime_nsec);
> > +	inode_set_ctime(inode, le64_to_cpu(fe->i_ctime),
> > +		        le32_to_cpu(fe->i_ctime_nsec));
> > =20
> >  	if (OCFS2_I(inode)->ip_blkno !=3D le64_to_cpu(fe->i_blkno))
> >  		mlog(ML_ERROR,
> > @@ -1314,8 +1314,8 @@ int ocfs2_mark_inode_dirty(handle_t *handle,
> >  	fe->i_mode =3D cpu_to_le16(inode->i_mode);
> >  	fe->i_atime =3D cpu_to_le64(inode->i_atime.tv_sec);
> >  	fe->i_atime_nsec =3D cpu_to_le32(inode->i_atime.tv_nsec);
> > -	fe->i_ctime =3D cpu_to_le64(inode->i_ctime.tv_sec);
> > -	fe->i_ctime_nsec =3D cpu_to_le32(inode->i_ctime.tv_nsec);
> > +	fe->i_ctime =3D cpu_to_le64(inode_get_ctime(inode).tv_sec);
> > +	fe->i_ctime_nsec =3D cpu_to_le32(inode_get_ctime(inode).tv_nsec);
> >  	fe->i_mtime =3D cpu_to_le64(inode->i_mtime.tv_sec);
> >  	fe->i_mtime_nsec =3D cpu_to_le32(inode->i_mtime.tv_nsec);
> > =20
> > @@ -1352,8 +1352,8 @@ void ocfs2_refresh_inode(struct inode *inode,
> >  	inode->i_atime.tv_nsec =3D le32_to_cpu(fe->i_atime_nsec);
> >  	inode->i_mtime.tv_sec =3D le64_to_cpu(fe->i_mtime);
> >  	inode->i_mtime.tv_nsec =3D le32_to_cpu(fe->i_mtime_nsec);
> > -	inode->i_ctime.tv_sec =3D le64_to_cpu(fe->i_ctime);
> > -	inode->i_ctime.tv_nsec =3D le32_to_cpu(fe->i_ctime_nsec);
> > +	inode_set_ctime(inode, le64_to_cpu(fe->i_ctime),
> > +			le32_to_cpu(fe->i_ctime_nsec));
> > =20
> >  	spin_unlock(&OCFS2_I(inode)->ip_lock);
> >  }
> > diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
> > index b1e32ec4a9d4..05d67968a3a9 100644
> > --- a/fs/ocfs2/move_extents.c
> > +++ b/fs/ocfs2/move_extents.c
> > @@ -950,9 +950,9 @@ static int ocfs2_move_extents(struct ocfs2_move_ext=
ents_context *context)
> >  	}
> > =20
> >  	di =3D (struct ocfs2_dinode *)di_bh->b_data;
> > -	inode->i_ctime =3D current_time(inode);
> > -	di->i_ctime =3D cpu_to_le64(inode->i_ctime.tv_sec);
> > -	di->i_ctime_nsec =3D cpu_to_le32(inode->i_ctime.tv_nsec);
> > +	inode_set_ctime_current(inode);
> > +	di->i_ctime =3D cpu_to_le64(inode_get_ctime(inode).tv_sec);
> > +	di->i_ctime_nsec =3D cpu_to_le32(inode_get_ctime(inode).tv_nsec);
> >  	ocfs2_update_inode_fsync_trans(handle, inode, 0);
> > =20
> >  	ocfs2_journal_dirty(handle, di_bh);
> > diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> > index 17c52225b87d..e4a684d45308 100644
> > --- a/fs/ocfs2/namei.c
> > +++ b/fs/ocfs2/namei.c
> > @@ -793,10 +793,10 @@ static int ocfs2_link(struct dentry *old_dentry,
> >  	}
> > =20
> >  	inc_nlink(inode);
> > -	inode->i_ctime =3D current_time(inode);
> > +	inode_set_ctime_current(inode);
> >  	ocfs2_set_links_count(fe, inode->i_nlink);
> > -	fe->i_ctime =3D cpu_to_le64(inode->i_ctime.tv_sec);
> > -	fe->i_ctime_nsec =3D cpu_to_le32(inode->i_ctime.tv_nsec);
> > +	fe->i_ctime =3D cpu_to_le64(inode_get_ctime(inode).tv_sec);
> > +	fe->i_ctime_nsec =3D cpu_to_le32(inode_get_ctime(inode).tv_nsec);
> >  	ocfs2_journal_dirty(handle, fe_bh);
> > =20
> >  	err =3D ocfs2_add_entry(handle, dentry, inode,
> > @@ -995,7 +995,7 @@ static int ocfs2_unlink(struct inode *dir,
> >  	ocfs2_set_links_count(fe, inode->i_nlink);
> >  	ocfs2_journal_dirty(handle, fe_bh);
> > =20
> > -	dir->i_ctime =3D dir->i_mtime =3D current_time(dir);
> > +	dir->i_mtime =3D inode_set_ctime_current(dir);
> >  	if (S_ISDIR(inode->i_mode))
> >  		drop_nlink(dir);
> > =20
> > @@ -1537,7 +1537,7 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
> >  					 new_dir_bh, &target_insert);
> >  	}
> > =20
> > -	old_inode->i_ctime =3D current_time(old_inode);
> > +	inode_set_ctime_current(old_inode);
> >  	mark_inode_dirty(old_inode);
> > =20
> >  	status =3D ocfs2_journal_access_di(handle, INODE_CACHE(old_inode),
> > @@ -1546,8 +1546,8 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
> >  	if (status >=3D 0) {
> >  		old_di =3D (struct ocfs2_dinode *) old_inode_bh->b_data;
> > =20
> > -		old_di->i_ctime =3D cpu_to_le64(old_inode->i_ctime.tv_sec);
> > -		old_di->i_ctime_nsec =3D cpu_to_le32(old_inode->i_ctime.tv_nsec);
> > +		old_di->i_ctime =3D cpu_to_le64(inode_get_ctime(old_inode).tv_sec);
> > +		old_di->i_ctime_nsec =3D cpu_to_le32(inode_get_ctime(old_inode).tv_n=
sec);
> >  		ocfs2_journal_dirty(handle, old_inode_bh);
> >  	} else
> >  		mlog_errno(status);
> > @@ -1586,9 +1586,9 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
> > =20
> >  	if (new_inode) {
> >  		drop_nlink(new_inode);
> > -		new_inode->i_ctime =3D current_time(new_inode);
> > +		inode_set_ctime_current(new_inode);
> >  	}
> > -	old_dir->i_ctime =3D old_dir->i_mtime =3D current_time(old_dir);
> > +	old_dir->i_mtime =3D inode_set_ctime_current(old_dir);
> > =20
> >  	if (update_dot_dot) {
> >  		status =3D ocfs2_update_entry(old_inode, handle,
> > @@ -1610,7 +1610,8 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
> > =20
> >  	if (old_dir !=3D new_dir) {
> >  		/* Keep the same times on both directories.*/
> > -		new_dir->i_ctime =3D new_dir->i_mtime =3D old_dir->i_ctime;
> > +		new_dir->i_mtime =3D inode_set_ctime_to_ts(new_dir,
> > +							 inode_get_ctime(old_dir));
> > =20
> >  		/*
> >  		 * This will also pick up the i_nlink change from the
> > diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> > index 564ab48d03ef..25c8ec3c8c3a 100644
> > --- a/fs/ocfs2/refcounttree.c
> > +++ b/fs/ocfs2/refcounttree.c
> > @@ -3750,9 +3750,9 @@ static int ocfs2_change_ctime(struct inode *inode=
,
> >  		goto out_commit;
> >  	}
> > =20
> > -	inode->i_ctime =3D current_time(inode);
> > -	di->i_ctime =3D cpu_to_le64(inode->i_ctime.tv_sec);
> > -	di->i_ctime_nsec =3D cpu_to_le32(inode->i_ctime.tv_nsec);
> > +	inode_set_ctime_current(inode);
> > +	di->i_ctime =3D cpu_to_le64(inode_get_ctime(inode).tv_sec);
> > +	di->i_ctime_nsec =3D cpu_to_le32(inode_get_ctime(inode).tv_nsec);
> > =20
> >  	ocfs2_journal_dirty(handle, di_bh);
> > =20
> > @@ -4073,10 +4073,10 @@ static int ocfs2_complete_reflink(struct inode =
*s_inode,
> >  		 * we want mtime to appear identical to the source and
> >  		 * update ctime.
> >  		 */
> > -		t_inode->i_ctime =3D current_time(t_inode);
> > +		inode_set_ctime_current(t_inode);
> > =20
> > -		di->i_ctime =3D cpu_to_le64(t_inode->i_ctime.tv_sec);
> > -		di->i_ctime_nsec =3D cpu_to_le32(t_inode->i_ctime.tv_nsec);
> > +		di->i_ctime =3D cpu_to_le64(inode_get_ctime(t_inode).tv_sec);
> > +		di->i_ctime_nsec =3D cpu_to_le32(inode_get_ctime(t_inode).tv_nsec);
> > =20
> >  		t_inode->i_mtime =3D s_inode->i_mtime;
> >  		di->i_mtime =3D s_di->i_mtime;
> > @@ -4456,7 +4456,7 @@ int ocfs2_reflink_update_dest(struct inode *dest,
> >  	if (newlen > i_size_read(dest))
> >  		i_size_write(dest, newlen);
> >  	spin_unlock(&OCFS2_I(dest)->ip_lock);
> > -	dest->i_ctime =3D dest->i_mtime =3D current_time(dest);
> > +	dest->i_mtime =3D inode_set_ctime_current(dest);
> > =20
> >  	ret =3D ocfs2_mark_inode_dirty(handle, dest, d_bh);
> >  	if (ret) {
> > diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> > index 4ac77ff6e676..6510ad783c91 100644
> > --- a/fs/ocfs2/xattr.c
> > +++ b/fs/ocfs2/xattr.c
> > @@ -3421,9 +3421,9 @@ static int __ocfs2_xattr_set_handle(struct inode =
*inode,
> >  			goto out;
> >  		}
> > =20
> > -		inode->i_ctime =3D current_time(inode);
> > -		di->i_ctime =3D cpu_to_le64(inode->i_ctime.tv_sec);
> > -		di->i_ctime_nsec =3D cpu_to_le32(inode->i_ctime.tv_nsec);
> > +		inode_set_ctime_current(inode);
> > +		di->i_ctime =3D cpu_to_le64(inode_get_ctime(inode).tv_sec);
> > +		di->i_ctime_nsec =3D cpu_to_le32(inode_get_ctime(inode).tv_nsec);
> >  		ocfs2_journal_dirty(ctxt->handle, xis->inode_bh);
> >  	}
> >  out:

--=20
Jeff Layton <jlayton@kernel.org>
