Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92E06E4678
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 13:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjDQLaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 07:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjDQLaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669824C28
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 04:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681730838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVc9uxy2kIdreOR/jYYEkHBdj+2RYiJitTncQTj92Ak=;
        b=NanM95DIf6UqjG2Vx5RF7ykf0oZmfTs/2USLb19AXJCGj+zVOHGy9cSV2QghmE+K5qo87U
        qzqBOFXZ0PgBHYGDwQ5N3yrClRiR7CQFCcnmMLRBQX91F/5zVnjiYosuoqmja2QAitRaHU
        LDcF0eQkZnNUwADKchhrd4Jv61QWPi0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-k8FIX2EhO9qO2vFA8DzSYg-1; Mon, 17 Apr 2023 07:01:22 -0400
X-MC-Unique: k8FIX2EhO9qO2vFA8DzSYg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2efbab2e7ffso389707f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 04:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681729281; x=1684321281;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVc9uxy2kIdreOR/jYYEkHBdj+2RYiJitTncQTj92Ak=;
        b=YHJnD+U4CFABqPwb8vXyqVdUua4UwO5UbUetpPhkdDmQ+k962iClPNYCxWy77qxXN1
         uJbdmZ8y15Bymjsu/pBiD4ok7AZQnVuK3wZIbtpju29rSfa1HUYSRMXwR3LfEmqN3u1a
         flEyO7If+PRqcuiv/eA2Jdg6DWQjwP3sYw6DtnG0MkTzz5j0zbWsIIAyv2LQcNQdCjeA
         YaIrXamBwD0XeYuTHiU7JsuQ6pw0wWLGSjIac47TpL3KEH3Y8+DO+JdRc1hXdBqQa2oo
         frv6znXALU/8Bntfwc10jz6m23fImlip8sdzcKbrbXEUd56rip1kDMA0foO4rEyub58M
         XFoA==
X-Gm-Message-State: AAQBX9edQengxmqtqrMpj9ahL1P0CZ8R9Pv3N7wqz84pQg5mHNZ9gDF/
        p15FOfzBysxbTvERfYpu3O3eQrzy/UoZBK77OWcieZ9qCCWe4OziFN47yQTWsqsX398MtK13gfl
        dVbRydn1lqo11n5OfzLgqLa3yyg==
X-Received: by 2002:a05:6000:1376:b0:2f7:fb78:9694 with SMTP id q22-20020a056000137600b002f7fb789694mr5066259wrz.17.1681729281617;
        Mon, 17 Apr 2023 04:01:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZQIa4sVrexrjBGWt+x2dl05vD2C7OxIO4qZKWXoX9kbiyotAMI/EdKnSlVTtQjGuOSPjILbQ==
X-Received: by 2002:a05:6000:1376:b0:2f7:fb78:9694 with SMTP id q22-20020a056000137600b002f7fb789694mr5066215wrz.17.1681729280958;
        Mon, 17 Apr 2023 04:01:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d4fcc000000b002f22c44e974sm10214704wrw.102.2023.04.17.04.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 04:01:20 -0700 (PDT)
Message-ID: <8a323d9f-f54e-065d-d611-0a07aea170c8@redhat.com>
Date:   Mon, 17 Apr 2023 13:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 3/7] mm/gup: remove vmas parameter from
 get_user_pages_remote()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1681558407.git.lstoakes@gmail.com>
 <523f0764f4979276a6d4b89cbad9af9124e4bf0a.1681558407.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <523f0764f4979276a6d4b89cbad9af9124e4bf0a.1681558407.git.lstoakes@gmail.com>
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

On 15.04.23 14:09, Lorenzo Stoakes wrote:
> The only instances of get_user_pages_remote() invocations which used the
> vmas parameter were for a single page which can instead simply look up the
> VMA directly. In particular:-
> 
> - __update_ref_ctr() looked up the VMA but did nothing with it so we simply
>    remove it.
> 
> - __access_remote_vm() was already using vma_lookup() when the original
>    lookup failed so by doing the lookup directly this also de-duplicates the
>    code.
> 
> This forms part of a broader set of patches intended to eliminate the vmas
> parameter altogether.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---

I guess we should never drop the mmap lock temporarily in these cases, 
so it's fine.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

