Return-Path: <linux-fsdevel+bounces-25257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 689DD94A528
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136F11F23799
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A611D6DC3;
	Wed,  7 Aug 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3NI6b4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AF51CB33A;
	Wed,  7 Aug 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025429; cv=none; b=UbfoOs0xV3xFx7aIspQtyhJ3ObqgdyKkBN5n7z19z8IW5cNzwxP9MbUll4LG8576kRtCVravffUc6icDFN+iLrjY5QXHZo41TvF5roJvyRwpxpycB+mxIOVkpJ6GgBTnqgbIZWritXMCBXMcLLZ//UqfeYgbEegLE8828Z4t42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025429; c=relaxed/simple;
	bh=eBc8BK6TF2PeBiD3vbcn930TmC98UXZiLj/lgQVZk8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAHGfPf1l6xFacnGACxw/e72FoYisDGXzg3BKgrhRAzHr7TVQt7y/eTu3n4rSJpd3c4NIgWiT6woyQnHT93EN7zF2HoFzTdMc53MiYHSWkNeIUDBniJF8F8+GbsSXjs5VMPgPUx1a9VJVO2xsqhb94AOIY3tiYTT7ZfYKB5UFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3NI6b4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26E1C32782;
	Wed,  7 Aug 2024 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723025429;
	bh=eBc8BK6TF2PeBiD3vbcn930TmC98UXZiLj/lgQVZk8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3NI6b4TjqIS2p/fGCEiCrezINlzvUX+cJko6yRAjJRWijiDoHvZ8wipJHJj5gLh/
	 5/zZKJWgA5QK0GW1uOrCa0tTiP3g3H4brdbuz7eydtvQwXpFoDzfUfKVXoTWslazjR
	 1PkKF+Gk7ku1BJ05SmuKBJU70tMdW3xbCGHgpFjfNMVKu++/5gFIwUfx2t/usYYYsc
	 pjSwDlS5NSEoupr0oIlJEzGRsVMlxWo/zK7DUy5OYDGyOdyjtLqYVpGTVnhvfjAzlg
	 ygDLpJ2TbzGKDAiu2Hp0xU96wgb4mHEojsJOg8YGVlIDFJLhlqqwDW9mrj4W2QRErg
	 YQSbHOCVmCSgw==
Date: Wed, 7 Aug 2024 12:10:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 05/39] regularize emptiness checks in fini_module(2) and
 vfs_dedupe_file_range()
Message-ID: <20240807-referat-klischee-162c96b05177@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-5-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-5-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:15:51AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Currently all emptiness checks are done as fd_file(...) in boolean
> context (usually something like if (!fd_file(f))...); those will be
> taken care of later.
> 
> However, there's a couple of places where we do those checks as
> 'store fd_file(...) into a variable, then check if this variable is
> NULL' and those are harder to spot.
> 
> Get rid of those now.
> 
> use fd_empty() instead of extracting file and then checking it for NULL.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

