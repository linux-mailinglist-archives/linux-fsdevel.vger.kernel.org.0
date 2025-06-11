Return-Path: <linux-fsdevel+bounces-51289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BAEAD5344
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1191C20C64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56442874F9;
	Wed, 11 Jun 2025 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9WCdLO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218352874E8
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639285; cv=none; b=K+p+omPSnwpYS6X6WlS2P62tQ7KjgzJlIVFhIhUu+7TwkTdyR8MiOJQhMn//5aUwiF8QbsZj6fa4x+VG+OrDRjGX9MVjQSC+XTsMcX6OgCs0VubTxPzVxYmnrR385j667oVTk0nNHhKD92OxoDTprvnyXkxNbrAF4Ng6kiawojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639285; c=relaxed/simple;
	bh=o2XsQKUCYG9u1N6EFuiCmfXXD5RXdJSkMwDPFS1yFog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhhuNoEkq2lQ9voJh5APdHGt5IUyJNcqzlBwXkE+Lg9OiW2azTQWxt2pxVenaBrcfcz2ThyL4C67rn4VUYHnJzToWxTRg7LJQBMz5dQc4OKxdeHfizvrXOnE3FLkIFgz7YSG+SOr/+PI4nwvr95fJEaHnixT+kbFo86sJf4r8tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9WCdLO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D006C4CEEE;
	Wed, 11 Jun 2025 10:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639284;
	bh=o2XsQKUCYG9u1N6EFuiCmfXXD5RXdJSkMwDPFS1yFog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9WCdLO9enuhYwcKAD0cgTOQrHsY0YedFL9JlDyEZiLOqHzppylSOhFuqFfcj6xRx
	 1oULRz2TocC2zWFOnmEMUMPs3W4+274WJmPIerjcXjuV4wmCCBEMp/CdhWbGGUBJfd
	 DzehqDw9+HYTCC54CnosDo4Ku3A12EZ3tJHidmRxWSZU1O1VoS3Y6ndNf39154jzxy
	 wcH95waA2eMcXPmTw+pBL51Xxh0evV/di1sHBPWgqsVHs5nnQUu+Tr49SA03ZxZveb
	 +URcLdqYMm/delbx43uv8QjTj4gZn8191wyVEupuC/UdnN7fnxz++cQ1Hnum3ehfzU
	 FljAGw4+ZUxEA==
Date: Wed, 11 Jun 2025 12:54:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 10/26] do_umount(): simplify the "is it still mounted"
 checks
Message-ID: <20250611-klubs-frappierend-847293d030e0@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-10-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-10-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:32AM +0100, Al Viro wrote:
> Calls of do_umount() are always preceded by can_umount(), where we'd
> done a racy check for mount belonging to our namespace; if it wasn't,
> can_unmount() would've failed with -EINVAL and we wouldn't have
> reached do_umount() at all.
> 
> That check needs to be redone once we have acquired namespace_sem
> and in do_umount() we do that.  However, that's done in a very odd
> way; we check that mount is still in rbtree of _some_ namespace or
> its mnt_list is not empty.  It is equivalent to check_mnt(mnt) -
> we know that earlier mnt was mounted in our namespace; if it has
> stayed there, it's going to remain in rbtree of our namespace.
> OTOH, if it ever had been removed from out namespace, it would be
> removed from rbtree and it never would've re-added to a namespace
> afterwards.  As for ->mnt_list, for something that had been mounted
> in a namespace we'll never observe non-empty ->mnt_list while holding
> namespace_sem - it does temporarily become non-empty during
> umount_tree(), but that doesn't outlast the call of umount_tree(),
> let alone dropping namespace_sem.
> 
> Things get much easier to follow if we replace that with (equivalent)
> check_mnt(mnt) there.  What's more, currently we treat a failure of
> that test as "quietly do nothing"; we might as well pretend that we'd
> lost the race and fail on that the same way can_umount() would have.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

