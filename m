Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F7E6E4653
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 13:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjDQLYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 07:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjDQLYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32008682
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 04:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681730515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mkcwhp5zTW1yRaiHiJTdOs9s0Tvzr5julsI/kTPOe68=;
        b=HO0+YObt/3aVi67/IEtOuxKqjMnIa2b6AQnoxpD+Gcb6sAHnKpfwQKeHYCmROOwttBH0Jy
        j/zqCpSjP+IljcpWrOpIGI8+jFP6J0ZJa1lV6L2w/fReU+M/zjYojNePlTpZNjj8v6fQxX
        h3i/J92KNj0+x+slDLHNO1MCpcxW5JA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-02r1UxWHNsWK8MV_3GeEpA-1; Mon, 17 Apr 2023 07:21:54 -0400
X-MC-Unique: 02r1UxWHNsWK8MV_3GeEpA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-2f6bd453dd0so677468f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 04:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681730513; x=1684322513;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkcwhp5zTW1yRaiHiJTdOs9s0Tvzr5julsI/kTPOe68=;
        b=doHM5+87kjHrO/UfNJRHoHoQp5gNG7hAeAWxriFveweveefDHyYWZO+8FPphBy8/sD
         bFKTsN3+yGVThx1O4ug97nXPGLNukXotX5RAg9nnFx6ymoMLuBHmyCtPI3a86tYPzvEH
         +yvbrzMP7UL0ZHYTT1Yhh+Pc4dugQ2rNh/mpw6qxDkxGjwv4HY5TQF+wXQt6fpylzmtw
         BLPbh/raK4AnKItJuxXVTl9qfontxGSjj3tdhYrz7/g5BTO0Z79VpDjh49z3sdylCeGY
         nwOWPbNGBM7oOKsyWZxgv36oUbfUKHYCgvurG+ayqXpNj6ohfxY4V+5VUudy9y82F1ML
         GOag==
X-Gm-Message-State: AAQBX9dzwaJdnbpYl24Ex6VcwqwadP0/xVzDdTSmzvL5CN6xUXEHPOfy
        IHoyigV4Et5oNkF6hOlDZAv6/HS+LQDzcZs60C8lYg1mFHRi/omEvgSQGMBUw8qFdC1+tB8strm
        e1/AW0xjC6dhBXJAP1s/Ph+QtQQ==
X-Received: by 2002:adf:ff85:0:b0:2f9:dfab:1b8c with SMTP id j5-20020adfff85000000b002f9dfab1b8cmr2581410wrr.50.1681730513174;
        Mon, 17 Apr 2023 04:21:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350abZRZAOfdMv9lYJhbEZufnC86FDoAE2OKI65tR0JXtMEmI74JIW99/H3RyhX6ngBR4MbJnEg==
X-Received: by 2002:adf:ff85:0:b0:2f9:dfab:1b8c with SMTP id j5-20020adfff85000000b002f9dfab1b8cmr2581395wrr.50.1681730512826;
        Mon, 17 Apr 2023 04:21:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id e6-20020adff346000000b002efac42ff35sm10294758wrp.37.2023.04.17.04.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 04:21:52 -0700 (PDT)
Message-ID: <dfa218f9-1a99-f877-4c9d-a4d185b6ebd5@redhat.com>
Date:   Mon, 17 Apr 2023 13:21:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH next] shmem: minor fixes to splice-read implementation
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Yang Shi <shy828301@gmail.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <2d5fa5e3-dac5-6973-74e5-eeedf36a42b@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2d5fa5e3-dac5-6973-74e5-eeedf36a42b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.04.23 06:46, Hugh Dickins wrote:
> generic_file_splice_read() makes a couple of preliminary checks (for
> s_maxbytes and zero len), but shmem_file_splice_read() is called without
> those: so check them inside it.  (But shmem does not support O_DIRECT,
> so no need for that one here - and even if O_DIRECT support were stubbed
> in, it would still just be using the page cache.)
> 
> HWPoison: my reading of folio_test_hwpoison() is that it only tests the
> head page of a large folio, whereas splice_folio_into_pipe() will splice
> as much of the folio as it can: so for safety we should also check the
> has_hwpoisoned flag, set if any of the folio's pages are hwpoisoned.
> (Perhaps that ugliness can be improved at the mm end later.)
> 
> The call to splice_zeropage_into_pipe() risked overrunning past EOF:
> ask it for "part" not "len".
> 
> Fixes: b81d7b89becc ("shmem: Implement splice-read")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> Thank you, David, for attending to tmpfs in your splice update:
> yes, I too wish it could have just used the generic, but I'm sure
> you're right that there's a number of reasons it needs its own.
> 
>   mm/shmem.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2902,6 +2902,11 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
>   	loff_t isize;
>   	int error = 0;
>   
> +	if (unlikely(*ppos >= MAX_LFS_FILESIZE))
> +		return 0;
> +	if (unlikely(!len))
> +		return 0;
> +
>   	/* Work out how much data we can actually add into the pipe */
>   	used = pipe_occupancy(pipe->head, pipe->tail);
>   	npages = max_t(ssize_t, pipe->max_usage - used, 0);
> @@ -2911,7 +2916,8 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
>   		if (*ppos >= i_size_read(inode))
>   			break;
>   
> -		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio, SGP_READ);
> +		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio,
> +					SGP_READ);
>   		if (error) {
>   			if (error == -EINVAL)
>   				error = 0;
> @@ -2920,7 +2926,9 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
>   		if (folio) {
>   			folio_unlock(folio);
>   
> -			if (folio_test_hwpoison(folio)) {
> +			if (folio_test_hwpoison(folio) ||
> +			    (folio_test_large(folio) &&
> +			     folio_test_has_hwpoisoned(folio))) {
>   				error = -EIO;
>   				break;
>   			}
> @@ -2956,7 +2964,7 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
>   			folio_put(folio);
>   			folio = NULL;
>   		} else {
> -			n = splice_zeropage_into_pipe(pipe, *ppos, len);
> +			n = splice_zeropage_into_pipe(pipe, *ppos, part);
>   		}
>   
>   		if (!n)
> 

FWIW, looks good to me.


-- 
Thanks,

David / dhildenb

