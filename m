Return-Path: <linux-fsdevel+bounces-58291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A62DB2BECF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0581BC2D3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C439427700C;
	Tue, 19 Aug 2025 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+nU4IS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D727A13A
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598860; cv=none; b=HK8CnIWEoPirdfmeN4FqCJqayGJOxYlz4mAuFW9R/25AHBNNY8HrNWG2jQ93bA96RGkV1SIVrLBoM6DqxzH77liVoeSTYsg5AO6+x5Jz6Yl1FzboDuoWmJU+/IYKEsgSyFF147Ul8G9p5iwthHI9UgiPe3fqZgHrQBXFpopL9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598860; c=relaxed/simple;
	bh=sHXkZ/k9kb5SoOWS4pX+L3Ij7OEuTvK3oELl8BWyl70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOW08JsIBa0ZrVTDcaGgyzBvaZgc3pcPNotoQBgdztyyZg1Z2CptlBSXkPrv37H2P1E2qiX3tVeEdpat0nqR/n2t/dWewQWmUv9Ftw9OkIy9TKBCS9MINYEGIl2nX3wUrYvg4+0/zjcaYEBEPSc+U5AxdmZisEYUVY+499DyXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+nU4IS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A6EC4CEF1;
	Tue, 19 Aug 2025 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755598860;
	bh=sHXkZ/k9kb5SoOWS4pX+L3Ij7OEuTvK3oELl8BWyl70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+nU4IS0tokT7Bfs/aYub0IDCVylkCjPHbcJ7csHsGATqdbspQpetM57/D2XjLpXo
	 QD2VYkaR0zXrsKSmTq3h3bUAHrcPdH5tZQTseaVeaRqZlFmhHyuNvroKfUw4MeSbWb
	 6i5dTTnKE8s9HaEMElSFMedsM1zGINukuxwCvHP+cniu1/W3xgkdIHEzcDLgqeZkD0
	 io4yNdZsSvHWd3gP5yWU53CqWRYDNWkqCG1y8bzJ/pDCFmGUe5UisgE9r/EJawwj8t
	 WenK1p2OcTjAmNwphYoTGnShqRt+RKZD3NpjcNsjeUsxVmVM18bRHmJ8LIrt1UbEoQ
	 uNkyQx5wsxGoQ==
Date: Tue, 19 Aug 2025 12:20:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, "Lai, Yi" <yi1.lai@linux.intel.com>, 
	Tycho Andersen <tycho@tycho.pizza>, Andrei Vagin <avagin@google.com>, 
	Pavel Tikhomirov <snorcht@gmail.com>
Subject: Re: [PATCH 4/4] change_mnt_propagation(): calculate propagation
 source only if we'll need it
Message-ID: <20250819-kundtat-schiffen-4982aa593106@brauner>
References: <20250815233316.GS222315@ZenIV>
 <20250815233645.GD2117906@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815233645.GD2117906@ZenIV>

On Sat, Aug 16, 2025 at 12:36:45AM +0100, Al Viro wrote:
> We only need it when mount in question was sending events downstream (then
> recepients need to switch to new master) or the mount is being turned into
> slave (then we need a new master for it).
> 
> That wouldn't be a big deal, except that it causes quite a bit of work
> when umount_tree() is taking a large peer group out.  Adding a trivial
> "don't bother calling propagation_source() unless we are going to use
> its results" logics improves the things quite a bit.
> 
> We are still doing unnecessary work on bulk removals from propagation graph,
> but the full solution for that will have to wait for the next merge window.
> 
> Fixes: 955336e204ab "do_make_slave(): choose new master sanely"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

