Return-Path: <linux-fsdevel+bounces-9205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D18783EDAA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 15:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B071F21BFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C963428DA7;
	Sat, 27 Jan 2024 14:47:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621CF1E4BC;
	Sat, 27 Jan 2024 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366842; cv=none; b=bczmnJ0xowbzkTOZ5L2KX+/sprQL33Y25w8gO5mBuoOE1f3TEVx08VHf9f2E8m6TaFONd5SX8ijTnmjCTPzSuaxqV3v2+2EnfAQJq8RZHOYh4xDFvIjYLavr2eW51+AODEbNCN2t7m+FbocqASz+vb1T9coCTCx5UaX327K8vyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366842; c=relaxed/simple;
	bh=FZLyxs2KTnrtcfMD37K8ga7IQTtn1kDf3zqroJHBu0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEgrDhkjpnnGd7qFECr+IiV+mVhIcMUwjMav7nWHh1MLOr1b63V77wvAHqAx4FQwTYUUSr7pOoG3Z3rw8TnmFbl3SzGe/q6phCnetW14WzasR7sIFEqHooeM/20IFcOh2LZfhcfQb1eXoZSs50yJsVvZ8noGDDX44K4MLa5Of4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA99C433C7;
	Sat, 27 Jan 2024 14:47:20 +0000 (UTC)
Date: Sat, 27 Jan 2024 09:47:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Devel
 <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Message-ID: <20240127094717.63c09edb@rorschach.local.home>
In-Reply-To: <CAHk-=whDnGUm1zAhq7Oa+5BjzjChxObWdy4J4n2TAmMWb_RWtw@mail.gmail.com>
References: <20240126150209.367ff402@gandalf.local.home>
	<CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
	<20240126162626.31d90da9@gandalf.local.home>
	<CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
	<CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
	<0C9AF227-60F1-4D9B-9099-1A86502359BA@goodmis.org>
	<CAHk-=whDnGUm1zAhq7Oa+5BjzjChxObWdy4J4n2TAmMWb_RWtw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 14:26:08 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> nother thing that worries me is that odd locking that releases the
> lock in the middle. I don't understand why you release the
> tracefs_mutex() over create_file(), for example. There's a lot of
> "take, drop, re-take, re-drop" of that mutex that seems strange.

This was because the create_file/dir() would call into the VFS which
would grab locks, and on a final dput() on a ei dentry that is to be
freed, calls back into eventfs_set_ei_status_free() which also grabs
the eventfs_mutex. But it gets called with the same VFS locks that are
taken by create_file/dir() VFS calls. This was caught by lockdep. Hence
the dropping of those locks.

The eventfs_mutex is just protecting the ei list and also assigning and
clearing the ei->dentry. Now that dentry is used to synchronize the last
close, and also to know if the ei was ever referenced. If ei->dentry is
NULL it can be freed immediately (after SRCU) when the directory is
deleted. But if ei->dentry is set, it means that something may still
have a reference to it and must be freed after the last dput() and SRCU.

Now some of this was needed due to the way the dir wrapper worked so I
may be able to revisit this and possibly just use an ei->ref counter.
But I wasted enough time on this and I'm way behind in my other
responsibilities, so this is not something I can work on now.

-- Steve

