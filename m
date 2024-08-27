Return-Path: <linux-fsdevel+bounces-27323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B7B9603C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 09:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC6828227F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F971714B8;
	Tue, 27 Aug 2024 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0RSPaGX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F6158D66;
	Tue, 27 Aug 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745557; cv=none; b=D/O/8rxHOxo+u9x0yTj0BG+A/7BJB/uZ+ceUfs59Y+RZIEKtxE/P6JD4mt+MP4BT7bOAx2rPvdE6LYwUoPG7tucy/IJwAdM0r15X4XY9HgGxRvbD/FWgoWeas0m2czjFmNrjBbieWFrwYPeh1neAC1PIfemLfaQldKyTisf9XFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745557; c=relaxed/simple;
	bh=CKjdtSxL5j9yCktzG6dNKwfYSKRhZeAscTZxm/udIPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfcA9fhBJozQyWdjDF1zWNsrz+ZRaleLh/2p6pl2+3AhZi+gjVGQY6GvgWyJWTVIE0WnVCFyG5N7HGr5sYCfYe2sBiprzZV56AabhsNnhaC54xE2VTgbUzJvWo6HhHePrC8pZpV7wOjqP2Apt6dBYcDwFBW79VBhEQiMNl7mR7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0RSPaGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1699C8B7A0;
	Tue, 27 Aug 2024 07:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724745556;
	bh=CKjdtSxL5j9yCktzG6dNKwfYSKRhZeAscTZxm/udIPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0RSPaGXjm28J/s8HQNWj3Lka/siSOx6Yo64BnZRTkUqjkZZbMxN86HNFGCFY2D1k
	 E0/kdSIK0aG+x45U+ItCNjjC4UtAIu5JFXQHtQGx/F0pljHBX1pY53A6PJC35Laell
	 oOmT+1QSDyQvT50BBmIbcmTa6MvHzB7AdJricqCZp+x8Gazad2B1gOg4GCKXx2Mjw3
	 j2nArgZeA7M3iInPVtGPZFEPeoZ8avAQZcXA4OEHnxuCJimYEdmE4/batAReCRgr+j
	 NplX6v8evX5tbo3DDnDlPjTXmTastW2KFCubWLB37zaFU96qqcXKolN+7AjKHIirjW
	 DTiPSaZ6tEK9w==
Date: Tue, 27 Aug 2024 09:59:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk, 
	jlayton@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: drop one lock trip in evict()
Message-ID: <20240827-panzerglas-wohngebiet-85bb20c2729d@brauner>
References: <20240813143626.1573445-1-mjguzik@gmail.com>
 <20240826202746.ipovnb5hfom7jkmb@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826202746.ipovnb5hfom7jkmb@quack3>

On Mon, Aug 26, 2024 at 10:27:46PM GMT, Jan Kara wrote:
> On Tue 13-08-24 16:36:26, Mateusz Guzik wrote:
> > Most commonly neither I_LRU_ISOLATING nor I_SYNC are set, but the stock
> > kernel takes a back-to-back relock trip to check for them.
> > 
> > It probably can be avoided altogether, but for now massage things back
> > to just one lock acquire.
> > 
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> 
> Back from vacation so not sure if this is still actual but the patch looks
> good to me. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

It's all still in vfs.misc so we can still add RvBs.
So go ahead and ack whatever you want to ack. :)

