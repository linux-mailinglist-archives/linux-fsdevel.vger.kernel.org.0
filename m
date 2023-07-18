Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363D2757175
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 03:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjGRBpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 21:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjGRBpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:45:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12781A6
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 18:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689644699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IhD0+ZBVPYFnTWd85wDpKQlkImyuWRSCaCnKLkybDrg=;
        b=E/kYxDnJ0O2a/Y5cWy5I+37JheC5qovA4AF/XvWJbctAYXTDw0ulzU4NvuDFTYqzwD/E+l
        QsvxdXbX9dDg0eXAbkP9lCuDdrXuhXH1YT0dj+XsPtPST6jX7HWpEXXANgVgdFjb8Me2kD
        qp2cujKyxAPR5QqFhcdQCvgz69RPO1k=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-ids0YhVlMEuKi08e4EgdNw-1; Mon, 17 Jul 2023 21:44:58 -0400
X-MC-Unique: ids0YhVlMEuKi08e4EgdNw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-666edb72db2so2833360b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 18:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689644697; x=1692236697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhD0+ZBVPYFnTWd85wDpKQlkImyuWRSCaCnKLkybDrg=;
        b=PU07odhHWN5If/uWsRPdl6Q4SQ+pfShAqbMzHT8FxNB6Urfq90mUJzeLRkJVZ22w9z
         FkaTtfqb0RIEB9wbnL4H4an2r8J4S+jiDkd8bGRV+4wvFEDxDwWvSrQKikqwu+Ggm4c6
         nzrj72/vRdCrafypCKRDnrerqouEX1fch5CYh+KxY9xzx3ATJKfmjGwspJ8XH7Ifk8ii
         UQgCRZRERHD+XqeRfKH48TImvoz3Y4sOxCCH9ygQM74XtBlEI8hw4YV962gWvYDj7uGC
         yzUQFNQECYaf1Flr6eqdFwTGvSY7ZVWtH4bboNrJuZlMqzbG2lqPvtNx76TwGZ2/zZPv
         0X/Q==
X-Gm-Message-State: ABy/qLYmLQB1EdHW87e5Gebn30NvDAasvgYFCG3JR0L8670JXb/gi/BH
        p3O3ghaS5uIivABQw2W593mZWXFAhTkOQng+ajdZr7pDkI5GINz2eIEr0WQZYTv4fLzYYnGAT8t
        ATfNMwfNEFBc3IxLI2ucgkrCYMfkYyPUjA5Yd
X-Received: by 2002:a05:6a20:5498:b0:133:6c35:99c1 with SMTP id i24-20020a056a20549800b001336c3599c1mr14562863pzk.16.1689644696852;
        Mon, 17 Jul 2023 18:44:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGxAju5T1UCwQF5/cupW+zXgFeNUcZ+pCUS/8FwaxHZi+FOWZyjLBc5TWNGr2M+mKKpCLUi4Q==
X-Received: by 2002:a05:6a20:5498:b0:133:6c35:99c1 with SMTP id i24-20020a056a20549800b001336c3599c1mr14562854pzk.16.1689644696521;
        Mon, 17 Jul 2023 18:44:56 -0700 (PDT)
