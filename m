Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C867984D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 11:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbjIHJaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 05:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIHJag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279E11B
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 02:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694165388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L5feGZu7QwBh6YZCnrue6kLvl8ArVHGYdhPOxNSWMIg=;
        b=J8cdDZWl47SKUGoI7szoJsWNXfrgS7KavTI8An2C0f9nu/EuHBhUsPzhdjOYb60HEfy0IE
        GlOeacEfltrKI6bo2ZeNZ11m5IOM5jV2I+cKj10LPkmD/G2wsLC6qHMrQYwtdrbH6G+JaF
        zeToETVz+SZxbpYOLg9umRYK6v3TEI4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-V02aFcf2Os6XC-7Lpnxg4Q-1; Fri, 08 Sep 2023 05:29:45 -0400
X-MC-Unique: V02aFcf2Os6XC-7Lpnxg4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 789DE3C025B5;
        Fri,  8 Sep 2023 09:29:44 +0000 (UTC)
Received: from [10.43.17.103] (unknown [10.43.17.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90AA92026D76;
        Fri,  8 Sep 2023 09:29:42 +0000 (UTC)
Message-ID: <86235d7a-a7ea-49da-968e-c5810cbf4a7b@redhat.com>
Date:   Fri, 8 Sep 2023 11:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix writing to the filesystem after unmount
To:     Jan Kara <jack@suse.cz>, Mikulas Patocka <mpatocka@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com>
 <20230906-launenhaft-kinder-118ea59706c8@brauner>
 <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
 <20230906-aufheben-hagel-9925501b7822@brauner>
 <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
 <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
 <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
 <20230907094457.vcvmixi23dk3pzqe@quack3>
 <20230907-abgrenzen-achtung-b17e9a1ad136@brauner>
 <513f337e-d254-2454-6197-82df564ed5fc@redhat.com>
 <20230908073244.wyriwwxahd3im2rw@quack3>
Content-Language: en-US, cs
From:   Zdenek Kabelac <zkabelac@redhat.com>
In-Reply-To: <20230908073244.wyriwwxahd3im2rw@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dne 08. 09. 23 v 9:32 Jan Kara napsal(a):
> On Thu 07-09-23 14:04:51, Mikulas Patocka wrote:
>>
>> On Thu, 7 Sep 2023, Christian Brauner wrote:
>>
>>>> I think we've got too deep down into "how to fix things" but I'm not 100%
>>> We did.
>>>
>>>> sure what the "bug" actually is. In the initial posting Mikulas writes "the
>>>> kernel writes to the filesystem after unmount successfully returned" - is
>>>> that really such a big issue?
>> I think it's an issue if the administrator writes a script that unmounts a
>> filesystem and then copies the underyling block device somewhere. Or a
>> script that unmounts a filesystem and runs fsck afterwards. Or a script
>> that unmounts a filesystem and runs mkfs on the same block device.
> Well, e.g. e2fsprogs use O_EXCL open so they will detect that the filesystem
> hasn't been unmounted properly and complain. Which is exactly what should
> IMHO happen.
>
>>>> Anybody else can open the device and write to it as well. Or even
>>>> mount the device again. So userspace that relies on this is kind of
>>>> flaky anyway (and always has been).
>> It's admin's responsibility to make sure that the filesystem is not
>> mounted multiple times when he touches the underlying block device after
>> unmount.
> What I wanted to suggest is that we should provide means how to make sure
> block device is not being modified and educate admins and tool authors
> about them. Because just doing "umount /dev/sda1" and thinking this means
> that /dev/sda1 is unused now simply is not enough in today's world for
> multiple reasons and we cannot solve it just in the kernel.
>

Hi


/me just wondering how do you then imagine i.e. safe removal of USB drive when 
user shall not expect unmount really unmounts filesystem?

IMHO  - unmount should detect some very suspicious state of block device if it 
cannot correctly proceed - i.e. reporting 'warning/error' on such commands...

Main problem is - if the 'unmount' is successful in this case - the last 
connection userspace had to this fileystem is lost - and user cannot get rid 
of such filesystem anymore for a system.

I'd likely propose in this particular state of unmounting of a frozen 
filesystem to just proceed - and drop the frozen state together with release 
filesystem and never issue any ioctl from such filelsystem to the device below 
- so it would not be a 100% valid unmount - but since the freeze should be 
nearly equivalent of having a proper 'unmount' being done -  it shoudn't be 
causing any harm either - and  all resources associated could  be 
'released.    IMHO it's correct to 'drop' frozen state for filesystem that is 
not going to exist anymore  (assuming it's the last  such user)

Regards


Zdenek


