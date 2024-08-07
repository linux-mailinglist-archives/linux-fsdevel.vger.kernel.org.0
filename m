Return-Path: <linux-fsdevel+bounces-25281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605E894A60C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923461C225F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65AA1E4F16;
	Wed,  7 Aug 2024 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC/i43LY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F139C1DF690;
	Wed,  7 Aug 2024 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027404; cv=none; b=olOYo9DS1FxQrfHYGQWOsgEHbRy1vjyuz7uPtQi0RHXrmlsaBBAKa4uX7Ixb/2Bx89glYWopVxCGYdPKlbly6fdew3Tt5aOD7hfUTL80IzYHr1qvi7fAJF2a4l9T9b4L5frZiQMR4scevH3ogFmq31o6+iX46irLXH9+aPJKzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027404; c=relaxed/simple;
	bh=zOGeSIXWEn5qUY2HGYA0iGhZfpA+GlGsjsr2QBXSAnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iezkeTHnbO6QQdiMikT3l6Ibxlj2qdRZZ4TptEMD5rroJaIjq25K+jJVYQflC8SkGQ2GtwZ7PfAQphsdACcA6NQIgJ0lmEdN+gMH1znPZTtH7elu3WwyQmwMmlH7PHeS6umBE4L38mumTh7GBHTHS+l/SLt4G5DiFt9g+6nr2jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC/i43LY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DCEC32782;
	Wed,  7 Aug 2024 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027403;
	bh=zOGeSIXWEn5qUY2HGYA0iGhZfpA+GlGsjsr2QBXSAnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aC/i43LYEkC1iy+iDaPycTxBioYxlX4Ec9vdyliAui2JLWh1kZL2ANrt7v43BX4Yl
	 0qxPwAGnFoxYdnvt6biXokNLKEJPc38AwJBDqCJrRXrlgbt5EEx56p/dew+2wYMWji
	 PYH69/KE0pyw/BQDNDMIF1e3JFNwR41JoyjWzUpwWvsXoeDg9rQa2kmhqzw9gih4iQ
	 IjLsUdWZsX0vJ6x/O+cNya0aoc1gj4sd8vBcxdKr1xfxCoLFmcGVACpHviYm+fjDDJ
	 RIz7OyDjNIq8G1uuO6EgcFjlUE7u7QMCfxVPkJ27tGZ1sN1v6f7ojRwKoJt6jC2G/4
	 as0EmlC4wF9gQ==
Date: Wed, 7 Aug 2024 12:43:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 34/39] do_pollfd(): convert to CLASS(fd)
Message-ID: <20240807-wandmalerei-einwurf-b94bf6c33d73@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-34-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-34-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:20AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> lift setting ->revents into the caller, so that failure exits (including
> the early one) would be plain returns.
> 
> We need the scope of our struct fd to end before the store to ->revents,
> since that's shared with the failure exits prior to the point where we
> can do fdget().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

