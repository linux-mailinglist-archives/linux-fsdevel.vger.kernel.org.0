Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF36758DE1F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 20:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbiHISM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 14:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345956AbiHISME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:12:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145482B61F;
        Tue,  9 Aug 2022 11:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7205B817B7;
        Tue,  9 Aug 2022 18:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D54BC433C1;
        Tue,  9 Aug 2022 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660068289;
        bh=s+ZsIaocJsUaJFjFm4CBKMF8tunKkWAAOKS5RQlQwic=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nUtiLryrFDHCGTbuhYMq7e+oqxYoa8dwzvsYvhsuYsL7/jaJztUW38wLJE+8fehPD
         DfG2BGs+GV4Jak5BEfWKyYgmknU+3htBLVvKLgFwnI0C/u7/CRfxUHDLYU3aj7MDwm
         f1NpFcohTqKBTOVebCfZspgpXk67zCszY+G/FQlawU0NpHi4mzN7ewwhIQc+JYzkZ1
         61vDF7FqmgZuR7fk7R6ESzHmrX5xRjhYaNHkOD0MgnnNz3dLjC9wOMmGE9JfhKIOaL
         EdEdiQ80kX6q8IBOswLXfXYZv+tHG13kLNYUEZ7xLxPaBF8t8kNPedubVsK1AdtCB7
         8U4+TqVppAHPQ==
