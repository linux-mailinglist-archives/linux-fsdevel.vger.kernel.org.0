Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4472C52A0C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345531AbiEQLyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 07:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345332AbiEQLyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 07:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C273335B;
        Tue, 17 May 2022 04:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E6E161011;
        Tue, 17 May 2022 11:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB748C34100;
        Tue, 17 May 2022 11:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652788450;
        bh=NQsTMvV0FQAE5+/fQ7iCblYSI/nthXnAKetXnUiNeTo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z0XuF0XcX44EPzJ0UvEwxrW3tq+ZlPaSRCfGzhDLjYRwX4NaG6vy2CZPKBQgshuLf
         AeuKyxOHtNlheGtuvWQxOTeBaeFMGX5+pyj7kAJOFA1gnrReDL7pxXOis9CldpHoKe
         aIp04D18E5w/0E13vORYE7QuzqBzpQ8ztRUTvw5ZjyxVQXX76YZavg83K8HP52GfiL
         ly+/YUaDiabdwp4a8GS3M/tdntYWkWD4USIE8qGlCxpKvMmzJjdaRY6yXWN15qPyED
         IuyhcqjbvRzFX5qY3jczKFNId7VPUbn5iow/0+SebfhSSuUEvbLdOm7/BXIiTmGlVo
         6XFmEllo2S0Zg==
Message-ID: <bd2ea8d6467ff8ea98c7bd048fd417aced86e20d.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] ceph: wait the first reply of inflight
 unlink/rmdir
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, viro@zeniv.linux.org.uk
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Date:   Tue, 17 May 2022 07:54:08 -0400
In-Reply-To: <bce4ef40-277f-8bc0-6cdb-3435eddddf44@redhat.com>
References: <20220517010316.81483-1-xiubli@redhat.com>
         <20220517010316.81483-3-xiubli@redhat.com>
         <a2d05d80e30831e915e707a48520139500befc2b.camel@kernel.org>
         <bce4ef40-277f-8bc0-6cdb-3435eddddf44@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-05-17 at 19:49 +0800, Xiubo Li wrote:
