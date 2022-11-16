Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC4262BB02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 12:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbiKPLKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 06:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiKPLJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:09:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B266253EE5;
        Wed, 16 Nov 2022 02:55:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37A5361C3D;
        Wed, 16 Nov 2022 10:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC38C433C1;
        Wed, 16 Nov 2022 10:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668596143;
        bh=SEruetDyw7jeeWcWUn9e8lbWk5UPrbdXddorDzoL4MU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fZvfEAyCgZ+dwSstpvbGcX1K0oaNOSlvrptgmDS400TvTU5VF2iVWlTfUFuX3TeEf
         a3fiBZY2O8CHCx/mdv9ukInxB96qP5Go4FBWbXKAlyaqGvmq6o4h6D87ZgeH7X76og
         9iqJBGaLChPz7iL0fai8AzRJigACLmlsJ5QhHtLRv6SCSNa8cLCahT0sEKg2+87bDP
         MNnjzy2dUqmezvm7ZNBcy3yxfI+WwjRfaEzsMiTDU4cF60sxWdN5ikrxhNtpL9LvIb
         kbWm3Y1psnLrTRYYlJ/mvjcPf0O5fg669PseQRCppDVP4Oy+3wn/tT+UqhlSBpZhDc
         qEbX6laeuJqSA==
Message-ID: <969b751761988e75b11a75b1f44171305019711a.camel@kernel.org>
Subject: Re: [RFC PATCH] filelock: new helper: vfs_file_has_locks
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, chuck.lever@oracle.com
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Date:   Wed, 16 Nov 2022 05:55:41 -0500
In-Reply-To: <a8c94ba5-c01f-3bb6-0b35-2aee06b9d6e7@redhat.com>
References: <20221114140747.134928-1-jlayton@kernel.org>
         <30355bc8aa4998cb48b34df958837a8f818ceeb0.camel@kernel.org>
         <54b90281-c575-5aee-e886-e4d7b50236f0@redhat.com>
         <4a8720c8a24a9b06adc40fdada9c621fd5d849df.camel@kernel.org>
         <a8c94ba5-c01f-3bb6-0b35-2aee06b9d6e7@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-11-16 at 14:49 +0800, Xiubo Li wrote:
> On 15/11/2022 22:40, Jeff Layton wrote:
> > On Tue, 2022-11-15 at 13:43 +0800, Xiubo Li wrote:
> > > On 15/11/2022 03:46, Jeff Layton wrote:
> > > > On Mon, 2022-11-14 at 09:07 -0500, Jeff Layton wrote:
> > > > > Ceph has a need to know whether a particular file has any locks s=
et on
> > > > > it. It's currently tracking that by a num_locks field in its
> > > > > filp->private_data, but that's problematic as it tries to decreme=
nt this
> > > > > field when releasing locks and that can race with the file being =
torn
> > > > > down.
> > > > >=20
> > > > > Add a new vfs_file_has_locks helper that will scan the flock and =
posix
> > > > > lists, and return true if any of the locks have a fl_file that ma=
tches
> > > > > the given one. Ceph can then call this instead of doing its own
> > > > > tracking.
> > > > >=20
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >    fs/locks.c         | 36 ++++++++++++++++++++++++++++++++++++
> > > > >    include/linux/fs.h |  1 +
> > > > >    2 files changed, 37 insertions(+)
> > > > >=20
> > > > > Xiubo,
> > > > >=20
> > > > > Here's what I was thinking instead of trying to track this within=
 ceph.
> > > > > Most inodes never have locks set, so in most cases this will be a=
 NULL
