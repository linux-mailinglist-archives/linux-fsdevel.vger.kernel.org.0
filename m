Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD387466CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 03:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGDBL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 21:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGDBLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFAF186
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 18:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688433031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tHvy2cSjRNLBspkBnwHleNI4FVF/3lOoEAeskedvTOg=;
        b=gdHPE5FnleVeZWLtkmi5L27vCDz3/KIFLkNbiTGq2raLWeJcEuRWHgalEnTLqgVfBOzGAW
        VYdHYZHkdk477SmKTkg/Gf6jq50+3ZcHsFbNPiawpExcaT1Zn2oWtrxTe9hqQBUe0MrhGI
        nUX+fwEUaLjLjhnC8be6/V/mfEPij80=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-ZBkKLuy0P1y9-ngGCKkIbg-1; Mon, 03 Jul 2023 21:10:30 -0400
X-MC-Unique: ZBkKLuy0P1y9-ngGCKkIbg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b890e2b99dso20492995ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jul 2023 18:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688433030; x=1691025030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHvy2cSjRNLBspkBnwHleNI4FVF/3lOoEAeskedvTOg=;
        b=TkGWK3c+yd32eSE39p18XSXqzIofmpzVMUF6OdyVfI1RzKETAKkxKFnzq9fc0WxmvR
         n95kbE95p7SsnEJpJMmIYSMGwxdg6ZuqM8u8JPGL+J9zbeQEJqp4AHWqNfl85ppozJnp
         2YXETMnphFYHahAH8yx/eB7Iu1Jt1gevEDAl2huo62hO3C6hGYfMSjebBTsPxc6Y2ApS
         j0GKTlQtix4VyOwnRjIIgA9K0Q0jUYX6mufFg5/JIc1E/uCmDDA9gomna9Xg6xpwCqSW
         hQbb5t1lxkogbgtKC3OC4FGH8ojczwXBAVGwSFZfnLaY0+eqHQIEARQk1VDY8wvnLfG2
         Dbyw==
X-Gm-Message-State: ABy/qLYtO5LTAn+w1kuimwVspFpQPP8CLPUf7ldN4fH7cxxCT5Mjez0E
        PpUCpWjN5p2e7frfO5LavuyHJWmeyYnzEpeQL0RGaqyaMagaKT4+CtVJ1pmDT1oFjH80Vvz6Skc
        96bpldiQc3Qvhuk1K1gwMiBtcHA==
X-Received: by 2002:a17:902:e80c:b0:1b4:5697:d9a8 with SMTP id u12-20020a170902e80c00b001b45697d9a8mr11428309plg.24.1688433029778;
        Mon, 03 Jul 2023 18:10:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEkUcs+Igdu1cGCcdWMRT4RWhJygrdqtCuKld769XYQogZn8ImhvI35kbP5T5WjvG7mZV0IdQ==
X-Received: by 2002:a17:902:e80c:b0:1b4:5697:d9a8 with SMTP id u12-20020a170902e80c00b001b45697d9a8mr11428293plg.24.1688433029436;
        Mon, 03 Jul 2023 18:10:29 -0700 (PDT)
Received: from [10.72.12.93] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902a51200b001b7fb1a8200sm14137286plq.258.2023.07.03.18.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 18:10:29 -0700 (PDT)
Message-ID: <f885fddd-d511-0e31-cafe-b766144e6207@redhat.com>
Date:   Tue, 4 Jul 2023 09:10:22 +0800
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
 <CAEivzxeBNOeufOraU27Y+qVApVjAoLhzwPnw0HSkqSt6P3MV9w@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAEivzxeBNOeufOraU27Y+qVApVjAoLhzwPnw0HSkqSt6P3MV9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/26/23 19:49, Aleksandr Mikhalitsyn wrote:
