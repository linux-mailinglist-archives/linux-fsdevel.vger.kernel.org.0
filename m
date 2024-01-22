Return-Path: <linux-fsdevel+bounces-8481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F98375B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 22:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2E81C26F12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EFF482F9;
	Mon, 22 Jan 2024 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoMi5e0X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B248785;
	Mon, 22 Jan 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960772; cv=none; b=fc97gAPgb4cbCOEuaDAW0tcQvC9GO/hKGR2ZU9IT1vGhB7gK9CPZhKGhUlp7ffK24gF3F7TMzZbZvs+coE10CcDzJrCYkPwLARQQGB/0/8tjylGmUaUTt7CUsC8YXUupXGhe+gaNum1KygUZVpCZkNqQ0gTdG6OlOmOgKOsSC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960772; c=relaxed/simple;
	bh=am4ve4KfU4jwHZ/TAyMBGpHozz+jSvRUqB01KMTKOg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rmat3DVTHF/uION8rdhqB/L/sVnZmbOY6JJpH7GrSi7lL9f5gdnLR8oeyiN+lmHqN95fW1bYS9sxMRWRiAw4pnMmdD9HXC4dvfkKkrxUBwiVObsyt+2jdKhiCgG2q6QlnDxEtRDQj2E9qu4IcANVpCUQALW3uyT3n17jjnJi/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoMi5e0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DEDC433F1;
	Mon, 22 Jan 2024 21:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705960771;
	bh=am4ve4KfU4jwHZ/TAyMBGpHozz+jSvRUqB01KMTKOg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IoMi5e0X7Rlpq7H53Zg11damp7QnG6EsQ2EEEhMWJyKuXEzQesZVjAX0ZgQ9IlDYs
	 k3Iv8Xf33n2v6YMRQ+Z86Dl23nhcG03P1llCa15NWVc6IQ1Q8d5GhBm0annOmHSv5t
	 O35HYZe7hif6DetSEO3dgZ8JpPYGvix10JHArGSL2xDWzcnet9j4zbKHFioc7yrmye
	 aWbBjn9XYRvkUkeEMAIukGR0/RRvY4zOXz1uJDioTPMdaXIUu5Ij9BAc2fHjkneNeZ
	 03aDIIW1d9syjyH4i/9+E+0ktC3AxWvFHhc1o0bEIU2CEaA4FEFr+plIsc0CW1UvDj
	 jvnQ1oGWbFoNw==
Date: Mon, 22 Jan 2024 13:59:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] eventfs: Have the inodes all for files and
 directories all be the same
Message-ID: <20240122215930.GA6184@frogsfrogsfrogs>
References: <20240116225531.681181743@goodmis.org>
 <20240116234014.459886712@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240116234014.459886712@goodmis.org>

On Tue, Jan 16, 2024 at 05:55:32PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The dentries and inodes are created in the readdir for the sole purpose of
> getting a consistent inode number. Linus stated that is unnecessary, and
> that all inodes can have the same inode number. For a virtual file system
> they are pretty meaningless.
> 
> Instead use a single unique inode number for all files and one for all
> directories.
> 
> Link: https://lore.kernel.org/all/20240116133753.2808d45e@gandalf.local.home/
> Link: https://lore.kernel.org/linux-trace-kernel/20240116211353.412180363@goodmis.org
> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Al  Viro <viro@ZenIV.linux.org.uk>
> Cc: Ajay Kaher <ajay.kaher@broadcom.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/tracefs/event_inode.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index fdff53d5a1f8..5edf0b96758b 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -32,6 +32,10 @@
>   */
>  static DEFINE_MUTEX(eventfs_mutex);
>  
> +/* Choose something "unique" ;-) */
> +#define EVENTFS_FILE_INODE_INO		0x12c4e37
> +#define EVENTFS_DIR_INODE_INO		0x134b2f5
> +
>  /*
>   * The eventfs_inode (ei) itself is protected by SRCU. It is released from
>   * its parent's list and will have is_freed set (under eventfs_mutex).
> @@ -352,6 +356,9 @@ static struct dentry *create_file(const char *name, umode_t mode,
>  	inode->i_fop = fop;
>  	inode->i_private = data;
>  
> +	/* All files will have the same inode number */
> +	inode->i_ino = EVENTFS_FILE_INODE_INO;
> +
>  	ti = get_tracefs(inode);
>  	ti->flags |= TRACEFS_EVENT_INODE;
>  	d_instantiate(dentry, inode);
> @@ -388,6 +395,9 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
>  	inode->i_op = &eventfs_root_dir_inode_operations;
>  	inode->i_fop = &eventfs_file_operations;
>  
> +	/* All directories will have the same inode number */
> +	inode->i_ino = EVENTFS_DIR_INODE_INO;

Regrettably, this leads to find failing on 6.8-rc1 (see xfs/55[89] in
fstests):

# find /sys/kernel/debug/tracing/ >/dev/null
find: File system loop detected; ‘/sys/kernel/debug/tracing/events/initcall/initcall_finish’ is part of the same file system loop as ‘/sys/kernel/debug/tracing/events/initcall’.
find: File system loop detected; ‘/sys/kernel/debug/tracing/events/initcall/initcall_start’ is part of the same file system loop as ‘/sys/kernel/debug/tracing/events/initcall’.
find: File system loop detected; ‘/sys/kernel/debug/tracing/events/initcall/initcall_level’ is part of the same file system loop as ‘/sys/kernel/debug/tracing/events/initcall’.

There were no such reports on 6.7.0; AFAICT find(1) is tripping over
parent and child subdirectory having the same dev/i_ino.  Changing this
line to the following:

	/* All directories will NOT have the same inode number */
	inode->i_ino = (unsigned long)inode;

makes the messages about filesystem loops go away, though I don't think
leaking raw kernel pointers is an awesome idea.

--D

> +
>  	ti = get_tracefs(inode);
>  	ti->flags |= TRACEFS_EVENT_INODE;
>  
> -- 
> 2.43.0
> 
> 
> 

