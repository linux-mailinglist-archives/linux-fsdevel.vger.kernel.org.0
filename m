Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E119560C156
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 03:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiJYBqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 21:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiJYBqO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EC3B7D6
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 18:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666661763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DYLvMWohMQOnmNwDsrK+I31G6MoBnNEl5ivt4+nnJo=;
        b=SPMkVM20ZHrqAdxEv+qIg5bucR2w8thUhzJCrJH/mgwonGzfbzjf9xKN9wLbPsI3vEKxql
        I6QiYM+ZLb01V/NvPfkwqNQIkcJH1nRcqv0VbEjIsknIvtZ9w+/rcLXHeXTvJt4EXTpSjJ
        cObiRroFJj/2n/eaKZmjDac24+ILOcY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-394-IzK7qnJZMgi4EcbXyMLHCg-1; Mon, 24 Oct 2022 21:36:01 -0400
X-MC-Unique: IzK7qnJZMgi4EcbXyMLHCg-1
Received: by mail-pl1-f197.google.com with SMTP id u9-20020a17090341c900b0017f8514cf61so7295585ple.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 18:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DYLvMWohMQOnmNwDsrK+I31G6MoBnNEl5ivt4+nnJo=;
        b=3rlgFQ5sYo6R9tWErwgt1c0uCFyO6vbSFRq0GAVi6IwzNNLhvyNZ8vQoJ/lVjVsl8k
         dyilKKu2CLiHvS863mSstF9xLxl/b/VoXFKdw77OsWl35tUKGBISZoEy8piArrLb2YC1
         2Pe7MgBfgc5j5HjhsgKPtEvGMSlv5pL4BE6uHd9vkjBxpP13AQHls3aC46iySgnJAzmv
         q/Trv2xwNiGfvPwSjWGosT1EDC035NNUsx2Jngvc4nytO1Kmm0tfnUw5dwyfeEp4Po5C
         Pgi2LcFFxwOmyX3akBoYO4yLCDeCyoBVYhWiGnFQknVzOMICOcle0TutqZnBzQ+B9soj
         zD+Q==
X-Gm-Message-State: ACrzQf2wUVBNxgH4HF/1y99z0wvmosB/Xau/RW17SPNYLveKhtEHYj8f
        gkSQb7Cqk8pbkkC5opbIqyrTjQ9/WYW6NdLRVi/Twbq624QAclqiq7Q0Ad4BN5T3S3XXG9GjXgX
        jI7HfGi+zv9/3n5Sbs+KxtJdMZQ==
X-Received: by 2002:a63:b4d:0:b0:454:d8b4:285 with SMTP id a13-20020a630b4d000000b00454d8b40285mr30990770pgl.410.1666661759997;
        Mon, 24 Oct 2022 18:35:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM49YaDrb9kBPStSxqrZQcx8RoSrIeo6axA2H/PsteEYVv3nOwTp6g7CuOF6YPHb2NT9Go57jw==
X-Received: by 2002:a63:b4d:0:b0:454:d8b4:285 with SMTP id a13-20020a630b4d000000b00454d8b40285mr30990755pgl.410.1666661759701;
        Mon, 24 Oct 2022 18:35:59 -0700 (PDT)
Received: from [10.72.12.79] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090341c100b001714c36a6e7sm298288ple.284.2022.10.24.18.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 18:35:59 -0700 (PDT)
Subject: Re: [PATCH] fs/ceph/super: add mount options "snapdir{mode,uid,gid}"
To:     Jeff Layton <jlayton@kernel.org>,
        Max Kellermann <max.kellermann@ionos.com>
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220927120857.639461-1-max.kellermann@ionos.com>
 <88f8941f-82bf-5152-b49a-56cb2e465abb@redhat.com>
 <CAKPOu+88FT1SeFDhvnD_NC7aEJBxd=-T99w67mA-s4SXQXjQNw@mail.gmail.com>
 <75e7f676-8c85-af0a-97b2-43664f60c811@redhat.com>
 <CAKPOu+-rKOVsZ1T=1X-T-Y5Fe1MW2Fs9ixQh8rgq3S9shi8Thw@mail.gmail.com>
 <baf42d14-9bc8-93e1-3d75-7248f93afbd2@redhat.com>
 <cd5ed50a3c760f746a43f8d68fdbc69b01b89b39.camel@kernel.org>
 <7e28f7d1-cfd5-642a-dd4e-ab521885187c@redhat.com>
 <8ef79208adc82b546cc4c2ba20b5c6ddbc3a2732.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <7d40fada-f5f8-4357-c559-18421266f5b4@redhat.com>
