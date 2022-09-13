Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345D45B670F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 06:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIMEmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 00:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIMEmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:42:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358F815720
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 21:41:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C75021032;
        Tue, 13 Sep 2022 04:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663044117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lAxRZ/xvzu1cFEUxLEMlXi+wyTWW2aReL1d5LkaRKc=;
        b=Cz7slhdmELiKfzGeL+3JPGsq/b0YrEJrW6vdvDAoyVNiWlIT5cZ3u+atOfVE5muXde4nwz
        r8wo8ovLYWheWTaOA3ypYEDG05VDNzNmFxQycZaRjpzsKhFk2MNDjqt9j/NhVyBdVUI6Pk
        +s8cbhfGxE/0LTNB9277RMuhJ8JF5Qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663044117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lAxRZ/xvzu1cFEUxLEMlXi+wyTWW2aReL1d5LkaRKc=;
        b=6Bwm1Bc+0RThkEefhJ6fk21pCpTQ4YmAJGiybKknIPSdXgPQEKeq4mpNN6+mKTtSoGKSMw
        AdRP9hx4313xIGAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4749139B3;
        Tue, 13 Sep 2022 04:41:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2GeNIhMKIGO/SQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 13 Sep 2022 04:41:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Miklos Szeredi" <mszeredi@redhat.com>
Cc:     "Al Viro" <viro@ZenIV.linux.org.uk>,
        "Xavier Roche" <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: fix link vs. rename race
