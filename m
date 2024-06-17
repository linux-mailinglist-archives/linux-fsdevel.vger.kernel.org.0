Return-Path: <linux-fsdevel+bounces-21809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C3690A934
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 11:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B898A1C23DEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 09:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A417419308E;
	Mon, 17 Jun 2024 09:11:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E95192B89;
	Mon, 17 Jun 2024 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615495; cv=none; b=S3d32lt/YuZsHf8klgcMYKtIMnY8TJlkLvYqaSDIFJizd52qYd3Gu3GJkKwiQ2KHgH7wbH+n1BnJrfEkj+XJoEwp1uxC1mdanux9poiVH1GKZjS+z3J7cQ8FO1ugE84fHSgVRGU5e30LTtVvddit02VXYxC6erWEeImQdZckNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615495; c=relaxed/simple;
	bh=BNypJZ0Cx2gOnF3iMtKKqVQWHAjZZROs/81IROL2cVU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SbjqBryXwtF5Xj6JFoZIJ7qKnuPp3hjzgB2l/phzVr+GPVpu0fNoh0wkY1K9x+GwaEXRL8KuecIX9n36mP12maVVeWEbCx/pPY91o4t4L9t8dr5oFmFFo+uESi8s0b/OlOTYS13GOszqUSoBN+JAzVs0fRJN3Flr6FL/nSh3ZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W2kdc1sRtz4f3ktx;
	Mon, 17 Jun 2024 17:11:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EBF401A016E;
	Mon, 17 Jun 2024 17:11:27 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCnDw2+_W9mE+OzAA--.36669S3;
	Mon, 17 Jun 2024 17:11:27 +0800 (CST)
Subject: Re: [PATCH -next v5 7/8] xfs: speed up truncating down a big realtime
 inode
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, brauner@kernel.org,
 david@fromorbit.com, chandanbabu@kernel.org, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 John Garry <john.g.garry@oracle.com>
References: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
 <20240613090033.2246907-8-yi.zhang@huaweicloud.com>
 <ZmveZolfY0Q0--1k@infradead.org>
 <399680eb-cd60-4c27-ef2b-2704e470d228@huaweicloud.com>
 <ZmwJuiMHQ8qgkJDS@infradead.org>
 <ecd7a5cf-4939-947a-edd4-0739dc73870b@huaweicloud.com>
 <Zm_ezp1TaIoAK1-P@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <59887f65-4a5b-aa96-7646-4c7b79372bf1@huaweicloud.com>
Date: Mon, 17 Jun 2024 17:11:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zm_ezp1TaIoAK1-P@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnDw2+_W9mE+OzAA--.36669S3
X-Coremail-Antispam: 1UD129KBjvdXoWrGr1DKr4xArWxJw1rAFyDtrb_yoWxArbEq3
	yavrZ3ArWIy3WxZ3W2yrn8CrWIqFs5Kw4jk343Gr1DWayrXr93ZrZ8Cr1fXw1agF43Crnx
	Kr1DZ34xXr9IgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/6/17 14:59, Christoph Hellwig wrote:
> On Sat, Jun 15, 2024 at 07:44:21PM +0800, Zhang Yi wrote:
>> The reason why atomic feature can't split and convert the tail extent on truncate
>> down now is the dio write iter loop will split an atomic dio which covers the
>> whole allocation unit(extsize) since there are two extents in on allocation unit.
> 
> We could fix this by merging the two in iomap_begin, as the end_io
> handler already deals with multiple ranges.  

Yeah, that's one solution.

> But let's think of that when the need actually arises.
> 

Sure, I will retest and submit only patch 6&8 to solve current issue in my next
version.

Thanks,
Yi.


