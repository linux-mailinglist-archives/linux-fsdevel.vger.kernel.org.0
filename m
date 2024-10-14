Return-Path: <linux-fsdevel+bounces-31921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B314D99D8CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 23:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70BC1C212EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 21:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC31D0940;
	Mon, 14 Oct 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnIDC6Rl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7201D0B9B;
	Mon, 14 Oct 2024 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940415; cv=none; b=HwdIrQ91xU4QExaOQ1KLcwU//CLzV5SFkGKeFn4w3ddjSGdIggsmJZD6caF8bzqSVnbXkmn3rKy74Yaz/XKDe5MoAIvOOqM3K5bdpD+v+K7BcpRMw/V9jKNfH6BjG8s/QIxD8PAGWKsXfSIlPu17BNeRy9NJ9G/ovC7mnAwRh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940415; c=relaxed/simple;
	bh=hZ4sZBjojl8AVeRz94L+xmF0lc4B91BT4wKsw0/97uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSmBk4u67rbzSquSvoq+rajbdETdzX67xUD/bC8LT0RAPyqCph4ufo0NTNXoMW2AI0n4hyYYKtS34KjHNKstsiqjMO4MnnEYsh7qa8STTLpUVRCVR4O0IDztt2sH/7CwaTkz6aH4cPqQrxTESEICB/2KykY40Itgj5axa4fYzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnIDC6Rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4241C4CEC3;
	Mon, 14 Oct 2024 21:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728940414;
	bh=hZ4sZBjojl8AVeRz94L+xmF0lc4B91BT4wKsw0/97uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cnIDC6Rlf5QyxMldNmF2WIuElwqTChk8cYTloV+tjUtl5nDqPp19DzMqQvX/TWvJc
	 B3QDF8U9SpCJBVSu41XFqJxVPIbF60GgJuE+YL+HaLmLH4BJhNDuFTW0WJ0WXZpqLm
	 JzDRd1qJ8W8lQHwWNFuNL/j41jajAJ0LlVKqJytcijLVnejYjMIs1hgH2KRRXNGL0L
	 C9xwhpi2cpBP5gH4ffpM3EDu2KWy6iOpO5dfmcEH1rfl7wN4hKlTOchacQUoL4BJZ7
	 7StJVQ6ha8eECsf6mh0PKJr590C1cOpsJm8mw2jC9DS7fk5QqP89Vu55nbI+0/rOca
	 iNlqkbt2pgjvw==
Date: Mon, 14 Oct 2024 14:13:32 -0700
From: Kees Cook <kees@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
Message-ID: <202410141403.D8B6671@keescook>
References: <20240924141001.116584-1-tycho@tycho.pizza>
 <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
 <Zv1aA4I6r4py-8yW@kawka3.in.waw.pl>
 <ZwaWG/ult2P7HR5A@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwaWG/ult2P7HR5A@tycho.pizza>

