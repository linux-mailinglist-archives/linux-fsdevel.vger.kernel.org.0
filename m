Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EDE749142
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 01:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjGEXBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 19:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjGEXBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E425F1FC2;
        Wed,  5 Jul 2023 16:01:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39BD061804;
        Wed,  5 Jul 2023 23:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C772C433C8;
        Wed,  5 Jul 2023 23:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688598065;
        bh=XpGursO87vVTb9NCK3pFJHPSTZmFnpIPiBKxIe3GsMg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g4j9ugy8GvcidFX+MW3csjrz5rCJjVhJnu2ppfc80IeC/y5lhm1bGcjLHypWHPWa+
         yaiQjdRLDRWUokVXIv+YeO/skhND/56Ueckhlq1ANDwqVeJA42CJ3Qi8Yimt+lUIob
         O83j86WSc2yCnFdQJxQRfCAl4fZu25xlo3XNno1kWFqB93mWnTkg+s74F++Rzh2d5O
         ZOEYtXZ1cg01/FKDc8s8eIurjotPGZHCWcGDWCfMY3Uxo1Y7x3VXJQbDRVL+aJ8t+/
         4BJxuViab9DrEaYnolYOEazreTyHiO0l/FY9pfy7h9Hy5/J+h8DaGmY76Z+wYQkxKe
         PZWlA9cWWpjVA==
Message-ID: <9f083eda686ac143a5823e224003ca6797089c54.camel@kernel.org>
Subject: Re: [PATCH v2 74/92] smb: convert to ctime accessor functions
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Date:   Wed, 05 Jul 2023 19:01:01 -0400
In-Reply-To: <20230705190309.579783-72-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
         <20230705190309.579783-1-jlayton@kernel.org>
         <20230705190309.579783-72-jlayton@kernel.org>
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

On Wed, 2023-07-05 at 15:01 -0400, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
>=20
> Acked-by: Tom Talpey <tom@talpey.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/smb/client/file.c    |  4 ++--
>  fs/smb/client/fscache.h |  5 +++--
>  fs/smb/client/inode.c   | 14 +++++++-------
>  fs/smb/client/smb2ops.c |  3 ++-
>  fs/smb/server/smb2pdu.c |  8 ++++----
>  5 files changed, 18 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 0a5fe8d5314b..689058e1b6e6 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -1085,7 +1085,7 @@ int cifs_close(struct inode *inode, struct file *fi=
le)
>  		    !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
>  		    dclose) {
>  			if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &cinode->flags)) {
> -				inode->i_ctime =3D inode->i_mtime =3D current_time(inode);
> +				inode->i_mtime =3D inode_set_ctime_current(inode);
>  			}
>  			spin_lock(&cinode->deferred_lock);
>  			cifs_add_deferred_close(cfile, dclose);
> @@ -2596,7 +2596,7 @@ static int cifs_partialpagewrite(struct page *page,=
 unsigned from, unsigned to)
