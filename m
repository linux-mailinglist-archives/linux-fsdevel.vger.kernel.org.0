Return-Path: <linux-fsdevel+bounces-59024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A87BB33F6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54BB203AA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222CC1A9FB3;
	Mon, 25 Aug 2025 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S06X1WP3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DF1A8401
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125024; cv=none; b=rOTqHKv1uS4cNdnxbx3VIhzLgRUUWjvUihsuPK5TAwvWwJdwWJ3XSoe4hDGpFlFh4Fqlwdc4Gm83mixF4+un5AOraRvTJOYk2KgchXmn2S52R5JA7nX0X4j4Kz3tcukUCw8SPOVpXmye4Ip0REtD0D9Way3q/GXG23QpR2XtWdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125024; c=relaxed/simple;
	bh=saQXyyKePGEn/cw0taEZVp6nqLbaiUnohirHuTxOt0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCKqUYlnIgt79G11va6PvLkfd7m8ABGw6IrWeVcO0wjItNeLLKaTxb5m6OKOBtO8lsZ/Etmn4e2hmwJV2sIcTadSJf5n65UDR87sPJL4+W1ND7KtWeB8DJabEVungPyGXLkC9fuGbTAVPqIiezcy1YerVJXBWeW/Ltr8K6E5xeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S06X1WP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BDDC4CEED;
	Mon, 25 Aug 2025 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756125024;
	bh=saQXyyKePGEn/cw0taEZVp6nqLbaiUnohirHuTxOt0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S06X1WP3wonl4UzGNXp8wZbgh5DMxOMDO3g0ttS67otCDcDV4Ds+iRkKLTgBe8ORi
	 T8X4rgcIOrchryCaLULhauVk9Y5BLYhqGuVoVn2skj727j+94Km7lq95GoMJVw75FM
	 vaQrOzuW47kGRlHyQcWV1dZu4vKiDwqohxfDRiBiLjIuflWScwQ1vAUS58Tr+sjA/y
	 4BhX2djHa2LiLunqDyoVvGBMgdlSsJ/Oo5mjDOGhNBxh7IBV7l7hT5g3NMkf5g9K8u
	 aJzLkgKfVR1f0zV+dJGdBXR3U9jwKqDx/lo8Q9iIsF1cSOv7VLX1lPP50Jubs8QtUA
	 APP2nglicRP4Q==
Date: Mon, 25 Aug 2025 14:30:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 01/52] fs/namespace.c: fix the namespace_sem guard mess
Message-ID: <20250825-sinnbild-fluchen-e6a5bdbc2215@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:04AM +0100, Al Viro wrote:
> If anything, namespace_lock should be DEFINE_LOCK_GUARD_0, not DEFINE_GUARD.
> That way we
> 	* do not need to feed it a bogus argument
> 	* do not get gcc trying to compare an address of static in
> file variable with -4097 - and, if we are unlucky, trying to keep
> it in a register, with spills and all such.
> 
> The same problems apply to grabbing namespace_sem shared.
> 
> Rename it to namespace_excl, add namespace_shared, convert the existing users:
> 
>     guard(namespace_lock, &namespace_sem) => guard(namespace_excl)()
>     guard(rwsem_read, &namespace_sem) => guard(namespace_shared)()
>     scoped_guard(namespace_lock, &namespace_sem) => scoped_guard(namespace_excl)
>     scoped_guard(rwsem_read, &namespace_sem) => scoped_guard(namespace_shared)
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

