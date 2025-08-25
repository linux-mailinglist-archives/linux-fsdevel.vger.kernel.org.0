Return-Path: <linux-fsdevel+bounces-59012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6505B33E80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98E314E3243
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AB32E5437;
	Mon, 25 Aug 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPkoEoxv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400CF38D;
	Mon, 25 Aug 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122971; cv=none; b=ZwgmIwLU4fHuSpmfAQ9kGCgoySurTUY2lQ1IfCUDsJoU81coPCt3odiCxxo2zL0uvT9wjkssobfsJ1Nt56eC5Onn5Vy6AhNKKcR6aSWrSSKT7Cb8E+o1w3pqYJJPJdc3hD5XcPj7oKXmaQXz/7//JomMjaFCiAxAZgHPdTdXuao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122971; c=relaxed/simple;
	bh=MDSWgn6WKv+gJIuM/KMh250oQpC7dHfexKwoxreXAtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbFoxBXxK4STmFlVQ1hfE8xdSyq4hkgCX5OWeEllQYjThmY+BCvKcQx3uhh1EebT9voHAtwcFv7BCIlNKBaj5jJyWdZEghqwwM+1idBVr5CLWJVEStre9RxYF04ccb8gB/lPgV5CipUvNsrS/msfbOhbkRLKu/ddmyhxa/28rag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPkoEoxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FF5C4CEED;
	Mon, 25 Aug 2025 11:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756122970;
	bh=MDSWgn6WKv+gJIuM/KMh250oQpC7dHfexKwoxreXAtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPkoEoxvHfgM+V7S4D/WFHpuNZ0OztvUfx+8JrDAC6WCCyKOGfofT392bUTFo+d0L
	 jUByDTZKk77wKlMuRUbbnMUhzDELt76eEAGciBD9sdxdT4RpifTPanfxRY2Mp29O+7
	 c6dCbh1KXx8QNOici8N5M6SEhafagC+bQJqvDaxEen/vU+1omdfRx6ryn/+Hlxfnly
	 H4+YagonfpyWr0RcyGTP5/8S+fGG7AIemHsqHbL8Ef7+Gn7pbp1fUjCEXpBgX6Cw47
	 p5TO56K1k/U/Ubwe24Vg8UeHicfrpmmPYjZZ0hTzCqK6HnzyWfo57OQo0v8jOhFil4
	 5yltmj8H7f2/A==
Date: Mon, 25 Aug 2025 13:56:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 50/50] fs: add documentation explaining the reference
 count rules for inodes
Message-ID: <20250825-evakuieren-ansetzen-105f384692dc@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <e0bdfc839c71c8e7264e570125cc4573d9613df4.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0bdfc839c71c8e7264e570125cc4573d9613df4.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:19:01PM -0400, Josef Bacik wrote:
> Now that we've made these changes to the inode, document the reference
> count rules in the vfs documentation.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  Documentation/filesystems/vfs.rst | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 229eb90c96f2..5bfe7863a5de 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -457,6 +457,29 @@ The Inode Object
>  
>  An inode object represents an object within the filesystem.
>  
> +Reference counting rules
> +------------------------
> +
> +The inode is reference counted in two distinct ways, an i_obj_count refcount and
> +an i_count refcount. These control two different lifetimes of the inode. The
> +i_obj_count is the simplest, think of it as a reference count on the object
> +itself. When the i_obj_count reaches zero, the inode is freed.  Inode freeing
> +happens in the RCU context, so the inode is not freed immediately, but rather
> +after a grace period.
> +
> +The i_count reference is the indicator that the inode is "alive". That is to
> +say, it is available for use by all the ways that a user can access the inode.
> +Once this count reaches zero, we begin the process of evicting the inode. This
> +is where the final truncate of an unlinked inode will normally occur.  Once
> +i_count has reached 0, only the final iput() is allowed to do things like
> +writeback, truncate, etc. All users that want to do these style of operation
> +must use igrab() or, in very rare and specific circumstances, use
> +inode_tryget().
> +
> +Every access to an inode must include one of these two references. Generally
> +i_obj_count is reserved for internal VFS references, the s_inode_list for
> +example. All file systems should use igrab()/lookup() to get a live reference on
> +the inode, with very few exceptions.

It would be awesome if you could document in more detail how LRU
handling and reference counts works.

I_FREEING | I_WILL_FREE was tightly interconnected with LRU handling and
it was frankly a mess to understand so having the new stuff clearly
documented would help us all a lot. Thanks!

