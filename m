Return-Path: <linux-fsdevel+bounces-55590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25697B0C36B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B85542240
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 11:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5223E2D59FC;
	Mon, 21 Jul 2025 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rlb+UE5M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA972BE7B6;
	Mon, 21 Jul 2025 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098029; cv=none; b=aKJd4AdnW7GjFzgar4wxUn5zl2NpRmM4OttDywUugereOIlSss6GKblKDTadfXq1b5G3gQfabw93FFJs4rM4CROnzpPsdqiZ2DrdLYqisT0Ftnyy5XoCAAa3RD+h3ulXdgwtPuG2AoJ+gh20QWFp9kBUSAA2F2jUBhtGwpRIdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098029; c=relaxed/simple;
	bh=P27JgD4W7aeNDmUhVxQx19p6ani2xRr7SVoxgJhV6vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDxSC6NBkbbdSGcqZrB87QFQ0XqXUm1YR34lKTgivM83yeObVZi7Fbz1fxnfP3BmTTFXiWN2bx/EAvkd7g27t6dANup/MtPHRWl+YTU396eudHsUSKF0f24R5422A7jN5haFGq0ekKyCxAwBcusxtn1M/rqO7wSsDRp9aNpiPXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rlb+UE5M; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753098018; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8/0MxmZXQFEgx1v9g0Zx0cK6D0Dzk/CVwttHZ2ijYQw=;
	b=rlb+UE5Mhah/tXQBkkpUnzaa/eCCM8S8xrv5UsEc5B9GHxRDZ+NSVZXjbq2u6YBBv7rCc7TvDcG3JMAS+5c5AK6sKtmDPQNruwVuoJXAWg/Pu7y9VZS7244wGGzjdQe7mzQkqUWRzukEp2HrEP9fpwH24M/z6Bjw3T0Cd/zskmU=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjOEKZd_1753098012 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Jul 2025 19:40:15 +0800
Message-ID: <de793a0d-b65e-4b36-ad7f-3202515ba9c9@linux.alibaba.com>
Date: Mon, 21 Jul 2025 19:40:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compressed files & the page cache
To: Jan Kara <jack@suse.cz>
Cc: Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
 Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>,
 Hailong Liu <hailong.liu@oppo.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
 <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
 <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
 <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com>
 <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jan,

On 2025/7/21 18:25, Jan Kara wrote:
> On Mon 21-07-25 11:14:02, Gao Xiang wrote:
>> Hi Barry,
>>
>> On 2025/7/21 09:02, Barry Song wrote:
>>> On Wed, Jul 16, 2025 at 8:28 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>>
>>
>> ...
>>
>>>>
>>>> ... high-order folios can cause side effects on embedded devices
>>>> like routers and IoT devices, which still have MiBs of memory (and I
>>>> believe this won't change due to their use cases) but they also use
>>>> Linux kernel for quite long time.  In short, I don't think enabling
>>>> large folios for those devices is very useful, let alone limiting
>>>> the minimum folio order for them (It would make the filesystem not
>>>> suitable any more for those users.  At least that is what I never
>>>> want to do).  And I believe this is different from the current LBS
>>>> support to match hardware characteristics or LBS atomic write
>>>> requirement.
>>>
>>> Given the difficulty of allocating large folios, it's always a good
>>> idea to have order-0 as a fallback. While I agree with your point,
>>> I have a slightly different perspective — enabling large folios for
>>> those devices might be beneficial, but the maximum order should
>>> remain small. I'm referring to "small" large folios.
>>
>> Yeah, agreed. Having a way to limit the maximum order for those small
>> devices (rather than disabling it completely) would be helpful.  At
>> least "small" large folios could still provide benefits when memory
>> pressure is light.
> 
> Well, in the page cache you can tune not only the minimum but also the
> maximum order of a folio being allocated for each inode. Btrfs and ext4
> already use this functionality. So in principle the functionality is there,
> it is "just" a question of proper user interfaces or automatic logic to
> tune this limit.

Yes, I took a quick glance of the current ext4 and btrfs cases
weeks ago which use this to fulfill the journal reservation
for example.

but considering that specific memory overhead use cases (to
limit maximum large folio order for small devices), it sounds
more like a generic page cache user interface for all
filesystems instead, and in the effective maximum order should
combine these two maximum numbers.

Thanks,
Gao Xiang

> 
> 								Honza


