Return-Path: <linux-fsdevel+bounces-366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2867C9C65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 00:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609561C20968
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Oct 2023 22:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3565814AAF;
	Sun, 15 Oct 2023 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mh+DtIoT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05B15D4
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Oct 2023 22:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0E2C433C7;
	Sun, 15 Oct 2023 22:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697408536;
	bh=n5eTHT4FC+5SGFkkalU1P/ultlRemjXtW9CBzRjBKvc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mh+DtIoT+xWY0xHkOQR8mY5SIv+bq0u8F6Feo6EuzF7KVWmtZCQobZIkAPXA0TOFF
	 X3QRcy7qQxKnLf8eGr18852RTZv0sTgLTzYH10I2SE4jl41BcJVPQiRKkBdqvan+rI
	 F/BnS22ZBI63kH7PqRAtZ+/aRGm3Ba+SzwS+ZVViVG3bZM74BQ3qilkDk9VxFBLxOD
	 fzkw5xT3PEEljvh7rO2h2EoyiinhXaBJrdTPStrvTlsf++GyNCoSpn96wZSbFhFdio
	 2IP+92vJPXU8+8qOIsMmEwZajXL+Xmm9okAAw3VSk+k2tkVh/1QZlTErgGY1keLtDT
	 j6VNOEiw/IjaQ==
Message-ID: <69c5d947-27a1-4feb-b823-35e33d86f74c@kernel.org>
Date: Mon, 16 Oct 2023 07:22:13 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] block: Support data lifetime in the I/O priority
 bitfield
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
 Daejun Park <daejun7.park@samsung.com>, Hannes Reinecke <hare@suse.de>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <20231005194129.1882245-4-bvanassche@acm.org>
 <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
 <46c17c1b-29be-41a3-b799-79163851f972@acm.org>
 <b0b015bf-0a27-4e89-950a-597b9fed20fb@acm.org>
 <447f3095-66cb-417b-b48c-90005d37b5d3@kernel.org>
 <4fee2c56-7631-45d2-b709-2dadea057f52@acm.org>
 <2fa9ea51-c343-4cc2-b755-a5de024bb32f@kernel.org>
 <94c58f6a-cdbf-4718-b60f-ba4082a040b5@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <94c58f6a-cdbf-4718-b60f-ba4082a040b5@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/23 05:18, Bart Van Assche wrote:
> On 10/12/23 18:08, Damien Le Moal wrote:
>> On 10/13/23 03:00, Bart Van Assche wrote:
>>> We are having this discussion because bi_ioprio is sixteen bits wide and
>>> because we don't want to make struct bio larger. How about expanding the
>>> bi_ioprio field from 16 to 32 bits and to use separate bits for CDL
>>> information and data lifetimes?
>>
>> I guess we could do that as well. User side aio_reqprio field of struct aiocb,
>> which is used by io_uring and libaio, is an int, so 32-bits also. Changing
>> bi_ioprio to match that should not cause regressions or break user space I
>> think. Kernel uapi ioprio.h will need some massaging though.
> 
> Hmm ... are we perhaps looking at different kernel versions? This is
> what I found:
> 
> $ git grep -nHE 'ioprio;|reqprio;' include/uapi/linux/{io_uring,aio_abi}.h
> include/uapi/linux/aio_abi.h:89:	__s16	aio_reqprio;
> include/uapi/linux/io_uring.h:33:	__u16	ioprio;		/* ioprio for the 
> request */

My bad. I looked at "man aio" but that is the posix AIO API, not Linux native.

> The struct iocb used for asynchronous I/O has a size of 64 bytes and
> does not have any holes. struct io_uring_sqe also has a size of 64 bytes
> and does not have any holes either. The ioprio_set() and ioprio_get()
> system calls use the data type int so these wouldn't need any changes to
> increase the number of ioprio bits.

Yes, but I think it would be better to keep the bio bi_ioprio field size synced
with the per AIO aio_reqprio/ioprio for libaio and io_uring, that is, 16-bits.

>> Reading Niklas's reply to Kanchan, I was reminded that using ioprio hint for
>> the lifetime may have one drawback: that information will be propagated to the
>> device only for direct IOs, no ? For buffered IOs, the information will be
>> lost. The other potential disadvantage of the ioprio interface is that we
>> cannot define ioprio+hint per file (or per inode really), unlike the old
>> write_hint that you initially reintroduced. Are these points blockers for the
>> user API you were thinking of ? How do you envision the user specifying
>> lifetime ? Per file ? Or are you thinking of not relying on the user to specify
>> that but rather the FS (e.g. f2fs) deciding on its own ? If it is the latter, I
>> think ioprio+hint is fine (it is simple). But if it is the former, the ioprio
>> API may not be the best suited for the job at hand.
> 
> The way I see it is that the primary purpose of the bits in the
> bi_ioprio member that are used for the data lifetime is to allow
> filesystems to provide data lifetime information to block drivers.
> 
> Specifying data lifetime information for direct I/O is convenient when
> writing test scripts that verify whether data lifetime supports works
> correctly. There may be other use cases but this is not my primary
> focus.
> 
> I think that applications that want to specify data lifetime information
> should use fcntl(fd, F_SET_RW_HINT, ...). It is up to the filesystem to
> make sure that this information ends up in the bi_ioprio field. The
> block layer is responsible for passing the information in the bi_ioprio
> member to block drivers. Filesystems can support multiple policies for
> combining the i_write_hint and other information into a data lifetime.
> See also the whint_mode restored by patch 05/15 in this series.

Explaining this in the cover letter of the series would be helpful for one to
understand your view of how the information is propagated from user to device.

I am not a fan of having a fcntl() call ending up modifying the ioprio of IOs
using hints, given that hints in themselves are already a user facing
information/API. This is confusing... What if we have a user issue direct IOs
with a lifetime value hint on a file that has a different lifetime set with
fcntl() ? And I am sure there are other corner cases like this.

Given that lifetime is per file (inode) and IO prio is per process or per I/O,
having different user APIs makes sense. The issue of not growing (if possible)
the bio and request structures remains. For bio, you identified a hole already,
so what about using another 16-bits field for lifetime ? Not sure for requests.
I thought also of a union with bi_ioprio, but that would prevent using lifetime
and IO priority together, which is not ideal.

> 
> Thanks,
> 
> Bart.

-- 
Damien Le Moal
Western Digital Research


