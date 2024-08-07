Return-Path: <linux-fsdevel+bounces-25278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981D794A5F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58940282A06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F391E6728;
	Wed,  7 Aug 2024 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbj8Rgnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16C1E213F;
	Wed,  7 Aug 2024 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027305; cv=none; b=jB1oYeUHddwUOhC5fhtt1eOZk9KQrAVBEY1qRiZ7MkDoJ8PA2DcIlUYdK1m/JTIEp+a1D7LdEaYpNQWQcZTsT7WFkt1tSDEZwTGLSgQ0cIUS7iFJrhvxYhvziO3/OMu1AcyLi4A4Ejva2elJnhvqogDNRjvERM6Z3/11DGevKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027305; c=relaxed/simple;
	bh=Gz/Xv2OWmw2RoQUffsP+1UZgCqhiCjs3pek12EA5OI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNoPhqItbch+4wTZU5JFnq8ndDPPg2tFt4wyMx1Fu4PyvAJVD/8RSatar1CR3MWC8maKTiYO4ZNrUQNQY/ADsGNoJ92Zn1/0FjCRTsz+teOHQIeM1Dcejy93lYOfQrJ7rTab6sxtiAyPPxi+Ubi8hSWSl5joBBQiiUwglfqSAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbj8Rgnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B988C4AF0E;
	Wed,  7 Aug 2024 10:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027305;
	bh=Gz/Xv2OWmw2RoQUffsP+1UZgCqhiCjs3pek12EA5OI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pbj8RgnlRfnyOzDRDq9svH6BFHU5LC5K/Tr12mAwJJC6wi/3F5kcOWP8JnLB0nTyk
	 ZXcPCKKco5G/nJmGZiWChQflxMOjH1oJ9g/Lz4Gnwkor0teQTr3Y2IGuIXVcd5d3fh
	 jlQUm7Md6NFprQFmII5ynA2rCahCRqU/tqoNh0chwwVFvq116dHtgH9JXeRuW1i4ep
	 q7XVhVcrz6WGfHq3XPIfq6+zoMQZG5d2pMQEEPkzHjDwWuH0ZRRAAa0yCcsB8Pfdr6
	 M58gl/ViOUnLefdkCIFaJLzviFkyKX8AF/UsnrJWkCpE5E9hexSAx3GfbeGOmCaGd6
	 S+ucLWXUhGNOQ==
Date: Wed, 7 Aug 2024 12:41:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 31/39] convert cifs_ioctl_copychunk()
Message-ID: <20240807-aufkeimen-gejagt-1ad28277d9a2@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-31-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-31-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:17AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> fdput() moved past mnt_drop_file_write(); harmless, if somewhat cringeworthy.
> Reordering could be avoided either by adding an explicit scope or by making
> mnt_drop_file_write() called via __cleanup.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

