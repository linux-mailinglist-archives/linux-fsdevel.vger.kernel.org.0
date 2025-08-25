Return-Path: <linux-fsdevel+bounces-59038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8891AB33FC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042531A80E21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C9B1C6FE8;
	Mon, 25 Aug 2025 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huWAojBs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7D1B040B
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125657; cv=none; b=OnppC+p83DgjF1Eq+d4g7GbX19aY/8j9MwzBqzx423YtoEyKDUHg7COR+Cjn7hRmKAgzWArjpbcAMpFW0C0UoFQU9wq30S46anv6nMwvPXlApyo7hXlUwyILxlHSqYulGpXLAScp9lCbU82Z1ocucap+ofL9PCN6NuX2pOJDdW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125657; c=relaxed/simple;
	bh=OWctUFOp14vOh0K8ZgG02HgirWf8JXBl3m59Hx0Asmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBNHX66kc/JtM83T8EPUixy9MgzLNNKopj4Gvz36qFfB1kZ6PkIp2N2/AeJ/EYHPkaziG+7p0pfT2sNA3LCqOpmp2jtBdGRhWWQuOy2/ALkeOdF+oDLOXZx7u5PEKncG6lhSyYFJq3kDOoNa0VGs5RrDaFLGRas/iXQ6ZXFxTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huWAojBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE50C4CEED;
	Mon, 25 Aug 2025 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756125656;
	bh=OWctUFOp14vOh0K8ZgG02HgirWf8JXBl3m59Hx0Asmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huWAojBswqV/aaQ7uZ7dU0TEUES8uMQWu7P0nJBZmAXm0zpsDcb6/Mfk+kiHU6cu9
	 GPSStPzoauUh4ZKdwb7e2rcWfJKt31Dx2zhhNyqClmXpP+AdvkKT2cJtdTcqHl/1Rq
	 Zl1gR3OSO5/GPUFI07rPpIKLzcmouk6W/x7JPzBR3BYyGc0Ziy7GlzJaZAjEZT0+8J
	 2twKjsEvC4YE5lLzAXRHZz44U279Du2F8XdKuYS18GwNAx5Iuj6SwDcj5TipSLoqMI
	 LBb/xI6nhJpz6efqCXktEyzSCE377g2TCVd4zWU5yO8eSED+LTS7weU2VrO/6XK5S9
	 ZR0c+UebUvxHw==
Date: Mon, 25 Aug 2025 14:40:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 09/52] put_mnt_ns(): use guards
Message-ID: <20250825-hohen-brokkoli-377019b30a94@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-9-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-9-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:12AM +0100, Al Viro wrote:
> clean fit; guards can't be weaker due to umount_tree() call.
> Setting emptied_ns requires namespace_excl, but not anything
> mount_lock-related.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namespace.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 898a6b7307e4..86a86be2b0ef 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -6153,12 +6153,10 @@ void put_mnt_ns(struct mnt_namespace *ns)
>  {
>  	if (!refcount_dec_and_test(&ns->ns.count))
>  		return;
> -	namespace_lock();
> +	guard(namespace_excl)();
>  	emptied_ns = ns;

Another thing, did I miss

commit aab771f34e63ef89e195b63d121abcb55eebfde6
Author:     Al Viro <viro@zeniv.linux.org.uk>
AuthorDate: Wed Jun 18 18:23:41 2025 -0400
Commit:     Al Viro <viro@zeniv.linux.org.uk>
CommitDate: Sun Jun 29 19:03:46 2025 -0400

    take freeing of emptied mnt_namespace to namespace_unlock()

on the list somehow? I just saw that "emptied_ns" thing for the first
time and was very confused where that came from. I don't see any lore
link attached to the commit message.

