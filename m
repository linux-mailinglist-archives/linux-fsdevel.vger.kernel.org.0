Return-Path: <linux-fsdevel+bounces-68272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 804A0C57C5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C345344364
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489A221FCF;
	Thu, 13 Nov 2025 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fch/N+v2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271015ADB4;
	Thu, 13 Nov 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041305; cv=none; b=s5WWm+HCTEyCHa4Y6LHVpAPE8Z1qgD+qHAB7J1UoX18dlHN752eh38Rodwm5Q0sQjF0LVGuG7Vz7GGpX30dq+udYuOseXoLHhAb0hVljZmvcMmVcrFgcob2xRugxTP3Rff1UN7+1MW3Sx3P9AvY1lrSMY5FgooRM0VNaNeG+Sc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041305; c=relaxed/simple;
	bh=znnVbV3UektVp6foJ7zrgVaXmmfVsxVggqS+vhasYR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrSwfv8E/yTub4+/kdZXGpjeyJk/QRI7N+5k6xnMUM6MKsyMLehm7BsPnV05SZYeUAygtt5BCsUyaIxx48V8CYb4fDLoBLI61G3JGwsXn/h52Y9GvZSPn7XrUDV98nkF58lhlIT7/Z7hssmqhfFUM3lGQeL75n0R/kb5VdmIU7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fch/N+v2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536D4C16AAE;
	Thu, 13 Nov 2025 13:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763041305;
	bh=znnVbV3UektVp6foJ7zrgVaXmmfVsxVggqS+vhasYR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fch/N+v2XqPXx2JAds3rEVbTkYs0Ws3bZlTL1kN0VkUaosJK8WnQKxb2jr4NVfF54
	 1b0Dxduvskrd3IJ1ZqyEKFeNpshULclPIcw32DkmMWa4D1kDog6xWWTuJpxZqVJ1eB
	 q9q596ZZ4miUvk6rKpRrChMARNMVVMcXIzsvPznmOYzHjsjYA16MKVFAzQ4cFJ0UZU
	 SM0PHlWPRfdyuXaLzO1oOm7+hmqOQMHmiWgZtypSGFPEKPcGkbRsxGhfxB1qYNi1+3
	 YGBEjFe3ULU9MUSdHy1cX72YJ8CZ/jt1SeGGbRmnV3bwV0MBrnkf6Dtm0gUyOlwKQC
	 4OrirkuNJxGlw==
Date: Thu, 13 Nov 2025 14:41:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 37/42] ovl: refactor ovl_lookup()
Message-ID: <20251113-wildpark-treue-5ccabb7eb7e2@brauner>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
 <20251113-work-ovl-cred-guard-v1-37-fa9887f17061@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113-work-ovl-cred-guard-v1-37-fa9887f17061@kernel.org>

On Thu, Nov 13, 2025 at 02:01:57PM +0100, Christian Brauner wrote:
> Split the core into a separate helper in preparation of converting the
> caller to the scoped ovl cred guard.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---

This has a bug. I need to resend.

