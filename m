Return-Path: <linux-fsdevel+bounces-50329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1449EACAF3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 15:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B31188DC5E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B3D221297;
	Mon,  2 Jun 2025 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="onTBjsoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499402AD1C
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871573; cv=none; b=VLSn/DJNnzKFBwt8h/UbmKo6QOofS0YKo8i4CUG+Yhxrx7Ly+PwDAd3m0SxJbrW37JpnpIyKtrHAu/q9/FLeTrYcu0lQ7c4VAegB+pNlgeUdWqMabW/bTHEuflMfrEzVPvaGf0n3vrLXLnj09CrafiOgccS+puIBGiuIVkdsZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871573; c=relaxed/simple;
	bh=1J3CIViaGgkdQJhwhaGefR9lpN/7hbL5mQCAe8hlrH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bswUXN4GTN5RU47Nt/Is3iRKNPlTr75k88T7r2upLwYLiCAYfVSighJ4lfxbBnOqFmO3y7KyVmlxVJWtY+wu6iJDhMvSeFteyeb43x7y2RX+08a+KrP+IEuj36Ai5EpvqL9p1LoRbAAvsaWfjukzskdyTIvWN0kfTxsN3Kb7hSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=onTBjsoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216E3C4CEEB;
	Mon,  2 Jun 2025 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748871572;
	bh=1J3CIViaGgkdQJhwhaGefR9lpN/7hbL5mQCAe8hlrH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onTBjsoIq1VzmceMi2mlLcV2DhGlGmf8UyHbMgBF3MU1lswwgHrc91B2lF/ChT25k
	 rDwIx35C1SGT7JJ13yG78DYI+CsHPcUzdSY3uFDpGszQrgwKvh4xEoRQPH0y7n37d8
	 /DrfEZfg/PUujv2CXdpqjgTz6akzwv1UWgifiQOs=
Date: Mon, 2 Jun 2025 15:39:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Luca Boccassi <bluca@debian.org>, stable@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: Please consider backporting coredump %F patch to stable kernels
Message-ID: <2025060213-varnish-elevating-6b5f@gregkh>
References: <CAMw=ZnT4KSk_+Z422mEZVzfAkTueKvzdw=r9ZB2JKg5-1t6BDw@mail.gmail.com>
 <20250602-vulkan-wandbild-fb6a495c3fc3@brauner>
 <2025060211-egotistic-overnight-9d10@gregkh>
 <20250602-eilte-experiment-4334f67dc5d8@brauner>
 <2025060256-talcum-repave-92be@gregkh>
 <20250602-substantiell-zoologie-02c4dfb4b35d@brauner>
 <20250602-analphabeten-darmentleerung-a49c4a8e36ee@brauner>
 <2025060246-backlit-perish-c1ab@gregkh>
 <20250602-getextet-stehplatz-35f704165888@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-getextet-stehplatz-35f704165888@brauner>

On Mon, Jun 02, 2025 at 03:06:12PM +0200, Christian Brauner wrote:
> On Mon, Jun 02, 2025 at 02:49:32PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jun 02, 2025 at 02:32:24PM +0200, Christian Brauner wrote:
> > > v5.14
> > 
> > Nit, the stable tree is "5.15", not "5.14" :)
> 
> Whoops, sorry about that. I misread the kernel.org page. Here's a pr for
> v5.15:

Not a problem, I took the 5.14 version and fixed it up already :)

thanks,

greg k-h

