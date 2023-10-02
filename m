Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FEC7B5921
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjJBRbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 13:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjJBRbd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2846D9
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 10:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696267840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Zv0IPJYzYkiErG2s6ydEpQAC8u1zC0W3lAo3suRrzY=;
        b=Oxn3zN+OxXJbPXNgHVQeWgFskNZtAygEb95VEtl8YLUyZ53UbsmGYFqbbB9a+CmT+voT05
        /AULt6jQGfwXYKLZmczfxbBuegdrOedukv/0Dl960hSyQPXlUF1SWs2xm5PFEJx7HzET0G
        JHQ2iKT69wc+kw2/qEqdnOY7CrAy9L4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-Qpk7EfdWMkyahtHNj1_Qvg-1; Mon, 02 Oct 2023 13:30:38 -0400
X-MC-Unique: Qpk7EfdWMkyahtHNj1_Qvg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32661ca30d9so49827f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 10:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696267837; x=1696872637;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Zv0IPJYzYkiErG2s6ydEpQAC8u1zC0W3lAo3suRrzY=;
        b=ueqI8KDTqgL0z3IF+E1itAthh4kcIn1cccYYNSK3goavgaxuSs7fp7tP0TpurwaVUX
         99GbRYjbtCRu4sDPPSZElZHKZUC6Kp9tWsTPx3YAv7q+CUyREzY4wskG7iVXJutk+BQe
         e/mX7SrxkslvhR1d7AxW/rfX+2IX3/KZOhZs9DhE1BhzAfIfgbh788HFaoRI7w687PwI
         YETMq3KLpr1MIMogfhjf3u7bjor0YNT+/hIRVU/pK+KGkKfuMvIQ0zc74GkhUJlolFDl
         CB9+HebWGM222q1acIYkf+oozfsTBNnBX5u80aRf/3X/dWmF1M1Vxgca02O12lC/G7Gv
         ByKg==
X-Gm-Message-State: AOJu0Yw8497hZEXTkQd7TbVuFfY0kpScD+ZGO5UZulnd8c7ZuPOQJnZJ
        1onuu2tW+gyznwLUeiWf4hYGPBOFd2jzbJi5YktiNPV8FgCS9ncKzw3NnSYmaa1lTQ9lFIY6WJC
        /U802oF3obuZrfAabHdEavLNo2A==
X-Received: by 2002:a5d:448c:0:b0:321:4d1c:425f with SMTP id j12-20020a5d448c000000b003214d1c425fmr10461728wrq.47.1696267837288;
        Mon, 02 Oct 2023 10:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1s/Oh/sK26P/qhtJnkQ9pABgb0+Kto2RYoGCs5kChT5kKPuRRCO3dybkxiXNrHhCDhqfXMQ==
X-Received: by 2002:a5d:448c:0:b0:321:4d1c:425f with SMTP id j12-20020a5d448c000000b003214d1c425fmr10461690wrq.47.1696267836848;
        Mon, 02 Oct 2023 10:30:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id r17-20020adfda51000000b00327c79ca7c6sm3612731wrl.80.2023.10.02.10.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 10:30:36 -0700 (PDT)
Message-ID: <e5d41fbe-a91b-9491-7b93-733f67e75a54@redhat.com>
Date:   Mon, 2 Oct 2023 19:30:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To:     Peter Xu <peterx@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-2-surenb@google.com>
 <27f177c9-1035-3277-cd62-dc81c12acec4@redhat.com> <ZRrgWVgjVfQu4RGX@x1n>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/3] userfaultfd: UFFDIO_REMAP: rmap preparation
In-Reply-To: <ZRrgWVgjVfQu4RGX@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.10.23 17:23, Peter Xu wrote:
> On Mon, Oct 02, 2023 at 04:42:50PM +0200, David Hildenbrand wrote:
>> On 23.09.23 03:31, Suren Baghdasaryan wrote:
>>> From: Andrea Arcangeli <aarcange@redhat.com>
>>>
>>> As far as the rmap code is concerned, UFFDIO_REMAP only alters the
>>> page->mapping and page->index. It does it while holding the page
>>> lock. However folio_referenced() is doing rmap walks without taking the
>>> folio lock first, so folio_lock_anon_vma_read() must be updated to
>>> re-check that the folio->mapping didn't change after we obtained the
>>> anon_vma read lock.
>>
>> I'm curious: why don't we need this for existing users of
>> page_move_anon_rmap()? What's special about UFFDIO_REMAP?
> 
> Totally no expert on anon vma so I'm prone to errors, but IIUC the
> difference here is root anon vma cannot change in page_move_anon_rmap(),
> while UFFDIO_REMAP can.

That does sound reasonable, thanks.

Probably we can do better with the patch description (once [1] is used 
to move the folio to the other anon_vma).

"mm/rmap: support move to different root anon_vma in folio_move_anon_rmap()

For now, folio_move_anon_rmap() was only used to move a folio to a 
different anon_vma after fork(), whereby the root anon_vma stayed 
unchanged. For that, it was sufficient to hold the page lock when 
calling folio_move_anon_rmap().

However, we want to make use of folio_move_anon_rmap() to move folios 
between VMAs that have a different root anon_vma. As folio_referenced() 
performs an RMAP walk without holding the page lock but only holding the 
anon_vma in read mode, holding the page lock is insufficient.

When moving to an anon_vma with a different root anon_vma, we'll have to 
hold both, the page lock and the anon_vma lock in write mode. 
Consequently, whenever we succeeded in folio_lock_anon_vma_read() to 
read-lock the anon_vma, we have to re-check if the mapping was changed 
in the meantime. If that was the case, we have to retry.

Note that folio_move_anon_rmap() must only be called if the anon page is 
exclusive to a process, and must not be called on KSM folios.

This is a preparation for UFFDIO_REMAP, which will hold the page lock, 
the anon_vma lock in write mode, and the mmap_lock in read mode.
"

In addition, we should document these locking details for 
folio_move_anon_rmap() and probably not mention UFFDIO_REMAP in the 
comment in folio_lock_anon_vma_read(), but instead say 
"folio_move_anon_rmap() might have changed the anon_vma as we might not 
hold the page lock here."


[1] https://lkml.kernel.org/r/20231002142949.235104-3-david@redhat.com

-- 
Cheers,

David / dhildenb

