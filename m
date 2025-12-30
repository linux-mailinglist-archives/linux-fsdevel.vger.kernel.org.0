Return-Path: <linux-fsdevel+bounces-72234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D284CE91DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 10:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 837ED301E1AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA265314D3E;
	Tue, 30 Dec 2025 08:46:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD2314D10;
	Tue, 30 Dec 2025 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767084412; cv=none; b=chnyH0FFnzPyiRvk+bpEXhKb18hPEvReJPKUi6Hpv3j25lDuVYnmqXhhtFMdHPPvKjSM8NGJGlIuPFieKxHkIC89SkZCU/IqGCcH28fowRoUmxj3WUb9IlfuOagLrchaJLnUeo6tJGrAztB2x+UiACGhd2RJvVUx3TXhdKbuE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767084412; c=relaxed/simple;
	bh=PBq9vi/WeU2Uyj7uEfJLGSU+xh4T+7XIUifqQbdScfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grn5yxSYl3oKuFQXTDiU6cuVgzvJ6CAIquwvuJf4dk1VHgfFKYdu6Cn/RJWNmBM5ogjXeLP6LrUeNvfAoR/NhzhA468xzc18KneO1fM3xh390SJn4TWMUupnjdwyBZZuCB+SAxZJr6S2iRigN/vT1HY9/WorD3RhypyHQNTy4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (118-103-000-128.ip-addr.inexio.net [128.0.103.118])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id 2744EE07C2;
	Tue, 30 Dec 2025 09:36:45 +0100 (CET)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Tue, 30 Dec 2025 09:36:45 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Horst Birthelmer <hbirthelmer@googlemail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>, 
	syzbot@syzkaller.appspotmail.com
Subject: Re: Re: [PATCH RFC v2 0/2] fuse: compound commands
Message-ID: <aVON2GgM7KK4oBb_@fedora.fritz.box>
References: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
 <be2abea2-3834-4029-ba76-e8b338e83415@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2abea2-3834-4029-ba76-e8b338e83415@linux.alibaba.com>

On Mon, Dec 29, 2025 at 02:03:02PM +0800, Jingbo Xu wrote:
> Hi Horst & Bernd,
> 
> On 12/24/25 6:13 AM, Horst Birthelmer wrote:
> > In the discussion about open+getattr here [1] Bernd and Miklos talked
> > about the need for a compound command in fuse that could send multiple
> > commands to a fuse server.
> >     
> > Here's a propsal for exactly that compound command with an example
> > (the mentioned open+getattr).
> >     
> > [1] https://lore.kernel.org/linux-fsdevel/CAJfpegshcrjXJ0USZ8RRdBy=e0MxmBTJSCE0xnxG8LXgXy-xuQ@mail.gmail.com/
> > 
> 
> To achieve close-to-open, why not just invalidate the cached attr on
> open so that the following access to the attr would trigger a new
> FUSE_GETATTR request to fetch the latest attr from server?
> 

Hi Jingbo,

you are probably right, that it can be achieved that way. I thas some consequences that can be avoided, like having to wait at a later moment for the attributes to be fetched.

The main goal of this patch however was not close-to-open, even though it was discussed in that context.

We can do a lot more with the compounds than just fix close-to-open consistency. As Bernd mentioned, I am very close to havin implemented the fuse_atomic_open() call with compounds, namely the atomic combination of lookup+create.
And there are some more ideas out there.

open+getattr was just the low hanging fruit in this case.

Cheers,
Horst

