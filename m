Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF33D6C48E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 12:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCVLTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 07:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCVLTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD32CC18
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 04:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679483892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RGXtnRTO5ux2tPoKk2ueNig0Mis6f6SCdrb5V0DSYA0=;
        b=W+6zJB2j/6tIty37vM07EOJw+Z+4KvmnNPQznMj4XbG4/3iJ5rbxkNVYQzhsGJH/kdhZ7a
        OpQkR/jk2y/e0CWOTwi9ccUoz7Giz+koeAE4rcsOnNVrEQj8gIKYvivLHXtGgw/DaVyDBO
        5pewmXGf5JZfJTaco8o3n69KMdAZhaE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-0zb73qkZNratk9KvNo2sBQ-1; Wed, 22 Mar 2023 07:18:11 -0400
X-MC-Unique: 0zb73qkZNratk9KvNo2sBQ-1
Received: by mail-wm1-f72.google.com with SMTP id v8-20020a05600c470800b003ed3b575374so8577119wmo.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Mar 2023 04:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679483890;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGXtnRTO5ux2tPoKk2ueNig0Mis6f6SCdrb5V0DSYA0=;
        b=nenvgPBRngi0Rh2A6V5/qXdODw5JREUzH6YFK1wtk7NKP2skSn4RdATwWkDn2XGBvL
         2FdHWeSI9khQe5mhAj0MpvGkCmruhWhxW+He0wWV0zBRSoyFC7uhYS4zeXqQCk6/ZRXR
         2A8LSGL+475qwXxzjL7Hs36Bv1F1flgKf9g1NoDhTQx1lbCWKhEhNvnWWS4eWy4dNFxW
         rXj9y8pxjhX0LXZNF8disb6W2jeipgWRtjoCw4acQLniqD8nKV377hicGuFSQDD+pc4t
         bNKZZrzBbxYM+pMdqA+ZQPkFZzfDXERu8zo75z+KzNv0XyUC/63AQtk56H7aD4Fo9Tum
         laXQ==
X-Gm-Message-State: AO0yUKU7kKGUMfuhrqqAewG1T5hgivIY5Fi9lNT9z8ArmQzQ9yW1XAq2
        wMk7xxsGTpLKp422CkdfotwP1vmMgrbWsRvKJIzvqiwaCRqyOmpzfSgBADFAJkDECOfjCPW/285
        BWbSgOEKRugXbnzDpIeaqOgcZDg==
X-Received: by 2002:a7b:c38e:0:b0:3ed:f9d3:f95c with SMTP id s14-20020a7bc38e000000b003edf9d3f95cmr4686143wmj.19.1679483890267;
        Wed, 22 Mar 2023 04:18:10 -0700 (PDT)
X-Google-Smtp-Source: AK7set9mcGpeMLeRP8Q8H264tJSjlNKYbWOQArqWJCPwIDU5RZzaTQdES5I0ClQsgif2CIbW1KNVWg==
X-Received: by 2002:a7b:c38e:0:b0:3ed:f9d3:f95c with SMTP id s14-20020a7bc38e000000b003edf9d3f95cmr4686129wmj.19.1679483889956;
        Wed, 22 Mar 2023 04:18:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:d00:ca74:d9ea:11e0:dfb? (p200300cbc7030d00ca74d9ea11e00dfb.dip0.t-ipconnect.de. [2003:cb:c703:d00:ca74:d9ea:11e0:dfb])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b003ede03e4369sm10954856wmg.33.2023.03.22.04.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 04:18:09 -0700 (PDT)
Message-ID: <8ba0360e-57eb-93b0-3ae6-612f6b371bff@redhat.com>
Date:   Wed, 22 Mar 2023 12:18:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 4/4] mm: vmalloc: convert vread() to vread_iter()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1679431886.git.lstoakes@gmail.com>
 <6b3899bbbf1f4bd6b7133c8b6f27b3a8791607b0.1679431886.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6b3899bbbf1f4bd6b7133c8b6f27b3a8791607b0.1679431886.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21.03.23 21:54, Lorenzo Stoakes wrote:
> Having previously laid the foundation for converting vread() to an iterator
> function, pull the trigger and do so.
> 
> This patch attempts to provide minimal refactoring and to reflect the
> existing logic as best we can, for example we continue to zero portions of
> memory not read, as before.
> 
> Overall, there should be no functional difference other than a performance
> improvement in /proc/kcore access to vmalloc regions.
> 
> Now we have eliminated the need for a bounce buffer in read_kcore_iter(),
> we dispense with it. We need to ensure userland pages are faulted in before
> proceeding, as we take spin locks.
> 
> Additionally, we must account for the fact that at any point a copy may
> fail if this happens, we exit indicating fewer bytes retrieved than
> expected.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>   fs/proc/kcore.c         |  26 ++---
>   include/linux/vmalloc.h |   3 +-
>   mm/nommu.c              |  10 +-
>   mm/vmalloc.c            | 234 +++++++++++++++++++++++++---------------
>   4 files changed, 160 insertions(+), 113 deletions(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 25e0eeb8d498..221e16f75ba5 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -307,13 +307,9 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
>   	*i = ALIGN(*i + descsz, 4);
>   }
>   
> -static ssize_t
> -read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
> +static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>   {
> -	struct file *file = iocb->ki_filp;
> -	char *buf = file->private_data;
>   	loff_t *ppos = &iocb->ki_pos;
> -
>   	size_t phdrs_offset, notes_offset, data_offset;
>   	size_t page_offline_frozen = 1;
>   	size_t phdrs_len, notes_len;
> @@ -507,9 +503,12 @@ read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>   
>   		switch (m->type) {
>   		case KCORE_VMALLOC:
> -			vread(buf, (char *)start, tsz);
> -			/* we have to zero-fill user buffer even if no read */
> -			if (copy_to_iter(buf, tsz, iter) != tsz) {
> +			/*
> +			 * Make sure user pages are faulted in as we acquire
> +			 * spinlocks in vread_iter().
> +			 */
> +			if (fault_in_iov_iter_writeable(iter, tsz) ||
> +			    vread_iter(iter, (char *)start, tsz) != tsz) {
>   				ret = -EFAULT;
>   				goto out;
>   			}

What if we race with swapout after faulting the pages in? Or some other 
mechanism to write-protect the user space pages?

Also, "This is primarily useful when we already know that some or all of 
the pages in @i aren't in memory". This order of events might slow down 
things quite a bit if I am not wrong.


Wouldn't you want to have something like:

while (vread_iter(iter, (char *)start, tsz) != tsz) {
	if (fault_in_iov_iter_writeable(iter, tsz)) {
		ret = -EFAULT;
		goto out;
	}
}

Or am I missing something?

-- 
Thanks,

David / dhildenb