Date:   Tue, 25 Oct 2022 09:35:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <8ef79208adc82b546cc4c2ba20b5c6ddbc3a2732.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 20/10/2022 18:13, Jeff Layton wrote:
> On Thu, 2022-10-20 at 09:29 +0800, Xiubo Li wrote:
>> On 11/10/2022 18:45, Jeff Layton wrote:
>>> On Mon, 2022-10-10 at 10:02 +0800, Xiubo Li wrote:
>>>> On 09/10/2022 18:27, Max Kellermann wrote:
>>>>> On Sun, Oct 9, 2022 at 10:43 AM Xiubo Li <xiubli@redhat.com> wrote:
>>>>>> I mean CEPHFS CLIENT CAPABILITIES [1].
>>>>> I know that, but that's suitable for me. This is client-specific, not
>>>>> user (uid/gid) specific.
>>>>>
>>>>> In my use case, a server can run unprivileged user processes which
>>>>> should not be able create snapshots for their own home directory, and
>>>>> ideally they should not even be able to traverse into the ".snap"
>>>>> directory and access the snapshots created of their home directory.
>>>>> Other (non-superuser) system processes however should be able to
>>>>> manage snapshots. It should be possible to bind-mount snapshots into
>>>>> the user's mount namespace.
>>>>>
>>>>> All of that is possible with my patch, but impossible with your
>>>>> suggestion. The client-specific approach is all-or-nothing (unless I
>>>>> miss something vital).
>>>>>
>>>>>> The snapdir name is a different case.
>>>>> But this is only about the snapdir. The snapdir does not exist on the
>>>>> server, it is synthesized on the client (in the Linux kernel cephfs
>>>>> code).
>>>> This could be applied to it's parent dir instead as one metadata in mds
>>>> side and in client side it will be transfer to snapdir's metadata, just
>>>> like what the snapshots.
>>>>
>>>> But just ignore this approach.
>>>>
>>>>>> But your current approach will introduce issues when an UID/GID is reused after an user/groud is deleted ?
>>>>> The UID I would specify is one which exists on the client, for a
>>>>> dedicated system user whose purpose is to manage cephfs snapshots of
>>>>> all users. The UID is created when the machine is installed, and is
>>>>> never deleted.
>>>> This is an ideal use case IMO.
>>>>
>>>> I googled about reusing the UID/GID issues and found someone has hit a
>>>> similar issue in their use case.
>>>>
>>> This is always a danger and not just with ceph. The solution to that is
>>> good sysadmin practices (i.e. don't reuse uid/gid values without
>>> sanitizing the filesystems first).
>> Yeah, this sounds reasonable.
>>
>>>>>> Maybe the proper approach is the posix acl. Then by default the .snap dir will inherit the permission from its parent and you can change it as you wish. This permission could be spread to all the other clients too ?
>>>>> No, that would be impractical and unreliable.
>>>>> Impractical because it would require me to walk the whole filesystem
>>>>> tree and let the kernel synthesize the snapdir inode for all
>>>>> directories and change its ACL;
>>>> No, it don't have to. This could work simply as the snaprealm hierarchy
>>>> thing in kceph.
>>>>
>>>> Only the up top directory need to record the ACL and all the descendants
>>>> will point and use it if they don't have their own ACLs.
>>>>
>>>>>     impractical because walking millions
>>>>> of directories takes longer than I am willing to wait.
>>>>> Unreliable because there would be race problems when another client
>>>>> (or even the local client) creates a new directory. Until my local
>>>>> "snapdir ACL daemon" learns about the existence of the new directory
>>>>> and is able to update its ACL, the user can already have messed with
>>>>> it.
>>>> For multiple clients case I think the cephfs capabilities [3] could
>>>> guarantee the consistency of this. While for the single client case if
>>>> before the user could update its ACL just after creating it someone else
>>>> has changed it or messed it up, then won't the existing ACLs have the
>>>> same issue ?
>>>>
>>>> [3] https://docs.ceph.com/en/quincy/cephfs/capabilities/
>>>>
>>>>
>>>>> Both of that is not a problem with my patch.
>>>>>
>>>> Jeff,
>>>>
>>>> Any idea ?
>>>>
>>> I tend to agree with Max here. The .snap dir is a client-side fiction,
>>> so trying to do something on the MDS to govern its use seems a bit odd.
>>> cephx is really about authenticating clients. I know we do things like
>>> enforce root squashing on the MDS, but this is a little different.
>>>
>>> Now, all of that said, snapshot handling is an area where I'm just not
>>> that knowledgeable. Feel free to ignore my opinion here as uninformed.
>> I am thinking currently the cephfs have the same issue we discussed
>> here. Because the cephfs is saving the UID/GID number in the CInode
>> metedata. While when there have multiple clients are sharing the same
>> cephfs, so in different client nodes another user could cross access a
>> specified user's files. For example:
>>
>> In client nodeA:
>>
>> user1's UID is 123, user2's UID is 321.
>>
>> In client nodeB:
>>
>> user1's UID is 321, user2's UID is 123.
>>
>> And if user1 create a fileA in the client nodeA, then user2 could access
>> it from client nodeB.
>>
>> Doesn't this also sound more like a client-side fiction ?
>>
> idmapping is a difficult issue and not at all confined to CephFS. NFSv4
> has a whole upcall facility for mapping IDs, for instance. The MDS has
> no way to know that 123 and 321 are the same user on different machines.
> That sort of mapping must be set up by the administrator.
>
> The real question is: Does it make sense for the MDS to use directory
> permissions to enforce access on something that isn't really a
> directory?
>
> My "gut feeling" here is that the MDS ought to be in charge of governing
> which _clients_ are allowed to make snapshots, but it's up to the client
> to determine which _users_ are allowed to create them. With that concept
> in mind, Max's proposal makes some sense.
>
> Snapshots are not part of POSIX, and the ".snap" directory interface was
> copied from Netapp (AFAICT). Maybe CephFS ought to enforce permissions
> on snapshots the same way Netapps do? I don't know exactly how it works
> there, so some research may be required.
>
> I found this article but it's behind a paywall:
>
>      https://kb.netapp.com/Advice_and_Troubleshooting/Data_Storage_Software/ONTAP_OS_7_Mode/How_to_control_access_to_a_Snapshot_directory
>
Patrick provode a better idea for this feature.

Currently cephx permission has already supported the 's' permission, 
which means you can do the snapshot create/remove. And for a privileged 
or specific mounts you can give them the 's' permission and then only 
they can do the snapshot create/remove. And all the others won't.

And then use the container or something else to make the specific users 
could access to them.

Thanks!

- Xiubo




