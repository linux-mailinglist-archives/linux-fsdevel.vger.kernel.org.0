Return-Path: <linux-fsdevel+bounces-79213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFjvNOfXpmnHWgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:45:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE341EFA8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 13:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FBD3309EE8E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 12:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1202E1D516C;
	Tue,  3 Mar 2026 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="o25fQL/r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lj79Usfj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877011E487;
	Tue,  3 Mar 2026 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541448; cv=none; b=owmJYzXyaowHvXreVUTg0wPkntv9uYUfLRZbZSU2X61CUG6kR9LUCVEtgp51W35antL7CgaNYqyXKztBeK+jUB7flF/qd4Pdtc8DZAthJlrPWhZjHV+KdIfMHP2MIuVmBo8FHe6Rmw0PXzQ8HDLn+G7311dUM4vAHOGdYgkn9OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541448; c=relaxed/simple;
	bh=aXoSr4H6i+Q6L7XDbeyPiJqsUe2LawDGHZ/4hphn3wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KH/9ZqlV2Oi7JeuPRiZy879OV/xJGFF6j0rC16wagJbtrfYgWPu1W8J6dsnxsSaSNr7VwSVBYST4F+6N8oNPai6J387w6pZHRNcRCRLBmx/mrma0vEhHRAJ4glUEEDRtd/M3jmzjwJkuI+9SOMv+xFQBfnXHGQGpBjkRuPzdKYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=o25fQL/r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lj79Usfj; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 77A3C1D00165;
	Tue,  3 Mar 2026 07:37:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 03 Mar 2026 07:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772541445;
	 x=1772627845; bh=h6z8jGvysGKGF5Q2jaCxYObJv4fCC3nCU2KhWN2REt8=; b=
	o25fQL/rSjE8KxLqcGroE95HkitDbrdaNUBrenNwCLx4z/lid6KRur4Q2WXXxI2Q
	hh+De95W5iCB9Jll+P0B7Tg99gxdxHDrcCmlD3ur6Edt3Etnt4Nh42cwn4YA4tet
	A/dG4J8wKE/cI97oQ7MRz/WvaHpKh6ela5w6CDhLWqpCioYexzXyOtBjGVWQOQ3g
	PnGKR/3AO3qnOI5jGJAQXn/XrA7cokNg1Xbd9YAOA6el/VcmUCTGTlKFOhpRVyar
	uBIH8WPyxZm2nWYGKDlBO3p9zpwKIJsmA9gazezKkOnACuYfeFt79jk1hbOBYcg/
	+IPdSYbJtT+idP2R8m1Yhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772541445; x=
	1772627845; bh=h6z8jGvysGKGF5Q2jaCxYObJv4fCC3nCU2KhWN2REt8=; b=L
	j79Usfj2jVHho4c/JdI9mT/Lx7BJ+aoaMQz+scHB62r1fWIKcpg8O5Tvwuux9Ss3
	h4G1WGy6/BWSEGaDXHlRVymBi/xQtvD8f37CY6L+Tykvo476dn4IUvDGWbMYtsef
	lxx4/gnJ1OeSRXEnYtjeRBB5Z5x6HHqt4Gv7eiUCfDlTBO+Vph3z4wpi3ceWf5by
	kW46QfIUwrbg271cQ4GE8szHafjlI0sgZTWaklCkNynTdPZRRMNOROnqLQlYOADs
	MXy3T5uCxyr9cNnVCUnhjFVZQVNpkj8W0e0mf7Rl/FePWOO12Vc6N2KSJBZA5hFy
	nZNRRYkoKVFT8MkJo4eTA==
X-ME-Sender: <xms:BNamaZ2WnR-1oTO9pvRGaF_odSrBqPcMJ9UR1T8Mhak8jNZqSVU-Yg>
    <xme:BNamabBNVpnOcQrcYkrsLcurOCZ6SSoU2i4D-qsDV6cTHU5IbZ0a-y6AHwvqxWcIY
    MvqJIRF0707srrAP94xFalS0ICWFA97BqH-bmm-4msbijfIDsTf>
X-ME-Received: <xmr:BNamaY6q0x9AoHlfLlLGfFuBg6CKuTF2BGEaZPlm-KEdl3QQjQ84pLQFbZ5zQt9sIjNdjbo8BCO5z5vydHuYUKXTn_Hktg6BmikuInAPwtoDbRvo0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejgfeljeeuffehhfeukedvudfhteethedtheefjefhveduteehhfdttedv
    keekveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    gvfhhflhgvgihusehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepsghs
    tghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvg
    guihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegtughinhhgseguughnrdgtohhm
