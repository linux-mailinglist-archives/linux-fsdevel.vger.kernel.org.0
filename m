Return-Path: <linux-fsdevel+bounces-51288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8422AD5322
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1B63B257F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D4D283FD9;
	Wed, 11 Jun 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZj4zwrj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90902E6132
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639209; cv=none; b=po2nIqQeu7kliFwn8tcGjjKd7YwvKn4w5RxoZrAfJG+zBiggASslVI5y3s+DkJVyus7JC46A/hnPNGCpM0XBgY9lHWr8p/LdLB2pcjX55dmxMqvdqSKwLfVizLs9lVPsqdhwHKSqyvq2x1LLowH1PD5g7iI4S1VDOF0MvfxggR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639209; c=relaxed/simple;
	bh=pSJpNCCzEBYxwGwX0QSyX4udpEWzr4HRt1kTKxg3Vco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnF840uDxxsebhqI8buD7XzpssNcCHKAQeMYhu4Mq3r7B2zdU4KbCy2CugIE26J5jr8yVyEeJHzM2iYyZDm1BLRrvsxvFWLorUTVxGTjjcSMLjrE0zPDaMUw3e8kk26iFfdorpGGfX9DNghqREto3V9Ud/frSap7YMXtIbYsZhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZj4zwrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1D0C4CEEE;
	Wed, 11 Jun 2025 10:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639209;
	bh=pSJpNCCzEBYxwGwX0QSyX4udpEWzr4HRt1kTKxg3Vco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZj4zwrjKcg+uPkdocI8w8p6LQrsE3NmnxgEsUVzrxYLqdazsN65y+I8cu8T58yT+
	 0+0MgKFxsdogQFZthOk59CbpWoz1+3G1/dQWTbOsgzvnDDW60EQbgzkZbxyMgJMp9C
	 vYkPxsFrhgpeVYJj9SbH2hsLuYsRDbjdbhbnqtuq20JLeZtjTw2Gg9yKdjcEu9mMll
	 wcuvmXSyroi/gP54yZLMlS4akQg413ifa6CsastRMr5xEYvx7fox0PCyE8all+6/Sz
	 ZdnGFVFGjI0FyWISbFPKFGwIz3BGl6d25uXsgL8kMQ6MfKFIj9OuPqQS1zLKSpJXY+
	 vrk6WkhNMl2Ng==
Date: Wed, 11 Jun 2025 12:53:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 09/26] clone_mnt(): simplify the propagation-related
 logics
Message-ID: <20250611-pochen-erdumlaufbahn-c052360503dd@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-9-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-9-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:31AM +0100, Al Viro wrote:
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

Reviewed-by: Christian Brauner <brauner@kernel.org>

