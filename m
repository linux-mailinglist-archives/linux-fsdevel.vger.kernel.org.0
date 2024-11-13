Return-Path: <linux-fsdevel+bounces-34586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDFB9C66AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 02:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35AEB2945B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEDB2AD21;
	Wed, 13 Nov 2024 01:25:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C56136;
	Wed, 13 Nov 2024 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461139; cv=none; b=m53TFjSyIh3/bXWaExWbx3VUJPBLbOCsY7GeOEQw/IXQL9Nkz5JNcDhKnC0Tdad1h1KxgJidXutteyR9aEelamrSA7YLQONNOsHrxTbxGDoGtm8AAqpOZHa1HWDoUSdZSNweeEPQV06jrfdg2vX864LFviAyl5qBhWfjH6FjEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461139; c=relaxed/simple;
	bh=RcozWhXqN+O6tjah6Mezp5HtLZDLBknWqNMKvUKyDo0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W0UBN3CBb57cDmJFRi6YEyIb0cgjWf+ADBKMZyCWF8qblvksSSP9A6tfnMVWcsH5qrJ6itJ0YoEt7z8J6+/ryQZwGGlSQHDFRvAeVAncqkpLYWcHHBAkt1fr8PdInKv/H+qv//FlL8puOKy71E9QRb8hgVqiyDG3JT3vPH+qcJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xp5FC2w3xz4f3jqK;
	Wed, 13 Nov 2024 09:25:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 87ED41A058E;
	Wed, 13 Nov 2024 09:25:32 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgBH77ALADRnl6taBg--.30653S2;
	Wed, 13 Nov 2024 09:25:32 +0800 (CST)
Subject: Re: [PATCH RESEND V2 0/5] Fixes and cleanups to xarray
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20241111215359.246937-1-shikemeng@huaweicloud.com>
 <20241111132816.3dcbb113241353e9a544adab@linux-foundation.org>
 <8667a8e9-8052-4a32-817a-2c4ef97ddfbe@huaweicloud.com>
 <ZzN446h5pdMsYfRa@casper.infradead.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <3bdc195d-e8ae-f82b-1d44-c3c2628afead@huaweicloud.com>
Date: Wed, 13 Nov 2024 09:25:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZzN446h5pdMsYfRa@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBH77ALADRnl6taBg--.30653S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyUJFWktryfKw13XryfXrb_yoW8AF15pa
	93Gr12kF4kG34rAwn7AayIgw1S93yxZrW5JFZ5W3y0yw13WryFkrs0gF4F9FyDCrsrCr1j
	qF42yasYv3Z8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7
	UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 11/12/2024 11:48 PM, Matthew Wilcox wrote:
> On Tue, Nov 12, 2024 at 03:05:51PM +0800, Kemeng Shi wrote:
>> Patch 1 fixes the issue that xas_find_marked() will return a sibling entry
>> to users when there is a race to replace old entry with small range with
>> a new entry with bigger range. The kernel will crash if users use returned
>> sibling entry as a valid entry.
>> For example, find_get_entry() will crash if it gets a sibling entry from
>> xas_find_marked() when trying to search a writeback folios.
> 
> You _think_ this can happen, or you've observed a crash where it _has_
> happened?  I don't think it can happen due to the various locks we
> have.  I'm not opposed to including this patch, but I don't think it
> can happen today.Sorry for confusion. As I mentioned at last email, we need to confirm if
the trigger condition exists in real world of all three potential bug. Here,
I want to describe the potential impact if the potential bug happens for
some early input.
> 
>> Patch 3 fixes the issue that xas_pause() may skip some entry unepxectedly
>> after xas_load()(may be called in xas_for_each for first entry) loads a
>> large entry with index point at mid of the entry. So we may miss to writeback
>> some dirty page and lost user data.
> 
> How do we lose user data?  The inode will still contain dirty pages.
> We might skip some pages we should not have skipped, but they'll be
> caught by a subsequent pass, no?
> 
After flush, users may expect dirty pages are in storage and are persistent. But
if we miss to writeback some dirty pages and kernel is reboot after flush, then
the data in un-written pages are last to users. I'm not sure if I miss something
are. But again, we need to confirm if the trigger condition exists in real world.

Thanks.


