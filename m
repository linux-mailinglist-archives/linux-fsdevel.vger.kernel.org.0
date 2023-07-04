Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DACB7466C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 03:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjGDBJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 21:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGDBJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A40186
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 18:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688432942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXCms+65LqYKrmZBhhf/y9w2Ow+x0tGEGBk7yYwG+Bc=;
        b=BP+vM54At6m7wRiZPLnwC0uiL/y65a94Al32Injz7Py6Nskx6l0DAJBljefga3CJh8NoAK
        KleDb8CGnXnXHf5xkEXfFLyFaq2cDdnYqcWBN0OzunaZLmOjEzoXEeWEpYXOKuNbXTQa39
        /C/csR/E1hGxptpbKi9zWLcFp8xRanE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-QRTtYSplPvKWRYTfNFDCwA-1; Mon, 03 Jul 2023 21:09:01 -0400
X-MC-Unique: QRTtYSplPvKWRYTfNFDCwA-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1b806d07935so51969205ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jul 2023 18:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688432940; x=1691024940;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXCms+65LqYKrmZBhhf/y9w2Ow+x0tGEGBk7yYwG+Bc=;
        b=M2PVMfTs5UhWUk80XsUCm8glzaB+/x6XTrkAlZl/cNu8ySB+7XLQaA7N8bEF9XAqog
         B2Y4eDx+tHHMJpKBdFCrlwjkDh28g347EeJNZi3HzAwCuoGLoxMH99kyShr6hJV42G4k
         +d+QYTCshjUOC3mw/ObuTsrIjR+s2gIPGotjMqJKQTE/EpkNZv6VdD/Bh52oyKt7Lq5n
         N69KkcrB9CDhTmr+WWgYY+a0okFHEJ+6KMgNYJ7/iVouOhze7DLNRfpwQrRobyCgZoIL
         dW8UojXpyhseJQXpYyqCPUvbdS+QxcSo/FxyN9w7lWAOGpLP/M4oMN0qGabgfvFtZABP
         DgXg==
X-Gm-Message-State: ABy/qLbVp4WUxzkswtxesfAq5oX+iW1eT/cEPH1jRxqUG/M5OUdJaPQ4
        uPoNmqGbkfKrkAyuPnaHOSfSVJ1vU3m3+DAlUeizWSO6Iq1iChSe48xkEnE4Gno4NgCQdpiiquq
        GCpJlSpCWrigaB/3hEF03tcVeMw==
X-Received: by 2002:a17:902:ab81:b0:1b8:21f:bcc2 with SMTP id f1-20020a170902ab8100b001b8021fbcc2mr8285844plr.34.1688432940154;
        Mon, 03 Jul 2023 18:09:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF8J/qamT+QxSmLqt2/HMj0wZqnpxCzoME3hFQuIzuCGLQWUFGxKr2LCAZv7luGDotwZXtVWQ==
X-Received: by 2002:a17:902:ab81:b0:1b8:21f:bcc2 with SMTP id f1-20020a170902ab8100b001b8021fbcc2mr8285835plr.34.1688432939786;
        Mon, 03 Jul 2023 18:08:59 -0700 (PDT)
Received: from [10.72.12.93] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902d70100b001b523714ed5sm15873685ply.252.2023.07.03.18.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 18:08:59 -0700 (PDT)
Message-ID: <0a42c5d0-0479-e60e-ac84-be3b915c62d9@redhat.com>
Date:   Tue, 4 Jul 2023 09:08:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Xiubo Li <xiubli@redhat.com>
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
Content-Language: en-US
In-Reply-To: <CAEivzxeQGkemxVwJ148b_+OmntUAWkdL==yMiTMN+GPyaLkFPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry, not sure, why my last reply wasn't sent out.

Do it again.


