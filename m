Return-Path: <linux-fsdevel+bounces-33036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDF69B22B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 03:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBE99B217A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 02:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60175156F3C;
	Mon, 28 Oct 2024 02:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TWJSFPj2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0E558BC
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730082503; cv=none; b=sg+HYiVlF33uuWfjR+vFxLTxGIqhCPfyqLhywLcDe3GrmXVPogy2cHF2y5/vM2s25AqAxONyGaavCqwi4e0HRLa6AXi1d4zc2N4bytEy3YOmjFGgfHu+Uqy3wK+aW420S/PKyUJdt+KNprmODltrDSItjPXRxkC/VTw4Au/mVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730082503; c=relaxed/simple;
	bh=sM0wPb+VcYyUVNqH+zKZp7Cgc/ws+aHQp54KfoTL74E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjU8qFhFlg81ndjZDVHfS5o0wgS0xM6WbQ5gtRdCpufqOtte+/Nj4M0o50MRO9W3I/1xzTDt4mZ98oTYmAQ5u/qwVJFTGwLU5def1zRHC2DXzjEk0jfcF1bKJETps9WmsOR7wxOWe/IhkP9VKLp4tODhMk2ub9L6DjDPdKYFOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TWJSFPj2; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730082490; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VFQl1w/gX77WPMQusxQCra6sXMLdIY9lsYhIe+TixHg=;
	b=TWJSFPj2tPxzNjh2MEzT54pMzMxTHSH5BAsvH4mIva+bVxuig6V3sWnuvLDkG/fG1TEZWb0lgW6unekxQxz3QorBE6QYEHj4rERKnL2Kjofpl1aNwW0j5igQMfuRdwbbIkb5493JMaub6WyNAd431vrYOJvPMGY0y2lPLTvIM54=
Received: from 30.221.148.132(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WHz.MBB_1730082488 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 10:28:09 +0800
Message-ID: <5825a89f-7994-4de5-aecb-ebb6e3f94488@linux.alibaba.com>
Date: Mon, 28 Oct 2024 10:28:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-fsdevel@vger.kernel.org,
 josef@toxicpanda.com, bernd.schubert@fastmail.fm, hannes@cmpxchg.org,
 linux-mm@kvack.org, kernel-team@meta.com
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
 <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
 <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
 <CAJnrk1aB3MehpTx6OM=J_5jgs_Xo+euAZBRGLGB+1HYX66URHQ@mail.gmail.com>
 <CAJnrk1YFPZ8=7s4m-CP02_416syO+zDLjNSBrYteUqm8ovoHSQ@mail.gmail.com>
 <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com>
 <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
 <CAJnrk1Z_+WOcD1W2SHX83Z_89b6LZtPMGH6GDPNW-V5BD_VY9Q@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1Z_+WOcD1W2SHX83Z_89b6LZtPMGH6GDPNW-V5BD_VY9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/26/24 2:47 AM, Joanne Koong wrote:
> On Fri, Oct 25, 2024 at 10:36 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> On Thu, Oct 24, 2024 at 6:38 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>
>>>
>>>
>>> On 10/25/24 12:54 AM, Joanne Koong wrote:
>>>> On Mon, Oct 21, 2024 at 2:05 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>>>>
>>>>> On Mon, Oct 21, 2024 at 3:15 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>>>
>>>>>> On Fri, 18 Oct 2024 at 07:31, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>>>>
>>>>>>> I feel like this is too much restrictive and I am still not sure why
>>>>>>> blocking on fuse folios served by non-privileges fuse server is worse
>>>>>>> than blocking on folios served from the network.
>>>>>>
>>>>>> Might be.  But historically fuse had this behavior and I'd be very
>>>>>> reluctant to change that unconditionally.
>>>>>>
>>>>>> With a systemwide maximal timeout for fuse requests it might make
>>>>>> sense to allow sync(2), etc. to wait for fuse writeback.
>>>>>>
>>>>>> Without a timeout allowing fuse servers to block sync(2) indefinitely
>>>>>> seems rather risky.
>>>>>
>>>>> Could we skip waiting on writeback in sync(2) if it's a fuse folio?
>>>>> That seems in line with the sync(2) documentation Jingbo referenced
>>>>> earlier where it states "The writing, although scheduled, is not
>>>>> necessarily complete upon return from sync()."
>>>>> https://pubs.opengroup.org/onlinepubs/9699919799/functions/sync.html
>>>>>
>>>>
>>>> So I think the answer to this is "no" for Linux. What the Linux man
>>>> page for sync(2) says:
>>>>
>>>> "According to the standard specification (e.g., POSIX.1-2001), sync()
>>>> schedules the writes, but may return before the actual writing is
>>>> done.  However Linux waits for I/O completions, and thus sync() or
>>>> syncfs() provide the same guarantees as fsync() called on every file
>>>> in the system or filesystem respectively." [1]
>>>
>>> Actually as for FUSE, IIUC the writeback is not guaranteed to be
>>> completed when sync(2) returns since the temp page mechanism.  When
>>> sync(2) returns, PG_writeback is indeed cleared for all original pages
>>> (in the address_space), while the real writeback work (initiated from
>>> temp page) may be still in progress.
>>>
>>
>> That's a great point. It seems like we can just skip waiting on
>> writeback to finish for fuse folios in sync(2) altogether then. I'll
>> look into what's the best way to do this.
> 
> I think the most straightforward way to do this for sync(2) is to add
> the mapping check inside sync_bdevs(). With something like:
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 738e3c8457e7..bcb2b6d3db94 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1247,7 +1247,7 @@ void sync_bdevs(bool wait)
>                 mutex_lock(&bdev->bd_disk->open_mutex);
>                 if (!atomic_read(&bdev->bd_openers)) {
>                         ; /* skip */
> -               } else if (wait) {
> +               } else if (wait &&
> !mapping_no_writeback_wait(inode->i_mapping)) {
>                         /*
>                          * We keep the error status of individual mapping so
>                          * that applications can catch the writeback error using
> 
> 

I'm afraid we are waiting in wait_sb_inodes (ksys_sync -> sync_inodes_sb
-> wait_sb_inodes) rather than sync_bdevs.  sync_bdevs() is used to
writeback and sync the metadata residing on the block device directly
such as the superblock.  It is sync_inodes_one_sb() that actually
writeback inodes.


-- 
Thanks,
Jingbo

