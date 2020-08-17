Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18770245E59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 09:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHQHuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 03:50:12 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64628 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgHQHuL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:11 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BVR635hQkz9tydN;
        Mon, 17 Aug 2020 09:50:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6bnqZI49gzlj; Mon, 17 Aug 2020 09:50:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BVR634gmzz9tydG;
        Mon, 17 Aug 2020 09:50:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A773C8B777;
        Mon, 17 Aug 2020 09:50:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lTOY4FOE6N1D; Mon, 17 Aug 2020 09:50:08 +0200 (CEST)
Received: from [172.25.230.104] (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7AD158B75B;
        Mon, 17 Aug 2020 09:50:08 +0200 (CEST)
Subject: Re: [PATCH 05/11] test_bitmap: skip user bitmap tests for
 !CONFIG_SET_FS
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-6-hch@lst.de>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9e632937-9e9a-faed-bc0e-fcb7a6b4f54c@csgroup.eu>
Date:   Mon, 17 Aug 2020 09:50:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817073212.830069-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 17/08/2020 à 09:32, Christoph Hellwig a écrit :
> We can't run the tests for userspace bitmap parsing if set_fs() doesn't
> exist.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   lib/test_bitmap.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index df903c53952bb9..49b1d25fbaf546 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -365,6 +365,7 @@ static void __init __test_bitmap_parselist(int is_user)
>   	for (i = 0; i < ARRAY_SIZE(parselist_tests); i++) {
>   #define ptest parselist_tests[i]
>   
> +#ifdef CONFIG_SET_FS

get_fs() and set_fs() have stubs for when an arch doesn't define them, 
so I this it would be cleaner if you were using 'if 
(IS_ENABLED(CONFIG_SET_FS) && is_user)`instead of an ifdefery in the 
middle of the if/else.

Christophe


>   		if (is_user) {
>   			mm_segment_t orig_fs = get_fs();
>   			size_t len = strlen(ptest.in);
> @@ -375,7 +376,9 @@ static void __init __test_bitmap_parselist(int is_user)
>   						    bmap, ptest.nbits);
>   			time = ktime_get() - time;
>   			set_fs(orig_fs);
> -		} else {
> +		} else
> +#endif /* CONFIG_SET_FS */
> +		{
>   			time = ktime_get();
>   			err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
>   			time = ktime_get() - time;
> @@ -454,6 +457,7 @@ static void __init __test_bitmap_parse(int is_user)
>   	for (i = 0; i < ARRAY_SIZE(parse_tests); i++) {
>   		struct test_bitmap_parselist test = parse_tests[i];
>   
> +#ifdef CONFIG_SET_FS
>   		if (is_user) {
>   			size_t len = strlen(test.in);
>   			mm_segment_t orig_fs = get_fs();
> @@ -464,7 +468,9 @@ static void __init __test_bitmap_parse(int is_user)
>   						bmap, test.nbits);
>   			time = ktime_get() - time;
>   			set_fs(orig_fs);
> -		} else {
> +		} else
> +#endif /* CONFIG_SET_FS */
> +		{
>   			size_t len = test.flags & NO_LEN ?
>   				UINT_MAX : strlen(test.in);
>   			time = ktime_get();
> 
