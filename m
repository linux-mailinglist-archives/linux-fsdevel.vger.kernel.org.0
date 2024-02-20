Return-Path: <linux-fsdevel+bounces-12144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A3D85B82B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0795B248E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252D762162;
	Tue, 20 Feb 2024 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/NMLa1k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F52361699;
	Tue, 20 Feb 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422496; cv=none; b=MS0nxEUO8okpLVHaU/oTAp204X2tUmrCyJP7lzfmY5sVVs/LT6ZEPZI9oMiArjI34zEyvLk5YlgCeWI0G0tqsFrktZ49sL/oemRvGwdrHC03zyHH66z1O/Ds3IclF96Yo0F8W1pTwBIl46BUyS88YF6zxKJexeZcXjn1mla+0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422496; c=relaxed/simple;
	bh=ycB7feGoMgOOYRRk2SzQ5E4UrY1BK6VU1Ai3KyHgdwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPe3Pgc+757n9SQsL6P77czTmA/y11nHAXEXE480cPIKe3f1aCnjXklDGD9NQQPD70bmPrnVvWUvtrziJydM5BpVa+FwOlOUDlseL5EGJVZmaLNrXZMCPttT5KoZhkGbxLvZkGayB4z7GNUtFRWU98NA6ctDYfLyUCpTXbeJyxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/NMLa1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0A8C43390;
	Tue, 20 Feb 2024 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708422496;
	bh=ycB7feGoMgOOYRRk2SzQ5E4UrY1BK6VU1Ai3KyHgdwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/NMLa1kkSbZ8oURln4ckWxg/R6k55qYd+S4NfVFKFpKG7ehZkUGvHM0PaPkMHELJ
	 oCBHUAKWwxdG1AWLHSdcOVnTbokPWA7Gioq/ur1/cj6kIQXT7PgwQNR30bwdq4H9wL
	 GEnrX39HYFsUrV9VpdKbhfmHIOsdM5p7b2n8tGEVKdu9qDRmoXEwfGy0I4U/YWhuUy
	 8L4yY4wtj4N+55irvd8Y++Etwiuxm0yb23W97D1m0gmfjoH7z5NIGMtELxfriztXyk
	 uQRwjFgr+f5WQuhhXtF19njEoP7IhwkwEATuTZ8Utc1imxsuLGEpt7Us6kRLV2r1E6
	 gUZ6CUlI+W/AA==
Date: Tue, 20 Feb 2024 10:48:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	kpsingh@google.com, jannh@google.com, jolsa@kernel.org, daniel@iogearbox.net, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH bpf-next 01/11] bpf: make bpf_d_path() helper use
 probe-read semantics
Message-ID: <20240220-erstochen-notwehr-755dbd0a02b3@brauner>
References: <cover.1708377880.git.mattbobrowski@google.com>
 <5643840bd57d0c2345635552ae228dfb2ed3428c.1708377880.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5643840bd57d0c2345635552ae228dfb2ed3428c.1708377880.git.mattbobrowski@google.com>

On Tue, Feb 20, 2024 at 09:27:23AM +0000, Matt Bobrowski wrote:
> There has now been several reported instances [0, 1, 2] where the
> usage of the BPF helper bpf_d_path() has led to some form of memory
> corruption issue.
> 
> The fundamental reason behind why we repeatedly see bpf_d_path() being
> susceptible to such memory corruption issues is because it only
> enforces ARG_PTR_TO_BTF_ID constraints onto it's struct path
> argument. This essentially means that it only requires an in-kernel
> pointer of type struct path to be provided to it. Depending on the
> underlying context and where the supplied struct path was obtained
> from and when, depends on whether the struct path is fully intact or
> not when calling bpf_d_path(). It's certainly possible to call
> bpf_d_path() and subsequently d_path() from contexts where the
> supplied struct path to bpf_d_path() has already started being torn
> down by __fput() and such. An example of this is perfectly illustrated
> in [0].
> 
> Moving forward, we simply cannot enforce KF_TRUSTED_ARGS semantics
> onto struct path of bpf_d_path(), as this approach would presumably
> lead to some pretty wide scale and highly undesirable BPF program
> breakage. To avoid breaking any pre-existing BPF program that is
> dependent on bpf_d_path(), I propose that we take a different path and
> re-implement an incredibly minimalistic and bare bone version of
> d_path() which is entirely backed by kernel probe-read semantics. IOW,
> a version of d_path() that is backed by
> copy_from_kernel_nofault(). This ensures that any reads performed
> against the supplied struct path to bpf_d_path() which may end up
> faulting for whatever reason end up being gracefully handled and fixed
> up.
> 
> The caveats with such an approach is that we can't fully uphold all of
> d_path()'s path resolution capabilities. Resolving a path which is
> comprised of a dentry that make use of dynamic names via isn't
> possible as we can't enforce probe-read semantics onto indirect
> function calls performed via d_op as they're implementation
> dependent. For such cases, we just return -EOPNOTSUPP. This might be a
> little surprising to some users, especially those that are interested
> in resolving paths that involve a dentry that resides on some
> non-mountable pseudo-filesystem, being pipefs/sockfs/nsfs, but it's
> arguably better than enforcing KF_TRUSTED_ARGS onto bpf_d_path() and
> causing an unnecessary shemozzle for users. Additionally, we don't

