Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7A564B18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 03:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiGDBOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 21:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiGDBOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 438FB6377
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Jul 2022 18:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656897235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nv3kLqVRpORhA1eU8Voo6ss8wDxc+AM8OLmudfWCLYs=;
        b=g+on8ILU3TZ3NxYF+EXMjA7PV2V9D7+PHOY1eQDafgIx0VtV/oY1Rs6f8RXu65ecak3wDq
        VcsAEjesx6IfD4lo/xDExtl25iPijiPqdTZhxpCNtm6Yb44STxFAV3waakz6RCbxYj3q5l
        kVInWumh019a6EFLcmeNEge2ZqFwoMY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-XAdbdptINAKAOggp-ATuGw-1; Sun, 03 Jul 2022 21:13:54 -0400
X-MC-Unique: XAdbdptINAKAOggp-ATuGw-1
Received: by mail-pj1-f69.google.com with SMTP id gd18-20020a17090b0fd200b001ef193b5452so4503978pjb.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Jul 2022 18:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nv3kLqVRpORhA1eU8Voo6ss8wDxc+AM8OLmudfWCLYs=;
        b=0USHNaGtjJYOkglwt1Ri7oxfgG7YX9GmkBxPumxhisJPX0pfZPC4ZKPvmAjSCn1aWU
         wejV+lY3NcGmpv33ENa2dqVg9KSJxHFmYINhhAHGukxt21IoSP1/oJ2oSfWcqQPB8Hjp
         NyugDjfFtcjYv+oRhlBXPhn3R9kVqASqUgCWMmQhU+4ZF+O3M01s2It5dXm6BRQFA9oM
         rG0Azsv51plHsZmT/wjqBK9Yop2VU/YfOnTgHG6oyX45k/jt9RLXewJ3YrbTktFpzuMo
         32+oA3SwxSRLsDVkUTfJ5vfNZBEWEVhHWpy+hlqrZZXFU7oNUW9AGU1VYokWJkBXXVI4
         DEMg==
X-Gm-Message-State: AJIora+KeWwyy5UfPEV9w5O/AH00o567OEULMTKVno3H4B32xBUXPpmD
        +cZ9Slp6LD/K0JmQrF+Pxboen8j30RPN+QrytsCA8ig3wyuQqOiGZdR2FYyFPyl2WpOyRTV07rr
        bKZxIlzUTpB3jKoweIscKrJI+7Q==
X-Received: by 2002:a63:33ce:0:b0:40c:5487:6e6d with SMTP id z197-20020a6333ce000000b0040c54876e6dmr23506166pgz.135.1656897232907;
        Sun, 03 Jul 2022 18:13:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v+HireMspFAh1WUDJ6ByKYptcG3louApKnYoE9dNmZU5NVDm+4O8N59fgytQgg2A5L4LbblA==
X-Received: by 2002:a63:33ce:0:b0:40c:5487:6e6d with SMTP id z197-20020a6333ce000000b0040c54876e6dmr23506145pgz.135.1656897232639;
        Sun, 03 Jul 2022 18:13:52 -0700 (PDT)
Received: from [10.72.12.186] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q17-20020a656851000000b003fdc16f5de2sm19407912pgt.15.2022.07.03.18.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 18:13:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] netfs: release the folio lock and put the folio
 before retrying
To:     Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com,
        dhowells@redhat.com
Cc:     vshankar@redhat.com, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, willy@infradead.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com
References: <20220701022947.10716-1-xiubli@redhat.com>
 <20220701022947.10716-2-xiubli@redhat.com>
 <30a4bd0e19626f5fb30f19f0ae70fba2debb361a.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <f55d10f8-55f6-f56c-bb41-bce139869c8d@redhat.com>
Date:   Mon, 4 Jul 2022 09:13:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <30a4bd0e19626f5fb30f19f0ae70fba2debb361a.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/1/22 6:38 PM, Jeff Layton wrote:
> On Fri, 2022-07-01 at 10:29 +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> The lower layer filesystem should always make sure the folio is
>> locked and do the unlock and put the folio in netfs layer.
>>
>> URL: https://tracker.ceph.com/issues/56423
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/netfs/buffered_read.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
>> index 42f892c5712e..257fd37c2461 100644
>> --- a/fs/netfs/buffered_read.c
>> +++ b/fs/netfs/buffered_read.c
>> @@ -351,8 +351,11 @@ int netfs_write_begin(struct netfs_inode *ctx,
>>   		ret = ctx->ops->check_write_begin(file, pos, len, folio, _fsdata);
>>   		if (ret < 0) {
>>   			trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
>> -			if (ret == -EAGAIN)
>> +			if (ret == -EAGAIN) {
>> +				folio_unlock(folio);
>> +				folio_put(folio);
>>   				goto retry;
>> +			}
>>   			goto error;
>>   		}
>>   	}
> I don't know here... I think it might be better to just expect that when
> this function returns an error that the folio has already been unlocked.
> Doing it this way will mean that you will lock and unlock the folio a
> second time for no reason.
>
> Maybe something like this instead?
>
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 42f892c5712e..8ae7b0f4c909 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -353,7 +353,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
>                          trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
>                          if (ret == -EAGAIN)
>                                  goto retry;
> -                       goto error;
> +                       goto error_unlocked;
>                  }
>          }
>   
> @@ -418,6 +418,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
>   error:
>          folio_unlock(folio);
>          folio_put(folio);
> +error_unlocked:
>          _leave(" = %d", ret);
>          return ret;
>   }

Then the "afs" won't work correctly:

377 static int afs_check_write_begin(struct file *file, loff_t pos, 
unsigned len,
378                                  struct folio *folio, void **_fsdata)
379 {
380         struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
381
382         return test_bit(AFS_VNODE_DELETED, &vnode->flags) ? -ESTALE : 0;
383 }

The "afs" does nothing with the folio lock.

-- Xiubo


