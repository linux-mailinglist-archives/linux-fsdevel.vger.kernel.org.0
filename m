Return-Path: <linux-fsdevel+bounces-10304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D4B849A28
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5681F25DB0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06201BC46;
	Mon,  5 Feb 2024 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG2JMntN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8E171A7;
	Mon,  5 Feb 2024 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136131; cv=none; b=kb7GqCNPZI3OJbhMhIga1NqyTChIuXBPwyimuROU/TO1MybTmnS6nHYKceDlDTOfp0whkyfbZhH9I19ySMdbx86VV81NgmQzVMjVvW3ksX6iOAz+omEuxOYwBI689HyMaqa+ELQ1EE1oGQJVxky9MR7bxMxdg/QeEiLp5GPcJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136131; c=relaxed/simple;
	bh=L69wtjMODm7TYmnn0OfoaJYSfzwj3CoqiYLxlqkXr3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZ4z8hq8OhB9H3N+dTNbDuYUh+o9WN2JlpyPVoWDkQFLS+zrWzieX+378OnVpAxbVkegTxO1wBX191Q9qsV7kdbj+QNITRrkoRS7XNYpY9B1YDm/cFDVUTrfVYcP3kLkW2wZIPPqsOdl2y7Ml/HZKOarJYEoDa2rRkvf3P+Bi9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG2JMntN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E5FC433C7;
	Mon,  5 Feb 2024 12:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136130;
	bh=L69wtjMODm7TYmnn0OfoaJYSfzwj3CoqiYLxlqkXr3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FG2JMntNwoncsqiPQkaqZ0NtfHzb6dDnAKEU4Ul0uU3b2n2HshQBBdDDpi0QesebO
	 mi33N0j7MPTTl2r2tn247duu+V5NSBlKUsMi7/51hGrulBoi6dRtk6JzswN4WGAWX9
	 ZYRMBXN6sx0uKESX/cCUTp7gKiGl4FsOK5GlXJB59RTISHWVxJ9T56N9zQGclQcONN
	 kSVWZ1EaTZikQxZSdUGeqBdyIxEKROJXVfXCg9uS3EsO5CPsuVdQ6fqH9uAoVzVF6R
	 LW/CrIe6Oh2RhMw5nDTkZlrQbcjqOzHOAU4tOMnDEvQdXUQQHsj1mcR3bT4pgnNL4Q
	 9fH6dvQxTTyRg==
Date: Mon, 5 Feb 2024 13:28:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 06/13] afs: fix __afs_break_callback() /
 afs_drop_open_mmap() race
Message-ID: <20240205-haarausfall-wegbleiben-688f8b69552b@brauner>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-6-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204021739.1157830-6-viro@zeniv.linux.org.uk>

On Sun, Feb 04, 2024 at 02:17:32AM +0000, Al Viro wrote:
> In __afs_break_callback() we might check ->cb_nr_mmap and if it's non-zero
> do queue_work(&vnode->cb_work).  In afs_drop_open_mmap() we decrement
> ->cb_nr_mmap and do flush_work(&vnode->cb_work) if it reaches zero.
> 
> The trouble is, there's nothing to prevent __afs_break_callback() from
> seeing ->cb_nr_mmap before the decrement and do queue_work() after both
> the decrement and flush_work().  If that happens, we might be in trouble -
> vnode might get freed before the queued work runs.
> 
> __afs_break_callback() is always done under ->cb_lock, so let's make
> sure that ->cb_nr_mmap can change from non-zero to zero while holding
> ->cb_lock (the spinlock component of it - it's a seqlock and we don't
> need to mess with the counter).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

