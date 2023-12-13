Return-Path: <linux-fsdevel+bounces-5836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A78810EC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 11:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79881F212E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 10:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F1B22EFB;
	Wed, 13 Dec 2023 10:46:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D828B2;
	Wed, 13 Dec 2023 02:46:19 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SqsHJ5pQQz9y0PF;
	Wed, 13 Dec 2023 18:32:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 4511B140411;
	Wed, 13 Dec 2023 18:46:15 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCnpV9li3llaWZvAg--.43787S2;
	Wed, 13 Dec 2023 11:46:14 +0100 (CET)
Message-ID: <7c226242-2eda-41cd-9be8-c2c010f3fc49@huaweicloud.com>
Date: Wed, 13 Dec 2023 11:45:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
 stephen.smalley.work@gmail.com, eparis@parisplace.org,
 casey@schaufler-ca.com, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwCnpV9li3llaWZvAg--.43787S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF17Kw1kuFWrWr45ur1kGrg_yoW5tF48pF
	43Ka4xJw4kXF929rn2vF45ur4fKFWSgFWUWwn8Grn7Aas09r1Ygr45Ary8uFyUGr98tw1F
	qr1a9ry3Z3WqyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAKBF1jj5OXOgACsB

On 17.11.23 21:57, Paul Moore wrote:
> On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
>>
>> Before the security field of kernel objects could be shared among LSMs with
>> the LSM stacking feature, IMA and EVM had to rely on an alternative storage
>> of inode metadata. The association between inode metadata and inode is
>> maintained through an rbtree.
>>
>> Because of this alternative storage mechanism, there was no need to use
>> disjoint inode metadata, so IMA and EVM today still share them.
>>
>> With the reservation mechanism offered by the LSM infrastructure, the
>> rbtree is no longer necessary, as each LSM could reserve a space in the
>> security blob for each inode. However, since IMA and EVM share the
>> inode metadata, they cannot directly reserve the space for them.
>>
>> Instead, request from the 'integrity' LSM a space in the security blob for
>> the pointer of inode metadata (integrity_iint_cache structure). The other
>> reason for keeping the 'integrity' LSM is to preserve the original ordering
>> of IMA and EVM functions as when they were hardcoded.
>>
>> Prefer reserving space for a pointer to allocating the integrity_iint_cache
>> structure directly, as IMA would require it only for a subset of inodes.
>> Always allocating it would cause a waste of memory.
>>
>> Introduce two primitives for getting and setting the pointer of
>> integrity_iint_cache in the security blob, respectively
>> integrity_inode_get_iint() and integrity_inode_set_iint(). This would make
>> the code more understandable, as they directly replace rbtree operations.
>>
>> Locking is not needed, as access to inode metadata is not shared, it is per
>> inode.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> ---
>>   security/integrity/iint.c      | 71 +++++-----------------------------
>>   security/integrity/integrity.h | 20 +++++++++-
>>   2 files changed, 29 insertions(+), 62 deletions(-)
>>
>> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
>> index 882fde2a2607..a5edd3c70784 100644
>> --- a/security/integrity/iint.c
>> +++ b/security/integrity/iint.c
>> @@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
>>   	return 0;
>>   }
>>   
>> +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
>> +	.lbs_inode = sizeof(struct integrity_iint_cache *),
>> +};
> 
> I'll admit that I'm likely missing an important detail, but is there
> a reason why you couldn't stash the integrity_iint_cache struct
> directly in the inode's security blob instead of the pointer?  For
> example:
> 
>    struct lsm_blob_sizes ... = {
>      .lbs_inode = sizeof(struct integrity_iint_cache),
>    };
> 
>    struct integrity_iint_cache *integrity_inode_get(inode)
>    {
>      if (unlikely(!inode->isecurity))
>        return NULL;

Ok, this caught my attention...

I see that selinux_inode() has it, but smack_inode() doesn't.

Some Smack code assumes that the inode security blob is always non-NULL:

static void init_inode_smack(struct inode *inode, struct smack_known *skp)
{
	struct inode_smack *isp = smack_inode(inode);

	isp->smk_inode = skp;
	isp->smk_flags = 0;
}


Is that intended? Should I add the check?

Thanks

Roberto

>      return inode->i_security + integrity_blob_sizes.lbs_inode;
>    }
> 
> --
> paul-moore.com


