Return-Path: <linux-fsdevel+bounces-59814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91195B3E20E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493C0201A83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243DF32144E;
	Mon,  1 Sep 2025 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2rMX7TH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834CF31CA78
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756727459; cv=none; b=QDPpUwPsBFpFlvGVPnRSb0ATXba5kaVNHCW+e3G5v9DngjbyaDr0uyyzjq5lYMoo6fFPn7k6UHznXmkf17pJYFUpldHUJpgeARzrt3jkZ7xk9CXZyYuhkCDieUihRdQGtbOr3C03AbwCdk0CNbl7hvW5XjRLXkF6PMPo7ishtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756727459; c=relaxed/simple;
	bh=oi6vWM834EhJKdHUopLs9kOJtVawWQk+BH5h5G4l9Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYLfsxyPWlXT3ujW3K9ZJC+iG/0aDfBZXGhwiprDMzRlM0lhTE3NoU2DeZST+9HAapmQxAllrGcSjoCVz8wUbnuhL8+t3Ec6OXlpBPkfB+DfcxVo1q8lH3GxZ/bobqZwZVp+4lAh1iHSK21fuJv9kyzpItbQ45kDDK3O2U/Qy8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2rMX7TH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AD6C4CEF0;
	Mon,  1 Sep 2025 11:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756727459;
	bh=oi6vWM834EhJKdHUopLs9kOJtVawWQk+BH5h5G4l9Ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f2rMX7THaMI7aLChl664h3quH0oSuCEeNoUNq1wxwVwCUlKfSl6mDRhSh/TlAo198
	 HeN2sGGyYehObdjpGwlBRtDh/MahFb7ZcP0l2xuzs/UbwqiwETBQYpE9GZV8nFeo39
	 L10vtwLgi5LQ+oHfysSolvTjogS+jTbKVuAdJpdL4rQqQQTrAaCTs5P2/EGkVfEW9h
	 nGgykMqDjuMOlqsL+pr/UQvDiVxyhPpEOqDpKQKGxLclstomCvLmDK1UR4Vo/qrJ/B
	 f4fUw5dCNwrafVYSsbben9l3PUKdFP06Dd946TlvxSRbrOkz0Mo/trDLAiQXjJtDNQ
	 Gdd8bRHwMSIWA==
Date: Mon, 1 Sep 2025 13:50:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 51/63] umount_tree(): take all victims out of
 propagation graph at once
Message-ID: <20250901-erlitt-zapfhahn-320c92f65b7e@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-51-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-51-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:54AM +0100, Al Viro wrote:
> For each removed mount we need to calculate where the slaves will end up.
> To avoid duplicating that work, do it for all mounts to be removed
> at once, taking the mounts themselves out of propagation graph as
> we go, then do all transfers; the duplicate work on finding destinations
> is avoided since if we run into a mount that already had destination found,
> we don't need to trace the rest of the way.  That's guaranteed
> O(removed mounts) for finding destinations and removing from propagation
> graph and O(surviving mounts that have master removed) for transfers.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

