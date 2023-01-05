Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D265E74A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 10:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjAEJF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 04:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjAEJE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:04:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95C45007E
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jan 2023 01:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672909458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gex+QnT4hwAgx1h+eIu+UAUxgiKZCLZj1HYsXCJOojw=;
        b=AYDB/l8TYguoSYKipoxsM+sVa/SS1MNZph/gsP+GDLE+r8NkQUU8gFdD7SBbdpVGPlRECN
        9nXqs6I2Ng7vnwtKrT3lSq/xyUxG40c1yOWPC6lWk0nZ0L6dZFmQLywdXgxSzbaPFoJ9AJ
        Qd2E1516V9wM1Z/F5qDw3q+74R73WZg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-74-oWctyFn4PVGTWthmg4PQSQ-1; Thu, 05 Jan 2023 04:04:17 -0500
X-MC-Unique: oWctyFn4PVGTWthmg4PQSQ-1
Received: by mail-wm1-f72.google.com with SMTP id fl12-20020a05600c0b8c00b003d96f0a7f36so18000218wmb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jan 2023 01:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gex+QnT4hwAgx1h+eIu+UAUxgiKZCLZj1HYsXCJOojw=;
        b=uvsBZaNvCe8p8KcITF1Mr6wvEOu9eiXlAPKTr0Ud3NRdjJcucbdnX+jMlqGnjtiVXK
         UGjQB/zC1Aqqj4NNJLYnc452oU3qh2cYs+KwYPkVNIdphAlqtYSUgR7io9iNZB7kZ2mJ
         GGcpizdgClZIAvo7b3kO1CznJvtJnJKItgcdp9hAv7jMIBQGTZ+UFNew8Cp4TmHXbq6q
         /7cT+oua0RcqKzuJL25PcJK7OePwf1tEIRUN6RwpJzSuU1DuvxGohKom2mhVt7ouHFVG
         Tpdi9moJt68UmqlP2OdeNSZxxzFhFyKat62Ylt8jUWg8M0iY4NMNAT1niXkQFA5oHk+L
         cPzQ==
X-Gm-Message-State: AFqh2kpiBaeptxnLH5FmHgPvFbmdQbk+GjqIGDthRom5yWsRrpyHx6k9
        +NyQNFFizkvpevRu3hfnJA58m0CTcXsaGwcpyzjsGo9wBdkSu18fbqRSbNUqt//fzzYnsgQYWcb
        IdBzKx3gbrdOXSmL0qlogzoiMYA==
X-Received: by 2002:a05:600c:3d11:b0:3cf:8b22:76b3 with SMTP id bh17-20020a05600c3d1100b003cf8b2276b3mr36164750wmb.0.1672909456589;
        Thu, 05 Jan 2023 01:04:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvE4YV6gmwoMdYh7/YQCeNZ3S6PGe2qC4e43M/dqNDy8OkC6hj8sgg2g/J5YgDEpskNAkF9hw==
X-Received: by 2002:a05:600c:3d11:b0:3cf:8b22:76b3 with SMTP id bh17-20020a05600c3d1100b003cf8b2276b3mr36164714wmb.0.1672909456272;
        Thu, 05 Jan 2023 01:04:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id n126-20020a1ca484000000b003d21759db42sm1717113wme.5.2023.01.05.01.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 01:04:15 -0800 (PST)
Message-ID: <ccbd7330-b7d7-9048-b49a-80f904353c21@redhat.com>
Date:   Thu, 5 Jan 2023 10:04:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/1] mm: fix vma->anon_name memory leak for anonymous
 shmem VMAs
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     hughd@google.com, hannes@cmpxchg.org, vincent.whitchurch@axis.com,
        seanjc@google.com, rppt@kernel.org, shy828301@gmail.com,
        pasha.tatashin@soleen.com, paul.gortmaker@windriver.com,
        peterx@redhat.com, vbabka@suse.cz, Liam.Howlett@Oracle.com,
        ccross@google.com, willy@infradead.org, arnd@arndb.de,
        cgel.zte@gmail.com, yuzhao@google.com, bagasdotme@gmail.com,
        suleiman@google.com, steven@liquorix.net, heftig@archlinux.org,
        cuigaosheng1@huawei.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
References: <20230105000241.1450843-1-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230105000241.1450843-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.01.23 01:02, Suren Baghdasaryan wrote:
> free_anon_vma_name() is missing a check for anonymous shmem VMA which
> leads to a memory leak due to refcount not being dropped.  Fix this by
> calling anon_vma_name_put() unconditionally. It will free vma->anon_name
> whenever it's non-NULL.
> 
> Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reported-by: syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

