Return-Path: <linux-fsdevel+bounces-43740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22665A5D1F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 22:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62AFD17B457
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 21:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCAC263899;
	Tue, 11 Mar 2025 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BrsWm8VK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B20222A1CD
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729647; cv=none; b=B3UVcPMAjnNfcMJOYyfUAnAUDKYC9wZhgm6NhmHQydyzseCZKf7obtMQGln42RpP6supUVaRme9kIOjVb8b16ainqlvnatcpoZZa5zUw/FTRIQ2fxA2BIuw3mYZ8vqk3XntOs64SZnruIg8HLItEXiBwF9Z+RCuG7kQx0sobGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729647; c=relaxed/simple;
	bh=VkHS73BmOGqRfMcDLYknkiuo7qwm81Es3i5cCJWsj1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwtcB0txAgskkVufYsSrSP5JZJXVQRd9yjm9nQprRhtPJ0Z51nfk0AiAxnCXBtJF/8cB6hNdSX0YwxpVqyGyf8Dp3BpAwVHdy7rQtPtT5WsMLWNAq2WvVlW3V+9Axc1VZckInrfegGF5jSj9ZxuTj6pPrCnMaw2SIyAAs58o4Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BrsWm8VK; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Mar 2025 17:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741729641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VkHS73BmOGqRfMcDLYknkiuo7qwm81Es3i5cCJWsj1g=;
	b=BrsWm8VK/l4sH7XyYdYrecuARIxdrj8oA7hTIvct/kV3Do7f8jADUERMMbfb8rG6t5hMPW
	ZmfmzC9nVDckS+LBCyiM3RCN22t3X0mjmK1412m8N/uD0LHg/rYVPRonozrCAdj8al3fir
	9+hRxNT2nJ05MPOPn/PlQZyqPcfP1BA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Sun Yongjian <sunyongjian1@huawei.com>, linux-fsdevel@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
Message-ID: <vg5mnmd5qar5cck2qezeimkhjrs6cqgwb2xd6togm6sp6ac7or@dahqij46fml6>
References: <2025022612-stratus-theology-de3c@gregkh>
 <ca00f758-2028-49da-a2fe-c8c4c2b2cefd@oracle.com>
 <2025031039-gander-stamina-4bb6@gregkh>
 <d61acb5f-118e-4589-978c-1107d307d9b5@oracle.com>
 <691e95db-112e-4276-9de4-03a383ff4bfe@huawei.com>
 <f73e4e72-c46d-499b-a5d6-bf469331d496@oracle.com>
 <20250311181139.GC2803730@frogsfrogsfrogs>
 <2fd09a27-dc67-4622-9327-a81e541f4935@oracle.com>
 <20250311185246.GD89034@frogsfrogsfrogs>
 <d0dc742a-7373-4e1e-9af4-d7414b1d3f4e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0dc742a-7373-4e1e-9af4-d7414b1d3f4e@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 11, 2025 at 03:39:32PM -0400, Chuck Lever wrote:
> Not sure what you're getting at here, but POSIX makes absolutely no
> guarantee that d_off will always increase in value as an application
> walks the directory. That's an impossible thing to guarantee given
> the way d_off values are chosen (at entry creation time, not at
> directory iteration time).

Not sure why you're trying to cite POSIX when it's an actual application
regression under discussion.

Sane d_offset behaviour is one of those "of _course_ things will break
you screw that up and I don't want to be on the hook for debugging it"
things to filesystem developers - you don't do it.

