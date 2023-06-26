Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA77473D5BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 04:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjFZCNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 22:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFZCNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:13:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A27C12B
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jun 2023 19:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687745568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvHSlfKX+Q9EnaTb8YY7loKKccihuP0tvgv06rmGdeo=;
        b=BKCMv65qYFzMcgrQ7yiOHrb9PW1RqBaLlkSWw72n/NBh7VOZxs+l1TQFw8sAd3QSQMJE1P
        mxvzECoraOUUqmchv9w5YVq12ZpNG36tqR4cqb5/MP6SuJClhwrXV+uwOxQBU9XKRW6wnz
        QlLlBTVg8iKjblR3MUaQ6Yj/qO0JatQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-5co-B6czMe2ElH8O02h6kw-1; Sun, 25 Jun 2023 22:12:46 -0400
X-MC-Unique: 5co-B6czMe2ElH8O02h6kw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-53fa00ed93dso2325700a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jun 2023 19:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687745565; x=1690337565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvHSlfKX+Q9EnaTb8YY7loKKccihuP0tvgv06rmGdeo=;
        b=I4BqEM8J40El7E9Ifja1kw4x13M6WNU0buTIFGqJ+wTfETDfc/C7Zi1wRSEkPr0Uas
         NPNRjropyhbvpx7wwZzxWPC1jRjrg24xwLcSYv3zkQQ4IDmqNXHAI4x3AqVnY7p4BBJP
         tDf/mJhGM/uy27JUR2GXlwHs4d+Eur0mXWucNKJztwr1NiLeCqAv8ea+VQ0QL5Bp7uZ7
         vwCKmFOunuH6QqUGiB4nlwluB7am5GKteIrWbHoC83Rf4wFLTMICNllQq0TbtP3ePqg4
         cCKzdUbX2t3+D4L4d9u+IuIooZfeKZpFJnVuCpR80mWEC7536XxdYHITH200jXFXvMsq
         JUJg==
X-Gm-Message-State: AC+VfDzyMczlYS5KFgSFDGvbIPj4/I1e/h1Ufe7+k38G5K0lvV7RcD/c
        xsuwUmKEB66Zkmx0iC2effK/m34r5AHSYW05eouGPbQX+j3vjfoSPbSymOpAs8hnV2IDlF6TlQN
        W5qrCxKbF9GRrvl1OcA9SmeX+Qg==
X-Received: by 2002:a05:6a20:3ca7:b0:121:bc20:f6c7 with SMTP id b39-20020a056a203ca700b00121bc20f6c7mr25834128pzj.19.1687745565660;
        Sun, 25 Jun 2023 19:12:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wcxGfN53h6dsr+wWOqZCl9CvqOw4NFsJ+DqE7HyvLS/BSMZ1rPtwqWZ9jfbJ0NMOOH8eQQQ==
X-Received: by 2002:a05:6a20:3ca7:b0:121:bc20:f6c7 with SMTP id b39-20020a056a203ca700b00121bc20f6c7mr25834115pzj.19.1687745565360;
        Sun, 25 Jun 2023 19:12:45 -0700 (PDT)
Received: from [10.72.13.91] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q10-20020a65684a000000b0053f06d09725sm2647645pgt.32.2023.06.25.19.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 19:12:44 -0700 (PDT)
Message-ID: <4c4f73d8-8238-6ab8-ae50-d83c1441ac05@redhat.com>
Date:   Mon, 26 Jun 2023 10:12:39 +0800
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
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAEivzxeF51ZEKhQ-0M35nooZ7_cZgk1-q75-YbkeWpZ9RuHG4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/24/23 15:11, Aleksandr Mikhalitsyn wrote:
> On Sat, Jun 24, 2023 at 3:37 AM Xiubo Li <xiubli@redhat.com> wrote:
>> [...]
>>
>>   > > >
>>   > > > I thought about this too and came to the same conclusion, that
>> UID/GID
>>   > > > based
>>   > > > restriction can be applied dynamically, so detecting it on mount-time
>>   > > > helps not so much.
>>   > > >
>>   > > For this you please raise one PR to ceph first to support this, and in
>>   > > the PR we can discuss more for the MDS auth caps. And after the PR
>>   > > getting merged then in this patch series you need to check the
>>   > > corresponding option or flag to determine whether could the idmap
>>   > > mounting succeed.
>>   >
>>   > I'm sorry but I don't understand what we want to support here. Do we
>> want to
>>   > add some new ceph request that allows to check if UID/GID-based
>>   > permissions are applied for
>>   > a particular ceph client user?
>>
>> IMO we should prevent user to set UID/GID-based permisions caps from
>> ceph side.
>>
>> As I know currently there is no way to prevent users to set MDS auth
>> caps, IMO in ceph side at least we need one flag or option to disable
>> this once users want this fs cluster sever for idmap mounts use case.
> How this should be visible from the user side? We introducing a new
> kernel client mount option,
> like "nomdscaps", then pass flag to the MDS and MDS should check that
> MDS auth permissions
> are not applied (on the mount time) and prevent them from being
> applied later while session is active. Like that?
>
> At the same time I'm thinking about protocol extension that adds 2
> additional fields for UID/GID. This will allow to correctly
> handle everything. I wanted to avoid any changes to the protocol or
> server-side things. But if we want to change MDS side,
> maybe it's better then to go this way?

There is another way:

For each client it will have a dedicated client auth caps, something like:

client.foo
   key: *key*
   caps: [mds] allow r, allow rw path=/bar
   caps: [mon] allow r
   caps: [osd] allow rw tag cephfs data=cephfs_a

When mounting this client with idmap enabled, then we can just check the 
above [mds] caps, if there has any UID/GID based permissions set, then 
fail the mounting.

That means this kind client couldn't be mounted with idmap enabled.

Also we need to make sure that once there is a mount with idmap enabled, 
the corresponding client caps couldn't be append the UID/GID based 
permissions. This need a patch in ceph anyway IMO.

Thanks

- Xiubo





>
> Thanks,
> Alex
>
>> Thanks
>>
>> - Xiubo
>>

