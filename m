Return-Path: <linux-fsdevel+bounces-47162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D536A9A162
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EF85A3F9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E331DFDBB;
	Thu, 24 Apr 2025 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrvHOCyn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100462701B8;
	Thu, 24 Apr 2025 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475396; cv=none; b=OhKuaMmS1rVWzDjXTR17VG/pFlsIh2erS41YQHlFC7ddfXB66NgqFIcYcyCpBuPn/aPR1fzQYNbKmLYR36SIG7Pob1KN1kH2GYcpJyX0ZcqKSE79MmRfQaEvfL4ULmeo+t65WKO9nIBxqINlOD8tfPoBVcb3Hy6N3IxeVfEN6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475396; c=relaxed/simple;
	bh=6Xr09O4vCci9bOT2aPxJNqlx8do8UkjpuOWegDKQYe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COEr5m3QkeusFY1IRmWzJYgez9k6/Q4c7fAjZzCrzUzDbBlqXlhOIirkrL5Sfy8colTAudyrTzS9l02aTu6fdagNE03HL0E0V6SztL1KyvuHYXgbpKC/iZt4T4vNnSgvlcJ9HgynjugSsHoRCkvDJ1mo5StcCRRZn0ckfaMYJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrvHOCyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B61C4CEE3;
	Thu, 24 Apr 2025 06:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745475395;
	bh=6Xr09O4vCci9bOT2aPxJNqlx8do8UkjpuOWegDKQYe0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qrvHOCynOgl/Zlfo7/JzMoAPOaVll83jSfnhkeJoC0LCFBExEz2ioNhHV6naejhy5
	 9RqnPT9cDZIeVk4qk5LTWWqwyphJg3AX5urGsDpndzPlMLR6tZoT7XjNdXisrRKxEu
	 nC/SBJE527mcVPLDiWMfuluDlayU0mP/Azeq3eoQFkrMo7gVapev3sq92x6VQNRipZ
	 FqCFPIoGZkWNthyTMPyAa45xcO/YkTuJZiAc+cu9DOQvya+UZErajJSxIGbfeP8G6b
	 Phxk+tFGuZ5um99G01r8cmcDpR3vg+0/oB6yPLfal54diyHEaMI49MMjAC9qy9cJ6Y
	 Wen4y9nnCkavg==
Message-ID: <baa7c2a6-35e9-4a57-8c9b-bce5f4976fbe@kernel.org>
Date: Thu, 24 Apr 2025 15:16:31 +0900
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

