Return-Path: <linux-fsdevel+bounces-4514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC17FFE87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 23:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197431C209B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 22:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B55461FC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 22:34:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5476110FA;
	Thu, 30 Nov 2023 13:57:20 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sh8ns56LGz9xqch;
	Fri,  1 Dec 2023 05:43:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 9BC53140EF6;
	Fri,  1 Dec 2023 05:57:07 +0800 (CST)
Received: from [10.81.202.161] (unknown [10.81.202.161])
	by APP1 (Coremail) with SMTP id LxC2BwAH9XQkBWllrDCtAQ--.23231S2;
	Thu, 30 Nov 2023 22:57:07 +0100 (CET)
Message-ID: <a1d549b6-3f36-4e28-aadd-954f1355089b@huaweicloud.com>
Date: Thu, 30 Nov 2023 22:56:47 +0100
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
 <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
 <CAHC9VhROnfBoaOy2MurdSpcE_poo_6Qy9d2U3g6m2NRRHaqz4Q@mail.gmail.com>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CAHC9VhROnfBoaOy2MurdSpcE_poo_6Qy9d2U3g6m2NRRHaqz4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAH9XQkBWllrDCtAQ--.23231S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJF1rAw4rWryfJF17tr4UXFb_yoWkWF1UpF
	W7Ka17Kr4kJry2krn2vF4UZrWSyrW8WryUXrn8Gry8A3s0yr1Iqr4jkrWUuFyDGr4kKw1j
	qr1Ygry7Z3WDZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBF1jj5MfCgAAsg

