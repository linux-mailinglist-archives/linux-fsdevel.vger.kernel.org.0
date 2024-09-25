Return-Path: <linux-fsdevel+bounces-30044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D350985585
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 10:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9012A1C22E5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 08:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF91591F0;
	Wed, 25 Sep 2024 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceByRlbM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7345C1849;
	Wed, 25 Sep 2024 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253070; cv=none; b=pl2kI/+1mzC2vQNK55c56hCjZsGko8auLzFI33WECcu1VwFcTZf6DdG3P6eE9rOWiV6JpjyHb5jr+azv5oXr6SAv8uNk7ZWMuxlSjaMYG3uVUyDhBALea21AXtP/e5zok644Zdti3guIteyDXBJhvZOEXkxhnneZOW7vIQNwjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253070; c=relaxed/simple;
	bh=HZAomvSklThtRAOmnplclgrQHIBXha+XYRV1StbeV9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbWadRZz0XqkMvVJbaiqNtNdbMRrgpg5TILC3elrRofHIjV5vTkg6rhHBdactpXyWklnzXtTYK1N+oEeQvRt/Yp1le0J81lgINtUCQlK+KJF2986HfccukHUFQtFA8AgdugEINTUNo5aReAX95yhJF8/tO8RrJVz8+Uwy7FDU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceByRlbM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF64C4CEC3;
	Wed, 25 Sep 2024 08:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727253069;
	bh=HZAomvSklThtRAOmnplclgrQHIBXha+XYRV1StbeV9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ceByRlbMy2nybxNP5/Fxc9GTkzweijxAkfovrht8aYhHVaV7S8ghpODKEjZ5Rxv1/
	 Pt84bTCynTvqXYp9BKxEHYC2wybbCh7k6KXrmSz3zMQH+3oFRA47IMrQbl+io/t6DX
	 OeLG1SnEnlXDutSILoqWbPshrdxXPbAsAcLaBpj1NbqH8NXaqr6pD1egqN0RPQLg63
	 fbb38Ttiu47PzAs12sO3rd6tlTKxdhGPR/8JC4FygBCMpzeizx7LzTubOVlxaPf9PI
	 D4D63FfvWvpA/9UcBgD7XAIz0VkxotecGMq7AfykQpwxTbbrkIZ1PDCCO0YFvkNciK
	 fdj5JQnn7blYQ==
Date: Wed, 25 Sep 2024 10:31:04 +0200
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
Message-ID: <20240925-herziehen-unerbittlich-23c5845fed06@brauner>
References: <20240924141001.116584-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924141001.116584-1-tycho@tycho.pizza>

