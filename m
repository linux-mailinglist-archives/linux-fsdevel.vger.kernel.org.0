Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E2B7637C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjGZNjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 09:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjGZNjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE8AE69
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690378696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8Z700vzR7baDs8b/e0kEl1jWEWNlBZFJe5eJ9LWL2M=;
        b=cYKxX+f5W8GUBF/bVF+A9Se010HvytxlKcOf0y68e2N/F8OE1NI+wt2gjdQl0vBTJD0/jJ
        IvYIFC5W8AcyrgYfqZSVITssoEt8EswqUuIJtuDadQcAspDSCa/l3q2cOS4WuXSN+cv080
        TIGaEi5PrzUzo3ZsEOHyLEVblg/pJlo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-d9qWTDzHNgaX7zAaXyQjbw-1; Wed, 26 Jul 2023 09:38:15 -0400
X-MC-Unique: d9qWTDzHNgaX7zAaXyQjbw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31779e89e39so138117f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 06:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690378694; x=1690983494;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8Z700vzR7baDs8b/e0kEl1jWEWNlBZFJe5eJ9LWL2M=;
        b=Hyd2s+PLZvzeuIg0KfOnhsxvaCuJvusV+9Kr4S/DLfEV3HXzZ+sWDwBL3cn1V6SXpT
         dBanJsYtXW/khPH1157ILkHsIEaJeC7bWfi5kt691S5b2sYvveZ5GNLq0dFUiUBSGcag
         aEe2UCq5QQYn4Np0u/Tx++w401OWAdN/vU2ANzBAWjUfEkj/VdqIL1V5HKDEQNbyDHWE
         QHrIU0IPktcZrzIJjjQDkpXiC1nezzft8Jfu5ygzJOe55Av4umMZqD0IR5JqJSI6xkwj
         ydUlGCZX0ivihXc6OFRR9qMWMYU8FhrBJ3UTgOkEJ0/nUrG3esa2zn2iEd67RURhdaM9
         I/OA==
X-Gm-Message-State: ABy/qLYr5z7oCfkpbhhrbUW1NN/M7BV5PhTYpI8Ynnrtsu6tJXWACrQd
        pQ1X5vsNF1C3imk0zK2RGZlidjvIEe+QE6uWZZ9KJ5CgbkgH1kH1VmAqqURJhKhmm57fe1UnvpO
        YTjmWOdDkHBl5O1754Fn7ab3tQg==
X-Received: by 2002:a5d:468b:0:b0:317:59c8:17bc with SMTP id u11-20020a5d468b000000b0031759c817bcmr1262944wrq.15.1690378694087;
        Wed, 26 Jul 2023 06:38:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFW6fWGnz4rPcAEd3A5rxFde+FjwCaa7dB2oKhB0S6J5Gte5BzfN0mtzCoUlg3SX0ZdBK9MJw==
X-Received: by 2002:a5d:468b:0:b0:317:59c8:17bc with SMTP id u11-20020a5d468b000000b0031759c817bcmr1262918wrq.15.1690378693599;
        Wed, 26 Jul 2023 06:38:13 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6c57.dip0.t-ipconnect.de. [91.12.108.87])
        by smtp.gmail.com with ESMTPSA id k11-20020adfd84b000000b0031773e3cf46sm2867991wrl.61.2023.07.26.06.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 06:38:13 -0700 (PDT)
