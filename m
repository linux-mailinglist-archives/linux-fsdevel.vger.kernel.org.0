Return-Path: <linux-fsdevel+bounces-14274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C27387A4E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 10:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B81C21A5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 09:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80520313;
	Wed, 13 Mar 2024 09:23:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4212A17580;
	Wed, 13 Mar 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321832; cv=none; b=TGAp13ECqg9HE7jDiWLYbfFfgBxR4G9G7KwMSuZpjFzK4IxSL4JDJ7Y+gmOyAgZUFMCfKWToAsOFilIL9VtWR4Hvm6iw9bhQKM1hoSIxV2MbvAshJBOjLdjMk0pAAmdhZvSb7I0nKqKGReKT1FYtkxB5I+V0JaUX2CKFD/GGxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321832; c=relaxed/simple;
	bh=DUWA95OUQZ4tb1g6/fDurLWTmlYD9hTjPojdeFcqTrI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V+uxRjb9QHAFDMd+WiLd7OOTGpOLyA09a7wD/7qQ12zcpN0xOpMFIZVJ8XqFFCycGa2IVO+vJM9+IBhGJ6AsvbBblnvc/clZTs5ItbnYyil/Jq4ulHZTyuIbDiL8be9DSzkFsp++rqyZC+ZoMASsN7c6X4CfydvAvm7EIWrEWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TvlS50Vrfz4f3pHc;
	Wed, 13 Mar 2024 17:23:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C108F1A019F;
	Wed, 13 Mar 2024 17:23:40 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g6acPFlcbg_Gw--.27770S3;
	Wed, 13 Mar 2024 17:23:40 +0800 (CST)
Subject: Re: [PATCH 4/4] iomap: cleanup iomap_write_iter()
To: "Darrick J. Wong" <djwong@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, brauner@kernel.org, david@fromorbit.com,
 tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-5-yi.zhang@huaweicloud.com>
 <20240311160739.GV1927156@frogsfrogsfrogs> <ZfBJYG5OHgLGewHv@infradead.org>
 <20240312162729.GD1927156@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <72683844-f2df-9773-bfb8-7dc2bff76272@huaweicloud.com>
Date: Wed, 13 Mar 2024 17:23:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240312162729.GD1927156@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAn9g6acPFlcbg_Gw--.27770S3
X-Coremail-Antispam: 1UD129KBjvJXoW7try3GFWkurW3GF15KFW3Jrb_yoW8Xw1DpF
	9Iga4jka1qga4xZrykAa1avr1Yk397Kry7try8G398Ar15uw13KF1ruF12yF1UAas7Aw4f
	Xr48Zryku3WqyFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/3/13 0:27, Darrick J. Wong wrote:
> On Tue, Mar 12, 2024 at 05:24:00AM -0700, Christoph Hellwig wrote:
>> On Mon, Mar 11, 2024 at 09:07:39AM -0700, Darrick J. Wong wrote:
>>> If at some point iomap_write_end actually starts returning partial write
>>> completions (e.g. you wrote 250 bytes, but for some reason the pagecache
>>> only acknowledges 100 bytes were written) then this code no longer
>>> reverts the iter or truncates posteof pagecache correctly...
>>
>> I don't think it makes sense to return a partial write from
>> iomap_write_end.  But to make that clear it really should not return
>> a byte count by a boolean.  I've been wanting to make that cleanup
>> for a while, but it would reach all the way into buffer.c.
> 
> For now, can we change the return types of iomap_write_end_inline and
> __iomap_write_end?  Then iomap can WARN_ON if the block_write_end return
> value isn't 0 or copied:
> 
> 	bool ret;
> 
> 	if (srcmap->type == IOMAP_INLINE) {
> 		ret = iomap_write_end_inline(iter, folio, pos, copied);
> 	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
> 		size_t bh_written;
> 
> 		bh_written = block_write_end(NULL, iter->inode->i_mapping,
> 				pos, len, copied, &folio->page, NULL);
> 
> 		WARN_ON(bh_written != copied && bh_written != 0);
> 		ret = bh_written == copied;
> 	} else {
> 		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
> 	}
> 
> 	...
> 
> 	return ret;
> 
> Some day later we can circle back to bufferheads, or maybe they'll die
> before we get to it. ;)
> 

It looks great to me for now, we can revise iomap first.

Thanks,
Yi.



