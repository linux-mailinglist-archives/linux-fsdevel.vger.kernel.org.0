Return-Path: <linux-fsdevel+bounces-27280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF98495FFF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3462835E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 03:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E01121340;
	Tue, 27 Aug 2024 03:47:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB7175BF;
	Tue, 27 Aug 2024 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724730475; cv=none; b=HFMgG03+CE5Iz14UaSb2+EjbdeIvviucMWDIoZQdHy2YjkHyZiT7YJdWM2jNqdkCUxWREJuok8KCocnQuxVNpptbZcvR0uySWNDXvsvLIAh74F7Wf0vHStgoxar1JK7WAK4ZFgcS2U1Zlj/AG2RiEUSbMdvf2Qkfnu9rFor48h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724730475; c=relaxed/simple;
	bh=lPtDJ1wNWNDenZoG4SuiqmoxqD7FETC475odRZucW5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tFY3dfLFjssGBGq1gc31zTq8+/dhEJiiyAnsJgabAuZ7hEx0wUkzljvAJM8AzuFCu6kWlM5JMYsPPwXPk0anozCJjExIe9ViIURwFtaZwzftklvL4H9Ni6lKSIAkwCUQRs6cs6ZjN8CChdVQ+d5mm6gLQd4sywg0eQM7RkzNC5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WtD5K1TnDz4f3jM8;
	Tue, 27 Aug 2024 11:47:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B12321A14E7;
	Tue, 27 Aug 2024 11:47:47 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgB37IJfTM1m5shTCw--.52889S3;
	Tue, 27 Aug 2024 11:47:47 +0800 (CST)
Message-ID: <5b7455f8-4637-4ec0-a016-233827131fb2@huaweicloud.com>
Date: Tue, 27 Aug 2024 11:47:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cachefiles: fix dentry leak in cachefiles_open_file()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, David Howells <dhowells@redhat.com>,
 Jeff Layton <jlayton@kernel.org>, stable@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>, Hou Tao <houtao1@huawei.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, Yang Erkun <yangerkun@huawei.com>,
 Yu Kuai <yukuai3@huawei.com>, Zizhi Wo <wozizhi@huawei.com>,
 Baokun Li <libaokun1@huawei.com>
References: <20240826040018.2990763-1-libaokun@huaweicloud.com>
 <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <467d9b9b-34b4-4a94-95c1-1d41f0a91e05@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB37IJfTM1m5shTCw--.52889S3
X-Coremail-Antispam: 1UD129KBjvJXoW7GryUWF4kGw4rZFWUKFyDWrg_yoW8Jr4UpF
	Way3WUKryfWr4UKr4kAa1Fvw1F9397WFs0q3W3Wr9rAan0qryYvr12grn0qF98AryDJr42
	qa1j9a43X3yUJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	aFAJUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAIBWbMPH9KgwAAss

On 2024/8/26 21:55, Markus Elfring wrote:
> …
>> Add the missing dput() to cachefiles_open_file() for a quick fix.
> I suggest to use a goto chain accordingly.
>
>
> …

Hi Markus,


Thanks for the suggestion, but I think the current solution is simple
enough that we don't need to add a label to it.

Actually, at first I was going to release the reference count of the
dentry uniformly in cachefiles_look_up_object() and delete all dput()
in cachefiles_open_file(), but this may conflict when backporting
the code to stable. So just keep it simple to facilitate backporting
to stable.

Thanks,
Baokun
>> +++ b/fs/cachefiles/namei.c
>> @@ -554,6 +554,7 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
>>   	if (!cachefiles_mark_inode_in_use(object, d_inode(dentry))) {
>>   		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
>>   			  dentry, d_inode(dentry)->i_ino);
>> +		dput(dentry);
>>   		return false;
> Please replace two statements by the statement “goto put_dentry;”.
>
>
> …
>> error:
>> 	cachefiles_do_unmark_inode_in_use(object, d_inode(dentry));
> +put_dentry:
>> 	dput(dentry);
>> 	return false;
>> }
> Regards,
> Markus

-- 
With Best Regards,
Baokun Li


