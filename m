Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AB123BDBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgHDQIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 12:08:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56274 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbgHDQHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:07:45 -0400
Received: from [10.137.106.139] (unknown [131.107.174.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id C947F20B4908;
        Tue,  4 Aug 2020 09:07:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C947F20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596557247;
        bh=4tc7ukCcPyol40cGNCHOnU9JsMLB2DAzg5ZehqWEL3s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WaO0B9rj2UDzfKn9XUcHQWxCPmx+3QxsciSW+4tdIO3nrwRFCLUnj7n7RpzP7/MAZ
         Nxtva1f0C43CJNOx/HLk1V8oi8EuAPmpIa6uFwb6ZspRejtdyFxKgCDTfXNobEIbyf
         i1gXkOdBtGErAnIRoc9Z8BMv+Y/vF6VKZ0axZ1v4=
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM
 (IPE)
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Pavel Machek <pavel@ucw.cz>, Sasha Levin <sashal@kernel.org>
Cc:     snitzer@redhat.com, zohar@linux.ibm.com, dm-devel@redhat.com,
        tyhicks@linux.microsoft.com, agk@redhat.com, paul@paul-moore.com,
        mdsakib@microsoft.com, jmorris@namei.org,
        nramas@linux.microsoft.com, serge@hallyn.com,
        pasha.tatashin@soleen.com, jannh@google.com,
        linux-block@vger.kernel.org, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, corbet@lwn.net, linux-kernel@vger.kernel.org,
        eparis@redhat.com, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200802115545.GA1162@bug> <20200802140300.GA2975990@sasha-vm>
 <20200802143143.GB20261@amd> <1596386606.4087.20.camel@HansenPartnership.com>
From:   Deven Bowers <deven.desai@linux.microsoft.com>
Message-ID: <fb35a1f7-7633-a678-3f0f-17cf83032d2b@linux.microsoft.com>
Date:   Tue, 4 Aug 2020 09:07:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1596386606.4087.20.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/2/2020 9:43 AM, James Bottomley wrote:
> On Sun, 2020-08-02 at 16:31 +0200, Pavel Machek wrote:
>> On Sun 2020-08-02 10:03:00, Sasha Levin wrote:
>>> On Sun, Aug 02, 2020 at 01:55:45PM +0200, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>> IPE is a Linux Security Module which allows for a configurable
>>>>> policy to enforce integrity requirements on the whole system.
>>>>> It attempts to solve the issue of Code Integrity: that any code
>>>>> being executed (or files being read), are identical to the
>>>>> version that was built by a trusted source.
>>>>
>>>> How is that different from security/integrity/ima?
>>>
>>> Maybe if you would have read the cover letter all the way down to
>>> the 5th paragraph which explains how IPE is different from IMA we
>>> could avoided this mail exchange...
>>
>> "
>> IPE differs from other LSMs which provide integrity checking (for
>> instance,
>> IMA), as it has no dependency on the filesystem metadata itself. The
>> attributes that IPE checks are deterministic properties that exist
>> solely
>> in the kernel. Additionally, IPE provides no additional mechanisms of
>> verifying these files (e.g. IMA Signatures) - all of the attributes
>> of
>> verifying files are existing features within the kernel, such as
>> dm-verity
>> or fsverity.
>> "
>>
>> That is not really helpful.

Perhaps I can explain (and re-word this paragraph) a bit better.

As James indicates, IPE does try to close the gap of the IMA limitation
with xattr. I honestly wasn’t familiar with the appended signatures,
which seems fine.

Regardless, this isn’t the larger benefit that IPE provides. The
larger benefit of this is how IPE separates _mechanisms_ (properties)
to enforce integrity requirements, from _policy_. The LSM provides
policy, while things like dm-verity provide mechanism.

So to speak, IPE acts as the glue for other mechanisms to leverage a
customizable, system-wide policy to enforce. While this initial
patchset only onboards dm-verity, there’s also potential for MAC labels,
fs-verity, authenticated BTRFS, dm-integrity, etc. IPE leverages
existing systems in the kernel, while IMA uses its own.

Another difference is the general coverage. IMA has some difficulties
in covering mprotect[1], IPE doesn’t (the MAP_ANONYMOUS indicated by
Jann in that thread would be denied as the file struct would be null,
with IPE’s current set of supported mechanisms. mprotect would continue
to function as expected if you change to PROT_EXEC).

> Perhaps the big question is: If we used the existing IMA appended
> signature for detached signatures (effectively becoming the
> "properties" referred to in the cover letter) and hooked IMA into
> device mapper using additional policy terms, would that satisfy all the
> requirements this new LSM has?

Well, Mimi, what do you think? Should we integrate all the features of
IPE into IMA, or do you think they are sufficiently different in
architecture that it would be worth it to keep the code base in separate
LSMs?


[1] 
https://lore.kernel.org/linux-integrity/1588688204.5157.5.camel@linux.ibm.com/

