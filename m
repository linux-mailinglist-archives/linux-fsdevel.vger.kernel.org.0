Return-Path: <linux-fsdevel+bounces-49165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C43AB8D25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2615E16416F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D783254B1B;
	Thu, 15 May 2025 17:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VYN6rO8p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD71F5849;
	Thu, 15 May 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328482; cv=none; b=Nl8rrtcOXm+Z007s7F0kQ7cjub+clZFhhxjkx+58UMZ8VmbvM1SXY4cis6YU1wG5bEyqeT0MxKu5ErTBysHavMkAeXlYcAiomIlDzpe1RZ6UTcvx0lVFngQr4A317/G8HkHEji6fljcWIBhetjZMoB/2n1hL+jz0TlF0cxz56c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328482; c=relaxed/simple;
	bh=zCUqZaF//cXIHwa0sLcfpFFArG53hcVcDVzV51MpqG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1xtWpnUJuAruAG8vmDO9tXJSvaEXEozoNQjykFOXmoNQ89GG9e3yyQHDuINSxfKNKn+vLGJwKzr8pE/L/qsCNPbNZFRFt7P52Q40NtdKj5F1aDNJM5BcIsLVzgj927LeFmJF6tk/3F788wc595oZwiDrn8cs7neg1aBMGbGl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VYN6rO8p; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747328481; x=1778864481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WiGdij5nNkivbmSbA7JNidQW9frbngAVJFSP81M8sPE=;
  b=VYN6rO8pDWSyPrmC1+j7Kz6+WS2dSnO91FjY6JjJ0sqZ31Cm04jdTKGf
   HDEXJPkclbDhPzZhcq+EKMPdBznFYVqJbEugez34HTzyXm74MfAI8e/PQ
   ninuqx7qhXbEYlltuAxxXimQPFok2KknzL2Excy6NAzvhXNk4yasYRoxJ
   GVx4+jKs71lUcZE0c/kJUYRLcw3KWjhrosp2ohsRfntbmCjp4XPtNRATa
   TwoECN5/6ifaMFnKEbBgVwFVGh0FhiZGsKDqVOoDbno7J9fhnGv7Gkpas
   jPHiUtqO+aXn8nK4u4329N5CuTtBh0LO07kT4mUdH9vg5P2uchEc8dnIm
   w==;
X-IronPort-AV: E=Sophos;i="6.15,291,1739836800"; 
   d="scan'208";a="744986109"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 17:01:15 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:47656]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.53:2525] with esmtp (Farcaster)
 id 8438c557-2276-403f-a02c-c7f77bb6bcbc; Thu, 15 May 2025 17:01:13 +0000 (UTC)
X-Farcaster-Flow-ID: 8438c557-2276-403f-a02c-c7f77bb6bcbc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 17:01:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 17:01:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <brauner@kernel.org>
CC: <alexander@mihalicyn.com>, <bluca@debian.org>, <daan.j.demeyer@gmail.com>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <david@readahead.eu>,
	<edumazet@google.com>, <horms@kernel.org>, <jack@suse.cz>,
	<jannh@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<lennart@poettering.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<me@yhndnzj.com>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <viro@zeniv.linux.org.uk>, <zbyszek@in.waw.pl>
