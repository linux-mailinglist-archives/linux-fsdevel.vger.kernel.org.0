Return-Path: <linux-fsdevel+bounces-13628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A969D872186
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5151C221B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91BF5C618;
	Tue,  5 Mar 2024 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/0nMbmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1078986AC2;
	Tue,  5 Mar 2024 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649239; cv=none; b=b6r5xlG5cgnNzP/QhDNQmKDQK5QHEw+A0Du5+4cFi+oyuZr1oGk87iPltMVLHaVrT5Y7hqL+/2eVwejuDs1ursVCUwCPfuOe+2C13yUjlVr5lvKEelc1pJndljRS+oscDbUL+XkWI1nlxhqWDZzoGuKnmrbCEE9mtgedKhGm+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649239; c=relaxed/simple;
	bh=eBiqSkWyhcWNjSZwXg5KFgXsg8vQMzr1zNnOysu8a2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bem73UcUUVH3lljhw/NJ0bq3+DfHDi4G8cGfS9sLh6TUivw8DFuu1vexg+BwqED0/DtTZKuDZ+QfgstRgGtabTegfH8oWXaK6d0F4WzE4jpTt7dlBcVsSQ0Iz/opKm2ONDR5Yv4eyN81wPmyIx81ucByEGviR/2l8nv5Mr8sK+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/0nMbmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED39C43390;
	Tue,  5 Mar 2024 14:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709649238;
	bh=eBiqSkWyhcWNjSZwXg5KFgXsg8vQMzr1zNnOysu8a2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/0nMbmGohSXfrmGLUjMCdBQKtS+6Mqgc/CybNiPKfef7dy3X5VTK4bBqHIXZH75B
	 v8evXrJUgaOTbPuAc5Pli+KFqPUyG4xBTsz+48TRzODfYRLCaSXR3434RSZpudsDnD
	 neV4Q4mXN9qGiIJaRS0BjIIm6dgpL7lRbN2FtjaZETUtVhp7iIeqSAknWpH5I2uCzW
	 BoYT2+Hs/Nh4aRYwRPwznbZOYjTe5W0r1LAmLMck1yHiz5wvufXZIR2+tg8h64p/24
	 XWI8e+u8QuknCVXQ0gF+fnVYBR7Iu5WcIk+mufKRa6/8OfRU2pdAOfI6U6EvbsdfuC
	 tv15LmvPhn0vA==
Date: Tue, 5 Mar 2024 08:33:57 -0600
From: Seth Forshee <sforshee@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] xattr: restrict vfs_getxattr_alloc() allocation size
Message-ID: <ZectVeZtw/EmfAUA@do-x1extreme>
References: <20240305-effekt-luftzug-51913178f6cd@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-effekt-luftzug-51913178f6cd@brauner>

On Tue, Mar 05, 2024 at 01:27:06PM +0100, Christian Brauner wrote:
> The vfs_getxattr_alloc() interface is a special-purpose in-kernel api
> that does a racy query-size+allocate-buffer+retrieve-data. It is used by
> EVM, IMA, and fscaps to retrieve xattrs. Recently, we've seen issues
> where 9p returned values that amount to allocating about 8000GB worth of
> memory (cf. [1]). That's now fixed in 9p. But vfs_getxattr_alloc() has
> no reason to allow getting xattr values that are larger than
> XATTR_MAX_SIZE as that's the limit we use for setting and getting xattr
> values and nothing currently goes beyond that limit afaict. Let it check
> for that and reject requests that are larger than that.
> 
> Link: https://lore.kernel.org/r/ZeXcQmHWcYvfCR93@do-x1extreme [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Makes sense.

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>