> On Mon, Jun 26, 2023 at 1:23 PM Aleksandr Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
>> On Mon, Jun 26, 2023 at 4:12 AM Xiubo Li <xiubli@redhat.com> wrote:
>>>
>>> On 6/24/23 15:11, Aleksandr Mikhalitsyn wrote:
>>>> On Sat, Jun 24, 2023 at 3:37 AM Xiubo Li <xiubli@redhat.com> wrote:
>>>>> [...]
>>>>>
>>>>>    > > >
>>>>>    > > > I thought about this too and came to the same conclusion, that
>>>>> UID/GID
>>>>>    > > > based
>>>>>    > > > restriction can be applied dynamically, so detecting it on mount-time
>>>>>    > > > helps not so much.
>>>>>    > > >
>>>>>    > > For this you please raise one PR to ceph first to support this, and in
>>>>>    > > the PR we can discuss more for the MDS auth caps. And after the PR
>>>>>    > > getting merged then in this patch series you need to check the
>>>>>    > > corresponding option or flag to determine whether could the idmap
>>>>>    > > mounting succeed.
>>>>>    >
>>>>>    > I'm sorry but I don't understand what we want to support here. Do we
>>>>> want to
>>>>>    > add some new ceph request that allows to check if UID/GID-based
>>>>>    > permissions are applied for
>>>>>    > a particular ceph client user?
>>>>>
>>>>> IMO we should prevent user to set UID/GID-based permisions caps from
>>>>> ceph side.
>>>>>
>>>>> As I know currently there is no way to prevent users to set MDS auth
>>>>> caps, IMO in ceph side at least we need one flag or option to disable
>>>>> this once users want this fs cluster sever for idmap mounts use case.
>>>> How this should be visible from the user side? We introducing a new
>>>> kernel client mount option,
>>>> like "nomdscaps", then pass flag to the MDS and MDS should check that
>>>> MDS auth permissions
>>>> are not applied (on the mount time) and prevent them from being
>>>> applied later while session is active. Like that?
>>>>
>>>> At the same time I'm thinking about protocol extension that adds 2
>>>> additional fields for UID/GID. This will allow to correctly
>>>> handle everything. I wanted to avoid any changes to the protocol or
>>>> server-side things. But if we want to change MDS side,
>>>> maybe it's better then to go this way?
>> Hi Xiubo,
>>
>>> There is another way:
>>>
>>> For each client it will have a dedicated client auth caps, something like:
>>>
>>> client.foo
>>>     key: *key*
>>>     caps: [mds] allow r, allow rw path=/bar
>>>     caps: [mon] allow r
>>>     caps: [osd] allow rw tag cephfs data=cephfs_a
>> Do we have any infrastructure to get this caps list on the client side
>> right now?
>> (I've taken a quick look through the code and can't find anything
>> related to this.)
> I've found your PR that looks related https://github.com/ceph/ceph/pull/48027

Yeah, after this we need to do some extra work in kclient and then it 
will be easy to check the caps I think.

Thanks

- Xiubo

>>> When mounting this client with idmap enabled, then we can just check the
>>> above [mds] caps, if there has any UID/GID based permissions set, then
>>> fail the mounting.
>> understood
>>
>>> That means this kind client couldn't be mounted with idmap enabled.
>>>
>>> Also we need to make sure that once there is a mount with idmap enabled,
>>> the corresponding client caps couldn't be append the UID/GID based
>>> permissions. This need a patch in ceph anyway IMO.
>> So, yeah we will need to effectively block cephx permission changes if
>> there is a client mounted with
>> an active idmapped mount. Sounds as something that require massive
>> changes on the server side.
>>
>> At the same time this will just block users from using idmapped mounts
>> along with UID/GID restrictions.
>>
>> If you want me to change server-side anyways, isn't it better just to
>> extend cephfs protocol to properly
>> handle UID/GIDs with idmapped mounts? (It was originally proposed by Christian.)
>> What we need to do here is to add a separate UID/GID fields for ceph
>> requests those are creating a new inodes
>> (like mknod, symlink, etc).
>>
>> Kind regards,
>> Alex
>>
>>> Thanks
>>>
>>> - Xiubo
>>>
>>>
>>>
>>>
>>>
>>>> Thanks,
>>>> Alex
>>>>
>>>>> Thanks
>>>>>
>>>>> - Xiubo
>>>>>

