Return-Path: <linux-fsdevel+bounces-45330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5B0A76462
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10266168C93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE791DFE0A;
	Mon, 31 Mar 2025 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1emQMe3C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0EF1DF755
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417521; cv=none; b=Nm0ak5fjqbXS+RpGwXili0GEqlIYRd+tLINYxVJHM4qcMiKz1p3i7mT15/WgZUZ6e130b/D6gUiY/TIF5G1ugdJyklivz9w/M8GZQKY9pWKTDscqnh8YIXLXeO7tCoS2uQpibJOpS//Gcv4hKL2130YN0n4rbix32+MU3v10LYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417521; c=relaxed/simple;
	bh=fp/SJrIXMX+Nf/NJz9Q2Zf/jf+bSvl3QrK2koBsOVco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYAYDaaWi9q65bVXRruhrhrgjOaFgmWO1C9PBvYToJNSderSB/YwsLBoHp2Pveh+wKctHnhh9c6fvNaYJK2TxfMxId3N+ael6+UywnsdA9b5kUmrIiJOz/plwdB0AWzecW/rFPOwZs8e0hqehs77yuvH/XzdjJ+ms2cfKIHalzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1emQMe3C; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZR6zl5fwxzSK;
	Mon, 31 Mar 2025 12:38:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1743417507;
	bh=ZTNb8YJW4XZL2AXv4REL7RhASXHc5ylbeciO05IsU5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1emQMe3CIV7VNQAzHMH1bADasfY42NYUo2Qe+7zfxTNXIqkjPIAtn9DuyjNMauEG9
	 U6QBESUBcELoOeqAexAH6xejMaj+KtwvcoPvtfjBbkKILDW3M8qaEqagLy07X3yF3i
	 U0s+UR8btMOvPPd4TXSg2zM/AwEa1KrYcwDKYIjQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZR6zk2lgjzvfg;
	Mon, 31 Mar 2025 12:38:26 +0200 (CEST)
Date: Mon, 31 Mar 2025 12:38:25 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Christian Brauner <brauner@kernel.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Tahera Fahimi <fahimitahera@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/8] landlock: Add the errata interface
Message-ID: <20250331.Eiwaiph1zahd@digikod.net>
References: <20250318161443.279194-1-mic@digikod.net>
 <20250318161443.279194-3-mic@digikod.net>
 <20250330.de9cd57f3cd0@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250330.de9cd57f3cd0@gnoack.org>
X-Infomaniak-Routing: alpha

On Sun, Mar 30, 2025 at 12:13:08PM +0200, Günther Noack wrote:
> Hello!
> 
> Thanks for these patches!  An explicit errata versioning is a good
> idea.  With that, I could change the Go-Landlock library to only use
> the "V6" level ABI on kernels where the signal erratum is present, so
> that the libpsx(3)/nptl(7) hacks continue to work.
> 
> The userspace API for this looks good to me as well (except for that I
> wonder whether we should not expose errata numbers as constants in the
> uapi header)?

We could do that but backporting them would be a pain.  That would need
to come from a standalone commit, which means the UAPI header could not
be used by the kernel.  I'm not sure this is worth it given that they
are still documented in the user doc, similarly as ABI versions.

> 
> Regarding internal implementation, splitting the errata definitions up
> into multiple headers feels complicated compared to the naive solution
> and it's not entirely clear to me what the purpose is (see below).

As explain in the comment and the commit message, the goal is to avoid
conflict when backporting fixes with errata.  If all errata are defined
in the same file, only backporting some of them would be a nightmare.

> (Resolving merge conflicts is normally the job of the downstream
> kernel maintainers when doing a cherry pick, and the merge conflicts
> don't sound too complicated in this case?)

No, backporting fixes to stable branches (and resolving the related
conflicts) is my job, and I want to make my life easier. :)

This is unrelated to distros backporting Landlock *features*, and it
should not change anything for them.