On Wed, Oct 09, 2024 at 08:41:31AM -0600, Tycho Andersen wrote:
> On Wed, Oct 02, 2024 at 02:34:43PM +0000, Zbigniew Jędrzejewski-Szmek wrote:
> > On Tue, Sep 24, 2024 at 12:39:35PM -0500, Eric W. Biederman wrote:
> > > Tycho Andersen <tycho@tycho.pizza> writes:
> > > 
> > > > From: Tycho Andersen <tandersen@netflix.com>
> > > >
> > > > Zbigniew mentioned at Linux Plumber's that systemd is interested in
> > > > switching to execveat() for service execution, but can't, because the
> > > > contents of /proc/pid/comm are the file descriptor which was used,
> > > > instead of the path to the binary. This makes the output of tools like
> > > > top and ps useless, especially in a world where most fds are opened
> > > > CLOEXEC so the number is truly meaningless.
> > > >
> > > > This patch adds an AT_ flag to fix up /proc/pid/comm to instead be the
> > > > contents of argv[0], instead of the fdno.
> > 
> > I tried this version (with a local modification to drop the flag and
> > enable the new codepath if get_user_arg_ptr(argv, 0) returns nonnull
> > as suggested later in the thread), and it seems to work as expected.
> > In particular, 'pgrep' finds for the original name in case of
> > symlinks.
> 
> Here is a version that only affects /proc/pid/comm, without a flag. We
> still have to do the dance of keeping the user argv0 before actually
> doing __set_task_comm(), since we want to surface the resulting fault
> if people pass a bad argv0. Thoughts?
> 
> Tycho
> 
> 
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index dad402d55681..61de8a71f316 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1416,7 +1416,16 @@ int begin_new_exec(struct linux_binprm * bprm)
>  		set_dumpable(current->mm, SUID_DUMP_USER);
>  
>  	perf_event_exec();
> -	__set_task_comm(me, kbasename(bprm->filename), true);
> +
> +	/*
> +	 * If fdpath was set, execveat() made up a path that will
> +	 * probably not be useful to admins running ps or similar.
> +	 * Let's fix it up to be something reasonable.
> +	 */
> +	if (bprm->argv0)
> +		__set_task_comm(me, kbasename(bprm->argv0), true);
> +	else
> +		__set_task_comm(me, kbasename(bprm->filename), true);

This isn't checking fdpath?

>  
>  	/* An exec changes our domain. We are no longer part of the thread
>  	   group */
> @@ -1566,9 +1575,30 @@ static void free_bprm(struct linux_binprm *bprm)
>  	if (bprm->interp != bprm->filename)
>  		kfree(bprm->interp);
>  	kfree(bprm->fdpath);
> +	kfree(bprm->argv0);
>  	kfree(bprm);
>  }
>  
> +static int bprm_add_fixup_comm(struct linux_binprm *bprm, struct user_arg_ptr argv)
> +{
> +	const char __user *p = get_user_arg_ptr(argv, 0);
> +
> +	/*
> +	 * In keeping with the logic in do_execveat_common(), we say p == NULL
> +	 * => "" for comm.
> +	 */
> +	if (!p) {
> +		bprm->argv0 = kstrdup("", GFP_KERNEL);
> +		return 0;
> +	}
> +
> +	bprm->argv0 = strndup_user(p, MAX_ARG_STRLEN);
> +	if (bprm->argv0)
> +		return 0;
> +
> +	return -EFAULT;
> +}

I'd rather this logic got done in copy_strings() and to avoid duplicating
a copy for all exec users. I think it should be possible to just do
this, to find the __user char *:

diff --git a/fs/exec.c b/fs/exec.c
index 77364806b48d..e12fd706f577 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -642,6 +642,8 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 				goto out;
 			}
 		}
+		if (argc == 0)
+			bprm->argv0 = str;
 	}
 	ret = 0;
 out:


Once we get to begin_new_exec(), only if we need to do the work (fdpath
set), then we can do the strndup_user() instead of making every exec
hold a copy regardless of whether it will be needed.

-Kees

> +
>  static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int flags)
>  {
>  	struct linux_binprm *bprm;
> @@ -1975,6 +2005,10 @@ static int do_execveat_common(int fd, struct filename *filename,
>  		goto out_ret;
>  	}
>  
> +	retval = bprm_add_fixup_comm(bprm, argv);
> +	if (retval != 0)
> +		goto out_free;
> +
>  	retval = count(argv, MAX_ARG_STRINGS);
>  	if (retval == 0)
>  		pr_warn_once("process '%s' launched '%s' with NULL argv: empty string added\n",
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index e6c00e860951..0cd1f2d0e8c6 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -55,6 +55,7 @@ struct linux_binprm {
>  				   of the time same as filename, but could be
>  				   different for binfmt_{misc,script} */
>  	const char *fdpath;	/* generated filename for execveat */
> +	const char *argv0;	/* argv0 from execveat */
>  	unsigned interp_flags;
>  	int execfd;		/* File descriptor of the executable */
>  	unsigned long loader, exec;

-- 
Kees Cook

