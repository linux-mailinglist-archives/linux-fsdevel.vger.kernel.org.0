Return-Path: <linux-fsdevel+bounces-24834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F83D945341
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 21:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17C0B24885
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B214AD02;
	Thu,  1 Aug 2024 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj6Uegrh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69A14A60A;
	Thu,  1 Aug 2024 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540112; cv=none; b=gaEVnvXaLeqyho3cmflskelr2K2yjdHrya8DnTudcbcuCsE+UuPhYHg1qNUkRKSCQPqe7PUDTnYKNzmBbrpGb7w6J9yQWO2z6oGbUh/HBHPrhuFkPgPfjwrygMPyu53B0TGRwjOMA9HksZ25ouDGNQnHbbPeWII30H/1H/9QR1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540112; c=relaxed/simple;
	bh=xE3L8EJ1jm124rMNDrOjuoguyqV05szqmZN2nxQ/V8c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GU0lyZp4rY569j9FnbOhwjx6RBw7oi5QmB7OWEYAC48qnx6bd+ls9Lf4xNVBj/hGZDGVyLXVrdpzo+vDnYgHFmxvcnJDm98jjbxFaBaXhIpflqcsi6bj4SZNL+TWAVd8iarzGKunS2YCAOf+hTL4Tg61elHg/2w0fzRSxyIplkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj6Uegrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF31C32786;
	Thu,  1 Aug 2024 19:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722540112;
	bh=xE3L8EJ1jm124rMNDrOjuoguyqV05szqmZN2nxQ/V8c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Bj6Uegrh6O92QLRHGj+OpF8rXGFsb9ZtVLgHXj+pnySZcBkcyH4CRiTSZG9ai3r7b
	 xGH+4WTap+fWLwril7MCKRWeVEiBRtUSakIF3zdk007S+ERPMP7SDAuKRa/7LuknFO
	 IPhUpYVfke8Kc69BvVLYB1GqMl6WvIh0ul/QXWlgdBJw0dWP9KNb8XRKg+tyw4nmr/
	 FTjS1O/vYnfOLf+TtgF7PUAdgrJiEVWgi5NfOBSzHZnJlLJG/zfpXOrzUOtWbKTBOJ
	 Fnq3NloVeg7WHnDanydiOBx+t9aZn4i1KMCwVu4hTa8lFDe6b9WyNTQwuBcSyaa2gX
	 UF2MBcFr4tHNw==
Message-ID: <37ca45753755fcb57702b5f61c7f18aeb02a7d96.camel@kernel.org>
Subject: Re: [PATCH RFC v3 1/2] uapi: explain how per-syscall AT_* flags
 should be allocated
From: Jeff Layton <jlayton@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, Amir Goldstein
 <amir73il@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Date: Thu, 01 Aug 2024 15:21:49 -0400
In-Reply-To: <20240801-exportfs-u64-mount-id-v3-1-be5d6283144a@cyphar.com>
References: <20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com>
	 <20240801-exportfs-u64-mount-id-v3-1-be5d6283144a@cyphar.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-01 at 13:52 +1000, Aleksa Sarai wrote:
> Unfortunately, the way we have gone about adding new AT_* flags has
> been a little messy. In the beginning, all of the AT_* flags had generic
> meanings and so it made sense to share the flag bits indiscriminately.
> However, we inevitably ran into syscalls that needed their own
> syscall-specific flags. Due to the lack of a planned out policy, we
> ended up with the following situations:
>=20
> =C2=A0* Existing syscalls adding new features tended to use new AT_* bits=
,
> =C2=A0=C2=A0 with some effort taken to try to re-use bits for flags that =
were so
> =C2=A0=C2=A0 obviously syscall specific that they only make sense for a s=
ingle
> =C2=A0=C2=A0 syscall (such as the AT_EACCESS/AT_REMOVEDIR/AT_HANDLE_FID t=
riplet).
>=20
> =C2=A0=C2=A0 Given the constraints of bitflags, this works well in practi=
ce, but
> =C2=A0=C2=A0 ideally (to avoid future confusion) we would plan ahead and =
define a
> =C2=A0=C2=A0 set of "per-syscall bits" ahead of time so that when allocat=
ing new
> =C2=A0=C2=A0 bits we don't end up with a complete mish-mash of which bits=
 are
