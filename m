Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DE276343C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 12:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjGZKtq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 06:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjGZKtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:49:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023D8212D;
        Wed, 26 Jul 2023 03:49:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8220461A74;
        Wed, 26 Jul 2023 10:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C146FC433C7;
        Wed, 26 Jul 2023 10:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690368579;
        bh=2dfZYSb7SXGkMObcrfK4A6YGYYkg6dqmecGQRsejOiM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nlKvlRJi9pgRH+6o2ty2NFubBfldMbVG92auYpu5rLnD7BHetmDU9VKYf6sT5m1Lw
         9z8nCOyKDUhe+AxVNHBpmS6G2dD8dJzX+rJji+yaVhGIr54DxEXSQ8Naflc5EqkZXm
         oMx3oc62nv59pQtbN4bwMHejWgL7/m3Ho4bpcELYand2g/GOfOpkZzzw8UfdxYWu0D
         cRTsM9p1Zy07AvT/CyljCNa9RVmM27z0pUsiEqV9U73RULJVyyi4xsIH17O7pCeT7K
         2vuopndVreRhDXzjIQrwQNhfO8nP7E7b/KPlwkbJ15nkxHodGzG9a+hw+kyXBC4p1M
         3/8b9w+0ZBn0Q==
Message-ID: <4d4a9a3c59ed2efe5132c01f08a7719c2ea60f04.camel@kernel.org>
Subject: Re: [PATCH v6 1/7] fs: pass the request_mask to generic_fillattr
From:   Jeff Layton <jlayton@kernel.org>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Anthony Iliopoulos <ailiop@suse.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org
Date:   Wed, 26 Jul 2023 06:49:36 -0400
In-Reply-To: <1da81657-2ee1-0ef3-c222-66e00d021c24@linux.alibaba.com>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
         <20230725-mgctime-v6-1-a794c2b7abca@kernel.org>
         <1da81657-2ee1-0ef3-c222-66e00d021c24@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
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

