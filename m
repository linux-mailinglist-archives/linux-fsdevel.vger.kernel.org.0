Return-Path: <linux-fsdevel+bounces-715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE14C7CECCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 02:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F71D1F22FED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 00:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3EC9469;
	Thu, 19 Oct 2023 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAoKYohH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3E9444
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 00:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCECC433C8;
	Thu, 19 Oct 2023 00:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697675628;
	bh=ub2poWEDZ0m0k0zYhYsMeLfrRJ9CszztgPlp7gkyR6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VAoKYohHcNKvxXDF0IRZlFnNr5/U6M+ayq9rFQB8OmA3ZYwqlRYojwuRI5hYeLn6S
	 hbrTy7C/ExndfUg1OnXA4h74TmR7oZVbw1NfaLma/lfd2chkwK+DDCddrvfF0s3w7N
	 jzc61RtGLkjzN6r5g2gPAglp/CZlzLrtSGRCCnj0x7NkFPeGc5WDaR34WBKRAeEOIA
	 J+rTS2J1olJuj9UgoXD3cF/eCE6UQvfZtyP8eWm5p0FIjKfpDlNXuC+wqq4kM5HWMP
	 yWV/UL0RiL8AtHD7Q38NpzT9iMAikySnQgJ7axXLQl473Ax/aclHzIsYpB4KhqxvLX
	 wbWkV3PgQXgxw==
Message-ID: <e2e56cdf-0cfe-4c5b-991f-ea6a80452891@kernel.org>
Date: Thu, 19 Oct 2023 09:33:46 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] Pass data temperature information to SCSI disk
 devices
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
 Daejun Park <daejun7.park@samsung.com>
References: <20231017204739.3409052-1-bvanassche@acm.org>
 <3f3c2289-3185-4895-92cb-0692e3ca9ebc@kernel.dk>
 <e8b49fac-77ce-4b61-ac4d-e4ace58d8319@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e8b49fac-77ce-4b61-ac4d-e4ace58d8319@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/23 04:34, Bart Van Assche wrote:
> 
> On 10/18/23 12:09, Jens Axboe wrote:
>> My main hesitation with this is that there's a big gap between what
>> makes theoretical sense and practical sense. When we previously tried
>> this, turns out devices retained the data temperature on media, as
>> expected, but tossed it out when data was GC'ed. That made it more of a
>> benchmarking case than anything else. How do we know that things are
>> better now? In previous postings I've seen you point at some papers, but
>> I'm mostly concerned with practical use cases and devices. Are there any
>> results, at all, from that? Or is this a case of vendors asking for
>> something to check some marketing boxes or have value add?
> 
> Hi Jens,
> 
> Multiple UFS vendors made it clear to me that this feature is essential 
> for their UFS devices to perform well. I will reach out to some of these
> vendors off-list and will ask them to share performance numbers.
> 
> A note: persistent stream support is a feature that was only added
> recently in the latest SCSI SBC-5 draft. This SCSI specification change
> allows SCSI device vendors to interpret the GROUP NUMBER field as a data
> lifetime. UFS device vendors interpret the GROUP NUMBER field as a data
> lifetime since a long time - long before this was allowed by the SCSI
> standards. See also the "ContextID" feature in the UFS specification.
> That feature is mentioned in every version of the UFS specification I
> have access to. The oldest version of the UFS specification I have
> access to is version 2.2, published in 2016.
> (https://www.jedec.org/system/files/docs/JESD220C-2_2.pdf). This
> document is available free of charge after an account has been created 
> on the JEDEC website.
> 
>> I'm also really against growing struct bio just for this. Why is patch 2
>> not just using the ioprio field at least?
> 
> Hmm ... shouldn't the bits in the ioprio field in struct bio have the
> same meaning as in the ioprio fields used in interfaces between user
> space and the kernel? Damien Le Moal asked me not to use any of the
> ioprio bits passing data lifetime information from user space to the kernel.

I said so in the context that if lifetime is a per-inode property, then ioprio
is the wrong interface since the ioprio API is per process or per IO. There is a
mismatch.

One version of your patch series used fnctl() to set the lifetime per inoe,
which is fine, and then used the BIO ioprio to pass the lifetime down to the
device driver. That is in theory a nice trick, but that creates conflicts with
the userspace ioprio API if the user uses that at the same time.

So may be we should change bio ioprio from int to u16 and use the freedup u16
for lifetime. With that, things are cleanly separated without growing struct bio.

> 
> Is it clear that the size of struct bio has not been changed because the
> new bi_lifetime member fills a hole in struct bio?

When the struct is randomized, holes move or disappear. Don't count on that...

> 
> Thanks,
> 
> Bart.
> 
> 

-- 
Damien Le Moal
Western Digital Research


