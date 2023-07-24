Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD76675E5F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 03:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjGXBDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jul 2023 21:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjGXBDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7378137
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jul 2023 18:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690160543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WkKtlTfdzdRbT+kDNFRtZnQaI9gazMxS86pPa1uKms=;
        b=Fu1KBf03Q9PeUL6lruerhZ5FEnfnmcIXXfg8qeR0ziUqfc3wFCQesqzpK9IP+g+KCyGU0j
        DYf4/xXzINOE3Cb8pXQX/lNRzxGCNqT9RgVmuwrQjTzULSFCZC5VOQ0pB1ngTySVj4DxmA
        qBoEztlMMplMptLP8GHNZZeSXhJr2Ks=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-RTJnBw7BPEKnYsBUrBOkBw-1; Sun, 23 Jul 2023 21:02:22 -0400
X-MC-Unique: RTJnBw7BPEKnYsBUrBOkBw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-682a4f1253aso2712064b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jul 2023 18:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690160541; x=1690765341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WkKtlTfdzdRbT+kDNFRtZnQaI9gazMxS86pPa1uKms=;
        b=X89jjXd6DBb5DSeHy7NrVoCDfMNUkA+ktp0H+/ZmXB0pFK9fL5yYADxaY50haxzwLL
         abbc3DCf7eEhCCpVa8yPnsRzkbsV3heun/vJzdi9B8+nuIfvjFO3jhwP+m92RXT371zD
         qIaHBhvOkMVFz7ih/Mft0+ljaroBeR/keYUD99PwneJNC8xVKsfYc+mIQkHf0TrcNwdO
         Nq5zsBOIb9XKtFrq4ESALEfiIimVs/fukkWvPbnkmrFW8fAa4TonLNbty1yg2Rg0Rz6u
         Fs90nVJvD/MyUySpakaLaOnmAU2jnkmwi9Z0Ee+9XVhEUuH3uCvGpCwPQJc1XE2S0o3Y
         6U9g==
X-Gm-Message-State: ABy/qLb+Bd0lTyeIs46HVu6dl0i4Y/570wFLYlAoCllpWH0QPxdR3LvZ
        K33ZG+bVAO7nUBt7smj2VX5+HLxjN7wGtbd0VEgyNbBOCuh4DxXAbbOlqJcsi58uRuxxj6FeOi0
        X9fjr+uxbNeJrctJGsDi0fhIrpQ==
X-Received: by 2002:a05:6a21:3285:b0:125:3445:8af0 with SMTP id yt5-20020a056a21328500b0012534458af0mr10459876pzb.7.1690160541389;
        Sun, 23 Jul 2023 18:02:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEbA72/PSHrxZsKmR4e7rOkEQj6d1T9id3AOxCvask7WNZAKcWp07bL2d7kxYekhkNEGpM1MQ==
X-Received: by 2002:a05:6a21:3285:b0:125:3445:8af0 with SMTP id yt5-20020a056a21328500b0012534458af0mr10459863pzb.7.1690160541026;
        Sun, 23 Jul 2023 18:02:21 -0700 (PDT)
Received: from [10.72.112.55] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j1-20020aa783c1000000b0063f00898245sm952470pfn.146.2023.07.23.18.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 18:02:20 -0700 (PDT)
Message-ID: <e48455d5-ca00-5f39-7608-1fc6fc8e4718@redhat.com>
Date:   Mon, 24 Jul 2023 09:02:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
Content-Language: en-US
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        Christian Brauner <brauner@kernel.org>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com>
 <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
 <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com>
 <64241ff0-9af3-6817-478f-c24a0b9de9b3@redhat.com>
 <CAEivzxeF51ZEKhQ-0M35nooZ7_cZgk1-q75-YbkeWpZ9RuHG4A@mail.gmail.com>
 <4c4f73d8-8238-6ab8-ae50-d83c1441ac05@redhat.com>
 <CAEivzxeQGkemxVwJ148b_+OmntUAWkdL==yMiTMN+GPyaLkFPg@mail.gmail.com>
 <0a42c5d0-0479-e60e-ac84-be3b915c62d9@redhat.com>
 <CAEivzxcskn8WxcOo0PDHMascFRdYTD0Lr5Uo4fj3deBjDviOXA@mail.gmail.com>
 <8121882a-0823-3a60-e108-0ff7bae5c0c9@redhat.com>
 <CAEivzxcaJQvYyutAL8xapvoer06c97uVSVC729pUE=4_z4m_CA@mail.gmail.com>
 <CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com>
 <3af4f092-8de7-d217-cd2d-d39dfc625edd@redhat.com>
 <CAEivzxcM2=nwtTJ7ZUwubk0m4Fr+otuqzJhp+bRAYLMXuEYZgg@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAEivzxcM2=nwtTJ7ZUwubk0m4Fr+otuqzJhp+bRAYLMXuEYZgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/21/23 23:43, Aleksandr Mikhalitsyn wrote:
