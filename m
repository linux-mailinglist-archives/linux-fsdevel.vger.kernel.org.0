Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6640599B3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 13:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348549AbiHSLkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 07:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348526AbiHSLkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:40:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC241EF9F9;
        Fri, 19 Aug 2022 04:40:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593B2617AC;
        Fri, 19 Aug 2022 11:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04DCC433D6;
        Fri, 19 Aug 2022 11:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660909210;
        bh=7554TDRPSRzYSeXKuR5+rVsRfRWnvuMBPIGBqERnfs8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KG5wJ/b+ixlX+rNfgtMmwEr34taP/vrwBlGGINfK87e/R9F60Ld39iYkU3Cizh9TZ
         svItgGf5J/mCnllWOEIkgMnP/Td5lL3qgSKldAjB3LuWOf383MOvJo+qRgu+gdq3Nz
         RipNJ1RQh+KgTx5+T02/dB4+YWw/53qjK6aXPpQWvybJHriNPlj4yUUAv53aqCEGN+
         RMt0FIwwqiI7aytNTXmw4btbnB9h32HPIa8wpikGmH5ulJ1ST8A8e0Fw67DdbgMt+g
         +2iJcW9Siir+EMwAYkdVw9uGBuzWwfJio6R1NrU7OVCjl29DFawllHlgQW1Wo+drBt
         T7HCBD7wBrt6Q==
Message-ID: <8a0ccce66b624be545268e2839b34ac5f6aabcd3.camel@kernel.org>
Subject: Re: [PATCH] ext4: fix i_version handling in ext4
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>
Date:   Fri, 19 Aug 2022 07:40:08 -0400
In-Reply-To: <20220819113620.12048-1-jlayton@kernel.org>
References: <20220819113620.12048-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

Oops, I should have labeled this "PATCH v3". In any case, I think we've
covered all of the places where it should get bumped now.

