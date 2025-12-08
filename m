Return-Path: <linux-fsdevel+bounces-70985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FC7CAE5E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 23:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE9C301AD2A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 22:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9572882A9;
	Mon,  8 Dec 2025 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="UiktAdiK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="svWBTjC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2617C9E
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Dec 2025 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765234622; cv=none; b=bAwfuwO4jbs/ioAuhU2k4XxBKV61u3PEr/aIIJrvxsLhC3AdKM05P5eemdGmkDkQHktKaOLZHiC6GLGdhdArDefLRDmb+TTB/3npoGHWn3qIxB80sah0AYsYDu+pnKPZQdm4pmy/kAUGQB+rPDpSfGnztSO0pWjeu7eCBg9Yk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765234622; c=relaxed/simple;
	bh=KJw50zsUCuAkLJiVi5yGF7SPx/1x8rk9p6NnzuZmkvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cL1ACApK0cSpkS1Enk9VifjwHzZnF9pysKuhjbAfGjfod5qLH8tFKzYe2PHqlL250JwIoKxc+rpf/h4DFcpSkuVQJrYaAT0YA7R0rce2vMlvLGjTX+D2cMdj1gkBTHtcTkD/h2MXI9nbhqwNsF4iBsnQTcBywTcXiYM7dG9QcxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=UiktAdiK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=svWBTjC8; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 59D9614001D1;
	Mon,  8 Dec 2025 17:56:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Dec 2025 17:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765234619;
	 x=1765321019; bh=O7IBayEbtRg+6/BlCOwLNBM+c0TN5fUo9EOW48IPSmI=; b=
	UiktAdiKbUc5hmW1EqzNags40xwLI3Uk01E5WWB7KiOC9izJl8M9apR0n814RejM
	nn2aQWhvWE7SYEDEWM6fVX4+IQIRmyr/96sl36UPLJ9xKHHT3mT0E+/Jn05rgbWH
	tY2DQ4kl3p6oGkDwJgYFeqzy34iTqWbPfS1Ps6R/anQl9un1dtsfAq0Nwi+akY/G
	S6inEzv0siZjwE0/kWVOu1BzWp9NLLTOcLuberrvyXy9Md18T04rTc8MSrpAWfJT
	8hS1eYERlmQceeKcqOkq3UxOeoBzpKIsDC7NYLybscD9eLp2kJdIQ6ZgdwTOIjzN
	0IGeujLqpZiS7X6uGqMaeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765234619; x=
	1765321019; bh=O7IBayEbtRg+6/BlCOwLNBM+c0TN5fUo9EOW48IPSmI=; b=s
	vWBTjC8sl1NeIWNrwuGIBddfWo0Zqmnb+46gZCn0dKdO5a5i6T9r5F7qmR1IXsXg
	8bmGFpJXfNto74Po+cdQZCLK4RUBodPj+g6DHBZCfoymBE2VKmD3VeJflnkFSp9i
	G4NCWAd+wVlPXZS/O/AkAvNxXeIYHEeL7u/kXXMPaNBSqq6WWzlggIwBuFwu8JJv
	Rc9R9hUDAibhLd78BfpNt7yYSfLXc2Qwnjx1qnmfr+OzIJ9CxNaSlO0glnK/4jhX
	X/5dPNIKvOW3Rm5PRz+Xs7hRlie4Wesfr7RzEQvSuThjs4cIFfpeZ0HOJVy6m5zO
	fixQwr2DLLo7DRBz85c7Q==
X-ME-Sender: <xms:u1c3afl5Y9LZmBlqVsqLi6gpar5Kwn82upADClS0gcdGLnfABo2AxQ>
    <xme:u1c3aZuLqW4Wk0Kr55qvfmPbL95SqQq_FkoqEftsMg7p348LIKuMRPx1W0bElQ2Lo
    UOpGiks3H2usnuajphmr1D45r_hPuA42F8-5UVjyhGBDkKQSU0>
X-ME-Received: <xmr:u1c3ad9FlDHciAsAdUnZp_A8C9PjzzYcSqDA4GjXzcZWC8Cm_2VE5UETV4jopE1K2Sc1wZoCLJiZ0gb90U5zU9IIFhFSqWmKZugDlTx-ZpqrQj6t6PbD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepteeigfekgfetgeelvdejieeuheffhfejkeejgfehjeejjeegueduhefgleeg
    vedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnuges
    sghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopegr
    sghhihhshhgvkhhmghhuphhtrgesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    ihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepshifvghthhhvsehgohhogh
    hlvgdrtghomh
X-ME-Proxy: <xmx:u1c3aTNEHaSjE_2ugScEvWzbruv2Ucxb2KCFB-MqjMzrUYUYWbYkag>
    <xmx:u1c3abGY1Xkxr0gKqcSv5fayq5ueLP6vxLr6aKU_ujF-btGCJG2zqg>
    <xmx:u1c3aRRjSQyJXQBUMYga09vDTghwAhQMOD_JRIZEjT8X53GAXd7pGg>
    <xmx:u1c3aYtv7C5iCArjDIz4R1jZWztlV6HjY_vW5OrbBbcP2ViRCu5NRQ>
    <xmx:u1c3aSRAZvnKXMntD0dv6w6GAfvRs7NIdfer858OxgPXyd1TOp9J9xs4>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 17:56:58 -0500 (EST)
