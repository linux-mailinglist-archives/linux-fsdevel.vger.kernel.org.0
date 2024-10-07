Return-Path: <linux-fsdevel+bounces-31179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2658E992E87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B041F24388
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE8C1D223C;
	Mon,  7 Oct 2024 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRruKamw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D0B1D54FD;
	Mon,  7 Oct 2024 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310322; cv=none; b=QwZ0KeaSlkzgMf/hU5m5vuhbwuDfz8hsDdw72FvGQn6pVI0hx4VeecsqELG5jrVc8S+Zd54PpmqxGbolvyrVA/SES5QSDLjsGwBvAr5MwY0RyyTEa6V/eNExi8IQqYZRz8bJa/W0QzrfEhqOFskfCAoHtqdARJNj/SEuL2x3VCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310322; c=relaxed/simple;
	bh=ybFSDB793E+AR/RaS+tyFBVGPsMJ3mur3+7gERRCSwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/Xb9IDzwRLmxz3vww/9a0tk3GEFS2CnUGeRgvke5sXJCeb4QF22ExdeIEhu9PIIkLGC+uPP4aAhRdpODOxJMEiuYEviHJOJwMrOVX3IrQLvQZv1OOmlTTAC1xiojWOaOHm5Vop7ztpp95TtR98iZyqf2giweni5Go4/r4IWOIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRruKamw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1643C4CED0;
	Mon,  7 Oct 2024 14:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728310322;
	bh=ybFSDB793E+AR/RaS+tyFBVGPsMJ3mur3+7gERRCSwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tRruKamwkMKa8ls0Nj3OchiowXPhrd7s591m9NO18RyILz3ZqO+yyhCnxyXO3W3sq
	 YSWWU3dS/alYrizwOhDWCML0fzJJptj+rR156l+UiLogXCOW5Hn9XY3UFAFSQ5meDi
	 zLjw0+ztS8aN8k7aoRCRVtNvGsjdlcQO1vAXYIZ1VwxF9WsJPX3hMc2U9s2jQnRcoF
	 wsVfb+0VBclM8MrAB8xDyWXU0/MOMklPBer/ltIjFZXsZZvA6EHMR8vAkifuq1+Rs/
	 1mGw3SuMWYkNZDiRm0RbOsh6NiP0SPfAhUVbHOCYVR2G2OrC+LrF0HUs5DgaCzozwu
	 FfN/HnyzoW0fA==
Date: Mon, 7 Oct 2024 16:11:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Stash overlay real upper file in backing_file
Message-ID: <20241007-trial-abbrechen-dc2976f10eb3@brauner>
References: <20241006082359.263755-1-amir73il@gmail.com>
 <CAJfpegsrwq8GCACdqCG3jx5zBVWC4DRp4+uvQjYAsttr5SuqQw@mail.gmail.com>
 <CAOQ4uxjxLRuVEXhY1z_7x-u=Yui4sC8m0NU83e0dLggRLSXHRA@mail.gmail.com>
 <CAJfpegvbAsRu-ncwZcr-FTpst4Qq_ygrp3L7T5X4a2YiODZ4yg@mail.gmail.com>
 <CAOQ4uxi0LKDi0VaYzDq0ja-Qn0D=Zg_wxraqnVomat29Z1QVuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi0LKDi0VaYzDq0ja-Qn0D=Zg_wxraqnVomat29Z1QVuw@mail.gmail.com>

On Mon, Oct 07, 2024 at 01:01:56PM GMT, Amir Goldstein wrote:
> On Mon, Oct 7, 2024 at 12:38 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, 7 Oct 2024 at 12:22, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > Maybe it is more straightforward, I can go with that, but it
> > > feels like a waste not to use the space in backing_file,
> > > so let me first try to convince you otherwise.
> >
> > Is it not a much bigger waste to allocate backing_file with kmalloc()
> > instead of kmem_cache_alloc()?
> 
> Yes, much bigger...
> 
> Christian is still moving things around wrt lifetime of file and
> backing_file, so I do not want to intervene in the file_table.c space.

My plan was to just snatch your series on top of things once it's ready.
Sorry, I didn't get around to take a look. It seems even just closing
your eyes for a weekend to a computer screen is like opening flood
gates...