On Fri, 2022-08-19 at 07:36 -0400, Jeff Layton wrote:
> ext4 currently updates the i_version counter when the atime is updated
> during a read. This is less than ideal as it can cause unnecessary cache
> invalidations with NFSv4 and unnecessary remeasurements for IMA. The
> increment in ext4_mark_iloc_dirty is also problematic since it can also
> corrupt the i_version counter for ea_inodes. We aren't bumping the file
> times in ext4_mark_iloc_dirty, so changing the i_version there seems
> wrong, and is the cause of both problems.
>=20
> Remove that callsite and add increments to the setattr, setxattr and
> ioctl codepaths (at the same time that we update the ctime). The
> i_version bump that already happens during timestamp updates should take
> care of the rest.
>=20
> In ext4_move_extents, increment the i_version on both inodes, and also
> add in missing ctime updates.
>=20
> Cc: Lukas Czerner <lczerner@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ext4/inode.c       | 10 +++++-----
>  fs/ext4/ioctl.c       |  4 ++++
>  fs/ext4/move_extent.c |  6 ++++++
>  fs/ext4/xattr.c       |  2 ++
>  4 files changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 601214453c3a..aa37bce4c541 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5342,6 +5342,7 @@ int ext4_setattr(struct user_namespace *mnt_userns,=
 struct dentry *dentry,
>  	int error, rc =3D 0;
>  	int orphan =3D 0;
>  	const unsigned int ia_valid =3D attr->ia_valid;
> +	bool inc_ivers =3D IS_I_VERSION(inode);
> =20
>  	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
>  		return -EIO;
> @@ -5425,8 +5426,8 @@ int ext4_setattr(struct user_namespace *mnt_userns,=
 struct dentry *dentry,
>  			return -EINVAL;
>  		}
> =20
> -		if (IS_I_VERSION(inode) && attr->ia_size !=3D inode->i_size)
> -			inode_inc_iversion(inode);
> +		if (attr->ia_size =3D=3D inode->i_size)
> +			inc_ivers =3D false;
> =20
>  		if (shrink) {
>  			if (ext4_should_order_data(inode)) {
> @@ -5528,6 +5529,8 @@ int ext4_setattr(struct user_namespace *mnt_userns,=
 struct dentry *dentry,
>  	}
> =20
>  	if (!error) {
> +		if (inc_ivers)
> +			inode_inc_iversion(inode);
>  		setattr_copy(mnt_userns, inode, attr);
>  		mark_inode_dirty(inode);
>  	}
> @@ -5731,9 +5734,6 @@ int ext4_mark_iloc_dirty(handle_t *handle,
>  	}
>  	ext4_fc_track_inode(handle, inode);
> =20
> -	if (IS_I_VERSION(inode))
> -		inode_inc_iversion(inode);
> -
>  	/* the do_update_inode consumes one bh->b_count */
>  	get_bh(iloc->bh);
> =20
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 3cf3ec4b1c21..ad3a294a88eb 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -452,6 +452,7 @@ static long swap_inode_boot_loader(struct super_block=
 *sb,
>  	swap_inode_data(inode, inode_bl);
> =20
>  	inode->i_ctime =3D inode_bl->i_ctime =3D current_time(inode);
> +	inode_inc_iversion(inode);
> =20
>  	inode->i_generation =3D prandom_u32();
>  	inode_bl->i_generation =3D prandom_u32();
> @@ -665,6 +666,7 @@ static int ext4_ioctl_setflags(struct inode *inode,
>  	ext4_set_inode_flags(inode, false);
> =20
>  	inode->i_ctime =3D current_time(inode);
> +	inode_inc_iversion(inode);
> =20
>  	err =3D ext4_mark_iloc_dirty(handle, inode, &iloc);
>  flags_err:
> @@ -775,6 +777,7 @@ static int ext4_ioctl_setproject(struct inode *inode,=
 __u32 projid)
> =20
>  	EXT4_I(inode)->i_projid =3D kprojid;
>  	inode->i_ctime =3D current_time(inode);
> +	inode_inc_iversion(inode);
>  out_dirty:
>  	rc =3D ext4_mark_iloc_dirty(handle, inode, &iloc);
>  	if (!err)
> @@ -1257,6 +1260,7 @@ static long __ext4_ioctl(struct file *filp, unsigne=
d int cmd, unsigned long arg)
>  		err =3D ext4_reserve_inode_write(handle, inode, &iloc);
>  		if (err =3D=3D 0) {
>  			inode->i_ctime =3D current_time(inode);
> +			inode_inc_iversion(inode);
>  			inode->i_generation =3D generation;
>  			err =3D ext4_mark_iloc_dirty(handle, inode, &iloc);
>  		}
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 701f1d6a217f..285700b00d38 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -6,6 +6,7 @@
>   */
> =20
>  #include <linux/fs.h>
> +#include <linux/iversion.h>
>  #include <linux/quotaops.h>
>  #include <linux/slab.h>
>  #include <linux/sched/mm.h>
> @@ -683,6 +684,11 @@ ext4_move_extents(struct file *o_filp, struct file *=
d_filp, __u64 orig_blk,
>  			break;
>  		o_start +=3D cur_len;
>  		d_start +=3D cur_len;
> +
> +		orig_inode->i_ctime =3D current_time(orig_inode);
> +		donor_inode->i_ctime =3D current_time(donor_inode);
> +		inode_inc_iversion(orig_inode);
> +		inode_inc_iversion(donor_inode);
>  	}
>  	*moved_len =3D o_start - orig_blk;
>  	if (*moved_len > len)
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 533216e80fa2..e975442e4ab2 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2412,6 +2412,8 @@ ext4_xattr_set_handle(handle_t *handle, struct inod=
e *inode, int name_index,
>  	if (!error) {
>  		ext4_xattr_update_super_block(handle, inode->i_sb);
>  		inode->i_ctime =3D current_time(inode);
> +		if (IS_I_VERSION(inode))
> +			inode_inc_iversion(inode);
>  		if (!value)
>  			no_expand =3D 0;
>  		error =3D ext4_mark_iloc_dirty(handle, inode, &is.iloc);

--=20
Jeff Layton <jlayton@kernel.org>
