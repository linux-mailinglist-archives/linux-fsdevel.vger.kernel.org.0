Return-Path: <linux-fsdevel+bounces-33591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38219BAAA5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 02:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8928C281689
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 01:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429E41632C8;
	Mon,  4 Nov 2024 01:56:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A23214;
	Mon,  4 Nov 2024 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730685374; cv=none; b=F84f7foRoY7EwkNGtBaWNsLvcaBiyoafCspR9nIfEMwTcA4HeSbF/in0z/n7Ncm91a5EPrDAvkHGktR8ZoYVLDPjpxfLa9iMR8Udb0VEyD/e3Ymv8WPsNzvV8JXkvvubYQ5VhZunBe/BgSWhAzcFBJlO/L23iACWjb8v60j7jcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730685374; c=relaxed/simple;
	bh=JBLsFCFUyfh5SnpAOk7Agow/cXIsLWEBHl806oKUEwY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Rx4BwKAT/F3mNaqfgDyWMe13IAITjl//eAvKzAzKr2Z6zDYyMnybIeb5+iM2wlF+hdfqR4JvE5EL088K0rHjUkoGROwa06r+teBw/rqvLz45rzOpX8GKVfhDdrdTzVUhj8Xd2ijO5UjoC9AOKatvidGx1XqRMhpZdjmWt/ZWlLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XhZLf1X0Jz4f3jkm;
	Mon,  4 Nov 2024 09:55:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id EE0CF1A0196;
	Mon,  4 Nov 2024 09:56:06 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgD3n7GfKShnS_sSAw--.11192S2;
	Mon, 04 Nov 2024 09:56:06 +0800 (CST)
Subject: Re: [PATCH 4/6] Xarray: skip unneeded xas_store() and
 xas_clear_mark() in __xa_alloc()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20241101155028.11702-1-shikemeng@huaweicloud.com>
 <20241101155028.11702-5-shikemeng@huaweicloud.com>
 <ZyT7qRhtqGDe_AuO@casper.infradead.org>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <ad978b0c-b814-02ad-6304-6096d5cacf9a@huaweicloud.com>
Date: Mon, 4 Nov 2024 09:55:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZyT7qRhtqGDe_AuO@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgD3n7GfKShnS_sSAw--.11192S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1rKFW8ZF1UuF18XF1DJrb_yoWfuwbEva
	s2qr9rGwnFvrnrKa1Y9r4qg3srJF45GFW5Wr4DXan7urW7JFyDJ3yvyrn7Z3Z3Kr4fC3WD
	Jrs5Z345Jw1IqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 11/2/2024 12:02 AM, Matthew Wilcox wrote:
> On Fri, Nov 01, 2024 at 11:50:26PM +0800, Kemeng Shi wrote:
>> If xas_find_marked() failed, there is no need to call xas_store() and
>> xas_clear_mark(). Just call xas_store() and xas_clear_mark() if
>> xas_find_marked() succeed.
> 
> No.  The point of the xas interfaces is that they turn into no-ops once
> an error has occurred.
Yes, xas interfaces can tolerate error. The question is do we really need to
call xas_store(...) here if we already know there is no room to store new entry.
But no insistant on this as it's not a big deal anyway.

Will drop this on next version if you still disklike this.
Thanks.

> 
>> -		else
>> +		else {
>>  			*id = xas.xa_index;
>> -		xas_store(&xas, entry);
>> -		xas_clear_mark(&xas, XA_FREE_MARK);
>> +			xas_store(&xas, entry);
>> +			xas_clear_mark(&xas, XA_FREE_MARK);
>> +		}
>>  	} while (__xas_nomem(&xas, gfp));
>>  
>>  	return xas_error(&xas);
>> -- 
>> 2.30.0
>>
> 


