Return-Path: <linux-fsdevel+bounces-47859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E84AA6353
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 20:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178F03AF1C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EBE2253E9;
	Thu,  1 May 2025 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpLu1f+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297A21D001;
	Thu,  1 May 2025 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125866; cv=none; b=SluTnOWh/HEubJP4GlcSu5KL5Q2gCH3w3LhMEF+1N2usYWfQZffTi0V8kHSa8RQBKdScV0F2lgchDZ4t6JCzgMEnd+S+XLcH0+heZso0Rg6vJx0m1q2zwgH33d4vfABMCOcICp924c6bchmhhyxKhJFCZFYzDvwZtk2/rYI4GJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125866; c=relaxed/simple;
	bh=L6YgiajSCmaTngjiZmmqaGmsmojrz1vlo8PwMBvjpIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaHIcTvyIa7xyFKWVrI8TD1jw/LV+GohqTwGLYgxJ5ud4NjSI9fSIvqEkdWcav7m44+zleiXYF/FZ0iHIeFB6g0E0PwESEN5CTE5XA4Irva/Ydga8uSgclaIk87I46n37mxuCYJ8SDuvFLkIIqgNI7kR/CGzJmcjUbs75gQFfxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpLu1f+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AF8C4CEE3;
	Thu,  1 May 2025 18:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125865;
	bh=L6YgiajSCmaTngjiZmmqaGmsmojrz1vlo8PwMBvjpIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KpLu1f+pCTayPnOxO8p7LYVKHLi9I1et9tNZOzJZnMMagAxvCaVUuxZ4Tyh/P2905
	 HeDN/RIgeAQhIJXzdbW33ycFQPD+HdfGZusBdDp//644IAZqnJ3my5nRiQZbOQ03no
	 PSziuUx4ngoOC5MUxCiGMhoVUuxlj5nD5qEM1uIZKTuBR3N6Wl0uNfZkJDzSjkD49A
	 3b9ujHabOs5Qqh3KvB72MPRblyMIDHpl4wbJvpJ3YiSiFSVKEGsP8P9r/g1fCzQFuJ
	 GMGWH/5VYz2K7WCr1/lErYal4oSxXhOmJTI8usoRdQN1v9Xro8IbBODlJuPVg4zdoN
	 owXpwZFHxNa2A==
Message-ID: <b056d22e-7058-4c89-b8a3-e9bed9e4527e@kernel.org>
Date: Fri, 2 May 2025 03:57:41 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] xfs: simplify xfs_buf_submit_bio
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
 <20250430212159.2865803-16-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250430212159.2865803-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 06:21, Christoph Hellwig wrote:
> Convert the __bio_add_page(..., virt_to_page(), ...) pattern to the
> bio_add_virt_nofail helper implementing it and use bio_add_vmalloc
> to insulate xfs from the details of adding vmalloc memory to a bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