X-ME-Proxy: <xmx:BNamacI2ERaASgGcmuQUKrNLpmA4fQVyEM88IeAGi7KOCplF_fFFTw>
    <xmx:BNamaZt4on5MESKT5_pDTRNH4E5FfWbJgfpSAwuY8rGojx7j7IBUEQ>
    <xmx:BNamaTIKHAtKvJU5qYGBYWjxj4LuwNdu6Ha3hDFNxg2OJOb7pawwLg>
    <xmx:BNamaa8X5vWjro3nShKHWn3Ps3-SKW2yYFsVK85gc4PwfBSyEq8azQ>
    <xmx:Bdamafn5S7zDq0_aMvZynP6CjbwdBjQ7firH3x0OhAp3mU7OONwQSu2p>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 07:37:23 -0500 (EST)
Message-ID: <e548152e-a831-4b5a-bc18-52fdb7dc1d7f@bsbernd.com>
Date: Tue, 3 Mar 2026 13:37:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: move page cache invalidation after AIO to workqueue
To: Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert
 <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cheng Ding <cding@ddn.com>
References: <20260303-async-dio-aio-cache-invalidation-v1-1-fba0fd0426c3@ddn.com>
 <8e322296-52c7-4826-adb3-7fb476cdf35b@linux.alibaba.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <8e322296-52c7-4826-adb3-7fb476cdf35b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2DE341EFA8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-79213-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,bsbernd.com:dkim,bsbernd.com:mid,ddn.com:email]
X-Rspamd-Action: no action



On 3/3/26 13:03, Jingbo Xu wrote:
> 
> 
> On 3/3/26 6:23 PM, Bernd Schubert wrote:
>> From: Cheng Ding <cding@ddn.com>
>>
>> Invalidating the page cache in fuse_aio_complete() causes deadlock.
>> Call Trace:
>>  <TASK>
>>  __schedule+0x27c/0x6b0
>>  schedule+0x33/0x110
>>  io_schedule+0x46/0x80
>>  folio_wait_bit_common+0x136/0x330
>>  __folio_lock+0x17/0x30
>>  invalidate_inode_pages2_range+0x1d2/0x4f0
>>  fuse_aio_complete+0x258/0x270 [fuse]
>>  fuse_aio_complete_req+0x87/0xd0 [fuse]
>>  fuse_request_end+0x18e/0x200 [fuse]
>>  fuse_uring_req_end+0x87/0xd0 [fuse]
>>  fuse_uring_cmd+0x241/0xf20 [fuse]
>>  io_uring_cmd+0x9f/0x140
>>  io_issue_sqe+0x193/0x410
>>  io_submit_sqes+0x128/0x3e0
>>  __do_sys_io_uring_enter+0x2ea/0x490
>>  __x64_sys_io_uring_enter+0x22/0x40
>>
>> Move the invalidate_inode_pages2_range() call to a workqueue worker
>> to avoid this issue. This approach is similar to
>> iomap_dio_bio_end_io().
>>
>> (Minor edit by Bernd to avoid a merge conflict in Miklos' for-next
>> branch). The commit is based on that branch with the addition of
>> https://lore.kernel.org/r/20260111073701.6071-1-jefflexu@linux.alibaba.com)
> 
> I think it would be better to completely drop my previous patch and
> rework on the bare ground, as the patch
> (https://lore.kernel.org/r/20260111073701.6071-1-jefflexu@linux.alibaba.com)
> is only in Miklos's branch, not merged to the master yet.
> 
> 
> After reverting my previous patch, I think it would be cleaner by:
> 
> 
> "The page cache invalidation for FOPEN_DIRECT_IO write in
> fuse_direct_io() is moved to fuse_direct_write_iter() (with any progress
> in write), to keep consistent with generic_file_direct_write().  This
> covers the scenarios of both synchronous FOPEN_DIRECT_IO write
> (regardless FUSE_ASYNC_DIO) and asynchronous FOPEN_DIRECT_IO write
> without FUSE_ASYNC_DIO.
> 
> After that, only asynchronous direct write (for both FOPEN_DIRECT_IO and
> non-FOPEN_DIRECT_IO) with FUSE_ASYNC_DIO is left."

I think your suggestion moves into this direction

https://lore.kernel.org/all/20230918150313.3845114-1-bschubert@ddn.com/


Thanks,
Bernd


