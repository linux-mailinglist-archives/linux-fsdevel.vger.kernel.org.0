Return-Path: <linux-fsdevel+bounces-47161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A89A9A158
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C7E5A4017
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4AC1DE8AE;
	Thu, 24 Apr 2025 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJpXDvT5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9966D2701B8;
	Thu, 24 Apr 2025 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475370; cv=none; b=N1BvkSKwh08awuORr+3DXDrgPCwzUfyovynSQEHTilTnP0HKiBkEvf8T+ayt3hwQ/kXOKpZcC7DF2XilfZv5AQGycg3Fd3/dxCzNeSYAaxjM6zoTYjm5acfU7PNZHjOTasEZzGTZNHY4i8gRb7uLsS9xUMXcgFzem73POmXVLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475370; c=relaxed/simple;
	bh=EPXS09pZIvwkOrNJ/rTD/IshrcvAZENk8SKbEbdJf4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyP2d1MI97+eLxvtVrioTalFJjZGVOD7GRBc306vV6GOIWKUwCboh/5Yohurg562fwRh2AQppqjkVFYvFb2+Jl1YsXScGllfcRFC33P8cN9W1OETmQntoKsTCoIRz2wzHqMvl/Sx3z1gzTyjBPZd2wzVdlGsLY9wjZ850e5OM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJpXDvT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04881C4CEE3;
	Thu, 24 Apr 2025 06:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475370;
	bh=EPXS09pZIvwkOrNJ/rTD/IshrcvAZENk8SKbEbdJf4E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lJpXDvT5fLnMtpdGCPYjSzqFr31+3t/iO9xBSnukBSZ/tOaevL1zKN4I3I++9vc4n
	 J9Nl7byrw/eLpp6ZtTOj4EThdEAowC/xI7Rbfx9UXoxAklNbOgNmy0elET8x/FKSir
	 qYjJyYM2TsZE9eIcciVfIEYrF+y2803ChEfTRDVGqXMNc7ocMhiyMAXkGFbzJIyxLF
	 mcrGLWVQq/qh/5cmmEt1U9PijQ5vihvh8NQtVdgZwIcV+Lg3fDXM/kqprocV5xuAqk
	 0Zx/P7ZVf2ZOT0mnebwZz7s59xO3cafcn2ePD/5kuRgPRP+IlTjwlTsvtUtbCHcbKV
	 J0Y27C9338Q8Q==
Message-ID: <a7923f3f-1c41-4c3e-a6dc-7bb2b6ed647c@kernel.org>
Date: Thu, 24 Apr 2025 15:16:05 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] dm-integrity: use bio_add_virt_nofail
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
 <20250422142628.1553523-10-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
> bio_add_virt_nofail helper implementing it, and do the same for the
> similar pattern using bio_add_page for adding the first segment after
> a bio allocation as that can't fail either.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

