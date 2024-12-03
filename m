Return-Path: <linux-fsdevel+bounces-36314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D1D9E1385
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 07:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A583A1611AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 06:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B69518871D;
	Tue,  3 Dec 2024 06:49:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E98837;
	Tue,  3 Dec 2024 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733208578; cv=none; b=Ug1lZpxxDlrFYZ+6GjzkXhB15giJS1Rt0Iivrpd4BCMq/fS5w2Z/FKyP6etm2DuKiNFY5wBPiersqSy1kinJLgV9zEaLdihQnBG4UXxaWW7dsNsD3K6BlD3pv52KdTtfdsKxYT/aGs15vYOiLkkcXdN3BeHEZFNZb9WpsYIlfV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733208578; c=relaxed/simple;
	bh=nq3LmtWF3DuD5mUH3kjW2xIUPaFRDgXKI7KW0h2/meE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iP8hP0yhIBMjjExzAAK+LNorkzUIKsQJzTs82skN7IUB9Ix69/AMoUKj6s0SmZOek+Vowzx6vsmKcdXteIYuHgSOzg9H6Bkei6sdbVw7cAONWx5j1vCtqmCvrNs3E6QxCVescb/vwCLclHazRtx+hfLdrQEWhyu3fxlpnQLYnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y2WTZ1KgMz4f3jRC;
	Tue,  3 Dec 2024 14:49:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1D70B1A0196;
	Tue,  3 Dec 2024 14:49:25 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgB3bK7nqU5niSfBDQ--.45529S2;
	Tue, 03 Dec 2024 14:49:24 +0800 (CST)
Subject: Re: [PATCH 1/2] jbd2: increase IO priority for writing revoke records
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20241203014407.805916-1-yi.zhang@huaweicloud.com>
 <20241203014407.805916-2-yi.zhang@huaweicloud.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <dd1bac63-b06f-96da-38a1-9c62f63a784e@huaweicloud.com>
Date: Tue, 3 Dec 2024 14:49:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241203014407.805916-2-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB3bK7nqU5niSfBDQ--.45529S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF4UZw1DXryrKFy5AF1fWFg_yoWkJwc_WF
	Wj9ryfZ3yftr12vF4jvw15AFsak3yfWF1xC3s8tr18W34DWas5JF9rtr95Xr1kJFZFgrZ5
	Cr1SqFWrKrs7ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 12/3/2024 9:44 AM, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Commit '6a3afb6ac6df ("jbd2: increase the journal IO's priority")'
> increases the priority of journal I/O by marking I/O with the
> JBD2_JOURNAL_REQ_FLAGS. However, that commit missed the revoke buffers,
> so also addresses that kind of I/Os.
> 
> Fixes: 6a3afb6ac6df ("jbd2: increase the journal IO's priority")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/jbd2/revoke.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index 4556e4689024..ce63d5fde9c3 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -654,7 +654,7 @@ static void flush_descriptor(journal_t *journal,
>  	set_buffer_jwrite(descriptor);
>  	BUFFER_TRACE(descriptor, "write");
>  	set_buffer_dirty(descriptor);
> -	write_dirty_buffer(descriptor, REQ_SYNC);
> +	write_dirty_buffer(descriptor, JBD2_JOURNAL_REQ_FLAGS);
>  }
>  #endif
Look good to me. Feel free to add:

Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>


