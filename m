Return-Path: <linux-fsdevel+bounces-30906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C44098F7EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 22:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BABEEB22876
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 20:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A591AD418;
	Thu,  3 Oct 2024 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oOhqwgUa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B51212FB0A
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986286; cv=none; b=c+Sd+h26xzBBmEuHMjW38x8sLTf6Hc/U8caO798+5ogV28ueW2+P9QKuZ8j3ZjtAedsnKRH2ab/kTr+Ib4epSGTpD6HJKDdwwI8el70OR2Peo2Y5PcrJ/RooQwpaDBPHjR1w+db5SlZrUma4gELnaAbwJc7C5v3Ym57i7jsAh+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986286; c=relaxed/simple;
	bh=rg/naDQM/vx8qoqw+T4vgXspe7QarPcXwG8M1Bp0jIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJtpaF4YWtUpwOIeW9zrSDQYTaAVNh6xZD2loezJgFZUNy8BqTP6ypDqRYKO5Nx21HfuQhpKtbfI7XD95xG9/dX9z7qRi6T9I0b55xl8M8TyW0mWI18I8cTHQusEdElUdm2JCJeL7Pe098db1YAt0pGyCKxMqjSFvj+YWD5FLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oOhqwgUa; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 3 Oct 2024 13:11:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727986279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rhPQoJlakqquoI5upZw/takDi1T+3w/Qo6IA9str170=;
	b=oOhqwgUa1OJ93qlI1jFlbG6VY4hEtaMvKCrc4n3X9JM7tjnbO53noxUwy13usv9VckJRIz
	sNnHvu8j30Fsec5oODrdK8tYi6TxSKomXKdXJo0x5c4wzMWO9KQyC+gcvE1POr+Ssomhqb
	suDyzmPDAeswetTnn9/IPbT2WpFhBeo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm/truncate: reset xa_has_values flag on each iteration
Message-ID: <xqpohu2prms6cdhasdwup7dgkj6jsnnal7rx4t4i2qddownomf@gtx42zkp2n7t>
References: <20241002225150.2334504-1-shakeel.butt@linux.dev>
 <20241002155555.7fc4c6e294c75e2510426598@linux-foundation.org>
 <zdrmuzjcgxps3ivdvnmouygdct2lr6qj2avypuj3hatv746rye@7wu3txx5hyou>
 <20241003130133.afb8e8bbdfa8f638b0343473@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003130133.afb8e8bbdfa8f638b0343473@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 03, 2024 at 01:01:33PM GMT, Andrew Morton wrote:
> On Wed, 2 Oct 2024 16:09:11 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > On Wed, Oct 02, 2024 at 03:55:55PM GMT, Andrew Morton wrote:
> > > On Wed,  2 Oct 2024 15:51:50 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > 
> > > > Currently mapping_try_invalidate() and invalidate_inode_pages2_range()
> > > > traverses the xarray in batches and then for each batch, maintains and
> > > > set the flag named xa_has_values if the batch has a shadow entry to
> > > > clear the entries at the end of the iteration. However they forgot to
> > > > reset the flag at the end of the iteration which cause them to always
> > > > try to clear the shadow entries in the subsequent iterations where
> > > > there might not be any shadow entries. Fixing it.
> > > > 
> > > 
> > > So this is an efficiency thing, no other effects expected?
> > > 
> > 
> > Correct, just an efficiency thing.
> 
> Thanks.  I'm assuming the benfits are sufficiently small that a
> backport is inappropriate.

I agree.

