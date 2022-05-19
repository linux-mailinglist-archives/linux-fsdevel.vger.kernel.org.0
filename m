Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319C752D17C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 13:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbiESLad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 07:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiESLac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 07:30:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EC04F467;
        Thu, 19 May 2022 04:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45E6EB823E2;
        Thu, 19 May 2022 11:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87FAC385AA;
        Thu, 19 May 2022 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652959828;
        bh=Sms09XACd7yd8zjKehxBBYAzAuL4Pp8LUqBmSdhiZQU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MEF165ojs+tXVPIqK9RhYDC0VPX6kqNppki++cdLE6tcZOKXcp97L/v+awZdqsw8p
         g5alO5qShQWnjzmyILAcy2akllhA7B54x3AuNpBykRyltKiF24kRM2t/MnKN/0yzr7
         TRoLykrCUze5203IeI+NcbZz56CKdc5nzkA5C5bbf5S4MqFzQ65OfDhmlBP755N7H8
         kEMPzizOiO6/8+FxRypu5Pv7dLaD7IKqaS4jjMQG3Rhpm85uTUvxpMZpiOH2RbdeEA
         R+RfdboumZBS4xN49kF4jJg34ZB1Nt1yVD8QouMfXubXizw5S6AkQupfU2TpsLBw6A
         iKg/vERAq5dZw==
Message-ID: <f03c8c7ef004ddde6766e43c021183f2d2454d17.camel@kernel.org>
Subject: Re: [PATCH v5 2/2] ceph: wait the first reply of inflight async
 unlink
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, idryomov@gmail.com,
        viro@zeniv.linux.org.uk
Cc:     willy@infradead.org, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Date:   Thu, 19 May 2022 07:30:25 -0400
In-Reply-To: <20220519101847.87907-3-xiubli@redhat.com>
References: <20220519101847.87907-1-xiubli@redhat.com>
         <20220519101847.87907-3-xiubli@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-05-19 at 18:18 +0800, Xiubo Li wrote:
