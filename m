Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048A872F652
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 09:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbjFNH3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 03:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjFNH33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA15B1BC5
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 00:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686727720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoOp2WXZj/1IeU1OQfnjNJXRwTjLv2KdN6AVUPP90dQ=;
        b=SUq7OWaU/DmPPP8qAFyOHEqE2UgbMtlVQeB2IqFldWs10X19NiMkctAIVKEa70rlwOpXO3
        2FJJHqpJLtzd5EVjnbO0JEJL/IeBO0/TxBlQ7vpyq7xgitAnY2+NYgOo+wiHuRmLYQmkrO
        qlcO3zVE4igpAYUkLo+mjAqY6kq7B2I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-nm5eklZ0OYyQyd_k2i1Cew-1; Wed, 14 Jun 2023 03:28:39 -0400
X-MC-Unique: nm5eklZ0OYyQyd_k2i1Cew-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7ecc15771so1669655e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 00:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686727718; x=1689319718;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoOp2WXZj/1IeU1OQfnjNJXRwTjLv2KdN6AVUPP90dQ=;
        b=k0s6Ojqa6q3gN+qoFc2S8LDst8sVC1Jz86ULeG+WPgwyxxxSCwJdpFWwqqFbk0ZPpY
         mpiRWkiGQY6OTKONKpib/ag7UqPFzjcLqzHXgo0FloMVGegBn85NIN17O96ovLYgTi8l
         9ITUgi7cyXMWHHwdu3rtC8/ac5K7ME3r4i5rIewqRZeI+zz2/hTCUP/KBWA794jDdqY8
         IJiiVbddojPaUV2mahpV5VHxkjZL1ZsxEp0wefyzzPQskwY7Lr89fekZTlGNY40sjuJi
         pPAxBTA/cYwVV98NVJVuvDjixakuEHvvuGaw5dDAhXoi0FbLga5wI3moWx7sYhXlbG1A
         lf8w==
X-Gm-Message-State: AC+VfDy6T0WY78cqa2yhyM7iHMkFOmYLt0bjY+jY+kN4URLrERlZsstE
        3egiwwPaJGZ7DkxD8n2grcXxEf1NGCuGwwEyCMe8xAH05qOf1y00zuv+P1PmAhFX4mnJMFuv0tP
        oKjHZo29wkPRgnwos7tWcdgrXzQ==
X-Received: by 2002:a1c:720c:0:b0:3f1:731e:cdb1 with SMTP id n12-20020a1c720c000000b003f1731ecdb1mr701024wmc.6.1686727718360;
        Wed, 14 Jun 2023 00:28:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47nT/sd1Fp64hlEKEvu1oRyMkoHoA3zodk9vinDMdNyiquCqMTYEZ40M2Y4d+tAIpyY0MLVA==
X-Received: by 2002:a1c:720c:0:b0:3f1:731e:cdb1 with SMTP id n12-20020a1c720c000000b003f1731ecdb1mr700995wmc.6.1686727717995;
        Wed, 14 Jun 2023 00:28:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b200:7d03:23db:ad5:2d21? (p200300cbc704b2007d0323db0ad52d21.dip0.t-ipconnect.de. [2003:cb:c704:b200:7d03:23db:ad5:2d21])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c228b00b003f7361ca753sm16474673wmf.24.2023.06.14.00.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 00:28:37 -0700 (PDT)
Message-ID: <e2d88c95-f848-2236-64c5-54331876d2bf@redhat.com>
Date:   Wed, 14 Jun 2023 09:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: Fix dio_cleanup() to advance the head index
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org
References: <1193485.1686693279@warthog.procyon.org.uk>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1193485.1686693279@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.06.23 23:54, David Howells wrote:
>      
> Fix dio_bio_cleanup() to advance the head index into the list of pages past
> the pages it has released, as __blockdev_direct_IO() will call it twice if
> do_direct_IO() fails.
> 
> The issue was causing:
> 
>          WARNING: CPU: 6 PID: 2220 at mm/gup.c:76 try_get_folio
> 
> This can be triggered by setting up a clean pair of UDF filesystems on
> loopback devices and running the generic/451 xfstest with them as the
> scratch and test partitions.  Something like the following:
> 
>      fallocate /mnt2/udf_scratch -l 1G
>      fallocate /mnt2/udf_test -l 1G
>      mknod /dev/lo0 b 7 0
>      mknod /dev/lo1 b 7 1
>      losetup lo0 /mnt2/udf_scratch
>      losetup lo1 /mnt2/udf_test
>      mkfs -t udf /dev/lo0
>      mkfs -t udf /dev/lo1
>      cd xfstests
>      ./check generic/451
> 
> with xfstests configured by putting the following into local.config:
> 
>      export FSTYP=udf
>      export DISABLE_UDF_TEST=1
>      export TEST_DEV=/dev/lo1
>      export TEST_DIR=/xfstest.test
>      export SCRATCH_DEV=/dev/lo0
>      export SCRATCH_MNT=/xfstest.scratch
> 
> Fixes: 1ccf164ec866 ("block: Use iov_iter_extract_pages() and page pinning in direct-io.c")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202306120931.a9606b88-oliver.sang@intel.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: David Hildenbrand <david@redhat.com>
> cc: Andrew Morton <akpm@linux-foundation.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Jan Kara <jack@suse.cz>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Jason Gunthorpe <jgg@nvidia.com>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: Hillf Danton <hdanton@sina.com>
> cc: Christian Brauner <brauner@kernel.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-kernel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>   fs/direct-io.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 0643f1bb4b59..2ceb378b93c0 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -459,6 +459,7 @@ static inline void dio_cleanup(struct dio *dio, struct dio_submit *sdio)
>   	if (dio->is_pinned)
>   		unpin_user_pages(dio->pages + sdio->head,
>   				 sdio->tail - sdio->head);
> +	sdio->head = sdio->tail;
>   }
>   
>   /*
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

