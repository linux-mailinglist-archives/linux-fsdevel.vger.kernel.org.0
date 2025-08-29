Return-Path: <linux-fsdevel+bounces-59636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340F9B3B7DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9623A0244D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AC71C5D72;
	Fri, 29 Aug 2025 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSxSuYMD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0BE28369A
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461402; cv=none; b=YuGg38bIuL335Wd9QJDLKHzMO6lkdnitvgBwXnRiIRJnti6DlJRPMHlOpyRFw2JpVTIkyBMowdAMe+Q/TrWun7gkEeF+VAwAu1jDGWkuHYQ/oZZkUQQQNlQuBAXWXKlIY5rnhQfJjV9qCeihinhehsaFlu5tjElJNhZjYNu/3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461402; c=relaxed/simple;
	bh=PNVkxJZ0LIsx52NvzpWv5gCOClFPo4Z+9wAxcSQ0oMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3N/odlWZ/z9FkFGqZju2bl/AXWprcuUapIXSPDzSztshjUrrdP+yGnzE2kGs6h3s1KB6WmFoG3kY9uRgipT3oE/UQpk5V6UyAYo2ga8PeiSQGKOQD1C0cOxsnrbDWQyM+5hsoNU6wXd93oaTKXDP6buMS21Pl3NHuWPCCB7aRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSxSuYMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8BEC4CEF0;
	Fri, 29 Aug 2025 09:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756461401;
	bh=PNVkxJZ0LIsx52NvzpWv5gCOClFPo4Z+9wAxcSQ0oMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSxSuYMDI0e0t6gNIwQ22ToRZ1VeN6UdCCz6SJgSWURxpqnsgxU5LIoRxEUp0fdtn
	 RKC6+tvG6EgVL88/d0FLb4nZtCGVnWEfll1dfaI4C82F6nz3aSJ2u23dDUNKVFiPtz
	 ofgk19rsgbQ283984Fk9e1cKQy6vKnhwbFx0I2R9pXZZFcsaCTe3r6+CsVW/RCzscE
	 TK8x6T7YRQ9DmvyP3P+D42pv7EHruN2cbGX5NHIcIZoXqV5HzrZ+OrL7NSb4lWn1V2
	 OTIfYCNbHZGSJO5E14TMrWGNTQdO5XjjDYyl3/FQp8TpXdxuecw1SRM0BloFNImZEp
	 zomhHFrWnKUdQ==
Date: Fri, 29 Aug 2025 11:56:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 57/63] copy_mnt_ns(): use the regular mechanism for
 freeing empty mnt_ns on failure
Message-ID: <20250829-waldrand-nehmt-78713d3c5fb0@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-57-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-57-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:08:00AM +0100, Al Viro wrote:
> Now that free_mnt_ns() works prior to mnt_ns_tree_add(), there's no need for
> an open-coded analogue free_mnt_ns() there - yes, we do avoid one call_rcu()
> use per failing call of clone() or unshare(), if they fail due to OOM in that
> particular spot, but it's not really worth bothering.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

