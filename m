Return-Path: <linux-fsdevel+bounces-47164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184FBA9A176
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC8D448380
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA511DF24E;
	Thu, 24 Apr 2025 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Utble3CD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659042701B8;
	Thu, 24 Apr 2025 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475510; cv=none; b=BNAuXWJ8LQ0B0F7exVrXhRSobhwoAv4TYsHHRAPmh9Zzogf0AM92FJSObZrvbmQxwL5Ft3+qLUcfT8xl6+uyRJLxs+stjjNWlW3twKdVvEdMF22SkBWJNp6gNXAqORmvNrMGppXwHEKo62BqnLzfU9YHSs5VGvrXTC6uMiSeY1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475510; c=relaxed/simple;
	bh=I4qz/7K3xCJ9coNmZ53jQlf+KBbj24RL9BOVlrXTf94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftOGrPjjI2c0K7PVTzWZcnJgJwkVabbvdQcSIjWxPOuDOacq+biMLKvs+/CqMHL5MLyQpNqunntrNka6RrTIe0MEJbtvYH/rTp+HCtvjQ24ao5zGn2iP3j9d4DiyzkkVZWsZfQhhtxI0RDev7HuTm4kXpAapvRx3EWVDwOGY+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Utble3CD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2404C4CEE3;
	Thu, 24 Apr 2025 06:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475509;
	bh=I4qz/7K3xCJ9coNmZ53jQlf+KBbj24RL9BOVlrXTf94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Utble3CDM/3kqc5lr8z+pwI3xIlYaSZvxcuoFUgQN4dBZWL8p78gt3Y4OQd9pc85y
	 RVb7f2clPPjLKwtqmV9FaJRp/RrsAykWfoc/Tx7o/QIpXzE3MfJ+gmQ/bKGOnsMTVr
	 C06TyIpZOon0JC4seJF8w44ZAndrDWdTri6CdH2zDA71NnNtfJgg4d9s7GshC04C2s
	 ZfJ33gKFmAnHZ9OLkxfgDmnHigfDjsS8+xIzW3054MF1ovjQMGfmUzc8SQ0+ra7DlD
	 KfwdLXhz1uypuveSwtZ/UtJ8+ftHwF0oDpHuQDmvc3dZ5D8pq4pVp6jS4IGcvSAlkY
	 T4OQYaX7b0QoA==
Message-ID: <44cedbce-95db-489f-bd41-385b446f77f6@kernel.org>
Date: Thu, 24 Apr 2025 15:18:25 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] xfs: simplify xfs_buf_submit_bio
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
 <20250422142628.1553523-12-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
> bio_add_virt_nofail helper implementing it and use bio_add_vmalloc
> to insulate xfs from the details of adding vmalloc memory to a bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

