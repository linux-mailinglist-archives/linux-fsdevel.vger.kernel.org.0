Return-Path: <linux-fsdevel+bounces-56727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84411B1AF56
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 09:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DE2A4E17B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 07:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7BD23AB8F;
	Tue,  5 Aug 2025 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="xLs7dR6V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5EF282EE;
	Tue,  5 Aug 2025 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754378969; cv=none; b=HvBcB+0sOIdQEHlABYjWU9sChLwmSc+/rmOvtr9upJyzQisBF9EVlzFKtUbgtAyWdONcS4W6h8y0TOebKHEjcChggBJYIMASnEDLEBCNdMgP48gB2mM3yNM7BseqZ5DJdPa3FF8L5PK5sC+3hfLE4el1fkrAU87BMM+kCFenCY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754378969; c=relaxed/simple;
	bh=YiSBx51qUAJhEI1Vc8mOuai6IqOQu/TakE/doWnHuFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Offn8/zGx+KSfZxwKnflLLpqmUTFxcmE5inoPHH6DqJdxFNJJJik8hZVCc6ot99KsEHkv0WPQJ6teDooTqIk8jLeHya2PWAvKZpx1XWvkay4qC9VJCUIi9VCsz/8S30p2zx7fFBo+A3g8xtCPZ18mH7W7DqUvm0OkeGwjNsNX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=xLs7dR6V; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bx4mz1YqVz9sqy;
	Tue,  5 Aug 2025 09:29:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754378963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pfh8YJ4n3uQCmVckM45sIplsuScMr3VZ5PLpA8Dw3NM=;
	b=xLs7dR6Vmy3KBoEtHV6RG5nPh39Q/vHHLVGDhIEG/L0MFDYaxGZD9vjTmX0vM4dwWwlY5m
	xnMj7qKnybzTp5Bik6fSlL0Pt7MqgVUT3+z7cdmI9pWwZEsU9ADX3vd+v+b3pXw7BPvth4
	C1BmLy/HzQcOpHz+rjhQzHVCZoKeMd+7CQCgb0kV0JdxVhrQRmjzyCRqOYLuqvyMoGv4zt
	HCdm7Mt+nvooS3eks+q+EzwQWWQEnDg2J0tx/Iv4J+8XRTuDgRqkG+uENlW9R1xzFxuj0b
	tXtM94tk8m5SclXE3yK79i6MlSWoQ0pHKBJB69lloMnDNQUjVG2e4cQSmfxl7g==
Date: Tue, 5 Aug 2025 17:29:07 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 2/4] procfs: add "pidns" mount option
Message-ID: <2025-08-05.1754378656-steep-harps-muscled-mailroom-lively-gosling-VVGNTP@cyphar.com>
References: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
 <20250805-procfs-pidns-api-v4-2-705f984940e7@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5o54eqw2png257t6"
Content-Disposition: inline
In-Reply-To: <20250805-procfs-pidns-api-v4-2-705f984940e7@cyphar.com>


--5o54eqw2png257t6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/4] procfs: add "pidns" mount option
MIME-Version: 1.0

