Return-Path: <linux-fsdevel+bounces-18077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EDF8B5351
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 10:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7D75281A11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FA917C60;
	Mon, 29 Apr 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3xivcoW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DFE179BC;
	Mon, 29 Apr 2024 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380011; cv=none; b=E7aSMKRJFA/4iohVjbh7V4k1pE9G+bUyN03vNDQvGLGn5MCc38pZYmK5stUGQJQwIiJaCkA6p2s1e4NOcB9jSzzNQeyRRjaqcywfpf+3A8oYMZNAII//KKYEKb0bZMjHANREUM94BZQu+XCQC56LvnNY0MPMMwlvABDkiIHufHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380011; c=relaxed/simple;
	bh=6Z/FOrE5y0vpMmnOecP6tJYXEgDC2DlRbdDNduB1CXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V81lK8Zx0oUNlFJsX6FuYcCcRcQ/1cCBD0G8Zu20IXK3x2B3cjPSvNQPKphX5y6TUqCIpUWugDVq1NU54+H7BE/NRjGsgvZoV5788MSiffXyWBpf8xOKk2Rxe0spfWuONAb4QlbHX38ujqSd8FkmOIVxYwDMDYUJ/kv57Mww8sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3xivcoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A938C4AF18;
	Mon, 29 Apr 2024 08:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714380010;
	bh=6Z/FOrE5y0vpMmnOecP6tJYXEgDC2DlRbdDNduB1CXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3xivcoWvUS6wEgShGWL5tawiSJL1YV2sq40Ap//FVW6ehlxnpVYk2PDzIOQFPA7s
	 1oNXtHM/G5Nqb2CyNDBI4knC+hCDHfoNla07mNhYFB1V/hJLE8E82UA0kU4ir5STfL
	 8wThGESRcp1e9UPrUGCvL4hdgMI418RmtIeXnVqf/mDxow77uXN5zgz+J70C92eRDj
	 vaQs3zvbVtQfs/R1PtinHfdC9q2EeYADaNaht2GV7AvwA+pjnBWFW+mGj7T18M/hE0
	 1fhteP8mKX0m9v4idZLakF/NpqOEFizeJInRdXF2zuFqgv7wG9w8RDxA8KPKX0d5Iy
	 HbWe/UmzTJ/4A==
Date: Mon, 29 Apr 2024 10:40:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/7] swsusp: don't bother with setting block size
Message-ID: <20240429-rotwein-hemmschwelle-31f8e9b32299@brauner>
References: <20240427210920.GR2118490@ZenIV>
 <20240427211156.GE1495312@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240427211156.GE1495312@ZenIV>

On Sat, Apr 27, 2024 at 10:11:56PM +0100, Al Viro wrote:
> same as with the swap...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

