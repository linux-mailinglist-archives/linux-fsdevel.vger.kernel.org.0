Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7DF7B55B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbjJBOnp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbjJBOno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18226AD
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696257775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JyF1pnZ6qkmXa4qXcGzIhipUJOWvJDJpCe2ELEDUqZE=;
        b=Tx/PcI0aIJ6Dj5VWmraIIglYrfDpvJ7WUKFO16hFtZ2Za6O5jmxKHp83Z/tU6x1pOJ10iw
        4QUzpW9Q8zjR7oet9hjTKzR4XfcswZ02QenYP/NBzAxRylQLktHaWkrm8rCfwCfPDqzeYp
        vLqgqA1zydudr1vHgFJ5ev7Y+gobuRo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Z490PUcvOGuZhU-J2HoxVg-1; Mon, 02 Oct 2023 10:42:54 -0400
X-MC-Unique: Z490PUcvOGuZhU-J2HoxVg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40590e6bd67so105632335e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 07:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696257773; x=1696862573;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyF1pnZ6qkmXa4qXcGzIhipUJOWvJDJpCe2ELEDUqZE=;
        b=kFqtVrL6xrb8dyq+vIngDEibnvRs7J3ip2ozBhF2XHmehWLqWCGlf6hdQI3bIpUs3X
         PH0oyJIKsyf8SmPY4mDml5qOyCviDmpD8AOrSHiZuwwmf6PzF2D673LrzLUakXNhRZKA
         l3raAHG8enHit6oYdZudXyVO2u8NC1zwgnrzqxogxBQgaxrCT1km+MmcaVzcWq1sNngc
         +SSssGg4RsZ1YruzEx6gh5wIfX7B1B03yljlerRO9RxEyAUclnbOBPyY17liJ7oybB7O
         9tAvYrb9wejDha/YmypM2tiGy01YQlOzhPvg5KZwCW2cL31JAr/E0MgS/g7WSYTmS//b
         Vg0w==
X-Gm-Message-State: AOJu0YwwqhJLeS72/DHtQpXL7AnBORdgUqs8bUaquQaCtlubMQ5kTy3b
        ukqiBvTJlR9o4Z8xran3V0435L52v2eJnEfFkpFtLMtMuAg0hrb4qiuZg5GhUANAwa0Er965o6b
        osu1GFVzRHqBj8MJisvtVyFGuBA==
X-Received: by 2002:a05:6000:1d0:b0:322:707e:a9fd with SMTP id t16-20020a05600001d000b00322707ea9fdmr8891399wrx.34.1696257772805;
        Mon, 02 Oct 2023 07:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGymUSv8zl2ClRiKwhAr/NLjZAkFh/vu2pxeK/KZTOMETVSkxSO89mrdgd615CqhPnR+vID4A==
X-Received: by 2002:a05:6000:1d0:b0:322:707e:a9fd with SMTP id t16-20020a05600001d000b00322707ea9fdmr8891355wrx.34.1696257772272;
        Mon, 02 Oct 2023 07:42:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d6046000000b003259b068ba6sm7972412wrt.7.2023.10.02.07.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 07:42:51 -0700 (PDT)
Message-ID: <27f177c9-1035-3277-cd62-dc81c12acec4@redhat.com>
Date:   Mon, 2 Oct 2023 16:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] userfaultfd: UFFDIO_REMAP: rmap preparation
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-2-surenb@google.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230923013148.1390521-2-surenb@google.com>
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

On 23.09.23 03:31, Suren Baghdasaryan wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> As far as the rmap code is concerned, UFFDIO_REMAP only alters the
> page->mapping and page->index. It does it while holding the page
> lock. However folio_referenced() is doing rmap walks without taking the
> folio lock first, so folio_lock_anon_vma_read() must be updated to
> re-check that the folio->mapping didn't change after we obtained the
> anon_vma read lock.

I'm curious: why don't we need this for existing users of 
page_move_anon_rmap()? What's special about UFFDIO_REMAP?


-- 
Cheers,

David / dhildenb

