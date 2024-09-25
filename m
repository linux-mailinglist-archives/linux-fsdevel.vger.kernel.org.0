Return-Path: <linux-fsdevel+bounces-30108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E356C986423
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A056928F222
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93771B949;
	Wed, 25 Sep 2024 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="BNpAv7r9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F051B963;
	Wed, 25 Sep 2024 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279441; cv=none; b=NLgieocGAMImqE7qXxkpVx9Ogoy1zp/yWazvDL0E+MPBUut50lT25wvhd0ITaaFM8jpOoBaUFOQpx9S/6/O432XP2q2Cxh0OtmmvM972pVlId6zqjps847CpFZ3Vzsw8vwAe3NNdg5kEK1VVHLLVx9aRIhx8gg8p4OncX8joOVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279441; c=relaxed/simple;
	bh=CB+3Lp3VN774vqHi8/oCBn9vplfDccD6BeDeA6L4O4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgP8YVhjAyxmeIXhdotzzHzwQkaDZ1pIlLXA1fG62fXZUKdkELSdu8UwQJkgCd4gyVrWx2aWMYmcYdRyf/RgsGaMeEtWIbTP/DSQ7LR7R6LLM16F0ZfBKX72f5QePzEiK5xK9QKsUdAnC069j7ecezpBEM1tz8wRZkYF71fv6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=BNpAv7r9; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XDLm51Fzgz9v6Q;
	Wed, 25 Sep 2024 17:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1727279429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQf8ojWSXWZSZ6MYBGzujgts/DM5JNOMcUzwckxOaIM=;
	b=BNpAv7r9p6pFXjR/X5j1ZOd09QJPaD38/oxMmMUAOYAyGMwU5Z2EHrSKBYBYsbro8XdWwn
	7t6sq892Z9CoCO29BfTEUXsGM763nE9U4rMxDd9/C9/CFb1GXSfzF1aPwLtgE4cGyFmNrO
	CbEIYdj1s8C8fLGPpT7eoAD2qxAPi3+TYGtbh+aubowslCOY5KXR2S/5Kiwl/TLyr0JvX7
	tV/iyvWjTwqwgM+ZqOM9wOlF7GzawnK0qIFCxFXZYMGqJTx+yQUFAsg09du0YoHRjkuCse
	6sd1b+hC8BMwhwlZJo5oDQdnM9on+m7mD0pNk2/TMpcsU54knGMETW2E5N3kSw==
Date: Wed, 25 Sep 2024 17:50:10 +0200
From: Aleksa Sarai <cyphar@cyphar.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
Message-ID: <20240925.152228-private.conflict.frozen.trios-TdUGhuI5Sb4v@cyphar.com>
References: <20240924141001.116584-1-tycho@tycho.pizza>
 <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zq3wrif6kf5tb34a"
Content-Disposition: inline
In-Reply-To: <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
X-Rspamd-Queue-Id: 4XDLm51Fzgz9v6Q


