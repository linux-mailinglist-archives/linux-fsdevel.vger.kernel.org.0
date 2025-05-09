Return-Path: <linux-fsdevel+bounces-48579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F071EAB1166
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A6F4C4B3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 11:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA70328D82F;
	Fri,  9 May 2025 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwhuS+tl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E613C816
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788554; cv=none; b=mXDbRKAi6Nef5QUeHrdwKlTdFrB8/Ygz3wT306DAMfByGbw3FWa3kYFHzc/K5U/7MGz8+VlH0dhDnPJhTkAj8/FiT70W261sichxp8rP6CfHMb/A+6PXL8ukWVMiznV5FNWbphv/4Cf8JEwSCL3AcsMVELwdwgCKT0KJE0kYnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788554; c=relaxed/simple;
	bh=sXmqYWAUF/ZLuu17zP+oFt79udurOX9/WrZ8LKykW1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4elIE/Ot8xIb1xu/6pF6CsREfYBiktCLZd0HTfJ8jrv3LPBYzyQMk1VPnXjjdtzRTv7Bvi6QYQJHmnAzrCYPnZ8QOoawEeim8jHJ2JChm2yJYtERa8sfljMFM+oHN6xRyo4eEUwdZhT79m2bZhYBMqcQg/wZVJOpK+7ZnS8QWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwhuS+tl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0B7C4CEE4;
	Fri,  9 May 2025 11:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746788553;
	bh=sXmqYWAUF/ZLuu17zP+oFt79udurOX9/WrZ8LKykW1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwhuS+tl+Paw+ekz5ThF+Ju6DeT9m4anqw1IW74UshjZgGVloQMTtFMRKsu4rzNYS
	 EyerDKiY4/iOfuxBAx5ykWxxmvCZzwh12v1oIkpdDEbo1zICvWupwpogUmyQHTJdRA
	 lidvWYi6mHBtKvxx+T5twMcdfEnvq6jeGhNj/4aI44DMpjexcstdrUh2qgnPz64eAT
	 y4UBWNp8vFAs07hQX1JB7IztFJEG3JvvFJAtcPcC6xsBriAfu3rDCq5kvY1ZJpWcWB
	 gNwih0cNpZgI363RF601EeUzJIeIGr8Qk6wtdRVlAElN1kPJbCsqfCHv7qWiRg2S7g
	 Vrwv52+6jUu5Q==
Date: Fri, 9 May 2025 13:02:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/4] do_umount(): add missing barrier before refcount
 checks in sync case
Message-ID: <20250509-amtlich-wildkatzen-9c3efd4b44c5@brauner>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
 <20250508195916.GC2023217@ZenIV>
 <20250508200137.GE2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508200137.GE2023217@ZenIV>

On Thu, May 08, 2025 at 09:01:37PM +0100, Al Viro wrote:
> do_umount() analogue of the race fixed in 119e1ef80ecf "fix
> __legitimize_mnt()/mntput() race".  Here we want to make sure that
> if __legitimize_mnt() doesn't notice our lock_mount_hash(), we will
> notice their refcount increment.  Harder to hit than mntput_no_expire()
> one, fortunately, and consequences are milder (sync umount acting
> like umount -l on a rare race with RCU pathwalk hitting at just the
> wrong time instead of use-after-free galore mntput_no_expire()
> counterpart used to be hit).  Still a bug...
> 
> Fixes: 48a066e72d97 ("RCU'd vfsmounts")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Thanks!
Reviewed-by: Christian Brauner <brauner@kernel.org>

