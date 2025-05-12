Return-Path: <linux-fsdevel+bounces-48716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DFEAB32C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCBD3A37DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874FA25A342;
	Mon, 12 May 2025 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6imcgPy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1366255238;
	Mon, 12 May 2025 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041073; cv=none; b=LBHV/9Mzl1+MjGofzRocGqQWmdR3x2UCe00uQZa4XP2pcCpyRemPcBS4EZXo16LiyQCpJKFkltXoqxEO1AzKCy2YUS3SIA1Qzryyc9GFTeHHR3AlE5DScVrtHN5ECB28vxeTax3ihssGgt2XtrCR0RxMqPzThGSrRPX61ngrqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041073; c=relaxed/simple;
	bh=/351irQ8y8ezP60Hk+w0Y0B2YMEfkZWybYmmQrMUcBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLZqrK2FH800vGVn2Xnwwj20ouOuAMwAvipe+NeLQU6O2nj6xxcI0Ehb42ERJVGo3caL9AjdLl/ds81zolo+CwSkEldbbY6GDip6/Y8LaeaVSMIyhrwD431satmTMy2zphCZJ515c4ramgUdvoWjlm56N8fCM322/apDXiy6OLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6imcgPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D7FC4CEE9;
	Mon, 12 May 2025 09:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747041072;
	bh=/351irQ8y8ezP60Hk+w0Y0B2YMEfkZWybYmmQrMUcBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d6imcgPyEeH74pNl7jZYG5XTA76uorqqNrNyh5zCsR9pp4qPafRkQ+SegYgVHmLF+
	 Ul7civZsAL7AmULogl4Ro38r8AeKHsGt6rb0yBo20BQqI9/hP7/tO3rlZVeZrot6Xp
	 VUccY3joiWutaIcYk4h2cVnfovA/pHVzIi3pLenRDLT2MwTy5aOD83yGRcUAHJz5BK
	 yiIlY5/I80eCUhGPS1Np85jsTox6kLaQJlJaISnW+o64DIAp3OeVOxdwzu+hJOwUzX
	 P7qcUTbw5thvIE5VCkefb5cScsqJlTtgCfhZ73EVA5HuvyJ3hp4a+4KX8qy4L8UqDI
	 z3vAYUMb83uzA==
Date: Mon, 12 May 2025 11:11:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org, 
	tglx@linutronix.de, jlayton@kernel.org, frederic@kernel.org, 
	chenlinxuan@uniontech.com, xu.xin16@zte.com.cn, adrian.ratiu@collabora.com, 
	lorenzo.stoakes@oracle.com, mingo@kernel.org, felix.moessbauer@siemens.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, zhanjun@uniontech.com, 
	niecheng1@uniontech.com, guanwentao@uniontech.com
Subject: Re: [PATCH] proc: Show the mountid associated with exe
Message-ID: <20250512-maximal-gutmenschen-d16584a02aeb@brauner>
References: <3885DACAB5D311F7+20250511114243.215132-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3885DACAB5D311F7+20250511114243.215132-1-wangyuli@uniontech.com>

On Sun, May 11, 2025 at 07:42:43PM +0800, WangYuli wrote:
> From: Chen Linxuan <chenlinxuan@uniontech.com>
> 
> In Linux, an fd (file descriptor) is a non-negative integer
> representing an open file or other I/O resource associated with a
> process. These resources are located on file systems accessed via
> mount points.
> 
> A mount ID (mnt_id) is a unique identifier for a specific instance
> of a mounted file system within a mount namespace, essential for
> understanding the file's context, especially in complex or
> containerized environments. The executable (exe), pointed to by
> /proc/<pid>/exe, is the process's binary file, which also resides
> on a file system.
> 
> Knowing the mount ID for both file descriptors and the executable
> is valuable for debugging and understanding a process's resource
> origins.
> 
> We can easily obtain the mnt_id for an open fd by reading
> /proc/<pid>/fdinfo/<fd}, where it's explicitly listed.
> 
> However, there isn't a direct interface (like a specific field in
> /proc/<pid}/ status or a dedicated exeinfo file) to easily get the
> mount ID of the executable file without performing additional path
> resolution or file operations.
> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---


>  fs/proc/base.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index b0d4e1908b22..fe8a2d5b3bc1 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -101,6 +101,7 @@
>  #include <trace/events/oom.h>
>  #include "internal.h"
>  #include "fd.h"
> +#include "../mount.h"
>  
>  #include "../../lib/kstrtox.h"
>  
> @@ -1790,6 +1791,28 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
>  		return -ENOENT;
>  }
>  
> +static int proc_exe_mntid(struct seq_file *m, struct pid_namespace *ns,
> +			struct pid *pid, struct task_struct *task)
> +{
> +	struct file *exe_file;
> +	struct path exe_path;
> +
> +	exe_file = get_task_exe_file(task);
> +
> +	if (exe_file) {
> +		exe_path = exe_file->f_path;
> +		path_get(&exe_file->f_path);
> +
> +		seq_printf(m, "%i\n", real_mount(exe_path.mnt)->mnt_id);

You're exposing the legacy mount id. It is only guaranteed to be valid
while the executable is running as legacy mount ids are recycled
quickly.

And no, we're not going to expose either in this way via procfs. You can
get the same information via:

fd_exe = open("/proc/<pid>/exe", O_PATH | O_CLOEXEC);
statx(fd_exe, ...)

or via fdinfo:

read("/proc/self/fdinfo/<fd_exe>");

A separate file for this is just not worth it.

