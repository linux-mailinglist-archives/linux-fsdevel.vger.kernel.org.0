Return-Path: <linux-fsdevel+bounces-47163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFEBA9A16B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7ABA19462A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4F1DEFE1;
	Thu, 24 Apr 2025 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9q3vq6X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7031A23A6;
	Thu, 24 Apr 2025 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475421; cv=none; b=UxiUmmU8OTvNl/oOz9p1qjCsgL5dP/TAEnjUcOX63qPVmandVEZxLaL7Gzj0Oi74dgYzRZejiztkb/fjuPyc6BitSQAzQpkNZpm6LnHiT2P5XmfxkCpfdzr4kh7IgEGiG5AHRQtSQ3fibJceCx4DSgbh9lxtIambL2zJdnEBBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475421; c=relaxed/simple;
	bh=6Xr09O4vCci9bOT2aPxJNqlx8do8UkjpuOWegDKQYe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDCSd2J1pj0xLA5ZNN5K0KkT2I/GtYAgubC5x93i3/dyV7d7EUmQnGUGAc/023Qv7ITtFGnYydA9U1k99LfPE9X4TAL2Yw4xahZJTEYIl6HDrfg/6YpZ5tSaCxJJLxjimtHOPQs4SELKJJoW5Ht4UmXhJ+itZA9/95dxWtog2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9q3vq6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E364C4CEE3;
	Thu, 24 Apr 2025 06:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475420;
	bh=6Xr09O4vCci9bOT2aPxJNqlx8do8UkjpuOWegDKQYe0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i9q3vq6XqRMOlIjBqJfWt3YXyAPNWK2AMXHM9noe+CCtMjsdzZ+teAgMKraScwTPq
	 CAjL+WB+Tf7opMcRTjF2LnTdX0XhPfq5arjGfIYs2BHP6DJNn64mvbo6msP0P50c9F
	 xBjexaw588r7dFM3uMKmPqKYHBGlvxdUHap27Vv3YlLnKvia786LhMEsOQpvUgLhxv
	 4oUSmoB1N1lv+KegTKr/d3/WBE7npfBuR/jZHiIJA1/fPPIl+g3Ssx2SRKSWGFtGAb
	 jeFgc8PS0GHz0nuk8pdV3FRCatvDzcDoZA9HJT48EzWEb52GgPLmx2PcnQUWlxprUR
	 ckWJBnId7IfYg==
Message-ID: <6ef9ea43-bcc0-49a4-a855-d926f4601e1d@kernel.org>
Date: Thu, 24 Apr 2025 15:16:56 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] rnbd-srv: use bio_add_virt_nofail
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
 <20250422142628.1553523-11-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Use the bio_add_virt_nofail to add a single kernel virtual address
> to a bio as that can't fail.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

