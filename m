Return-Path: <linux-fsdevel+bounces-48578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B855BAB1163
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E33189A145
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B59E28E594;
	Fri,  9 May 2025 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB8VVCO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50E13C816
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788536; cv=none; b=dLDV7Lq3bnRJmAaJDLbmRDM0l8SfIOiJ5fggyMIfoJ/e9dM4pIYfOqeroyVA/2fmKDArj2H3DgzeiSLlrWVAX+l3xv/9M9t1sTMvu4BJqdIO7vpYu46l3VAXKGLu5x4g0gNtCDprxQTdX+MvQHma1sE6p54kUOdjt2QDY4KRDUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788536; c=relaxed/simple;
	bh=uDbzQ9Q3JzgncP9zmWxvCKf485wOOFQsRtj8G+Lvde4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWaSy4Pua5YNJ0aliuVKEt1LAFmTj+UowsU/VazMPow4tSFMiZCVTjqymPKkptIJfV3kEod5UDPRoM84qKXaYbhFwZwzDhBBJNwQVKLN9EycJ0/WDdqpEE+lXUw1VkPyA7xu78qe3FSBi1x04ZWs0wsNIIeBQqXQtLeucDntTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB8VVCO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E94C4CEE4;
	Fri,  9 May 2025 11:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746788534;
	bh=uDbzQ9Q3JzgncP9zmWxvCKf485wOOFQsRtj8G+Lvde4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mB8VVCO9qxMi4AWA6qETQi16xb1kHG58BvDx2WJnL8hbuV2Qk+JiQsXS3CDffoTc0
	 Z5m38fnYxk4+u+59n8tup1o5/bTBlTPy44RAvvPnBiqR/p9mJS1pMJsuNqFoEcypbJ
	 JrKwvl/bFp1JtDfHT/rc0uOou77xIQuBCaB54V7su3sowtbzKkBZfRwp1N/T9J0dZJ
	 zX/wnfjgiDFZUFf62Ae+IQoCbF8ZCpSMvVqEJjgMf8j4F2Pg9tSG5D5lN/r4wXPMsu
	 YsEkOephkQm/6zqDJVWKc7K95UgTJtlQK1RRqSzvtsG9wN3yTzSnWTcqcw4WCRMhoB
	 sKbxnSoamDjHQ==
Date: Fri, 9 May 2025 13:02:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/4] do_move_mount(): don't leak MNTNS_PROPAGATING on
 failures
Message-ID: <20250509-einfliegen-lektion-62715d8b42ef@brauner>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
 <20250508195916.GC2023217@ZenIV>
 <20250508200211.GF2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508200211.GF2023217@ZenIV>

On Thu, May 08, 2025 at 09:02:11PM +0100, Al Viro wrote:
> as it is, a failed move_mount(2) from anon namespace breaks
> all further propagation into that namespace, including normal
> mounts in non-anon namespaces that would otherwise propagate
> there.
> 
> Fixes: 064fe6e233e8 ("mount: handle mount propagation for detached mount trees")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Thanks!
Reviewed-by: Christian Brauner <brauner@kernel.org>

