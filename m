Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5828076779C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 23:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjG1Vcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 17:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjG1Vcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E782A3AB3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 14:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690579916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S6lbOkGydlirE9nA3kdmMXZFBN+LXCd5vET/ZOFTDEo=;
        b=fSD4xNR9259Db9typIbMczqpwQJQK+ZY6H8Z7vHiieg/DpAazCiYQ1AlMX9BqNyDqGP7qy
        M7p516meDU8teOx3EDo82ZDEB1efVI78fcz88mTe0xvICjj6RCyuH3iN437LBmuq6xbJdl
        a3NwS4LmpEuDYxGSYDH3NdeGobW3wfg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-2t6Y0bMzO0ywHtM_cUnzOw-1; Fri, 28 Jul 2023 17:31:52 -0400
X-MC-Unique: 2t6Y0bMzO0ywHtM_cUnzOw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc00d7d62cso15134335e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 14:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690579911; x=1691184711;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6lbOkGydlirE9nA3kdmMXZFBN+LXCd5vET/ZOFTDEo=;
        b=BW/OnThUJnpS0V4NFCeyOYYNNo1u8Cj6JbamD3+HLUhlRw5A5oCxjvOJHH/D492t6k
         W6CDP3Ol22XjGTEFi5omvmL4mODFDIL4cM6hPPvHCp3oi5BI3yUfth2/2cXu3Ikpszts
         YuGxi+oMAzsbcf4oQofgXSB8ZDWUsnu2QHWWPo08Hu2PtHuzW8W/+e/jGJTQaqLrH3aK
         fSaptZC5Y6CTsToXL7GFip4/6H24VfLaJmy0KSiA+irYjbbT+MTorzLSo5wk+rDLcgsD
         PHiXQNztBKYmnnRgcBsBo1boYkJR91bVrq6I4NXqmTBYHs+FphDyjopJud0BQSfWaGUz
         mnfg==
X-Gm-Message-State: ABy/qLYFcE/l5cinvw4ur7nixbRu9x8SxHuGGb/hyakcxF4GGyT1nx8Y
        XHdwAx+YFv/ghXGZRysSa8vUrgYLRsyt8Te7/YhdX6VCXwP3AyGyasbwoEPu/ePRxsrIQBXG/5G
        237Wqi6mXsmRKLfQRbGpuPG1feQ==
X-Received: by 2002:a7b:cd95:0:b0:3fc:92:73d6 with SMTP id y21-20020a7bcd95000000b003fc009273d6mr2621794wmj.11.1690579911127;
        Fri, 28 Jul 2023 14:31:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGEmQpF8Yul3mD8s5S8bvwWjm0+sgBoWmTFYFiAx780XZFTCm0bK5IQyqZa/Pqk+guYrETtoA==
X-Received: by 2002:a7b:cd95:0:b0:3fc:92:73d6 with SMTP id y21-20020a7bcd95000000b003fc009273d6mr2621779wmj.11.1690579910792;
        Fri, 28 Jul 2023 14:31:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id f14-20020a7bcd0e000000b003fba94c9e18sm5097861wmj.4.2023.07.28.14.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 14:31:50 -0700 (PDT)
Message-ID: <22262495-c92c-20fa-dddf-eee4ce635b12@redhat.com>
Date:   Fri, 28 Jul 2023 23:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <ZMQZfn/hUURmfqWN@x1n>
 <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
 <e74b735e-56c8-8e62-976f-f448f7d4370c@redhat.com>
 <CAHk-=wgG1kfPR6vtA2W8DMFOSSVMOhKz1_w5bwUn4_QxyYHnTA@mail.gmail.com>
 <69a5f457-63b6-2d4f-e5c0-4b3de1e6c9f1@redhat.com> <ZMQxNzDcYTQRjWNh@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
In-Reply-To: <ZMQxNzDcYTQRjWNh@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.07.23 23:20, Peter Xu wrote:
> On Fri, Jul 28, 2023 at 11:02:46PM +0200, David Hildenbrand wrote:
>> Can we get a simple revert in first (without that FOLL_FORCE special casing
>> and ideally with a better name) to handle stable backports, and I'll
>> follow-up with more documentation and letting GUP callers pass in that flag
>> instead?
>>
>> That would help a lot. Then we also have more time to let that "move it to
>> GUP callers" mature a bit in -next, to see if we find any surprises?
> 
> As I raised my concern over the other thread, I still worry numa users can
> be affected by this change. After all, numa isn't so uncommon to me, at
> least fedora / rhel as CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y. I highly
> suspect that's also true to major distros.  Meanwhile all kernel modules
> use gup..
> 
> I'd say we can go ahead and try if we want, but I really don't know why
> that helps in any form to move it to the callers.. with the risk of
> breaking someone.
> 

Indeed, that's why I suggest to be a bit careful, especially with stable.

> Logically it should also be always better to migrate earlier than later,
> not only because the page will be local earlier, but also per I discussed
> also in the other thread (that the gup can hold a ref to the page, and it
> could potentially stop numa balancing to succeed later).

I get your point, but I also see the following cases (QEMU/KVM as example):

* User space triggers O_DIRECT. It will be short-lived. But is it really
   an access from that CPU (NUMA node) to that page? At least for KVM,
   you much rather want to let KVM trigger the NUMA fault on actual
   memory access from a guest VCPU, not from a QEMU iothread when pinning
   the page?

* vfio triggers FOLL_PIN|FOLL_LONGTERM from a random QEMU thread.
   Where should we migrate that page to? Would it actually be counter-
   productive to migrate it to the NUMA node of the setup thread? The
   longterm pin will turn the page unmovable, yes, but where to migrate
   it to?

-- 
Cheers,

David / dhildenb