> On Thu, Jul 20, 2023 at 8:36 AM Xiubo Li <xiubli@redhat.com> wrote:
>>
>> On 7/19/23 19:57, Aleksandr Mikhalitsyn wrote:
>>> On Tue, Jul 18, 2023 at 4:49 PM Aleksandr Mikhalitsyn
>>> <aleksandr.mikhalitsyn@canonical.com> wrote:
>>>> On Tue, Jul 18, 2023 at 3:45 AM Xiubo Li <xiubli@redhat.com> wrote:
>> [...]
>>>> No, the idea is to stop mapping a caller_{uid, gid}. And to add a new
>>>> fields like
>>>> inode_owner_{uid, gid} which will be idmapped (this field will be specific only
>>>> for those operations that create a new inode).
>>> I've decided to write some summary of different approaches and
>>> elaborate tricky places.
>>>
>>> Current implementation.
>>>
>>> We have head->caller_{uid,gid} fields mapped in according
>>> to the mount's idmapping. But as we don't have information about
>>> mount's idmapping in all call stacks (like ->lookup case), we
>>> are not able to map it always and they are left untouched in these cases.
>>>
>>> This tends to an inconsistency between different inode_operations,
>>> for example ->lookup (don't have an access to an idmapping) and
>>> ->mkdir (have an idmapping as an argument).
>>>
>>> This inconsistency is absolutely harmless if the user does not
>>> use UID/GID-based restrictions. Because in this use case head->caller_{uid,gid}
>>> fields used *only* to set inode owner UID/GID during the inode_operations
>>> which create inodes.
>>>
>>> Conclusion 1. head->caller_{uid,gid} fields have two meanings
>>> - UID/GID-based permission checks
>>> - inode owner information
>>>
>>> Solution 0. Ignore the issue with UID/GID-based restrictions and idmapped mounts
>>> until we are not blamed by users ;-)
>>>
>>> As far as I can see you are not happy about this way. :-)
>>>
>>> Solution 1. Let's add mount's idmapping argument to all inode_operations
>>> and always map head->caller_{uid,gid} fields.
>>>
>>> Not a best idea, because:
>>> - big modification of VFS layer
>>> - ideologically incorrect, for instance ->lookup should not care
>>> and know *anything* about mount's idmapping, because ->lookup works
>>> not on the mount level (it's not important who and through which mount
>>> triggered the ->lookup). Imagine that you've dentry cache filled and call
>>> open(...) in this case ->lookup can be uncalled. But if the user was not lucky
>>> enough to have cache filled then open(..) will trigger the lookup and
>>> then ->lookup results will be dependent on the mount's idmapping. It
>>> seems incorrect
>>> and unobvious consequence of introducing such a parameter to ->lookup operation.
>>> To summarize, ->lookup is about filling dentry cache and dentry cache
>>> is superblock-level
>>> thing, not mount-level.
>>>
>>> Solution 2. Add some kind of extra checks to ceph-client and ceph
>>> server to detect that
>>> mount idmappings used with UID/GID-based restrictions and restrict such mounts.
>>>
>>> Seems not ideal to me too. Because it's not a fix, it's a limitation
>>> and this limitation is
>>> not cheap from the implementation perspective (we need heavy changes
>>> in ceph server side and
>>> client side too). Btw, currently VFS API is also not ready for that,
>>> because we can't
>>> decide if idmapped mounts are allowed or not in runtime. It's a static
>>> thing that should be declared
>>> with FS_ALLOW_IDMAP flag in (struct file_system_type)->fs_flags. Not a
>>> big deal, but...
>>>
>>> Solution 3. Add a new UID/GID fields to ceph request structure in
>>> addition to head->caller_{uid,gid}
>>> to store information about inode owners (only for inode_operations
>>> which create inodes).
>>>
>>> How does it solves the problem?
>>> With these new fields we can leave head->caller_{uid,gid} untouched
>>> with an idmapped mounts code.
>>> It means that UID/GID-based restrictions will continue to work as intended.
>>>
>>> At the same time, new fields (let say "inode_owner_{uid,gid}") will be
>>> mapped in accordance with
>>> a mount's idmapping.
>>>
>>> This solution seems ideal, because it is philosophically correct, it
>>> makes cephfs idmapped mounts to work
>>> in the same manner and way as idmapped mounts work for any other
>>> filesystem like ext4.
>> Okay, this approach sounds more reasonable to me. But you need to do
>> some extra work to make it to be compatible between {old,new} kernels
>> and  {old,new} cephs.
>>
>> So then the caller uid/gid will always be the user uid/gid issuing the
>> requests as now.
> Dear Xiubo,
>
> I've posted a PR https://github.com/ceph/ceph/pull/52575

Sure. Will check.

Thanks

- Xiubo

> Kind regards,
> Alex
>
>> Thanks
>>
>> - Xiubo
>>
>>
>>> But yes, this requires cephfs protocol changes...
>>>
>>> I personally still believe that the "Solution 0" approach is optimal
>>> and we can go with "Solution 3" way
>>> as the next iteration.
>>>
>>> Kind regards,
>>> Alex
>>>
>>>> And also the same for other non-create requests. If
>>>>> so this will be incorrect for the cephx perm checks IMO.
>>>> Thanks,
>>>> Alex
>>>>
>>>>> Thanks
>>>>>
>>>>> - Xiubo
>>>>>
>>>>>
>>>>>> This makes a problem with path-based UID/GID restriction mechanism,
>>>>>> because it uses head->caller_{uid,gid} fields
>>>>>> to check if UID/GID is permitted or not.
>>>>>>
>>>>>> So, the problem is that we have one field in ceph request for two
>>>>>> different needs - to control permissions and to set inode owner.
>>>>>> Christian pointed that the most saner way is to modify ceph protocol
>>>>>> and add a separate field to store inode owner UID/GID,
>>>>>> and only this fields should be idmapped, but head->caller_{uid,gid}
>>>>>> will be untouched.
>>>>>>
>>>>>> With this approach, we will not affect UID/GID-based permission rules
>>>>>> with an idmapped mounts at all.
>>>>>>
>>>>>> Kind regards,
>>>>>> Alex
>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> - Xiubo
>>>>>>>
>>>>>>>
>>>>>>>> Kind regards,
>>>>>>>> Alex
>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>>> - Xiubo
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Alex
>>>>>>>>>>
>>>>>>>>>>> Thanks
>>>>>>>>>>>
>>>>>>>>>>> - Xiubo
>>>>>>>>>>>

