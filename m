Return-Path: <linux-fsdevel+bounces-26176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3F895561A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 09:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 873E9B221FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 07:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9968113FD69;
	Sat, 17 Aug 2024 07:16:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5411213D880;
	Sat, 17 Aug 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723879008; cv=none; b=NuKP6NVqTfu8bJeY7WM7gozNQwgyUzWCJjdTaSg7MWPRRsNLb0fXBt+CxswdrKUtsUMpx9+rO3RCY18pVPM5pqMOlB2q/35qVjxIPWH4ZC24BldLiDLNkZoSZDKglLq0fhGOl3ftC7HWiy6MAWRYJmp6MoKi3r0B1EAq/rkK1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723879008; c=relaxed/simple;
	bh=H5vRJ7qWKzwCuSYttmlCbpKT8XxX86cdHL5br20y1d0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Xz6koxbIZcZIVzYLT5aEr2Zj3gtz+ZFHcPgyKjS2qk4A88E2dm/Fn42Lv9E6TuPwKCgzOqtj54rSFuHhkcVoDh2NeIKkjbvSKZf/1mX7ywN0JilqEo5kZ8SOEsRTTWPE1VPxpzAgt0mzWyNXzoitkrWkQN6C7G7BUF3hmcebL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wm9Bx72Tdz4f3jYx;
	Sat, 17 Aug 2024 15:16:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 725BC1A0568;
	Sat, 17 Aug 2024 15:16:35 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoRRTsBm_Bq0Bw--.39554S3;
	Sat, 17 Aug 2024 15:16:35 +0800 (CST)
Subject: Re: [PATCH v2 5/6] iomap: don't mark blocks uptodate after partial
 zeroing
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-6-yi.zhang@huaweicloud.com>
 <ZsArnB9ItrxUmXHW@casper.infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <5a3dd916-19a3-7c61-e19d-f257907ae47d@huaweicloud.com>
Date: Sat, 17 Aug 2024 15:16:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZsArnB9ItrxUmXHW@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXPoRRTsBm_Bq0Bw--.39554S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4kWw13ZryUGw1rZryrZwb_yoWxCFc_uw
	1kuw1kAFZ8W3Z3Aa45C3W5J3s7KFn5XF47Xr4Fy347Cr9rWF93Ar40krn3GrsavF43GFy5
	Cwsavr48AFn3XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/17 12:48, Matthew Wilcox wrote:
> On Mon, Aug 12, 2024 at 08:11:58PM +0800, Zhang Yi wrote:
>> +++ b/fs/iomap/buffered-io.c
>> @@ -744,8 +744,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>>  					poff, plen, srcmap);
>>  			if (status)
>>  				return status;
>> +			iomap_set_range_uptodate(folio, poff, plen);
>>  		}
>> -		iomap_set_range_uptodate(folio, poff, plen);
>>  	} while ((block_start += plen) < block_end);
> 
> Um, what I meant was to just delete the iomap_set_range_uptodate()
> call in __iomap_write_begin() altogether.  We'll call it soon enough in
> __iomap_write_end().
> 

Yeah! Looks reasonable to me.

Thanks,
Yi.


