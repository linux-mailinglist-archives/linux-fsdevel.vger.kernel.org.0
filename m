Return-Path: <linux-fsdevel+bounces-70086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E750DC9052A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 00:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812DF3AAC93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 23:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08DE322550;
	Thu, 27 Nov 2025 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="b5TCGyWX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dTFN+/N8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2C02417F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764284737; cv=none; b=sCR4pXvE5z968/Tv3TSboAdpPIFPS+fb1siRWrEDR1QncBlP3qNYKGaClRnYkb8A7YxIbKny17KMkoi2ywRfqHBmlkZkUrHRBqKwDVKP0nzb02Xlyg6aepg0SjNbHB8vuzXLT4OAPiM7J8iBqHMtvpB2XSvf5K+OlfU8LOHyEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764284737; c=relaxed/simple;
	bh=GDngtDDNaoe7glJULc/ZFM36R0SQJQMzoVUnxYdRhp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvF4YD5KF53r5nN76x4BVouS2NA0XdXEvRPpLovRXgSWIBZH/YB2sTCRsijOFub3iHUbSisPlONE+tH3YgzRanEIqy2UHRqUm+aZHU8kIhvtMkDNpyvYbtwDMYZi74PghkzRkOydAQpnk5EGmiqm50KFh/OfgODvqXw5TNSMsdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=b5TCGyWX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dTFN+/N8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D87727A0759;
	Thu, 27 Nov 2025 18:05:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 27 Nov 2025 18:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764284733;
	 x=1764371133; bh=Nx1V4gZgXQqhewVt6261Vd/BCwPZib+mHN4ZZsAsMGk=; b=
	b5TCGyWXjQ2YgYjn2HOb9jmZqe60sYttYj4SwyDxe5kYw3Kjtdl3kUOMwaDH3AQh
	Z5trtap+u/KbZS3IxofEH1E7Ww9oIWr2z6GpfoCH2lyVpR/WdPI86zmQt/3Psr4E
	YWtyIlokp3rjQBqVnwbCgUHPlk+nSkiIxhrRFxQVfQrP01pJt0a9Bi6I/ypW2Cdf
	8NPcO/+EFqQKgl5N2H2XFPRBR+2EZa92iphzGSVd0TAqjbFbA+HKXQQHorv7chbU
	TRlatLrE6xmEQYrCE2boyxKbF8AgY9Ulr/sTHp+amsrG98TE+c213WmxPB6GW8Qa
	Xhc6gILuR0T5hRsPYrsC+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764284733; x=
	1764371133; bh=Nx1V4gZgXQqhewVt6261Vd/BCwPZib+mHN4ZZsAsMGk=; b=d
	TFN+/N8dZWe1h2SgV8u5BrS566L44qUGVFke0TzosM832bEKyqXBYyhRjaMcymTC
	10o+MsTNncaIeUBnDGVvim/uJl5i3TbgrmUKoXm9y9DHD1pCZFw6gqw5M5GwMU2N
	tdAUO/PCl1kYbP0F+zXLIw9YlvsRsxKKLkvwt3yTvZJhzxjgPHJtWxRZrW1J6tnd
	ciVOU+cD9f/Htm1KJElOhyHOIfLHFIBogE8Zvd8+nZRDBq9wtM47vUhAhaMbN8//
	LuL1yibCBYDSbbv0mjnrozamLVuV3Z7uYB2O/juAHJlFqeC+xop8O4FlGgu28PpC
	gHBLr4MuSQNFx2tlHMyPA==
X-ME-Sender: <xms:PNkoaRQ9FoEd0jUcPQGHh8m9F2KCdjNEWLf9OlP5AAMfKhv2iTq-6A>
    <xme:PNkoaRrg9LLtsBCb5eqRUga9k-1OgH1im4zTFVKIov1KVV9HEfggWokn8g37b0Q3-
    wt6KtxHbRC_CXLgrv07YBaTcQeFT5G7xTANz8YUaH7LmyQ1lrBV>
X-ME-Received: <xmr:PNkoafJZpfoxojEWVw63YS-hDAXx8J0Yx8C5r7sCLmzKwJ0aXjZXmV2sLhcsgcRpTpsWiMxSeTwwmjDTJZJKcY__Ku4e-IXIHYCHGihRWDwfY4cBB1mO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrsghhihhshhgvkhhmghhuphhtrgesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgtphht
    thhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehsfigvthhh
    vhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:PdkoaUri75Mt03lY1avuVOK93hqgIBCvIvHyMp7OH7rf6EjbfPjXqQ>
    <xmx:PdkoaXySv399G7imHnegFm6kJPfZIjpJF-F4B0ZLqAHBphoaBU-Dyw>
    <xmx:PdkoaYMgeRjrcaa1UGSxq46Zx3a-AOZb1yppPdu4M6T6wzSnkaLaGg>
    <xmx:Pdkoac7RxSfh-rhGFW1svDweCYCpBWAs4bmJuJPUg3gHy-2ttKicdg>
    <xmx:PdkoaSNXik_zJ5-gGqkdT5kDrpT7hIZWT7AOhTaKYC5ROBH2XkV8SbOX>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 18:05:31 -0500 (EST)
