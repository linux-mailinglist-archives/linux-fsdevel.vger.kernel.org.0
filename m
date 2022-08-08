Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F19558C63C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 12:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbiHHKSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiHHKSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:18:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D2FDF85;
        Mon,  8 Aug 2022 03:18:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22EC6B80E38;
        Mon,  8 Aug 2022 10:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0127C43470;
        Mon,  8 Aug 2022 10:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659953897;
        bh=NeqZRYiD9+QFszEb0HDM46ke3bHl/YmdCD/826WagaA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bayUb3SXYtM1CEKJnQhutAqSXWfGamnU+2f3VI6Lu7xB7XXv8f7UDn0kdPabDRRnH
         sH2CBxWVzae7kpqcOnMWmok3cVAkIiYwaHOPbtMrEB5AK9NmRqKP4M6V0ZX5t9z0CQ
         HU/dC+XuBtCdaW+yaO2wCP6HuVq6y8Pby2f5MwEfsVPr85C1cyYQ0tBtBGqKOrjvEU
         joiWmLrIJNsOly31/qgnmGlLhk/8vgbKji02eOMH7ZFq1D9i/PTWVylQCshOi97owx
         B1/jHVHhVbdmSgV+VUGzRWQXWkopnzqMl71JkcNdWi45wJ0l0xaJklGNFSiH0jF8BO
         Bag/xMSkTZcBA==
Message-ID: <beeaa2b135fc9a1b411a8ad208d70ba5e9708d08.camel@kernel.org>
Subject: Re: [RFC PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, lczerner@redhat.com, bxue@redhat.com,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Date:   Mon, 08 Aug 2022 06:18:15 -0400
In-Reply-To: <8a87ee82-fa04-6b99-8716-9acf24446c5a@redhat.com>
References: <20220805183543.274352-1-jlayton@kernel.org>
         <20220805183543.274352-2-jlayton@kernel.org>
         <8a87ee82-fa04-6b99-8716-9acf24446c5a@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-08-08 at 10:09 +0800, Xiubo Li wrote:
> On 8/6/22 2:35 AM, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> >=20
> > Claim one of the spare fields in struct statx to hold a 64-bit change
> > attribute. When statx requests this attribute, do an
> > inode_query_iversion and fill the result in the field.
> >=20
> > Also update the test-statx.c program to fetch the change attribute as
> > well.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   fs/stat.c                 | 7 +++++++
> >   include/linux/stat.h      | 1 +
> >   include/uapi/linux/stat.h | 3 ++-
> >   samples/vfs/test-statx.c  | 4 +++-
> >   4 files changed, 13 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 9ced8860e0f3..976e0a59ab23 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -17,6 +17,7 @@
> >   #include <linux/syscalls.h>
> >   #include <linux/pagemap.h>
> >   #include <linux/compat.h>
> > +#include <linux/iversion.h>
> >  =20
> >   #include <linux/uaccess.h>
> >   #include <asm/unistd.h>
> > @@ -118,6 +119,11 @@ int vfs_getattr_nosec(const struct path *path, str=
uct kstat *stat,
> >   	stat->attributes_mask |=3D (STATX_ATTR_AUTOMOUNT |
> >   				  STATX_ATTR_DAX);
> >  =20
> > +	if ((request_mask & STATX_CHGATTR) && IS_I_VERSION(inode)) {
> > +		stat->result_mask |=3D STATX_CHGATTR;
> > +		stat->chgattr =3D inode_query_iversion(inode);
> > +	}
> > +
> >   	mnt_userns =3D mnt_user_ns(path->mnt);
> >   	if (inode->i_op->getattr)
> >   		return inode->i_op->getattr(mnt_userns, path, stat,
> > @@ -611,6 +617,7 @@ cp_statx(const struct kstat *stat, struct statx __u=
ser *buffer)
> >   	tmp.stx_dev_major =3D MAJOR(stat->dev);
> >   	tmp.stx_dev_minor =3D MINOR(stat->dev);
> >   	tmp.stx_mnt_id =3D stat->mnt_id;
> > +	tmp.stx_chgattr =3D stat->chgattr;
> >  =20
> >   	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
> >   }
> > diff --git a/include/linux/stat.h b/include/linux/stat.h
> > index 7df06931f25d..4a17887472f6 100644
> > --- a/include/linux/stat.h
> > +++ b/include/linux/stat.h
> > @@ -50,6 +50,7 @@ struct kstat {
> >   	struct timespec64 btime;			/* File creation time */
> >   	u64		blocks;
> >   	u64		mnt_id;
> > +	u64		chgattr;
> >   };
> >  =20
> >   #endif
> > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > index 1500a0f58041..b45243a0fbc5 100644
> > --- a/include/uapi/linux/stat.h
> > +++ b/include/uapi/linux/stat.h
> > @@ -124,7 +124,7 @@ struct statx {
> >   	__u32	stx_dev_minor;
> >   	/* 0x90 */
> >   	__u64	stx_mnt_id;
> > -	__u64	__spare2;
> > +	__u64	stx_chgattr;	/* Inode change attribute */
> >   	/* 0xa0 */
> >   	__u64	__spare3[12];	/* Spare space for future expansion */
> >   	/* 0x100 */
> > @@ -152,6 +152,7 @@ struct statx {
> >   #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat=
 struct */
> >   #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
> >   #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
> > +#define STATX_CHGATTR		0x00002000U	/* Want/git stx_chgattr */
>=20
> s/git/get/ ?
>=20

Muscle-memory typo. Fixed in my tree.

> >  =20
> >   #define STATX__RESERVED		0x80000000U	/* Reserved for future struct st=
atx expansion */
> >  =20
> > diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
> > index 49c7a46cee07..767208d2f564 100644
> > --- a/samples/vfs/test-statx.c
> > +++ b/samples/vfs/test-statx.c
> > @@ -109,6 +109,8 @@ static void dump_statx(struct statx *stx)
> >   		printf(" Inode: %-11llu", (unsigned long long) stx->stx_ino);
> >   	if (stx->stx_mask & STATX_NLINK)
> >   		printf(" Links: %-5u", stx->stx_nlink);
> > +	if (stx->stx_mask & STATX_CHGATTR)
> > +		printf(" Change Attr: 0x%llx", stx->stx_chgattr);
> >   	if (stx->stx_mask & STATX_TYPE) {
> >   		switch (stx->stx_mode & S_IFMT) {
> >   		case S_IFBLK:
> > @@ -218,7 +220,7 @@ int main(int argc, char **argv)
> >   	struct statx stx;
> >   	int ret, raw =3D 0, atflag =3D AT_SYMLINK_NOFOLLOW;
> >  =20
> > -	unsigned int mask =3D STATX_BASIC_STATS | STATX_BTIME;
> > +	unsigned int mask =3D STATX_BASIC_STATS | STATX_BTIME | STATX_CHGATTR=
;
> >  =20
> >   	for (argv++; *argv; argv++) {
> >   		if (strcmp(*argv, "-F") =3D=3D 0) {
>=20

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
