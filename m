Return-Path: <linux-fsdevel+bounces-6048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB4812C98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 11:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B48C1F21892
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC2E3B2A2;
	Thu, 14 Dec 2023 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="gYI5ZOAS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75164B2
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 02:14:12 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SrSr25YnhzMpnhP;
	Thu, 14 Dec 2023 10:14:10 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SrSr16ggszMppRm;
	Thu, 14 Dec 2023 11:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1702548850;
	bh=bWbKinlIygs69dJQ7/qr2QWlAqI8sDyZwNvzhZi/3SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYI5ZOASCdWCNf7u8DjUO0rNf1JGX5D6Cl9u5oKS+wswU4P6lPr2Wr+i4t/XjIeYk
	 fC8wrLnADI72uD57RIAqg77e2HWzEOep8EM9MCe1qmdP2aLVF3sFksd8Suv1iv+PqE
	 095vkYrcwbXtl7xRJ3BzZ+Rj3HLZ6kEjty3jUUAA=
Date: Thu, 14 Dec 2023 11:14:09 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 4/9] landlock: Add IOCTL access right
Message-ID: <20231214.Iev8oopu8iel@digikod.net>
References: <20231208155121.1943775-1-gnoack@google.com>
 <20231208155121.1943775-5-gnoack@google.com>
 <20231214.feeZ6Hahwaem@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231214.feeZ6Hahwaem@digikod.net>
X-Infomaniak-Routing: alpha

