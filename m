Return-Path: <linux-fsdevel+bounces-47860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9E3AA6359
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 20:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DB01BA80C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043062253AE;
	Thu,  1 May 2025 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVtAJy+2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8101C1F22;
	Thu,  1 May 2025 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125916; cv=none; b=Ssi0XxRzOq62sWOIi+lihbSsu+C32KIA9t7F2txGaTBjWnNTwHEL0QWtwIZSLQKR0LIhF14MFB16iBnzAwWltUd+6s2pPvcdui71z/idE4LE1MBxWThSSZcaOUkkBTo84taW5s8/iwsyoRh2WoNio/kFmFxrit8UTdAmuN8dW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125916; c=relaxed/simple;
	bh=MvpBJEAd5MibOUFCkz9qXHf76/sQpqZUQyHDuD8PBg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MofITGjIteJHg0Bh8R7ZXNK7l+woPsBvviG7lOhoU3DlC6Qi1ULIxfyY6YY+HopCGYgzi6q1EbzbSJFmUGvnIQRFEQMKgPLHMMVoH9peFxsA5h7xun/yt/VUTcJrz0XxKZZjYuHbjrSpKPp+eXIXfH9rR5uR7Yv1e7N2KAhWckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVtAJy+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231A2C4CEE3;
	Thu,  1 May 2025 18:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125914;
	bh=MvpBJEAd5MibOUFCkz9qXHf76/sQpqZUQyHDuD8PBg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EVtAJy+2MAigGQ4jUUmi9uLwBVCUEthnC2p51mjsJl/bj5X2LZirsLrUsuz4ED2HG
	 rh5IwWMrtc6xTeR5w6RqFqYVHsVAYQPxqT1VzVmahzQ14/h6kvrzSeV/3M8y7pIONX
	 SLHLWn5PI5eTSht3B/Q87TCKG6xliO2A0bdqjl/I+T4u3TvEnHJuO1FBZMzIJtby2e
	 RCJmCJfm9RbsWL30cG7Z+v8S2mIMvTYE9mv+MaImHRstezXP8+6L2f3LbGZVh+QvR4
	 OFW1txSpw/T0lG/UedF+csz/6cMHt3XLCRbVYGxUzfYbpTAGrks6tqzaSDg3Bq6PTF
	 6M8W7OMxgSw0A==
Message-ID: <1ea2b54e-b3cf-4e0d-87df-ddfbddf0ce58@kernel.org>
Date: Fri, 2 May 2025 03:58:31 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] xfs: simplify building the bio in xlog_write_iclog
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
 <20250430212159.2865803-18-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250430212159.2865803-18-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 06:21, Christoph Hellwig wrote:
> Use the bio_add_virt_nofail and bio_add_vmalloc helpers to abstract
> away the details of the memory allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