On 11/30/2023 5:34 PM, Paul Moore wrote:
> On Wed, Nov 29, 2023 at 1:47 PM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
>> On 11/29/2023 6:22 PM, Paul Moore wrote:
>>> On Wed, Nov 29, 2023 at 7:28 AM Roberto Sassu
>>> <roberto.sassu@huaweicloud.com> wrote:
>>>>
>>>> On Mon, 2023-11-20 at 16:06 -0500, Paul Moore wrote:
>>>>> On Mon, Nov 20, 2023 at 3:16 AM Roberto Sassu
>>>>> <roberto.sassu@huaweicloud.com> wrote:
>>>>>> On Fri, 2023-11-17 at 15:57 -0500, Paul Moore wrote:
>>>>>>> On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
>>>>>>>>
>>>>>>>> Before the security field of kernel objects could be shared among LSMs with
>>>>>>>> the LSM stacking feature, IMA and EVM had to rely on an alternative storage
>>>>>>>> of inode metadata. The association between inode metadata and inode is
>>>>>>>> maintained through an rbtree.
>>>>>>>>
>>>>>>>> Because of this alternative storage mechanism, there was no need to use
>>>>>>>> disjoint inode metadata, so IMA and EVM today still share them.
>>>>>>>>
>>>>>>>> With the reservation mechanism offered by the LSM infrastructure, the
>>>>>>>> rbtree is no longer necessary, as each LSM could reserve a space in the
>>>>>>>> security blob for each inode. However, since IMA and EVM share the
>>>>>>>> inode metadata, they cannot directly reserve the space for them.
>>>>>>>>
>>>>>>>> Instead, request from the 'integrity' LSM a space in the security blob for
>>>>>>>> the pointer of inode metadata (integrity_iint_cache structure). The other
>>>>>>>> reason for keeping the 'integrity' LSM is to preserve the original ordering
>>>>>>>> of IMA and EVM functions as when they were hardcoded.
>>>>>>>>
>>>>>>>> Prefer reserving space for a pointer to allocating the integrity_iint_cache
>>>>>>>> structure directly, as IMA would require it only for a subset of inodes.
>>>>>>>> Always allocating it would cause a waste of memory.
>>>>>>>>
>>>>>>>> Introduce two primitives for getting and setting the pointer of
>>>>>>>> integrity_iint_cache in the security blob, respectively
>>>>>>>> integrity_inode_get_iint() and integrity_inode_set_iint(). This would make
>>>>>>>> the code more understandable, as they directly replace rbtree operations.
>>>>>>>>
>>>>>>>> Locking is not needed, as access to inode metadata is not shared, it is per
>>>>>>>> inode.
>>>>>>>>
>>>>>>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>>>>>>> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>>>>>>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>>>>>>> ---
>>>>>>>>    security/integrity/iint.c      | 71 +++++-----------------------------
>>>>>>>>    security/integrity/integrity.h | 20 +++++++++-
>>>>>>>>    2 files changed, 29 insertions(+), 62 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
>>>>>>>> index 882fde2a2607..a5edd3c70784 100644
>>>>>>>> --- a/security/integrity/iint.c
>>>>>>>> +++ b/security/integrity/iint.c
>>>>>>>> @@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
>>>>>>>>       return 0;
>>>>>>>>    }
>>>>>>>>
>>>>>>>> +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
>>>>>>>> +   .lbs_inode = sizeof(struct integrity_iint_cache *),
>>>>>>>> +};
>>>>>>>
>>>>>>> I'll admit that I'm likely missing an important detail, but is there
>>>>>>> a reason why you couldn't stash the integrity_iint_cache struct
>>>>>>> directly in the inode's security blob instead of the pointer?  For
>>>>>>> example:
>>>>>>>
>>>>>>>     struct lsm_blob_sizes ... = {
>>>>>>>       .lbs_inode = sizeof(struct integrity_iint_cache),
>>>>>>>     };
>>>>>>>
>>>>>>>     struct integrity_iint_cache *integrity_inode_get(inode)
>>>>>>>     {
>>>>>>>       if (unlikely(!inode->isecurity))
>>>>>>>         return NULL;
>>>>>>>       return inode->i_security + integrity_blob_sizes.lbs_inode;
>>>>>>>     }
>>>>>>
>>>>>> It would increase memory occupation. Sometimes the IMA policy
>>>>>> encompasses a small subset of the inodes. Allocating the full
>>>>>> integrity_iint_cache would be a waste of memory, I guess?
>>>>>
>>>>> Perhaps, but if it allows us to remove another layer of dynamic memory
>>>>> I would argue that it may be worth the cost.  It's also worth
>>>>> considering the size of integrity_iint_cache, while it isn't small, it
>>>>> isn't exactly huge either.
>>>>>
>>>>>> On the other hand... (did not think fully about that) if we embed the
>>>>>> full structure in the security blob, we already have a mutex available
>>>>>> to use, and we don't need to take the inode lock (?).
>>>>>
>>>>> That would be excellent, getting rid of a layer of locking would be significant.
>>>>>
>>>>>> I'm fully convinced that we can improve the implementation
>>>>>> significantly. I just was really hoping to go step by step and not
>>>>>> accumulating improvements as dependency for moving IMA and EVM to the
>>>>>> LSM infrastructure.
>>>>>
>>>>> I understand, and I agree that an iterative approach is a good idea, I
>>>>> just want to make sure we keep things tidy from a user perspective,
>>>>> i.e. not exposing the "integrity" LSM when it isn't required.
>>>>
>>>> Ok, I went back to it again.
>>>>
>>>> I think trying to separate integrity metadata is premature now, too
>>>> many things at the same time.
>>>
>>> I'm not bothered by the size of the patchset, it is more important
>>> that we do The Right Thing.  I would like to hear in more detail why
>>> you don't think this will work, I'm not interested in hearing about
>>> difficult it may be, I'm interested in hearing about what challenges
>>> we need to solve to do this properly.
>>
>> The right thing in my opinion is to achieve the goal with the minimal
>> set of changes, in the most intuitive way.
> 
> Once again, I want to stress that I don't care about the size of the
> change, the number of patches in a patchset, etc.  While it's always
> nice to be able to minimize the number of changes in a patch/patchset,
> that is secondary to making sure we are doing the right thing over the
> long term.  This is especially important when we are talking about
> things that are user visible.

If we successfully remove the 'integrity' LSM we achieve the goal.

What you say is beyond the scope of this patch set, which is just moving 
IMA and EVM to the LSM infrastructure.

Of course we can discuss about nice ideas, how to improve IMA and EVM, 
but again this is beyond scope.