On Thu, Dec 14, 2023 at 10:26:49AM +0100, Mickaël Salaün wrote:
> On Fri, Dec 08, 2023 at 04:51:16PM +0100, Günther Noack wrote:
> > Introduces the LANDLOCK_ACCESS_FS_IOCTL access right
> > and increments the Landlock ABI version to 5.
> > 
> > Like the truncate right, these rights are associated with a file
> > descriptor at the time of open(2), and get respected even when the
> > file descriptor is used outside of the thread which it was originally
> > opened in.
> > 
> > A newly enabled Landlock policy therefore does not apply to file
> > descriptors which are already open.
> > 
> > If the LANDLOCK_ACCESS_FS_IOCTL right is handled, only a small number
> > of safe IOCTL commands will be permitted on newly opened files.  The
> > permitted IOCTLs can be configured through the ruleset in limited ways
> > now.  (See documentation for details.)
> > 
> > Specifically, when LANDLOCK_ACCESS_FS_IOCTL is handled, granting this
> > right on a file or directory will *not* permit to do all IOCTL
> > commands, but only influence the IOCTL commands which are not already
> > handled through other access rights.  The intent is to keep the groups
> > of IOCTL commands more fine-grained.
> > 
> > Noteworthy scenarios which require special attention:
> > 
> > TTY devices support IOCTLs like TIOCSTI and TIOCLINUX, which can be
> > used to control shell processes on the same terminal which run at
> > different privilege levels, which may make it possible to escape a
> > sandbox.  Because stdin, stdout and stderr are normally inherited
> > rather than newly opened, IOCTLs are usually permitted on them even
> > after the Landlock policy is enforced.
> > 
> > Some legitimate file system features, like setting up fscrypt, are
> > exposed as IOCTL commands on regular files and directories -- users of
> > Landlock are advised to double check that the sandboxed process does
> > not need to invoke these IOCTLs.
> > 
> > Known limitations:
> > 
> > The LANDLOCK_ACCESS_FS_IOCTL access right is a coarse-grained control
> > over IOCTL commands.  Future work will enable a more fine-grained
> > access control for IOCTLs.
> > 
> > In the meantime, Landlock users may use path-based restrictions in
> > combination with their knowledge about the file system layout to
> > control what IOCTLs can be done.  Mounting file systems with the nodev
> > option can help to distinguish regular files and devices, and give
> > guarantees about the affected files, which Landlock alone can not give
> > yet.
> > 
> > Signed-off-by: Günther Noack <gnoack@google.com>
> > ---
> >  include/uapi/linux/landlock.h                |  58 +++++-
> >  security/landlock/fs.c                       | 176 ++++++++++++++++++-
> >  security/landlock/fs.h                       |   2 +
> >  security/landlock/limits.h                   |  11 +-
> >  security/landlock/ruleset.h                  |   2 +-
> >  security/landlock/syscalls.c                 |  19 +-
> >  tools/testing/selftests/landlock/base_test.c |   2 +-
> >  tools/testing/selftests/landlock/fs_test.c   |   5 +-
> >  8 files changed, 253 insertions(+), 22 deletions(-)
> > 
> 
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index 9ba989ef46a5..81ce41e9e6db 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -7,12 +7,14 @@
> >   * Copyright © 2021-2022 Microsoft Corporation
> >   */
> >  
> > +#include <asm/ioctls.h>
> >  #include <linux/atomic.h>
> >  #include <linux/bitops.h>
> >  #include <linux/bits.h>
> >  #include <linux/compiler_types.h>
> >  #include <linux/dcache.h>
> >  #include <linux/err.h>
> > +#include <linux/falloc.h>
> >  #include <linux/fs.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> > @@ -28,6 +30,7 @@
> >  #include <linux/types.h>
> >  #include <linux/wait_bit.h>
> >  #include <linux/workqueue.h>
> > +#include <uapi/linux/fiemap.h>
> >  #include <uapi/linux/landlock.h>
> >  
> >  #include "common.h"
> > @@ -83,6 +86,145 @@ static const struct landlock_object_underops landlock_fs_underops = {
> >  	.release = release_inode
> >  };
> >  
> > +/* IOCTL helpers */
> > +
> > +/*
> > + * These are synthetic access rights, which are only used within the kernel, but
> > + * not exposed to callers in userspace.  The mapping between these access rights
> > + * and IOCTL commands is defined in the required_ioctl_access() helper function.
> > + */
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP1 (LANDLOCK_LAST_PUBLIC_ACCESS_FS << 1)
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP2 (LANDLOCK_LAST_PUBLIC_ACCESS_FS << 2)
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP3 (LANDLOCK_LAST_PUBLIC_ACCESS_FS << 3)
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP4 (LANDLOCK_LAST_PUBLIC_ACCESS_FS << 4)
> > +
> > +/* ioctl_groups - all synthetic access rights for IOCTL command groups */
> > +/* clang-format off */
> > +#define IOCTL_GROUPS (			  \
> > +	LANDLOCK_ACCESS_FS_IOCTL_GROUP1 | \
> > +	LANDLOCK_ACCESS_FS_IOCTL_GROUP2 | \
> > +	LANDLOCK_ACCESS_FS_IOCTL_GROUP3 | \
> > +	LANDLOCK_ACCESS_FS_IOCTL_GROUP4)
> > +/* clang-format on */
> > +
> > +static_assert((IOCTL_GROUPS & LANDLOCK_MASK_ACCESS_FS) == IOCTL_GROUPS);
> > +
> > +/**
> > + * required_ioctl_access(): Determine required IOCTL access rights.
> > + *
> > + * @cmd: The IOCTL command that is supposed to be run.
> > + *
> > + * Returns: The access rights that must be granted on an opened file in order to
> > + * use the given @cmd.
> > + */
> > +static access_mask_t required_ioctl_access(unsigned int cmd)

Please use a verb for functions, something like
get_required_ioctl_access().

