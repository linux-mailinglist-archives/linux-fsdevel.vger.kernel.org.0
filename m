Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C1598DEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 22:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbiHRUZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 16:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345920AbiHRUYx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:24:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD4131DCB;
        Thu, 18 Aug 2022 13:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0AF9B821B2;
        Thu, 18 Aug 2022 20:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D03C433D6;
        Thu, 18 Aug 2022 20:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660854289;
        bh=rhCcE6BsFr9jeqwgKfyrstDmdjKZAbCUvhIibEhSVuc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qwRvDuv64pB3FXUAC8nsVZdNvYDAKxDL/d3BSKEvicIcbUEnWQBG3Ji/Eq4l9+sYY
         VQwnIKlP04OIRHNU7AWlL1r4XVc0DBNJkQc6Zj/l/3hvYCG9ZEerzLAWcIxjW6TMjZ
         A/1X/e0pMC2IPpAKLDbPHNszA7i+eXLJil1xzzLSfYW4vWOtDZBXMJZ+oDsAGeTrTm
         X1GD5mWmFdvvjWA3j6gTgTtI35QTFDlS5xVjNoIOT7tf/RyAmKiLXndRv+NMOTnQ2P
         7oi1HJ0naV1HZmvIhMZ6Aog9a8qtSNVyAYMKGJV+UveU7f5I2D0SL3mVyQn7KEdpB1
         wKpRyF0CsBVQQ==
Message-ID: <f064c27a105b7cef5ccf7e844095a4fe212014ce.camel@kernel.org>
Subject: Re: [PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        Trond Myklebust <trondmy@gmail.com>,
        Dave Chinner <dchinner@redhat.com>
Date:   Thu, 18 Aug 2022 16:24:47 -0400
In-Reply-To: <20220816134419.xra4krb3jwlm4npk@wittgenstein>
References: <20220816132759.43248-1-jlayton@kernel.org>
         <20220816132759.43248-2-jlayton@kernel.org>
         <20220816134419.xra4krb3jwlm4npk@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Tue, 2022-08-16 at 15:44 +0200, Christian Brauner wrote:
> On Tue, Aug 16, 2022 at 09:27:56AM -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> >=20
> > Claim one of the spare fields in struct statx to hold a 64-bit change
> > attribute. When statx requests this attribute, do an
> > inode_query_iversion and fill the result in the field.
> >=20
> > Also update the test-statx.c program to display the change attribute an=
d
> > the mountid as well.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/stat.c                 | 7 +++++++
> >  include/linux/stat.h      | 1 +
> >  include/uapi/linux/stat.h | 3 ++-
> >  samples/vfs/test-statx.c  | 8 ++++++--
> >  4 files changed, 16 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/stat.c b/fs/stat.c
> > index 9ced8860e0f3..7c3d063c31ba 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/compat.h>
> > +#include <linux/iversion.h>
> > =20
> >  #include <linux/uaccess.h>
> >  #include <asm/unistd.h>
> > @@ -118,6 +119,11 @@ int vfs_getattr_nosec(const struct path *path, str=
uct kstat *stat,
> >  	stat->attributes_mask |=3D (STATX_ATTR_AUTOMOUNT |
> >  				  STATX_ATTR_DAX);
> > =20
> > +	if ((request_mask & STATX_CHANGE_ATTR) && IS_I_VERSION(inode)) {
> > +		stat->result_mask |=3D STATX_CHANGE_ATTR;
> > +		stat->change_attr =3D inode_query_iversion(inode);
> > +	}
> > +
> >  	mnt_userns =3D mnt_user_ns(path->mnt);
> >  	if (inode->i_op->getattr)
> >  		return inode->i_op->getattr(mnt_userns, path, stat,
> > @@ -611,6 +617,7 @@ cp_statx(const struct kstat *stat, struct statx __u=
ser *buffer)
> >  	tmp.stx_dev_major =3D MAJOR(stat->dev);
> >  	tmp.stx_dev_minor =3D MINOR(stat->dev);
> >  	tmp.stx_mnt_id =3D stat->mnt_id;
> > +	tmp.stx_change_attr =3D stat->change_attr;
> > =20
> >  	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
> >  }
> > diff --git a/include/linux/stat.h b/include/linux/stat.h
> > index 7df06931f25d..7b444c2ad0ad 100644
> > --- a/include/linux/stat.h
> > +++ b/include/linux/stat.h
> > @@ -50,6 +50,7 @@ struct kstat {
> >  	struct timespec64 btime;			/* File creation time */
> >  	u64		blocks;
> >  	u64		mnt_id;
> > +	u64		change_attr;
> >  };
> > =20
> >  #endif
> > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > index 1500a0f58041..fd839ec76aa4 100644
> > --- a/include/uapi/linux/stat.h
> > +++ b/include/uapi/linux/stat.h
> > @@ -124,7 +124,7 @@ struct statx {
> >  	__u32	stx_dev_minor;
> >  	/* 0x90 */
> >  	__u64	stx_mnt_id;
> > -	__u64	__spare2;
> > +	__u64	stx_change_attr; /* Inode change attribute */
> >  	/* 0xa0 */
> >  	__u64	__spare3[12];	/* Spare space for future expansion */
> >  	/* 0x100 */
> > @@ -152,6 +152,7 @@ struct statx {
> >  #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat =
struct */
> >  #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
> >  #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
> > +#define STATX_CHANGE_ATTR	0x00002000U	/* Want/got stx_change_attr */
>=20
> I'm a bit worried that STATX_CHANGE_ATTR isn't a good name for the flag
> and field. Or I fail to understand what exact information this will
> expose and how userspace will consume it.
> To me the naming gives the impression that some set of generic
> attributes have changed but given that statx is about querying file
> attributes this becomes confusing.
>=20
> Wouldn't it make more sense this time to expose it as what it is and
> call this STATX_INO_VERSION and __u64 stx_ino_version?

Ok, having thought about this some more, I think this is a reasonable
name. It _does_ sort of imply that this value will increase over time.
That's true of all of the existing implementations, but I think we ought
to define such that there could be alternative implementations.

I'll respin this patch and resend it with a wider audience.

Thanks for the input so far!
--=20
Jeff Layton <jlayton@kernel.org>
