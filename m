Return-Path: <linux-fsdevel+bounces-51335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D158AD5A5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBD916D4A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14EB1C84A0;
	Wed, 11 Jun 2025 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="W/Qwl9S2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580F1AAA11;
	Wed, 11 Jun 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655452; cv=none; b=ekdA43jcJ8YPFHuimBTnBR1GiI+mjqoY5Eqm4l6fOJay6zlg3jXAO3CZZvF/y0uo2O5JFzElRqTp+JOYncFysDGMinollTJs90TjTx7MZ9EL79t1XSkaHppUo4YYjaFEUV0io4rTHYeupaoYdfNel6DFOK4255897AVqGrELyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655452; c=relaxed/simple;
	bh=4ZJrxbQD7Wq1zQl7il+htYlEl74rivfaeLej9OYZtSY=;
	h=Subject:Message-ID:Date:MIME-Version:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XlrYQSRdAulNCcvpwKF2wUWllhwvo4tleLOh6RyTOLThNA6hUCPz45qWVxI5OyRwaH5QDOdEgv0vmIOkIgMn9nZ+5vYi0P9X7H6BOb9QOmnSi+HnpqjHWykgANtafL64ThqTBTrEOxvWs5MSoj0szz8zBhsH3BOnL020RxJ2MSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=W/Qwl9S2; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749655450; x=1781191450;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=T4o6YcPRF1U1tvznrJTs87/iT7vaJoRM/tUg+dY5ocQ=;
  b=W/Qwl9S2MnJkQDuXGkdsmWpSZMK5NJ/YC8vch2AQMsHRbGReoo8Obl4P
   piq2FyNxWgKe1w+uiEaGsNDlKcnQ2BTApg9lxVJs+pSIu/lglkdLg4WSp
   3kYjkwv7OCo7OQK5DLYaWOL4kLyfnn1ZeDBvffPySRNHJjehb2HDzi7xA
   EC46aMEIStFkz8Fdgnc8uaPCCRASyIcY8pZuCDLWMt+hfpRDDWATduJ4B
   4GyD/OIuqnsC6KOo52J541bq1u12EPUZ/V8t52zFn4kHeoL5DReiHZtSI
   fy/9KjC0wEr8WKjlzl3yBBo1lRHe3wsSO+ZKtGnZRwT2q2O3upB0lhzAf
   g==;
X-IronPort-AV: E=Sophos;i="6.16,228,1744070400"; 
   d="scan'208";a="754310820"
Subject: Re: [PATCH] Revert "block: don't reorder requests in blk_add_rq_to_plug"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 15:24:08 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:34556]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.8.92:2525] with esmtp (Farcaster)
 id 3f9813e5-609c-48b8-930f-26a74422b933; Wed, 11 Jun 2025 15:24:08 +0000 (UTC)
X-Farcaster-Flow-ID: 3f9813e5-609c-48b8-930f-26a74422b933
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 15:24:08 +0000
Received: from [192.168.11.154] (10.106.82.32) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 15:24:07 +0000
Message-ID: <32c83d67-1d69-4d69-8d00-274cf0d0ff62@amazon.com>
Date: Wed, 11 Jun 2025 16:24:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ming Lei <ming.lei@redhat.com>
CC: <stable@vger.kernel.org>, kernel test robot <oliver.sang@intel.com>, Hagar
 Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>, "Jens Axboe"
	<axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-nvme@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>
References: <20250611121626.7252-1-abuehaze@amazon.com>
 <aEmcZLGtQFWMDDXZ@fedora>
Content-Language: en-US
From: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
In-Reply-To: <aEmcZLGtQFWMDDXZ@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D006EUC003.ant.amazon.com (10.252.51.252) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

On 11/06/2025 16:10, Ming Lei wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Wed, Jun 11, 2025 at 12:14:54PM +0000, Hazem Mohamed Abuelfotoh wrote:
>> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
>>
>> Commit <e70c301faece> ("block: don't reorder requests in
>> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
>> list, this had significant impact on bio merging with requests exist on
>> the plug list. This impact has been reported in [1] and could easily be
>> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
>> having any filesystem on the disk.
>>
>> My benchmark is:
>>
>>      fio --time_based --name=benchmark --size=50G --rw=randwrite \
>>        --runtime=60 --filename="/dev/nvme1n1" --ioengine=psync \
>>        --randrepeat=0 --iodepth=1 --fsync=64 --invalidate=1 \
>>        --verify=0 --verify_fatal=0 --blocksize=4k --numjobs=4 \
>>        --group_reporting
>>
>> On 1.9TiB SSD(180K Max IOPS) attached to i3.16xlarge AWS EC2 instance.
>>
>> Kernel        |  fio (B.W MiB/sec)  | I/O size (iostat)
>> --------------+---------------------+--------------------
>> 6.15.1        |   362               |  2KiB
>> 6.15.1+revert |   660 (+82%)        |  4KiB
>> --------------+---------------------+--------------------
> 
> I just run one quick test in my test VM, but can't reproduce it.

Possibly you aren't hitting the Disk IOPS limit because you are using 
more powerful SSD? In this case I am using i3.16xlarge EC2 instance 
running AL2023 or may be fio has different behavior across Distribution. 
In AL2023 we have fio-3.32

> Also be curious, why does writeback produce so many 2KiB bios?

Good question unfortunately I don't have a good answer on why we have
2KB bios although I am specifying 4K as I/O size in fio, this is 
something we probably should explore further.

Hazem




