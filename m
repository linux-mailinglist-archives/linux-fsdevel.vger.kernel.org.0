Return-Path: <linux-fsdevel+bounces-7255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74BD8235E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 20:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55255282744
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 19:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2C11CFAD;
	Wed,  3 Jan 2024 19:52:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765221D525;
	Wed,  3 Jan 2024 19:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0594C433C7;
	Wed,  3 Jan 2024 19:52:02 +0000 (UTC)
Date: Wed, 3 Jan 2024 14:53:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Al Viro <viro@ZenIV.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
Message-ID: <20240103145306.51f8a4cd@gandalf.local.home>
In-Reply-To: <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
References: <20240103102553.17a19cea@gandalf.local.home>
	<CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
	<CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jan 2024 10:38:09 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> @@ -332,10 +255,8 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
>  	if (!remount || opts->opts & BIT(Opt_uid))
>  		inode->i_uid = opts->uid;
>  
> -	if (!remount || opts->opts & BIT(Opt_gid)) {
> -		/* Set all the group ids to the mount option */
> -		set_gid(sb->s_root, opts->gid);
> -	}
> +	if (!remount || opts->opts & BIT(Opt_gid))
> +		inode->i_gid = opts->gid;
>  
>  	return 0;
>  }

This doesn't work because for tracefs (not eventfs) the dentries are
created at boot up and before the file system is mounted. This means you
can't even set a gid in /etc/fstab. This will cause a regression.

tracefs was designed after debugfs, which also ignores gid. But because
there's users out there that want non-root accounts to have access to
tracing, it is documented to set the gid to a group that you can then add
users to. And that's the reason behind the set_gid() walk.

Reverting that one commit won't fix things either, because it only blocked
OTH to be read, but the creation of the files changed their mode's passed
to block OTH as well, so all those would need to be changed too. And I
don't think making the trace files open to OTH is a good solution, even if
the tracefs top level directory itself blocks other. The issue was that the
user use to just mount the top level to allow the group access to the files
below, which allowed all users access. But this is weak control of the file
system.

Even my non-test machines have me in the tracing group so my user account
has access to tracefs.

On boot up, all the tracefs files are created via tracefs_create_file() and
directories by tracefs_create_dir() which was copied from
debugfs_create_file/dir(). At this moment, the dentry is created with the
permissions set. There's no looking at the super block.

So we need a way to change the permissions at mount time.

The only solution I can think of that doesn't include walking the current
dentries, is to convert all of tracefs to be more like eventfs, and have
the dentries created on demand. But perhaps, different than eventfs, they
do not need to be freed when they are no longer referenced, which should
make it easier to implement. And there's not nearly as many files and
directories, so keeping meta data around isn't as much of an issue.

Instead of creating the inode and dentry in the tracefs_create_file/dir(),
it could just create a descriptor that holds the fops, data and mode. Then
on lookup, it would create the inodes and dentries similar to eventfs.

It would need its own iterate_shared as well.

-- Steve