NAK. We're not going to add a semi-functional reimplementation of
d_path() for bpf. This relied on VFS internals and guarantees that were
never given. Restrict it to KF_TRUSTED_ARGS as it was suggested when
this originally came up or fix it another way. But we're not adding a
bunch of kfuncs to even more sensitive VFS machinery and then build a
d_path() clone just so we can retroactively justify broken behavior.

> make use of all the locking semantics, or handle all the erroneous
> cases in which d_path() naturally would. This is fine however, as
> we're only looking to provide users with a rather acceptable version
> of a reconstructed path, whilst they eventually migrate over to the
> trusted bpf_path_d_path() BPF kfunc variant.
> 
> Note that the selftests that go with this change to bpf_d_path() have
> been purposely split out into a completely separate patch. This is so
> that the reviewers attention is not torn by noise and can remain
> focused on reviewing the implementation details contained within this
> patch.
> 
> [0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/
> [1] https://lore.kernel.org/bpf/20230606181714.532998-1-jolsa@kernel.org/
> [2] https://lore.kernel.org/bpf/20220219113744.1852259-1-memxor@gmail.com/
> 
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  fs/Makefile                       |   6 +-
>  fs/probe_read_d_path.c            | 150 ++++++++++++++++++++++++++++++
>  include/linux/probe_read_d_path.h |  13 +++
>  kernel/trace/bpf_trace.c          |  13 ++-
>  4 files changed, 172 insertions(+), 10 deletions(-)
>  create mode 100644 fs/probe_read_d_path.c
>  create mode 100644 include/linux/probe_read_d_path.h
> 
> diff --git a/fs/Makefile b/fs/Makefile
> index c09016257f05..945c9c84d35d 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -4,7 +4,7 @@
>  #
>  # 14 Sep 2000, Christoph Hellwig <hch@infradead.org>
>  # Rewritten to use lists instead of if-statements.
> -# 
> +#
>  
>  
>  obj-y :=	open.o read_write.o file_table.o super.o \
> @@ -12,7 +12,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
>  		ioctl.o readdir.o select.o dcache.o inode.o \
>  		attr.o bad_inode.o file.o filesystems.o namespace.o \
>  		seq_file.o xattr.o libfs.o fs-writeback.o \
> -		pnode.o splice.o sync.o utimes.o d_path.o \
> +		pnode.o splice.o sync.o utimes.o d_path.o probe_read_d_path.o \
>  		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
>  		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
>  		kernel_read_file.o mnt_idmapping.o remap_range.o
> @@ -58,7 +58,7 @@ obj-$(CONFIG_CONFIGFS_FS)	+= configfs/
>  obj-y				+= devpts/
>  
>  obj-$(CONFIG_DLM)		+= dlm/
> - 
> +
>  # Do not add any filesystems before this line
>  obj-$(CONFIG_NETFS_SUPPORT)	+= netfs/
>  obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
> diff --git a/fs/probe_read_d_path.c b/fs/probe_read_d_path.c
> new file mode 100644
> index 000000000000..8d0db902f836
> --- /dev/null
> +++ b/fs/probe_read_d_path.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Google LLC.
> + */
> +
> +#include "asm/ptrace.h"
> +#include <linux/container_of.h>
> +#include <linux/dcache.h>
> +#include <linux/fs_struct.h>
> +#include <linux/uaccess.h>
> +#include <linux/path.h>
> +#include <linux/probe_read_d_path.h>
> +
> +#include "mount.h"
> +
> +#define PROBE_READ(src)                                              \
> +	({                                                           \
> +		typeof(src) __r;                                     \
> +		if (copy_from_kernel_nofault((void *)(&__r), (&src), \
> +					     sizeof((__r))))         \
> +			memset((void *)(&__r), 0, sizeof((__r)));    \
> +		__r;                                                 \
> +	})
> +
> +static inline bool probe_read_d_unlinked(const struct dentry *dentry)
> +{
> +	return !PROBE_READ(dentry->d_hash.pprev) &&
> +	       !(dentry == PROBE_READ(dentry->d_parent));
> +}
> +
> +static long probe_read_prepend(const char *s, int len, char *buf, int *buflen)
> +{
> +	/*
> +	 * The supplied len that is to be copied into the buffer will result in
> +	 * an overflow. The true implementation of d_path() already returns an
> +	 * error for such overflow cases, so the semantics with regards to the
> +	 * bpf_d_path() helper returning the same error value for overflow cases
> +	 * remain the same.
> +	 */
> +	if (len > *buflen)
> +		return -ENAMETOOLONG;
> +
> +	/*
> +	 * The supplied string fits completely into the remaining buffer
> +	 * space. Attempt to make the copy.
> +	 */
> +	*buflen -= len;
> +	buf += *buflen;
> +	return copy_from_kernel_nofault(buf, s, len);
> +}
> +
> +static bool use_dname(const struct path *path)
> +{
> +	const struct dentry_operations *d_op;
> +	char *(*d_dname)(struct dentry *, char *, int);
> +
> +	d_op = PROBE_READ(path->dentry->d_op);
> +	d_dname = PROBE_READ(d_op->d_dname);
> +
> +	return d_op && d_dname &&
> +	       (!(path->dentry == PROBE_READ(path->dentry->d_parent)) ||
> +		path->dentry != PROBE_READ(path->mnt->mnt_root));
> +}
> +
> +char *probe_read_d_path(const struct path *path, char *buf, int buflen)
> +{
> +	int len;
> +	long err;
> +	struct path root;
> +	struct mount *mnt;
> +	struct dentry *dentry;
> +
> +	dentry = path->dentry;
> +	mnt = container_of(path->mnt, struct mount, mnt);
> +
> +	/*
> +	 * We cannot back dentry->d_op->d_dname() with probe-read semantics, so
> +	 * just return an error to the caller when the supplied path contains a
> +	 * dentry component that makes use of a dynamic name.
> +	 */
> +	if (use_dname(path))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	err = probe_read_prepend("\0", 1, buf, &buflen);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	if (probe_read_d_unlinked(dentry)) {
> +		err = probe_read_prepend(" (deleted)", 10, buf, &buflen);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
> +	len = buflen;
> +	root = PROBE_READ(current->fs->root);
> +	while (dentry != root.dentry || &mnt->mnt != root.mnt) {
> +		struct dentry *parent;
> +		if (dentry == PROBE_READ(mnt->mnt.mnt_root)) {
> +			struct mount *m;
> +
> +			m = PROBE_READ(mnt->mnt_parent);
> +			if (mnt != m) {
> +				dentry = PROBE_READ(mnt->mnt_mountpoint);
> +				mnt = m;
> +				continue;
> +			}
> +
> +			/*
> +			 * If we've reached the global root, then there's
> +			 * nothing we can really do but bail.
> +			 */
> +			break;
> +		}
> +
> +		parent = PROBE_READ(dentry->d_parent);
> +		if (dentry == parent) {
> +			/*
> +			 * Escaped? We return an ECANCELED error here to signify
> +			 * that we've prematurely terminated pathname
> +			 * reconstruction. We've potentially hit a root dentry
> +			 * that isn't associated with any roots from the mounted
> +			 * filesystems that we've jumped through, so it's not
> +			 * clear where we are in the VFS exactly.
> +			 */
> +			err = -ECANCELED;
> +			break;
> +		}
> +
> +		err = probe_read_prepend(dentry->d_name.name,
> +					 PROBE_READ(dentry->d_name.len), buf,
> +					 &buflen);
> +		if (err)
> +			break;
> +
> +		err = probe_read_prepend("/", 1, buf, &buflen);
> +		if (err)
> +			break;
> +		dentry = parent;
> +	}
> +
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	if (len == buflen) {
> +		err = probe_read_prepend("/", 1, buf, &buflen);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +	return buf + buflen;
> +}
> diff --git a/include/linux/probe_read_d_path.h b/include/linux/probe_read_d_path.h
> new file mode 100644
> index 000000000000..9b3908746657
> --- /dev/null
> +++ b/include/linux/probe_read_d_path.h
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Google LLC.
> + */
> +
> +#ifndef _LINUX_PROBE_READ_D_PATH_H
> +#define _LINUX_PROBE_READ_D_PATH_H
> +
> +#include <linux/path.h>
> +
> +extern char *probe_read_d_path(const struct path *path, char *buf, int buflen);
> +
> +#endif /* _LINUX_PROBE_READ_D_PATH_H */
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 241ddf5e3895..12dbd9cef1fa 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -25,6 +25,7 @@
>  #include <linux/verification.h>
>  #include <linux/namei.h>
>  #include <linux/fileattr.h>
> +#include <linux/probe_read_d_path.h>
>  
>  #include <net/bpf_sk_storage.h>
>  
> @@ -923,14 +924,12 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
>  	if (len < 0)
>  		return len;
>  
> -	p = d_path(&copy, buf, sz);
> -	if (IS_ERR(p)) {
> -		len = PTR_ERR(p);
> -	} else {
> -		len = buf + sz - p;
> -		memmove(buf, p, len);
> -	}
> +	p = probe_read_d_path(&copy, buf, sz);
> +	if (IS_ERR(p))
> +		return PTR_ERR(p);
>  
> +	len = buf + sz - p;
> +	memmove(buf, p, len);
>  	return len;
>  }
>  
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 
> /M

