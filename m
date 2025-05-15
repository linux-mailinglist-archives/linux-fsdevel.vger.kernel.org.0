Return-Path: <linux-fsdevel+bounces-49138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F8AB882D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 15:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E296817A694
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6121C5D57;
	Thu, 15 May 2025 13:36:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ADF64A98;
	Thu, 15 May 2025 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747316176; cv=none; b=j9BkSsarfdKCWqJDV26HRLwH2NycMQHUdDRKlUU3amACkb7lIjWJxGObPxNsbbpU184eXVbPGlNDbYwtZ7b58t5DigVJEigFmF8pDswtWiOTQ7ckz+HdAdDC5Kd0vOsqQfPuQeHHlD5UBm1iGakrqq7f1khX7pa3Sx4ywe6QLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747316176; c=relaxed/simple;
	bh=xaDmKt3RfeiiCoNmS8bhgDEBGsYhQ0B0xi9U4HGaC6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hnp8L7KOSbeVit/ix3ITEG1VCTJ3xUxMtIPcwMYvm9vFQMRTvgzb7SC1E4Lm5mClnOJJ1FwvAetWOC9o/Tcq5Q3TLoy8TBxbcInapDNhKSio/ziv+P9vi35C91Y7tnMleJlyMKEClziF5IiARAw+RVI59DpIIpTAyJzSTIndgf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 431CB8BF; Thu, 15 May 2025 08:36:06 -0500 (CDT)
Date: Thu, 15 May 2025 08:36:06 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	David Rheinsberg <david@readahead.eu>,
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>,
	Lennart Poettering <lennart@poettering.net>,
	Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v7 1/9] coredump: massage format_corname()
Message-ID: <20250515133606.GA740869@mail.hallyn.com>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
 <20250515-work-coredump-socket-v7-1-0a1329496c31@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515-work-coredump-socket-v7-1-0a1329496c31@kernel.org>

On Thu, May 15, 2025 at 12:03:34AM +0200, Christian Brauner wrote:
> We're going to extend the coredump code in follow-up patches.
> Clean it up so we can do this more easily.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Not my wheelhouse, but this is a nice cleanup.

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  fs/coredump.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index d740a0411266..368751d98781 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -76,9 +76,15 @@ static char core_pattern[CORENAME_MAX_SIZE] = "core";
>  static int core_name_size = CORENAME_MAX_SIZE;
>  unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
>  
> +enum coredump_type_t {
> +	COREDUMP_FILE = 1,
> +	COREDUMP_PIPE = 2,
> +};
> +
>  struct core_name {
>  	char *corename;
>  	int used, size;
> +	enum coredump_type_t core_type;
>  };
>  
>  static int expand_corename(struct core_name *cn, int size)
> @@ -218,18 +224,21 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>  {
>  	const struct cred *cred = current_cred();
>  	const char *pat_ptr = core_pattern;
> -	int ispipe = (*pat_ptr == '|');
>  	bool was_space = false;
>  	int pid_in_pattern = 0;
>  	int err = 0;
>  
>  	cn->used = 0;
>  	cn->corename = NULL;
> +	if (*pat_ptr == '|')
> +		cn->core_type = COREDUMP_PIPE;
> +	else
> +		cn->core_type = COREDUMP_FILE;
>  	if (expand_corename(cn, core_name_size))
>  		return -ENOMEM;
>  	cn->corename[0] = '\0';
>  
> -	if (ispipe) {
> +	if (cn->core_type == COREDUMP_PIPE) {
>  		int argvs = sizeof(core_pattern) / 2;
>  		(*argv) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
>  		if (!(*argv))
> @@ -247,7 +256,7 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>  		 * Split on spaces before doing template expansion so that
>  		 * %e and %E don't get split if they have spaces in them
>  		 */
> -		if (ispipe) {
> +		if (cn->core_type == COREDUMP_PIPE) {
>  			if (isspace(*pat_ptr)) {
>  				if (cn->used != 0)
>  					was_space = true;
> @@ -353,7 +362,7 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>  				 * Installing a pidfd only makes sense if
>  				 * we actually spawn a usermode helper.
>  				 */
> -				if (!ispipe)
> +				if (cn->core_type != COREDUMP_PIPE)
>  					break;
>  
>  				/*
> @@ -384,12 +393,12 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>  	 * If core_pattern does not include a %p (as is the default)
>  	 * and core_uses_pid is set, then .%pid will be appended to
>  	 * the filename. Do not do this for piped commands. */
> -	if (!ispipe && !pid_in_pattern && core_uses_pid) {
> +	if (!(cn->core_type == COREDUMP_PIPE) && !pid_in_pattern && core_uses_pid) {
>  		err = cn_printf(cn, ".%d", task_tgid_vnr(current));
>  		if (err)
>  			return err;
>  	}
> -	return ispipe;
> +	return 0;
>  }
>  
>  static int zap_process(struct signal_struct *signal, int exit_code)
> @@ -583,7 +592,6 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  	const struct cred *old_cred;
>  	struct cred *cred;
>  	int retval = 0;
> -	int ispipe;
>  	size_t *argv = NULL;
>  	int argc = 0;
>  	/* require nonrelative corefile path and be extra careful */
> @@ -632,19 +640,18 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  
>  	old_cred = override_creds(cred);
>  
> -	ispipe = format_corename(&cn, &cprm, &argv, &argc);
> +	retval = format_corename(&cn, &cprm, &argv, &argc);
> +	if (retval < 0) {
> +		coredump_report_failure("format_corename failed, aborting core");
> +		goto fail_unlock;
> +	}
>  
> -	if (ispipe) {
> +	if (cn.core_type == COREDUMP_PIPE) {
>  		int argi;
>  		int dump_count;
>  		char **helper_argv;
>  		struct subprocess_info *sub_info;
>  
> -		if (ispipe < 0) {
> -			coredump_report_failure("format_corename failed, aborting core");
> -			goto fail_unlock;
> -		}
> -
>  		if (cprm.limit == 1) {
>  			/* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
>  			 *
> @@ -695,7 +702,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  			coredump_report_failure("|%s pipe failed", cn.corename);
>  			goto close_fail;
>  		}
> -	} else {
> +	} else if (cn.core_type == COREDUMP_FILE) {
>  		struct mnt_idmap *idmap;
>  		struct inode *inode;
>  		int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
> @@ -823,13 +830,13 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		file_end_write(cprm.file);
>  		free_vma_snapshot(&cprm);
>  	}
> -	if (ispipe && core_pipe_limit)
> +	if ((cn.core_type == COREDUMP_PIPE) && core_pipe_limit)
>  		wait_for_dump_helpers(cprm.file);
>  close_fail:
>  	if (cprm.file)
>  		filp_close(cprm.file, NULL);
>  fail_dropcount:
> -	if (ispipe)
> +	if (cn.core_type == COREDUMP_PIPE)
>  		atomic_dec(&core_dump_count);
>  fail_unlock:
>  	kfree(argv);
> 
> -- 
> 2.47.2
> 