> > > > > pointer check.
> > > > >=20
> > > > >=20
> > > > >=20
> > > > I went ahead and added a slightly updated version of this this to m=
y
> > > > locks-next branch for now, but...
> > > >=20
> > > > Thinking about this more...I'm not sure this whole concept of what =
the
> > > > ceph code is trying to do makes sense. Locks only conflict if they =
have
> > > > different owners, and POSIX locks are owned by the process. Conside=
r
> > > > this scenario (obviously, this is not a problem with OFD locks).
> > > >=20
> > > > A process has the same file open via two different fds. It sets loc=
k A
> > > > from offset 0..9 via fd 1. Now, same process sets lock B from 10..1=
9 via
> > > > fd 2. The two locks will be merged, because they don't conflict (be=
cause
> > > > it's the same process).
> > > >=20
> > > > Against which fd should the merged lock record be counted?
> > > Thanks Jeff.
> > >=20
> > > For the above example as you mentioned, from my reading of the lock c=
ode
> > > after being merged it will always keep the old file_lock's fl_file.
> > >=20
> > > There is another case that if the Inode already has LockA and LockB:
> > >=20
> > > Lock A --> [0, 9] --> fileA
> > >=20
> > > Lock B --> [15, 20] --> fileB
> > >=20
> > > And then LockC comes:
> > >=20
> > > Lock C --> [8, 16] --> fileC
> > >=20
> > > Then the inode will only have the LockB:
> > >=20
> > > Lock B --> [0, 20] --> fileB.
> > >=20
> > > So the exiting ceph code seems buggy!
> > >=20
> > Yeah, there are a number of ways to end up with a different fl_file tha=
n
> > you started with.
> >  =20
> > > > Would it be better to always check for CEPH_I_ERROR_FILELOCK, even =
when
> > > > the fd hasn't had any locks explicitly set on it?
> > > Maybe we should check whether any POSIX lock exist, if so we should
> > > check CEPH_I_ERROR_FILELOCK always. Or we need to check it depending =
on
> > > each fd ?
> > >=20
> > >=20
> > It was originally added here:
> >=20
> > commit ff5d913dfc7142974eb1694d5fd6284658e46bc6
> > Author: Yan, Zheng <zyan@redhat.com>
> > Date:   Thu Jul 25 20:16:45 2019 +0800
> >=20
> >      ceph: return -EIO if read/write against filp that lost file locks
> >     =20
> >      After mds evicts session, file locks get lost sliently. It's not s=
afe to
> >      let programs continue to do read/write.
> >     =20
> >      Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> >      Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >      Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> >=20
> > So I guess with the current code if you have the file open and set a
> > lock on it, you'll get back EIO when you try to get caps for it, but if
> > you never set a lock on the fd, then you wouldn't get an error. We don'=
t
> > reliably keep track of what fd was used to set a lock (as noted above),
> > so we can't really do what Zheng was trying to do here.
> >=20
> > Having a file where some openers use locking and others don't is a
> > really odd usage pattern though. Locks are like stoplights -- they only
> > work if everyone pays attention to them.
> >=20
> > I think we should probably switch ceph_get_caps to just check whether
> > any locks are set on the file. If there are POSIX/OFD/FLOCK locks on th=
e
> > file at the time, we should set CHECK_FILELOCK, regardless of what fd
> > was used to set the lock.
> >=20
> > In practical terms, we probably want a vfs_inode_has_locks function,
> > that just tests whether the flc_posix and flc_flock lists are empty.
>=20
> Jeff,
>=20
> Yeah, this sounds good to me.
>=20
>=20
> > Maybe something like this instead? Then ceph could call this from
> > ceph_get_caps and set CHECK_FILELOCK if it returns true.
> >=20
> > -------------8<---------------
> >=20
> > [PATCH] filelock: new helper: vfs_inode_has_locks
> >=20
> > Ceph has a need to know whether a particular inode has any locks set on
> > it. It's currently tracking that by a num_locks field in its
> > filp->private_data, but that's problematic as it tries to decrement thi=
s
> > field when releasing locks and that can race with the file being torn
> > down.
> >=20
> > Add a new vfs_inode_has_locks helper that just returns whether any lock=
s
> > are currently held on the inode.
> >=20
> > Cc: Xiubo Li <xiubli@redhat.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/locks.c         | 23 +++++++++++++++++++++++
> >   include/linux/fs.h |  1 +
> >   2 files changed, 24 insertions(+)
> >=20
> > diff --git a/fs/locks.c b/fs/locks.c
> > index 5876c8ff0edc..9ccf89b6c95d 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -2672,6 +2672,29 @@ int vfs_cancel_lock(struct file *filp, struct fi=
le_lock *fl)
> >   }
> >   EXPORT_SYMBOL_GPL(vfs_cancel_lock);
> >  =20
> > +/**
> > + * vfs_inode_has_locks - are any file locks held on @inode?
> > + * @inode: inode to check for locks
> > + *
> > + * Return true if there are any FL_POSIX or FL_FLOCK locks currently
> > + * set on @inode.
> > + */
> > +bool vfs_inode_has_locks(struct inode *inode)
> > +{
> > +	struct file_lock_context *ctx;
> > +	bool ret;
> > +
> > +	ctx =3D smp_load_acquire(&inode->i_flctx);
> > +	if (!ctx)
> > +		return false;
> > +
> > +	spin_lock(&ctx->flc_lock);
> > +	ret =3D !list_empty(&ctx->flc_posix) || !list_empty(&ctx->flc_flock);
> > +	spin_unlock(&ctx->flc_lock);
>=20
> BTW, is the spin_lock/spin_unlock here really needed ?
>=20

We could probably achieve the same effect with barriers, but I doubt
it's worth it. The flc_lock only protects the lists in the
file_lock_context, so it should almost always be uncontended.


> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(vfs_inode_has_locks);
> > +
> >   #ifdef CONFIG_PROC_FS
> >   #include <linux/proc_fs.h>
> >   #include <linux/seq_file.h>
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index e654435f1651..d6cb42b7e91c 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1170,6 +1170,7 @@ extern int locks_delete_block(struct file_lock *)=
;
> >   extern int vfs_test_lock(struct file *, struct file_lock *);
> >   extern int vfs_lock_file(struct file *, unsigned int, struct file_loc=
k *, struct file_lock *);
> >   extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
> > +bool vfs_inode_has_locks(struct inode *inode);
> >   extern int locks_lock_inode_wait(struct inode *inode, struct file_loc=
k *fl);
> >   extern int __break_lease(struct inode *inode, unsigned int flags, uns=
igned int type);
> >   extern void lease_get_mtime(struct inode *, struct timespec64 *time);
>=20
> All the others LGTM.
>=20
> Thanks.
>=20
> - Xiubo
>=20
>=20

Thanks. I'll re-post it "officially" in a bit and will queue it up for
v6.2.
--=20
Jeff Layton <jlayton@kernel.org>