On 2025-08-05, Aleksa Sarai <cyphar@cyphar.com> wrote:
> Since the introduction of pid namespaces, their interaction with procfs
> has been entirely implicit in ways that require a lot of dancing around
> by programs that need to construct sandboxes with different PID
> namespaces.
>=20
> Being able to explicitly specify the pid namespace to use when
> constructing a procfs super block will allow programs to no longer need
> to fork off a process which does then does unshare(2) / setns(2) and
> forks again in order to construct a procfs in a pidns.
>=20
> So, provide a "pidns" mount option which allows such users to just
> explicitly state which pid namespace they want that procfs instance to
> use. This interface can be used with fsconfig(2) either with a file
> descriptor or a path:
>=20
>   fsconfig(procfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
>   fsconfig(procfd, FSCONFIG_SET_STRING, "pidns", "/proc/self/ns/pid", 0);
>=20
> or with classic mount(2) / mount(8):
>=20
>   // mount -t proc -o pidns=3D/proc/self/ns/pid proc /tmp/proc
>   mount("proc", "/tmp/proc", "proc", MS_..., "pidns=3D/proc/self/ns/pid");
>=20
> As this new API is effectively shorthand for setns(2) followed by
> mount(2), the permission model for this mirrors pidns_install() to avoid
> opening up new attack surfaces by loosening the existing permission
> model.
>=20
> In order to avoid having to RCU-protect all users of proc_pid_ns() (to
> avoid UAFs), attempting to reconfigure an existing procfs instance's pid
> namespace will error out with -EBUSY. Creating new procfs instances is
> quite cheap, so this should not be an impediment to most users, and lets
> us avoid a lot of churn in fs/proc/* for a feature that it seems
> unlikely userspace would use.
>=20
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  Documentation/filesystems/proc.rst |  8 ++++
>  fs/proc/root.c                     | 98 ++++++++++++++++++++++++++++++++=
+++---
>  2 files changed, 100 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
> index 5236cb52e357..5a157dadea0b 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -2360,6 +2360,7 @@ The following mount options are supported:
>  	hidepid=3D	Set /proc/<pid>/ access mode.
>  	gid=3D		Set the group authorized to learn processes information.
>  	subset=3D		Show only the specified subset of procfs.
> +	pidns=3D		Specify a the namespace used by this procfs.
>  	=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  hidepid=3Doff or hidepid=3D0 means classic mode - everybody may access a=
ll
> @@ -2392,6 +2393,13 @@ information about processes information, just add =
identd to this group.
>  subset=3Dpid hides all top level files and directories in the procfs that
>  are not related to tasks.
> =20
> +pidns=3D specifies a pid namespace (either as a string path to something=
 like
> +`/proc/$pid/ns/pid`, or a file descriptor when using `FSCONFIG_SET_FD`) =
that
> +will be used by the procfs instance when translating pids. By default, p=
rocfs
> +will use the calling process's active pid namespace. Note that the pid
> +namespace of an existing procfs instance cannot be modified (attempting =
to do
> +so will give an `-EBUSY` error).
> +
>  Chapter 5: Filesystem behavior
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> =20
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index ed86ac710384..fd1f1c8a939a 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -38,12 +38,14 @@ enum proc_param {
>  	Opt_gid,
>  	Opt_hidepid,
>  	Opt_subset,
> +	Opt_pidns,
>  };
> =20
>  static const struct fs_parameter_spec proc_fs_parameters[] =3D {
> -	fsparam_u32("gid",	Opt_gid),
> +	fsparam_u32("gid",		Opt_gid),
>  	fsparam_string("hidepid",	Opt_hidepid),
>  	fsparam_string("subset",	Opt_subset),
> +	fsparam_file_or_string("pidns",	Opt_pidns),
>  	{}
>  };
> =20
> @@ -109,11 +111,66 @@ static int proc_parse_subset_param(struct fs_contex=
t *fc, char *value)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PID_NS
> +static int proc_parse_pidns_param(struct fs_context *fc,
> +				  struct fs_parameter *param,
> +				  struct fs_parse_result *result)
> +{
> +	struct proc_fs_context *ctx =3D fc->fs_private;
> +	struct pid_namespace *target, *active =3D task_active_pid_ns(current);
> +	struct ns_common *ns;
> +	struct file *ns_filp __free(fput) =3D NULL;
> +
> +	switch (param->type) {
> +	case fs_value_is_file:
> +		/* came through fsconfig, steal the file reference */
> +		ns_filp =3D no_free_ptr(param->file);
> +		break;
> +	case fs_value_is_string:
> +		ns_filp =3D filp_open(param->string, O_RDONLY, 0);
> +		break;

I just realised that we probably also want to support FSCONFIG_SET_PATH
here, but fsparam_file_or_string() doesn't handle that at the moment. I
think we probably want to have fsparam_file_or_path() which would act
like:

 1. A path with FSCONFIG_SET_STRING and FSCONFIG_SET_PATH.
 2. A file with FSCONFIG_SET_FD.

These are the semantics I would already expect from these kinds of
flags, but at the moment FSCONFIG_SET_PATH is entirely disallowed.

@Amir:

I wonder if overlayfs (the only other user of fsparam_file_or_string())
would also prefer having these semantics? We could just migrate
fsparam_file_or_string() to fsparam_file_or_path() everwhere, since I'm
pretty sure these are the semantics userspace expects anyway.

> +	default:
> +		WARN_ON_ONCE(true);
> +		break;
> +	}
> +	if (!ns_filp)
> +		ns_filp =3D ERR_PTR(-EBADF);
> +	if (IS_ERR(ns_filp)) {
> +		errorfc(fc, "could not get file from pidns argument");
> +		return PTR_ERR(ns_filp);
> +	}
> +
> +	if (!proc_ns_file(ns_filp))
> +		return invalfc(fc, "pidns argument is not an nsfs file");
> +	ns =3D get_proc_ns(file_inode(ns_filp));
> +	if (ns->ops->type !=3D CLONE_NEWPID)
> +		return invalfc(fc, "pidns argument is not a pidns file");
> +	target =3D container_of(ns, struct pid_namespace, ns);
> +
> +	/*
> +	 * pidns=3D is shorthand for joining the pidns to get a fsopen fd, so t=
he
> +	 * permission model should be the same as pidns_install().
> +	 */
> +	if (!ns_capable(target->user_ns, CAP_SYS_ADMIN)) {
> +		errorfc(fc, "insufficient permissions to set pidns");
> +		return -EPERM;
> +	}
> +	if (!pidns_is_ancestor(target, active))
> +		return invalfc(fc, "cannot set pidns to non-descendant pidns");
> +
> +	put_pid_ns(ctx->pid_ns);
> +	ctx->pid_ns =3D get_pid_ns(target);
> +	put_user_ns(fc->user_ns);
> +	fc->user_ns =3D get_user_ns(ctx->pid_ns->user_ns);
> +	return 0;
> +}
> +#endif /* CONFIG_PID_NS */
> +
>  static int proc_parse_param(struct fs_context *fc, struct fs_parameter *=
param)
>  {
>  	struct proc_fs_context *ctx =3D fc->fs_private;
>  	struct fs_parse_result result;
> -	int opt;
> +	int opt, err;
> =20
>  	opt =3D fs_parse(fc, proc_fs_parameters, param, &result);
>  	if (opt < 0)
> @@ -125,14 +182,38 @@ static int proc_parse_param(struct fs_context *fc, =
struct fs_parameter *param)
>  		break;
> =20
>  	case Opt_hidepid:
> -		if (proc_parse_hidepid_param(fc, param))
> -			return -EINVAL;
> +		err =3D proc_parse_hidepid_param(fc, param);
> +		if (err)
> +			return err;
>  		break;
> =20
>  	case Opt_subset:
> -		if (proc_parse_subset_param(fc, param->string) < 0)
> -			return -EINVAL;
> +		err =3D proc_parse_subset_param(fc, param->string);
> +		if (err)
> +			return err;
> +		break;
> +
> +	case Opt_pidns:
> +#ifdef CONFIG_PID_NS
> +		/*
> +		 * We would have to RCU-protect every proc_pid_ns() or
> +		 * proc_sb_info() access if we allowed this to be reconfigured
> +		 * for an existing procfs instance. Luckily, procfs instances
> +		 * are cheap to create, and mount-beneath would let you
> +		 * atomically replace an instance even with overmounts.
> +		 */
> +		if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE) {
> +			errorfc(fc, "cannot reconfigure pidns for existing procfs");
> +			return -EBUSY;
> +		}
> +		err =3D proc_parse_pidns_param(fc, param, &result);
> +		if (err)
> +			return err;
>  		break;
> +#else
> +		errorfc(fc, "pidns mount flag not supported on this system");
> +		return -EOPNOTSUPP;
> +#endif
> =20
>  	default:
>  		return -EINVAL;
> @@ -154,6 +235,11 @@ static void proc_apply_options(struct proc_fs_info *=
fs_info,
>  		fs_info->hide_pid =3D ctx->hidepid;
>  	if (ctx->mask & (1 << Opt_subset))
>  		fs_info->pidonly =3D ctx->pidonly;
> +	if (ctx->mask & (1 << Opt_pidns) &&
> +	    !WARN_ON_ONCE(fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE)) {
> +		put_pid_ns(fs_info->pid_ns);
> +		fs_info->pid_ns =3D get_pid_ns(ctx->pid_ns);
> +	}
>  }
> =20
>  static int proc_fill_super(struct super_block *s, struct fs_context *fc)
>=20
> --=20
> 2.50.1
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--5o54eqw2png257t6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJGywwAKCRAol/rSt+lE
b9g9AP0cbo5zi5SaWHVkITOZ9tdmZPQ3mBfvQN80O6xOYxAasQD9GGvqDQLIZudv
LWdGv0XCW63Bw5sA4NH64WxUuKaO3wk=
=YRkM
-----END PGP SIGNATURE-----

--5o54eqw2png257t6--

