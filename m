Return-Path: <linux-fsdevel+bounces-24729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257559441E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 05:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCAD81F22696
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 03:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8031D696;
	Thu,  1 Aug 2024 03:32:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147051EB493
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722483156; cv=none; b=MtzZig6I42mBafKJPYuvBNioGLNRThY0ywq4zEPtsnwXR6FHmULWDHNIk44n2uwkYiqo5GJKHUnSw7bvTAQjzNVMXWc4sw8xDl9be1uYPIPz45RhjQI0v8kaZxxsIWa73VYsShp4glYY7ArUJ7+YRkB14I/OO9bEL7FiKaQsg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722483156; c=relaxed/simple;
	bh=8ympoBazZMhgaBx6XTcGsXO7VvSzQPHDXMKtgPo79Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOWTYTlSnxnIg02++/e+0UNcjuYmAQnKfMqcaP1SEJvACCUIbmlv1ufgmHBjtcrPQkYh9WDjb8Fuicm4ajo4brhrgaCFsRfHeIHdjIjwTuIX2sU4jPveEKz6TDIeYdRh/OO+eegkxGeLeILH1w0uTE4GAR0MtxrFydSTE+0LWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WZDzh48m4z4f3jdb
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 11:32:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 89C171A167F
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 11:32:29 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgBXfoTJAatmIou8AQ--.18102S3;
	Thu, 01 Aug 2024 11:32:27 +0800 (CST)
Message-ID: <9107aa4d-c888-3a73-0a07-a9d49f5ec558@huaweicloud.com>
Date: Thu, 1 Aug 2024 11:32:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
To: Christian Brauner <brauner@kernel.org>, chuck.lever@oracle.com,
 jack@suse.cz, yangerkun <yangerkun@huawei.com>
Cc: hughd@google.com, zlang@kernel.org, fdmanana@suse.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@infradead.org,
 viro@zeniv.linux.org.uk
References: <20240731043835.1828697-1-yangerkun@huawei.com>
 <20240731-pfeifen-gingen-4f8635e6ffcb@brauner>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20240731-pfeifen-gingen-4f8635e6ffcb@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXfoTJAatmIou8AQ--.18102S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw48Cw1DGr48Gr45JFy8AFb_yoW8XFWrpa
	ykGw4DKr4DXF1UG3929FnruFyFgan3Jr13K34DXw4kZryYgr93KFyI9r4Yga4vkr9a9w42
	qF43t3s5GF1xZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Hi!

在 2024/7/31 22:16, Christian Brauner 写道:
> On Wed, 31 Jul 2024 12:38:35 +0800, yangerkun wrote:
>> After we switch tmpfs dir operations from simple_dir_operations to
>> simple_offset_dir_operations, every rename happened will fill new dentry
>> to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
>> key starting with octx->newx_offset, and then set newx_offset equals to
>> free key + 1. This will lead to infinite readdir combine with rename
>> happened at the same time, which fail generic/736 in xfstests(detail show
>> as below).
>>
>> [...]
> 
> @Chuck, @Jan I did the requested change directly. Please check!

Thanks for applied this patch, the suggestions from Jan and Chuck will
be a separates patch!


> 
> ---
> 
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
> 
> [1/1] libfs: fix infinite directory reads for offset dir
>        https://git.kernel.org/vfs/vfs/c/fad90bfe412e


