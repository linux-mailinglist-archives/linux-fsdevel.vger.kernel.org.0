Return-Path: <linux-fsdevel+bounces-25659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9497194E9AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BB51C21629
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006CD16D4E2;
	Mon, 12 Aug 2024 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjgW25aP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C716CD19
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454695; cv=none; b=uvM7bdLPLVLIbeLG0UTGmgEM4W4z0KLvatld3K1cfoSQwNBPqVgc+P2vcISk8IE7Cj8mKYSNIvk9W/2jxnkjhgQG/6ElHQdLyVbu8YU0qDSa1XQc9XIxahl3Nsvw9zyd4rz9fVn6R335HYyBwwwsKjnvnQBpxyROxEnlPwbGoCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454695; c=relaxed/simple;
	bh=gXCXxKPbVZO+PIzcIoPbX3AlD9BRaA+8CdpPULG3rwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd98rwKYI+zLPeCqjIT9Oj+42LH6BG6u5RZWH8o6jWthbqs5lTgv1UHqo1iaVznzObea9AFQ2thNxIvmDOq6IRCWx73EN6Q/kfERGtLvfwLxjeGW4mefkVCdImmCAugXbFq5Cci+fPBbxe7MsqAlYfhCQyKiRSIfJTEJzkcy0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjgW25aP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C20C32782;
	Mon, 12 Aug 2024 09:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723454695;
	bh=gXCXxKPbVZO+PIzcIoPbX3AlD9BRaA+8CdpPULG3rwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZjgW25aPaznwM+VZV2cQ2Y4qcNt68i+BCahv/BSBb8FojOmPpxhUPWAD4X8Xs+rNq
	 JzitAyHit7wZQYTK26Oyo1KfwbKSpVkR6HeFQ/x9E6EoMU7utPsfw/XafPqSv+ZdDB
	 /vdrAMLpxL/LTLtQupcU3174CMwkR25bwI3Emnsy53sE+mOSxr31Ac+TaUbW5jDh05
	 z5f+pkDJOZvCXjKJXktHdMR6sKluQldgYtc7VwrAXWWllGPu69S/7Sotdzsu7UtfSo
	 lkV9+mdahM7dLBwZmxNhvKS7xJX32gYtpi/pFaJqVlqyhTP83vsQBkEnC25EHwpvNH
	 J9aeSHeaVs49w==
Date: Mon, 12 Aug 2024 11:24:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/11] get rid of ...lookup...fdget_rcu() family
Message-ID: <20240812-radikal-wohnraum-a30b0f3b4fc3@brauner>
References: <20240812064214.GH13701@ZenIV>
 <20240812064427.240190-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240812064427.240190-1-viro@zeniv.linux.org.uk>

On Mon, Aug 12, 2024 at 07:44:17AM GMT, Al Viro wrote:
> Once upon a time, predecessors of those used to do file lookup
> without bumping a refcount, provided that caller held rcu_read_lock()
> across the lookup and whatever it wanted to read from the struct
> file found.  When struct file allocation switched to SLAB_TYPESAFE_BY_RCU,
> that stopped being feasible and these primitives started to bump the
> file refcount for lookup result, requiring the caller to call fput()
> afterwards.
> 
> But that turned them pointless - e.g.
> 	rcu_read_lock();
> 	file = lookup_fdget_rcu(fd);
> 	rcu_read_unlock();
> is equivalent to
> 	file = fget_raw(fd);
> and all callers of lookup_fdget_rcu() are of that form.  Similarly,
> task_lookup_fdget_rcu() calls can be replaced with calling fget_task().
> task_lookup_next_fdget_rcu() doesn't have direct counterparts, but
> its callers would be happier if we replaced it with an analogue that
> deals with RCU internally.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