Message-ID: <06ab8a37-530d-488f-abaf-6f0b636b3322@bsbernd.com>
Date: Mon, 8 Dec 2025 23:56:57 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FUSE: [Regression] Fuse legacy path performance scaling lost in
 v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
To: Bernd Schubert <bschubert@ddn.com>,
 Abhishek Gupta <abhishekmgupta@google.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "miklos@szeredi.hu" <miklos@szeredi.hu>,
 Swetha Vadlakonda <swethv@google.com>
References: <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
 <e6a41630-c2e6-4bd9-aea9-df38238f6359@ddn.com>
 <CAPr64AJXg9nr_xG_wpy3sDtWmy2cR+HhqphCGgWSoYs2+OjQUQ@mail.gmail.com>
 <ea9193cd-dbff-4398-8f6a-2b5be89b1fa4@bsbernd.com>
 <CAPr64A+=63MQoa6RR4SeVOb49Pqqpr8enP7NmXeZ=8YtF8D1Pg@mail.gmail.com>
 <CAPr64AKYisa=_X5fAB1ozgb3SoarKm19TD3hgwhX9csD92iBzA@mail.gmail.com>
 <bcb930c5-d526-42c9-a538-e645510bb944@ddn.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <bcb930c5-d526-42c9-a538-e645510bb944@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Abishek,

really sorry for the delay. I can see the same as you do, no improvement
with --iodepth. Although increasing the number of fio threads/jobs helps.

Interesting is that this is not what I'm seeing with passthrough_hp,
at least I think so

I had run quite some tests here
https://lore.kernel.org/r/20251003-reduced-nr-ring-queues_3-v2-6-742ff1a8fc58@ddn.com
focused on io-uring, but I had also done some tests with legacy
fuse. I was hoping I would managed to re-run today before sending
the mail, but much too late right. Will try in the morning.



Thanks,
Bernd


