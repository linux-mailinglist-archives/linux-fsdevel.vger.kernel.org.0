Return-Path: <linux-fsdevel+bounces-47855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8864BAA6319
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 20:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E870A1BC3889
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053592248AE;
	Thu,  1 May 2025 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr9Rodi2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB01DC9B5;
	Thu,  1 May 2025 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125413; cv=none; b=JI2mKrYNMc5g22NDM1eE8fSf059jUAoXTemniaR9nbNfWGwk0XTl64J//ffiahr/VPn3jtOtc6jT4QfIi9GYv+CNIBug2jXRE6yWAvU0pRO+Y8bCWKafZ+vMR2iJ0GVKlb/XzE6huGCHpWmqV18dkwSYdS/bOP3QiSeTsnyctI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125413; c=relaxed/simple;
	bh=DGkgMiy9qf4q/9Mpq+Bp+yn/dM48QFRWxdUShMpmv6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYZkafBxchfOvKu/nnHbQoQ4dLQPe/cF3ghAuZL8lxhjVSVU+PMLvt8HxcTeuFW9dNA99Do7b517F5InhGEGraEAcDZHIINxBHp5SfIIZHxqAZ6ui8Eu7pBRf2KmE/nF8xO76qqB/7dq4OYGkIk27H6McE7VqUo3eLuF5uE+1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr9Rodi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02023C4CEE3;
	Thu,  1 May 2025 18:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125412;
	bh=DGkgMiy9qf4q/9Mpq+Bp+yn/dM48QFRWxdUShMpmv6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hr9Rodi2VemJ07IFwLyeDI5OSpxzfoGqZr/8WdDi5QtwnFmknmBZFJNRfa6Q73S/q
	 ZQEW8TcOwrNx8mpX1qNmOscLBXnET6FXF/rEO+4iECwMKQt1PcG0S1AFsPSvV6npwS
	 ZJ7cXuLGl+Ou8z2Whys8uem17jPJxVMxHB6uugOQ0fWttfE7/qYal1GJlDLVVB6z1e
	 xZUfRtPO4RLXub08NwbEEmK4/3RWy9A9joY2yyjIRczpQVvHKYqcxk/RX+Mt2H93cG
	 R95xJ6UTzEiHRERBxeCGKQOGdvTNyycwycQ22MDHq4mIe/a01RNuNvHL+BibDkHvh/
	 HrCL1tVBV6d/Q==
Message-ID: <f5df09ec-9543-41da-9d4e-05d7f2c24e0f@kernel.org>
Date: Fri, 2 May 2025 03:50:08 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/19] block: add a bio_add_max_vecs helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, slava@dubeyko.com,
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250430212159.2865803-1-hch@lst.de>
 <20250430212159.2865803-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250430212159.2865803-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 06:21, Christoph Hellwig wrote:
> Add a helper to check how many bio_vecs are needed to add a kernel
> virtual address range to a bio, accounting for the always contiguous
> direct mapping and vmalloc mappings that usually need a bio_vec
> per page sized chunk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

