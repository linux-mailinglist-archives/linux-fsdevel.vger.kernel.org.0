Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F4D5F5241
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 12:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJEKIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJEKIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:08:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F435A2FC;
        Wed,  5 Oct 2022 03:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C27D5615C0;
        Wed,  5 Oct 2022 10:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28711C433D6;
        Wed,  5 Oct 2022 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664964517;
        bh=lmKpPN4jK/UeVcNOmKsqFBoj/He9Psi/sFsMJE7FYS4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=txxMe3DoW42qelwB3CR0n4mx2jieb7LcK5K7H9w4RC9fWiWnQAGh4DOgJDkDpPRdw
         2eF5ZfOP9KJU7DDh60uhjDZdtQbm4irf1+60pr3kmSsOizXX7S5JUzuj4DjRkC1OsR
         rRAcOmT3SrmAoTssUj1txx7BjHhHZ5tZgtFCi2Rit/NLTMGihFzZltPlWHmg9htS09
         +g1VVyZgs4b6VgkmFrQvt1CZAGVjbJTEHEwI35V0DzamWff6L9tdbe9g4kDYdahP+0
         3FWc2cPb/MdFCF4SOHvNK9yyBllVYzJcYvnsivn7MlFWYO3dkoS3e6mulSYtFQ1SDZ
         V5lDlJ1xgQQ0A==
Message-ID: <8442c467b93d0b3e37ecb2142755d274252884b6.camel@kernel.org>
Subject: Re: [PATCH v6 7/9] vfs: expose STATX_VERSION to userland
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Date:   Wed, 05 Oct 2022 06:08:33 -0400
In-Reply-To: <166484055905.14457.14231369028013027820@noble.neil.brown.name>
References: <20220930111840.10695-1-jlayton@kernel.org>
        , <20220930111840.10695-8-jlayton@kernel.org>
         <166484055905.14457.14231369028013027820@noble.neil.brown.name>
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

