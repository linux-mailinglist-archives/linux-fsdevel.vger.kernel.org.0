Return-Path: <linux-fsdevel+bounces-4513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142737FFE86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 23:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C53D1C20A1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 22:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A126F61FB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 22:34:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631C6194;
	Thu, 30 Nov 2023 13:35:09 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sh8JG0NwSz9yGX1;
	Fri,  1 Dec 2023 05:21:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id E7FC0140F0D;
	Fri,  1 Dec 2023 05:34:55 +0800 (CST)
Received: from [10.81.202.161] (unknown [10.81.202.161])
	by APP1 (Coremail) with SMTP id LxC2BwA3c3Pv_2hljvGsAQ--.1329S2;
	Thu, 30 Nov 2023 22:34:55 +0100 (CET)
Message-ID: <9297638a-8dab-42ba-8b60-82c03497c9cd@huaweicloud.com>
Date: Thu, 30 Nov 2023 22:34:37 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
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
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <a121c359-03c9-42b1-aa19-1e9e34f6a386@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwA3c3Pv_2hljvGsAQ--.1329S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWrtFWxCr4fWr4kKr1xXwb_yoW8Xw4rpa
	yxtayUtF4qyr47KrZ2ya1FgFyFvFs3AFy5Jry5tr1Fy3s8WFyxAr4xKFsI9asrCwnak34F
	yrWay3s0vr4kAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73D
	UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBF1jj5cdpQAFsP

On 11/30/2023 5:15 PM, Casey Schaufler wrote:
> On 11/30/2023 12:30 AM, Petr Tesarik wrote:
>> Hi all,
>>
>> On 11/30/2023 1:41 AM, Casey Schaufler wrote:
>>> ...
>>> It would be nice if the solution directly addresses the problem.
>>> EVM needs to be after the LSMs that use xattrs, not after all LSMs.
>>> I suggested LSM_ORDER_REALLY_LAST in part to identify the notion as
>>> unattractive.
>> Excuse me to chime in, but do we really need the ordering in code?
> 
> tl;dr - Yes.
> 
>>   FWIW
>> the linker guarantees that objects appear in the order they are seen
>> during the link (unless --sort-section overrides that default, but this
>> option is not used in the kernel). Since *.a archive files are used in
>> kbuild, I have also verified that their use does not break the
>> assumption; they are always created from scratch.
>>
>> In short, to enforce an ordering, you can simply list the corresponding
>> object files in that order in the Makefile. Of course, add a big fat
>> warning comment, so people understand the order is not arbitrary.
> 
> Not everyone builds custom kernels.

Sorry, I didn't understand your comment. Everyone builds the kernel, 
also Linux distros. What Petr was suggesting was that it does not matter 
how you build the kernel, the linker will place the LSMs in the order 
they appear in the Makefile. And for this particular case, we have:

obj-$(CONFIG_IMA)                       += ima/
obj-$(CONFIG_EVM)                       += evm/

In the past, I also verified that swapping these two resulted in the 
swapped order of LSMs. Petr confirmed that it would always happen.

Thanks

Roberto


