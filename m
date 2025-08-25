Return-Path: <linux-fsdevel+bounces-59033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B3FB33FB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A962B7B423B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB42E14B977;
	Mon, 25 Aug 2025 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUuBJkDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1756872639
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125425; cv=none; b=ILVTqO+PCF6TIsS4BIBy0GrWxmQKlH0+a/2zv635/yJ/NANKhtsRQwSpTf9Xhc66kMe+eCbmLS5cVwH6E56iQ0wDvqVYr9F5O3i8oKqEgU39u0yv3KbPuTSXgLuDH1+rXms7ozk0R+CsbrvyT6lw711HOK+qco2lvIuNvWh1Jh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125425; c=relaxed/simple;
	bh=uAOByhV5mmyL5CMpWhI8ZxRgOs+UWbUUm6v3vpY+fTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSaWadr5g0yza+eTuJp2nIMF4N4FhomNJs6VO+516aOmw29F4lN5IVPNZEqbI9yPeAJhJcJSDFZj3upf1rxqkerJJhZn0kFBeGseiudNOIZK858t/C//+XMYpg/sL4Wo4n+AMVmqA80N8v1FIKlNPk/pwEq6+2i0TFcO8eyuBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUuBJkDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629ADC4CEED;
	Mon, 25 Aug 2025 12:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756125424;
	bh=uAOByhV5mmyL5CMpWhI8ZxRgOs+UWbUUm6v3vpY+fTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUuBJkDVK3XKz/qgFlEO6jZntVcTN2YbWfOZg06VvaHmKTfHNuMerSgCDfxXhqAUq
	 WL6BP4NaCZUAJ7W+zfOP9Fm/p1wr5dZt8tIKlVoRF41yE2oluCrevtXK16Gjebof7Q
	 60O2Y1LdA4BEE/jfygM6krlNmmrgiLVTbt1xxJGkl42yIV8w263Q+D/UYusKzqzJnX
	 gX1CC+5aJG3mWt/ybuAbah6MizwTDkMLe8+uvUwV0kr2xaO72gcCAMKozKuA/YvViE
	 7uTTjqAw2c40kCUO3Fgwy9Iej7nnNLGfMhVmtYRfd2PUVp+5SrPq6XGTiliXM2v/dU
	 QeURGUx5fRaYA==
Date: Mon, 25 Aug 2025 14:37:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 08/52] mark_mounts_for_expiry(): use guards
Message-ID: <20250825-rausspringen-instinkt-437192371cda@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-8-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-8-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:11AM +0100, Al Viro wrote:
> Clean fit; guards can't be weaker due to umount_tree() calls.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