Message-ID: <ea9193cd-dbff-4398-8f6a-2b5be89b1fa4@bsbernd.com>
Date: Fri, 28 Nov 2025 00:05:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FUSE: [Regression] Fuse legacy path performance scaling lost in
 v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
To: Abhishek Gupta <abhishekmgupta@google.com>,
 Bernd Schubert <bschubert@ddn.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "miklos@szeredi.hu" <miklos@szeredi.hu>,
 Swetha Vadlakonda <swethv@google.com>
References: <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
 <e6a41630-c2e6-4bd9-aea9-df38238f6359@ddn.com>
 <CAPr64AJXg9nr_xG_wpy3sDtWmy2cR+HhqphCGgWSoYs2+OjQUQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAPr64AJXg9nr_xG_wpy3sDtWmy2cR+HhqphCGgWSoYs2+OjQUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Abhishek,

On 11/27/25 14:37, Abhishek Gupta wrote:
> Hi Bernd,
> 
> Thanks for looking into this.
> Please find below the fio output on 6.11 & 6.14 kernel versions.
> 
> 
> On kernel 6.11
> 
> ~/gcsfuse$ uname -a
> Linux abhishek-c4-192-west4a 6.11.0-1016-gcp #16~24.04.1-Ubuntu SMP
> Wed May 28 02:40:52 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> 
> iodepth = 1
> :~/fio-fio-3.38$ ./fio --name=randread --rw=randread
> --ioengine=io_uring --thread
> --filename_format='/home/abhishekmgupta_google_com/bucket/$jobnum'
> --filesize=1G --time_based=1 --runtime=15s --bs=4K --numjobs=1
> --iodepth=1 --group_reporting=1 --direct=1
> randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=io_uring, iodepth=1
> fio-3.38
> Starting 1 thread
> ...
> Run status group 0 (all jobs):
>    READ: bw=3311KiB/s (3391kB/s), 3311KiB/s-3311KiB/s
> (3391kB/s-3391kB/s), io=48.5MiB (50.9MB), run=15001-15001msec
> 
> iodepth=4
> :~/fio-fio-3.38$ ./fio --name=randread --rw=randread
> --ioengine=io_uring --thread
> --filename_format='/home/abhishekmgupta_google_com/bucket/$jobnum'
> --filesize=1G --time_based=1 --runtime=15s --bs=4K --numjobs=1
> --iodepth=4 --group_reporting=1 --direct=1
> randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=io_uring, iodepth=4
> fio-3.38
> Starting 1 thread
> ...
> Run status group 0 (all jobs):
>    READ: bw=11.0MiB/s (11.6MB/s), 11.0MiB/s-11.0MiB/s
> (11.6MB/s-11.6MB/s), io=166MiB (174MB), run=15002-15002msec
> 
> 
> On kernel 6.14
> 
> :~$ uname -a
> Linux abhishek-west4a-2504 6.14.0-1019-gcp #20-Ubuntu SMP Wed Oct 15
> 00:41:12 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> 
> iodepth=1
> :~$ fio --name=randread --rw=randread --ioengine=io_uring --thread
> --filename_format='/home/abhishekmgupta_google_com/bucket/$jobnum'
> --filesize=1G --time_based=1 --runtime=15s --bs=4K --numjobs=1
> --iodepth=1 --group_reporting=1 --direct=1
> randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=io_uring, iodepth=1
> fio-3.38
> Starting 1 thread
> ...
> Run status group 0 (all jobs):
>    READ: bw=3576KiB/s (3662kB/s), 3576KiB/s-3576KiB/s
> (3662kB/s-3662kB/s), io=52.4MiB (54.9MB), run=15001-15001msec
> 
> iodepth=4
> :~$ fio --name=randread --rw=randread --ioengine=io_uring --thread
> --filename_format='/home/abhishekmgupta_google_com/bucket/$jobnum'
> --filesize=1G --time_based=1 --runtime=15s --bs=4K --numjobs=1
> --iodepth=4 --group_reporting=1 --direct=1
> randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=io_uring, iodepth=4
> fio-3.38
> ...
> Run status group 0 (all jobs):
>    READ: bw=3863KiB/s (3956kB/s), 3863KiB/s-3863KiB/s
> (3956kB/s-3956kB/s), io=56.6MiB (59.3MB), run=15001-15001msec

assuming I would find some time over the weekend and with the fact that
I don't know anything about google cloud, how can I reproduce this?


Thanks,
Bernd

