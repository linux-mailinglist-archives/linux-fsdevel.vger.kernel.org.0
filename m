Return-Path: <linux-fsdevel+bounces-30905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A20698F774
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 22:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07D01F22836
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 20:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAC3145B3E;
	Thu,  3 Oct 2024 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cCbsgQMv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134754C8F;
	Thu,  3 Oct 2024 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727985694; cv=none; b=OFl6Zx5qrlQJmnBOUIe760YxVa8NDej5zS5DF8DGod9ZCxLoBC8gesdFket4ivNWsaekenAmwbepb3v61OGWhaswtpqIuz0sGXZHD7TFMks94qVmtCPXrqct4LelFGG7NTWsYMg7pNqHd62vVTJ+4E2AqVZ8h62GHyk6NBo5gSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727985694; c=relaxed/simple;
	bh=RqvHe7FU3fH5p95Bh+yW9c9wRy4QevpHahv2OjiepJE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J7m8iP/BEgWkqgznkwWPKluAg2l5sAYGCHB39KryQxA/OLzrYtswmRmJPUO72J6CL+aKDMD5WcLVKLNnXr3l46TnEqNdj5zDV8b2IVaPEzdMywidXCzPiuS7kPZydPHDSR6gRyimKJMpL/3X6iG76I9QMoc8pMCc7yd3geEoeEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cCbsgQMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D2EC4CEC5;
	Thu,  3 Oct 2024 20:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727985693;
	bh=RqvHe7FU3fH5p95Bh+yW9c9wRy4QevpHahv2OjiepJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cCbsgQMv4beJNsGDComQA56FRALBKQ/tfqX/N8uf/WNy+YhDxz1SJ4HvrNYalZr59
	 NLQ0webp0FE1qcMxRH94bFnuJKnNIA5yhCIgx8FAKNqTsxLjoxFugbDAC2bB5Hroke
	 vbuDkw9SQ9foeP8Yh5ndTbCKfD8Yf/nhPhkH0JvM=
Date: Thu, 3 Oct 2024 13:01:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox
 <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm/truncate: reset xa_has_values flag on each iteration
Message-Id: <20241003130133.afb8e8bbdfa8f638b0343473@linux-foundation.org>
In-Reply-To: <zdrmuzjcgxps3ivdvnmouygdct2lr6qj2avypuj3hatv746rye@7wu3txx5hyou>
References: <20241002225150.2334504-1-shakeel.butt@linux.dev>
	<20241002155555.7fc4c6e294c75e2510426598@linux-foundation.org>
	<zdrmuzjcgxps3ivdvnmouygdct2lr6qj2avypuj3hatv746rye@7wu3txx5hyou>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 16:09:11 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Wed, Oct 02, 2024 at 03:55:55PM GMT, Andrew Morton wrote:
> > On Wed,  2 Oct 2024 15:51:50 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
> > > Currently mapping_try_invalidate() and invalidate_inode_pages2_range()
> > > traverses the xarray in batches and then for each batch, maintains and
> > > set the flag named xa_has_values if the batch has a shadow entry to
> > > clear the entries at the end of the iteration. However they forgot to
> > > reset the flag at the end of the iteration which cause them to always
> > > try to clear the shadow entries in the subsequent iterations where
> > > there might not be any shadow entries. Fixing it.
> > > 
> > 
> > So this is an efficiency thing, no other effects expected?
> > 
> 
> Correct, just an efficiency thing.

Thanks.  I'm assuming the benfits are sufficiently small that a
backport is inappropriate.

