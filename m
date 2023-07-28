Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89D7676FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 22:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjG1Uei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 16:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjG1Ueg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B59423B
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690576432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPoM804CxQXNyaqYOi76F9KayN7Vk1JGyDtsJtbRViY=;
        b=HahAFVaO/3KqYT+rdbVpmuS0X6b0lQstZJYvEMl5R0AD8wVByxcEq+DjR48AvRIjWdvHi2
        /NSFcCWXbz1HC6F/Yb5Psx6B3aMA/slrNI/J9qfB19JsoDt/uV2rvbRtQuhq6E9p7cEbNk
        IjwRn3JIZcecd7CLS/+kyLHNgNgi5sg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-83ae31T8OySS-QU2ncob2w-1; Fri, 28 Jul 2023 16:33:50 -0400
X-MC-Unique: 83ae31T8OySS-QU2ncob2w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbb0fdd060so15046035e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 13:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690576429; x=1691181229;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPoM804CxQXNyaqYOi76F9KayN7Vk1JGyDtsJtbRViY=;
        b=eoha69f8gyjcn1CvVKSNMU6cQg2fO/mfFDBSiusgjcPC7GMAuc8TXWFWQXKzr4eS5x
         bj+8mZkdJNwZrQ0tMngdWQLNOOhzZy/j/44Ltmh+rTVW7dLLd3hiS7ygHa2Uji7qAyHp
         R783EbyTfYWGyus2l530+/4hFRJq7WjjrDFckH+NNYolqxh/iP0OmxWs8IB0z0VCMQCd
         08gcTVoOCUITfz9rHT46Dmx58cileE/CRzBMRbTY9DfZ2+xAZpKRGBkWQc2yzPOoX5Nf
         w9+/vpX/KsrxCm5nez9gNBKuTGw5CFKaHOrH/9kQowecEoZaL3nEYhYnKrUKjvCPQbvx
         J9Rw==
X-Gm-Message-State: ABy/qLZIsd+MB4/HNl32E0r7A4OUX67hTwg4dBQa5i525E5dB4T3Ifqs
        lIhi/d8cy7WgEm77D7RDGT1S+cpTUOKY3JCse/61PJucr1AY7yXuY3xBUASdyfPK2bXm2Iw3IW0
        8+Qyt+ejllcbICwjEzC0ba1XQkw==
X-Received: by 2002:a05:600c:210b:b0:3fb:fb88:974b with SMTP id u11-20020a05600c210b00b003fbfb88974bmr2633204wml.6.1690576429286;
        Fri, 28 Jul 2023 13:33:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE0EWcwQHpVt4+4O+ITavcaEd7PJtizFZdLzot0OrKUsQ+DOTY++M7GZKjU+qSoarDGlXFOaA==
X-Received: by 2002:a05:600c:210b:b0:3fb:fb88:974b with SMTP id u11-20020a05600c210b00b003fbfb88974bmr2633190wml.6.1690576428946;
        Fri, 28 Jul 2023 13:33:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id v25-20020a05600c215900b003fc02a410d0sm7630531wml.48.2023.07.28.13.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 13:33:48 -0700 (PDT)
Message-ID: <e74b735e-56c8-8e62-976f-f448f7d4370c@redhat.com>
Date:   Fri, 28 Jul 2023 22:33:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
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

On 28.07.23 22:23, Linus Torvalds wrote:
> On Fri, 28 Jul 2023 at 12:39, Peter Xu <peterx@redhat.com> wrote:
>>
>> But then does it means that any gup-only user will have numa balancing
>> completely disabled?
> 
> Why would we ever care about a GUP-only user?
> 
> Who knows where the actual access is coming from? It might be some
> device that is on a different node entirely.
> 
> And even if the access is local from the CPU, it
> 
>   (a) might have happened after we moved somewhere else
> 
>   (b) who cares about the extra possible NUMA overhead when we just
> wasted *thousands* of cycles on GUP?
> 
> So NUMA balancing really doesn't seem to make sense for GUP anyway as
> far as I can see.

I do agree regarding many GUP users.

But at least for KVM (and probably some others, but most probably KVM is 
the most important GUP user) it does make sense and we have to find a 
way to keep that working.

At least, removing it creates significantly more harm than having it, 
guaranteed :)

So would you rather favor a FOLL_NUMA that has to be passed from the 
outside by selected callers or a FOLL_NUMA that is set on the GUP path 
unconditionally (but left clear for follow_page())?

-- 
Cheers,

David / dhildenb

