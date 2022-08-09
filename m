Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7DA58DB26
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 17:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbiHIPdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiHIPdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:33:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE65CF04;
        Tue,  9 Aug 2022 08:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BA7A61281;
        Tue,  9 Aug 2022 15:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E7CC433C1;
        Tue,  9 Aug 2022 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660059226;
        bh=uEM2II5ZhoclAW3oVUSmDhxIMZ4eqsmn7nBLYONcDbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADqackvhvCC8wIl5U58Kf/J+cARc/gGRlEfxvLyA16uJd34PobSGVVfmZLN/PJ34Q
         vLDEp9gMXE0wV1ro4j4eTbVie9tq1uE/nHYaLgjzDvADXUIRH+ti9hier4bBxNdsYr
         PkkG4N5k1Vqbk1z+UCpBgBZdz+CrcxlIJvlCs6tf+MPqCQiA9thw4tIztumaKTpiMR
         oBhrFrWDmdlcMoIph0Ea97MGZFV8ik7ZHNTZ6U9DDlrRa1b0HofZmHwJm3QcTTT9TJ
         DL6hGoGPiCQ05x7vPGP9dv5rKWOSdKMGtXaEUnbhN9u2i+vnxzocOZgW4Me8NyZ9yT
         vzkJo+IUAZ7UA==
Date:   Tue, 9 Aug 2022 08:33:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, lczerner@redhat.com, bxue@redhat.com,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
Message-ID: <YvJ+WkrtStRujU2/@magnolia>
References: <20220805183543.274352-1-jlayton@kernel.org>
 <20220805183543.274352-2-jlayton@kernel.org>
 <20220805220136.GG3600936@dread.disaster.area>
 <c10e4aa381aea86bb51b005887533e28f9c7302b.camel@redhat.com>
 <33176ee0f896aef889ad1930fb1e008323135a2e.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33176ee0f896aef889ad1930fb1e008323135a2e.camel@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 08, 2022 at 09:19:05AM -0400, Jeff Layton wrote:
> On Fri, 2022-08-05 at 18:06 -0400, Jeff Layton wrote:
> > On Sat, 2022-08-06 at 08:01 +1000, Dave Chinner wrote:
> > > On Fri, Aug 05, 2022 at 02:35:40PM -0400, Jeff Layton wrote:
> > > > From: Jeff Layton <jlayton@redhat.com>
> > > > 
> > > > Claim one of the spare fields in struct statx to hold a 64-bit change
> > > > attribute. When statx requests this attribute, do an
> > > > inode_query_iversion and fill the result in the field.
> > > > 
> > > > Also update the test-statx.c program to fetch the change attribute as
> > > > well.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/stat.c                 | 7 +++++++
> > > >  include/linux/stat.h      | 1 +
> > > >  include/uapi/linux/stat.h | 3 ++-
> > > >  samples/vfs/test-statx.c  | 4 +++-
> > > >  4 files changed, 13 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/stat.c b/fs/stat.c
> > > > index 9ced8860e0f3..976e0a59ab23 100644
> > > > --- a/fs/stat.c
> > > > +++ b/fs/stat.c
> > > > @@ -17,6 +17,7 @@
> > > >  #include <linux/syscalls.h>
> > > >  #include <linux/pagemap.h>
> > > >  #include <linux/compat.h>
> > > > +#include <linux/iversion.h>
> > > >  
> > > >  #include <linux/uaccess.h>
> > > >  #include <asm/unistd.h>
> > > > @@ -118,6 +119,11 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
> > > >  	stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
> > > >  				  STATX_ATTR_DAX);
> > > >  
> > > > +	if ((request_mask & STATX_CHGATTR) && IS_I_VERSION(inode)) {
> > > > +		stat->result_mask |= STATX_CHGATTR;
> > > > +		stat->chgattr = inode_query_iversion(inode);
> > > > +	}
> > > 
> > > If you're going to add generic support for it, shouldn't there be a
> > > generic test in fstests that ensures that filesystems that advertise
> > > STATX_CHGATTR support actually behave correctly? Including across
> > > mounts, and most importantly, that it is made properly stable by
> > > fsync?
> > > 
> > > i.e. what good is this if different filesystems have random quirks
> > > that mean it can't be relied on by userspace to tell it changes have
> > > occurred?
> > 
> > Absolutely. Being able to better test the i_version field for consistent
> > behavior is a primary goal. I haven't yet written any yet, but we'd
> > definitely want something in xfstests if we decide this is worthwhile.
> 
> I started writing some tests for this today, and hit a bit of a chicken-
> and-egg problem:
> 
> I'd prefer to use xfs_io for easier maintainability, but the STATX_*
> constants are defined via UAPI header. Older kernels don't have them and
> old xfs_io programs don't understand or report this value.
> 
> Should I just write a one-off binary program for xfstests to fetch this
> value for now, or are we better off merging the patchset first, and then
> fix xfs_io and then write the tests using the updated xfs_io program?

