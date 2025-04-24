Return-Path: <linux-fsdevel+bounces-47157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F82A9A110
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA1F447024
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866451DF970;
	Thu, 24 Apr 2025 06:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxz40yjz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8531B424A;
	Thu, 24 Apr 2025 06:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475087; cv=none; b=tRQwCFMIflQKqz9hV9tDcEzJcowI7ivW1nQkX1rVQoCF6YYT5FCdtWXPLNGUiGhpax1H2XLhiywura7wPfWaz/JaMZYsXro3a5WiidAISBEVLjNdvyxpkLHiQCoJi6RR3GtsKVPejGH29AsViF2MV8FIFNTOmi9dEluOJK5WTGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475087; c=relaxed/simple;
	bh=+hHw7tHt2mmmNlIXAwAZyVXsarEgwDoDZ3+bfL3vS78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nm+LltjYIpuNLK3uESztkqgfZnhumgxeQx3bqI38UYKlVE2Vlz9gw5rafecWW8apDy/l1IDHMAeY87pT0iN9QSL1s0F59Q5xtynIlUNlnfIxVsphz2pwM2jGGJ1JG6Yn1fwBeCbc7piw9wsonA4cETEx6ijnP3jf3bVz9s6ild4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxz40yjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF4DC4CEE3;
	Thu, 24 Apr 2025 06:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475087;
	bh=+hHw7tHt2mmmNlIXAwAZyVXsarEgwDoDZ3+bfL3vS78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oxz40yjzre5wW/ZS61dZYXX97WLflGTERc43YEwvdiFvXsmGi2FNNbIWcSWqEhFK3
	 2squ5i6tKXnCvJFfp44fIG5PJrP3AceHuSwz3GQyfgpWfxuvy1Ha6VvzZmSqKeApq5
	 /Ib95TXVuQYBSqv3ZI9ZEw1c10zkL+x9v3WdS1T1WsD99sAqXoCks/DpRy0UKqDS3x
	 k4KrdU48fKFz0xnMqV7i2zrCt51AJvKLiLojplGQWDLLwl4nZN4uxy5cRsmPEkNk9F
	 FTUq712k5RZ3o/Lm6iJ3D4f1VgEA6U5TC+J7CysxVAQwplb6UhirrInCnjBYSO2R4U
	 zw/S9q9lC3+MQ==
Message-ID: <3f9d3577-1040-4298-acd4-340934326d25@kernel.org>
Date: Thu, 24 Apr 2025 15:11:23 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] block: pass the operation to bio_{map,copy}_kern
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
 <20250422142628.1553523-6-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> That way the bio can be allocated with the right operation already
> set and there is no need to pass the separated 'reading' argument.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

