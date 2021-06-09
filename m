Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109A93A16C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 16:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbhFIOPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 10:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbhFIOP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:15:29 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB75CC061574;
        Wed,  9 Jun 2021 07:13:20 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id t6so19161609iln.8;
        Wed, 09 Jun 2021 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WgDdFC9LyeqAZL05FbBDlv9/pXFqVQqUYkzAMloDy78=;
        b=bmiJS6cj4JL1iOK15/sSmWzkEXhfEioYMz+5x6EHpBI0kD4KICw4lgRJ8nuvmlxub1
         g9ikJOmtRNWMLZtyKcQpy+RClZGgFF3YaDpA2kW2+g9Y0KTpqj1GcUD1jJeOUlYTn6ti
         tyC2BVYicBGICAztfk/3PxzNnReCdMYo8kgIO5p7ldrOvYESWHaAO8aj3PAzgKgKlaze
         oRlPbc1vCaK31PPSaN28oshvIKSCBNF45C2jaYIk4rV4b24DnyQ5voxpcMz0uGENeD2r
         h/V/j/nuDnUfWFAhr3buO64qFUq+P2KlqWu06/nh4lgIAZMrINlNvziO4qwupnKtC5vk
         bfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WgDdFC9LyeqAZL05FbBDlv9/pXFqVQqUYkzAMloDy78=;
        b=QFeLTzz4C/9EzAqD1pHch0tVsf5lzE/Kcyn+bZRk5Lh+J+0ZjauVHJ7S5qnuI0vxgH
         2z3fK88wbPWcZh6kIGOLG59kn4JP7oJp2Tb7rwTbpP+vfnDxYLD1UANqFuNH5QPV+q9V
         YdXFKqjGyw42CHL1PrxnQLWiWN3aRY4HzCir/aC71DltAwPDCCsJFXkZO4YCSMatvrol
         xDZUl7+T31by20spHz8JT3WvZIkX+IwraJ1j9Hi2Wwv1auQP2iILkkBK4bIcOmm3D9vT
         meoWxj6JZ1f9RYWqGYz2QZUgpoI+xumIgPqoiL/3E1kh2jgHTkbZatVsdIzduwDO2h0s
         CK2w==
X-Gm-Message-State: AOAM531JC8+JwcjgS3MqsPlOEq8JSui+ROGkSaCx6WRSAwifHGnP+aE7
        ZVRSxq1lvPlsc9wuR4fsD+ZDfPfvi+qKUw==
X-Google-Smtp-Source: ABdhPJygIm1qZY9qywOvCoVDy60MwBi8acFKPNMwdHyUsU9jCmEFWiqXTDgS16SMWc7ntkDr584s1g==
X-Received: by 2002:a05:6e02:521:: with SMTP id h1mr6679880ils.295.1623248000363;
        Wed, 09 Jun 2021 07:13:20 -0700 (PDT)
Received: from ceo1homenx.1.quietfountain.com (173-29-47-53.client.mchsi.com. [173.29.47.53])
        by smtp.gmail.com with ESMTPSA id p18sm84514ilg.32.2021.06.09.07.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:13:19 -0700 (PDT)
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        virtio-fs@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
References: <20210608153524.GB504497@redhat.com>
 <YMCPPCbjbRoPAEcL@stefanha-x1.localdomain>
From:   "Harry G. Coin" <hgcoin@gmail.com>
Subject: Re: [Virtio-fs] [PATCH] init/do_mounts.c: Add root="fstag:<tag>"
 syntax for root device
Message-ID: <af0fc557-c90c-4343-ed0e-a3a94dc07137@gmail.com>
Date:   Wed, 9 Jun 2021 09:13:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMCPPCbjbRoPAEcL@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/9/21 4:51 AM, Stefan Hajnoczi wrote:
> On Tue, Jun 08, 2021 at 11:35:24AM -0400, Vivek Goyal wrote:
>> We want to be able to mount virtiofs as rootfs and pass appropriate
>> kernel command line. Right now there does not seem to be a good way
>> to do that. If I specify "root=3Dmyfs rootfstype=3Dvirtiofs", system
>> panics.
>>
>> virtio-fs: tag </dev/root> not found
>> ..
>> ..
>> [ end Kernel panic - not syncing: VFS: Unable to mount root fs on unkn=
own-block(0,0) ]
>>
>> Basic problem here is that kernel assumes that device identifier
>> passed in "root=3D" is a block device. But there are few execptions
>> to this rule to take care of the needs of mtd, ubi, NFS and CIFS.
>>
>> For example, mtd and ubi prefix "mtd:" or "ubi:" respectively.
>>
>> "root=3Dmtd:<identifier>" or "root=3Dubi:<identifier>"
>>
>> NFS and CIFS use "root=3D/dev/nfs" and CIFS passes "root=3D/dev/cifs" =
and
>> actual root device details come from filesystem specific kernel
>> command line options.
>>
>> virtiofs does not seem to fit in any of the above categories. In fact
>> we have 9pfs which can be used to boot from but it also does not
>> have a proper syntax to specify rootfs and does not fit into any of
>> the existing syntax. They both expect a device "tag" to be passed
>> in a device to be mounted. And filesystem knows how to parse and
>> use "tag".
>>
>> So this patch proposes that we add a new prefix "fstag:" which specifi=
es
>> that identifier which follows is filesystem specific tag and its not
>> a block device. Just pass this tag to filesystem and filesystem will
>> figure out how to mount it.
>>
>> For example, "root=3Dfstag:<tag>".
>>
>> In case of virtiofs, I can specify "root=3Dfstag:myfs rootfstype=3Dvir=
tiofs"
>> and it works.
>>
>> I think this should work for 9p as well. "root=3Dfstag:myfs rootfstype=
=3D9p".
>> Though I have yet to test it.
>>
>> This kind of syntax should be able to address wide variety of use case=
s
>> where root device is not a block device and is simply some kind of
>> tag/label understood by filesystem.
> "fstag" is kind of virtio-9p/fs specific. The intended effect is really=

> to specify the file system source (like in mount(2)) without it being
> interpreted as a block device.
>
> In a previous discussion David Gilbert suggested detecting file systems=

> that do not need a block device:
> https://patchwork.kernel.org/project/linux-fsdevel/patch/20190906100324=
=2E8492-1-stefanha@redhat.com/
>
> I never got around to doing it, but can do_mounts.c just look at struct=

> file_system_type::fs_flags FS_REQUIRES_DEV to detect non-block device
> file systems?
>
> That way it would know to just mount with root=3D as the source instead=
 of
> treating it as a block device. No root=3D prefix would be required and =
it
> would handle NFS, virtiofs, virtio-9p, etc without introducing the
> concept of a "tag".
>
>   root=3Dmyfs rootfstype=3Dvirtiofs rootflags=3D...
>
> I wrote this up quickly after not thinking about the topic for 2 years,=

> so the idea may not work at all :).

I plead for the long term goal of syntax harmony between the kernel
command line and the first three fields of /etc/fstab.

Let's do one thing one way, even if it is specified more than one place.

HC