On 12/8/25 18:52, Bernd Schubert wrote:
> Hi Abhishek,
> 
> yes I was able to run it today, will send out a mail later. Sorry,
> rather busy with other work.
> 
> 
> Best,
> Bernd
> 
> On 12/8/25 18:43, Abhishek Gupta wrote:
>> Hi Bernd,
>>
>> Were you able to reproduce the issue locally using the steps I provided?
>> Please let me know if you require any further information or assistance.
>>
>> Thanks,
>> Abhishek
>>
>>
>> On Tue, Dec 2, 2025 at 4:12 PM Abhishek Gupta <abhishekmgupta@google.com
>> <mailto:abhishekmgupta@google.com>> wrote:
>>
>>     Hi Bernd,
>>
>>     Apologies for the delay in responding.
>>
>>     Here are the steps to reproduce the FUSE performance issue locally
>>     using a simple read-bench FUSE filesystem:
>>
>>     1. Set up the FUSE Filesystem:
>>     git clone https://github.com/jacobsa/fuse.git <https://github.com/
>>     jacobsa/fuse.git> jacobsa-fuse
>>     cd jacobsa-fuse/samples/mount_readbenchfs
>>     # Replace <mnt_dir> with your desired mount point
>>     go run mount.go --mount_point <mnt_dir>
>>
>>     2. Run Fio Benchmark (iodepth 1):
>>     fio  --name=randread --rw=randread --ioengine=io_uring --thread
>>     --filename=<mnt_dir>/test --filesize=1G --time_based=1 --runtime=5s
>>     --bs=4K --numjobs=1 --iodepth=1 --direct=1 --group_reporting=1
>>
>>     3. Run Fio Benchmark (iodepth 4):
>>     fio --name=randread --rw=randread --ioengine=io_uring --thread
>>     --filename=<mnt_dir>/test --filesize=1G --time_based=1 --runtime=5s
>>     --bs=4K --numjobs=1 --iodepth=4 --direct=1 --group_reporting=1
>>
>>
>>     Example Results on Kernel 6.14 (Regression Observed)
>>
>>     The following output shows the lack of scaling on my machine with
>>     Kernel 6.14:
>>
>>     Kernel:
>>     Linux abhishek-west4a-2504 6.14.0-1019-gcp #20-Ubuntu SMP Wed Oct 15
>>     00:41:12 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
>>
>>     Iodepth = 1:
>>     READ: bw=74.3MiB/s (77.9MB/s), ... io=372MiB (390MB), run=5001-5001msec
>>
>>     Iodepth = 4:
>>     READ: bw=87.6MiB/s (91.9MB/s), ... io=438MiB (459MB), run=5000-5000msec
>>
>>     Thanks,
>>     Abhishek
>>
>>
>>     On Fri, Nov 28, 2025 at 4:35 AM Bernd Schubert <bernd@bsbernd.com
>>     <mailto:bernd@bsbernd.com>> wrote:
>>     >
>>     > Hi Abhishek,
>>     >
>>     > On 11/27/25 14:37, Abhishek Gupta wrote:
>>     > > Hi Bernd,
>>     > >
>>     > > Thanks for looking into this.
>>     > > Please find below the fio output on 6.11 & 6.14 kernel versions.
>>     > >
>>     > >
>>     > > On kernel 6.11
>>     > >
>>     > > ~/gcsfuse$ uname -a
>>     > > Linux abhishek-c4-192-west4a 6.11.0-1016-gcp #16~24.04.1-Ubuntu SMP
>>     > > Wed May 28 02:40:52 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
>>     > >
>>     > > iodepth = 1
>>     > > :~/fio-fio-3.38$ ./fio --name=randread --rw=randread
>>     > > --ioengine=io_uring --thread
>>     > > --filename_format='/home/abhishekmgupta_google_com/bucket/$jobnum'
>>     > > --filesize=1G --time_based=1 --runtime=15s --bs=4K --numjobs=1
>>     > > --iodepth=1 --group_reporting=1 --direct=1
>>     > > randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W)
>>     4096B-4096B, (T)
>>     > > 4096B-4096B, ioengine=io_uring, iodepth=1
>>     > > fio-3.38
>>     > > Starting 1 thread
>>     > > ...
>>     > > Run status group 0 (all jobs):
>>     > >    READ: bw=3311KiB/s (3391kB/s), 3311KiB/s-3311KiB/s
>>     > > (3391kB/s-3391kB/s), io=48.5MiB (50.9MB), run=15001-15001msec
>>     > >
>>     > > iodepth=4
>>     > > :~/fio-fio-3.38$ ./fio --name=randread --rw=randread
>>     > > --ioengine=io_uring --thread
>>     > > --filename_format='/home/abhishekmgupta_google_com/bucket/$jobnum'
>>     > > --filesize=1G --time_based=1 --runtime=15s --bs=4K --numjobs=1
>>     > > --iodepth=4 --group_reporting=1 --direct=1
>>     > > randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W)
>>     4096B-4096B, (T)
>>     > > 4096B-4096B, ioengine=io_uring, iodepth=4
>>     > > fio-3.38
>>     > > Starting 1 thread
>>     > > ...
>>     > > Run status group 0 (all jobs):
>>     > >    READ: bw=11.0MiB/s (11.6MB/s), 11.0MiB/s-11.0MiB/s
>>     > > (11.6MB/s-11.6MB/s), io=166MiB (174MB), run=15002-15002msec
>>     > >
>>     > >
>>     > > On kernel 6.14
>>     > >
>>     > > :~$ uname -a
>>     > > Linux abhishek-west4a-2504 6.14.0-1019-gcp #20-Ubuntu SMP Wed Oct 15
>>     > > 00:41:12 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
>>     > >
>>     > > iodepth=1
>>     > > :~$ fio --name=randread --rw=randread --ioengine=io_uring --thread
>>     > > --filename_format='/home/abhishekmgupta_google_com/bucket/$jobnum'
>>     > > --filesize=1G --time_based=1 --runtime=15s --bs=4K --numjobs=1
>>     > > --iodepth=1 --group_reporting=1 --direct=1
>>     > > randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W)
>>     4096B-4096B, (T)
>>     > > 4096B-4096B, ioengine=io_uring, iodepth=1
>>     > > fio-3.38
>>     > > Starting 1 thread
>>     > > ...
>>     > > Run status group 0 (all jobs):
>>     > >    READ: bw=3576KiB/s (3662kB/s), 3576KiB/s-3576KiB/s
>>     > > (3662kB/s-3662kB/s), io=52.4MiB (54.9MB), run=15001-15001msec
>>     > >
>>     > > iodepth=4
>>     > > :~$ fio --name=randread --rw=randread --ioengine=io_uring --thread
>>     > > --filename_format='/home/abhishekmgupta_google_com/bucket/$jobnum'
>>     > > --filesize=1G --time_based=1 --runtime=15s --bs=4K --numjobs=1
>>     > > --iodepth=4 --group_reporting=1 --direct=1
>>     > > randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W)
>>     4096B-4096B, (T)
>>     > > 4096B-4096B, ioengine=io_uring, iodepth=4
>>     > > fio-3.38
>>     > > ...
>>     > > Run status group 0 (all jobs):
>>     > >    READ: bw=3863KiB/s (3956kB/s), 3863KiB/s-3863KiB/s
>>     > > (3956kB/s-3956kB/s), io=56.6MiB (59.3MB), run=15001-15001msec
>>     >
>>     > assuming I would find some time over the weekend and with the fact
>>     that
>>     > I don't know anything about google cloud, how can I reproduce this?
>>     >
>>     >
>>     > Thanks,
>>     > Bernd
>>
> 