On Tue, Sep 24, 2024 at 08:10:01AM GMT, Tycho Andersen wrote:
> From: Tycho Andersen <tandersen@netflix.com>
> 
> Zbigniew mentioned at Linux Plumber's that systemd is interested in
> switching to execveat() for service execution, but can't, because the
> contents of /proc/pid/comm are the file descriptor which was used,
> instead of the path to the binary. This makes the output of tools like
> top and ps useless, especially in a world where most fds are opened
> CLOEXEC so the number is truly meaningless.
> 
> This patch adds an AT_ flag to fix up /proc/pid/comm to instead be the
> contents of argv[0], instead of the fdno.
> 
> Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> Suggested-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
> CC: Aleksa Sarai <cyphar@cyphar.com>
> ---
> There is some question about what to name the flag; it seems to me that
> "everyone wants this" instead of the fdno, but probably "REASONABLE" is not
> a good choice.
> 
> Also, requiring the arg to alloc_bprm() is a bit ugly: kernel-based execs
> will never use this, so they just have to pass an empty thing. We could
> introduce a bprm_fixup_comm() to do the munging there, but then the code
> paths start to diverge, which is maybe not nice. I left it this way because
> this is the smallest patch in terms of size, but I'm happy to change it.
> 
> Finally, here is a small set of test programs, I'm happy to turn them into
> kselftests if we agree on an API
> 
> #include <stdio.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> 
> int main(void)
> {
> 	int fd;
> 	char buf[128];
> 
> 	fd = open("/proc/self/comm", O_RDONLY);
> 	if (fd < 0) {
> 		perror("open comm");
> 		exit(1);
> 	}
> 
> 	if (read(fd, buf, 128) < 0) {
> 		perror("read");
> 		exit(1);
> 	}
> 
> 	printf("comm: %s", buf);
> 	exit(0);
> }
> 
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <syscall.h>
> #include <stdbool.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <stdlib.h>
> #include <errno.h>
> #include <sys/wait.h>
> 
> #ifndef AT_EMPTY_PATH
> #define AT_EMPTY_PATH                        0x1000  /* Allow empty relative */
> #endif
> 
> #ifndef AT_EXEC_REASONABLE_COMM
> #define AT_EXEC_REASONABLE_COMM         0x200
> #endif
> 
> int main(int argc, char *argv[])
> {
> 	pid_t pid;
> 	int status;
> 	bool wants_reasonable_comm = argc > 1;
> 
> 	pid = fork();
> 	if (pid < 0) {
> 		perror("fork");
> 		exit(1);
> 	}
> 
> 	if (pid == 0) {
> 		int fd;
> 		long ret, flags;
> 
> 		fd = open("./catprocselfcomm", O_PATH);
> 		if (fd < 0) {
> 			perror("open catprocselfname");
> 			exit(1);
> 		}
> 
> 		flags = AT_EMPTY_PATH;
> 		if (wants_reasonable_comm)
> 			flags |= AT_EXEC_REASONABLE_COMM;
> 		syscall(__NR_execveat, fd, "", (char *[]){"./catprocselfcomm", NULL}, NULL, flags);

Yes, that one is the actually palatable solution that I mentioned during
the session and not the questionable version where the path argument is
overloaded by the flag.

Please add a:

Link: https://github.com/uapi-group/kernel-features#set-comm-field-before-exec

to the commit where this originated from.

> 		fprintf(stderr, "execveat failed %d\n", errno);
> 		exit(1);
> 	}
> 
> 	if (waitpid(pid, &status, 0) != pid) {
> 		fprintf(stderr, "wrong child\n");
> 		exit(1);
> 	}
> 
> 	if (!WIFEXITED(status)) {
> 		fprintf(stderr, "exit status %x\n", status);
> 		exit(1);
> 	}
> 
> 	if (WEXITSTATUS(status) != 0) {
> 		fprintf(stderr, "child failed\n");
> 		exit(1);
> 	}
> 
> 	return 0;
> }
> ---
>  fs/exec.c                  | 22 ++++++++++++++++++----
>  include/uapi/linux/fcntl.h |  3 ++-
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index dad402d55681..36434feddb7b 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1569,11 +1569,15 @@ static void free_bprm(struct linux_binprm *bprm)
>  	kfree(bprm);
>  }
>  
> -static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int flags)
> +static struct linux_binprm *alloc_bprm(int fd, struct filename *filename,
> +				       struct user_arg_ptr argv, int flags)
>  {
>  	struct linux_binprm *bprm;
>  	struct file *file;
>  	int retval = -ENOMEM;
> +	bool needs_comm_fixup = flags & AT_EXEC_REASONABLE_COMM;
> +
> +	flags &= ~AT_EXEC_REASONABLE_COMM;
>  
>  	file = do_open_execat(fd, filename, flags);
>  	if (IS_ERR(file))
> @@ -1590,11 +1594,20 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
>  	if (fd == AT_FDCWD || filename->name[0] == '/') {
>  		bprm->filename = filename->name;
>  	} else {
> -		if (filename->name[0] == '\0')
> +		if (needs_comm_fixup) {
> +			const char __user *p = get_user_arg_ptr(argv, 0);
> +
> +			retval = -EFAULT;
> +			if (!p)
> +				goto out_free;
> +
> +			bprm->fdpath = strndup_user(p, MAX_ARG_STRLEN);
> +		} else if (filename->name[0] == '\0')
>  			bprm->fdpath = kasprintf(GFP_KERNEL, "/dev/fd/%d", fd);
>  		else
>  			bprm->fdpath = kasprintf(GFP_KERNEL, "/dev/fd/%d/%s",
>  						  fd, filename->name);
> +		retval = -ENOMEM;
>  		if (!bprm->fdpath)
>  			goto out_free;
>  
> @@ -1969,7 +1982,7 @@ static int do_execveat_common(int fd, struct filename *filename,
>  	 * further execve() calls fail. */
>  	current->flags &= ~PF_NPROC_EXCEEDED;
>  
> -	bprm = alloc_bprm(fd, filename, flags);
> +	bprm = alloc_bprm(fd, filename, argv, flags);
>  	if (IS_ERR(bprm)) {
>  		retval = PTR_ERR(bprm);
>  		goto out_ret;
> @@ -2034,6 +2047,7 @@ int kernel_execve(const char *kernel_filename,
>  	struct linux_binprm *bprm;
>  	int fd = AT_FDCWD;
>  	int retval;
> +	struct user_arg_ptr user_argv = {};
>  
>  	/* It is non-sense for kernel threads to call execve */
>  	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
> @@ -2043,7 +2057,7 @@ int kernel_execve(const char *kernel_filename,
>  	if (IS_ERR(filename))
>  		return PTR_ERR(filename);
>  
> -	bprm = alloc_bprm(fd, filename, 0);
> +	bprm = alloc_bprm(fd, filename, user_argv, 0);
>  	if (IS_ERR(bprm)) {
>  		retval = PTR_ERR(bprm);
>  		goto out_ret;
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 87e2dec79fea..7178d1e4a3de 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -100,7 +100,8 @@
>  /* Reserved for per-syscall flags	0xff. */
>  #define AT_SYMLINK_NOFOLLOW		0x100   /* Do not follow symbolic
>  						   links. */
> -/* Reserved for per-syscall flags	0x200 */
> +#define AT_EXEC_REASONABLE_COMM		0x200   /* Use argv[0] for comm in
> +						   execveat */
>  #define AT_SYMLINK_FOLLOW		0x400   /* Follow symbolic links. */
>  #define AT_NO_AUTOMOUNT			0x800	/* Suppress terminal automount
>  						   traversal. */
> 
> base-commit: baeb9a7d8b60b021d907127509c44507539c15e5
> -- 
> 2.34.1
> 