> On 5/17/22 7:35 PM, Jeff Layton wrote:
> > On Tue, 2022-05-17 at 09:03 +0800, Xiubo Li wrote:
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
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Xiubo Li <xiubli@redhat.com>
> > > ---
> > >   fs/ceph/dir.c        | 70 +++++++++++++++++++++++++++++++++++++++--=
--
> > >   fs/ceph/file.c       |  5 ++++
> > >   fs/ceph/mds_client.c | 71 +++++++++++++++++++++++++++++++++++++++++=
+++
> > >   fs/ceph/mds_client.h |  1 +
> > >   fs/ceph/super.c      |  3 ++
> > >   fs/ceph/super.h      | 19 ++++++++----
> > >   6 files changed, 159 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > > index eae417d71136..88e0048d719e 100644
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
> > > @@ -1071,9 +1088,27 @@ static int ceph_link(struct dentry *old_dentry=
, struct inode *dir,
> > >   static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
> > >   				 struct ceph_mds_request *req)
> > >   {
> > > +	struct dentry *dentry =3D req->r_dentry;
> > > +	struct ceph_fs_client *fsc =3D ceph_sb_to_client(dentry->d_sb);
> > > +	struct ceph_dentry_info *di =3D ceph_dentry(dentry);
> > >   	int result =3D req->r_err ? req->r_err :
> > >   			le32_to_cpu(req->r_reply_info.head->result);
> > >  =20
> > > +	if (test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags)) {
> > Shouldn't this bit always be set in this case? Maybe this should be a
> > WARN_ON ?
>=20
> Okay, maybe a pr_warn() as you mentioned below.
>=20
>=20
> >=20
> > > +		BUG_ON(req->r_op !=3D CEPH_MDS_OP_UNLINK);
> > Note that this will crash the box in some environments (e.g. RHEL
> > kernels). I really advise against adding new BUG_ON calls unless the
> > situation is so dire that the machine can't (or shouldn't) continue on.
> >=20
> > In this case, we got a bogus reply from the MDS. I think throwing a
> > pr_warn message and erroring out the unlink would be better.
>=20
> Makes sense.
>=20
>=20
> > > +
> > > +		spin_lock(&fsc->async_unlink_conflict_lock);
> > > +		hash_del_rcu(&di->hnode);
> > > +		spin_unlock(&fsc->async_unlink_conflict_lock);
> > > +
> > > +		spin_lock(&dentry->d_lock);
> > > +		di->flags &=3D ~CEPH_DENTRY_ASYNC_UNLINK;
> > > +		wake_up_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT);
> > > +		spin_unlock(&dentry->d_lock);
> > > +
> > > +		synchronize_rcu();
> > Why do you need to synchronize_rcu here?
> >=20
> > I guess the concern is that once we put the req, then it could put the
> > dentry and free di while someone is still walking the hash?
>=20
> Yeah, right, we just need to make sure while iterating the hashtable the=
=20
> di memory won't be released after this.
>=20
> > > +	}
> > > +
> > >   	if (result =3D=3D -EJUKEBOX)
> > >   		goto out;
> > >  =20
> > > @@ -1081,7 +1116,7 @@ static void ceph_async_unlink_cb(struct ceph_md=
s_client *mdsc,
> > >   	if (result) {
> > >   		int pathlen =3D 0;
> > >   		u64 base =3D 0;
> > > -		char *path =3D ceph_mdsc_build_path(req->r_dentry, &pathlen,
> > > +		char *path =3D ceph_mdsc_build_path(dentry, &pathlen,
> > >   						  &base, 0);
> > >  =20
> > >   		/* mark error on parent + clear complete */
> > > @@ -1089,13 +1124,13 @@ static void ceph_async_unlink_cb(struct ceph_=
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
> > > @@ -1180,6 +1215,8 @@ static int ceph_unlink(struct inode *dir, struc=
t dentry *dentry)
> > >  =20
> > >   	if (try_async && op =3D=3D CEPH_MDS_OP_UNLINK &&
> > >   	    (req->r_dir_caps =3D get_caps_for_async_unlink(dir, dentry))) =
{
> > > +		struct ceph_dentry_info *di =3D ceph_dentry(dentry);
> > > +
> > >   		dout("async unlink on %llu/%.*s caps=3D%s", ceph_ino(dir),
> > >   		     dentry->d_name.len, dentry->d_name.name,
> > >   		     ceph_cap_string(req->r_dir_caps));
> > > @@ -1187,6 +1224,16 @@ static int ceph_unlink(struct inode *dir, stru=
ct dentry *dentry)
> > >   		req->r_callback =3D ceph_async_unlink_cb;
> > >   		req->r_old_inode =3D d_inode(dentry);
> > >   		ihold(req->r_old_inode);
> > > +
> > > +		spin_lock(&dentry->d_lock);
> > > +		di->flags |=3D CEPH_DENTRY_ASYNC_UNLINK;
> > > +		spin_unlock(&dentry->d_lock);
> > > +
> > > +		spin_lock(&fsc->async_unlink_conflict_lock);
> > > +		hash_add_rcu(fsc->async_unlink_conflict, &di->hnode,
> > > +			     dentry->d_name.hash);
> > > +		spin_unlock(&fsc->async_unlink_conflict_lock);
> > > +
> > >   		err =3D ceph_mdsc_submit_request(mdsc, dir, req);
> > >   		if (!err) {
> > >   			/*
> > > @@ -1198,6 +1245,15 @@ static int ceph_unlink(struct inode *dir, stru=
ct dentry *dentry)
> > >   		} else if (err =3D=3D -EJUKEBOX) {
> > >   			try_async =3D false;
> > >   			ceph_mdsc_put_request(req);
> > > +
> > > +			spin_lock(&dentry->d_lock);
> > > +			di->flags &=3D ~CEPH_DENTRY_ASYNC_UNLINK;
> > > +			spin_unlock(&dentry->d_lock);
> > > +
> > > +			spin_lock(&fsc->async_unlink_conflict_lock);
> > > +			hash_del_rcu(&di->hnode);
> > > +			spin_unlock(&fsc->async_unlink_conflict_lock);
> > > +
> > >   			goto retry;
> > >   		}
> > >   	} else {
> > > @@ -1237,6 +1293,10 @@ static int ceph_rename(struct user_namespace *=
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
> > > index e8c87dea0551..bb67f3d5a337 100644
> > > --- a/fs/ceph/mds_client.c
> > > +++ b/fs/ceph/mds_client.c
> > > @@ -655,6 +655,77 @@ static void destroy_reply_info(struct ceph_mds_r=
eply_info_parsed *info)
> > >   	free_pages((unsigned long)info->dir_entries, get_order(info->dir_b=
uf_size));
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
> > > +		WARN_ON_ONCE(!test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags));
> > A stack trace is not likely to be useful here. This means that we have
> > an entry in the hash that looks invalid. The stack trace of the waiter
> > probably won't tell us anything useful.
> >=20
> > What might be better is to pr_warn some info about the dentry in this
> > case. Maybe the name, parent inode, etc...
> Sure.
> >=20
> > > +
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
> > > +	dout("%s dentry %p:%pd conflict with old %p:%pd\n", __func__,
> > > +	     dentry, dentry, found, found);
> > > +
> > > +	err =3D wait_on_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT,
> > > +			  TASK_INTERRUPTIBLE);
> > > +	dput(found);
> > > +	return err;
> > > +}
> > > +
> > >  =20
> > >   /*
> > >    * sessions
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
> > > index b73b4f75462c..6542b71f8627 100644
> > > --- a/fs/ceph/super.c
> > > +++ b/fs/ceph/super.c
> > > @@ -816,6 +816,9 @@ static struct ceph_fs_client *create_fs_client(st=
ruct ceph_mount_options *fsopt,
> > >   	if (!fsc->cap_wq)
> > >   		goto fail_inode_wq;
> > >  =20
> > > +	hash_init(fsc->async_unlink_conflict);
> > > +	spin_lock_init(&fsc->async_unlink_conflict_lock);
> > > +
> > >   	spin_lock(&ceph_fsc_lock);
> > >   	list_add_tail(&fsc->metric_wakeup, &ceph_fsc_list);
> > >   	spin_unlock(&ceph_fsc_lock);
> > > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > > index 506d52633627..c10adb7c1cde 100644
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
> > Wow, that's 4k buckets. The hashtable alone will take 32k of memory on
> > 64 bit arch.
>=20
> Okay, I miss reading the DECLARE_HASHTABLE macro, I thought this will be=
=20
> the item number of the hash table arrary.
>=20
>=20
> > I doubt you need this large a hashtable, particularly given that this i=
s
> > per-superblock. In most cases, we'll just have a few of these in flight
> > at a time.
>=20
> A global hashtable ? And set the order to 8 ?

Per-sb is fine, IMO. 6-8 bits sounds reasonable.

>=20
> > >   struct ceph_fs_client {
> > >   	struct super_block *sb;
> > >  =20
> > > @@ -124,6 +127,9 @@ struct ceph_fs_client {
> > >   	struct workqueue_struct *inode_wq;
> > >   	struct workqueue_struct *cap_wq;
> > >  =20
> > > +	DECLARE_HASHTABLE(async_unlink_conflict, CEPH_ASYNC_CREATE_CONFLICT=
_BITS);
> > > +	spinlock_t async_unlink_conflict_lock;
> > > +
> > >   #ifdef CONFIG_DEBUG_FS
> > >   	struct dentry *debugfs_dentry_lru, *debugfs_caps;
> > >   	struct dentry *debugfs_congestion_kb;
> > > @@ -281,7 +287,8 @@ struct ceph_dentry_info {
> > >   	struct dentry *dentry;
> > >   	struct ceph_mds_session *lease_session;
> > >   	struct list_head lease_list;
> > > -	unsigned flags;
> > > +	struct hlist_node hnode;
> > > +	unsigned long flags;
> > >   	int lease_shared_gen;
> > >   	u32 lease_gen;
> > >   	u32 lease_seq;
> > > @@ -290,10 +297,12 @@ struct ceph_dentry_info {
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
