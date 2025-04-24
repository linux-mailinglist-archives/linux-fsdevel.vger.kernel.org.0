Return-Path: <linux-fsdevel+bounces-47158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C73A9A11B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A16194648D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D337B1DE4E1;
	Thu, 24 Apr 2025 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjayD/GA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D12701B8;
	Thu, 24 Apr 2025 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475241; cv=none; b=Hs0JD//GrYvXY+37TzV3M/kto2GO9RSbLAXqBQUsjhMYoO00w98D8HdSH/oNc7CFI0AaHnLI6RNp/Q7gyLzdmBuiuZjJluYkwXhGV41qbR925+i/dWC4Q5iEdSTQypKep2MLxEnvAzxJubX8MkDytQF3L5pXuREqczikzVxnEaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475241; c=relaxed/simple;
	bh=Z2EuEeb1jZ0ixNFWXOaJHagz3aDqUppqslgKOeW6oJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klfQd5P+S684b6RCIs5hwOSIZ4QhEyx+BtYo/v/DbwIDvh12KwjLbrR5CsP3ESgbN+wzAOvCx6PiBE8ieZrs0n+6TUGOYubl6HM1r1c1xgZGmgCg2g/eLATxN6wf0hgEmcaJEXlpK5k1GyzTOCpi0wlQLVoZfrqPRP+FUaTCWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjayD/GA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9B7C4CEE3;
	Thu, 24 Apr 2025 06:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475240;
	bh=Z2EuEeb1jZ0ixNFWXOaJHagz3aDqUppqslgKOeW6oJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VjayD/GAlDli5M9WUdc/bYenpaUdJm0q5WIMXEvf6AMQwaWskH4a+qfx3xt4TeLSC
	 naqMTT9kmU8RUPhnr902kegL3u1Y0OTRxjnQTwh0T6j6ARU6rFOoqcMGZdC1ZNIvhR
	 6gHYw1aRlEVeZDa9rzMTGF9UjGIHT6BgYAmpGEQjEObnrM+YIHggFuFUIZaMXO4H8v
	 t0oiMaxSCE450eQIoE2wRzAKtYtYYvDQPel4ALoiUUwvJy4+PDaACeVNwAfnTw8L9X
	 U5coOzUZPuN5ISqzHrs70yeP95LM2R5moa3x2o034kOmyw7vQXLj9lPtWblMRwccqu
	 Zxq6vDMjXyKzg==
Message-ID: <4fe5de45-812f-419e-9913-a410ade09626@kernel.org>
Date: Thu, 24 Apr 2025 15:13:56 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] block: simplify bio_map_kern
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
 <20250422142628.1553523-7-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Split bio_map_kern into a simple version that can use bio_add_virt_nofail
> for kernel direct mapping addresses and a more complex bio_map_vmalloc
> with the logic to chunk up and map vmalloc ranges using the
> bio_add_vmalloc helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