What we've done in the past to support new APIs until they land in
kernel headers is:

Add an autoconf macro to decide if the system header files are recent
enough to support whatever functionality is needed by xfs_io;

Modify the build system to #define OVERRIDE_FUBAR if the system headers
aren't new enough to have FUBAR; and

Modify (or create) the relevant header file to override the system
header definitions as needed to support building the relevant pieces of
code.  A year or so after the functionality lands, we can then remove
the overrides, or just leave them in place until the next time we need
it.

For example, Eric Biggers wanted to teach the fscrypt commands to use a
new feature he was adding to an existing API, so he AC_DEFUN'd a macro
that checks to see if the system linux/fs.h *does not* define a
structure containing the desired field.  If this is the case, it sets
need_internal_fscrypt_add_key_arg=yes.

AC_DEFUN([AC_NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG],
  [
    AC_CHECK_TYPE(struct fscrypt_add_key_arg,
      [
        AC_CHECK_MEMBER(struct fscrypt_add_key_arg.key_id,
          ,
          need_internal_fscrypt_add_key_arg=yes,
          [#include <linux/fs.h>]
        )
      ],,
      [#include <linux/fs.h>]
    )
    AC_SUBST(need_internal_fscrypt_add_key_arg)
  ])

This macro is called from configure.ac.

Next, include/builddefs.in was modified to include the selected value in
the make variables:

NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG = @need_internal_fscrypt_add_key_arg@

And then the shouty variable is used in the same file to set a compiler
define:

ifeq ($(NEED_INTERNAL_FSCRYPT_ADD_KEY_ARG),yes)
PCFLAGS+= -DOVERRIDE_SYSTEM_FSCRYPT_ADD_KEY_ARG
endif

Then io/encrypt.c does the following to move the system's definition of
struct fscrypt_add_key_arg out of the way...

#ifdef OVERRIDE_SYSTEM_FSCRYPT_ADD_KEY_ARG
#  define fscrypt_add_key_arg sys_fscrypt_add_key_arg
#endif
#include <linux/fs.h>  /* via io.h -> xfs.h -> xfs/linux.h */

...so that the file can provide its own definition further down:

/*
 * Since the key_id field was added later than struct
 * fscrypt_add_key_arg itself, we may need to override the system
 * definition to get that field.
 */
#if !defined(FS_IOC_ADD_ENCRYPTION_KEY) || \
	defined(OVERRIDE_SYSTEM_FSCRYPT_ADD_KEY_ARG)
#undef fscrypt_add_key_arg
struct fscrypt_add_key_arg {
	struct fscrypt_key_specifier key_spec;
	__u32 raw_size;
	__u32 key_id;
	__u32 __reserved[8];
	__u8 raw[];
};
#endif

Obviously, #defined constants are much easier to override:

#ifndef FS_IOC_ADD_ENCRYPTION_KEY
#  define FS_IOC_ADD_ENCRYPTION_KEY		_IOWR('f', 23, struct fscrypt_add_key_arg)
#endif

But I went for the full solution since you're adding fields to struct
statx.

Also, whatever you do, don't put your overrides in any file that gets
exported via xfslibs-dev, because those files get put in /usr/include.
We just learned that lesson the hard way with MAP_SYNC.

--D

> -- 
> Jeff Layton <jlayton@kernel.org>
