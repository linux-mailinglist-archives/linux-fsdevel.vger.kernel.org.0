Return-Path: <linux-fsdevel+bounces-48569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0228BAB110C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CF44C3BB8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6560928F51C;
	Fri,  9 May 2025 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reAYokh+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666328D834
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787555; cv=none; b=YGlodtDezemjosoWZWZNS+gZlKYJQZQJCYkEtt4L7r1zXeEIiWfKG6XYjxYdps8n38Gx8+DYbrJFmGUSr9pauuwFvMhrmgnsS0P6u+X0VUdAmfvb4eOX6vEGXUXJt8CA7koDUg1tdwKYCpb/6kXv9mC+7WElYKPc05hY4gxuaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787555; c=relaxed/simple;
	bh=9fmzDsJ5stVSUuLVALMfQJWh/K1lMrlOQQ3PuuHd20U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Elr2pVN/TJ3q667myumYv/Ij5CbJ5DO5hNUt+ISQaISVidX4LIvkYLY/hJLjCCR9D195a92xK7fMVALDwOJCHeRt3BcoUn4cJ8OACML6ce4QmzCw+HkGgJGbJij8L1MaNR3852kUnCld3rWQ2FiCSbDVYpB0hj91lH2B15jsqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reAYokh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AC5C4CEE4;
	Fri,  9 May 2025 10:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746787554;
	bh=9fmzDsJ5stVSUuLVALMfQJWh/K1lMrlOQQ3PuuHd20U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=reAYokh+eWQAlmRKtdWVkybo+18GE9G8I3v8mc3tF7SxSK613uKCHloLWi44nQE13
	 65frBRLBTPcuVoRhn2XeUSUaFiSOWVC07yYFiz5zLG+lV8Hy3fRuOq2KnJ0vGaactx
	 k+WxebbPjR0asGSjqo+aEnZvTAhNNu/XwY9hQ1Hwgiq+6bVQ+bKfEwEE9AZrVldIUR
	 w+KFFwb3X5K/3XDAGZqs8oBtipFQ5oEGn3nH5ZSPhGfa3IybCPEGaXjXLINWOOj/eB
	 TUpI8EkwM9LqGIKd4bF/SG/6qeBSCdi7KEcbNirfmgTB19RLaIoDvDqJv93lY9ErrC
	 Xg0V8mtrLHXjQ==
Date: Fri, 9 May 2025 12:45:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH][CFT][RFC] clone_mnt(): simplify the propagation-related
 logics
Message-ID: <20250509-sorgenfrei-vierkantholz-6def7014e157@brauner>
References: <20250507211523.GW2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507211523.GW2023217@ZenIV>

On Wed, May 07, 2025 at 10:15:23PM +0100, Al Viro wrote:
> [
> Help with testing and review would be very welcome; it does survive
> xfstests and ltp.  No visible regressions on kselftests either.
> IIRC, Christian mentioned some bunch of mount-related regression
> tests somewhere; was that a part of kselftests, or is it something
> separate?

I've made them all part of:

tools/testing/selftests/mount_setattr/

So just run mount_setattr_test that should excercise most of the
functionality.

In addition simple clone LTP, compile and do:

sudo ./kirk -f ltp -r fs_perms_simple fs_bind

The crucial part is "fs_bind" which should excercise a slew of mount
propagation tests I always run.

> ]
> 
> The underlying rules are simple:
> 	* MNT_SHARED should be set iff ->mnt_group_id of new mount ends up
> non-zero.
> 	* mounts should be on the same ->mnt_share cyclic list iff they have
> the same non-zero ->mnt_group_id value.
> 	* CL_PRIVATE is mutually exclusive with MNT_SHARED, MNT_SLAVE,
> MNT_SHARED_TO_SLAVE and MNT_EXPIRE; the whole point of that thing is to
> get a clone of old mount that would *not* be on any namespace-related
> lists.
> 
> The above allows to make the logics more straightforward; what's more,
> it makes the proof that invariants are maintained much simpler.
> The variant in mainline is safe (aside of a very narrow race with
> unsafe modification of mnt_flags right after we had the mount exposed
> in superblock's ->s_mounts; theoretically it can race with ro remount
> of the original, but it's not easy to hit), but proof of its correctness
> is really unpleasant.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>

