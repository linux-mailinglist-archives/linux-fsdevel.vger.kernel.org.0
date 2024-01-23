Return-Path: <linux-fsdevel+bounces-8598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BDE8392B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34AE1C238AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2747D5FEE5;
	Tue, 23 Jan 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK89aVGl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB851C3A;
	Tue, 23 Jan 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023812; cv=none; b=aJA1BVSztyWggxjVBOcJUmKnLRn7o+hk8WaRwJtJTMEoOMPOQruO44v7ra6IIn0ri8we5Z2A5JYgPqYR1/s4BsnI27i2h9hXPm38Dh++E6i9hb0dYSh13hQkrBzQgeMvR75cMhwa/KhLcRmPdsolb+nH2kz7lDXDhQAUIbzo8lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023812; c=relaxed/simple;
	bh=ni+H++b32vfegPdtL8QkxuZ4iXmva5ufBJv+Q+YyV24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1HA7Rh5dY6joIgiBD6roLBAJy+Z7gRjC3vTpEEPhWH1sM0ITxITHfO3/X26iRY+yQcXOKGPtCccPqW/fPotTq1UXXkKSTi5k/Ajr8jdsrrMZqSvVpftDtxL/VAmuY/CpPoxfro/XTmvhgIvUHnCCPKZ2yAXBNoAuRF2rQiVpt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK89aVGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFB6C433C7;
	Tue, 23 Jan 2024 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706023812;
	bh=ni+H++b32vfegPdtL8QkxuZ4iXmva5ufBJv+Q+YyV24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lK89aVGlV14uKQ29sz2ltqCKK/zNAno9Ye/bSUoE0ObllarRTyht7KbOMqgagehTB
	 zU1/64YE1WgBaELl34GcYUEn6qatSgBLrheN9XS6L4PJJvfPxx6CUfUgbR7aG2EgvH
	 /SHl6G6lNSYWWxdpy7xPmWb2pAvRvCEWyDhm6B1Yr9QLDR+JFFyjmDu5XRfR9HX/4N
	 uWKW/XewgamAXkzzYPApSKaKK/OkZnwNQEnAKTksPLk3ou+yPpIVTrfc0LUDfXODd4
	 pyXumwRwmYxyCWMOw/NWtd0wK6rNRGpviMGNg4ytzE4PPzkel+Ty7iD5gYsPXDhpqC
	 Z1soaoxkZgtUQ==
Date: Tue, 23 Jan 2024 16:30:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-aio@kvack.org, 
	linux-fsdevel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 37/82] aio: Refactor intentional wrap-around test
Message-ID: <20240123-zerzausen-ahnen-02455c8a91bc@brauner>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-37-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-37-keescook@chromium.org>

On Mon, Jan 22, 2024 at 04:27:12PM -0800, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Benjamin LaHaise <bcrl@kvack.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-aio@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

What's the plan?
Merge the generic infrastructure and we can pick the individual patches?

