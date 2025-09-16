Return-Path: <linux-fsdevel+bounces-61716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5895EB593CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 12:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AC2188BDCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11220307482;
	Tue, 16 Sep 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLBmDM7m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54404306B24;
	Tue, 16 Sep 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018624; cv=none; b=ZCvdE2soEcj0g3uZ29dr7eLd72ueHAse1dFvqWmT7+F311uNeoYbMCl6mpuWMAQi9XH0NMoxDjG3Rymc8iEPYyHeFYYr7S3ZccX2rWtUuHUZ3S0PrOzFpOtYTl+PuL0kkRShIeYUFAiC4fbRIa0cBv2P5iOsar5iEvRbOvVpmPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018624; c=relaxed/simple;
	bh=gAAilxsN/AVy1OShZW0GRslZOkvpO/f181u9q9w/XKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUfA3nMB2pVC6CsYxZW9IZCe6xUCcxoGsXm8eMatnNWJAgbqeU2cynpStkQUgF4QH4QwMg+k7OBh/O2NJXeysZfyoodP88/e/jU1X99osPskzihhuQKi0vZqhbEWFyBipgMclt71aQf+CyKs7NomPQ2XeJso1Vhaz+I2OvwRweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLBmDM7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB074C4CEEB;
	Tue, 16 Sep 2025 10:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018623;
	bh=gAAilxsN/AVy1OShZW0GRslZOkvpO/f181u9q9w/XKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLBmDM7mb3Ufg+oww+5cKXQVfa/6+8ufr00EHIZ2NKEfeL8k6NE3hjO8uY/vlZH0K
	 wlMwck/o+tJJ8yvFJEX9uzCKrtq6+f+rbPTTuiOcV6orcThd5Bu6M+NgsoHWMjeKeI
	 22INFqATsBATErhrCt9XD+PM8gKiiH3BAxkGgSSXPCwm6YylRxb1076qo42ZGkJteB
	 J7Kp+N+MyL4XbrhT65sZMAAf/adRAKeXSfHNNjgf6ysYPwZXZy0lkGWG9ETsnxrN9o
	 KYm6YCuhkBTP7CxvYv7+aRspQgy+mencFK4zqZA3lHUdAGko23rA89qtojjxrU6Wqg
	 3OLtjjNBb3Lfw==
Date: Tue, 16 Sep 2025 12:30:18 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Dave Chinner <david@fromorbit.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, hch <hch@lst.de>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] fs: add an enum for number of life time hints
Message-ID: <tzam6zmquwkevvzttqpjbstfynoakruxwopkwxh4uwwp6y5jfh@pqcn5fabxbek>
References: <20250901105128.14987-1-hans.holmberg@wdc.com>
 <kcwEWPeEOk9wQLfYFJ-h2ttYjtf0Wq-SjdLpIAqoJzT3jysu_U4uhYJj1RZys6tWgxVKxq833URcLKj-5faenA==@protonmail.internalid>
 <20250901105128.14987-2-hans.holmberg@wdc.com>
 <gzj54cob33ecyfdabfbvci7nj7gl5sc2cbujpkg6qax7vgoph2@3ubnb4d2dfim>
 <DZB0-ULgmDqGhUYZTNmejWn0uBGpQyLcY3GV5p4BugXGGUlPZmVRsuex9bfbG_iP7M2fbufVZNJGcpyXi22z4w==@protonmail.internalid>
 <20250905-posaunen-lenken-e81db0559def@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-posaunen-lenken-e81db0559def@brauner>

On Fri, Sep 05, 2025 at 04:03:51PM +0200, Christian Brauner wrote:
> On Fri, Sep 05, 2025 at 10:17:51AM +0200, Carlos Maiolino wrote:
> > On Mon, Sep 01, 2025 at 10:52:04AM +0000, Hans Holmberg wrote:
> > > Add WRITE_LIFE_HINT_NR into the rw_hint enum to define the number of
> > > values write life time hints can be set to. This is useful for e.g.
> > > file systems which may want to map these values to allocation groups.
> > >
> > > Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> >
> > Cc'ing Chris Brauner here, as I think he is who will be picking this up.
> 
> This is so trivial, just take it through xfs, please.

Deal.


