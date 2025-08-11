Return-Path: <linux-fsdevel+bounces-57337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C60B208C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF2F16C66F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D32D3A83;
	Mon, 11 Aug 2025 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="FZOHRrf8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B2B2D3A63;
	Mon, 11 Aug 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915141; cv=none; b=tqQzH9GtJNZ9/HNYeBIwfeDp2i1Ffx63YVOn6xpK2Wa0DZe1qneu3hA7hamAfEwnTgz7T6bYbfSCfOtUYAOl+7Ypx1IaDcV495bDLdi7v0XEEtp0aKme8/ECfBDqjpPZ4tH9XnileM2zUua3em7dp7S5H1NTDOVlkGeVk4l++MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915141; c=relaxed/simple;
	bh=fyMJVnzq19HoVjaJWvf7zLPkT0rLDLhUHH3rd92MRNA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=uN4CxbaMzC5vjqFifRIPALow2Gp7MoxncrfZgca0uFZ/tGvRaM2sx+9OQDGYYCkkH5j7TCA1g9uAGNqwfnAEaitU6fV6VqMOSxYVuAaj1so7OC+Es51t8iHOs9tDkYsZlKaFnL7o5gWjw+ezKhp4ZsQxBwB3s09hqW0UHEd+hRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=FZOHRrf8; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HQe9woX2qSiEsy9FbidNroRd+9loJaekn/V3lZ85QLU=; b=FZOHRrf86TSOMsy4/15ub+Z+BD
	LFbTet6eHpszyszaAIgHBKCELIE6ELVmG9t0q5MtPAXmIDQnu9jk7AaDWU7C4jsRh1EVkP36kjE1C
	FknDVlbBbi0qjZg36w5NVnF6/nFceObERAjqBq7xb3mJ7fGrtDtIVerLQgUFq8g02YwO6Gc+/9UEb
	W4ObIv2mkyHZll42KKRpckO6O8vZMEgt3mCe3Nk6eTTV3lw1isaKLX8lgvoHIQ0FOUGaf8i0KVJPL
	696iQTN4PrVe24KXtS7mR0i28+vlv5ZLEV7MLfvHesRJ6WazuDl6ztgxaBt4ivFhKvAzJ/cJXbP3A
	fm7trYkw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.98.2)
	id 1ulRai-000000002Wy-3vkP;
	Mon, 11 Aug 2025 09:25:28 -0300
Message-ID: <9ab64c5bd90474a5e57c73cc0c48f612@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>,
 Enzo Matsumiya <ematsumiya@suse.de>
Cc: dhowells@redhat.com, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey
 <tom@talpey.com>, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix collect_sample() to handle any iterator type
In-Reply-To: <324664.1754897644@warthog.procyon.org.uk>
References: <324664.1754897644@warthog.procyon.org.uk>
Date: Mon, 11 Aug 2025 09:25:23 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> collect_sample() is used to gather samples of the data in a Write op for
> analysis to try and determine if the compression algorithm is likely to
> achieve anything more quickly than actually running the compression
> algorithm.
>
> However, collect_sample() assumes that the data it is going to be sampling
> is stored in an ITER_XARRAY-type iterator (which it now should never be)
> and doesn't actually check that it is before accessing the underlying
> xarray directly.
>
> Fix this by replacing the code with a loop that just uses the standard
> iterator functions to sample every other 2KiB block, skipping the
> intervening ones.  It's not quite the same as the previous algorithm as it
> doesn't necessarily align to the pages within an ordinary write from the
> pagecache.
>
> Note that the btrfs code from which this was derived samples the inode's
> pagecache directly rather than the iterator - but that doesn't necessarily
> work for network filesystems if O_DIRECT is in operation.
>
> Fixes: 94ae8c3fee94 ("smb: client: compress: LZ77 code improvements cleanup")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Enzo Matsumiya <ematsumiya@suse.de>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/compress.c |   71 +++++++++++++----------------------------------
>  1 file changed, 21 insertions(+), 50 deletions(-)

Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

