Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826C175605D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 12:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjGQK0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 06:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGQK0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5E5E52
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689589547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ZxqwFcIYi400ycUN1jF1UBiOV7Go/IiKqR9OlilEKQ=;
        b=SfykH/ii3gUCTwlyPuuCth+cz001fCWo95eWHJiSUOn65rniv0I8nUqum9T2TOTs9h0f/8
        YGi6pYFViNM1FtuYbUvoywXkP25N53QuE15VHpDDSb8eO792EaoINwhwjmRGMQ47lVVkCQ
        c+j9coZwgS0ZIcR7yWBv3h+UhR4T6rg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-9Uq66Lz5O9Cp8qrnG6sV5w-1; Mon, 17 Jul 2023 06:25:46 -0400
X-MC-Unique: 9Uq66Lz5O9Cp8qrnG6sV5w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-314326f6e23so2365838f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 03:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689589545; x=1692181545;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZxqwFcIYi400ycUN1jF1UBiOV7Go/IiKqR9OlilEKQ=;
        b=cflbVYorEIn28jneH03UYEhhvkjqQLIUj895gQkMnbZhbqL+MMzQ+Kt8Koc50DInRX
         Rh77EKOONxBm5dvee2vmGXwGikt9UPSn6s59RXd/qBuLblrlaIyWiHTR9WvUZTVJqF2l
         lOxD67dtOM2obbBXGiRPleCiIv5l0E8/FJw54xYC+9bV2pSZd2SBVmR1bzDV4Tasc3zi
         wrFxQMgWhvHrwrvjalcadd6ts4Tkz7tJ/6ENDtLgVWaxXb4ESp2TVKEXoFdLwt7bfP4a
         L0auoCCenTxwCYT5PGYifFEe7CL5BCiOWBuTKUjoKCD6/YxwD9dDJPWOIWWAf54eDA59
         jtUg==
X-Gm-Message-State: ABy/qLbWvHDWV3tsSlHgMAJhz3cAbKiR2I74VnowrLFpVO5igvM0Oodd
        N6Z414S6iNnN7fD3wJUBp/H+5UC9qFwC47sWyIjRRGBzRDxa1PhzcQbImmH5mH1LzY8m27FbrYK
        fVcSwuB5zwy6tGscv1KGmkigkmA==
X-Received: by 2002:a5d:6301:0:b0:313:f548:25b9 with SMTP id i1-20020a5d6301000000b00313f54825b9mr10182306wru.40.1689589545445;
        Mon, 17 Jul 2023 03:25:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEWwgj2gvrTcZVcFzDTLfBjRjMXpKrSXg5bhLw4PXADJbZO+n+htRPdtsID+emCjARx8zYmVw==
X-Received: by 2002:a5d:6301:0:b0:313:f548:25b9 with SMTP id i1-20020a5d6301000000b00313f54825b9mr10182288wru.40.1689589545080;
        Mon, 17 Jul 2023 03:25:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d4641000000b0031434936f0dsm18732085wrs.68.2023.07.17.03.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 03:25:44 -0700 (PDT)
Message-ID: <2000511c-d551-5b3d-a9a9-adb4ba3be1f1@redhat.com>
Date:   Mon, 17 Jul 2023 12:25:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/5] mm: use vma_is_stack() and vma_is_heap()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com>
 <20230712143831.120701-3-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230712143831.120701-3-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.07.23 16:38, Kefeng Wang wrote:
> Use the helpers to simplify code.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   fs/proc/task_mmu.c   | 24 ++++--------------------
>   fs/proc/task_nommu.c | 15 +--------------
>   2 files changed, 5 insertions(+), 34 deletions(-)
> 

Please squash patch #1 and this patch and call it something like

"mm: factor out VMA stack and heap checks"

And then, maybe also keep the comments in these functions, they sound 
reasonable to have.

-- 
Cheers,

David / dhildenb

