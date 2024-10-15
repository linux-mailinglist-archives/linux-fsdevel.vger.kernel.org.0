Return-Path: <linux-fsdevel+bounces-32039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB02399FC7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 01:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF174283D55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 23:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B914D1D63E2;
	Tue, 15 Oct 2024 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D53LHxDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322B21E3CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729035260; cv=none; b=lfpNIs445hy0/RPOkYX8l3w70fxKAta1rizlhuxfT5dVhXkG1AKMB+ByVKkH37Jn7Wmw+dqZ49cooHGwPnNIlzk3pYfmiEYQh0D2Pa257r6Tf1dbh3IhpSUX+4Y67gjEVvSTu+0PUsqs92dXBiKUhXa+ljY+aYeVV7yJVEDk9MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729035260; c=relaxed/simple;
	bh=SXX8O/sLlccrZ5N07Bice1ruODGEWHYpZjbH8/E1ozQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4gzQjOLw7Ulr9/Z61JKqUAihiawzenEnnkh2yy7lVTPfNAyzkl3LJo2EjXuS2NJTCZzSOEDSpVy2oboI08te/YapNDxk/OZih15lcVt7HeiMKdI3k53PygQupKyGRPLM4HS0zNPAC90MhFy9NuLFY0EZXeMdLXEV5s04pAph18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D53LHxDy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AzMmlvJIAYiSx5KY5lZihaP3U7n28sJ4HX7OmlEqjss=; b=D53LHxDyt9jkmiuA4fCd+TJ2Sx
	n5MG8YPnZasArG4ON7L++cNFyaH5QQ9HGS/bjtkuRAvDkF+Mk5VAtwUptesou1ENS5JWesU8p6J1E
	PmI6CmeMXxOQoOOcq9iosXOXGiSEUQXox1/dQdlPAnDgmjaoCFJ5MCsBIFdiKWaC40IhO5glEgxDZ
	SbMikTlxV4gfyNs4nwifAMygRpOGnOlBaskJYIV2LggUGPTV221DSP2t1VCtNRSRcyQSXm+IomOx+
	bTYLd3R0tGs593en6eyKNXMVIGCWvtCaAqbeJ/RdvneQ86KzBjQojyMprwN9aig0LlANpQbLizlXS
	Ni0Yc0yQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0r3P-00000004Chc-3yCn;
	Tue, 15 Oct 2024 23:34:16 +0000
Date: Wed, 16 Oct 2024 00:34:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 0/6] initramfs: reduce buffer footprint
Message-ID: <20241015233415.GG4017910@ZenIV>
References: <20241015133016.23468-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015133016.23468-1-ddiss@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 15, 2024 at 01:11:57PM +0000, David Disseldorp wrote:
> There are a number of stack, heap and data-segment buffers which are
> unnecessary for initramfs unpacking. This patchset attempts to remove
> them by:
> - parsing cpio hex strings in place, instead of copying them for
>   nul-termination. (Patches 1 & 2).
> - reusing a single heap buffer for cpio header, file and symlink paths,
>   instead of three separate buffers. (Patches 3 & 4).
> - reusing the heap-allocated cpio buffer across both builtin and
>   bootloader-provided unpack attempts. (Patch 5).
> - reusing the heap-allocated cpio buffer for error messages on
>   FSM-exit, instead of a data-segment buffer. (Patch 6).
> 
> I've flagged this as an RFC as I'd like to improve the commit messages
> and also provide more thorough testing, likely via kunit / kselftest
> integration.

Umm...  An obvious question: what's the point?  Reducing the amount of
temporary allocations (and not particularly large ones, at that) done
during early boot and freed before we run anything in user mode?

