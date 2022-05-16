Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99478528B6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344025AbiEPQ65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343952AbiEPQ6t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:58:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE7E5;
        Mon, 16 May 2022 09:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA3E8B81440;
        Mon, 16 May 2022 16:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D53C385AA;
        Mon, 16 May 2022 16:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652720284;
        bh=H9xB8teURimmfXiDkUtscEpRX59mDROnTxCxMaR7NSM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gISHzlG3LOzqtOhLevfwOKZr9zF3PT7xX7hZTvebM4M3XHzDikfSlSTDQXaJQe9x9
         YC4ywtiBd5CbGoTRtiXgn5pqpMqMZFgyqbOsaFl92Qf8pzhIcUbh3FUAl5IfQcGU0M
         zKafac8yHEuCvmjKBukhDf+imZjWNzedzpIqif35VAsmMmHbD9ayjxC6ILtyMRanwB
         m0OQUSFL/rZZczO1FDv9hs3VLpwAJdt8lsPdcYp1LZULEjT4dGcICHxNPBiruIB5pY
         pvu+NBBCDsZfuoCBFyk8tzA81daKcOioBg6z0kPYD1nS6rQ7Qz2z1j/oU+EfiKeZWK
         v5SUWQ/QnToVQ==
Message-ID: <c0db7d53099d171e8abd5df07c1c177ce22fc303.camel@kernel.org>
Subject: Re: [PATCH 2/2] ceph: wait the first reply of inflight unlink/rmdir
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, viro@zeniv.linux.org.uk
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, mcgrof@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 16 May 2022 12:58:02 -0400
In-Reply-To: <7a37f7a3-586b-5b75-3692-dc391f737a6b@redhat.com>
References: <20220516122046.40655-1-xiubli@redhat.com>
         <20220516122046.40655-3-xiubli@redhat.com>
         <ea6eef767ae6bcdf7aeae7bbc00c2dd89f8c7e5f.camel@kernel.org>
         <7a37f7a3-586b-5b75-3692-dc391f737a6b@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-05-16 at 22:56 +0800, Xiubo Li wrote:
