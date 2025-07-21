Return-Path: <linux-fsdevel+bounces-55549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C25B0BB45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 05:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F00E18972D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 03:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C597E1FAC48;
	Mon, 21 Jul 2025 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WIlMh/K4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F11E0DEA;
	Mon, 21 Jul 2025 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753067659; cv=none; b=H2cgxKbHqh7C6JaOSHdysJ1er/5xnnMWDzw9mJ0gBWBQ0NLSwpU5kZezwE2wsUcKrlm4WVcHRRKJQPyNQdrxWZSGzBJB79rm/KvG93i/Kpk5khno0CcUKYj1nLitl1Hif5fmIhqZ+G0tGCZ38O23+FRTHJd162bNQ9LISfuQru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753067659; c=relaxed/simple;
	bh=KcIuPHoEk9AuwbE4824NkZYgCzpBO0ssry4Gl0Uvdlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvKwJkVNSpNb5D90CdxVUlHDBaIhPc97RUK6mVP/sBqnGlXojqUzutS+sXz4NpR8Y2WnUU2P3EXbKQ1xO2fSPvmpNqN3w5RKDGT991sqmfrLE9Hwa68ezZIGan9GkJz/PC7hozfKuQ7ytKZCXBgU8NznT2Wk96vOeDv6clROKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WIlMh/K4; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753067649; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lCr7ru8zjyenyzhIwOzkZiA0apFYT5PO1pQKlR1f6Gw=;
	b=WIlMh/K4n+3t+sVE+jy0ALadodWkNQy8OAtmzfR8Ss184gs6ZnsxY/onLFH5kIM24BWM72cX42JJXu0BAYGEHTd8VYqwiU2L7aYgGUIPxQELw3gF/Af3hhrM17g/bOlFjxODPJ54TDKEnKM9KyugPesZxcb70OLews/+Bce16nw=
Received: from 30.221.132.193(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjIdN4u_1753067645 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Jul 2025 11:14:06 +0800
Message-ID: <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com>
Date: Mon, 21 Jul 2025 11:14:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compressed files & the page cache
To: Barry Song <21cnbao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Barry,

On 2025/7/21 09:02, Barry Song wrote:
> On Wed, Jul 16, 2025 at 8:28 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>

...

>>
>> ... high-order folios can cause side effects on embedded devices
>> like routers and IoT devices, which still have MiBs of memory (and I
>> believe this won't change due to their use cases) but they also use
>> Linux kernel for quite long time.  In short, I don't think enabling
>> large folios for those devices is very useful, let alone limiting
>> the minimum folio order for them (It would make the filesystem not
>> suitable any more for those users.  At least that is what I never
>> want to do).  And I believe this is different from the current LBS
>> support to match hardware characteristics or LBS atomic write
>> requirement.
> 
> Given the difficulty of allocating large folios, it's always a good
> idea to have order-0 as a fallback. While I agree with your point,
> I have a slightly different perspective — enabling large folios for
> those devices might be beneficial, but the maximum order should
> remain small. I'm referring to "small" large folios.

Yeah, agreed. Having a way to limit the maximum order for those small
devices (rather than disabling it completely) would be helpful.  At
least "small" large folios could still provide benefits when memory
pressure is light.

Thanks,
Gao Xiang

> 
> Still, even with those, allocation can be difficult — especially
> since so many other allocations (which aren't large folios) can cause
> fragmentation. So having order-0 as a fallback remains important.
> 
> It seems we're missing a mechanism to enable "small" large folios
> for files. For anon large folios, we do have sysfs knobs—though they
> don’t seem to be universally appreciated. :-)
> 
> Thanks
> Barry