Message-ID: <416eca24-6baf-69d9-21a2-c434a9744596@redhat.com>
Date:   Wed, 26 Jul 2023 15:38:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] crypto, cifs: Fix error handling in extract_iter_to_sg()
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steve French <sfrench@samba.org>
Cc:     akpm@linux-foundation.org, Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Layton <jlayton@kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20571.1690369076@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20571.1690369076@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.07.23 12:57, David Howells wrote:
>      
> Fix error handling in extract_iter_to_sg().  Pages need to be unpinned, not
> put in extract_user_to_sg() when handling IOVEC/UBUF sources.
> 
> The bug may result in a warning like the following:
> 
>    WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 __lse_atomic_add arch/arm64/include/asm/atomic_lse.h:27 [inline]
>    WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 arch_atomic_add arch/arm64/include/asm/atomic.h:28 [inline]
>    WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 raw_atomic_add include/linux/atomic/atomic-arch-fallback.h:537 [inline]
>    WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 atomic_add include/linux/atomic/atomic-instrumented.h:105 [inline]
>    WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 try_grab_page+0x108/0x160 mm/gup.c:252
>    ...
>    pc : try_grab_page+0x108/0x160 mm/gup.c:229
>    lr : follow_page_pte+0x174/0x3e4 mm/gup.c:651
>    ...
>    Call trace:
>     __lse_atomic_add arch/arm64/include/asm/atomic_lse.h:27 [inline]
>     arch_atomic_add arch/arm64/include/asm/atomic.h:28 [inline]
>     raw_atomic_add include/linux/atomic/atomic-arch-fallback.h:537 [inline]
>     atomic_add include/linux/atomic/atomic-instrumented.h:105 [inline]
>     try_grab_page+0x108/0x160 mm/gup.c:252
>     follow_pmd_mask mm/gup.c:734 [inline]
>     follow_pud_mask mm/gup.c:765 [inline]
>     follow_p4d_mask mm/gup.c:782 [inline]
>     follow_page_mask+0x12c/0x2e4 mm/gup.c:839
>     __get_user_pages+0x174/0x30c mm/gup.c:1217
>     __get_user_pages_locked mm/gup.c:1448 [inline]
>     __gup_longterm_locked+0x94/0x8f4 mm/gup.c:2142
>     internal_get_user_pages_fast+0x970/0xb60 mm/gup.c:3140
>     pin_user_pages_fast+0x4c/0x60 mm/gup.c:3246
>     iov_iter_extract_user_pages lib/iov_iter.c:1768 [inline]
>     iov_iter_extract_pages+0xc8/0x54c lib/iov_iter.c:1831
>     extract_user_to_sg lib/scatterlist.c:1123 [inline]
>     extract_iter_to_sg lib/scatterlist.c:1349 [inline]
>     extract_iter_to_sg+0x26c/0x6fc lib/scatterlist.c:1339
>     hash_sendmsg+0xc0/0x43c crypto/algif_hash.c:117
>     sock_sendmsg_nosec net/socket.c:725 [inline]
>     sock_sendmsg+0x54/0x60 net/socket.c:748
>     ____sys_sendmsg+0x270/0x2ac net/socket.c:2494
>     ___sys_sendmsg+0x80/0xdc net/socket.c:2548
>     __sys_sendmsg+0x68/0xc4 net/socket.c:2577
>     __do_sys_sendmsg net/socket.c:2586 [inline]
>     __se_sys_sendmsg net/socket.c:2584 [inline]
>     __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2584
>     __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>     invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
>     el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
>     do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
>     el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
>     el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
>     el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
> 
> Fixes: 018584697533 ("netfs: Add a function to extract an iterator into a scatterlist")
> Reported-by: syzbot+9b82859567f2e50c123e@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-mm/000000000000273d0105ff97bf56@google.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Sven Schnelle <svens@linux.ibm.com>
> cc: akpm@linux-foundation.org
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-mm@kvack.org
> cc: linux-crypto@vger.kernel.org
> cc: linux-cachefs@redhat.com
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>   lib/scatterlist.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index e86231a44c3d..c65566b4dc66 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -1148,7 +1148,7 @@ static ssize_t extract_user_to_sg(struct iov_iter *iter,
>   
>   failed:
>   	while (sgtable->nents > sgtable->orig_nents)
> -		put_page(sg_page(&sgtable->sgl[--sgtable->nents]));
> +		unpin_user_page(sg_page(&sgtable->sgl[--sgtable->nents]));
>   	return res;
>   }
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

