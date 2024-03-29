Return-Path: <linux-fsdevel+bounces-15692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B65A8920B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 16:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE0B1F23A54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D5A2033E;
	Fri, 29 Mar 2024 15:43:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2851C0DF7;
	Fri, 29 Mar 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726996; cv=none; b=sLwrxY9g1KBg2KGGKOmBUVhN0dRQX9weqTwHxzdf2ruVyPmhbRlm8onPZTBrN6Nud8kffLy8+WCqiSw8nCleox3S0J7BgWlKkjr6Gk9xaKEGTnRYmcWBgOd7NjnFkCXBd7SOkvrw+IOZo1roeFioTQA/tbCcGjHR4RlEmPKsnNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726996; c=relaxed/simple;
	bh=8D3dJ6svTFv3Xw6tQT1vQDH8IAiOheAKB2leJyMX3hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfg+xh6oSOL9Kkd395WsFb05PXbCbX4I2bBDCSj5KAgxVKwgHsoVaqyH1GF7tzqrz9XqlxmdPw5KREUAWkstNs2weASRdkKajOY5WflS1NUCtwH8zyeaP2e1rQ9vUVIVFlSoffw/Nx0hUpBlecWAJvGPI/H4DnS5A/PIacs22tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4V5km40SrJz9xqxL;
	Fri, 29 Mar 2024 23:27:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id D5ED41402CD;
	Fri, 29 Mar 2024 23:43:08 +0800 (CST)
Received: from [10.48.128.185] (unknown [10.48.128.185])
	by APP2 (Coremail) with SMTP id GxC2BwDXECV94QZmAQ8uBQ--.25296S2;
	Fri, 29 Mar 2024 16:43:07 +0100 (CET)
Message-ID: <302ad45e-aff9-40e8-97de-121353e73384@huaweicloud.com>
Date: Fri, 29 Mar 2024 16:42:50 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] security: Handle dentries without inode in
 security_path_post_mknod()
To: Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-cifs@vger.kernel.org, viro@zeniv.linux.org.uk, pc@manguebit.com,
 christian@brauner.io, Roberto Sassu <roberto.sassu@huawei.com>,
 stable@vger.kernel.org, Steve French <smfrench@gmail.com>
References: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>
 <7b8162281b355b16e8dbdb93297a9a1cfb5bb6da.camel@linux.ibm.com>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <7b8162281b355b16e8dbdb93297a9a1cfb5bb6da.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwDXECV94QZmAQ8uBQ--.25296S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw43Xr4ftF1DKFW3ZryfXrb_yoW8Cr4DpF
	W8u3WDt3s5Jry8Gr4SyFy7Aa4Ikay8XF45G3Z5JrW3Za43uF1YgrWSvayY9rWDtr42gry2
	yw42qF9IqayDZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBF1jj5fusAAAsv

On 3/29/2024 4:05 PM, Mimi Zohar wrote:
> On Fri, 2024-03-29 at 11:56 +0100, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Commit 08abce60d63fi ("security: Introduce path_post_mknod hook")
>> introduced security_path_post_mknod(), to replace the IMA-specific call to
>> ima_post_path_mknod().
>>
>> For symmetry with security_path_mknod(), security_path_post_mknod() is
>> called after a successful mknod operation, for any file type, rather than
>> only for regular files at the time there was the IMA call.
>>
>> However, as reported by VFS maintainers, successful mknod operation does
>> not mean that the dentry always has an inode attached to it (for example,
>> not for FIFOs on a SAMBA mount).
>>
>> If that condition happens, the kernel crashes when
>> security_path_post_mknod() attempts to verify if the inode associated to
>> the dentry is private.
>>
>> Add an extra check to first verify if there is an inode attached to the
>> dentry, before checking if the inode is private. Also add the same check to
>> the current users of the path_post_mknod hook, ima_post_path_mknod() and
>> evm_post_path_mknod().
>>
>> Finally, use the proper helper, d_backing_inode(), to retrieve the inode
>> from the dentry in ima_post_path_mknod().
>>
>> Cc: stable@vger.kernel.org # 6.8.x
> 
> Huh?  It doesn't need to be backported.

Ehm, sorry. To be removed.

>> Reported-by: Steve French <smfrench@gmail.com>
>> Closes:
>> https://lore.kernel.org/linux-kernel/CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com/
>> Fixes: 08abce60d63fi ("security: Introduce path_post_mknod hook")
> 
> -> 08abce60d63f

Ok.

Thanks

Roberto

>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> 


