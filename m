Return-Path: <linux-fsdevel+bounces-47167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBE9A9A19D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F04462862
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B361E1E06;
	Thu, 24 Apr 2025 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siKS2erO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08821DDC21;
	Thu, 24 Apr 2025 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475701; cv=none; b=JPFa71KDiUrRBKjqMrZtMDq16tGb/UCmXgndf8oIxmFud6tDDhSDIPI1mTiph9iyrhwfQQFqI1ofEqGoDeN1iy81670+ndiDE+1Q7+icT+f8ksHIErgWDkYhk/b7eEZebq5nKNUDFwVkJRb9b76b7R4AgRnAZ8Wf/1xpDv7vhv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475701; c=relaxed/simple;
	bh=dwYQkBO2LcdIccYmfP+l9N2F4HoZ6fR32ZCHy1xVZuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPF3auJ2ZtpohnvOJch3AR/OnwDsLYoKIZP4lbmFv9r6IP7SHgzDeqkZ14NcuPdn6r5oYRPCZhIgVB7luyQ2vOMVHOd8UuONZY+a1yWhHoM2joPtqx+KF2XMpvnaafq4x2EcsNI+/Dkyrdqn9NM219UTSF79IbpVLbdqaxtUfi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siKS2erO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B784C4CEE3;
	Thu, 24 Apr 2025 06:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475701;
	bh=dwYQkBO2LcdIccYmfP+l9N2F4HoZ6fR32ZCHy1xVZuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=siKS2erOX8Uz6NF6CawNFV1MCMIxsi4suAKLq8/tLRIW9AuzH80l5DMy9mYQs6mpH
	 vFGvq79N0+0tXv0AFwOhBzMpjsz+oA3ZgkrlxdMcv5X9YbF7cRKJQEtlv69GRmfABN
	 UQReW6cdANyHNiq8S31NriN4kPNIhZoJ8yRkQ3TolFcMBPerFvVCRfW295EVPZcLR+
	 9Youi3OMa7GeBnJSbXzFYsRxoBDtQfL+mEmJi86oa6UY5CO0qjMaoLO/2jBPAykFWh
	 O7NTq2MdVl3Oagzr32pwfOerRGc0QOrzdv+LGLUD9i3BsomZoUMP1Hq1eM20EeQb4o
	 kRyjhCu2mpMSA==
Message-ID: <54a3a696-0fac-4fc7-a634-60cdd2a8c3ca@kernel.org>
Date: Thu, 24 Apr 2025 15:21:37 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] hfsplus: use bdev_rw_virt in hfsplus_submit_bio
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
 <20250422142628.1553523-15-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-15-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Replace the code building a bio from a kernel direct map address and
> submitting it synchronously with the bdev_rw_virt helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