Subject: Re: [PATCH v7 4/9] coredump: add coredump socket
Date: Thu, 15 May 2025 10:00:43 -0700
Message-ID: <20250515170057.50816-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515-work-coredump-socket-v7-4-0a1329496c31@kernel.org>
References: <20250515-work-coredump-socket-v7-4-0a1329496c31@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Brauner <brauner@kernel.org>
Date: Thu, 15 May 2025 00:03:37 +0200
> Coredumping currently supports two modes:
> 
> (1) Dumping directly into a file somewhere on the filesystem.
> (2) Dumping into a pipe connected to a usermode helper process
>     spawned as a child of the system_unbound_wq or kthreadd.
> 
> For simplicity I'm mostly ignoring (1). There's probably still some
> users of (1) out there but processing coredumps in this way can be
> considered adventurous especially in the face of set*id binaries.
> 
> The most common option should be (2) by now. It works by allowing
> userspace to put a string into /proc/sys/kernel/core_pattern like:
> 
>         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
> 
> The "|" at the beginning indicates to the kernel that a pipe must be
> used. The path following the pipe indicator is a path to a binary that
> will be spawned as a usermode helper process. Any additional parameters
> pass information about the task that is generating the coredump to the
> binary that processes the coredump.
> 
> In the example core_pattern shown above systemd-coredump is spawned as a
> usermode helper. There's various conceptual consequences of this
> (non-exhaustive list):
> 
> - systemd-coredump is spawned with file descriptor number 0 (stdin)
>   connected to the read-end of the pipe. All other file descriptors are
>   closed. That specifically includes 1 (stdout) and 2 (stderr). This has
>   already caused bugs because userspace assumed that this cannot happen
>   (Whether or not this is a sane assumption is irrelevant.).
> 
> - systemd-coredump will be spawned as a child of system_unbound_wq. So
>   it is not a child of any userspace process and specifically not a
>   child of PID 1. It cannot be waited upon and is in a weird hybrid
>   upcall which are difficult for userspace to control correctly.
> 
> - systemd-coredump is spawned with full kernel privileges. This
>   necessitates all kinds of weird privilege dropping excercises in
>   userspace to make this safe.
> 
> - A new usermode helper has to be spawned for each crashing process.
> 
> This series adds a new mode:
> 
> (3) Dumping into an AF_UNIX socket.
> 
> Userspace can set /proc/sys/kernel/core_pattern to:
> 
>         @/path/to/coredump.socket
> 
> The "@" at the beginning indicates to the kernel that an AF_UNIX
> coredump socket will be used to process coredumps.
> 
> The coredump socket must be located in the initial mount namespace.
> When a task coredumps it opens a client socket in the initial network
> namespace and connects to the coredump socket.
> 
> - The coredump server uses SO_PEERPIDFD to get a stable handle on the
>   connected crashing task. The retrieved pidfd will provide a stable
>   reference even if the crashing task gets SIGKILLed while generating
>   the coredump.
> 
> - By setting core_pipe_limit non-zero userspace can guarantee that the
>   crashing task cannot be reaped behind it's back and thus process all
>   necessary information in /proc/<pid>. The SO_PEERPIDFD can be used to
>   detect whether /proc/<pid> still refers to the same process.
> 
>   The core_pipe_limit isn't used to rate-limit connections to the
>   socket. This can simply be done via AF_UNIX sockets directly.
> 
> - The pidfd for the crashing task will grow new information how the task
>   coredumps.
> 
> - The coredump server should mark itself as non-dumpable.
> 
> - A container coredump server in a separate network namespace can simply
>   bind to another well-know address and systemd-coredump fowards
>   coredumps to the container.
> 
> - Coredumps could in the future also be handled via per-user/session
>   coredump servers that run only with that users privileges.
> 
>   The coredump server listens on the coredump socket and accepts a
>   new coredump connection. It then retrieves SO_PEERPIDFD for the
>   client, inspects uid/gid and hands the accepted client to the users
>   own coredump handler which runs with the users privileges only
>   (It must of coure pay close attention to not forward crashing suid
>   binaries.).
> 
> The new coredump socket will allow userspace to not have to rely on
> usermode helpers for processing coredumps and provides a safer way to
> handle them instead of relying on super privileged coredumping helpers
> that have and continue to cause significant CVEs.
> 
> This will also be significantly more lightweight since no fork()+exec()
> for the usermodehelper is required for each crashing process. The
> coredump server in userspace can e.g., just keep a worker pool.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/coredump.c       | 133 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  include/linux/net.h |   1 +
>  net/unix/af_unix.c  |  53 ++++++++++++++++-----
>  3 files changed, 166 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index a70929c3585b..e1256ebb89c1 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -44,7 +44,11 @@
>  #include <linux/sysctl.h>
>  #include <linux/elf.h>
>  #include <linux/pidfs.h>
> +#include <linux/net.h>
> +#include <linux/socket.h>
> +#include <net/net_namespace.h>
>  #include <uapi/linux/pidfd.h>
> +#include <uapi/linux/un.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/mmu_context.h>
> @@ -79,6 +83,7 @@ unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
>  enum coredump_type_t {
>  	COREDUMP_FILE = 1,
>  	COREDUMP_PIPE = 2,
> +	COREDUMP_SOCK = 3,
>  };
>  
>  struct core_name {
> @@ -232,13 +237,16 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>  	cn->corename = NULL;
>  	if (*pat_ptr == '|')
>  		cn->core_type = COREDUMP_PIPE;
> +	else if (*pat_ptr == '@')
> +		cn->core_type = COREDUMP_SOCK;
>  	else
>  		cn->core_type = COREDUMP_FILE;
>  	if (expand_corename(cn, core_name_size))
>  		return -ENOMEM;
>  	cn->corename[0] = '\0';
>  
> -	if (cn->core_type == COREDUMP_PIPE) {
> +	switch (cn->core_type) {
> +	case COREDUMP_PIPE: {
>  		int argvs = sizeof(core_pattern) / 2;
>  		(*argv) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
>  		if (!(*argv))
> @@ -247,6 +255,33 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>  		++pat_ptr;
>  		if (!(*pat_ptr))
>  			return -ENOMEM;
> +		break;
> +	}
> +	case COREDUMP_SOCK: {
> +		/* skip the @ */
> +		pat_ptr++;
> +		err = cn_printf(cn, "%s", pat_ptr);
> +		if (err)
> +			return err;
> +
> +		/* Require absolute paths. */
> +		if (cn->corename[0] != '/')
> +			return -EINVAL;
> +
> +		/*
> +		 * Currently no need to parse any other options.
> +		 * Relevant information can be retrieved from the peer
> +		 * pidfd retrievable via SO_PEERPIDFD by the receiver or
> +		 * via /proc/<pid>, using the SO_PEERPIDFD to guard
> +		 * against pid recycling when opening /proc/<pid>.
> +		 */
> +		return 0;
> +	}
> +	case COREDUMP_FILE:
> +		break;
> +	default:
> +		WARN_ON_ONCE(true);
> +		return -EINVAL;
>  	}
>  
>  	/* Repeat as long as we have more pattern to process and more output
> @@ -393,11 +428,20 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>  	 * If core_pattern does not include a %p (as is the default)
>  	 * and core_uses_pid is set, then .%pid will be appended to
>  	 * the filename. Do not do this for piped commands. */
> -	if (!(cn->core_type == COREDUMP_PIPE) && !pid_in_pattern && core_uses_pid) {
> -		err = cn_printf(cn, ".%d", task_tgid_vnr(current));
> -		if (err)
> -			return err;
> +	if (!pid_in_pattern && core_uses_pid) {
> +		switch (cn->core_type) {
> +		case COREDUMP_FILE:
> +			return cn_printf(cn, ".%d", task_tgid_vnr(current));
> +		case COREDUMP_PIPE:
> +			break;
> +		case COREDUMP_SOCK:
> +			break;
> +		default:
> +			WARN_ON_ONCE(true);
> +			return -EINVAL;
> +		}
>  	}
> +
>  	return 0;
>  }
>  
> @@ -801,6 +845,55 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		}
>  		break;
>  	}
> +	case COREDUMP_SOCK: {
> +#ifdef CONFIG_UNIX
> +		struct file *file __free(fput) = NULL;
> +		struct sockaddr_un addr = {
> +			.sun_family = AF_UNIX,
> +		};
> +		ssize_t addr_len;
> +		struct socket *socket;
> +
> +		retval = strscpy(addr.sun_path, cn.corename, sizeof(addr.sun_path));
> +		if (retval < 0)
> +			goto close_fail;
> +		addr_len = offsetof(struct sockaddr_un, sun_path) + retval + 1;
> +
> +		/*
> +		 * It is possible that the userspace process which is
> +		 * supposed to handle the coredump and is listening on
> +		 * the AF_UNIX socket coredumps. Userspace should just
> +		 * mark itself non dumpable.
> +		 */
> +
> +		retval = sock_create_kern(&init_net, AF_UNIX, SOCK_STREAM, 0, &socket);
> +		if (retval < 0)
> +			goto close_fail;
> +
> +		file = sock_alloc_file(socket, 0, NULL);
> +		if (IS_ERR(file)) {
> +			sock_release(socket);
> +			goto close_fail;
> +		}
> +
> +		retval = kernel_connect(socket, (struct sockaddr *)(&addr),
> +					addr_len, O_NONBLOCK | SOCK_COREDUMP);
> +		if (retval) {
> +			if (retval == -EAGAIN)
> +				coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
> +			else
> +				coredump_report_failure("Coredump socket connection %s failed %d", addr.sun_path, retval);
> +			goto close_fail;
> +		}
> +
> +		cprm.limit = RLIM_INFINITY;
> +		cprm.file = no_free_ptr(file);
> +#else
> +		coredump_report_failure("Core dump socket support %s disabled", cn.corename);
> +		goto close_fail;
> +#endif
> +		break;
> +	}
>  	default:
>  		WARN_ON_ONCE(true);
>  		goto close_fail;
> @@ -838,8 +931,32 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		file_end_write(cprm.file);
>  		free_vma_snapshot(&cprm);
>  	}
> -	if ((cn.core_type == COREDUMP_PIPE) && core_pipe_limit)
> -		wait_for_dump_helpers(cprm.file);
> +
> +	/*
> +	 * When core_pipe_limit is set we wait for the coredump server
> +	 * or usermodehelper to finish before exiting so it can e.g.,
> +	 * inspect /proc/<pid>.
> +	 */
> +	if (core_pipe_limit) {
> +		switch (cn.core_type) {
> +		case COREDUMP_PIPE:
> +			wait_for_dump_helpers(cprm.file);
> +			break;
> +		case COREDUMP_SOCK: {
> +			/*
> +			 * We use a simple read to wait for the coredump
> +			 * processing to finish. Either the socket is
> +			 * closed or we get sent unexpected data. In
> +			 * both cases, we're done.
> +			 */
> +			__kernel_read(cprm.file, &(char){ 0 }, 1, NULL);
> +			break;
> +		}
> +		default:
> +			break;
> +		}
> +	}
> +
>  close_fail:
>  	if (cprm.file)
>  		filp_close(cprm.file, NULL);
> @@ -1069,7 +1186,7 @@ EXPORT_SYMBOL(dump_align);
>  void validate_coredump_safety(void)
>  {
>  	if (suid_dumpable == SUID_DUMP_ROOT &&
> -	    core_pattern[0] != '/' && core_pattern[0] != '|') {
> +	    core_pattern[0] != '/' && core_pattern[0] != '|' && core_pattern[0] != '@') {
>  
>  		coredump_report_failure("Unsafe core_pattern used with fs.suid_dumpable=2: "
>  			"pipe handler or fully qualified core dump path required. "
> diff --git a/include/linux/net.h b/include/linux/net.h
> index 0ff950eecc6b..139c85d0f2ea 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -81,6 +81,7 @@ enum sock_type {
>  #ifndef SOCK_NONBLOCK
>  #define SOCK_NONBLOCK	O_NONBLOCK
>  #endif
> +#define SOCK_COREDUMP	O_NOCTTY
>  
>  #endif /* ARCH_HAS_SOCKET_TYPES */
>  
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 472f8aa9ea15..a9d1c9ba2961 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -85,10 +85,13 @@
>  #include <linux/file.h>
>  #include <linux/filter.h>
>  #include <linux/fs.h>
> +#include <linux/fs_struct.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/mount.h>
>  #include <linux/namei.h>
> +#include <linux/net.h>
> +#include <linux/pidfs.h>
>  #include <linux/poll.h>
>  #include <linux/proc_fs.h>
>  #include <linux/sched/signal.h>
> @@ -100,7 +103,6 @@
>  #include <linux/splice.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> -#include <linux/pidfs.h>
>  #include <net/af_unix.h>
>  #include <net/net_namespace.h>
>  #include <net/scm.h>
> @@ -1146,7 +1148,7 @@ static int unix_release(struct socket *sock)
>  }
>  
>  static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
> -				  int type)
> +				  int type, unsigned int flags)
  				      	    ^^^
nit: int flags


>  {
>  	struct inode *inode;
>  	struct path path;
> @@ -1154,13 +1156,38 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  	int err;
>  
>  	unix_mkname_bsd(sunaddr, addr_len);
> -	err = kern_path(sunaddr->sun_path, LOOKUP_FOLLOW, &path);
> -	if (err)
> -		goto fail;
>  
> -	err = path_permission(&path, MAY_WRITE);
> -	if (err)
> -		goto path_put;
> +	if (flags & SOCK_COREDUMP) {
> +		struct path root;
> +		struct cred *kcred;
> +		const struct cred *cred;

nit: please keep these in the reverse xmas tree order.
https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs


> +
> +		err = -ENOMEM;

While at it, please move this in the "if (!kcred)" as it's only
used for this.

Otherwise looks good to me.  I think you can just fix up nits
before pushing to the vfs tree unless there is any other feedback.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> +		kcred = prepare_kernel_cred(&init_task);
> +		if (!kcred)
> +			goto fail;
> +
> +		task_lock(&init_task);
> +		get_fs_root(init_task.fs, &root);
> +		task_unlock(&init_task);
> +
> +		cred = override_creds(kcred);
> +		err = vfs_path_lookup(root.dentry, root.mnt, sunaddr->sun_path,
> +				      LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
> +				      LOOKUP_NO_MAGICLINKS, &path);
> +		put_cred(revert_creds(cred));
> +		path_put(&root);
> +		if (err)
> +			goto fail;
> +	} else {
> +		err = kern_path(sunaddr->sun_path, LOOKUP_FOLLOW, &path);
> +		if (err)
> +			goto fail;
> +
> +		err = path_permission(&path, MAY_WRITE);
> +		if (err)
> +			goto path_put;
> +	}
>  
>  	err = -ECONNREFUSED;
>  	inode = d_backing_inode(path.dentry);
> @@ -1210,12 +1237,12 @@ static struct sock *unix_find_abstract(struct net *net,
>  
>  static struct sock *unix_find_other(struct net *net,
>  				    struct sockaddr_un *sunaddr,
> -				    int addr_len, int type)
> +				    int addr_len, int type, int flags)
>  {
>  	struct sock *sk;
>  
>  	if (sunaddr->sun_path[0])
> -		sk = unix_find_bsd(sunaddr, addr_len, type);
> +		sk = unix_find_bsd(sunaddr, addr_len, type, flags);
>  	else
>  		sk = unix_find_abstract(net, sunaddr, addr_len, type);
>  
> @@ -1473,7 +1500,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
>  		}
>  
>  restart:
> -		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type);
> +		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type, 0);
>  		if (IS_ERR(other)) {
>  			err = PTR_ERR(other);
>  			goto out;
> @@ -1620,7 +1647,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  
>  restart:
>  	/*  Find listening sock. */
> -	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type);
> +	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type, flags);
>  	if (IS_ERR(other)) {
>  		err = PTR_ERR(other);
>  		goto out_free_skb;
> @@ -2089,7 +2116,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
>  	if (msg->msg_namelen) {
>  lookup:
>  		other = unix_find_other(sock_net(sk), msg->msg_name,
> -					msg->msg_namelen, sk->sk_type);
> +					msg->msg_namelen, sk->sk_type, 0);
>  		if (IS_ERR(other)) {
>  			err = PTR_ERR(other);
>  			goto out_free;
> 
> -- 
> 2.47.2
> 

