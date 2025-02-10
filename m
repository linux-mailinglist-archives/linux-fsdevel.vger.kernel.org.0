Return-Path: <linux-fsdevel+bounces-41424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E180A2F52D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC167167398
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5730255E45;
	Mon, 10 Feb 2025 17:25:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843632500BA;
	Mon, 10 Feb 2025 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208320; cv=none; b=j/WwXc62ywgqwdXUyjAbv/AtRSv/L4Mk9vKos+FZZtJxcAiNxcik2q11Pr+SzcA8/NjYJuS/hZP3qdeKR0fM5aWWolMisw5tuH+tMd8Tk2SIWQU3O6mTEOZexKZOhnM5SJ5ur+6Rg0lR1yWbLy3h+GAq3H8hkT1xlOOYrlkWgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208320; c=relaxed/simple;
	bh=cba4ZwmhnGCFyWrudrOaxS5io42lHQ1n9Sr/fqDukjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ku6wSQVjYYDZM/kN1cXZyQ4Dz68gJ02+/VP1OEJ1ZogqXXyM4ZtkGAsL+tKW/OGcGYtqXLFFfb8tqCKvJqpgr2LwPt8R9z4EQY6arP70Q2z75WAl1nXc7nqDxT5fbNeN51089S2qunddHzBPavUtd5HIWW1bjqwCFJJ3Ol9TtVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A86C4CED1;
	Mon, 10 Feb 2025 17:25:18 +0000 (UTC)
Date: Mon, 10 Feb 2025 12:25:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Reaver <me@davidreaver.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, cocci@inria.fr, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] debugfs: Replace dentry with an opaque handle
 in debugfs API
Message-ID: <20250210122521.19cafd51@gandalf.local.home>
In-Reply-To: <20250210121246.60b2efbf@gandalf.local.home>
References: <20250210052039.144513-1-me@davidreaver.com>
	<2025021048-thieving-failing-7831@gregkh>
	<86ldud3hqe.fsf@davidreaver.com>
	<20250210115313.69299472@gandalf.local.home>
	<20250210170016.GD1977892@ZenIV>
	<20250210121246.60b2efbf@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 12:12:46 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From what I understand (and Christian can correct me), is that kernfs was
> created to be that interface of the "storage" connecting back to the
> kernel. Where the VFS layer deals with the user accessing the file system
> (read, write, mkdir, etc) but kernfs is the "data storage" that attaches
> those call back to the kernel to retrieve kernel information or even modify
> the kernel behavior.

To further expand on this, what a pseudo file system would need, is a way
to describe the layout of the file system, and to have the file_operations
defined for each file.

And possibly, a way to control what directories are made and what is in the
directory when a "mkdir" is performed (as mkdir in pseudo file systems
seldom create an empty directory). It would also need to handle the "rmdir"
on those directories.

Would also need to be able to store permissions too.

Debugfs did this with the dentry as the descriptor. But that dentry also
requires a static inode behind it and the memory used for all this was
really being wasted. Having a separate descriptor that acts like a storage
device and saves the file ops is basically all that is needed. It can act
like a real file system where no dentry or inode is created until the file
system is accessed by the user. And then, this descriptor can be attached
to the dentry and have an inode created for it. But after the file is no
longer referenced, the dentry and inode can be freed.

This is what is lacking with debugfs and tracefs at the moment. I did carve
out an "eventfs" from tracefs to do the above, and it saved over 20Megs in
memory when it wasn't being accessed.

-- Steve

