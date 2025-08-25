Return-Path: <linux-fsdevel+bounces-59081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B52B341CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7665A7B669E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C795298CBE;
	Mon, 25 Aug 2025 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uah0WCHc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE82ED16C
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129432; cv=none; b=V9vG58f6/ajmTL0mQuwd98+I3LRivtgDmm4IXRqGc7F3MeQpBEMxL8vvVl27UTpoAwukwG3h9RiuqauJuwVodzt5FLe1WpXLyyBneASKwiez9W58P2BELYnLp7fIs7kKCoS1E1NSGnm7uUb9Xpl8Rmr7Wr/NYRhOvAROxejd3Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129432; c=relaxed/simple;
	bh=NM6kgoLuDsyk+cZwlhjt3gTcQCxup8oPxRgk4yIugPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzQ0x7ZlnWYjl9TLWXG9ZuOgEL7ss8Uk9pYZDaKKyC7ruchS0jm41vNJTbvM+biuieiOis3e2um0JbTh6xrIYUBXaLaIL6qwh7Wq5zASLP11CBQYPavK2Tdj2S0BApowB6Dj74jndW6Uzl4yUPFu2dTFSwgQdtXJIZoFxmHKW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uah0WCHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23704C116D0;
	Mon, 25 Aug 2025 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756129432;
	bh=NM6kgoLuDsyk+cZwlhjt3gTcQCxup8oPxRgk4yIugPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uah0WCHc5ZavruRuvvWjks6bat1BZgMvfWoBJ0gYFfGQC8cc/JzOqRcF5CwRKOz9A
	 S8MVuKfGotqWLIVb0YKforYyzG+5Y7TSTCzsMJgdBaryNcvfNEpttig8ZiBeP2iPoR
	 9kPrL/vtutn5KSjpsEsTfKce6+Q6WJE8IWItqf0ZEkPMDmrC+YP4g7TPoR1cMBKK+s
	 ZzADiJrIQrDVlDnq+A4FMLDVOf14GU30W+5/FkPq5TdzZCKfkUu0am0FYhxsUjCuRT
	 ZhK6qDGDokC1O0hpu/4m65r5kIC5Lm9mSqsUCFoLKkG0hTlHxZCCbNGReDyGBSi/yc
	 grEzqaMXG2+1A==
Date: Mon, 25 Aug 2025 15:43:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 31/52] pivot_root(2): use old_mp.mp->m_dentry instead of
 old.dentry
Message-ID: <20250825-erfanden-anwandlungen-6c4715ea641a@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-31-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-31-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:34AM +0100, Al Viro wrote:
> That kills the last place where callers of lock_mount(path, &mp)
> used path->dentry.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

