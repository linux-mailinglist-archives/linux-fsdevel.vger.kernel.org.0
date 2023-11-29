Return-Path: <linux-fsdevel+bounces-4244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A35D7FE11D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 21:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01FCB20FF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 20:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389CF60EE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915F1133;
	Wed, 29 Nov 2023 10:47:02 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SgSY930FCz9yfLW;
	Thu, 30 Nov 2023 02:30:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 7DA2614089D;
	Thu, 30 Nov 2023 02:46:59 +0800 (CST)
Received: from [10.81.218.12] (unknown [10.81.218.12])
	by APP2 (Coremail) with SMTP id GxC2BwCHN2EUh2dlazOXAQ--.6321S2;
	Wed, 29 Nov 2023 19:46:58 +0100 (CET)
Message-ID: <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
Date: Wed, 29 Nov 2023 19:46:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
To: Paul Moore <paul@paul-moore.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
 tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
 stephen.smalley.work@gmail.com, eparis@parisplace.org,
 casey@schaufler-ca.com, mic@digikod.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org, selinux@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
 <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
 <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
 <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCHN2EUh2dlazOXAQ--.6321S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar18WFWruryUtFWUJFy5Jwb_yoW3Jw4kpF
	W7Kay7Kr1kAry29rn2vF45uFWfKrW8WFyUXrn8Gr18Zas09r10qr4UCrWUuFyUGrZ5Kw1j
	qr1Y9ry7Z3WDZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrLvKUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj5MTuwAAsc

On 11/29/2023 6:22 PM, Paul Moore wrote:
> On Wed, Nov 29, 2023 at 7:28 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
>>
>> On Mon, 2023-11-20 at 16:06 -0500, Paul Moore wrote:
>>> On Mon, Nov 20, 2023 at 3:16 AM Roberto Sassu
>>> <roberto.sassu@huaweicloud.com> wrote:
>>>> On Fri, 2023-11-17 at 15:57 -0500, Paul Moore wrote:
>>>>> On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
>>>>>>
>>>>>> Before the security field of kernel objects could be shared among LSMs with
>>>>>> the LSM stacking feature, IMA and EVM had to rely on an alternative storage
>>>>>> of inode metadata. The association between inode metadata and inode is
>>>>>> maintained through an rbtree.
>>>>>>
>>>>>> Because of this alternative storage mechanism, there was no need to use
>>>>>> disjoint inode metadata, so IMA and EVM today still share them.
>>>>>>
>>>>>> With the reservation mechanism offered by the LSM infrastructure, the
>>>>>> rbtree is no longer necessary, as each LSM could reserve a space in the
>>>>>> security blob for each inode. However, since IMA and EVM share the
>>>>>> inode metadata, they cannot directly reserve the space for them.
>>>>>>
>>>>>> Instead, request from the 'integrity' LSM a space in the security blob for
>>>>>> the pointer of inode metadata (integrity_iint_cache structure). The other
>>>>>> reason for keeping the 'integrity' LSM is to preserve the original ordering
>>>>>> of IMA and EVM functions as when they were hardcoded.
>>>>>>
>>>>>> Prefer reserving space for a pointer to allocating the integrity_iint_cache
>>>>>> structure directly, as IMA would require it only for a subset of inodes.
>>>>>> Always allocating it would cause a waste of memory.
>>>>>>
>>>>>> Introduce two primitives for getting and setting the pointer of
>>>>>> integrity_iint_cache in the security blob, respectively
>>>>>> integrity_inode_get_iint() and integrity_inode_set_iint(). This would make
>>>>>> the code more understandable, as they directly replace rbtree operations.
>>>>>>
>>>>>> Locking is not needed, as access to inode metadata is not shared, it is per
>>>>>> inode.
>>>>>>
>>>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>>>> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>>>>> ---
>>>>>>   security/integrity/iint.c      | 71 +++++-----------------------------
>>>>>>   security/integrity/integrity.h | 20 +++++++++-
>>>>>>   2 files changed, 29 insertions(+), 62 deletions(-)
>>>>>>
>>>>>> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
>>>>>> index 882fde2a2607..a5edd3c70784 100644
>>>>>> --- a/security/integrity/iint.c
>>>>>> +++ b/security/integrity/iint.c
>>>>>> @@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
>>>>>>      return 0;
>>>>>>   }
>>>>>>
>>>>>> +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
>>>>>> +   .lbs_inode = sizeof(struct integrity_iint_cache *),
>>>>>> +};
>>>>>
>>>>> I'll admit that I'm likely missing an important detail, but is there
>>>>> a reason why you couldn't stash the integrity_iint_cache struct
>>>>> directly in the inode's security blob instead of the pointer?  For
>>>>> example:
>>>>>
>>>>>    struct lsm_blob_sizes ... = {
>>>>>      .lbs_inode = sizeof(struct integrity_iint_cache),
>>>>>    };
>>>>>
>>>>>    struct integrity_iint_cache *integrity_inode_get(inode)
>>>>>    {
>>>>>      if (unlikely(!inode->isecurity))
>>>>>        return NULL;
>>>>>      return inode->i_security + integrity_blob_sizes.lbs_inode;
>>>>>    }
>>>>
>>>> It would increase memory occupation. Sometimes the IMA policy
>>>> encompasses a small subset of the inodes. Allocating the full
>>>> integrity_iint_cache would be a waste of memory, I guess?
>>>
>>> Perhaps, but if it allows us to remove another layer of dynamic memory
>>> I would argue that it may be worth the cost.  It's also worth
>>> considering the size of integrity_iint_cache, while it isn't small, it
>>> isn't exactly huge either.
>>>
>>>> On the other hand... (did not think fully about that) if we embed the
>>>> full structure in the security blob, we already have a mutex available
>>>> to use, and we don't need to take the inode lock (?).
>>>
>>> That would be excellent, getting rid of a layer of locking would be significant.
>>>
>>>> I'm fully convinced that we can improve the implementation
>>>> significantly. I just was really hoping to go step by step and not
>>>> accumulating improvements as dependency for moving IMA and EVM to the
>>>> LSM infrastructure.
>>>
>>> I understand, and I agree that an iterative approach is a good idea, I
>>> just want to make sure we keep things tidy from a user perspective,
>>> i.e. not exposing the "integrity" LSM when it isn't required.
>>
>> Ok, I went back to it again.
>>
>> I think trying to separate integrity metadata is premature now, too
>> many things at the same time.
> 
> I'm not bothered by the size of the patchset, it is more important
> that we do The Right Thing.  I would like to hear in more detail why
> you don't think this will work, I'm not interested in hearing about
> difficult it may be, I'm interested in hearing about what challenges
> we need to solve to do this properly.