Received: from [10.72.12.44] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jl2-20020a170903134200b001b51b3e84cesm506236plb.166.2023.07.17.18.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 18:44:56 -0700 (PDT)
Message-ID: <8121882a-0823-3a60-e108-0ff7bae5c0c9@redhat.com>
Date:   Tue, 18 Jul 2023 09:44:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        Christian Brauner <brauner@kernel.org>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com>
 <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner>
 <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com>
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
Content-Language: en-US
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAEivzxcskn8WxcOo0PDHMascFRdYTD0Lr5Uo4fj3deBjDviOXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/14/23 20:57, Aleksandr Mikhalitsyn wrote:
> On Tue, Jul 4, 2023 at 3:09 AM Xiubo Li <xiubli@redhat.com> wrote:
>> Sorry, not sure, why my last reply wasn't sent out.
>>
>> Do it again.
>>
>>
>> On 6/26/23 19:23, Aleksandr Mikhalitsyn wrote:
>>> On Mon, Jun 26, 2023 at 4:12 AM Xiubo Li<xiubli@redhat.com>  wrote:
>>>> On 6/24/23 15:11, Aleksandr Mikhalitsyn wrote:
>>>>> On Sat, Jun 24, 2023 at 3:37 AM Xiubo Li<xiubli@redhat.com>  wrote:
>>>>>> [...]
>>>>>>
>>>>>>     > > >
>>>>>>     > > > I thought about this too and came to the same conclusion, that
>>>>>> UID/GID
>>>>>>     > > > based
>>>>>>     > > > restriction can be applied dynamically, so detecting it on mount-time
>>>>>>     > > > helps not so much.
>>>>>>     > > >
>>>>>>     > > For this you please raise one PR to ceph first to support this, and in
>>>>>>     > > the PR we can discuss more for the MDS auth caps. And after the PR
>>>>>>     > > getting merged then in this patch series you need to check the
>>>>>>     > > corresponding option or flag to determine whether could the idmap
>>>>>>     > > mounting succeed.
>>>>>>     >
>>>>>>     > I'm sorry but I don't understand what we want to support here. Do we
>>>>>> want to
>>>>>>     > add some new ceph request that allows to check if UID/GID-based
>>>>>>     > permissions are applied for
>>>>>>     > a particular ceph client user?
>>>>>>
>>>>>> IMO we should prevent user to set UID/GID-based permisions caps from
>>>>>> ceph side.
>>>>>>
>>>>>> As I know currently there is no way to prevent users to set MDS auth
>>>>>> caps, IMO in ceph side at least we need one flag or option to disable
>>>>>> this once users want this fs cluster sever for idmap mounts use case.
>>>>> How this should be visible from the user side? We introducing a new
>>>>> kernel client mount option,
>>>>> like "nomdscaps", then pass flag to the MDS and MDS should check that
>>>>> MDS auth permissions
>>>>> are not applied (on the mount time) and prevent them from being
>>>>> applied later while session is active. Like that?
>>>>>
>>>>> At the same time I'm thinking about protocol extension that adds 2
>>>>> additional fields for UID/GID. This will allow to correctly
>>>>> handle everything. I wanted to avoid any changes to the protocol or
>>>>> server-side things. But if we want to change MDS side,
>>>>> maybe it's better then to go this way?
>>> Hi Xiubo,
>>>
>>>> There is another way:
>>>>
>>>> For each client it will have a dedicated client auth caps, something like:
>>>>
>>>> client.foo
>>>>      key: *key*
>>>>      caps: [mds] allow r, allow rw path=/bar
>>>>      caps: [mon] allow r
>>>>      caps: [osd] allow rw tag cephfs data=cephfs_a
>>> Do we have any infrastructure to get this caps list on the client side
>>> right now?
>>> (I've taken a quick look through the code and can't find anything
>>> related to this.)
>> I am afraid there is no.
>>
>> But just after the following ceph PR gets merged it will be easy to do this:
>>
>> https://github.com/ceph/ceph/pull/48027
>>
>> This is still under testing.
>>
>>>> When mounting this client with idmap enabled, then we can just check the
>>>> above [mds] caps, if there has any UID/GID based permissions set, then
>>>> fail the mounting.
>>> understood
>>>
>>>> That means this kind client couldn't be mounted with idmap enabled.
>>>>
>>>> Also we need to make sure that once there is a mount with idmap enabled,
>>>> the corresponding client caps couldn't be append the UID/GID based
>>>> permissions. This need a patch in ceph anyway IMO.
>>> So, yeah we will need to effectively block cephx permission changes if
>>> there is a client mounted with
>>> an active idmapped mount. Sounds as something that require massive
>>> changes on the server side.
>> Maybe no need much, it should be simple IMO. But I am not 100% sure.
>>
>>> At the same time this will just block users from using idmapped mounts
>>> along with UID/GID restrictions.
>>>
>>> If you want me to change server-side anyways, isn't it better just to
>>> extend cephfs protocol to properly
>>> handle UID/GIDs with idmapped mounts? (It was originally proposed by Christian.)
>>> What we need to do here is to add a separate UID/GID fields for ceph
>>> requests those are creating a new inodes
>>> (like mknod, symlink, etc).
> Dear Xiubo,
>
> I'm sorry for delay with reply, I've missed this message accidentally.
>
>> BTW, could you explain it more ? How could this resolve the issue we are
>> discussing here ?
> This was briefly mentioned here
> https://lore.kernel.org/all/20220105141023.vrrbfhti5apdvkz7@wittgenstein/#t
> by Christian. Let me describe it in detail.
>
> In the current approach we apply mount idmapping to
> head->caller_{uid,gid} fields
> to make mkdir/mknod/symlink operations set a proper inode owner
> uid/gid in according with an idmapping.

Sorry for late.

I still couldn't get how this could resolve the lookup case.

For a lookup request the caller_{uid, gid} still will be the mapped 
{uid, gid}, right ? And also the same for other non-create requests. If 
so this will be incorrect for the cephx perm checks IMO.

Thanks

- Xiubo


> This makes a problem with path-based UID/GID restriction mechanism,
> because it uses head->caller_{uid,gid} fields
> to check if UID/GID is permitted or not.
>
> So, the problem is that we have one field in ceph request for two
> different needs - to control permissions and to set inode owner.
> Christian pointed that the most saner way is to modify ceph protocol
> and add a separate field to store inode owner UID/GID,
> and only this fields should be idmapped, but head->caller_{uid,gid}
> will be untouched.
>
> With this approach, we will not affect UID/GID-based permission rules
> with an idmapped mounts at all.
>
> Kind regards,
> Alex
>
>> Thanks
>>
>> - Xiubo
>>
>>
>>> Kind regards,
>>> Alex
>>>
>>>> Thanks
>>>>
>>>> - Xiubo
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>> Thanks,
>>>>> Alex
>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> - Xiubo
>>>>>>

