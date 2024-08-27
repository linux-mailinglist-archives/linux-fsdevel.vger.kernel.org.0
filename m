Return-Path: <linux-fsdevel+bounces-27278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B927695FFE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E6528365F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 03:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFC6219FF;
	Tue, 27 Aug 2024 03:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ja6HPA68"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B181803D
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 03:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724730061; cv=none; b=RVtds+1ButLvhXsxENC4R+vfkZqXQWXwS311KjF1JWFkcHOjSrx8LO4gmdInV3YiSEzgjkNFx5pZpoqGjZJVf1m/c7eSGiR8GJJq9+sex1I+wrPX8+kmVbCS8e/JhRmDTTtXqwahArl8ofdYVcO3OvqE1eEfjCLIXpiYmPXZjwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724730061; c=relaxed/simple;
	bh=dqiEGoPnIof8whIkUrAdx54ftSd6zN4nOqnVHXLm+YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTiaiSoJv4YdONrnWmK2Owh7ZkOXbK5UHKM12SEdI36aqF9x6XuUyDtTsiy+FF5NaKpGKBACBvQFpbCIdIht2gANyMEz9Xwp9JLX2rT/Y3QnqgmYzS9n88Mh3x7bygh7y9oa2cL6lxh5j5h9YWt9ThmfEHajDZrNFmI5dgXKMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ja6HPA68; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 23:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724730057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k9hO/oyeDMZa3ohenIdsXi1JCSDSiKjlQBJP5uO0r1A=;
	b=ja6HPA68w1j44wzI1vRnRigboYt8UPiHOJ0FM9KDpPL9C5Ucp+T8Y1enOQMxgeE0F8pFTV
	2eXfg/YghkTDo7KymMo6JUvQy4VGhBDzlZCubVQxyl+pnIIi43HCOLRiGVbv7dWEqAbcpH
	EWa7Cov8f593mS/7UHuft6WGn8lNJus=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org
Subject: Re: bcachefs dropped writes with lockless buffered io path,
 COMPACTION/MIGRATION=y
Message-ID: <2iroae47robod2vijalby64iczk2emltrshmztlwyrxmkeiydd@4lxo55nlgpxo>
References: <ieb2nptxxk2apxfijk3qcjoxlz5uitsl5jn6tigunjmuqmkrwm@le74h3edr6oy>
 <Zs1JwTsgNQiKXkdE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs1JwTsgNQiKXkdE@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 27, 2024 at 04:36:33AM GMT, Matthew Wilcox wrote:
> On Mon, Aug 26, 2024 at 11:29:52PM -0400, Kent Overstreet wrote:
> > We had a report of corruption on nixos, on tests that build a system
> > image, it bisected to the patch that enabled buffered writes without
> > taking the inode lock:
> > 
> > https://evilpiepirate.org/git/bcachefs.git/commit/?id=7e64c86cdc6c
> > 
> > It appears that dirty folios are being dropped somehow; corrupt files,
> > when checked against good copies, have ranges of 0s that are 4k aligned
> > (modulo 2k, likely a misaligned partition).
> > 
> > Interestingly, it only triggers for QEMU - the test fails pretty
> > consistently and we have a lot of nixos users, we'd notice (via nix
> > store verifies) if the corruption was more widespread. We believe it
> > only triggers with QEMU's snapshots mode (but don't quote me on that).
> 
> Just to be crystal clear here, the corruption happens while running
> bcachefs in the qemu guest, and it doesn't matter what the host
> filesystem is?
> 
> Or did I misunderstand, and it occurs while running anything inside qemu
> on top of a bcachefs host?

The host is running bcachefs, backing qemu's disk image.

(And I'm using nested virtualization for bisecting, it's been a lot to
keep straight).