In-reply-to: <20220221082002.508392-1-mszeredi@redhat.com>
References: <20220221082002.508392-1-mszeredi@redhat.com>
Date:   Tue, 13 Sep 2022 14:41:51 +1000
Message-id: <166304411168.30452.12018495245762529070@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 21 Feb 2022, Miklos Szeredi wrote:
> There has been a longstanding race condition between rename(2) and link(2),
> when those operations are done in parallel:
>=20
> 1. Moving a file to an existing target file (eg. mv file target)
> 2. Creating a link from the target file to a third file (eg. ln target
>    link)
>=20
> By the time vfs_link() locks the target inode, it might already be unlinked
> by rename.  This results in vfs_link() returning -ENOENT in order to
> prevent linking to already unlinked files.  This check was introduced in
> v2.6.39 by commit aae8a97d3ec3 ("fs: Don't allow to create hardlink for
> deleted file").
>=20
> This breaks apparent atomicity of rename(2), which is described in
> standards and the man page:
>=20
>     "If newpath already exists, it will be atomically replaced, so that
>      there is no point at which another process attempting to access
>      newpath will find it missing."
>=20
> The simplest fix is to exclude renames for the complete link operation.

Alternately, lock the "from" directory as well as the "to" directory.
That would mean using lock_rename() and generally copying the structure
of do_renameat2() into do_linkat()

I wonder if you could get a similar race trying to create a file in
(empty directory) /tmp/foo while /tmp/bar was being renamed over it.

NeilBrown


>=20
> This patch introduces a global rw_semaphore that is locked for read in
> rename and for write in link.  To prevent excessive contention, do not take
> the lock in link on the first try.  If the source of the link was found to
> be unlinked, then retry with the lock held.
>=20
> Reuse the lock_rename()/unlock_rename() helpers for the rename part.  This
> however needs special treatment for stacking fs (overlayfs, ecryptfs) to
> prevent possible deadlocks.  Introduce [un]lock_rename_stacked() for this
> purpose.
>=20
> Reproducer can be found at:
>=20
>   https://lore.kernel.org/all/20220216131814.GA2463301@xavier-xps/
>=20
> Reported-by: Xavier Roche <xavier.roche@algolia.com>
> Link: https://lore.kernel.org/all/20220214210708.GA2167841@xavier-xps/
> Fixes: aae8a97d3ec3 ("fs: Don't allow to create hardlink for deleted file")
> Tested-by: Xavier Roche <xavier.roche@algolia.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/ecryptfs/inode.c    |  4 ++--
>  fs/namei.c             | 35 ++++++++++++++++++++++++++++++++---
>  fs/overlayfs/copy_up.c |  4 ++--
>  fs/overlayfs/dir.c     | 12 ++++++------
>  fs/overlayfs/util.c    |  4 ++--
>  include/linux/namei.h  |  4 ++++
>  6 files changed, 48 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 16d50dface59..f5c37599bd40 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -596,7 +596,7 @@ ecryptfs_rename(struct user_namespace *mnt_userns, stru=
ct inode *old_dir,
> =20
>  	target_inode =3D d_inode(new_dentry);
> =20
> -	trap =3D lock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
> +	trap =3D lock_rename_stacked(lower_old_dir_dentry, lower_new_dir_dentry);
>  	dget(lower_new_dentry);
>  	rc =3D -EINVAL;
>  	if (lower_old_dentry->d_parent !=3D lower_old_dir_dentry)
> @@ -631,7 +631,7 @@ ecryptfs_rename(struct user_namespace *mnt_userns, stru=
ct inode *old_dir,
>  		fsstack_copy_attr_all(old_dir, d_inode(lower_old_dir_dentry));
>  out_lock:
>  	dput(lower_new_dentry);
> -	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
> +	unlock_rename_stacked(lower_old_dir_dentry, lower_new_dir_dentry);
>  	return rc;
>  }
> =20
> diff --git a/fs/namei.c b/fs/namei.c
> index 3f1829b3ab5b..27e671c354a6 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -122,6 +122,8 @@
>   * PATH_MAX includes the nul terminator --RR.
>   */
> =20
> +static DECLARE_RWSEM(link_rwsem);
> +
>  #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
> =20
>  struct filename *
> @@ -2954,10 +2956,11 @@ static inline int may_create(struct user_namespace =
*mnt_userns,
>  	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
>  }
> =20
> +
>  /*
>   * p1 and p2 should be directories on the same fs.
>   */
> -struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
> +struct dentry *lock_rename_stacked(struct dentry *p1, struct dentry *p2)
>  {
>  	struct dentry *p;
> =20
> @@ -2986,9 +2989,16 @@ struct dentry *lock_rename(struct dentry *p1, struct=
 dentry *p2)
>  	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
>  	return NULL;
>  }
> +EXPORT_SYMBOL(lock_rename_stacked);
> +
> +struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
> +{
> +	down_read(&link_rwsem);
> +	return lock_rename_stacked(p1, p2);
> +}
>  EXPORT_SYMBOL(lock_rename);
> =20
> -void unlock_rename(struct dentry *p1, struct dentry *p2)
> +void unlock_rename_stacked(struct dentry *p1, struct dentry *p2)
>  {
>  	inode_unlock(p1->d_inode);
>  	if (p1 !=3D p2) {
> @@ -2996,6 +3006,13 @@ void unlock_rename(struct dentry *p1, struct dentry =
*p2)
>  		mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
>  	}
>  }
> +EXPORT_SYMBOL(unlock_rename_stacked);
> +
> +void unlock_rename(struct dentry *p1, struct dentry *p2)
> +{
> +	unlock_rename_stacked(p1, p2);
> +	up_read(&link_rwsem);
> +}
>  EXPORT_SYMBOL(unlock_rename);
> =20
>  /**
> @@ -4456,6 +4473,7 @@ int do_linkat(int olddfd, struct filename *old, int n=
ewdfd,
>  	struct path old_path, new_path;
>  	struct inode *delegated_inode =3D NULL;
>  	int how =3D 0;
> +	bool lock =3D false;
>  	int error;
> =20
>  	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) !=3D 0) {
> @@ -4474,10 +4492,13 @@ int do_linkat(int olddfd, struct filename *old, int=
 newdfd,
> =20
>  	if (flags & AT_SYMLINK_FOLLOW)
>  		how |=3D LOOKUP_FOLLOW;
> +retry_lock:
> +	if (lock)
> +		down_write(&link_rwsem);
>  retry:
>  	error =3D filename_lookup(olddfd, old, how, &old_path, NULL);
>  	if (error)
> -		goto out_putnames;
> +		goto out_unlock_link;
> =20
>  	new_dentry =3D filename_create(newdfd, new, &new_path,
>  					(how & LOOKUP_REVAL));
> @@ -4511,8 +4532,16 @@ int do_linkat(int olddfd, struct filename *old, int =
newdfd,
>  		how |=3D LOOKUP_REVAL;
>  		goto retry;
>  	}
> +	if (!lock && error =3D=3D -ENOENT) {
> +		path_put(&old_path);
> +		lock =3D true;
> +		goto retry_lock;
> +	}
>  out_putpath:
>  	path_put(&old_path);
> +out_unlock_link:
> +	if (lock)
> +		up_write(&link_rwsem);
>  out_putnames:
>  	putname(old);
>  	putname(new);
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index e040970408d4..911c3cec43c2 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -670,7 +670,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *=
c)
> =20
>  	/* workdir and destdir could be the same when copying up to indexdir */
>  	err =3D -EIO;
> -	if (lock_rename(c->workdir, c->destdir) !=3D NULL)
> +	if (lock_rename_stacked(c->workdir, c->destdir) !=3D NULL)
>  		goto unlock;
> =20
>  	err =3D ovl_prep_cu_creds(c->dentry, &cc);
> @@ -711,7 +711,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *=
c)
>  	if (S_ISDIR(inode->i_mode))
>  		ovl_set_flag(OVL_WHITEOUTS, inode);
>  unlock:
> -	unlock_rename(c->workdir, c->destdir);
> +	unlock_rename_stacked(c->workdir, c->destdir);
> =20
>  	return err;
> =20
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index f18490813170..fea397666174 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -416,7 +416,7 @@ static struct dentry *ovl_clear_empty(struct dentry *de=
ntry,
> =20
>  	ovl_cleanup_whiteouts(upper, list);
>  	ovl_cleanup(wdir, upper);
> -	unlock_rename(workdir, upperdir);
> +	unlock_rename_stacked(workdir, upperdir);
> =20
>  	/* dentry's upper doesn't match now, get rid of it */
>  	d_drop(dentry);
> @@ -427,7 +427,7 @@ static struct dentry *ovl_clear_empty(struct dentry *de=
ntry,
>  	ovl_cleanup(wdir, opaquedir);
>  	dput(opaquedir);
>  out_unlock:
> -	unlock_rename(workdir, upperdir);
> +	unlock_rename_stacked(workdir, upperdir);
>  out:
>  	return ERR_PTR(err);
>  }
> @@ -551,7 +551,7 @@ static int ovl_create_over_whiteout(struct dentry *dent=
ry, struct inode *inode,
>  out_dput:
>  	dput(upper);
>  out_unlock:
> -	unlock_rename(workdir, upperdir);
> +	unlock_rename_stacked(workdir, upperdir);
>  out:
>  	if (!hardlink) {
>  		posix_acl_release(acl);
> @@ -790,7 +790,7 @@ static int ovl_remove_and_whiteout(struct dentry *dentr=
y,
>  out_dput_upper:
>  	dput(upper);
>  out_unlock:
> -	unlock_rename(workdir, upperdir);
> +	unlock_rename_stacked(workdir, upperdir);
>  out_dput:
>  	dput(opaquedir);
>  out:
> @@ -1187,7 +1187,7 @@ static int ovl_rename(struct user_namespace *mnt_user=
ns, struct inode *olddir,
>  		}
>  	}
> =20
> -	trap =3D lock_rename(new_upperdir, old_upperdir);
> +	trap =3D lock_rename_stacked(new_upperdir, old_upperdir);
> =20
>  	olddentry =3D lookup_one_len(old->d_name.name, old_upperdir,
>  				   old->d_name.len);
> @@ -1281,7 +1281,7 @@ static int ovl_rename(struct user_namespace *mnt_user=
ns, struct inode *olddir,
>  out_dput_old:
>  	dput(olddentry);
>  out_unlock:
> -	unlock_rename(new_upperdir, old_upperdir);
> +	unlock_rename_stacked(new_upperdir, old_upperdir);
>  out_revert_creds:
>  	revert_creds(old_cred);
>  	if (update_nlink)
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index f48284a2a896..9358282278b1 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -930,13 +930,13 @@ int ovl_lock_rename_workdir(struct dentry *workdir, s=
truct dentry *upperdir)
>  		goto err;
> =20
>  	/* Workdir should not be subdir of upperdir and vice versa */
> -	if (lock_rename(workdir, upperdir) !=3D NULL)
> +	if (lock_rename_stacked(workdir, upperdir) !=3D NULL)
>  		goto err_unlock;
> =20
>  	return 0;
> =20
>  err_unlock:
> -	unlock_rename(workdir, upperdir);
> +	unlock_rename_stacked(workdir, upperdir);
>  err:
>  	pr_err("failed to lock workdir+upperdir\n");
>  	return -EIO;
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index e89329bb3134..0a87bb0d56ce 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -77,6 +77,10 @@ extern int follow_up(struct path *);
>  extern struct dentry *lock_rename(struct dentry *, struct dentry *);
>  extern void unlock_rename(struct dentry *, struct dentry *);
> =20
> +/* Special version of the above for stacking filesystems */
> +extern struct dentry *lock_rename_stacked(struct dentry *, struct dentry *=
);
> +extern void unlock_rename_stacked(struct dentry *, struct dentry *);
> +
>  extern int __must_check nd_jump_link(struct path *path);
> =20
>  static inline void nd_terminate_link(void *name, size_t len, size_t maxlen)
> --=20
> 2.34.1
>=20
>=20