On Wed, 2023-07-26 at 17:40 +0800, Joseph Qi wrote:
>=20
> On 7/25/23 10:58 PM, Jeff Layton wrote:
> > generic_fillattr just fills in the entire stat struct indiscriminately
> > today, copying data from the inode. There is at least one attribute
> > (STATX_CHANGE_COOKIE) that can have side effects when it is reported,
> > and we're looking at adding more with the addition of multigrain
> > timestamps.
> >=20
> > Add a request_mask argument to generic_fillattr and have most callers
> > just pass in the value that is passed to getattr. Have other callers
> > (e.g. ksmbd) just pass in STATX_BASIC_STATS. Also move the setting of
> > STATX_CHANGE_COOKIE into generic_fillattr.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/9p/vfs_inode.c       |  4 ++--
> >  fs/9p/vfs_inode_dotl.c  |  4 ++--
> >  fs/afs/inode.c          |  2 +-
> >  fs/btrfs/inode.c        |  2 +-
> >  fs/ceph/inode.c         |  2 +-
> >  fs/coda/inode.c         |  3 ++-
> >  fs/ecryptfs/inode.c     |  5 +++--
> >  fs/erofs/inode.c        |  2 +-
> >  fs/exfat/file.c         |  2 +-
> >  fs/ext2/inode.c         |  2 +-
> >  fs/ext4/inode.c         |  2 +-
> >  fs/f2fs/file.c          |  2 +-
> >  fs/fat/file.c           |  2 +-
> >  fs/fuse/dir.c           |  2 +-
> >  fs/gfs2/inode.c         |  2 +-
> >  fs/hfsplus/inode.c      |  2 +-
> >  fs/kernfs/inode.c       |  2 +-
> >  fs/libfs.c              |  4 ++--
> >  fs/minix/inode.c        |  2 +-
> >  fs/nfs/inode.c          |  2 +-
> >  fs/nfs/namespace.c      |  3 ++-
> >  fs/ntfs3/file.c         |  2 +-
> >  fs/ocfs2/file.c         |  2 +-
> >  fs/orangefs/inode.c     |  2 +-
> >  fs/proc/base.c          |  4 ++--
> >  fs/proc/fd.c            |  2 +-
> >  fs/proc/generic.c       |  2 +-
> >  fs/proc/proc_net.c      |  2 +-
> >  fs/proc/proc_sysctl.c   |  2 +-
> >  fs/proc/root.c          |  3 ++-
> >  fs/smb/client/inode.c   |  2 +-
> >  fs/smb/server/smb2pdu.c | 22 +++++++++++-----------
> >  fs/smb/server/vfs.c     |  3 ++-
> >  fs/stat.c               | 18 ++++++++++--------
> >  fs/sysv/itree.c         |  3 ++-
> >  fs/ubifs/dir.c          |  2 +-
> >  fs/udf/symlink.c        |  2 +-
> >  fs/vboxsf/utils.c       |  2 +-
> >  include/linux/fs.h      |  2 +-
> >  mm/shmem.c              |  2 +-
> >  40 files changed, 70 insertions(+), 62 deletions(-)
> >=20
>=20
> ...
>=20
> > diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> > index 1b337ebce4df..8184499ae7a5 100644
> > --- a/fs/ocfs2/file.c
> > +++ b/fs/ocfs2/file.c
> > @@ -1319,7 +1319,7 @@ int ocfs2_getattr(struct mnt_idmap *idmap, const =
struct path *path,
> >  		goto bail;
> >  	}
> > =20
> > -	generic_fillattr(&nop_mnt_idmap, inode, stat);
> > +	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
>=20
> For ocfs2 part, looks fine to me.
>=20
> Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>=20
> >  	/*
> >  	 * If there is inline data in the inode, the inode will normally not
> >  	 * have data blocks allocated (it may have an external xattr block).
>=20
> ...
>=20
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 8c2b30af19f5..062f311b5386 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -29,6 +29,7 @@
> >  /**
> >   * generic_fillattr - Fill in the basic attributes from the inode stru=
ct
> >   * @idmap:	idmap of the mount the inode was found from
> > + * @req_mask	statx request_mask
>=20
> s/req_mask/request_mask
>=20

Thanks. Fixed in my tree.

> >   * @inode:	Inode to use as the source
> >   * @stat:	Where to fill in the attributes
> >   *
> > @@ -42,8 +43,8 @@
> >   * uid and gid filds. On non-idmapped mounts or if permission checking=
 is to be
> >   * performed on the raw inode simply passs @nop_mnt_idmap.
> >   */
> > -void generic_fillattr(struct mnt_idmap *idmap, struct inode *inode,
> > -		      struct kstat *stat)
> > +void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
> > +		      struct inode *inode, struct kstat *stat)
> >  {
> >  	vfsuid_t vfsuid =3D i_uid_into_vfsuid(idmap, inode);
> >  	vfsgid_t vfsgid =3D i_gid_into_vfsgid(idmap, inode);
> > @@ -61,6 +62,12 @@ void generic_fillattr(struct mnt_idmap *idmap, struc=
t inode *inode,
> >  	stat->ctime =3D inode_get_ctime(inode);
> >  	stat->blksize =3D i_blocksize(inode);
> >  	stat->blocks =3D inode->i_blocks;
> > +
> > +	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> > +		stat->result_mask |=3D STATX_CHANGE_COOKIE;
> > +		stat->change_cookie =3D inode_query_iversion(inode);
> > +	}
> > +
> >  }
> >  EXPORT_SYMBOL(generic_fillattr);
> > =20
> > @@ -123,17 +130,12 @@ int vfs_getattr_nosec(const struct path *path, st=
ruct kstat *stat,
> >  	stat->attributes_mask |=3D (STATX_ATTR_AUTOMOUNT |
> >  				  STATX_ATTR_DAX);
> > =20
> > -	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> > -		stat->result_mask |=3D STATX_CHANGE_COOKIE;
> > -		stat->change_cookie =3D inode_query_iversion(inode);
> > -	}
> > -
> >  	idmap =3D mnt_idmap(path->mnt);
> >  	if (inode->i_op->getattr)
> >  		return inode->i_op->getattr(idmap, path, stat,
> >  					    request_mask, query_flags);
> > =20
> > -	generic_fillattr(idmap, inode, stat);
> > +	generic_fillattr(idmap, request_mask, inode, stat);
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(vfs_getattr_nosec);
>=20
> ...
>=20

--=20
Jeff Layton <jlayton@kernel.org>