On Tue, 2022-10-04 at 10:42 +1100, NeilBrown wrote:
> On Fri, 30 Sep 2022, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> >=20
> > Claim one of the spare fields in struct statx to hold a 64-bit inode
> > version attribute. When userland requests STATX_VERSION, copy the
> > value from the kstat struct there, and stop masking off
> > STATX_ATTR_VERSION_MONOTONIC.
> >=20
> > Update the test-statx sample program to output the change attr and
> > MountId.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/stat.c                 | 12 +++---------
> >  include/linux/stat.h      |  9 ---------
> >  include/uapi/linux/stat.h |  6 ++++--
> >  samples/vfs/test-statx.c  |  8 ++++++--
> >  4 files changed, 13 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/fs/stat.c b/fs/stat.c
> > index e7f8cd4b24e1..8396c372022f 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -593,11 +593,9 @@ cp_statx(const struct kstat *stat, struct statx __=
user *buffer)
> > =20
> >  	memset(&tmp, 0, sizeof(tmp));
> > =20
> > -	/* STATX_VERSION is kernel-only for now */
> > -	tmp.stx_mask =3D stat->result_mask & ~STATX_VERSION;
> > +	tmp.stx_mask =3D stat->result_mask;
> >  	tmp.stx_blksize =3D stat->blksize;
> > -	/* STATX_ATTR_VERSION_MONOTONIC is kernel-only for now */
> > -	tmp.stx_attributes =3D stat->attributes & ~STATX_ATTR_VERSION_MONOTON=
IC;
> > +	tmp.stx_attributes =3D stat->attributes;
> >  	tmp.stx_nlink =3D stat->nlink;
> >  	tmp.stx_uid =3D from_kuid_munged(current_user_ns(), stat->uid);
> >  	tmp.stx_gid =3D from_kgid_munged(current_user_ns(), stat->gid);
> > @@ -621,6 +619,7 @@ cp_statx(const struct kstat *stat, struct statx __u=
ser *buffer)
> >  	tmp.stx_mnt_id =3D stat->mnt_id;
> >  	tmp.stx_dio_mem_align =3D stat->dio_mem_align;
> >  	tmp.stx_dio_offset_align =3D stat->dio_offset_align;
> > +	tmp.stx_version =3D stat->version;
> > =20
> >  	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
> >  }
> > @@ -636,11 +635,6 @@ int do_statx(int dfd, struct filename *filename, u=
nsigned int flags,
> >  	if ((flags & AT_STATX_SYNC_TYPE) =3D=3D AT_STATX_SYNC_TYPE)
> >  		return -EINVAL;
> > =20
> > -	/* STATX_VERSION is kernel-only for now. Ignore requests
> > -	 * from userland.
> > -	 */
> > -	mask &=3D ~STATX_VERSION;
> > -
> >  	error =3D vfs_statx(dfd, filename, flags, &stat, mask);
> >  	if (error)
> >  		return error;
> > diff --git a/include/linux/stat.h b/include/linux/stat.h
> > index 4e9428d86a3a..69c79e4fd1b1 100644
> > --- a/include/linux/stat.h
> > +++ b/include/linux/stat.h
> > @@ -54,13 +54,4 @@ struct kstat {
> >  	u32		dio_offset_align;
> >  	u64		version;
> >  };
> > -
> > -/* These definitions are internal to the kernel for now. Mainly used b=
y nfsd. */
> > -
> > -/* mask values */
> > -#define STATX_VERSION		0x40000000U	/* Want/got stx_change_attr */
> > -
> > -/* file attribute values */
> > -#define STATX_ATTR_VERSION_MONOTONIC	0x8000000000000000ULL /* version =
monotonically increases */
> > -
> >  #endif
> > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > index 7cab2c65d3d7..4a0a1f27c059 100644
> > --- a/include/uapi/linux/stat.h
> > +++ b/include/uapi/linux/stat.h
> > @@ -127,7 +127,8 @@ struct statx {
> >  	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
> >  	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O *=
/
> >  	/* 0xa0 */
> > -	__u64	__spare3[12];	/* Spare space for future expansion */
> > +	__u64	stx_version; /* Inode change attribute */
> > +	__u64	__spare3[11];	/* Spare space for future expansion */
> >  	/* 0x100 */
> >  };
> > =20
> > @@ -154,6 +155,7 @@ struct statx {
> >  #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
> >  #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
> >  #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment i=
nfo */
> > +#define STATX_VERSION		0x00004000U	/* Want/got stx_version */
> > =20
> >  #define STATX__RESERVED		0x80000000U	/* Reserved for future struct sta=
tx expansion */
> > =20
> > @@ -189,6 +191,6 @@ struct statx {
> >  #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
> >  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
> >  #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state =
*/
> > -
> > +#define STATX_ATTR_VERSION_MONOTONIC	0x00400000 /* stx_version increas=
es w/ every change */
> > =20
> >  #endif /* _UAPI_LINUX_STAT_H */
> > diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
> > index 49c7a46cee07..bdbc371c9774 100644
> > --- a/samples/vfs/test-statx.c
> > +++ b/samples/vfs/test-statx.c
> > @@ -107,6 +107,8 @@ static void dump_statx(struct statx *stx)
> >  	printf("Device: %-15s", buffer);
> >  	if (stx->stx_mask & STATX_INO)
> >  		printf(" Inode: %-11llu", (unsigned long long) stx->stx_ino);
> > +	if (stx->stx_mask & STATX_MNT_ID)
> > +		printf(" MountId: %llx", stx->stx_mnt_id);
> >  	if (stx->stx_mask & STATX_NLINK)
> >  		printf(" Links: %-5u", stx->stx_nlink);
> >  	if (stx->stx_mask & STATX_TYPE) {
> > @@ -145,7 +147,9 @@ static void dump_statx(struct statx *stx)
> >  	if (stx->stx_mask & STATX_CTIME)
> >  		print_time("Change: ", &stx->stx_ctime);
> >  	if (stx->stx_mask & STATX_BTIME)
> > -		print_time(" Birth: ", &stx->stx_btime);
> > +		print_time("Birth: ", &stx->stx_btime);
> > +	if (stx->stx_mask & STATX_VERSION)
> > +		printf("Inode Version: 0x%llx\n", stx->stx_version);
>=20
> Why hex? not decimal?  I don't really care but it seems like an odd choic=
e.
>=20

Habit. You're probably right that this is better viewed in decimal. I'll
change it in the next iteration. We should probably also have this
display the new DIOALIGN fields as well. I'll roll that in too.

> > =20
> >  	if (stx->stx_attributes_mask) {
> >  		unsigned char bits, mbits;
> > @@ -218,7 +222,7 @@ int main(int argc, char **argv)
> >  	struct statx stx;
> >  	int ret, raw =3D 0, atflag =3D AT_SYMLINK_NOFOLLOW;
> > =20
> > -	unsigned int mask =3D STATX_BASIC_STATS | STATX_BTIME;
> > +	unsigned int mask =3D STATX_BASIC_STATS | STATX_BTIME | STATX_MNT_ID =
| STATX_VERSION;
> > =20
> >  	for (argv++; *argv; argv++) {
> >  		if (strcmp(*argv, "-F") =3D=3D 0) {
> > --=20
> > 2.37.3
> >=20
> >=20
>=20
> Reviewed-by: NeilBrown <neilb@suse.de>
>=20
> Thanks,
> NeilBrown

--=20
Jeff Layton <jlayton@kernel.org>