> On 5/16/22 9:23 PM, Jeff Layton wrote:
> > On Mon, 2022-05-16 at 20:20 +0800, Xiubo Li wrote:
> > > In async unlink case the kclient won't wait for the first reply
> > > from MDS and just drop all the links and unhash the dentry and then
> > > succeeds immediately.
> > >=20
> > > For any new create/link/rename,etc requests followed by using the
> > > same file names we must wait for the first reply of the inflight
> > > unlink request, or the MDS possibly will fail these following
> > > requests with -EEXIST if the inflight async unlink request was
> > > delayed for some reasons.
> > >=20
> > > And the worst case is that for the none async openc request it will
> > > successfully open the file if the CDentry hasn't been unlinked yet,
> > > but later the previous delayed async unlink request will remove the
> > > CDenty. That means the just created file is possiblly deleted later
> > > by accident.
> > >=20
> > > We need to wait for the inflight async unlink requests to finish
> > > when creating new files/directories by using the same file names.
> > >=20
> > > URL: https://tracker.ceph.com/issues/55332
> > > Signed-off-by: Xiubo Li <xiubli@redhat.com>
> > > ---
> > >   fs/ceph/dir.c        | 55 +++++++++++++++++++++++++++++++----
> > >   fs/ceph/file.c       |  5 ++++
> > >   fs/ceph/mds_client.c | 69 +++++++++++++++++++++++++++++++++++++++++=
+++
> > >   fs/ceph/mds_client.h |  1 +
> > >   fs/ceph/super.c      |  2 ++
> > >   fs/ceph/super.h      | 18 ++++++++----
> > >   6 files changed, 140 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > > index eae417d71136..20c648406528 100644
> > > --- a/fs/ceph/dir.c
> > > +++ b/fs/ceph/dir.c
> > > @@ -856,6 +856,10 @@ static int ceph_mknod(struct user_namespace *mnt=
_userns, struct inode *dir,
> > >   	if (ceph_snap(dir) !=3D CEPH_NOSNAP)
> > >   		return -EROFS;
> > >  =20
> > > +	err =3D ceph_wait_on_conflict_unlink(dentry);
> > > +	if (err)
> > > +		return err;
> > > +
> > >   	if (ceph_quota_is_max_files_exceeded(dir)) {
> > >   		err =3D -EDQUOT;
> > >   		goto out;
> > > @@ -918,6 +922,10 @@ static int ceph_symlink(struct user_namespace *m=
nt_userns, struct inode *dir,
> > >   	if (ceph_snap(dir) !=3D CEPH_NOSNAP)
> > >   		return -EROFS;
> > >  =20
> > > +	err =3D ceph_wait_on_conflict_unlink(dentry);
> > > +	if (err)
> > > +		return err;
> > > +
> > >   	if (ceph_quota_is_max_files_exceeded(dir)) {
> > >   		err =3D -EDQUOT;
> > >   		goto out;
> > > @@ -968,9 +976,13 @@ static int ceph_mkdir(struct user_namespace *mnt=
_userns, struct inode *dir,
> > >   	struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(dir->i_sb);
> > >   	struct ceph_mds_request *req;
> > >   	struct ceph_acl_sec_ctx as_ctx =3D {};
> > > -	int err =3D -EROFS;
> > > +	int err;
> > >   	int op;
> > >  =20
> > > +	err =3D ceph_wait_on_conflict_unlink(dentry);
> > > +	if (err)
> > > +		return err;
> > > +
> > >   	if (ceph_snap(dir) =3D=3D CEPH_SNAPDIR) {
> > >   		/* mkdir .snap/foo is a MKSNAP */
> > >   		op =3D CEPH_MDS_OP_MKSNAP;
> > > @@ -980,6 +992,7 @@ static int ceph_mkdir(struct user_namespace *mnt_=
userns, struct inode *dir,
> > >   		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
> > >   		op =3D CEPH_MDS_OP_MKDIR;
> > >   	} else {
> > > +		err =3D -EROFS;
> > >   		goto out;
> > >   	}
> > >  =20
> > > @@ -1037,6 +1050,10 @@ static int ceph_link(struct dentry *old_dentry=
, struct inode *dir,
> > >   	struct ceph_mds_request *req;
> > >   	int err;
> > >  =20
> > > +	err =3D ceph_wait_on_conflict_unlink(dentry);
> > > +	if (err)
> > > +		return err;
> > > +
> > >   	if (ceph_snap(dir) !=3D CEPH_NOSNAP)
> > >   		return -EROFS;
> > >  =20
> > > @@ -1071,9 +1088,24 @@ static int ceph_link(struct dentry *old_dentry=
, struct inode *dir,
> > >   static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
> > >   				 struct ceph_mds_request *req)
> > >   {
> > > +	struct dentry *dentry =3D req->r_dentry;
> > > +	struct ceph_dentry_info *di =3D ceph_dentry(dentry);
> > >   	int result =3D req->r_err ? req->r_err :
> > >   			le32_to_cpu(req->r_reply_info.head->result);
> > >  =20
> > > +	if (test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags)) {
> > > +		BUG_ON(req->r_op !=3D CEPH_MDS_OP_UNLINK);
> > > +
> > > +		hash_del_rcu(&di->hnode);
> > > +
> > > +		spin_lock(&dentry->d_lock);
> > > +		di->flags &=3D ~CEPH_DENTRY_ASYNC_UNLINK;
> > > +		wake_up_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT);
> > > +		spin_unlock(&dentry->d_lock);
> > > +
> > > +		synchronize_rcu();
> > > +	}
> > > +
> > >   	if (result =3D=3D -EJUKEBOX)
> > >   		goto out;
> > >  =20
> > > @@ -1081,7 +1113,7 @@ static void ceph_async_unlink_cb(struct ceph_md=
s_client *mdsc,
> > >   	if (result) {
> > >   		int pathlen =3D 0;
> > >   		u64 base =3D 0;
> > > -		char *path =3D ceph_mdsc_build_path(req->r_dentry, &pathlen,
> > > +		char *path =3D ceph_mdsc_build_path(dentry, &pathlen,
> > >   						  &base, 0);
> > >  =20
> > >   		/* mark error on parent + clear complete */
> > > @@ -1089,13 +1121,13 @@ static void ceph_async_unlink_cb(struct ceph_=
mds_client *mdsc,
> > >   		ceph_dir_clear_complete(req->r_parent);
> > >  =20
> > >   		/* drop the dentry -- we don't know its status */
> > > -		if (!d_unhashed(req->r_dentry))
> > > -			d_drop(req->r_dentry);
> > > +		if (!d_unhashed(dentry))
> > > +			d_drop(dentry);
> > >  =20
> > >   		/* mark inode itself for an error (since metadata is bogus) */
> > >   		mapping_set_error(req->r_old_inode->i_mapping, result);
> > >  =20
> > > -		pr_warn("ceph: async unlink failure path=3D(%llx)%s result=3D%d!\n=
",
> > > +		pr_warn("async unlink failure path=3D(%llx)%s result=3D%d!\n",
> > >   			base, IS_ERR(path) ? "<<bad>>" : path, result);
> > >   		ceph_mdsc_free_path(path, pathlen);
> > >   	}
> > > @@ -1189,12 +1221,21 @@ static int ceph_unlink(struct inode *dir, str=
uct dentry *dentry)
> > >   		ihold(req->r_old_inode);
> > >   		err =3D ceph_mdsc_submit_request(mdsc, dir, req);
> > >   		if (!err) {
> > > +			struct ceph_dentry_info *di;
> > > +
> > >   			/*
> > >   			 * We have enough caps, so we assume that the unlink
> > >   			 * will succeed. Fix up the target inode and dcache.
> > >   			 */
> > >   			drop_nlink(inode);
> > >   			d_delete(dentry);
> > > +
> > > +			spin_lock(&dentry->d_lock);
> > > +			di =3D ceph_dentry(dentry);
> > > +			di->flags |=3D CEPH_DENTRY_ASYNC_UNLINK;
> > > +			hash_add_rcu(fsc->async_unlink_conflict, &di->hnode,
> > > +				     dentry->d_name.hash);
> > > +			spin_unlock(&dentry->d_lock);
> > This looks racy. It's possible that the reply comes in before we get to
> > the point of setting this flag. You probably want to do this before
> > calling ceph_mdsc_submit_request, and just unwind it if the submission
> > fails.
>=20
> Ah, right. Will fix it.
>=20
>=20
> >=20
> > Also, you do still need some sort of lock to protect the
> > hash_add/del/_rcu calls.
>=20
> Sure, will fix it too.
>=20
> >   Those don't do any locking on their own. The
> > d_lock is insufficient here since it can't protect the whole list. You
> > may be able to use the i_ceph_lock of the parent though?
>=20
> The hashtable is a global one, so we couldn't use the i_ceph_lock here.=
=20
> I will add one dedicated spin lock for each sb.
>=20
> > >   		} else if (err =3D=3D -EJUKEBOX) {
> > >   			try_async =3D false;
> > >   			ceph_mdsc_put_request(req);
> > > @@ -1237,6 +1278,10 @@ static int ceph_rename(struct user_namespace *=
mnt_userns, struct inode *old_dir,
> > >   	    (!ceph_quota_is_same_realm(old_dir, new_dir)))
> > >   		return -EXDEV;
> > >  =20
> > > +	err =3D ceph_wait_on_conflict_unlink(new_dentry);
> > > +	if (err)
> > > +		return err;
> > > +
> > >   	dout("rename dir %p dentry %p to dir %p dentry %p\n",
> > >   	     old_dir, old_dentry, new_dir, new_dentry);
> > >   	req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > index 8c8226c0feac..47d068e6436a 100644
> > > --- a/fs/ceph/file.c
> > > +++ b/fs/ceph/file.c
> > > @@ -740,6 +740,10 @@ int ceph_atomic_open(struct inode *dir, struct d=
entry *dentry,
> > >   	if (dentry->d_name.len > NAME_MAX)
> > >   		return -ENAMETOOLONG;
> > >  =20
> > > +	err =3D ceph_wait_on_conflict_unlink(dentry);
> > > +	if (err)
> > > +		return err;
> > > +
> > What might be nice here eventually is to not block an async create here=
,
> > but instead queue the request so that it gets transmitted after the
> > async unlink reply comes in.
> >=20
> > That'll be hard to get right though, so this is fine for now.
>=20
> Sure.
>=20
> >=20
> > >   	if (flags & O_CREAT) {
> > >   		if (ceph_quota_is_max_files_exceeded(dir))
> > >   			return -EDQUOT;
> > > @@ -757,6 +761,7 @@ int ceph_atomic_open(struct inode *dir, struct de=
ntry *dentry,
> > >   		/* If it's not being looked up, it's negative */
> > >   		return -ENOENT;
> > >   	}
> > > +
> > >   retry:
> > >   	/* do the open */
> > >   	req =3D prepare_open_request(dir->i_sb, flags, mode);
> > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > index e8c87dea0551..0ae0e0110eb4 100644
> > > --- a/fs/ceph/mds_client.c
> > > +++ b/fs/ceph/mds_client.c
> > > @@ -468,6 +468,75 @@ static int ceph_parse_deleg_inos(void **p, void =
*end,
> > >   	return -EIO;
> > >   }
> > >  =20
> > > +/*
> > > + * In async unlink case the kclient won't wait for the first reply
> > > + * from MDS and just drop all the links and unhash the dentry and th=
en
> > > + * succeeds immediately.
> > > + *
> > > + * For any new create/link/rename,etc requests followed by using the
> > > + * same file names we must wait for the first reply of the inflight
> > > + * unlink request, or the MDS possibly will fail these following
> > > + * requests with -EEXIST if the inflight async unlink request was
> > > + * delayed for some reasons.
> > > + *
> > > + * And the worst case is that for the none async openc request it wi=
ll
> > > + * successfully open the file if the CDentry hasn't been unlinked ye=
t,
> > > + * but later the previous delayed async unlink request will remove t=
he
> > > + * CDenty. That means the just created file is possiblly deleted lat=
er
> > > + * by accident.
> > > + *
> > > + * We need to wait for the inflight async unlink requests to finish
> > > + * when creating new files/directories by using the same file names.
> > > + */
> > > +int ceph_wait_on_conflict_unlink(struct dentry *dentry)
> > > +{
> > > +	struct ceph_fs_client *fsc =3D ceph_sb_to_client(dentry->d_sb);
> > > +	struct dentry *pdentry =3D dentry->d_parent;
> > > +	struct dentry *udentry, *found =3D NULL;
> > > +	struct ceph_dentry_info *di;
> > > +	struct qstr dname;
> > > +	u32 hash =3D dentry->d_name.hash;
> > > +	int err;
> > > +
> > > +	dname.name =3D dentry->d_name.name;
> > > +	dname.len =3D dentry->d_name.len;
> > > +
> > > +	rcu_read_lock();
> > > +	hash_for_each_possible_rcu(fsc->async_unlink_conflict, di,
> > > +				   hnode, hash) {
> > > +		udentry =3D di->dentry;
> > > +
> > > +		spin_lock(&udentry->d_lock);
> > > +		if (udentry->d_name.hash !=3D hash)
> > > +			goto next;
> > > +		if (unlikely(udentry->d_parent !=3D pdentry))
> > > +			goto next;
> > > +		if (!hash_hashed(&di->hnode))
> > > +			goto next;
> > > +
> > > +		if (!test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags))
> > > +			goto next;
> > > +
> > Maybe this should be a warning? Will we ever have entries in this
> > hashtable that don't have this bit set?
>=20
> Just before we take "spin_lock(&udentry->d_lock)" the udentry could be=
=20
> already removed from hashtable and the bit was cleared ?
>=20
>=20


The point is that you're removing the dentry from the hash before you
clear the flag, so there should never be a dentry in the hash that has
the flag cleared.

> >=20
> > > +		if (d_compare(pdentry, udentry, &dname))
> > > +			goto next;
> > > +
> > > +		spin_unlock(&udentry->d_lock);
> > > +		found =3D dget(udentry);
> > > +		break;
> > > +next:
> > > +		spin_unlock(&udentry->d_lock);
> > > +	}
> > > +	rcu_read_unlock();
> > > +
> > > +	if (likely(!found))
> > > +		return 0;
> > > +
> > > +	err =3D wait_on_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT,
> > > +			  TASK_INTERRUPTIBLE);
> > > +	dput(found);
> > > +	return err;
> > > +}
> > > +
> > >   u64 ceph_get_deleg_ino(struct ceph_mds_session *s)
> > >   {
> > >   	unsigned long ino;
> > > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > > index 33497846e47e..d1ae679c52c3 100644
> > > --- a/fs/ceph/mds_client.h
> > > +++ b/fs/ceph/mds_client.h
> > > @@ -582,6 +582,7 @@ static inline int ceph_wait_on_async_create(struc=
t inode *inode)
> > >   			   TASK_INTERRUPTIBLE);
> > >   }
> > >  =20
> > > +extern int ceph_wait_on_conflict_unlink(struct dentry *dentry);
> > >   extern u64 ceph_get_deleg_ino(struct ceph_mds_session *session);
> > >   extern int ceph_restore_deleg_ino(struct ceph_mds_session *session,=
 u64 ino);
> > >   #endif
> > > diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> > > index b73b4f75462c..7ae65001f04c 100644
> > > --- a/fs/ceph/super.c
> > > +++ b/fs/ceph/super.c
> > > @@ -816,6 +816,8 @@ static struct ceph_fs_client *create_fs_client(st=
ruct ceph_mount_options *fsopt,
> > >   	if (!fsc->cap_wq)
> > >   		goto fail_inode_wq;
> > >  =20
> > > +	hash_init(fsc->async_unlink_conflict);
> > > +
> > >   	spin_lock(&ceph_fsc_lock);
> > >   	list_add_tail(&fsc->metric_wakeup, &ceph_fsc_list);
> > >   	spin_unlock(&ceph_fsc_lock);
> > > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > > index 506d52633627..58bbb5df42da 100644
> > > --- a/fs/ceph/super.h
> > > +++ b/fs/ceph/super.h
> > > @@ -19,6 +19,7 @@
> > >   #include <linux/security.h>
> > >   #include <linux/netfs.h>
> > >   #include <linux/fscache.h>
> > > +#include <linux/hashtable.h>
> > >  =20
> > >   #include <linux/ceph/libceph.h>
> > >  =20
> > > @@ -99,6 +100,8 @@ struct ceph_mount_options {
> > >   	char *mon_addr;
> > >   };
> > >  =20
> > > +#define CEPH_ASYNC_CREATE_CONFLICT_BITS 12
> > > +
> > >   struct ceph_fs_client {
> > >   	struct super_block *sb;
> > >  =20
> > > @@ -124,6 +127,8 @@ struct ceph_fs_client {
> > >   	struct workqueue_struct *inode_wq;
> > >   	struct workqueue_struct *cap_wq;
> > >  =20
> > > +	DECLARE_HASHTABLE(async_unlink_conflict, CEPH_ASYNC_CREATE_CONFLICT=
_BITS);
> > > +
> > >   #ifdef CONFIG_DEBUG_FS
> > >   	struct dentry *debugfs_dentry_lru, *debugfs_caps;
> > >   	struct dentry *debugfs_congestion_kb;
> > > @@ -281,7 +286,8 @@ struct ceph_dentry_info {
> > >   	struct dentry *dentry;
> > >   	struct ceph_mds_session *lease_session;
> > >   	struct list_head lease_list;
> > > -	unsigned flags;
> > > +	struct hlist_node hnode;
> > > +	unsigned long flags;
> > >   	int lease_shared_gen;
> > >   	u32 lease_gen;
> > >   	u32 lease_seq;
> > > @@ -290,10 +296,12 @@ struct ceph_dentry_info {
> > >   	u64 offset;
> > >   };
> > >  =20
> > > -#define CEPH_DENTRY_REFERENCED		1
> > > -#define CEPH_DENTRY_LEASE_LIST		2
> > > -#define CEPH_DENTRY_SHRINK_LIST		4
> > > -#define CEPH_DENTRY_PRIMARY_LINK	8
> > > +#define CEPH_DENTRY_REFERENCED		(1 << 0)
> > > +#define CEPH_DENTRY_LEASE_LIST		(1 << 1)
> > > +#define CEPH_DENTRY_SHRINK_LIST		(1 << 2)
> > > +#define CEPH_DENTRY_PRIMARY_LINK	(1 << 3)
> > > +#define CEPH_DENTRY_ASYNC_UNLINK_BIT	(4)
> > > +#define CEPH_DENTRY_ASYNC_UNLINK	(1 << CEPH_DENTRY_ASYNC_UNLINK_BIT)
> > >  =20
> > >   struct ceph_inode_xattrs_info {
> > >   	/*
>=20

--=20
Jeff Layton <jlayton@kernel.org>
