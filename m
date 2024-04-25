Return-Path: <linux-fsdevel+bounces-17753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA568B21AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 14:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 819A5B24378
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4E41494CF;
	Thu, 25 Apr 2024 12:32:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168F31494A0;
	Thu, 25 Apr 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048376; cv=none; b=knlyek9PYe5nilZgt3HjMaCKMoNb1ocivc9l4ueInlO+N8U02OZQ5zgl93TvT/s7njz9+fEdRGK7VgRQU8n5w14X5UEj3qdFLJYBkRkiIIuRwxQ5LqQ4ZL9QVwQ6f+nfDlc8K1jVe5rdUFVL4l4WFqjPvueUDs/A7M4X0cKvXLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048376; c=relaxed/simple;
	bh=0m35+vbI8D/mNQBzmIl+HPDV6J3A1AZ6PbYpSywaQQk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IURaNu7H0M7PREQ+dAlQ3x1/IBKEvyl3vLksjsWquL0g3WyAUcGcWD6VG6lCITtQv46HkklBxL3kplWH0IBmeHJdp0T/ukL6oSeB+nJAFIBJVdO3GZLGE9B1R0EqEp7YeTACQ+lL0rbebemfNCUS3m/WdpFrY1B1Imsqj3lY0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VQFcP4qdDz4f3jXX;
	Thu, 25 Apr 2024 20:32:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 447421A0568;
	Thu, 25 Apr 2024 20:32:45 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBFrTSpmycKzKw--.59782S3;
	Thu, 25 Apr 2024 20:32:45 +0800 (CST)
Subject: Re: [PATCH v5 4/9] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, brauner@kernel.org,
 david@fromorbit.com, chandanbabu@kernel.org, tytso@mit.edu, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240320110548.2200662-5-yi.zhang@huaweicloud.com>
 <20240423111735.1298851-1-yi.zhang@huaweicloud.com>
 <ZipLCm2N-fYKCuGv@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <d89fc58a-59d0-6b91-0304-1dcc8166a350@huaweicloud.com>
Date: Thu, 25 Apr 2024 20:32:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZipLCm2N-fYKCuGv@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBnOBFrTSpmycKzKw--.59782S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4xurW7XrWUCr4rJFy5Arb_yoW3Zrg_ua
	yqyF4UCayvqFy5KF4UKrn5ArWFqrWqg3yYvrWkt3yqqayDGr48ZF1SyF1Fy3WfKan7Aanx
	ZwnYqrsak3Z0vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
	AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xF
	o4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/4/25 20:22, Christoph Hellwig wrote:
> On Tue, Apr 23, 2024 at 07:17:35PM +0800, Zhang Yi wrote:
>> +	if ((flags & IOMAP_ZERO) && imap.br_startoff <= offset_fsb &&
>> +	    isnullstartblock(imap.br_startblock)) {
>> +		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
>> +
>> +		if (offset_fsb >= eof_fsb)
>> +			goto convert_delay;
>> +		if (end_fsb > eof_fsb) {
>> +			end_fsb = eof_fsb;
>> +			xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
> 
> Nit: overly long line here.
> 
> I've also tried to to a more comprehensive review, but this depends on
> the rest of the series, which isn't in my linux-xfs folder for April.
> 
> I've your're not doing and instant revision it's usually much easier to
> just review the whole series.
> .
>

Sure, I will resend the whole series.

Thanks,
Yi.