>  					   write_data, to - from, &offset);
>  		cifsFileInfo_put(open_file);
>  		/* Does mm or vfs already set times? */
> -		inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_time(=
inode);
> +		inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_current(inode);
>  		if ((bytes_written > 0) && (offset))
>  			rc =3D 0;
>  		else if (bytes_written < 0)
> diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
> index 173999610997..a228964bc2ce 100644
> --- a/fs/smb/client/fscache.h
> +++ b/fs/smb/client/fscache.h
> @@ -50,12 +50,13 @@ void cifs_fscache_fill_coherency(struct inode *inode,
>  				 struct cifs_fscache_inode_coherency_data *cd)
>  {
>  	struct cifsInodeInfo *cifsi =3D CIFS_I(inode);
> +	struct timespec64 ctime =3D inode_get_ctime(inode);
> =20
>  	memset(cd, 0, sizeof(*cd));
>  	cd->last_write_time_sec   =3D cpu_to_le64(cifsi->netfs.inode.i_mtime.tv=
_sec);
>  	cd->last_write_time_nsec  =3D cpu_to_le32(cifsi->netfs.inode.i_mtime.tv=
_nsec);
> -	cd->last_change_time_sec  =3D cpu_to_le64(cifsi->netfs.inode.i_ctime.tv=
_sec);
> -	cd->last_change_time_nsec =3D cpu_to_le32(cifsi->netfs.inode.i_ctime.tv=
_nsec);
> +	cd->last_change_time_sec  =3D cpu_to_le64(ctime.tv_sec);
> +	cd->last_change_time_nsec  =3D cpu_to_le64(ctime.tv_nsec);

Tom pointed out that I made a switch to cpu_to_le64 here. That will need
to be fixed before we merge this. I've fixed this in my "ctime-next"
branch for now (and will collect other fixes there).

>  }
> =20
> =20
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index c3eeae07e139..218f03dd3f52 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -172,7 +172,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_=
fattr *fattr)
>  	else
>  		inode->i_atime =3D fattr->cf_atime;
>  	inode->i_mtime =3D fattr->cf_mtime;
> -	inode->i_ctime =3D fattr->cf_ctime;
> +	inode_set_ctime_to_ts(inode, fattr->cf_ctime);
>  	inode->i_rdev =3D fattr->cf_rdev;
>  	cifs_nlink_fattr_to_inode(inode, fattr);
>  	inode->i_uid =3D fattr->cf_uid;
> @@ -1744,9 +1744,9 @@ int cifs_unlink(struct inode *dir, struct dentry *d=
entry)
>  		cifs_inode =3D CIFS_I(inode);
>  		cifs_inode->time =3D 0;	/* will force revalidate to get info
>  					   when needed */
> -		inode->i_ctime =3D current_time(inode);
> +		inode_set_ctime_current(inode);
>  	}
> -	dir->i_ctime =3D dir->i_mtime =3D current_time(dir);
> +	dir->i_mtime =3D inode_set_ctime_current(dir);
>  	cifs_inode =3D CIFS_I(dir);
>  	CIFS_I(dir)->time =3D 0;	/* force revalidate of dir as well */
>  unlink_out:
> @@ -2060,8 +2060,8 @@ int cifs_rmdir(struct inode *inode, struct dentry *=
direntry)
>  	 */
>  	cifsInode->time =3D 0;
> =20
> -	d_inode(direntry)->i_ctime =3D inode->i_ctime =3D inode->i_mtime =3D
> -		current_time(inode);
> +	inode_set_ctime_current(d_inode(direntry));
> +	inode->i_mtime =3D inode_set_ctime_current(inode);
> =20
>  rmdir_exit:
>  	free_dentry_path(page);
> @@ -2267,8 +2267,8 @@ cifs_rename2(struct mnt_idmap *idmap, struct inode =
*source_dir,
>  	/* force revalidate to go get info when needed */
>  	CIFS_I(source_dir)->time =3D CIFS_I(target_dir)->time =3D 0;
> =20
> -	source_dir->i_ctime =3D source_dir->i_mtime =3D target_dir->i_ctime =3D
> -		target_dir->i_mtime =3D current_time(source_dir);
> +	source_dir->i_mtime =3D target_dir->i_mtime =3D inode_set_ctime_to_ts(s=
ource_dir,
> +									  inode_set_ctime_current(target_dir));
> =20
>  cifs_rename_exit:
>  	kfree(info_buf_source);
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 87abce010974..3cc3c4a71e32 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -1396,7 +1396,8 @@ smb2_close_getattr(const unsigned int xid, struct c=
ifs_tcon *tcon,
>  	if (file_inf.LastWriteTime)
>  		inode->i_mtime =3D cifs_NTtimeToUnix(file_inf.LastWriteTime);
>  	if (file_inf.ChangeTime)
> -		inode->i_ctime =3D cifs_NTtimeToUnix(file_inf.ChangeTime);
> +		inode_set_ctime_to_ts(inode,
> +				      cifs_NTtimeToUnix(file_inf.ChangeTime));
>  	if (file_inf.LastAccessTime)
>  		inode->i_atime =3D cifs_NTtimeToUnix(file_inf.LastAccessTime);
> =20
> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
> index cf8822103f50..f9099831c8ff 100644
> --- a/fs/smb/server/smb2pdu.c
> +++ b/fs/smb/server/smb2pdu.c
> @@ -4779,7 +4779,7 @@ static int find_file_posix_info(struct smb2_query_i=
nfo_rsp *rsp,
>  	file_info->LastAccessTime =3D cpu_to_le64(time);
>  	time =3D ksmbd_UnixTimeToNT(inode->i_mtime);
>  	file_info->LastWriteTime =3D cpu_to_le64(time);
> -	time =3D ksmbd_UnixTimeToNT(inode->i_ctime);
> +	time =3D ksmbd_UnixTimeToNT(inode_get_ctime(inode));
>  	file_info->ChangeTime =3D cpu_to_le64(time);
>  	file_info->DosAttributes =3D fp->f_ci->m_fattr;
>  	file_info->Inode =3D cpu_to_le64(inode->i_ino);
> @@ -5422,7 +5422,7 @@ int smb2_close(struct ksmbd_work *work)
>  		rsp->LastAccessTime =3D cpu_to_le64(time);
>  		time =3D ksmbd_UnixTimeToNT(inode->i_mtime);
>  		rsp->LastWriteTime =3D cpu_to_le64(time);
> -		time =3D ksmbd_UnixTimeToNT(inode->i_ctime);
> +		time =3D ksmbd_UnixTimeToNT(inode_get_ctime(inode));
>  		rsp->ChangeTime =3D cpu_to_le64(time);
>  		ksmbd_fd_put(work, fp);
>  	} else {
> @@ -5644,7 +5644,7 @@ static int set_file_basic_info(struct ksmbd_file *f=
p,
>  	if (file_info->ChangeTime)
>  		attrs.ia_ctime =3D ksmbd_NTtimeToUnix(file_info->ChangeTime);
>  	else
> -		attrs.ia_ctime =3D inode->i_ctime;
> +		attrs.ia_ctime =3D inode_get_ctime(inode);
> =20
>  	if (file_info->LastWriteTime) {
>  		attrs.ia_mtime =3D ksmbd_NTtimeToUnix(file_info->LastWriteTime);
> @@ -5689,7 +5689,7 @@ static int set_file_basic_info(struct ksmbd_file *f=
p,
>  			return -EACCES;
> =20
>  		inode_lock(inode);
> -		inode->i_ctime =3D attrs.ia_ctime;
> +		inode_set_ctime_to_ts(inode, attrs.ia_ctime);
>  		attrs.ia_valid &=3D ~ATTR_CTIME;
>  		rc =3D notify_change(idmap, dentry, &attrs, NULL);
>  		inode_unlock(inode);

--=20
Jeff Layton <jlayton@kernel.org>
