Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09B52C895
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 02:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiESA0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 20:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiESA0Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 20:26:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11B53632C;
        Wed, 18 May 2022 17:26:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76E7BB82256;
        Thu, 19 May 2022 00:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1389CC385A9;
        Thu, 19 May 2022 00:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652919981;
        bh=WOLX/V1AWxWxZSqss1gIU4yDoyPHFyahS7/8PGIDDJA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hSY32PdkqV101RO3Fk+WyFQWColYBFJn7gNQAn781dra+IfP7gJW9hYJkvwGYSJyw
         T0JPE/jZcvP+eD1iAzIj8r7CPZUDqyprw6HsAa/2Rrd6uCxqN3Ju/lYF8uZyIGtils
         JmZb/VS7FuPHx2Tbi8QMcHF9Sf9Nn/oGo0P4Oo0JrFZnulZZPNO939j9wmXPzbAZEs
         JwgrGYBadI/y7aJje6x/wsV/KjqTbvmsfAvTnNxvLXnzfoQ57xoBMGeseOAoPReKPf
         BFCWVqIRBm/EAXrq6aD3WvDEyxvihPj5c48SYQmZZQErmpmRUwC21bXtfJpfoyuzEz
         77IgVIDoJGgog==
Message-ID: <f7e96e833921150e6ad22458cfa4504987a35d8e.camel@kernel.org>
Subject: Re: [PATCH v4 2/2] ceph: wait the first reply of inflight async
 unlink
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, idryomov@gmail.com,
        viro@zeniv.linux.org.uk
Cc:     willy@infradead.org, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Date:   Wed, 18 May 2022 20:26:18 -0400
In-Reply-To: <708e3416-8a5a-6dfc-5d06-f82dd48c9913@redhat.com>
References: <20220518144545.246604-1-xiubli@redhat.com>
         <20220518144545.246604-3-xiubli@redhat.com>
         <b6e662fb38e55d3cc5158a7d1a8ea1eb5cdae80e.camel@kernel.org>
         <708e3416-8a5a-6dfc-5d06-f82dd48c9913@redhat.com>
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

On Thu, 2022-05-19 at 08:22 +0800, Xiubo Li wrote:
> On 5/19/22 4:28 AM, Jeff Layton wrote:
> > On Wed, 2022-05-18 at 22:45 +0800, Xiubo Li wrote:
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
-
> > >   fs/ceph/file.c       |  4 +++
> > >   fs/ceph/mds_client.c | 73 +++++++++++++++++++++++++++++++++++++++++=
+++
> > >   fs/ceph/mds_client.h |  1 +
> > >   fs/ceph/super.c      |  3 ++
> > >   fs/ceph/super.h      | 19 +++++++++---
> > >   6 files changed, 160 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > > index eae417d71136..01e7facef9b2 100644
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
> > > +	if (!test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags))
> > > +		pr_warn("%s dentry %p:%pd async unlink bit is not set\n",
> > > +			__func__, dentry, dentry);
> > > +
> > This is a pr_warn so it won't have a "ceph: " prefix or anything
> > prepending it like dout messages do. You should probably prepend this
> > with something like that.
>=20
> The pr_fmt already help add the module name:
>=20
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>=20
> Such as for one current log in ceph:
>=20
> 2022-05-02T17:28:51.006593+00:00 smithi040 kernel: ceph: ceph: async=20
> create failure path=3D(1)client.0/tmp/ceph/src/os/ObjectStore.h result=3D=
-17!
>=20
>=20

My mistake! Removing those is fine.

> >=20
> > > +	spin_lock(&fsc->async_unlink_conflict_lock);
> > > +	hash_del_rcu(&di->hnode);
> > > +	spin_unlock(&fsc->async_unlink_conflict_lock);
> > > +
> > > +	spin_lock(&dentry->d_lock);
> > > +	di->flags &=3D ~CEPH_DENTRY_ASYNC_UNLINK;
> > > +	wake_up_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT);
> > > +	spin_unlock(&dentry->d_lock);
> > > +
> > > +	synchronize_rcu();
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
> > Ditto here: why remove the prefix?
>=20
> The log will be:
>=20
> 2022-05-02T17:28:51.006593+00:00 smithi040 kernel: ceph: ceph: async=20
> create failure path=3D(1)client.0/tmp/ceph/src/os/ObjectStore.h result=3D=
-17!
>=20
> And the prefix "ceph:" is really needed ?
>=20

Nope. Disregard my earlier comment.

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
> > You're clearing the flag here before removing it from the hash. That
> > might end up causing a waiter to trip the pr_warn in
> > ceph_wait_on_conflict_unlink. You probably want to reverse the order
> > here.
>=20
> Sure. Will fix it.
>=20
> -- Xiubo
>=20

--=20
Jeff Layton <jlayton@kernel.org>
