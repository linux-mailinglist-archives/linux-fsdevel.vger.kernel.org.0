Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE8E6E0C5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 13:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDMLVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDMLVo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928454217
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 04:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681384863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jSfTt/FpZ51XsXOxa366XVa7DCOmNmyBB//s/oWzTsk=;
        b=JDOOxtWbitDg6ieKXAAtF1fKPzvtcwi5u7mhzpeUSH/kuacWvPM1GRBQzKKEHtQUgTdCh3
        /WPG9Fd115PYJOCRVcneUMcynSWcYdlBKtFPlI2zJDftCkf6fEycJ/2OsLZOci3dM0Itce
        iHtzY1nRR3+avE0TUsvBOKTQN4F5QiQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-SdaylSguO5y1L_H8XNS9jQ-1; Thu, 13 Apr 2023 07:21:02 -0400
X-MC-Unique: SdaylSguO5y1L_H8XNS9jQ-1
Received: by mail-wm1-f69.google.com with SMTP id ay4-20020a05600c1e0400b003f0ad935168so242679wmb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 04:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681384861; x=1683976861;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSfTt/FpZ51XsXOxa366XVa7DCOmNmyBB//s/oWzTsk=;
        b=WBGn2Ff2gY+03lC8NmXfA+W9QJqo2svDyS/pD35FLx16i9bKzTIZCHHTrByl4BuxMN
         4soQ9m8sd0bklgTyJ5Efms9Tg+JlU6eTmPTKeOKhcjurzIdxZJcrueNi8FJDqh4MHMqX
         cIyl7nEjN/ghhHxi3VLPNb9+RKg1jiR45Tg2TTd9k+NPJz9dzFB7t6seEPkBP2/SKKwN
         uC/PwAgs3Y82GZ2aOom+kvskG7PxkU/SGsWZ6nJkYSldcsWGMiykK9XkB4MmyOeLwMMN
         iA195zLgvfR8ijbqKexUX3wXw1G7CapjHZ9IJ+idp3hkWV3K57alTZY0ayt4dpUtCb1L
         D6vg==
X-Gm-Message-State: AAQBX9d/MAatHHt7+rQJsWbzL2FlwemInfak7UBY2/sZVQnRZN7CvTSo
        6yVuTdCF43lXXAuLRbs/i/WmUJV9HgRzL8WPk82MiOw4Ou4YKeFDtBRdFD9e6bhD602i3U8Z28o
        MahL16SOm63N/vHbZiGcnLDWi5g==
X-Received: by 2002:a5d:4748:0:b0:2f4:bc68:3493 with SMTP id o8-20020a5d4748000000b002f4bc683493mr1179292wrs.34.1681384861480;
        Thu, 13 Apr 2023 04:21:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350aqjI6Q+vFzM2qin74WRIRynSqW3dUlzZ+lzWRnT/FaK8OWoaXuG4EWNsNhSjPY7wORElSWBA==
X-Received: by 2002:a5d:4748:0:b0:2f4:bc68:3493 with SMTP id o8-20020a5d4748000000b002f4bc683493mr1179271wrs.34.1681384861121;
        Thu, 13 Apr 2023 04:21:01 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id f4-20020adff584000000b002f008477522sm1086917wro.24.2023.04.13.04.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:21:00 -0700 (PDT)
Message-ID: <b7fe839d-d914-80f7-6b96-f5f3a9d0c9b0@redhat.com>
Date:   Thu, 13 Apr 2023 13:20:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 3/3] mm: vmscan: refactor updating
 current->reclaim_state
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20230413104034.1086717-1-yosryahmed@google.com>
 <20230413104034.1086717-4-yosryahmed@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230413104034.1086717-4-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.04.23 12:40, Yosry Ahmed wrote:
> During reclaim, we keep track of pages reclaimed from other means than
> LRU-based reclaim through scan_control->reclaim_state->reclaimed_slab,
> which we stash a pointer to in current task_struct.
> 
> However, we keep track of more than just reclaimed slab pages through
> this. We also use it for clean file pages dropped through pruned inodes,
> and xfs buffer pages freed. Rename reclaimed_slab to reclaimed, and add

Would "reclaimed_non_lru" be more expressive? Then,

mm_account_reclaimed_pages() -> mm_account_non_lru_reclaimed_pages()


Apart from that LGTM.

-- 
Thanks,

David / dhildenb

