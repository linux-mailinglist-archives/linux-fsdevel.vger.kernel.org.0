Return-Path: <linux-fsdevel+bounces-25541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0F94D33B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 17:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8FA282DA8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 15:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4D0198A22;
	Fri,  9 Aug 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH7Au88n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B1B19885D;
	Fri,  9 Aug 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216682; cv=none; b=TLMXgNgte2LvtaR7G5xGwStHkFDFoBoGcVrpK91/BKqOu//Z9pyvkGVVh0r132Fl+zolE45l1EKuOhI+XYLGUxVULSRHAgB7XmNR4U4s8/UiGEhWcYTs5AO5aiYgvdp3UqFgCzG9tihYVw8YhM5lSgSUoEfvKojWldlUsRc2GBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216682; c=relaxed/simple;
	bh=HX0eI1ZHlD2NML9IXiV0/V6wNTRahD8BdtkiT/N4BTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMZ/EqayoJKLomRW/BSm2Bo4EDeIq4/LKsyd4UsGlmLt9NuD1859nFx1/OmXlRZsUAamANURT9i4muPwVay/iZzwNGqVTrwPw4tMO04l17Hd4/CMbbw2MWhHQkP5B/p7mTc44i4tyCBUz254fBt5e9GiTOdpZjP7vBxR8bZRVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH7Au88n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B0DC4AF0E;
	Fri,  9 Aug 2024 15:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723216681;
	bh=HX0eI1ZHlD2NML9IXiV0/V6wNTRahD8BdtkiT/N4BTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZH7Au88nUssQ9xp8l4VFNzZWPkzkUQifhQuiKvrL7Kv/NRE/RW63zW2+EqelO9Ore
	 e+vPKN+Q2mTrrGnomH8RD7x+mWKOPXCPMEm1AIv8JeG1TJZDHPn81T349DuOLtZM4q
	 blVo07MSk/hmdLiT/exZWIst1K63HWkRRa69DWu3Rrb94ntozUqShmS4Mh+UKm6Iw9
	 U4hXjuSwz8cUkc1Q7PwU2LZPzlquKeZdkglh66rU4hzoGh6oRwSDrMnFHLaVvYE9VB
	 78ehjol5/jAi18AFlm/6sN2e9tNcmwK4jMDDCV30fasEt3iNxSTxGAybJCZV1pQYMy
	 Zpy/zDIx8O8pw==
Date: Fri, 9 Aug 2024 17:17:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: don't overwrite the nsec field if I_CTIME_QUERIED is
 already set
Message-ID: <20240809-zugkraft-ergehen-df138f9d564a@brauner>
References: <20240809-mgtime-v1-1-b2cab4f1558d@kernel.org>
 <20240809-ausrollen-halsschlagader-02e0126179bc@brauner>
 <96dd05ee4ec91ea4ee25e1af395975d37893fcfc.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96dd05ee4ec91ea4ee25e1af395975d37893fcfc.camel@kernel.org>

On Fri, Aug 09, 2024 at 11:05:54AM GMT, Jeff Layton wrote:
> On Fri, 2024-08-09 at 16:55 +0200, Christian Brauner wrote:
> > On Fri, Aug 09, 2024 at 09:39:43AM GMT, Jeff Layton wrote:
> > > When fetching the ctime's nsec value for a stat-like operation, do
> > > a
> > > simple fetch first and avoid the atomic_fetch_or if the flag is
> > > already
> > > set.
> > > 
> > > Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > I'm running tests on this now, but I don't expect any problems.
> > > 
> > > This is based on top of Christian's vfs.mgtime branch. It may be
> > > best to
> > > squash this into 6feb43ecdd8e ("fs: add infrastructure for
> > > multigrain
> > > timestamps").
> > 
> > Squashed it. Can you double-check that things look correct?
> 
> One minor issue in fill_mg_cmtime:
> 
> -------------8<-----------------
>         if (!(stat->ctime.tv_nsec & I_CTIME_QUERIED))
>                 stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn));
>         trace_fill_mg_cmtime(inode, &stat->ctime, &stat->mtime);
>         stat->ctime.tv_nsec &= ~I_CTIME_QUERIED;
> }
> -------------8<-----------------
> 
> I'd swap the last two lines of the function. We print the ctime in the
> tracepoint as a timestamp, so if the QUERIED bit is present it's going
> to look funny. We _know_ that it's flagged after this function, so
> leaving it set is not terribly helpful.

Bah, fat-fingered on my end. I did intend to place it after. Thanks!