> =C2=A0=C2=A0 supposed to be per-syscall and which aren't.
>=20
> =C2=A0* New syscalls dealt with this in several ways:
>=20
> =C2=A0=C2=A0 - Some syscalls (like renameat2(2), move_mount(2), fsopen(2)=
, and
> =C2=A0=C2=A0=C2=A0=C2=A0 fspick(2)) created their separate own flag space=
s that have no
> =C2=A0=C2=A0=C2=A0=C2=A0 overlap with the AT_* flags. Most of these ended=
 up allocating
> =C2=A0=C2=A0=C2=A0=C2=A0 their bits sequentually.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 In the case of move_mount(2) and fspick(2), seve=
ral flags have
> =C2=A0=C2=A0=C2=A0=C2=A0 identical meanings to AT_* flags but were alloca=
ted in their own
> =C2=A0=C2=A0=C2=A0=C2=A0 flag space.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 This makes sense for syscalls that will never sh=
are AT_* flags, but
> =C2=A0=C2=A0=C2=A0=C2=A0 for some syscalls this leads to duplication with=
 AT_* flags in a
> =C2=A0=C2=A0=C2=A0=C2=A0 way that could cause confusion (if renameat2(2) =
grew a
> =C2=A0=C2=A0=C2=A0=C2=A0 RENAME_EMPTY_PATH it seems likely that users cou=
ld mistake it for
> =C2=A0=C2=A0=C2=A0=C2=A0 AT_EMPTY_PATH since it is an *at(2) syscall).
>=20
> =C2=A0=C2=A0 - Some syscalls unfortunately ended up both creating their o=
wn flag
> =C2=A0=C2=A0=C2=A0=C2=A0 space while also using bits from other flag spac=
es. The most
> =C2=A0=C2=A0=C2=A0=C2=A0 obvious example is open_tree(2), where the stand=
ard usage ends up
> =C2=A0=C2=A0=C2=A0=C2=A0 using flags from *THREE* separate flag spaces:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_tree(AT_FDCWD, "/foo", OPEN_TRE=
E_CLONE|O_CLOEXEC|AT_RECURSIVE);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 (Note that O_CLOEXEC is also platform-specific, =
so several future
> =C2=A0=C2=A0=C2=A0=C2=A0 OPEN_TREE_* bits are also made unusable in one f=
ell swoop.)
>=20
> It's not entirely clear to me what the "right" choice is for new
> syscalls. Just saying that all future VFS syscalls should use AT_* flags
> doesn't seem practical. openat2(2) has RESOLVE_* flags (many of which
> don't make much sense to burn generic AT_* flags for) and move_mount(2)
> has separate AT_*-like flags for both the source and target so separate
> flags are needed anyway (though it seems possible that renameat2(2)
> could grow *_EMPTY_PATH flags at some point, and it's a bit of a shame
> they can't be reused).
>=20
> But at least for syscalls that _do_ choose to use AT_* flags, we should
> explicitly state the policy that 0x2ff is currently intended for
> per-syscall flags and that new flags should err on the side of
> overlapping with existing flag bits (so we can extend the scope of
> generic flags in the future if necessary).
>=20
> And add AT_* aliases for the RENAME_* flags to further cement that
> renameat2(2) is an *at(2) flag, just with its own per-syscall flags.
>=20
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
> =C2=A0include/uapi/linux/fcntl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 80 ++++++++++++++-------
> =C2=A0tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 83 +++++++++++=
++++-------
> =C2=A02 files changed, 115 insertions(+), 48 deletions(-)
>=20

This seems like a reasonable proposal. We haven't been as careful about
how these flags get allocated as we probably should have in the past.
Nothing we can do about the existing ones, but some guidelines going
forward are welcome.

> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index e55a3314bcb0..38a6d66d9e88 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -90,37 +90,69 @@
> =C2=A0#define DN_ATTRIB	0x00000020	/* File changed attibutes */
> =C2=A0#define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
> =C2=A0
> +#define AT_FDCWD		-100=C2=A0=C2=A0=C2=A0 /* Special value for dirfd used=
 to
> +					=C2=A0=C2=A0 indicate openat should use the
> +					=C2=A0=C2=A0 current working directory. */
> +
> +
> +/* Generic flags for the *at(2) family of syscalls. */
> +
> +/* Reserved for per-syscall flags	0xff. */
> +#define AT_SYMLINK_NOFOLLOW		0x100=C2=A0=C2=A0 /* Do not follow symbolic
> +						=C2=A0=C2=A0 links. */
> +/* Reserved for per-syscall flags	0x200 */
> +#define AT_SYMLINK_FOLLOW		0x400=C2=A0=C2=A0 /* Follow symbolic links. *=
/
> +#define AT_NO_AUTOMOUNT			0x800	/* Suppress terminal automount
> +						=C2=A0=C2=A0 traversal. */
> +#define AT_EMPTY_PATH			0x1000	/* Allow empty relative
> +						=C2=A0=C2=A0 pathname to operate on dirfd
> +						=C2=A0=C2=A0 directly. */
> =C2=A0/*
> - * The constants AT_REMOVEDIR and AT_EACCESS have the same value.=C2=A0 =
AT_EACCESS is
> - * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only t=
o
> - * unlinkat.=C2=A0 The two functions do completely different things and =
therefore,
> - * the flags can be allowed to overlap.=C2=A0 For example, passing AT_RE=
MOVEDIR to
> - * faccessat would be undefined behavior and thus treating it equivalent=
 to
> - * AT_EACCESS is valid undefined behavior.
> + * These flags are currently statx(2)-specific, but they could be made g=
eneric
> + * in the future and so they should not be used for other per-syscall fl=
ags.
> =C2=A0 */
> -#define AT_FDCWD		-100=C2=A0=C2=A0=C2=A0 /* Special value used to indica=
te
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 openat should use the current
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 working directory. */
> -#define AT_SYMLINK_NOFOLLOW	0x100=C2=A0=C2=A0 /* Do not follow symbolic =
links.=C2=A0 */
> +#define AT_STATX_SYNC_TYPE		0x6000	/* Type of synchronisation required f=
rom statx() */
> +#define AT_STATX_SYNC_AS_STAT		0x0000	/* - Do whatever stat() does */
> +#define AT_STATX_FORCE_SYNC		0x2000	/* - Force the attributes to be sync=
'd with the server */
> +#define AT_STATX_DONT_SYNC		0x4000	/* - Don't sync attributes with the s=
erver */
> +
> +#define AT_RECURSIVE			0x8000	/* Apply to the entire subtree */
> +
> +/*
> + * Per-syscall flags for the *at(2) family of syscalls.
> + *
> + * These are flags that are so syscall-specific that a user passing thes=
e flags
> + * to the wrong syscall is so "clearly wrong" that we can safely call su=
ch
> + * usage "undefined behaviour".
> + *
> + * For example, the constants AT_REMOVEDIR and AT_EACCESS have the same =
value.
> + * AT_EACCESS is meaningful only to faccessat, while AT_REMOVEDIR is mea=
ningful
> + * only to unlinkat. The two functions do completely different things an=
d
> + * therefore, the flags can be allowed to overlap. For example, passing
> + * AT_REMOVEDIR to faccessat would be undefined behavior and thus treati=
ng it
> + * equivalent to AT_EACCESS is valid undefined behavior.
> + *
> + * Note for implementers: When picking a new per-syscall AT_* flag, try =
to
> + * reuse already existing flags first. This leaves us with as many unuse=
d bits
> + * as possible, so we can use them for generic bits in the future if nec=
essary.
> + */
> +
> +/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> +#define AT_RENAME_NOREPLACE	0x0001
> +#define AT_RENAME_EXCHANGE	0x0002
> +#define AT_RENAME_WHITEOUT	0x0004
> +
> +/* Flag for faccessat(2). */
> =C2=A0#define AT_EACCESS		0x200	/* Test access permitted for
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 effective IDs, not real IDs.=C2=A0 */
> +/* Flag for unlinkat(2). */
> =C2=A0#define AT_REMOVEDIR		0x200=C2=A0=C2=A0 /* Remove directory instead=
 of
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlinking file.=C2=A0 */
> -#define AT_SYMLINK_FOLLOW	0x400=C2=A0=C2=A0 /* Follow symbolic links.=C2=
=A0 */
> -#define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal =
*/
> -#define AT_EMPTY_PATH		0x1000	/* Allow empty relative pathname */
> -
> -#define AT_STATX_SYNC_TYPE	0x6000	/* Type of synchronisation required fr=
om statx() */
> -#define AT_STATX_SYNC_AS_STAT	0x0000	/* - Do whatever stat() does */
> -#define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'=
d with the server */
> -#define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the se=
rver */
> -
> -#define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
> +/* Flags for name_to_handle_at(2). */
> +#define AT_HANDLE_FID		0x200	/* File handle is needed to compare
> +					=C2=A0=C2=A0 object identity and may not be
> +					=C2=A0=C2=A0 usable with open_by_handle_at(2). */
> =C2=A0
> -/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits.=
.. */
> -#define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
> -					compare object identity and may not
> -					be usable to open_by_handle_at(2) */
> =C2=A0#if defined(__KERNEL__)
> =C2=A0#define AT_GETATTR_NOSEC	0x80000000
> =C2=A0#endif
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/p=
erf/trace/beauty/include/uapi/linux/fcntl.h
> index c0bcc185fa48..38a6d66d9e88 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
> @@ -16,6 +16,9 @@
> =C2=A0
> =C2=A0#define F_DUPFD_QUERY	(F_LINUX_SPECIFIC_BASE + 3)
> =C2=A0
> +/* Was the file just created? */
> +#define F_CREATED_QUERY	(F_LINUX_SPECIFIC_BASE + 4)
> +
> =C2=A0/*
> =C2=A0 * Cancel a blocking posix lock; internal use only until we expose =
an
> =C2=A0 * asynchronous lock api to userspace:
> @@ -87,37 +90,69 @@
> =C2=A0#define DN_ATTRIB	0x00000020	/* File changed attibutes */
> =C2=A0#define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
> =C2=A0
> +#define AT_FDCWD		-100=C2=A0=C2=A0=C2=A0 /* Special value for dirfd used=
 to
> +					=C2=A0=C2=A0 indicate openat should use the
> +					=C2=A0=C2=A0 current working directory. */
> +
> +
> +/* Generic flags for the *at(2) family of syscalls. */
> +
> +/* Reserved for per-syscall flags	0xff. */
> +#define AT_SYMLINK_NOFOLLOW		0x100=C2=A0=C2=A0 /* Do not follow symbolic
> +						=C2=A0=C2=A0 links. */
> +/* Reserved for per-syscall flags	0x200 */
> +#define AT_SYMLINK_FOLLOW		0x400=C2=A0=C2=A0 /* Follow symbolic links. *=
/
> +#define AT_NO_AUTOMOUNT			0x800	/* Suppress terminal automount
> +						=C2=A0=C2=A0 traversal. */
> +#define AT_EMPTY_PATH			0x1000	/* Allow empty relative
> +						=C2=A0=C2=A0 pathname to operate on dirfd
> +						=C2=A0=C2=A0 directly. */
> +/*
> + * These flags are currently statx(2)-specific, but they could be made g=
eneric
> + * in the future and so they should not be used for other per-syscall fl=
ags.
> + */
> +#define AT_STATX_SYNC_TYPE		0x6000	/* Type of synchronisation required f=
rom statx() */
> +#define AT_STATX_SYNC_AS_STAT		0x0000	/* - Do whatever stat() does */
> +#define AT_STATX_FORCE_SYNC		0x2000	/* - Force the attributes to be sync=
'd with the server */
> +#define AT_STATX_DONT_SYNC		0x4000	/* - Don't sync attributes with the s=
erver */
> +
> +#define AT_RECURSIVE			0x8000	/* Apply to the entire subtree */
> +
> =C2=A0/*
> - * The constants AT_REMOVEDIR and AT_EACCESS have the same value.=C2=A0 =
AT_EACCESS is
> - * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only t=
o
> - * unlinkat.=C2=A0 The two functions do completely different things and =
therefore,
> - * the flags can be allowed to overlap.=C2=A0 For example, passing AT_RE=
MOVEDIR to
> - * faccessat would be undefined behavior and thus treating it equivalent=
 to
> - * AT_EACCESS is valid undefined behavior.
> + * Per-syscall flags for the *at(2) family of syscalls.
> + *
> + * These are flags that are so syscall-specific that a user passing thes=
e flags
> + * to the wrong syscall is so "clearly wrong" that we can safely call su=
ch
> + * usage "undefined behaviour".
> + *
> + * For example, the constants AT_REMOVEDIR and AT_EACCESS have the same =
value.
> + * AT_EACCESS is meaningful only to faccessat, while AT_REMOVEDIR is mea=
ningful
> + * only to unlinkat. The two functions do completely different things an=
d
> + * therefore, the flags can be allowed to overlap. For example, passing
> + * AT_REMOVEDIR to faccessat would be undefined behavior and thus treati=
ng it
> + * equivalent to AT_EACCESS is valid undefined behavior.
> + *
> + * Note for implementers: When picking a new per-syscall AT_* flag, try =
to
> + * reuse already existing flags first. This leaves us with as many unuse=
d bits
> + * as possible, so we can use them for generic bits in the future if nec=
essary.
> =C2=A0 */
> -#define AT_FDCWD		-100=C2=A0=C2=A0=C2=A0 /* Special value used to indica=
te
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 openat should use the current
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 working directory. */
> -#define AT_SYMLINK_NOFOLLOW	0x100=C2=A0=C2=A0 /* Do not follow symbolic =
links.=C2=A0 */
> +
> +/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> +#define AT_RENAME_NOREPLACE	0x0001
> +#define AT_RENAME_EXCHANGE	0x0002
> +#define AT_RENAME_WHITEOUT	0x0004
> +
> +/* Flag for faccessat(2). */
> =C2=A0#define AT_EACCESS		0x200	/* Test access permitted for
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 effective IDs, not real IDs.=C2=A0 */
> +/* Flag for unlinkat(2). */
> =C2=A0#define AT_REMOVEDIR		0x200=C2=A0=C2=A0 /* Remove directory instead=
 of
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlinking file.=C2=A0 */
> -#define AT_SYMLINK_FOLLOW	0x400=C2=A0=C2=A0 /* Follow symbolic links.=C2=
=A0 */
> -#define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal =
*/
> -#define AT_EMPTY_PATH		0x1000	/* Allow empty relative pathname */
> -
> -#define AT_STATX_SYNC_TYPE	0x6000	/* Type of synchronisation required fr=
om statx() */
> -#define AT_STATX_SYNC_AS_STAT	0x0000	/* - Do whatever stat() does */
> -#define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'=
d with the server */
> -#define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the se=
rver */
> -
> -#define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
> +/* Flags for name_to_handle_at(2). */
> +#define AT_HANDLE_FID		0x200	/* File handle is needed to compare
> +					=C2=A0=C2=A0 object identity and may not be
> +					=C2=A0=C2=A0 usable with open_by_handle_at(2). */
> =C2=A0
> -/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits.=
.. */
> -#define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
> -					compare object identity and may not
> -					be usable to open_by_handle_at(2) */
> =C2=A0#if defined(__KERNEL__)
> =C2=A0#define AT_GETATTR_NOSEC	0x80000000
> =C2=A0#endif
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