The right thing in my opinion is to achieve the goal with the minimal 
set of changes, in the most intuitive way.

Until now, there was no solution that could achieve the primary goal of 
this patch set (moving IMA and EVM to the LSM infrastructure) and, at 
the same time, achieve the additional goal you set of removing the 
'integrity' LSM.

If you see the diff, the changes compared to v5 that was already 
accepted by Mimi are very straightforward. If the assumption I made that 
in the end the 'ima' LSM could take over the role of the 'integrity' 
LSM, that for me is the preferable option.

Given that the patch set is not doing any design change, but merely 
moving calls and storing pointers elsewhere, that leaves us with the 
option of thinking better what to do next, including like you suggested 
to make IMA and EVM use disjoint metadata.

>> I started to think, does EVM really need integrity metadata or it can
>> work without?
>>
>> The fact is that CONFIG_IMA=n and CONFIG_EVM=y is allowed, so we have
>> the same problem now. What if we make IMA the one that manages
>> integrity metadata, so that we can remove the 'integrity' LSM?
> 
> I guess we should probably revisit the basic idea of if it even makes
> sense to enable EVM without IMA?  Should we update the Kconfig to
> require IMA when EVM is enabled?

That would be up to Mimi. Also this does not seem the main focus of the 
patch set.

>> Regarding the LSM order, I would take Casey's suggestion of introducing
>> LSM_ORDER_REALLY_LAST, for EVM.
> 
> Please understand that I really dislike that we have imposed ordering
> constraints at the LSM layer, but I do understand the necessity (the
> BPF LSM ordering upsets me the most).  I really don't want to see us
> make things worse by adding yet another ordering bucket, I would
> rather that we document it well and leave it alone ... basically treat
> it like the BPF LSM (grrrrrr).

Uhm, that would not be possible right away (the BPF LSM is mutable), 
remember that we defined LSM_ORDER_LAST so that an LSM can be always 
enable and placed as last (requested by Mimi)?

Thanks

Roberto


