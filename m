Return-Path: <linux-fsdevel+bounces-12567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D506861271
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C74A1C21855
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F2B7EEE5;
	Fri, 23 Feb 2024 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="G3cGecz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956787E579;
	Fri, 23 Feb 2024 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694189; cv=none; b=AmVNSB/2Wr+pbbSixHUXsPIcao9d53Y+px112i7EZISp6Zdrr16PLfyk97NUbtlDowWQCLNWMTJiZWckEtn96vtSwJ4htV/SmWDMZjtJeTUS0xV29BB2cxt6G2eOzvuhYMrT+bEFoa2sTAtOkS4bCsAPQGcObSfwn4yweqAXQOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694189; c=relaxed/simple;
	bh=kcmFiuh1OodqGBqsxi0kGV358x2J36gONeQPxC2Zzyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFG+0xR3yTfY59Rf+dRd9n3MEyIATRlDzkEa9vmH3xLdiVqxlzeEx/IbxIWWLTx2r4C/FjZTi+wzHWj8s0zzhaf9OC+79YELuSylUqdFW/G4MM6ZWzwPnv887RuOTmcPgXtvqmjkKIf1lUml3XzvSvfBjnimUpLUk+g1/5Squ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=G3cGecz+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1708694175;
	bh=kcmFiuh1OodqGBqsxi0kGV358x2J36gONeQPxC2Zzyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3cGecz+zi5TgbKcScNvRye+hvdd0inPLd1s30zbvM1+ZdhnHxr0VYCaUCKKgZSIw
	 mb5662UbE19iha5IwvKpqJiwVIIUHBrKCtviPLBcwcZ7G6rhQ6FOs4B7av96SjEMqw
	 XQocmnlgXbDy1O8Yfrm+56oF5ue9dJT/BA3xAk5w=
Date: Fri, 23 Feb 2024 14:16:15 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH] sysctl: treewide: constify ctl_table_root::set_ownership
Message-ID: <23edfaea-fcee-4151-bfa8-d71d11a24401@t-8ch.de>
References: <20231226-sysctl-const-ownership-v1-1-d78fdd744ba1@weissschuh.net>
 <ZY12sLZYlQ09zU6D@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZY12sLZYlQ09zU6D@bombadil.infradead.org>

On 2023-12-28 05:22:56-0800, Luis Chamberlain wrote:
> On Tue, Dec 26, 2023 at 01:32:42PM +0100, Thomas Weißschuh wrote:
> > The set_ownership callback is not supposed to modify the ctl_table.
> > Enforce this expectation via the typesystem.
> > 
> > The patch was created with the following coccinelle script:
> > 
> >   virtual patch
> >   virtual context
> >   virtual report
> 
> If you remove this virtual stuff and mention how we verify manually
> through the build how users do not exits which rely on modifying the the
> table I thinkt these two patches are ready, thanks for doing this in
> Coccinelle it helps me review this faster!

Actually the 'table' parameter is never even used.
Do you prefer to drop it completely?


Thomas