> In async unlink case the kclient won't wait for the first reply
> from MDS and just drop all the links and unhash the dentry and then
> succeeds immediately.
>=20
> For any new create/link/rename,etc requests followed by using the
> same file names we must wait for the first reply of the inflight
> unlink request, or the MDS possibly will fail these following
> requests with -EEXIST if the inflight async unlink request was
> delayed for some reasons.
>=20
> And the worst case is that for the none async openc request it will
> successfully open the file if the CDentry hasn't been unlinked yet,
> but later the previous delayed async unlink request will remove the
> CDenty. That means the just created file is possiblly deleted later
> by accident.
>=20
> We need to wait for the inflight async unlink requests to finish
> when creating new files/directories by using the same file names.
>=20
> URL: https://tracker.ceph.com/issues/55332
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/dir.c        | 79 +++++++++++++++++++++++++++++++++++++++-----
>  fs/ceph/file.c       |  6 +++-
>  fs/ceph/mds_client.c | 75 ++++++++++++++++++++++++++++++++++++++++-
>  fs/ceph/mds_client.h |  1 +
>  fs/ceph/super.c      |  3 ++
>  fs/ceph/super.h      | 19 ++++++++---
>  6 files changed, 167 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index eae417d71136..e7e2ebac330d 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -856,6 +856,10 @@ static int ceph_mknod(struct user_namespace *mnt_use=
rns, struct inode *dir,
>  	if (ceph_snap(dir) !=3D CEPH_NOSNAP)
>  		return -EROFS;
> =20
> +	err =3D ceph_wait_on_conflict_unlink(dentry);
> +	if (err)
> +		return err;
> +
>  	if (ceph_quota_is_max_files_exceeded(dir)) {
>  		err =3D -EDQUOT;
>  		goto out;
> @@ -918,6 +922,10 @@ static int ceph_symlink(struct user_namespace *mnt_u=
serns, struct inode *dir,
>  	if (ceph_snap(dir) !=3D CEPH_NOSNAP)
>  		return -EROFS;
> =20
> +	err =3D ceph_wait_on_conflict_unlink(dentry);
> +	if (err)
> +		return err;
> +
>  	if (ceph_quota_is_max_files_exceeded(dir)) {
>  		err =3D -EDQUOT;
>  		goto out;
> @@ -968,9 +976,13 @@ static int ceph_mkdir(struct user_namespace *mnt_use=
rns, struct inode *dir,
>  	struct ceph_mds_client *mdsc =3D ceph_sb_to_mdsc(dir->i_sb);
>  	struct ceph_mds_request *req;
>  	struct ceph_acl_sec_ctx as_ctx =3D {};
> -	int err =3D -EROFS;
> +	int err;
>  	int op;
> =20
> +	err =3D ceph_wait_on_conflict_unlink(dentry);
> +	if (err)
> +		return err;
> +
>  	if (ceph_snap(dir) =3D=3D CEPH_SNAPDIR) {
>  		/* mkdir .snap/foo is a MKSNAP */
>  		op =3D CEPH_MDS_OP_MKSNAP;
> @@ -980,6 +992,7 @@ static int ceph_mkdir(struct user_namespace *mnt_user=
ns, struct inode *dir,
>  		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
>  		op =3D CEPH_MDS_OP_MKDIR;
>  	} else {
> +		err =3D -EROFS;
>  		goto out;
>  	}
> =20
> @@ -1037,6 +1050,10 @@ static int ceph_link(struct dentry *old_dentry, st=
ruct inode *dir,
>  	struct ceph_mds_request *req;
>  	int err;
> =20
> +	err =3D ceph_wait_on_conflict_unlink(dentry);
> +	if (err)
> +		return err;
> +
>  	if (ceph_snap(dir) !=3D CEPH_NOSNAP)
>  		return -EROFS;
> =20
> @@ -1071,9 +1088,27 @@ static int ceph_link(struct dentry *old_dentry, st=
ruct inode *dir,
>  static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
>  				 struct ceph_mds_request *req)
>  {
> +	struct dentry *dentry =3D req->r_dentry;
> +	struct ceph_fs_client *fsc =3D ceph_sb_to_client(dentry->d_sb);
> +	struct ceph_dentry_info *di =3D ceph_dentry(dentry);
>  	int result =3D req->r_err ? req->r_err :
>  			le32_to_cpu(req->r_reply_info.head->result);
> =20
> +	if (!test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags))
> +		pr_warn("%s dentry %p:%pd async unlink bit is not set\n",
> +			__func__, dentry, dentry);
> +
> +	spin_lock(&fsc->async_unlink_conflict_lock);
> +	hash_del_rcu(&di->hnode);
> +	spin_unlock(&fsc->async_unlink_conflict_lock);
> +
> +	spin_lock(&dentry->d_lock);
> +	di->flags &=3D ~CEPH_DENTRY_ASYNC_UNLINK;
> +	wake_up_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT);
> +	spin_unlock(&dentry->d_lock);
> +
> +	synchronize_rcu();
> +
>  	if (result =3D=3D -EJUKEBOX)
>  		goto out;
> =20
> @@ -1081,7 +1116,7 @@ static void ceph_async_unlink_cb(struct ceph_mds_cl=
ient *mdsc,
>  	if (result) {
>  		int pathlen =3D 0;
>  		u64 base =3D 0;
> -		char *path =3D ceph_mdsc_build_path(req->r_dentry, &pathlen,
> +		char *path =3D ceph_mdsc_build_path(dentry, &pathlen,
>  						  &base, 0);
> =20
>  		/* mark error on parent + clear complete */
> @@ -1089,13 +1124,13 @@ static void ceph_async_unlink_cb(struct ceph_mds_=
client *mdsc,
>  		ceph_dir_clear_complete(req->r_parent);
> =20
>  		/* drop the dentry -- we don't know its status */
> -		if (!d_unhashed(req->r_dentry))
> -			d_drop(req->r_dentry);
> +		if (!d_unhashed(dentry))
> +			d_drop(dentry);
> =20
>  		/* mark inode itself for an error (since metadata is bogus) */
>  		mapping_set_error(req->r_old_inode->i_mapping, result);
> =20
> -		pr_warn("ceph: async unlink failure path=3D(%llx)%s result=3D%d!\n",
> +		pr_warn("async unlink failure path=3D(%llx)%s result=3D%d!\n",
>  			base, IS_ERR(path) ? "<<bad>>" : path, result);
>  		ceph_mdsc_free_path(path, pathlen);
>  	}
> @@ -1180,6 +1215,8 @@ static int ceph_unlink(struct inode *dir, struct de=
ntry *dentry)
> =20
>  	if (try_async && op =3D=3D CEPH_MDS_OP_UNLINK &&
>  	    (req->r_dir_caps =3D get_caps_for_async_unlink(dir, dentry))) {
> +		struct ceph_dentry_info *di =3D ceph_dentry(dentry);
> +
>  		dout("async unlink on %llu/%.*s caps=3D%s", ceph_ino(dir),
>  		     dentry->d_name.len, dentry->d_name.name,
>  		     ceph_cap_string(req->r_dir_caps));
> @@ -1187,6 +1224,16 @@ static int ceph_unlink(struct inode *dir, struct d=
entry *dentry)
>  		req->r_callback =3D ceph_async_unlink_cb;
>  		req->r_old_inode =3D d_inode(dentry);
>  		ihold(req->r_old_inode);
> +
> +		spin_lock(&dentry->d_lock);
> +		di->flags |=3D CEPH_DENTRY_ASYNC_UNLINK;
> +		spin_unlock(&dentry->d_lock);
> +
> +		spin_lock(&fsc->async_unlink_conflict_lock);
> +		hash_add_rcu(fsc->async_unlink_conflict, &di->hnode,
> +			     dentry->d_name.hash);
> +		spin_unlock(&fsc->async_unlink_conflict_lock);
> +
>  		err =3D ceph_mdsc_submit_request(mdsc, dir, req);
>  		if (!err) {
>  			/*
> @@ -1195,10 +1242,20 @@ static int ceph_unlink(struct inode *dir, struct =
dentry *dentry)
>  			 */
>  			drop_nlink(inode);
>  			d_delete(dentry);
> -		} else if (err =3D=3D -EJUKEBOX) {
> -			try_async =3D false;
> -			ceph_mdsc_put_request(req);
> -			goto retry;
> +		} else {
> +			spin_lock(&fsc->async_unlink_conflict_lock);
> +			hash_del_rcu(&di->hnode);
> +			spin_unlock(&fsc->async_unlink_conflict_lock);
> +
> +			spin_lock(&dentry->d_lock);
> +			di->flags &=3D ~CEPH_DENTRY_ASYNC_UNLINK;
> +			spin_unlock(&dentry->d_lock);
> +
> +			if (err =3D=3D -EJUKEBOX) {
> +				try_async =3D false;
> +				ceph_mdsc_put_request(req);
> +				goto retry;
> +			}
>  		}
>  	} else {
>  		set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
> @@ -1237,6 +1294,10 @@ static int ceph_rename(struct user_namespace *mnt_=
userns, struct inode *old_dir,
>  	    (!ceph_quota_is_same_realm(old_dir, new_dir)))
>  		return -EXDEV;
> =20
> +	err =3D ceph_wait_on_conflict_unlink(new_dentry);
> +	if (err)
> +		return err;
> +
>  	dout("rename dir %p dentry %p to dir %p dentry %p\n",
>  	     old_dir, old_dentry, new_dir, new_dentry);
>  	req =3D ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 8c8226c0feac..0f863e1d6ae9 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -569,7 +569,7 @@ static void ceph_async_create_cb(struct ceph_mds_clie=
nt *mdsc,
>  		char *path =3D ceph_mdsc_build_path(req->r_dentry, &pathlen,
>  						  &base, 0);
> =20
> -		pr_warn("ceph: async create failure path=3D(%llx)%s result=3D%d!\n",
> +		pr_warn("async create failure path=3D(%llx)%s result=3D%d!\n",
>  			base, IS_ERR(path) ? "<<bad>>" : path, result);
>  		ceph_mdsc_free_path(path, pathlen);
> =20
> @@ -740,6 +740,10 @@ int ceph_atomic_open(struct inode *dir, struct dentr=
y *dentry,
>  	if (dentry->d_name.len > NAME_MAX)
>  		return -ENAMETOOLONG;
> =20
> +	err =3D ceph_wait_on_conflict_unlink(dentry);
> +	if (err)
> +		return err;
> +
>  	if (flags & O_CREAT) {
>  		if (ceph_quota_is_max_files_exceeded(dir))
>  			return -EDQUOT;
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index e8c87dea0551..9ea2dcc02710 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -456,7 +456,7 @@ static int ceph_parse_deleg_inos(void **p, void *end,
>  				dout("added delegated inode 0x%llx\n",
>  				     start - 1);
>  			} else if (err =3D=3D -EBUSY) {
> -				pr_warn("ceph: MDS delegated inode 0x%llx more than once.\n",
> +				pr_warn("MDS delegated inode 0x%llx more than once.\n",
>  					start - 1);
>  			} else {
>  				return err;
> @@ -655,6 +655,79 @@ static void destroy_reply_info(struct ceph_mds_reply=
_info_parsed *info)
>  	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_si=
ze));
>  }
> =20
> +/*
> + * In async unlink case the kclient won't wait for the first reply
> + * from MDS and just drop all the links and unhash the dentry and then
> + * succeeds immediately.
> + *
> + * For any new create/link/rename,etc requests followed by using the
> + * same file names we must wait for the first reply of the inflight
> + * unlink request, or the MDS possibly will fail these following
> + * requests with -EEXIST if the inflight async unlink request was
> + * delayed for some reasons.
> + *
> + * And the worst case is that for the none async openc request it will
> + * successfully open the file if the CDentry hasn't been unlinked yet,
> + * but later the previous delayed async unlink request will remove the
> + * CDenty. That means the just created file is possiblly deleted later
> + * by accident.
> + *
> + * We need to wait for the inflight async unlink requests to finish
> + * when creating new files/directories by using the same file names.
> + */
> +int ceph_wait_on_conflict_unlink(struct dentry *dentry)
> +{
> +	struct ceph_fs_client *fsc =3D ceph_sb_to_client(dentry->d_sb);
> +	struct dentry *pdentry =3D dentry->d_parent;
> +	struct dentry *udentry, *found =3D NULL;
> +	struct ceph_dentry_info *di;
> +	struct qstr dname;
> +	u32 hash =3D dentry->d_name.hash;
> +	int err;
> +
> +	dname.name =3D dentry->d_name.name;
> +	dname.len =3D dentry->d_name.len;
> +
> +	rcu_read_lock();
> +	hash_for_each_possible_rcu(fsc->async_unlink_conflict, di,
> +				   hnode, hash) {
> +		udentry =3D di->dentry;
> +
> +		spin_lock(&udentry->d_lock);
> +		if (udentry->d_name.hash !=3D hash)
> +			goto next;
> +		if (unlikely(udentry->d_parent !=3D pdentry))
> +			goto next;
> +		if (!hash_hashed(&di->hnode))
> +			goto next;
> +
> +		if (!test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags))
> +			pr_warn("%s dentry %p:%pd async unlink bit is not set\n",
> +				__func__, dentry, dentry);
> +
> +		if (d_compare(pdentry, udentry, &dname))
> +			goto next;
> +
> +		spin_unlock(&udentry->d_lock);
> +		found =3D dget(udentry);
> +		break;
> +next:
> +		spin_unlock(&udentry->d_lock);
> +	}
> +	rcu_read_unlock();
> +
> +	if (likely(!found))
> +		return 0;
> +
> +	dout("%s dentry %p:%pd conflict with old %p:%pd\n", __func__,
> +	     dentry, dentry, found, found);
> +
> +	err =3D wait_on_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT,
> +			  TASK_KILLABLE);
> +	dput(found);
> +	return err;
> +}
> +
> =20
>  /*
>   * sessions
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 33497846e47e..d1ae679c52c3 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -582,6 +582,7 @@ static inline int ceph_wait_on_async_create(struct in=
ode *inode)
>  			   TASK_INTERRUPTIBLE);
>  }
> =20
> +extern int ceph_wait_on_conflict_unlink(struct dentry *dentry);
>  extern u64 ceph_get_deleg_ino(struct ceph_mds_session *session);
>  extern int ceph_restore_deleg_ino(struct ceph_mds_session *session, u64 =
ino);
>  #endif
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index b73b4f75462c..6542b71f8627 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -816,6 +816,9 @@ static struct ceph_fs_client *create_fs_client(struct=
 ceph_mount_options *fsopt,
>  	if (!fsc->cap_wq)
>  		goto fail_inode_wq;
> =20
> +	hash_init(fsc->async_unlink_conflict);
> +	spin_lock_init(&fsc->async_unlink_conflict_lock);
> +
>  	spin_lock(&ceph_fsc_lock);
>  	list_add_tail(&fsc->metric_wakeup, &ceph_fsc_list);
>  	spin_unlock(&ceph_fsc_lock);
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 506d52633627..251e726ec628 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -19,6 +19,7 @@
>  #include <linux/security.h>
>  #include <linux/netfs.h>
>  #include <linux/fscache.h>
> +#include <linux/hashtable.h>
> =20
>  #include <linux/ceph/libceph.h>
> =20
> @@ -99,6 +100,8 @@ struct ceph_mount_options {
>  	char *mon_addr;
>  };
> =20
> +#define CEPH_ASYNC_CREATE_CONFLICT_BITS 8
> +
>  struct ceph_fs_client {
>  	struct super_block *sb;
> =20
> @@ -124,6 +127,9 @@ struct ceph_fs_client {
>  	struct workqueue_struct *inode_wq;
>  	struct workqueue_struct *cap_wq;
> =20
> +	DECLARE_HASHTABLE(async_unlink_conflict, CEPH_ASYNC_CREATE_CONFLICT_BIT=
S);
> +	spinlock_t async_unlink_conflict_lock;
> +
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *debugfs_dentry_lru, *debugfs_caps;
>  	struct dentry *debugfs_congestion_kb;
> @@ -281,7 +287,8 @@ struct ceph_dentry_info {
>  	struct dentry *dentry;
>  	struct ceph_mds_session *lease_session;
>  	struct list_head lease_list;
> -	unsigned flags;
> +	struct hlist_node hnode;
> +	unsigned long flags;
>  	int lease_shared_gen;
>  	u32 lease_gen;
>  	u32 lease_seq;
> @@ -290,10 +297,12 @@ struct ceph_dentry_info {
>  	u64 offset;
>  };
> =20
> -#define CEPH_DENTRY_REFERENCED		1
> -#define CEPH_DENTRY_LEASE_LIST		2
> -#define CEPH_DENTRY_SHRINK_LIST		4
> -#define CEPH_DENTRY_PRIMARY_LINK	8
> +#define CEPH_DENTRY_REFERENCED		(1 << 0)
> +#define CEPH_DENTRY_LEASE_LIST		(1 << 1)
> +#define CEPH_DENTRY_SHRINK_LIST		(1 << 2)
> +#define CEPH_DENTRY_PRIMARY_LINK	(1 << 3)
> +#define CEPH_DENTRY_ASYNC_UNLINK_BIT	(4)
> +#define CEPH_DENTRY_ASYNC_UNLINK	(1 << CEPH_DENTRY_ASYNC_UNLINK_BIT)
> =20
>  struct ceph_inode_xattrs_info {
>  	/*

Reviewed-by: Jeff Layton <jlayton@kernel.org>