> 
> You can add __attribute_const__ after "static", and also constify cmd.
> 
> > +{
> > +	switch (cmd) {
> > +	case FIOCLEX:
> > +	case FIONCLEX:
> > +	case FIONBIO:
> > +	case FIOASYNC:
> > +		/*
> > +		 * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's
> > +		 * close-on-exec and the file's buffered-IO and async flags.
> > +		 * These operations are also available through fcntl(2),
> > +		 * and are unconditionally permitted in Landlock.
> > +		 */
> > +		return 0;
> > +	case FIOQSIZE:
> > +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP1;
> > +	case FS_IOC_FIEMAP:
> > +	case FIBMAP:
> > +	case FIGETBSZ:
> > +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP2;
> > +	case FIONREAD:
> > +	case FIDEDUPERANGE:
> > +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP3;
> > +	case FICLONE:
> > +	case FICLONERANGE:
> > +	case FS_IOC_RESVSP:
> > +	case FS_IOC_RESVSP64:
> > +	case FS_IOC_UNRESVSP:
> > +	case FS_IOC_UNRESVSP64:
> > +	case FS_IOC_ZERO_RANGE:
> > +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP4;
> > +	default:
> > +		/*
> > +		 * Other commands are guarded by the catch-all access right.
> > +		 */
> > +		return LANDLOCK_ACCESS_FS_IOCTL;
> > +	}
> > +}
> > +
> > +/**
> > + * expand_ioctl() - Return the dst flags from either the src flag or the
> > + * %LANDLOCK_ACCESS_FS_IOCTL flag, depending on whether the
> > + * %LANDLOCK_ACCESS_FS_IOCTL and src access rights are handled or not.
> > + *
> > + * @handled: Handled access rights.
> > + * @access: The access mask to copy values from.
> > + * @src: A single access right to copy from in @access.
> > + * @dst: One or more access rights to copy to.
> > + *
> > + * Returns: @dst, or 0.
> > + */
> > +static access_mask_t expand_ioctl(const access_mask_t handled,
> 
> static __attribute_const__
> 
> > +				  const access_mask_t access,
> > +				  const access_mask_t src,
> > +				  const access_mask_t dst)
> > +{
> > +	access_mask_t copy_from;
> > +
> > +	if (!(handled & LANDLOCK_ACCESS_FS_IOCTL))
> > +		return 0;
> > +
> > +	copy_from = (handled & src) ? src : LANDLOCK_ACCESS_FS_IOCTL;
> > +	if (access & copy_from)
> > +		return dst;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * landlock_expand_access_fs() - Returns @access with the synthetic IOCTL group
> > + * flags enabled if necessary.
> > + *
> > + * @handled: Handled FS access rights.
> > + * @access: FS access rights to expand.
> > + *
> > + * Returns: @access expanded by the necessary flags for the synthetic IOCTL
> > + * access rights.
> > + */
> > +static access_mask_t landlock_expand_access_fs(const access_mask_t handled,
> 
> static __attribute_const__
> 
> > +					       const access_mask_t access)
> > +{
> > +	return access |
> > +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_WRITE_FILE,
> > +			    LANDLOCK_ACCESS_FS_IOCTL_GROUP1 |
> > +				    LANDLOCK_ACCESS_FS_IOCTL_GROUP2 |
> > +				    LANDLOCK_ACCESS_FS_IOCTL_GROUP4) |
> > +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_FILE,
> > +			    LANDLOCK_ACCESS_FS_IOCTL_GROUP1 |
> > +				    LANDLOCK_ACCESS_FS_IOCTL_GROUP2 |
> > +				    LANDLOCK_ACCESS_FS_IOCTL_GROUP3) |
> > +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_DIR,
> > +			    LANDLOCK_ACCESS_FS_IOCTL_GROUP1);
> > +}
> > +
> > +/**
> > + * landlock_expand_handled_access_fs() - add synthetic IOCTL access rights to an
> > + * access mask of handled accesses.
> > + *
> > + * @handled: The handled accesses of a ruleset that is being created.
> > + *
> > + * Returns: @handled, with the bits for the synthetic IOCTL access rights set,
> > + * if %LANDLOCK_ACCESS_FS_IOCTL is handled.
> > + */
> > +access_mask_t landlock_expand_handled_access_fs(const access_mask_t handled)
> 
> __attribute_const__ access_mask_t
> 
> > +{
> > +	return landlock_expand_access_fs(handled, handled);
> > +}
> > +
> 
> > diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> > index 488e4813680a..c88fe7bda37b 100644
> > --- a/security/landlock/fs.h
> > +++ b/security/landlock/fs.h
> > @@ -92,4 +92,6 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
> >  			    const struct path *const path,
> >  			    access_mask_t access_hierarchy);
> >  
> > +access_mask_t landlock_expand_handled_access_fs(const access_mask_t handled);
> 
> __attribute_const__ access_mask_t
> 
> > +
> >  #endif /* _SECURITY_LANDLOCK_FS_H */

