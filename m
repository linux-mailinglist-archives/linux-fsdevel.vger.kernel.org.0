Return-Path: <linux-fsdevel+bounces-47169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883E8A9A1F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA60B19474E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95051F30BE;
	Thu, 24 Apr 2025 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfm7ouUP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41E1DE2CB;
	Thu, 24 Apr 2025 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475848; cv=none; b=FQxuZY7eMEOaZdqRZasRnRVDTQyq+FdIQudArva/JWwJnExQFpee8aG3zZdTrb0SRVIZzHP+Ym1Q3BMnFxQObDQosMiqeBba/t2HYFvvf/Y+L4lvzpa/9PlRAUtPb1Jtvw06V34Qi0ITmpz/iysGZC9PdKTWaUpuN9JGIQzrybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475848; c=relaxed/simple;
	bh=AGVCcNypxE2M4Y174kK1xffh4IIOlh9uBcNdIkYM0Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pq6eC6kPlsAtk662sKnx2/SjHrF0RBLOW4dn0W2PLRsaeMNtS6Wu3wGua4n1fYfdojW/Jfs/cOK3P7smKrOA6FlnIVtCGQSToT2yFyPB0wsnyQBzcdns3MC9ftjGYvudJOJFkDISm4UndiCXtPe/+2D1bOE+iz2+eVOm74IQFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfm7ouUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CB2C4CEE3;
	Thu, 24 Apr 2025 06:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475847;
	bh=AGVCcNypxE2M4Y174kK1xffh4IIOlh9uBcNdIkYM0Ts=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mfm7ouUPBJ6ICmoMazk79OgxSoo6R5GWJzCGXi1RmlT6kEwDDek+AgL2PFizkBYno
	 ERPDrh9GUBBssGfDwa2xWDowh3xlnfsl471CSF4UC3dWub+5/f4Lg6O3uZg+JtKeeL
	 v6+GI3rnReEFKS2WKxTpa18vSzH5jeevBxfc7SYlf6VVPjZxewPuvjjr9YWiHoZxeJ
	 elqfGW5+NMFnTR8OR177xCszl7saEXzCmVK1IuVauTdFkFPPF7nuGUgYRgxyv3k3lk
	 K2LIbh6vz+RLWWQ4/cPgNVTyTNB+M+rpFI+ZS/hwXxcbayQz7nOVBssLTLgwo04Mpd
	 5sd8fBhDZtoWw==
Message-ID: <51343efb-4349-47b8-8a04-5c8d0d6d32fa@kernel.org>
Date: Thu, 24 Apr 2025 15:24:03 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] zonefs: use bdev_rw_virt in zonefs_read_super
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-17-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-17-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Switch zonefs_read_super to allocate the superblock buffer using kmalloc
> which falls back to the page allocator for PAGE_SIZE allocation but
> gives us a kernel virtual address and then use bdev_rw_virt to perform
> the synchronous read into it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

