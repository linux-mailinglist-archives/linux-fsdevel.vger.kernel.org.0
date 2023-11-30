Return-Path: <linux-fsdevel+bounces-4524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54422800049
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 01:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0AD28164E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4231C681
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7331715;
	Thu, 30 Nov 2023 15:44:01 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4ShC911BlYz9y8Th;
	Fri,  1 Dec 2023 07:30:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id DA6DC14065C;
	Fri,  1 Dec 2023 07:43:48 +0800 (CST)
Received: from [10.81.202.161] (unknown [10.81.202.161])
	by APP2 (Coremail) with SMTP id GxC2BwCnpV8kHmllcimqAQ--.14981S2;
	Fri, 01 Dec 2023 00:43:48 +0100 (CET)
Message-ID: <9c7860ed-b761-417b-a9ad-bd680f2c8d16@huaweicloud.com>
Date: Fri, 1 Dec 2023 00:43:28 +0100
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
To: Casey Schaufler <casey@schaufler-ca.com>,
 Petr Tesarik <petrtesarik@huaweicloud.com>, Paul Moore <paul@paul-moore.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
 tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
 stephen.smalley.work@gmail.com, eparis@parisplace.org, mic@digikod.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
 <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
 <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
 <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
 <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
 <366a6e5f-d43d-4266-8421-a8a05938a8fd@schaufler-ca.com>
 <66ec6876-483a-4403-9baa-487ebad053f2@huaweicloud.com>
 <a121c359-03c9-42b1-aa19-1e9e34f6a386@schaufler-ca.com>
 <9297638a-8dab-42ba-8b60-82c03497c9cd@huaweicloud.com>
 <018438d4-44b9-4734-9c0c-8a65f9c605a4@schaufler-ca.com>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <018438d4-44b9-4734-9c0c-8a65f9c605a4@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCnpV8kHmllcimqAQ--.14981S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWfZrWkGFy5CFy3XF4kXrb_yoW5KFyfpa
	yxtFW7KFWqyr48Kwn2ya15WFyjyws3Aa45Gr1UJF10k3s8Wr1Ivr4Igr4a9FyDCrsakry0
	qrWav34avrs8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	J73DUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBF1jj5MfhQAAsv

On 12/1/2023 12:31 AM, Casey Schaufler wrote:
> On 11/30/2023 1:34 PM, Roberto Sassu wrote:
>> On 11/30/2023 5:15 PM, Casey Schaufler wrote:
>>> On 11/30/2023 12:30 AM, Petr Tesarik wrote:
>>>> Hi all,
>>>>
>>>> On 11/30/2023 1:41 AM, Casey Schaufler wrote:
>>>>> ...
>>>>> It would be nice if the solution directly addresses the problem.
>>>>> EVM needs to be after the LSMs that use xattrs, not after all LSMs.
>>>>> I suggested LSM_ORDER_REALLY_LAST in part to identify the notion as
>>>>> unattractive.
>>>> Excuse me to chime in, but do we really need the ordering in code?
>>>
>>> tl;dr - Yes.
>>>
>>>>    FWIW
>>>> the linker guarantees that objects appear in the order they are seen
>>>> during the link (unless --sort-section overrides that default, but this
>>>> option is not used in the kernel). Since *.a archive files are used in
>>>> kbuild, I have also verified that their use does not break the
>>>> assumption; they are always created from scratch.
>>>>
>>>> In short, to enforce an ordering, you can simply list the corresponding
>>>> object files in that order in the Makefile. Of course, add a big fat
>>>> warning comment, so people understand the order is not arbitrary.
>>>
>>> Not everyone builds custom kernels.
>>
>> Sorry, I didn't understand your comment.
> 
> Most people run a disto supplied kernel. If the LSM ordering were determined
> only at compile time you could never run a kernel that omitted an LSM.

Ah, ok. We are talking about the LSMs with order LSM_ORDER_LAST which 
are always enabled and the last.

This is the code in security.c to handle them:

         /* LSM_ORDER_LAST is always last. */
         for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
                 if (lsm->order == LSM_ORDER_LAST)
                         append_ordered_lsm(lsm, "   last");
         }

Those LSMs are not affected by lsm= in the kernel command line, or the 
order in the kernel configuration (those are the mutable LSMs).

In this case, clearly, what matters is how LSMs are stored in the 
.lsm_info.init section. See the DEFINE_LSM() macro:

#define DEFINE_LSM(lsm)                                                \
         static struct lsm_info __lsm_##lsm                             \
                 __used __section(".lsm_info.init")                     \
                 __aligned(sizeof(unsigned long))

With Petr, we started to wonder if somehow the order in which LSMs are 
placed in this section is deterministic. I empirically tried to swap the 
order in which IMA and EVM are compiled in the Makefile, and that led to 
'evm' being placed in the LSM list before 'ima'.

The question is if this behavior is deterministic, or there is a case 
where 'evm' is before 'ima', despite they are in the inverse order in 
the Makefile.

Petr looked at the kernel linking process, which is relevant for the 
order of LSMs in the .lsm_info.init section, and he found that the order 
in the section always corresponds to the order in the Makefile.

Thanks

Roberto
>> Everyone builds the kernel, also Linux distros. What Petr was
>> suggesting was that it does not matter how you build the kernel, the
>> linker will place the LSMs in the order they appear in the Makefile.
>> And for this particular case, we have:
>>
>> obj-$(CONFIG_IMA)                       += ima/
>> obj-$(CONFIG_EVM)                       += evm/
>>
>> In the past, I also verified that swapping these two resulted in the
>> swapped order of LSMs. Petr confirmed that it would always happen.
> 
> LSM execution order is not based on compilation order. It is specified
> by CONFIG_LSM, and may be modified by the LSM_ORDER value. I don't
> understand why the linker is even being brought into the discussion.
> 
>>
>> Thanks
>>
>> Roberto


