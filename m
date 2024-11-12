Return-Path: <linux-fsdevel+bounces-34417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3979C522D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A421F21063
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE82020E03C;
	Tue, 12 Nov 2024 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4apR92S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3918820DD71;
	Tue, 12 Nov 2024 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404142; cv=none; b=pkeXKkbebjjUj7AIyC99Ag/K27B21OHBjrZF6Nsif8RChaOExQpOs/0CME27QjkmkzzkMnUdwIUVcI0JprZO5DthT506F9FAku8YiNew74yh3pt8YUnfW1Z81Y5quGbCXa+vtEnSW4oHJqtWOhkHNNMZ2wQgYe+YFXa2mca0eb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404142; c=relaxed/simple;
	bh=nie12rw9CwbepLn54gqeZhJx6b+/ZLsWWbYuZNDp/D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ1MHSTH24Sc+6B0r2uqiC9EouNRe/886+YK82yp2BXzizIN4lgxFjpj+wViErqg0EMfHHkwGctZjSPChrUYLr8mgk0ThmGZMKIwRbh+ianrhRbUvxYt6R0QzAktJugjJd/qI/QG5+XCD44luaztDo1lpbE9Qwl2FLzvzpPfjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4apR92S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFC4C4CECD;
	Tue, 12 Nov 2024 09:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731404141;
	bh=nie12rw9CwbepLn54gqeZhJx6b+/ZLsWWbYuZNDp/D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4apR92SJFTuIKPjcGyTYqSTGnMYlc3WZe77JROgA4ZBbFMq+umVdDEsU/ZDuPfZn
	 NaBh7dFUZ2oaPbSMqtxIlIXYEAOW8rcXEdNE7MtgSMXfhYl2m9f9ALbEG0nZ1CXkKn
	 wAf3AqgdcIjdgGq2cUxlDO8DhUMHvZaoH7OmjydYDiC2i+uHdm53o5QM4Dqxip/sde
	 DLj8Wi1UJvtKpNaJLLOThLy3UL3N15icYakZRucDFy5Wky8XI+FNcU1aLVnOfV5JlI
	 OOBdR77qG27RgsgvUsklIBojl5S+uIkq84//oziELuWs9lK899MsZU52AaE7NbeLYE
	 G4LxeTGgwHLAg==
Date: Tue, 12 Nov 2024 10:35:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: kernel-team@fb.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/4] proc/kcore: performance optimizations
Message-ID: <20241112-lohnt-bestanden-d0a0ae380679@brauner>
References: <cover.1731115587.git.osandov@fb.com>
 <20241111-umgebaut-freifahrt-cb0882051b88@brauner>
 <ZzJIJ4QFNj_KPPHK@telecaster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzJIJ4QFNj_KPPHK@telecaster>

On Mon, Nov 11, 2024 at 10:08:39AM -0800, Omar Sandoval wrote:
> On Mon, Nov 11, 2024 at 10:00:54AM +0100, Christian Brauner wrote:
> > On Fri, 08 Nov 2024 17:28:38 -0800, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > Hi,
> > > 
> > > The performance of /proc/kcore reads has been showing up as a bottleneck
> > > for drgn. drgn scripts often spend ~25% of their time in the kernel
> > > reading from /proc/kcore.
> > > 
> > > [...]
> > 
> > A bit too late for v6.13, I think but certainly something we can look at
> > for v6.14. And great that your stepping up to maintain it!
> 
> Thanks, v6.14 is totally fine!
> 
> I have a quick question on logistics. /proc/kcore typically only gets a
> handful of patches per cycle, if any, so should we add fsdevel to the
> MAINTAINERS entry so I can ask you to queue up patches in the vfs tree
> once I've reviewed them? Or should I send pull requests somewhere?

You can do that as you please. I can just pick them up once you've acked
them. I'm happy to do that.

