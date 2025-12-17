Return-Path: <linux-fsdevel+bounces-71558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6FFCC7623
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 941A7300BEE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE957288C26;
	Wed, 17 Dec 2025 11:41:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0756259CAF
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971708; cv=none; b=ufGpVZDiiQp43U6IRXDAP++92cC6FgMJ9ixQwouHIRjphIwCi+SfBXLDjGc9Cya+PpWOB0f/cvDgRl0EGo99xx6J3pJ1Gw13hq7XB9wFBsKEB7Hy+Hn4Ru00Zb4hBheK8Y3TgvzEJAXcKF0M9SS6hj35KfMGCrZC24y9edwp4QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971708; c=relaxed/simple;
	bh=sOV690M5VHfCcm080cRXXgQ0LEgrpe6lxjEGhgwkAek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzPDaqTZ2jOjGH4P5qkPQR99YrATb8XEuzJhi3GaImLe6LHvIoeq7Cj/+u1lshkwuk4V0qT+VMeyPInA2Twsx4dSa3MAi8koJgtyRwKId15C28VVPDy36/YKoJXkcq9G6fWC9hF8ZOySr3c55YSunlJTZ3dZykYza/SSoaqdxJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (178-062-210-188.ip-addr.inexio.net [188.210.62.178])
	by smtp04-ext3.udag.de (Postfix) with ESMTPA id 88CA1E01B1;
	Wed, 17 Dec 2025 12:34:55 +0100 (CET)
Authentication-Results: smtp04-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 17 Dec 2025 12:34:55 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Abhishek Gupta <abhishekmgupta@google.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "miklos@szeredi.hu" <miklos@szeredi.hu>, 
	Swetha Vadlakonda <swethv@google.com>, "Vikas Jain (GCS)" <vikj@google.com>
Subject: Re: Re: FUSE: [Regression] Fuse legacy path performance scaling lost
 in v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
Message-ID: <syxcri2ecemhhvbri5rztmnme6sanwyn2qtvnzsyrl24xfhcqt@v3th2xa23lxj>
References: <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
 <e6a41630-c2e6-4bd9-aea9-df38238f6359@ddn.com>
 <CAPr64AJXg9nr_xG_wpy3sDtWmy2cR+HhqphCGgWSoYs2+OjQUQ@mail.gmail.com>
 <ea9193cd-dbff-4398-8f6a-2b5be89b1fa4@bsbernd.com>
 <CAPr64A+=63MQoa6RR4SeVOb49Pqqpr8enP7NmXeZ=8YtF8D1Pg@mail.gmail.com>
 <CAPr64AKYisa=_X5fAB1ozgb3SoarKm19TD3hgwhX9csD92iBzA@mail.gmail.com>
 <bcb930c5-d526-42c9-a538-e645510bb944@ddn.com>
 <06ab8a37-530d-488f-abaf-6f0b636b3322@bsbernd.com>
 <CAJnrk1aSEaLo20FU36VQiMTS0NZ6XqvcguQ+Wp90jpwWbXo0hg@mail.gmail.com>
 <CAPr64AJW35BHBrOuZZfiB+SBL+bRmfNj3h7zY+ge8aZHgYU8rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPr64AJW35BHBrOuZZfiB+SBL+bRmfNj3h7zY+ge8aZHgYU8rA@mail.gmail.com>

On Wed, Dec 17, 2025 at 02:47:00PM +0530, Abhishek Gupta wrote:
> Hi Joanne, Bernd,
> 
> I'm seeing this regression on passthrough_hp as well. Checked it on
> 6.14.0-1019-gcp and I was getting 11.7MiB/s with iodepth 1 & 15.6
> MiB/s with iodepth 4. To remove ambiguity (due to kernel versions), I
> tried it on stock kernel 6.17 as well. Please find below more details:
> 
> # Installed stock kernel 6.17
> $ uname -a
> Linux abhishek-ubuntu2510.us-west4-a.c.gcs-fuse-test.internal 6.17.0
> #2 SMP Tue Dec 16 12:14:53 UTC 2025 x86_64 GNU/Linux
> 
> # Running it as sudo to ensure passthrough is allowed (& we don't get
> permission error for passthrough)
> $ sudo ./example/passthrough_hp --debug ~/test_source/ ~/test_mount/
> DEBUG: lookup(): name=test2.bin, parent=1
> DEBUG:do_lookup:410 inode 3527901 count 1
> DEBUG: lookup(): created userspace inode 3527901; fd = 9
> DEBUG: setup shared backing file 1 for inode 136392323632296
> DEBUG: closed backing file 1 for inode 136392323632296
> 
> # iodepth 1
> $ sudo fio --name=randread --rw=randread --ioengine=io_uring --thread
> --filename_format='/home/abhishekmgupta_google_com/test_mount/test.bin'
> --filesize=1G --time_based=1 --runtime=15s --bs=4K --numjobs=1
> --iodepth=1 --group_reporting=1 --direct=1
> randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=io_uring, iodepth=1
> fio-3.39
> Starting 1 thread ...
> Run status group 0 (all jobs):
>    READ: bw=11.4MiB/s (11.9MB/s), 11.4MiB/s-11.4MiB/s
> (11.9MB/s-11.9MB/s), io=170MiB (179MB), run=15001-15001msec
> 
> #iodepth 4
> $ sudo fio --name=randread --rw=randread --ioengine=io_uring --thread
> --filename_format='/home/abhishekmgupta_google_com/test_mount/test.bin'
> --filesize=1G --time_based=1 --runtime=15s --bs=4K --numjobs=1
> --iodepth=4 --group_reporting=1 --direct=1
> randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=io_uring, iodepth=4
> fio-3.39
> Starting 1 thread ...
> Run status group 0 (all jobs):
>    READ: bw=18.3MiB/s (19.2MB/s), 18.3MiB/s-18.3MiB/s
> (19.2MB/s-19.2MB/s), io=275MiB (288MB), run=15002-15002msec
> 
> Also, I tried to build the for-next branch against both kernel 6.18 &
> 6.17 (to figure out the culprit commit), but I got compilation errors.
> Which kernel version should I build the for-next branch against?

Hi Abhishek,

since I have been debugging some memory problems for 6.12 I'm somewhat familiar with the changes since.
After diffing the differences from v6.14 to v6.17 in the fs/fuse/ directory
the big topics of that whole journey were the move to folios, the timeouts and iomap changes.

None of which should make that kind of a difference.
I'd rather expect it to be slightly faster due 
to the removal of the tmp pages.

IIRC the default passthrough_hp does not use io-uring.

Are you using fuse over io-uring or the normal device?

Cheers,
Horst

