Return-Path: <linux-fsdevel+bounces-39277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5CCA12103
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3805516A8C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D445C1E98F0;
	Wed, 15 Jan 2025 10:51:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7787248BA1;
	Wed, 15 Jan 2025 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938307; cv=none; b=GqWeKjkUSOVg9z/M3Wy7pDSuV9KIOpk4E8FuUBXvY8zPB46hcO8b4or6FttkiL9ipxH+514BKVvfBnjpfUXs60MeLxMXtiRFepfRJS/Y04UZU5HKqPGrHmwVbuzEEhp+wG2ghWIAexOTrPOlFzyUPdrv5oX6+xBNfUrM0LHkAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938307; c=relaxed/simple;
	bh=QRU8U5lXb2pp4lu+Afpob7QHF/SlW2QAmZnjqoFRw6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPXJX8s5I92Ewl0H+5w7607scgKvsMWMEmfjiGmU5Yi7K7qhk9C+/ZW50PM8gI02uw2KZKJ9mJd2r15gwQFvbH1WPbdGQs/IfW5OY54bFtKA4oOCbcZsjFpR7Q0xm5zsm/E6U9QWlPopnD2Ciny9TU9F65/UYBZL8bvTFVP9shk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4YY2L516L9z9v7N7;
	Wed, 15 Jan 2025 18:29:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 61B5F140451;
	Wed, 15 Jan 2025 18:51:35 +0800 (CST)
Received: from [10.45.149.44] (unknown [10.45.149.44])
	by APP1 (Coremail) with SMTP id LxC2BwC3O0osk4dn7zysAA--.10045S2;
	Wed, 15 Jan 2025 11:51:34 +0100 (CET)
Message-ID: <85823922-0947-488e-ba95-f6c0e3132313@huaweicloud.com>
Date: Wed, 15 Jan 2025 11:51:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] ima: Ensure lock is held when setting iint pointer
 in inode security blob
To: Mimi Zohar <zohar@linux.ibm.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
 <20241128100621.461743-4-roberto.sassu@huaweicloud.com>
 <3545a38326a5d3dff28b1089ab2149f1662a641b.camel@linux.ibm.com>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <3545a38326a5d3dff28b1089ab2149f1662a641b.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwC3O0osk4dn7zysAA--.10045S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr15Jw4xJFy8tr1fCFyfWFg_yoW5CFy5pa
	n5ta4UG34jvFZ7Wr4Fva43uF1fK3ySgFWDGw45J3WvyFZrJr1qqr48Gry7ur15Gr4rA3Wv
	vr1jg3sxu3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFf
	HUUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBGeHXlMCcAADsQ

On 1/14/2025 3:20 PM, Mimi Zohar wrote:
> On Thu, 2024-11-28 at 11:06 +0100, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> IMA stores a pointer of the ima_iint_cache structure, containing integrity
>> metadata, in the inode security blob. However, check and assignment of this
>> pointer is not atomic, and it might happen that two tasks both see that the
>> iint pointer is NULL and try to set it, causing a memory leak.
>>
>> Ensure that the iint check and assignment is guarded, by adding a lockdep
>> assertion in ima_inode_get().
> 
> -> is guarded by the ima_iint_cache_lock mutex, ...

By the iint_lock mutex...

>> Consequently, guard the remaining ima_inode_get() calls, in
>> ima_post_create_tmpfile() and ima_post_path_mknod(), to avoid the lockdep
>> warnings.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
>>   security/integrity/ima/ima_iint.c |  2 ++
>>   security/integrity/ima/ima_main.c | 14 ++++++++++++--
>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
>> index dcc32483d29f..fca9db293c79 100644
>> --- a/security/integrity/ima/ima_iint.c
>> +++ b/security/integrity/ima/ima_iint.c
>> @@ -97,6 +97,8 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
>>   	if (!iint_lock)
>>   		return NULL;
>>   
>> +	lockdep_assert_held(&iint_lock->mutex);
>> +
> 
> lockdep_assert_held() doesn't actually "ensure" the lock is held, but emits a warning
> when the lock is not held (if debugging is enabled).  Semantically "ensure" gives the
> impression of enforcing.

I agree. I would replace ensure with detect.

Thanks

Roberto

> Mimi
> 
>>   	iint = iint_lock->iint;
>>   	if (iint)
>>   		return iint;
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 05cfb04cd02b..1e474ff6a777 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -705,14 +705,19 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
>>   	if (!must_appraise)
>>   		return;
>>   
>> +	ima_iint_lock(inode);
>> +
>>   	/* Nothing to do if we can't allocate memory */
>>   	iint = ima_inode_get(inode);
>> -	if (!iint)
>> +	if (!iint) {
>> +		ima_iint_unlock(inode);
>>   		return;
>> +	}
>>   
>>   	/* needed for writing the security xattrs */
>>   	set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
>>   	iint->ima_file_status = INTEGRITY_PASS;
>> +	ima_iint_unlock(inode);
>>   }
>>   
>>   /**
>> @@ -737,13 +742,18 @@ static void ima_post_path_mknod(struct mnt_idmap *idmap,
>> struct dentry *dentry)
>>   	if (!must_appraise)
>>   		return;
>>   
>> +	ima_iint_lock(inode);
>> +
>>   	/* Nothing to do if we can't allocate memory */
>>   	iint = ima_inode_get(inode);
>> -	if (!iint)
>> +	if (!iint) {
>> +		ima_iint_unlock(inode);
>>   		return;
>> +	}
>>   
>>   	/* needed for re-opening empty files */
>>   	iint->flags |= IMA_NEW_FILE;
>> +	ima_iint_unlock(inode);
>>   }
>>   
>>   /**
> 