> 
> 
> On Tue, Mar 18, 2025 at 05:14:37PM +0100, Mickaël Salaün wrote:
> > Some fixes may require user space to check if they are applied on the
> > running kernel before using a specific feature.  For instance, this
> > applies when a restriction was previously too restrictive and is now
> > getting relaxed (e.g. for compatibility reasons).  However, non-visible
> > changes for legitimate use (e.g. security fixes) do not require an
> > erratum.
> > 
> > Because fixes are backported down to a specific Landlock ABI, we need a
> > way to avoid cherry-pick conflicts.  The solution is to only update a
> > file related to the lower ABI impacted by this issue.  All the ABI files
> > are then used to create a bitmask of fixes.
> 
> I do not fully understand the underlying purpose here.
> 
> In this commit, the errata.h header includes errata/abi-[1234].h.  If
> this patch can be backported to the first version of Landlock (as the
> commit message says), 4 seems like an arbitrary limit, which is
> "including headers from the future", in the kernel that it gets
> backported to.

This commit *potentially* includes 4 header files, but they are not
provided by this commit.  This works thanks to the __has_include
directive.  It's not an issue to potentially have these files included,
but without them it would be an issue when backporting errata that
affect an ABI version <= 3 because the newer kernel would already have
the related abi-N.h file included (or it would be another conflict to
have a commit that both add an erratum and fix an issue).

I want to avoid patches that will only be created for backports but not
included in the master branch.

> 
> If future errata patches (like the one for signals) need to extend the
> list of ABIs in errata.h anyway, doesn't that create the same kinds of
> potential merge conflicts which we tried to avoid by splitting up the
> errata lists into errata/abi-?.h?

No because errata.h in only growing and all errata in the same abi-N.h
file should be backported together.  As explain in the comment, e.g. if
we need to add errata for ABI v5, we'll only need to backport the commit
that previously included abi-5.h and abi-6.h (with a Depends-on tag),
and to create a new commit that fixes the issue and adds the erratum in
abi-5.h at the same time.

> 
> 
> What problem are you addressing with the scheme of splitting up the
> errata/abi-?.h files?
> 
>  (A) Reduced merge conflicts at backporting time?

The goal is to avoid (not reduce) merge conflicts.

> 
>  (B) Catching the case where a errata patch gets applied to a too old
>      kernel for it to make sense?

No, this can only caught at runtime.

> 
>  (C) Something else that I did not see?

No :)

> 
> 
> Is there a cherry picking error scenario which can slip through if we
> were to use a simpler scheme for storing errata?  The most naive way
> would be:
> 
> const int landlock_errata = 0 \
> 	| LANDLOCK_ERRATA_TCP_SOCKET_IDENTIFICATION \
>         | LANDLOCK_ERRATA_CROSS_THREAD_SIGNALING \
>         ;

There are two issues with this approach:
1/ This line would be subject to conflict for *every* erratum backport,
   or if it is split into several lines: where (in the kernel code) to
   extend this landlock_errata variable?
2/ This only moves (one part of) the problem to where these
   LANDLOCK_ERRATA_* constants are defined.

> 
> In scenario (A), the merge conflict in the definition of
> landlock_errata would at worst be a one liner in that const
> definition, which sounds doable?  (Obviously, there can still be merge
> conflicts in the feature code, that is unavoidable.)

I can handle merge conflicts but I'd much prefer to avoid any. :)

The goal of this patch is to avoid any merge conflict, including in the
feature code.

Some potential future code fixes could conflict when backporting them,
but that will not impact the errata interface.

> 
> In scenario (B), it is likely to result in a merge conflict in the
> feature code anyway?  (The signal code and networking code must
> already be there, in order to apply a small change to them.)

The code to be fixed must be there for this fix to make sense, which
means that if the related abi-N.h file exists, it should be updated the
same way, and if it doesn't exist, the fix commit should create it,
whatever the kernel version.  In both cases, no conflict.

