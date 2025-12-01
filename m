Return-Path: <linux-fsdevel+bounces-70287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D8DC9598B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 03:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9901C4E01D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 02:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C3D19E7F7;
	Mon,  1 Dec 2025 02:38:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74413E02A;
	Mon,  1 Dec 2025 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556736; cv=none; b=jhgDCunFoPoD/uWZ1GVxFrzJ2bVe8WVaR+v+Bp+3vudviNJhGqUII9Q3xyBw5ku6tSbmfqlZTpAkW/pZ13hFZhjfv3wgYRCwNfxqUEpIJJyBPhZRTpKX1O+MGXxHogyG4ZiYpuBylAtb/Oaw115ngjhuHVOTlIXtc9CtASKrDW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556736; c=relaxed/simple;
	bh=RPVtdg/fP7xmqRi/VrzQI3GOt9Ati+PuK9h64C9X06k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTAaki4B6NENZ2irGZyhgoUylxBTPYBWv17aYMOdyW/p7bhQunt5UkErbI0qqUkQTbyk+6x4+/D78eLRdqdNwjlDPOKa1RM1PtfV4xwLx2WEbLHNmbL3On8rrt+JD0IxHSxV/FtllTQ0fVeam1e8yN2VYP3V6sfsjYkS/MmUXWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dKSkP4hM1zKHLwP;
	Mon,  1 Dec 2025 10:38:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 618DF1A0FDD;
	Mon,  1 Dec 2025 10:38:51 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP2 (Coremail) with SMTP id Syh0CgD311G5_yxpf6i7AA--.50711S3;
	Mon, 01 Dec 2025 10:38:51 +0800 (CST)
Message-ID: <7970e1c4-88d5-42ef-b8cf-ed50d27fedcc@huaweicloud.com>
Date: Mon, 1 Dec 2025 10:38:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
To: Al Viro <viro@zeniv.linux.org.uk>, Zizhi Wo <wozizhi@huaweicloud.com>
Cc: Will Deacon <will@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, jack@suse.com,
 brauner@kernel.org, hch@lst.de, akpm@linux-foundation.org,
 linux@armlinux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, yangerkun@huawei.com,
 wangkefeng.wang@huawei.com, pangliyuan1@huawei.com, xieyuanbin1@huawei.com
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <aShLKpTBr9akSuUG@willie-the-truck>
 <9ff0d134-2c64-4204-bbac-9fdf0867ac46@huaweicloud.com>
 <39d99c56-3c2f-46bd-933f-2aef69d169f3@huaweicloud.com>
 <61757d05-ffce-476d-9b07-88332e5db1b9@huaweicloud.com>
 <aSmUnZZATTn3JD7m@willie-the-truck>
 <b6e23094-f53f-4242-acb5-881bd304d707@huaweicloud.com>
 <20251129035510.GI3538@ZenIV>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20251129035510.GI3538@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD311G5_yxpf6i7AA--.50711S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4xJF4DCrWUGry5Ww43GFg_yoW3ZrX_W3
	y8tr4DCa43ta1fAa15GFW7ArZxJw42vr15KFZ5Xws3K3s2yFW8C398Kwn5Zan2qFWYkFsF
	9Fn3Jr17Cry3CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/11/29 11:55, Al Viro 写道:
> On Sat, Nov 29, 2025 at 09:02:27AM +0800, Zizhi Wo wrote:
> 
>> Thank you very much for the answer. For the vmalloc area, I checked the
>> call points on the vfs side, such as dentry_string_cmp() or hash_name().
>> Their "names addr" are all assigned by kmalloc(), so there should be no
>> corresponding issues. But I'm not familiar with the other calling
>> points...
> 
> Pathname might be a symlink body, sitting in page cache or whatever
> ->get_link() has returned...
> 


Thanks for the additional explanation — I indeed hadn't considered
symlinks. But if the data is in the page cache, as I understand it, its
address wouldn't be in the vmalloc area, right? However, for other
.get_link implementations, it's true that there's no guarantee.

Thanks,
Zizhi Wo


