Return-Path: <linux-fsdevel+bounces-41369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96135A2E52B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 08:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABD7188BD55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 07:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC811ACEAC;
	Mon, 10 Feb 2025 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D3VUYUh9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0346130E58;
	Mon, 10 Feb 2025 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739171303; cv=none; b=eN71tJTVfXwCIBwhGtBw0dYws0SnrcGMQL4hAr6zVB31gmw96R9TnOBTY3Cx35W3PusF0JhxcqVLP8Wq3gy/FfsvBuJlappAwnxcQ8EsRZliYa+mPkr7jK+LisB0+O1XVtttTbDzFlLeP7cibfm8tZdX/ZLgO5Eo858454GZHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739171303; c=relaxed/simple;
	bh=xmvJW278o88o2TSb1VIZDRp8UkUFXbbIsI0ctYa0fXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIMztqqosWBXowi6HY+QB7xpPvDUFY/0GGQ+zcZoE/L6FiZxSp0vCsVA7qWZrd2UYm3xvJatrnzhcu7ywEau5qaWNyhMclcQPj5rURwXIN1xQIQMNJ3JZtdikozxPNnDaWsubLWzNhDkN7FnniIUzIc21CvHCAOq7+WecbjkYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D3VUYUh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65D5C4CED1;
	Mon, 10 Feb 2025 07:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739171302;
	bh=xmvJW278o88o2TSb1VIZDRp8UkUFXbbIsI0ctYa0fXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3VUYUh9EiNiJ2K1v7tS6sdU+5IbgfD25scRhwksR7+Xl5kHL4zSXFfy2KODsdfxq
	 W3b6dqmqs1braLlD67nbV5M72WHW6weahVWBDUnB1OvZyjKxN29RNG9VMOH84q6Inx
	 Vh6Jh3CqU9xj4Nf6jiefOZKnyFQ8TZYOCzc8sacA=
Date: Mon, 10 Feb 2025 08:08:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Reaver <me@davidreaver.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] debugfs: Replace dentry with an opaque handle in
 debugfs API
Message-ID: <2025021048-thieving-failing-7831@gregkh>
References: <20250210052039.144513-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210052039.144513-1-me@davidreaver.com>

On Sun, Feb 09, 2025 at 09:20:20PM -0800, David Reaver wrote:
> Overview
> ========
> 
> This patch series replaces raw dentry pointers in the debugfs API with
> an opaque wrapper struct:
> 
> 	struct debugfs_node {
> 		struct dentry dentry;
> 	};
> 
> Intermediate commits rely on "#define debugfs_node dentry" to migrate
> debugfs users without breaking the build. The final commit introduces
> the struct and updates debugfs internals accordingly.
> 
> Why an RFC?
> ===========
> 
> This is a large change, and I expect a few iterations -- unless this
> entire approach is NACKed of course :) Any advice is appreciated, and
> I'm particularly looking for feedback on the following:
> 
> 1. This change touches over 1100 files. Is that okay? I've been told it
>    is because the patch series does "one thing", but it is a lot of
>    files to touch across many systems.
> 
> 2. The trickiest part of this migration is ensuring a declaration for
>    struct debugfs_node is in scope so we don't get errors that it is
>    being implicitly defined, especially as different kernel
>    configurations change which headers are transitively included. See
>    "#includes and #defines" below. I'm open to any other migration
>    strategies.
> 
> 3. This change is mostly automated with Coccinelle, but I'm really
>    contorting Coccinelle to replace dentry with debugfs_node in
>    different kinds of declarations. Any Coccinelle advice would be
>    appreciated.
> 
> Purpose/Background
> ==================
> 
> debugfs currently relies on dentry to represent its filesystem
> hierarchy, and its API directly exposes dentry pointers to users. This
> tight coupling makes it difficult to modify debugfs internals. A dentry
> and inode should exist only when needed, rather than being persistently
> tied to debugfs. Some kernel developers have proposed using an opaque
> handle for debugfs nodes instead of dentry pointers [1][2][3].
> 
> Replacing dentry with debugfs_node simplifies future migrations away
> from dentry. Additionally, a declaration with debugfs_node is more
> self-explanatory -- its purpose is immediately clear, unlike dentry,
> which requires further context to understand its role as a debugfs
> dentry.

First off, many thanks for attempting this, I didn't think it was ready
to even be attempted, so it's very nice to see this.

That being said, I agree with Al, we can't embed a dentry in a structure
like that as the lifecycles are going to get messy fast.

Also, your replacement of many of the dentry functions with wrappers
seems at bit odd, ideally you would just return a dentry from a call
like "debugfs_node_to_dentry()" and then let the caller do with it what
it wants to, that way you don't need to wrap everything.

And finally, I think that many of the places where you did have to
convert the code to save off a debugfs node instead of a dentry can be
removed entirely as a "lookup this file" can be used instead.  I was
waiting for more conversions of that logic, removing the need to store
anything in a driver/subsystem first, before attempting to get rid of
the returned dentry pointer.

As an example of this, why not look at removing almost all of those
pointers in the relay code?  Why is all of that being stored at all?

Oh, also, all of those forward declarations look really odd, something
feels wrong with needing that type of patch if we are doing things
right.  Are you sure it was needed?

thanks,

greg k-h

