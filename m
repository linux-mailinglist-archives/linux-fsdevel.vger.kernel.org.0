Return-Path: <linux-fsdevel+bounces-51691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 922CFADA326
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 21:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4346188FD68
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 19:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C460527D760;
	Sun, 15 Jun 2025 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Miip8bYM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05CA82C60
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jun 2025 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750015251; cv=none; b=s1rpdAZ3niZv2MLKiX2i1LwAAl5zRajbh8Hb10wqyLtCq1OVbS8BznKCBw3psmE32va8+rSHbPAfruC8AYEDrVp6g2YzYuxXWdBCe5DNOFWZc/euOZ+1DE8JcxbHJ5WrELd7NasB4uC/s52HwmtSXAR3DLT/Of5RYs7TO0L524k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750015251; c=relaxed/simple;
	bh=Hy7UGrEYV8dvlu3TyM7TIqB0QE7xVRRnwK0LdghV0yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juKBOe5BU29jqniY+58xdUbu5isaXeCFIn0NQ72fJpi9yEOjc1186OyPlx2obPvgDqQ2kiTDr0erxeTitzkJj04RGNi4t1zea0R2MMv+OA4m76qesMdMnkVAByA+gTQROcO1NJBkzhGUTrbmkHY4OgFqowC/kVT3IzHukiuRV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Miip8bYM; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 15 Jun 2025 15:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750015236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MKDp9IiF/iWKE7Om3zUoXR+MosPHV4Kwr2V25hWDfpY=;
	b=Miip8bYMUZbnTd5ND4RcI3mOLulD57OF4hCfngX8VnOMHqG1GT++ZLdjWKSX3nlXPjcJ13
	SY28vMi+7hrUZWl+9/d1aPuyCyzMr+n0uDNnV8rrLrn96csgVXZmuc64cEPazEXD7qTacC
	a4dVvipFi0vBbSvGyY7M3LPsnszA2YY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3] ovl: support layers on case-folding capable
 filesystems
Message-ID: <oxmvu3v6a3r4ca26b4dhsx45vuulltbke742zna3rrinxc7qxb@kinu65dlrv3f>
References: <20250602171702.1941891-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602171702.1941891-1-amir73il@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 02, 2025 at 07:17:02PM +0200, Amir Goldstein wrote:
> Case folding is often applied to subtrees and not on an entire
> filesystem.
> 
> Disallowing layers from filesystems that support case folding is over
> limiting.
> 
> Replace the rule that case-folding capable are not allowed as layers
> with a rule that case folded directories are not allowed in a merged
> directory stack.
> 
> Should case folding be enabled on an underlying directory while
> overlayfs is mounted the outcome is generally undefined.
> 
> Specifically in ovl_lookup(), we check the base underlying directory
> and fail with -ESTALE and write a warning to kmsg if an underlying
> directory case folding is enabled.
> 
> Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> Link: https://lore.kernel.org/linux-fsdevel/20250520051600.1903319-1-kent.overstreet@linux.dev/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Miklos,
> 
> This is my solution to Kent's request to allow overlayfs mount on
> bcachefs subtrees that do not have casefolding enabled, while other
> subtrees do have casefolding enabled.
> 
> I have written a test to cover the change of behavior [1].
> This test does not run on old kernel's where the mount always fails
> with casefold capable layers.
> 
> Let me know what you think.
> 
> Kent,
> 
> I have tested this on ext4.
> Please test on bcachefs.

Where are we at with getting this in? I've got users who keep asking, so
hoping we can get it backported to 6.15

