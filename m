Return-Path: <linux-fsdevel+bounces-51305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76EAD53BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0823C176388
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE5239E72;
	Wed, 11 Jun 2025 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUueSxnQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B641DA3D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640977; cv=none; b=LSzEnHOEhX5QR60kqenPW17N/IvdnMoKI80++pAk8ub99uT1iNu6wmPsXWD4/pHE5E0cpONsOeIHsfKt4QEKzv2BxJ1VR9xRmH+8FCjlhNtwZeFEpJ7O17tMVK0HX6b1deGtvOa2P7XEf+qfzz7xr3hImJWrjAkpnr2mJ8W2g2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640977; c=relaxed/simple;
	bh=U8L8xZ7lEFMvNK6O5fGAgzVH1QXJuVsOOCx4zm/O6w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVZEzumosMvhOjZaeP08PbRnYiQUZg4MginNu5j9k17pj2BAialGlGjA+VANu3x19CjsC3e32/OZGjqzPhSxDmcM6Fj0BbHmVkNb51TFh5fC4qY4LNJ/ysGT8YsGmv2Ef/SEzcC0oLgWSgfD/s2rcviB7LJZXu1005V65aSaXeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUueSxnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753DCC4CEEE;
	Wed, 11 Jun 2025 11:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749640976;
	bh=U8L8xZ7lEFMvNK6O5fGAgzVH1QXJuVsOOCx4zm/O6w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUueSxnQyQuCNksSX1LJZbnsmCEXbQgSdvHRVYqhzIV8qPjVJF1JalU86Qdd6Xi7l
	 /ZVjXttykdj8QLFvfUVUwdkqqM/k2WsOA0iArXZgTEFnWXfnFP/STqUNR7NIL0ee2T
	 exp+fBpozqasDxNZDgBGBXLmCBbF9L1n9DwHTObuugFbo5VmFh5swDmjcr1YaPLzQF
	 LM3Zv3eETaSW9brYIjRgw3lLpfxinbRa1irLf6HnFQQ4nSi8VIi5nReJHAA4/1q2RH
	 clshEBKp3apMWxPKKNus3QGEhOS8vASiOAi8HhKU/Qmvf9uoejdNYVFIBZmljX/0w1
	 RNKw9B5HbtD5w==
Date: Wed, 11 Jun 2025 13:22:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 26/26] don't have mounts pin their parents
Message-ID: <20250611-girokonten-untrennbar-c50491bb1224@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-26-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-26-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:48AM +0100, Al Viro wrote:
> Simplify the rules for mount refcounts.  Current rules include:
> 	* being a namespace root => +1
> 	* being someone's child => +1
> 	* being someone's child => +1 to parent's refcount, unless you've
> 				   already been through umount_tree().
> 
> The last part is not needed at all.  It makes for more places where need
> to decrement refcounts and it creates an asymmetry between the situations
> for something that has never been a part of a namespace and something that
> left one, both for no good reason.
> 
> If mount's refcount has additions from its children, we know that
> 	* it's either someone's child itself (and will remain so
> until umount_tree(), at which point contributions from children
> will disappear), or
> 	* or is the root of namespace (and will remain such until
> it either becomes someone's child in another namespace or goes through
> umount_tree()), or
> 	* it is the root of some tree copy, and is currently pinned
> by the caller of copy_tree() (and remains such until it either gets
> into namespace, or goes to umount_tree()).
> In all cases we already have contribution(s) to refcount that will last
> as long as the contribution from children remains.  In other words, the
> lifetime is not affected by refcount contributions from children.
> 
> It might be useful for "is it busy" checks, but those are actually
> no harder to express without it.
> 
> NB: propagate_mnt_busy() part is an equivalent transformation, ugly as it
> is; the current logics is actually wrong and may give false negatives,
> but fixing that is for a separate patch (probably earlier in the queue).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