On 6/26/23 19:23, Aleksandr Mikhalitsyn wrote:
> On Mon, Jun 26, 2023 at 4:12 AM Xiubo Li<xiubli@redhat.com>  wrote:
>> On 6/24/23 15:11, Aleksandr Mikhalitsyn wrote:
>>> On Sat, Jun 24, 2023 at 3:37 AM Xiubo Li<xiubli@redhat.com>  wrote:
>>>> [...]
>>>>
>>>>    > > >
>>>>    > > > I thought about this too and came to the same conclusion, that
>>>> UID/GID
>>>>    > > > based
>>>>    > > > restriction can be applied dynamically, so detecting it on mount-time
>>>>    > > > helps not so much.
>>>>    > > >
>>>>    > > For this you please raise one PR to ceph first to support this, and in
>>>>    > > the PR we can discuss more for the MDS auth caps. And after the PR
>>>>    > > getting merged then in this patch series you need to check the
>>>>    > > corresponding option or flag to determine whether could the idmap
>>>>    > > mounting succeed.
>>>>    >
>>>>    > I'm sorry but I don't understand what we want to support here. Do we
>>>> want to
>>>>    > add some new ceph request that allows to check if UID/GID-based
>>>>    > permissions are applied for
>>>>    > a particular ceph client user?
>>>>
>>>> IMO we should prevent user to set UID/GID-based permisions caps from
>>>> ceph side.
>>>>
>>>> As I know currently there is no way to prevent users to set MDS auth
>>>> caps, IMO in ceph side at least we need one flag or option to disable
>>>> this once users want this fs cluster sever for idmap mounts use case.
>>> How this should be visible from the user side? We introducing a new
>>> kernel client mount option,
>>> like "nomdscaps", then pass flag to the MDS and MDS should check that
>>> MDS auth permissions
>>> are not applied (on the mount time) and prevent them from being
>>> applied later while session is active. Like that?
>>>
>>> At the same time I'm thinking about protocol extension that adds 2
>>> additional fields for UID/GID. This will allow to correctly
>>> handle everything. I wanted to avoid any changes to the protocol or
>>> server-side things. But if we want to change MDS side,
>>> maybe it's better then to go this way?
> Hi Xiubo,
>
>> There is another way:
>>
>> For each client it will have a dedicated client auth caps, something like:
>>
>> client.foo
>>     key: *key*
>>     caps: [mds] allow r, allow rw path=/bar
>>     caps: [mon] allow r
>>     caps: [osd] allow rw tag cephfs data=cephfs_a
> Do we have any infrastructure to get this caps list on the client side
> right now?
> (I've taken a quick look through the code and can't find anything
> related to this.)

I am afraid there is no.

But just after the following ceph PR gets merged it will be easy to do this:

https://github.com/ceph/ceph/pull/48027

This is still under testing.

>> When mounting this client with idmap enabled, then we can just check the
>> above [mds] caps, if there has any UID/GID based permissions set, then
>> fail the mounting.
> understood
>
>> That means this kind client couldn't be mounted with idmap enabled.
>>
>> Also we need to make sure that once there is a mount with idmap enabled,
>> the corresponding client caps couldn't be append the UID/GID based
>> permissions. This need a patch in ceph anyway IMO.
> So, yeah we will need to effectively block cephx permission changes if
> there is a client mounted with
> an active idmapped mount. Sounds as something that require massive
> changes on the server side.

Maybe no need much, it should be simple IMO. But I am not 100% sure.

> At the same time this will just block users from using idmapped mounts
> along with UID/GID restrictions.
>
> If you want me to change server-side anyways, isn't it better just to
> extend cephfs protocol to properly
> handle UID/GIDs with idmapped mounts? (It was originally proposed by Christian.)
> What we need to do here is to add a separate UID/GID fields for ceph
> requests those are creating a new inodes
> (like mknod, symlink, etc).

BTW, could you explain it more ? How could this resolve the issue we are 
discussing here ?

Thanks

- Xiubo


>
> Kind regards,
> Alex
>
>> Thanks
>>
>> - Xiubo
>>
>>
>>
>>
>>
>>> Thanks,
>>> Alex
>>>
>>>> Thanks
>>>>
>>>> - Xiubo
>>>>

