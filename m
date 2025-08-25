Return-Path: <linux-fsdevel+bounces-59080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95628B34114
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1614B7B4170
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5006A2797AA;
	Mon, 25 Aug 2025 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRmmqqfA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE886279357
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129411; cv=none; b=FuY4/zPbSsu6o5MYrkRTzT5V+PBagw4i54NNNArN8JDgxgeO03o5X0qHAd2orJPcV0CLXdm/fdrmPeqs0kUbySTv0cB77oMbmgqW9RvJCgaDPDBahJRn4ta15AMH389I91PKj7otT6oLjfW6sEiF35NDMVIzyebCRVZ4sEUc3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129411; c=relaxed/simple;
	bh=lCGPlwwWTx1A8b0GgSRaccZ41u4x5WSE2TMN/gcTNZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfxEoulWzupGe0PXcU2YpwrY82t8ZntZ76hDoYPbApXyloqAtCqCwZKIfFvkNZhxz8jV2ynpRsf1MZub6PJmQwaA7Mz2X39PsI+/U+0WS8vYdWcYODy3nvG7i31fSPMm8RttAgODHwPr4MLjGxK9vtaFGUN1AOxWXebQLbWrSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRmmqqfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4BEC4CEED;
	Mon, 25 Aug 2025 13:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756129410;
	bh=lCGPlwwWTx1A8b0GgSRaccZ41u4x5WSE2TMN/gcTNZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRmmqqfAW1IQygDFtCO8v1aoUZeALeFwWd0o1nhgVZb6OcFImD69Uc/PL5qhNwLP8
	 2qFlldq57Tgh4Fjpw7J/islN7JPeRYnQA/0RS7SgwBzUHqlFCFIgwzbDov3aidfWhd
	 1a0UDf55GovPd1dE46eAjcqSqK4HoZTP/ANVoKsSoOPx+UaG6aedI9OU1vaesYmHIF
	 c75ukb5u8sb0Dpz73pYET81xwa2P8JhV4vftDI4XsuHOXnfe97ZiW0AufFmA4PaPTv
	 DS/FtoX4NplVsIQDO7G9QUIMrv+LZ3NcWOd75Qw/RehLtZwiujS8zya7ktpQkT/syE
	 4Z/CbNNDp6ikQ==
Date: Mon, 25 Aug 2025 15:43:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 35/52] constify check_mnt()
Message-ID: <20250825-landen-anschaffen-c1e81ed9b7f0@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-35-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-35-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:38AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