> 
> 
> > The new errata interface is similar to the one used to get the supported
> > Landlock ABI version, but it returns a bitmask instead because the order
> > of fixes may not match the order of versions, and not all fixes may
> > apply to all versions.
> > 
> > The actual errata will come with dedicated commits.  The description is
> > not actually used in the code but serves as documentation.
> > 
> > Create the landlock_abi_version symbol and use its value to check errata
> > consistency.
> > 
> > Update test_base's create_ruleset_checks_ordering tests and add errata
> > tests.
> > 
> > This commit is backportable down to the first version of Landlock.
> > 
> > Fixes: 3532b0b4352c ("landlock: Enable user space to infer supported features")
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Link: https://lore.kernel.org/r/20250318161443.279194-3-mic@digikod.net
> > ---
> > 
> > Changes since v1:
> > - New patch.
> > ---
> >  include/uapi/linux/landlock.h                |  2 +
> >  security/landlock/errata.h                   | 87 ++++++++++++++++++++
> >  security/landlock/setup.c                    | 30 +++++++
> >  security/landlock/setup.h                    |  3 +
> >  security/landlock/syscalls.c                 | 22 ++++-
> >  tools/testing/selftests/landlock/base_test.c | 38 ++++++++-
> >  6 files changed, 177 insertions(+), 5 deletions(-)
> >  create mode 100644 security/landlock/errata.h
> > 
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index e1d2c27533b4..8806a132d7b8 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -57,9 +57,11 @@ struct landlock_ruleset_attr {
> >   *
> >   * - %LANDLOCK_CREATE_RULESET_VERSION: Get the highest supported Landlock ABI
> >   *   version.
> > + * - %LANDLOCK_CREATE_RULESET_ERRATA: Get a bitmask of fixed issues.
> >   */
> >  /* clang-format off */
> >  #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
> > +#define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
> >  /* clang-format on */
> >  
> >  /**
> > diff --git a/security/landlock/errata.h b/security/landlock/errata.h
> > new file mode 100644
> > index 000000000000..f26b28b9873d
> > --- /dev/null
> > +++ b/security/landlock/errata.h
> > @@ -0,0 +1,87 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Landlock - Errata information
> > + *
> > + * Copyright © 2025 Microsoft Corporation
> > + */
> > +
> > +#ifndef _SECURITY_LANDLOCK_ERRATA_H
> > +#define _SECURITY_LANDLOCK_ERRATA_H
> > +
> > +#include <linux/init.h>
> > +
> > +struct landlock_erratum {
> > +	const int abi;
> > +	const u8 number;
> > +};
> > +
> > +/* clang-format off */
> > +#define LANDLOCK_ERRATUM(NUMBER) \
> > +	{ \
> > +		.abi = LANDLOCK_ERRATA_ABI, \
> > +		.number = NUMBER, \
> > +	},
> > +/* clang-format on */
> > +
> > +/*
> > + * Some fixes may require user space to check if they are applied on the running
> > + * kernel before using a specific feature.  For instance, this applies when a
> > + * restriction was previously too restrictive and is now getting relaxed (for
> > + * compatibility or semantic reasons).  However, non-visible changes for
> > + * legitimate use (e.g. security fixes) do not require an erratum.
> > + */
> > +static const struct landlock_erratum landlock_errata_init[] __initconst = {
> > +
> > +/*
> > + * Only Sparse may not implement __has_include.  If a compiler does not
> > + * implement __has_include, a warning will be printed at boot time (see
> > + * setup.c).
> > + */
> > +#ifdef __has_include
> > +
> > +#define LANDLOCK_ERRATA_ABI 1
> > +#if __has_include("errata/abi-1.h")
> > +#include "errata/abi-1.h"
> > +#endif
> > +#undef LANDLOCK_ERRATA_ABI
> > +
> > +#define LANDLOCK_ERRATA_ABI 2
> > +#if __has_include("errata/abi-2.h")
> > +#include "errata/abi-2.h"
> > +#endif
> > +#undef LANDLOCK_ERRATA_ABI
> > +
> > +#define LANDLOCK_ERRATA_ABI 3
> > +#if __has_include("errata/abi-3.h")
> > +#include "errata/abi-3.h"
> > +#endif
> > +#undef LANDLOCK_ERRATA_ABI
> > +
> > +#define LANDLOCK_ERRATA_ABI 4
> > +#if __has_include("errata/abi-4.h")
> > +#include "errata/abi-4.h"
> > +#endif
> > +#undef LANDLOCK_ERRATA_ABI
> 
> 
> > +
> > +/*
> > + * For each new erratum, we need to include all the ABI files up to the impacted
> > + * ABI to make all potential future intermediate errata easy to backport.
> > + *
> > + * If such change involves more than one ABI addition, then it must be in a
> > + * dedicated commit with the same Fixes tag as used for the actual fix.
> > + *
> > + * Each commit creating a new security/landlock/errata/abi-*.h file must have a
> > + * Depends-on tag to reference the commit that previously added the line to
> > + * include this new file, except if the original Fixes tag is enough.
> > + *
> > + * Each erratum must be documented in its related ABI file, and a dedicated
> > + * commit must update Documentation/userspace-api/landlock.rst to include this
> > + * erratum.  This commit will not be backported.
> > + */
> > +
> > +#endif
> > +
> > +	{}
> > +};
> > +
> > +#endif /* _SECURITY_LANDLOCK_ERRATA_H */
> > diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> > index c71832a8e369..0c85ea27e409 100644
> > --- a/security/landlock/setup.c
> > +++ b/security/landlock/setup.c
> > @@ -6,12 +6,14 @@
> >   * Copyright © 2018-2020 ANSSI
> >   */
> >  
> > +#include <linux/bits.h>
> >  #include <linux/init.h>
> >  #include <linux/lsm_hooks.h>
> >  #include <uapi/linux/lsm.h>
> >  
> >  #include "common.h"
> >  #include "cred.h"
> > +#include "errata.h"
> >  #include "fs.h"
> >  #include "net.h"
> >  #include "setup.h"
> > @@ -31,8 +33,36 @@ struct lsm_blob_sizes landlock_blob_sizes __ro_after_init = {
> >  	.lbs_superblock = sizeof(struct landlock_superblock_security),
> >  };
> >  
> > +int landlock_errata __ro_after_init;
> > +
> > +static void __init compute_errata(void)
> > +{
> > +	size_t i;
> > +
> > +#ifndef __has_include
> > +	/*
> > +	 * This is a safeguard to make sure the compiler implements
> > +	 * __has_include (see errata.h).
> > +	 */
> > +	WARN_ON_ONCE(1);
> > +	return;
> > +#endif
> > +
> > +	for (i = 0; landlock_errata_init[i].number; i++) {
> > +		const int prev_errata = landlock_errata;
> > +
> > +		if (WARN_ON_ONCE(landlock_errata_init[i].abi >
> > +				 landlock_abi_version))
> > +			continue;
> 
> IIUC, if we hit this condition, someone has tried to backport an
> erratum that does not apply here?

Yes, it's just a safeguard to ensure consistency.

> Shouldn't this ideally be a compile
> time error?

Yes, that would be nice but I didn't find a way to do it.

> Then downstream kernel maintainers would notice it
> earlier when they apply the wrong patch?

This check is mainly for downstream kernels yes, but that's also useful
for us.

> 
> Can this scenario really happen?  It feels that this should normally
> already be caught in merge conflicts at cherry picking time?

Well, a lot of things can happen when backporting *features* to older
kernels.  Anyway, it's a cheap check.

> 
> 
> > +
> > +		landlock_errata |= BIT(landlock_errata_init[i].number - 1);
> > +		WARN_ON_ONCE(prev_errata == landlock_errata);
> > +	}
> > +}
> > +
> >  static int __init landlock_init(void)
> >  {
> > +	compute_errata();
> >  	landlock_add_cred_hooks();
> >  	landlock_add_task_hooks();
> >  	landlock_add_fs_hooks();
> > diff --git a/security/landlock/setup.h b/security/landlock/setup.h
> > index c4252d46d49d..fca307c35fee 100644
> > --- a/security/landlock/setup.h
> > +++ b/security/landlock/setup.h
> > @@ -11,7 +11,10 @@
> >  
> >  #include <linux/lsm_hooks.h>
> >  
> > +extern const int landlock_abi_version;
> > +
> >  extern bool landlock_initialized;
> > +extern int landlock_errata;
> >  
> >  extern struct lsm_blob_sizes landlock_blob_sizes;
> >  extern const struct lsm_id landlock_lsmid;
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > index a9760d252fc2..cf9e0483e542 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> > @@ -160,7 +160,9 @@ static const struct file_operations ruleset_fops = {
> >   *        the new ruleset.
> >   * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
> >   *        backward and forward compatibility).
> > - * @flags: Supported value: %LANDLOCK_CREATE_RULESET_VERSION.
> > + * @flags: Supported value:
> > + *         - %LANDLOCK_CREATE_RULESET_VERSION
> > + *         - %LANDLOCK_CREATE_RULESET_ERRATA
> >   *
> >   * This system call enables to create a new Landlock ruleset, and returns the
> >   * related file descriptor on success.
> > @@ -169,6 +171,10 @@ static const struct file_operations ruleset_fops = {
> >   * 0, then the returned value is the highest supported Landlock ABI version
> >   * (starting at 1).
> >   *
> > + * If @flags is %LANDLOCK_CREATE_RULESET_ERRATA and @attr is NULL and @size is
> > + * 0, then the returned value is a bitmask of fixed issues for the current
> > + * Landlock ABI version.
> 
> We should probably say here where that list is defined.

It's defined in the user space documentation (see commits adding the
errata).  BTW, I'll send a patch to improve the documentation (mostly
cosmetic).

> 
> Should the errata numbers also be constants in the
> uapi/linux/landlock.h header?

As explained above, that would mean that we don't use these constants in
the kernel, which would be weird.

> 
> > + *
> >   * Possible returned errors are:
> >   *
> >   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
> > @@ -192,9 +198,15 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
> >  		return -EOPNOTSUPP;
> >  
> >  	if (flags) {
> > -		if ((flags == LANDLOCK_CREATE_RULESET_VERSION) && !attr &&
> > -		    !size)
> > -			return LANDLOCK_ABI_VERSION;
> > +		if (attr || size)
> > +			return -EINVAL;
> > +
> > +		if (flags == LANDLOCK_CREATE_RULESET_VERSION)
> > +			return landlock_abi_version;
> > +
> > +		if (flags == LANDLOCK_CREATE_RULESET_ERRATA)
> > +			return landlock_errata;
> > +
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -235,6 +247,8 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
> >  	return ruleset_fd;
> >  }
> >  
> > +const int landlock_abi_version = LANDLOCK_ABI_VERSION;
> > +
> >  /*
> >   * Returns an owned ruleset from a FD. It is thus needed to call
> >   * landlock_put_ruleset() on the return value.
> > diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> > index 1bc16fde2e8a..c0abadd0bbbe 100644
> > --- a/tools/testing/selftests/landlock/base_test.c
> > +++ b/tools/testing/selftests/landlock/base_test.c
> > @@ -98,10 +98,46 @@ TEST(abi_version)
> >  	ASSERT_EQ(EINVAL, errno);
> >  }
> >  
> > +TEST(errata)
> > +{
> > +	const struct landlock_ruleset_attr ruleset_attr = {
> > +		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
> > +	};
> > +	int errata;
> > +
> > +	errata = landlock_create_ruleset(NULL, 0,
> > +					 LANDLOCK_CREATE_RULESET_ERRATA);
> > +	/* The errata bitmask will not be backported to tests. */
> > +	ASSERT_LE(0, errata);
> > +	TH_LOG("errata: 0x%x", errata);
> > +
> > +	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> > +					      LANDLOCK_CREATE_RULESET_ERRATA));
> > +	ASSERT_EQ(EINVAL, errno);
> > +
> > +	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(ruleset_attr),
> > +					      LANDLOCK_CREATE_RULESET_ERRATA));
> > +	ASSERT_EQ(EINVAL, errno);
> > +
> > +	ASSERT_EQ(-1,
> > +		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
> > +					  LANDLOCK_CREATE_RULESET_ERRATA));
> > +	ASSERT_EQ(EINVAL, errno);
> > +
> > +	ASSERT_EQ(-1, landlock_create_ruleset(
> > +			      NULL, 0,
> > +			      LANDLOCK_CREATE_RULESET_VERSION |
> > +				      LANDLOCK_CREATE_RULESET_ERRATA));
> > +	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0,
> > +					      LANDLOCK_CREATE_RULESET_ERRATA |
> > +						      1 << 31));
> > +	ASSERT_EQ(EINVAL, errno);
> 
> There are two calls to landlock_create_ruleset() here, but only one
> ASSERT_EQ(EINVAL, errno).

Correct, I'll add another errno check.

> I do not understand why the second call to
> landlock_create_ruleset() was done here (with the | 1 << 31) -- was
> that left here by accident?

This second check is to make sure that an unknown flag results to an
EINVAL error.  A similar check is done with
LANDLOCK_CREATE_RULESET_VERSION.

> 
> 
> > +}
> > +
> >  /* Tests ordering of syscall argument checks. */
> >  TEST(create_ruleset_checks_ordering)
> >  {
> > -	const int last_flag = LANDLOCK_CREATE_RULESET_VERSION;
> > +	const int last_flag = LANDLOCK_CREATE_RULESET_ERRATA;
> >  	const int invalid_flag = last_flag << 1;
> >  	int ruleset_fd;
> >  	const struct landlock_ruleset_attr ruleset_attr = {
> > -- 
> > 2.48.1
> > 
> 
> –Günther
> 

