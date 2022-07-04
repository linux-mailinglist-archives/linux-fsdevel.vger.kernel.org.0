Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E87F564BD5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 04:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiGDCkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 22:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiGDCko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79449D85
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Jul 2022 19:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656902441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ICsT2ARw4a+JolXjcr8B3H69Dp/Dpn/qLY7Zn9Do1Ck=;
        b=i8ZQJlMCHDw1WLOjN/QRiXNdMVi0eiOXHDqf4xEvpArtAuPBSrJVdcV0xNeU4MqsEPTK6c
        NI/yDSw+uXqFjrosocTu/zV+ejceKH/bgYvdqY66mkfffs3Q/VjPRW6ljsySUpbOXg3Zwu
        +j0Aq5zKykyp/DilrpafSAv03gpFJdQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-emd0pZWnMrSDUQ5oGWJNEA-1; Sun, 03 Jul 2022 22:40:40 -0400
X-MC-Unique: emd0pZWnMrSDUQ5oGWJNEA-1
Received: by mail-pl1-f198.google.com with SMTP id k11-20020a170902c40b00b0016bac120046so4369716plk.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Jul 2022 19:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ICsT2ARw4a+JolXjcr8B3H69Dp/Dpn/qLY7Zn9Do1Ck=;
        b=6vqblUKH5Z/xSUxSOFS54ehGUcI1qqwGDsnMTv/yVTdZ0193miLZ9jCAUZ9CbFEzWk
         zuNvS6OAmHHxcMh8deDDxd5NKW2+9cK/hkWJtgmru2iJqbW4voYVxhY9umjq7AKMumNV
         mFBuxcXVqE9U38RASwKQy5Y7lDg7E1Ur/cItTnrMCT5jzZTm5J/DiU8/DImfPHgJC51n
         wyw1oJBQjGj4jDq5c5ASJzb8Qd4AiI8JfhJIjw75dmBKupEqPUtjcWMx4PI4aIM6Dkt1
         NlIqoWScTzMSN/NArv6L5oyTWphKbqXqFi/2g73kPYXsfuGibqN9+1FZWexemc0+b9SG
         BuOw==
X-Gm-Message-State: AJIora+V8TIZuxo6uGivf5Vf/kSPuCxiicW9IzsggcoDv3yzSMQaPjYW
        l6BDZkh9IaDdys0TYshw5np9WMo4wVkwGKzTkEf6xns9gUQzSaL4DEE79ffB2HSzIERqww+/2yk
        PSDIe+ueUjhKlml3OWee5xvudQw==
X-Received: by 2002:a63:f413:0:b0:40d:ba87:53f8 with SMTP id g19-20020a63f413000000b0040dba8753f8mr23612246pgi.193.1656902439240;
        Sun, 03 Jul 2022 19:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t6rQkQeAwxUPjvO4+/sON3E+ea4EU41n3iq0miNQNN+iS3edOR6v+wqUvMCSwrHEf4YPlg2g==
X-Received: by 2002:a63:f413:0:b0:40d:ba87:53f8 with SMTP id g19-20020a63f413000000b0040dba8753f8mr23612229pgi.193.1656902438974;
        Sun, 03 Jul 2022 19:40:38 -0700 (PDT)
Received: from [10.72.12.186] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id lx13-20020a17090b4b0d00b001df264610c4sm13631393pjb.0.2022.07.03.19.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 19:40:38 -0700 (PDT)
Subject: Re: [PATCH 1/2] netfs: release the folio lock and put the folio
 before retrying
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com,
        dhowells@redhat.com, vshankar@redhat.com,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com
References: <20220701022947.10716-1-xiubli@redhat.com>
 <20220701022947.10716-2-xiubli@redhat.com>
 <30a4bd0e19626f5fb30f19f0ae70fba2debb361a.camel@kernel.org>
 <f55d10f8-55f6-f56c-bb41-bce139869c8d@redhat.com>
 <YsJMCZB/ecQQha+/@casper.infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <5f9c75f0-d0ae-a9ff-df1b-40dd164d74ca@redhat.com>
Date:   Mon, 4 Jul 2022 10:40:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YsJMCZB/ecQQha+/@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/4/22 10:10 AM, Matthew Wilcox wrote:
> On Mon, Jul 04, 2022 at 09:13:44AM +0800, Xiubo Li wrote:
>> On 7/1/22 6:38 PM, Jeff Layton wrote:
>>> I don't know here... I think it might be better to just expect that when
>>> this function returns an error that the folio has already been unlocked.
>>> Doing it this way will mean that you will lock and unlock the folio a
>>> second time for no reason.
>>>
>>> Maybe something like this instead?
>>>
>>> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
>>> index 42f892c5712e..8ae7b0f4c909 100644
>>> --- a/fs/netfs/buffered_read.c
>>> +++ b/fs/netfs/buffered_read.c
>>> @@ -353,7 +353,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
>>>                           trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
>>>                           if (ret == -EAGAIN)
>>>                                   goto retry;
>>> -                       goto error;
>>> +                       goto error_unlocked;
>>>                   }
>>>           }
>>> @@ -418,6 +418,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
>>>    error:
>>>           folio_unlock(folio);
>>>           folio_put(folio);
>>> +error_unlocked:
>>>           _leave(" = %d", ret);
>>>           return ret;
>>>    }
>> Then the "afs" won't work correctly:
>>
>> 377 static int afs_check_write_begin(struct file *file, loff_t pos, unsigned
>> len,
>> 378                                  struct folio *folio, void **_fsdata)
>> 379 {
>> 380         struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
>> 381
>> 382         return test_bit(AFS_VNODE_DELETED, &vnode->flags) ? -ESTALE : 0;
>> 383 }
>>
>> The "afs" does nothing with the folio lock.
> It's OK to fix AFS too.
>
Okay, will fix it. Thanks!

-- Xiubo


