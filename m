Return-Path: <linux-fsdevel+bounces-36183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D259DF053
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 13:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74C71633D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 12:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796BD198E77;
	Sat, 30 Nov 2024 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoBByyPm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE925156F30;
	Sat, 30 Nov 2024 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732969798; cv=none; b=OWab6rFBhak9OX5BSAt3uk9uJLH2GxmMnftpySaJjQU4+oyvul+Xg1VjwTih4J846PYtKA+lXVZir426HrbR6Bl8cGfYp6vMR8BRlw3wX/1TqXj84fT7AMZ9qzXnfB8YQG9593+VEI9XTDIhtQjsmbUF2AWC479ltkuB8ZFX4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732969798; c=relaxed/simple;
	bh=0B7+NJKg6PDFktmYDGKBJZxB5QZ8x8bluiluB7gfHbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4KJ5aD3uLubNDjpFd3oxVVKbuVUgOID4IVbut67kmJ1F4wTjm+DHEys/eVRNKShr6bXv3l0O6fFodoFXA9di2QJIh0EaArUDFKRqMNzIZkenA2KjtAUPXLYnePnmS3nBIS3jNnovobuNnzp33Jxpx2KC5UfToZczUHnaydZg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoBByyPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBAEC4CECC;
	Sat, 30 Nov 2024 12:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732969798;
	bh=0B7+NJKg6PDFktmYDGKBJZxB5QZ8x8bluiluB7gfHbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uoBByyPmW9thOAgNMA++sY/TzO60gZgiNi8cCqo6Y5MAS9aKZwVs7+iOD5Ojmo+1N
	 zKpmYi5jn5hDP1U52B+D8AQWxi7wF27LyIHkRE2Q6Y9o+tBq5NJgEYxiok4AY3Jak4
	 JRu1DjANRWU8+4bC1v/cqplcZbmS2FqXxotV3mAPU7rJPaaBiqLkHEQNoB6jrL+czB
	 nUVAT/PzU+UkvGhC1yyCcycdrUk/C96IYKN3nHAxGD3b2Um8J6jbmgd6ylBKX5K/QS
	 4+9cYYIZP/bpSaoddmNZL6n1ES6fq80OIB0zONDx2dmDE7LrAcFHytYMxoz/DahKxv
	 sOFYd13zcUSWw==
Date: Sat, 30 Nov 2024 13:29:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Tycho Andersen <tandersen@netflix.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
Message-ID: <20241130-ohnegleichen-unweigerlich-ce3b8af0fa45@brauner>
References: <20241130045437.work.390-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241130045437.work.390-kees@kernel.org>

On Fri, Nov 29, 2024 at 08:54:38PM -0800, Kees Cook wrote:
> Zbigniew mentioned at Linux Plumber's that systemd is interested in
> switching to execveat() for service execution, but can't, because the
> contents of /proc/pid/comm are the file descriptor which was used,
> instead of the path to the binary. This makes the output of tools like
> top and ps useless, especially in a world where most fds are opened
> CLOEXEC so the number is truly meaningless.
> 
> When the filename passed in is empty (e.g. with AT_EMPTY_PATH), use the
> dentry's filename for "comm" instead of using the useless numeral from
> the synthetic fdpath construction. This way the actual exec machinery
> is unchanged, but cosmetically the comm looks reasonable to admins
> investigating things.
> 
> Instead of adding TASK_COMM_LEN more bytes to bprm, use one of the unused
> flag bits to indicate that we need to set "comm" from the dentry.
> 
> Suggested-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
> Suggested-by: Tycho Andersen <tandersen@netflix.com>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Aleksa Sarai <cyphar@cyphar.com>
> Link: https://github.com/uapi-group/kernel-features#set-comm-field-before-exec
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> 
> Here's what I've put together from the various suggestions. I didn't
> want to needlessly grow bprm, so I just added a flag instead. Otherwise,
> this is very similar to what Linus and Al suggested.
> ---
>  fs/exec.c               | 22 +++++++++++++++++++---
>  include/linux/binfmts.h |  4 +++-
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 5f16500ac325..d897d60ca5c2 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1347,7 +1347,21 @@ int begin_new_exec(struct linux_binprm * bprm)
>  		set_dumpable(current->mm, SUID_DUMP_USER);
>  
>  	perf_event_exec();
> -	__set_task_comm(me, kbasename(bprm->filename), true);
> +
> +	/*
> +	 * If the original filename was empty, alloc_bprm() made up a path
> +	 * that will probably not be useful to admins running ps or similar.
> +	 * Let's fix it up to be something reasonable.
> +	 */
> +	if (bprm->comm_from_dentry) {
> +		rcu_read_lock();
> +		/* The dentry name won't change while we hold the rcu read lock. */
> +		__set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),

What does the smp_load_acquire() pair with?

