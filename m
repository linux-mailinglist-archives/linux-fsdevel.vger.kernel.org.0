Return-Path: <linux-fsdevel+bounces-55593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD608B0C3B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 13:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1A2188EFD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6EB2D12F5;
	Mon, 21 Jul 2025 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="okMnN41H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9272BE04A;
	Mon, 21 Jul 2025 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098772; cv=none; b=jFbNHJjFq4TJJlq3Mdpo6LZ68miqH0GMZQHPXxli8cvMdP6GUnZ3d3c8vIukSAOS23yJ/WfQpM8I02q4CcwVOmvzINZP96A62M7o/5SSfNIZf/PgWW8k1IauWa+k9/2W+Rw4aeXN2M7rHTK2UFGG3WJePIbQBMftooFenfFkGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098772; c=relaxed/simple;
	bh=ZeBBuHgBp4hEsDwcktk9JG73t4T3D8iVzH6QmW+hg+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uz8C5pYsQ5UDn0Fs6mwgjIDeYxdz7WsxkpDPBob8TF5dWs3RBEuDNY78uQbjIFI7IDRysN9Nl97utyjE11X+riqriLtSpvlasK1dPjoEyJWI5V1cu+1PUCjkZd5VLdIwWGlkQWucXISNxG3q9ewiA9WQdeRrGz5y613C9mcgb+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=okMnN41H; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753098762; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xn+hlC0ADjp0KbawmAyVX05nJJetj+qoWgSmW+bOOXA=;
	b=okMnN41HP5taCoXf1kbwUjIL3RJaMTGT0sxm9zAdfpRQfDlcz8KmbyRg51Kx9Ub4jXm0EbA3/4Cag9yTKGqpWol3Np7Oqo/SmmeZ9zjhb54Lcli6EcLl+n425ovo+/Bl+T9RWjeW5B4L8KmDDvMqlMjkmLJKzvxSKqZHG/gMQao=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjOEOJD_1753098756 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Jul 2025 19:52:39 +0800
Message-ID: <5b01d35c-b73b-4c04-906d-6abc0c9e37ce@linux.alibaba.com>
Date: Mon, 21 Jul 2025 19:52:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compressed files & the page cache
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Jan Kara <jack@suse.cz>
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
 Hailong Liu <hailong.liu@oppo.com>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
 <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
 <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
 <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com>
 <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
 <85946346-8bfd-4164-a49d-594b4a158588@gmx.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <85946346-8bfd-4164-a49d-594b4a158588@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/21 19:36, Qu Wenruo wrote:
> 
> 
> 在 2025/7/21 19:55, Jan Kara 写道:
>> On Mon 21-07-25 11:14:02, Gao Xiang wrote:
>>> Hi Barry,
>>>
>>> On 2025/7/21 09:02, Barry Song wrote:
>>>> On Wed, Jul 16, 2025 at 8:28 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> [...]
>>>> Given the difficulty of allocating large folios, it's always a good
>>>> idea to have order-0 as a fallback. While I agree with your point,
>>>> I have a slightly different perspective — enabling large folios for
>>>> those devices might be beneficial, but the maximum order should
>>>> remain small. I'm referring to "small" large folios.
>>>
>>> Yeah, agreed. Having a way to limit the maximum order for those small
>>> devices (rather than disabling it completely) would be helpful.  At
>>> least "small" large folios could still provide benefits when memory
>>> pressure is light.
>>
>> Well, in the page cache you can tune not only the minimum but also the
>> maximum order of a folio being allocated for each inode. Btrfs and ext4
>> already use this functionality. So in principle the functionality is there,
>> it is "just" a question of proper user interfaces or automatic logic to
>> tune this limit.
>>
>>                                 Honza
> 
> And enabling large folios doesn't mean all fs operations will grab an unnecessarily large folio.
> 
> For buffered write, all those filesystem will only try to get folios as large as necessary, not overly large.
> 
> This means if the user space program is always doing buffered IO in a power-of-two unit (and aligned offset of course), the folio size will match the buffer size perfectly (if we have enough memory).
> 
> So for properly aligned buffered writes, large folios won't really cause  unnecessarily large folios, meanwhile brings all the benefits.

That really depends on the user behavior & I/O pattern and
could cause unexpected spike.

Anyway, IMHO, how to limit the maximum order may be useful
for small devices if large folios is enabled.  When direct
reclaim is the common case, it might be too late.

Thanks,
Gao Xiang

> 
> 
> Although I'm not familiar enough with filemap to comment on folio read and readahead...
> 
> Thanks,
> Qu