>> Until now, there was no solution that could achieve the primary goal of
>> this patch set (moving IMA and EVM to the LSM infrastructure) and, at
>> the same time, achieve the additional goal you set of removing the
>> 'integrity' LSM.
> 
> We need to stop thinking about the "integrity" code as a LSM, it isn't
> a LSM.  It's a vestigial implementation detail that was necessary back
> when there could only be one LSM active at a time and there was a
> desire to have IMA/EVM active in conjunction with one of the LSMs,
> i.e. Smack, SELinux, etc.
> 
> IMA and EVM are (or will be) LSMs, "integrity" is not.  I recognize
> that eliminating the need for the "integrity" code is a relatively new
> addition to this effort, but that is only because I didn't properly
> understand the relationship between IMA, EVM, and the "integrity" code
> until recently.  The elimination of the shared "integrity" code is
> consistent with promoting IMA and EVM as full LSMs, if there is core
> functionality that cannot be split up into the IMA and/or EVM LSMs
> then we need to look at how to support that without exposing that
> implementation detail/hack to userspace.  Maybe that means direct
> calls between IMA and EVM, maybe that means preserving some of the
> common integrity code hidden from userspace, maybe that means adding
> functionality to the LSM layer, maybe that means something else?
> Let's think on this to come up with something that we can all accept
> as a long term solution instead of just doing the quick and easy
> option.

Sorry, once we find the proper way to interface the 'ima' and 'evm' LSM 
with the LSM infrastructure, that is all we need to do.

Not changing any internal gives the best guarantee that the behavior 
remains unchanged. And the best thing is that we are not doing a hack, 
we are just preserving what is there.

Sorry, again, we are not exposing to user space any interface that is 
going to change in the future once we refactor the integrity metadata 
management. So, given that, I still haven't seen any compelling reason 
to do the change you suggested.

>> If you see the diff, the changes compared to v5 that was already
>> accepted by Mimi are very straightforward. If the assumption I made that
>> in the end the 'ima' LSM could take over the role of the 'integrity'
>> LSM, that for me is the preferable option.
> 
> I looked at it quickly, but my workflow isn't well suited for patches
> as attachments; inline patches (the kernel standard) is preferable.

Ok, no problem. I send the patches.

>> Given that the patch set is not doing any design change, but merely
>> moving calls and storing pointers elsewhere, that leaves us with the
>> option of thinking better what to do next, including like you suggested
>> to make IMA and EVM use disjoint metadata.
>>
>>>> I started to think, does EVM really need integrity metadata or it can
>>>> work without?
>>>>
>>>> The fact is that CONFIG_IMA=n and CONFIG_EVM=y is allowed, so we have
>>>> the same problem now. What if we make IMA the one that manages
>>>> integrity metadata, so that we can remove the 'integrity' LSM?
>>>
>>> I guess we should probably revisit the basic idea of if it even makes
>>> sense to enable EVM without IMA?  Should we update the Kconfig to
>>> require IMA when EVM is enabled?
>>
>> That would be up to Mimi. Also this does not seem the main focus of the
>> patch set.
> 
> Yes, it is not part of the original main focus, but it is definitely
> relevant to the discussion we are having now.  Once again, the most
> important thing to me is that we do The Right Thing for the long term
> maintenance of the code base; if that means scope creep, I've got no
> problem with that.
> 
>>>> Regarding the LSM order, I would take Casey's suggestion of introducing
>>>> LSM_ORDER_REALLY_LAST, for EVM.
>>>
>>> Please understand that I really dislike that we have imposed ordering
>>> constraints at the LSM layer, but I do understand the necessity (the
>>> BPF LSM ordering upsets me the most).  I really don't want to see us
>>> make things worse by adding yet another ordering bucket, I would
>>> rather that we document it well and leave it alone ... basically treat
>>> it like the BPF LSM (grrrrrr).
>>
>> Uhm, that would not be possible right away (the BPF LSM is mutable),
>> remember that we defined LSM_ORDER_LAST so that an LSM can be always
>> enable and placed as last (requested by Mimi)?
> 
> To be clear, I can both dislike the bpf-always-last and LSM_ORDER_LAST
> concepts while accepting them as necessary evils.  I'm willing to
> tolerate LSM_ORDER_LAST, but I'm not currently willing to tolerate
> LSM_ORDER_REALLY_LAST; that is one step too far right now.  I brought
> up the BPF LSM simply as an example of ordering that is not enforced
> by code, but rather by documentation and convention.

Given what Petr found, we don't need an additional order.

Thanks

Roberto


