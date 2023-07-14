Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A65753D41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 16:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbjGNO04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 10:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbjGNO0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:26:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281D8359F;
        Fri, 14 Jul 2023 07:26:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AADA51F747;
        Fri, 14 Jul 2023 14:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689344804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbJwmhXfhN5rIPoLj6fIJpy/+DMnwxG+UHYLi25rZdQ=;
        b=2eZEKNybuxBZ5dM4elpTXk5fybRAWCqEWxv5TWQSsbZwocHXqr6P/pCn+HDpCp7VOHFySU
        wrN5RdAayt0lobndDZx78GkWfzBqXslCQdTLHDIT0+rhfSaqa1zkl5RfWg4pf19se7xDGz
        2877+IHCgDJe1hKZRpKwl3nJ14+KI4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689344804;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbJwmhXfhN5rIPoLj6fIJpy/+DMnwxG+UHYLi25rZdQ=;
        b=cDg/jNJAsxU+WNbuvHmDt9VhdDeknW42QogvvhHtOg5owP1dFsCJop+teLMjTToesPOSkW
        QA4DQyFxXD8lQGCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A75413A15;
        Fri, 14 Jul 2023 14:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2440HSRbsWRTHQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Jul 2023 14:26:44 +0000
Message-ID: <d11b6c3c-cbf8-a7dc-3cf9-e4e4dcf81fbc@suse.cz>
Date:   Fri, 14 Jul 2023 16:26:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] drm/amdkfd: use vma_is_stack() and vma_is_heap()
Content-Language: en-US
To:     Felix Kuehling <felix.kuehling@amd.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org
References: <20230712143831.120701-1-wangkefeng.wang@huawei.com>
 <20230712143831.120701-4-wangkefeng.wang@huawei.com>
 <ZK671bHU1QLYagj8@infradead.org>
 <83f11260-cd26-5b46-e9d4-1ca97565a1d0@amd.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <83f11260-cd26-5b46-e9d4-1ca97565a1d0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/12/23 18:24, Felix Kuehling wrote:
> Allocations in the heap and stack tend to be small, with several 
> allocations sharing the same page. Sharing the same page for different 
> allocations with different access patterns leads to thrashing when we 
> migrate data back and forth on GPU and CPU access. To avoid this we 
> disable HMM migrations for head and stack VMAs.

Wonder how well does it really work in practice? AFAIK "heaps" (malloc())
today uses various arenas obtained by mmap() and not a single brk() managed
space anymore? And programs might be multithreaded, thus have multiple
stacks, while vma_is_stack() will recognize only the initial one...

Vlastimil

> Regards,
>    Felix
> 
> 
> Am 2023-07-12 um 10:42 schrieb Christoph Hellwig:
>> On Wed, Jul 12, 2023 at 10:38:29PM +0800, Kefeng Wang wrote:
>>> Use the helpers to simplify code.
>> Nothing against your addition of a helper, but a GPU driver really
>> should have no business even looking at this information..
>>
>>
> 

