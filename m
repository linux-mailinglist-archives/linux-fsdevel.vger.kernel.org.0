Return-Path: <linux-fsdevel+bounces-17864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 147EE8B3134
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 09:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5964282DF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 07:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3492F13BC2B;
	Fri, 26 Apr 2024 07:18:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8513AD33;
	Fri, 26 Apr 2024 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115908; cv=none; b=O77Aux72EoStra9NtVK1WBhK0USG+T9w4YZAWNhwFtOMn0tDW5esjDQCJ6stR+hFBWRr7/RKA2uRq554WxWqIotzGXhSVeIWo0AVQoHPnTj42PHCikCpBuYTif9GABARFZTu+lKxkTEyMDBG5g5K46//gJjDxU0GjXml+jlg364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115908; c=relaxed/simple;
	bh=WTCpI6h/TMPgfa/2HXkNHaaRz2yWWL9Ipkowo/sAKNE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CWlNKA5N0chVEn0+rh0lygQwORuhlX4p0isHSWpOPlj1khgm0i+7TZmDY6CG33EE0rdPtSpWD3RaKVutO8iToQ1Iz0hqvb77s2ssFkQi66HhURXBXxXAZfSLP+MqLEifED+fSUCZr9wxfenwbwUlOTq/O2+diDzrgRhgBxhQQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VQkbC05Mwz4f3jdD;
	Fri, 26 Apr 2024 15:18:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A20D31A1340;
	Fri, 26 Apr 2024 15:18:22 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP4 (Coremail) with SMTP id gCh0CgAXHG45VStmmbjILA--.23366S3;
	Fri, 26 Apr 2024 15:18:19 +0800 (CST)
Subject: Re: [PATCH v5 4/9] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
 tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
 <20240425131335.878454-5-yi.zhang@huaweicloud.com>
 <20240425182904.GA360919@frogsfrogsfrogs>
 <3be86418-e629-c7e6-fd73-f59f97a73a89@huaweicloud.com>
 <ZitKncYr0cCmU0NG@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <5b6228ce-c553-3387-dfc4-2db78e3bd810@huaweicloud.com>
Date: Fri, 26 Apr 2024 15:18:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZitKncYr0cCmU0NG@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXHG45VStmmbjILA--.23366S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw45XF1UAr1fGFW3Wry5CFg_yoW8Wr17p3
	s3K345KanxGw1kZw1xZwsruryrZw43Wa15GrWYqrySvas8XF1Skws7KF4YgFyqyrWkW3Wj
	vFW2934xtFZ8Zw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/4/26 14:33, Christoph Hellwig wrote:
> On Fri, Apr 26, 2024 at 02:24:19PM +0800, Zhang Yi wrote:
>> Yeah, it looks more reasonable. But from the original scene, the
>> xfs_bmap_extsize_align() aligned the new extent that added to the cow fork
>> could overlaps the unreflinked range, IIUC, I guess that spare range is
>> useless exactly, is there any situation that would use it?
> 
> I've just started staring at this (again) half an hour ago, and I fail
> to understand the (pre-existing) logic in xfs_reflink_zero_posteof.
> 
> We obviously need to ensure data between i_size and the end of the
> block that i_size sits in is zeroed (but IIRC we already do that
> in write and truncate anyway).  But what is the point of zeroing
> any speculative preallocation beyond the last block that actually
> contains data?  Just truncating the preallocation and freeing
> the delalloc and unwritten blocks seems like it would be way
> more efficient.
> 

I've had the same idea before, I asked Dave and he explained that Linux
could leak data beyond EOF page for some cases, e.g. mmap() can write to
the EOF page beyond EOF without failing, and the data in that EOF page
could be non-zeroed by mmap(), so the zeroing is still needed now.

OTOH, if we free the delalloc and unwritten blocks beyond EOF blocks, he
said it could lead to some performance problems and make thinks
complicated to deal with the trimming of EOF block. Please see [1]
for details and maybe Dave could explain more.

[1] https://lore.kernel.org/linux-xfs/ZeERAob9Imwh01bG@dread.disaster.area/

Thanks,
Yi.