Message-ID: <52c6fb93a0dff332dbc81c4a7d5d9f8ad11e09dc.camel@kernel.org>
Subject: Re: [RFC PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
From:   Jeff Layton <jlayton@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, lczerner@redhat.com, bxue@redhat.com,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fstests <fstests@vger.kernel.org>
Date:   Tue, 09 Aug 2022 14:04:46 -0400
In-Reply-To: <YvJ+WkrtStRujU2/@magnolia>
References: <20220805183543.274352-1-jlayton@kernel.org>
         <20220805183543.274352-2-jlayton@kernel.org>
         <20220805220136.GG3600936@dread.disaster.area>
         <c10e4aa381aea86bb51b005887533e28f9c7302b.camel@redhat.com>
         <33176ee0f896aef889ad1930fb1e008323135a2e.camel@kernel.org>
         <YvJ+WkrtStRujU2/@magnolia>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Tue, 2022-08-09 at 08:33 -0700, Darrick J. Wong wrote:
> On Mon, Aug 08, 2022 at 09:19:05AM -0400, Jeff Layton wrote:
> > On Fri, 2022-08-05 at 18:06 -0400, Jeff Layton wrote:
> > > On Sat, 2022-08-06 at 08:01 +1000, Dave Chinner wrote:
> > > > On Fri, Aug 05, 2022 at 02:35:40PM -0400, Jeff Layton wrote:
> > > > > From: Jeff Layton <jlayton@redhat.com>
> > > > >=20
> > > > > Claim one of the spare fields in struct statx to hold a 64-bit ch=
ange
> > > > > attribute. When statx requests this attribute, do an
> > > > > inode_query_iversion and fill the result in the field.
> > > > >=20
> > > > > Also update the test-statx.c program to fetch the change attribut=
e as
> > > > > well.
> > > > >=20
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  fs/stat.c                 | 7 +++++++
> > > > >  include/linux/stat.h      | 1 +
> > > > >  include/uapi/linux/stat.h | 3 ++-
> > > > >  samples/vfs/test-statx.c  | 4 +++-
> > > > >  4 files changed, 13 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/stat.c b/fs/stat.c
> > > > > index 9ced8860e0f3..976e0a59ab23 100644
> > > > > --- a/fs/stat.c
> > > > > +++ b/fs/stat.c
> > > > > @@ -17,6 +17,7 @@
> > > > >  #include <linux/syscalls.h>
> > > > >  #include <linux/pagemap.h>
> > > > >  #include <linux/compat.h>
> > > > > +#include <linux/iversion.h>
> > > > > =20
> > > > >  #include <linux/uaccess.h>
> > > > >  #include <asm/unistd.h>
> > > > > @@ -118,6 +119,11 @@ int vfs_getattr_nosec(const struct path *pat=
h, struct kstat *stat,
> > > > >  	stat->attributes_mask |=3D (STATX_ATTR_AUTOMOUNT |
> > > > >  				  STATX_ATTR_DAX);
> > > > > =20
> > > > > +	if ((request_mask & STATX_CHGATTR) && IS_I_VERSION(inode)) {
> > > > > +		stat->result_mask |=3D STATX_CHGATTR;
> > > > > +		stat->chgattr =3D inode_query_iversion(inode);
> > > > > +	}
> > > >=20
> > > > If you're going to add generic support for it, shouldn't there be a
> > > > generic test in fstests that ensures that filesystems that advertis=
e
> > > > STATX_CHGATTR support actually behave correctly? Including across
> > > > mounts, and most importantly, that it is made properly stable by
> > > > fsync?
> > > >=20
> > > > i.e. what good is this if different filesystems have random quirks
> > > > that mean it can't be relied on by userspace to tell it changes hav=
e
> > > > occurred?
> > >=20
> > > Absolutely. Being able to better test the i_version field for consist=
ent
> > > behavior is a primary goal. I haven't yet written any yet, but we'd
> > > definitely want something in xfstests if we decide this is worthwhile=
.
> >=20
> > I started writing some tests for this today, and hit a bit of a chicken=
-
> > and-egg problem:
> >=20
> > I'd prefer to use xfs_io for easier maintainability, but the STATX_*
> > constants are defined via UAPI header. Older kernels don't have them an=
d
> > old xfs_io programs don't understand or report this value.
> >=20
> > Should I just write a one-off binary program for xfstests to fetch this
> > value for now, or are we better off merging the patchset first, and the=
n
> > fix xfs_io and then write the tests using the updated xfs_io program?
>=20
> What we've done in the past to support new APIs until they land in
> kernel headers is:
>=20
> Add an autoconf macro to decide if the system header files are recent
> enough to support whatever functionality is needed by xfs_io;
>=20
> Modify the build system to #define OVERRIDE_FUBAR if the system headers
> aren't new enough to have FUBAR; and
>=20
> Modify (or create) the relevant header file to override the system
> header definitions as needed to support building the relevant pieces of
> code.  A year or so after the functionality lands, we can then remove
> the overrides, or just leave them in place until the next time we need
> it.
>=20
> For example, Eric Biggers wanted to teach the fscrypt commands to use a
> new feature he was adding to an existing API, so he AC_DEFUN'd a macro
> that checks to see if the system linux/fs.h *does not* define a
> structure containing the desired field.  If this is the case, it sets
> need_internal_fscrypt_add_key_arg=3Dyes.
>=20
> AC_DEFUN([AC_NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG],
>   [
>     AC_CHECK_TYPE(struct fscrypt_add_key_arg,
>       [
>         AC_CHECK_MEMBER(struct fscrypt_add_key_arg.key_id,
>           ,
>           need_internal_fscrypt_add_key_arg=3Dyes,
>           [#include <linux/fs.h>]
>         )
>       ],,
>       [#include <linux/fs.h>]
>     )
>     AC_SUBST(need_internal_fscrypt_add_key_arg)
>   ])
>=20
> This macro is called from configure.ac.
>=20
> Next, include/builddefs.in was modified to include the selected value in
> the make variables:
>=20
> NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG =3D @need_internal_fscrypt_add_key_arg@
>=20
> And then the shouty variable is used in the same file to set a compiler
> define:
>=20
> ifeq ($(NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG),yes)
> PCFLAGS+=3D -DOVERRIDE_SYSTEM_FSCRYPT_ADD_KEY_ARG
> endif
>=20
> Then io/encrypt.c does the following to move the system's definition of
> struct fscrypt_add_key_arg out of the way...
>=20
> #ifdef OVERRIDE_SYSTEM_FSCRYPT_ADD_KEY_ARG
> #  define fscrypt_add_key_arg sys_fscrypt_add_key_arg
> #endif
> #include <linux/fs.h>  /* via io.h -> xfs.h -> xfs/linux.h */
>=20
> ...so that the file can provide its own definition further down:
>=20
> /*
>  * Since the key_id field was added later than struct
>  * fscrypt_add_key_arg itself, we may need to override the system
>  * definition to get that field.
>  */
> #if !defined(FS_IOC_ADD_ENCRYPTION_KEY) || \
> 	defined(OVERRIDE_SYSTEM_FSCRYPT_ADD_KEY_ARG)
> #undef fscrypt_add_key_arg
> struct fscrypt_add_key_arg {
> 	struct fscrypt_key_specifier key_spec;
> 	__u32 raw_size;
> 	__u32 key_id;
> 	__u32 __reserved[8];
> 	__u8 raw[];
> };
> #endif
>=20

Darrick, thanks for the detailed instructions. They've been very
helpful! My approach is slightly different since xfsprogs already has a
statx.h. I'm just updating that to allow for overriding. I think I have
the autoconf part worked out.

I'm having a problem with the above though. I have this in statx.h:

#undef statx_timestamp
struct statx_timestamp {
        __s64   tv_sec;
        __s32   tv_nsec;
        __s32   __reserved;
};

...but when I go to build, I get this:

In file included from stat.c:11:
statx.h:60:8: error: redefinition of =E2=80=98struct statx_timestamp=E2=80=
=99
   60 | struct statx_timestamp {
      |        ^~~~~~~~~~~~~~~

...it seems like the "#undef statx_timestamp" isn't doing the right
thing. Is my syntax wrong?
--=20
Jeff Layton <jlayton@kernel.org>