--zq3wrif6kf5tb34a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-24, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Tycho Andersen <tycho@tycho.pizza> writes:
>=20
> > From: Tycho Andersen <tandersen@netflix.com>
> >
> > Zbigniew mentioned at Linux Plumber's that systemd is interested in
> > switching to execveat() for service execution, but can't, because the
> > contents of /proc/pid/comm are the file descriptor which was used,
> > instead of the path to the binary. This makes the output of tools like
> > top and ps useless, especially in a world where most fds are opened
> > CLOEXEC so the number is truly meaningless.
> >
> > This patch adds an AT_ flag to fix up /proc/pid/comm to instead be the
> > contents of argv[0], instead of the fdno.
>=20
> The kernel allows prctl(PR_SET_NAME, ...)  without any permission
> checks so adding an AT_ flat to use argv[0] instead of the execed
> filename seems reasonable.
>=20
> Maybe the flag should be called AT_NAME_ARGV0.
>=20
>=20
> That said I am trying to remember why we picked /dev/fd/N, as the
> filename.
>=20
> My memory is that we couldn't think of anything more reasonable to use.
> Looking at commit 51f39a1f0cea ("syscalls: implement execveat() system
> call") unfortunately doesn't clarify anything for me, except that
> /dev/fd/N was a reasonable choice.
>=20
> I am thinking the code could reasonably try:
> 	get_fs_root_rcu(current->fs, &root);
> 	path =3D __d_path(file->f_path, root, buf, buflen);
>=20
> To see if a path to the file from the current root directory can be
> found.  For files that are not reachable from the current root the code
> still need to fallback to /dev/fd/N.
>=20
> Do you think you can investigate that and see if that would generate
> a reasonable task->comm?

The problem mentioned during the discussion after the talk was that
busybox symlinks everything to the same program, so using d_path will
give somewhat confusing results and so separate behaviour is still
needed (though to be fair, the current results are also confusing).

> If for no other reason than because it would generate a usable result
> for #! scripts, without /proc mounted.

For interpreters, wouldn't there be a race condition where the path
might change after doing d_path? I don't know if any interpreter
actually cares about that, but it seems possible that it could lead to
issues. Though for O_CLOEXEC, the fd will always be closed (as Zbigniew
said in his talk) so maybe this isn't a problem in practice.

> It looks like a reasonable case can be made that while /dev/fd/N is
> a good path for interpreters, it is never a good choice for comm,
> so perhaps we could always use argv[0] if the fdpath is of the
> form /dev/fd/N.
>=20
> All of that said I am not a fan of the implementation below as it has
> the side effect of replacing /dev/fd/N with a filename that is not
> usable by #! interpreters.  So I suggest an implementation that affects
> task->comm and not brpm->filename.

I think only affecting task->comm would be ideal.

> Eric
>=20
>=20
> > Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> > Suggested-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> > CC: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> > There is some question about what to name the flag; it seems to me that
> > "everyone wants this" instead of the fdno, but probably "REASONABLE" is=
 not
> > a good choice.
> >
> > Also, requiring the arg to alloc_bprm() is a bit ugly: kernel-based exe=
cs
> > will never use this, so they just have to pass an empty thing. We could
> > introduce a bprm_fixup_comm() to do the munging there, but then the code
> > paths start to diverge, which is maybe not nice. I left it this way bec=
ause
> > this is the smallest patch in terms of size, but I'm happy to change it.
> >
> > Finally, here is a small set of test programs, I'm happy to turn them i=
nto
> > kselftests if we agree on an API
> >
> > #include <stdio.h>
> > #include <unistd.h>
> > #include <stdlib.h>
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> >
> > int main(void)
> > {
> > 	int fd;
> > 	char buf[128];
> >
> > 	fd =3D open("/proc/self/comm", O_RDONLY);
> > 	if (fd < 0) {
> > 		perror("open comm");
> > 		exit(1);
> > 	}
> >
> > 	if (read(fd, buf, 128) < 0) {
> > 		perror("read");
> > 		exit(1);
> > 	}
> >
> > 	printf("comm: %s", buf);
> > 	exit(0);
> > }
> >
> > #define _GNU_SOURCE
> > #include <stdio.h>
> > #include <syscall.h>
> > #include <stdbool.h>
> > #include <unistd.h>
> > #include <fcntl.h>
> > #include <stdlib.h>
> > #include <errno.h>
> > #include <sys/wait.h>
> >
> > #ifndef AT_EMPTY_PATH
> > #define AT_EMPTY_PATH                        0x1000  /* Allow empty rel=
ative */
> > #endif
> >
> > #ifndef AT_EXEC_REASONABLE_COMM
> > #define AT_EXEC_REASONABLE_COMM         0x200
> > #endif
> >
> > int main(int argc, char *argv[])
> > {
> > 	pid_t pid;
> > 	int status;
> > 	bool wants_reasonable_comm =3D argc > 1;
> >
> > 	pid =3D fork();
> > 	if (pid < 0) {
> > 		perror("fork");
> > 		exit(1);
> > 	}
> >
> > 	if (pid =3D=3D 0) {
> > 		int fd;
> > 		long ret, flags;
> >
> > 		fd =3D open("./catprocselfcomm", O_PATH);
> > 		if (fd < 0) {
> > 			perror("open catprocselfname");
> > 			exit(1);
> > 		}
> >
> > 		flags =3D AT_EMPTY_PATH;
> > 		if (wants_reasonable_comm)
> > 			flags |=3D AT_EXEC_REASONABLE_COMM;
> > 		syscall(__NR_execveat, fd, "", (char *[]){"./catprocselfcomm", NULL},=
 NULL, flags);
> > 		fprintf(stderr, "execveat failed %d\n", errno);
> > 		exit(1);
> > 	}
> >
> > 	if (waitpid(pid, &status, 0) !=3D pid) {
> > 		fprintf(stderr, "wrong child\n");
> > 		exit(1);
> > 	}
> >
> > 	if (!WIFEXITED(status)) {
> > 		fprintf(stderr, "exit status %x\n", status);
> > 		exit(1);
> > 	}
> >
> > 	if (WEXITSTATUS(status) !=3D 0) {
> > 		fprintf(stderr, "child failed\n");
> > 		exit(1);
> > 	}
> >
> > 	return 0;
> > }
> > ---
> >  fs/exec.c                  | 22 ++++++++++++++++++----
> >  include/uapi/linux/fcntl.h |  3 ++-
> >  2 files changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/exec.c b/fs/exec.c
> > index dad402d55681..36434feddb7b 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1569,11 +1569,15 @@ static void free_bprm(struct linux_binprm *bprm)
> >  	kfree(bprm);
> >  }
> > =20
> > -static struct linux_binprm *alloc_bprm(int fd, struct filename *filena=
me, int flags)
> > +static struct linux_binprm *alloc_bprm(int fd, struct filename *filena=
me,
> > +				       struct user_arg_ptr argv, int flags)
> >  {
> >  	struct linux_binprm *bprm;
> >  	struct file *file;
> >  	int retval =3D -ENOMEM;
> > +	bool needs_comm_fixup =3D flags & AT_EXEC_REASONABLE_COMM;
> > +
> > +	flags &=3D ~AT_EXEC_REASONABLE_COMM;
> > =20
> >  	file =3D do_open_execat(fd, filename, flags);
> >  	if (IS_ERR(file))
> > @@ -1590,11 +1594,20 @@ static struct linux_binprm *alloc_bprm(int fd, =
struct filename *filename, int fl
> >  	if (fd =3D=3D AT_FDCWD || filename->name[0] =3D=3D '/') {
> >  		bprm->filename =3D filename->name;
> >  	} else {
> > -		if (filename->name[0] =3D=3D '\0')
> > +		if (needs_comm_fixup) {
> > +			const char __user *p =3D get_user_arg_ptr(argv, 0);
> > +
> > +			retval =3D -EFAULT;
> > +			if (!p)
> > +				goto out_free;
> > +
> > +			bprm->fdpath =3D strndup_user(p, MAX_ARG_STRLEN);
> > +		} else if (filename->name[0] =3D=3D '\0')
> >  			bprm->fdpath =3D kasprintf(GFP_KERNEL, "/dev/fd/%d", fd);
> >  		else
> >  			bprm->fdpath =3D kasprintf(GFP_KERNEL, "/dev/fd/%d/%s",
> >  						  fd, filename->name);
> > +		retval =3D -ENOMEM;
> >  		if (!bprm->fdpath)
> >  			goto out_free;
> > =20
> > @@ -1969,7 +1982,7 @@ static int do_execveat_common(int fd, struct file=
name *filename,
> >  	 * further execve() calls fail. */
> >  	current->flags &=3D ~PF_NPROC_EXCEEDED;
> > =20
> > -	bprm =3D alloc_bprm(fd, filename, flags);
> > +	bprm =3D alloc_bprm(fd, filename, argv, flags);
> >  	if (IS_ERR(bprm)) {
> >  		retval =3D PTR_ERR(bprm);
> >  		goto out_ret;
> > @@ -2034,6 +2047,7 @@ int kernel_execve(const char *kernel_filename,
> >  	struct linux_binprm *bprm;
> >  	int fd =3D AT_FDCWD;
> >  	int retval;
> > +	struct user_arg_ptr user_argv =3D {};
> > =20
> >  	/* It is non-sense for kernel threads to call execve */
> >  	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
> > @@ -2043,7 +2057,7 @@ int kernel_execve(const char *kernel_filename,
> >  	if (IS_ERR(filename))
> >  		return PTR_ERR(filename);
> > =20
> > -	bprm =3D alloc_bprm(fd, filename, 0);
> > +	bprm =3D alloc_bprm(fd, filename, user_argv, 0);
> >  	if (IS_ERR(bprm)) {
> >  		retval =3D PTR_ERR(bprm);
> >  		goto out_ret;
> > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > index 87e2dec79fea..7178d1e4a3de 100644
> > --- a/include/uapi/linux/fcntl.h
> > +++ b/include/uapi/linux/fcntl.h
> > @@ -100,7 +100,8 @@
> >  /* Reserved for per-syscall flags	0xff. */
> >  #define AT_SYMLINK_NOFOLLOW		0x100   /* Do not follow symbolic
> >  						   links. */
> > -/* Reserved for per-syscall flags	0x200 */
> > +#define AT_EXEC_REASONABLE_COMM		0x200   /* Use argv[0] for comm in
> > +						   execveat */
> >  #define AT_SYMLINK_FOLLOW		0x400   /* Follow symbolic links. */
> >  #define AT_NO_AUTOMOUNT			0x800	/* Suppress terminal automount
> >  						   traversal. */
> >
> > base-commit: baeb9a7d8b60b021d907127509c44507539c15e5

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--zq3wrif6kf5tb34a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZvQxMQAKCRAol/rSt+lE
b1XgAP41kGZlYqUV0ZABrpnHjekcL3eayZchKbYAY7PP51DYDgD9EmJbAQws0DYN
7baXa27f1/Ih9KmNAYcj2WsktTkQogI=
=vOm3
-----END PGP SIGNATURE-----

--zq3wrif6kf5tb34a--

