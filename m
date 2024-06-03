Return-Path: <linux-fsdevel+bounces-20820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F22538D83CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECD31C219AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118A12D765;
	Mon,  3 Jun 2024 13:24:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694A12D1F4;
	Mon,  3 Jun 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421040; cv=none; b=WcvcxMePdq35M/Wv4gogFpUpCvncf0bVqxSzE/u+E+diMmiBa+Q2RMp929eF2cXSdIoybCYDgYpZQnol6VHCntra3zClCAEObKGXJ6iFSZ98SEx/KHG/9aTyBTV5U4+5yoGI5IgDPPew7l2pA7RA4Y9N/uLkfxyqA+D3z365tKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421040; c=relaxed/simple;
	bh=udMEuk2A2ogGiCDA9gXwFSBeuO3i5em6Eu0uB+qAV04=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hugLxGvCjY9s7UfWFJC+ihD9examJcBrxMyZgxs82XnJ4LDU+p0JetePTgSdhxendRk/ooaBiWf4GoZ5SjC9Oqc4iTXP1/WcoZUwNcfUhySRrzMkPSD70YNtMemDimsaw/JST4WthVS/A6rP9hQp2nA0va0tw+ubPRUv3nVLIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VtDvM17rCz4f3m75;
	Mon,  3 Jun 2024 21:23:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 340D41A0170;
	Mon,  3 Jun 2024 21:23:54 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgCnyw7ow11mnudLOw--.43837S3;
	Mon, 03 Jun 2024 21:23:54 +0800 (CST)
Subject: Re: [RFC PATCH v4 3/8] iomap: pass blocksize to iomap_truncate_page()
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, brauner@kernel.org,
 david@fromorbit.com, chandanbabu@kernel.org, jack@suse.cz,
 willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-4-yi.zhang@huaweicloud.com>
 <ZlnE7vrk_dmrqUxC@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <4dad0661-fad4-cac3-ffcc-0485ae62b823@huaweicloud.com>
Date: Mon, 3 Jun 2024 21:23:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZlnE7vrk_dmrqUxC@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCnyw7ow11mnudLOw--.43837S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw43uFy5tr43urW8Jr4DXFb_yoWDKrg_u3
	92qFyvq3W8CrnxZF43Cr13JrZxtF1q9r9xWFZ8X3y2vasxWFZrAFZ29F97CFn5ta1IkrnI
	yryYgF48Cry7ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/31 20:39, Christoph Hellwig wrote:
>> -		const struct iomap_ops *ops)
>> +iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
>> +		bool *did_zero, const struct iomap_ops *ops)
>>  {
>> -	unsigned int blocksize = i_blocksize(inode);
>> -	unsigned int off = pos & (blocksize - 1);
>> +	unsigned int off = rem_u64(pos, blocksize);
>>  
>>  	/* Block boundary? Nothing to do */
>>  	if (!off)
> 
> Instad of passing yet another argument here, can we just kill
> iomap_truncate_page?
> 
> I.e. just open code the rem_u64 and 0 offset check in the only caller
> and call iomap_zero_range.  Same for the DAX variant and it's two
> callers.
> 

Yeah, we could drop iomap_truncate_page() and dax_truncate_page(), but
that means we have to open code the zeroing length calculation or add a
fs private helper to do that in every filesystems. Now we only have xfs
and ext2 two caller, so it looks fine, but if the caller becomes more in
the future, this could becomes repetitive, if we keep them, all
filesystems could don't pay attention to these details.

Thanks,
Yi.


