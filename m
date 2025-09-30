Return-Path: <linux-fsdevel+bounces-63097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58748BABE7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 09:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0253BE772
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 07:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3C02D9EF8;
	Tue, 30 Sep 2025 07:52:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7EB2DEA75;
	Tue, 30 Sep 2025 07:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218723; cv=none; b=qwWGxh/mhcJE8M+E6sDNhXd0KbzDkwxI5Bi3titbpqUBQaKKh5JTnFqFaAjgvc+pMl/9pL+AYeV2c6mk6st8Xdp/tlFio3p7EdZEWZ0ZVtW8RcgKX41c57+5zyct0n8sxh7sScrwAg0PL4W+UVwGQTACNNmIvMnGcz1CtAcoL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218723; c=relaxed/simple;
	bh=TsGsebrOw6apQ7+NmGSvBQVcZ9EJutlezrwTjqg0cQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcQtsmGz+VyMWvojqo2nZiWz4BluPGfOwo4JQI3HVtTSGk494urg4klmqgbusHIgoY42IACBI5v9rkrkCCrGQ32+WWggJCD1W4TluMs53WexmuRcJzqErF0+So+ARPF+3PO7Erpzcws5lWyugD+Pp/KHMf0q/NWzB6RYIT6WXBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cbVcX4YzFzYQv9R;
	Tue, 30 Sep 2025 15:51:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DEA801A10A2;
	Tue, 30 Sep 2025 15:51:41 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP4 (Coremail) with SMTP id gCh0CgAn6mEMjNtooTk7BQ--.46441S3;
	Tue, 30 Sep 2025 15:51:41 +0800 (CST)
Message-ID: <4656e296-5dfa-46a7-8b9b-a089425b1eac@huaweicloud.com>
Date: Tue, 30 Sep 2025 15:51:39 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] loop: Avoid updating block size under exclusive
 owner
To: Greg KH <gregkh@linuxfoundation.org>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, stable@vger.kernel.org, jack@suse.cz,
 sashal@kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, houtao1@huawei.com, zhengqixing@huawei.com
References: <20250930064933.1188006-1-zhengqixing@huaweicloud.com>
 <2025093029-clavicle-landline-0a31@gregkh>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <2025093029-clavicle-landline-0a31@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAn6mEMjNtooTk7BQ--.46441S3
X-Coremail-Antispam: 1UD129KBjvdXoWrur1xCw15uFW8Gw47tF4kCrg_yoW3WrX_WF
	WjkrWDWw4vqaykXFZ3tFn8ZFWfKayjvF9xJryUXrWfWFy8ZF9xJas5tasavw10qrWSgFnI
	k348GF47tr9xtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

Hi,


The patch applied in the 6.6.103 release encountered issues when adapted 
to the 6.6.y branch and was reverted in 6.6.108 (commit 42a6aeb4b238, 
“Revert ‘loop: Avoid updating block size under exclusive owner’”).


We have reworked the backport to address the adaptation problems. Could 
you please review and re-apply the updated patch?


Please let me know if you need anything else.


Thanks,

Qixing


在 2025/9/30 15:34, Greg KH 写道:
> On Tue, Sep 30, 2025 at 02:49:33PM +0800, Zheng Qixing wrote:
>> From: Zheng Qixing <zhengqixing@huawei.com>
>>
>> From: Jan Kara <jack@suse.cz>
>>
>> [ Upstream commit 7e49538288e523427beedd26993d446afef1a6fb ]
> This is already in the 6.6.103 release, so how can we apply it again?
>
> thanks,
>
> greg k-h


