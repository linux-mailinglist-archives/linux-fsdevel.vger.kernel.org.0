Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74074D5001
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 18:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243850AbiCJROP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 12:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiCJROP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:14:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A393717F698
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 09:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646932392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0g7kEPpgKBPzdK7oqMjhrzrQPzP1oj31vajQi/QH0g=;
        b=dlpHnE/4VqpQfLD0xbXP+TWM67zGWfxPibSvjDKrAdzm3wDf2VrKPTmemLnIy74ktXaFYC
        dqGAkVszIY7L4ZwH4lxTdH1l3KNSkUqrkWH6D4cIL1/5xjzFtodmQ5gUX+JgY3cImA1ZwW
        IySKhkmk+APR/MKyZdsTXQF1bg22frI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-psYdEe7dM0GsrvCHErOgHw-1; Thu, 10 Mar 2022 12:13:11 -0500
X-MC-Unique: psYdEe7dM0GsrvCHErOgHw-1
Received: by mail-wr1-f71.google.com with SMTP id a5-20020adfdd05000000b001f023fe32ffso1902340wrm.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 09:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=K0g7kEPpgKBPzdK7oqMjhrzrQPzP1oj31vajQi/QH0g=;
        b=vB/WH3ROyt7vxHMTI/O3OsmJaz1goNGtlA0g0xbFJ41C4e0K0Q9m7PZNxJFyTLMHGz
         c83P98hHblA0+PYOUTpaGxZ8f6Cbx2s0ye7+Ql/FTI2GUx+NEw92n3qdvZU/dkw0VNn5
         pMIoXgmal0ipPTaTDcMTdO9fGbyXIS2tkm2F1Q5thGzj6IPQxOvKeHtDY8kzUE3n1mtT
         bCKoa3kHRwS/RvhSF0WcpK2/3mkyMVHTPXRLpPXmTNWWkvQ78HSby+NRci+wctV9idZI
         b7/HCxOtCV9LobKdrZow8SG/azz/iEtoQKgV10v0x96pNEdmpzgkvkJQautntYyfwFz9
         +omw==
X-Gm-Message-State: AOAM5330Zkf4vBuflYd9EBFaQB6XHecmwkYoJ4RClkTSO/gQOnUZDDse
        21e8s1KE2Z6jBV44g+cYYVzuO49KSGq6718FWxfbkLaobk1hpLjIfF4zVvSdwHg1iX+YKc4bDJ2
        YQ1hH/M+FUfS27O2AU1BX2/LC4w==
X-Received: by 2002:a05:6000:1683:b0:1f1:eb7c:be70 with SMTP id y3-20020a056000168300b001f1eb7cbe70mr4261146wrd.129.1646932390259;
        Thu, 10 Mar 2022 09:13:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3SkTi3yW7UBBeX1DEMnFy33opyiuGAlZsjFfPFWjJgPjyUpAftbHJ/wJhhj/ZTUEnc+Lavw==
X-Received: by 2002:a05:6000:1683:b0:1f1:eb7c:be70 with SMTP id y3-20020a056000168300b001f1eb7cbe70mr4261126wrd.129.1646932389931;
        Thu, 10 Mar 2022 09:13:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:6100:d527:e3ca:6293:8440? (p200300cbc7086100d527e3ca62938440.dip0.t-ipconnect.de. [2003:cb:c708:6100:d527:e3ca:6293:8440])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d564f000000b0020371faf04fsm4545238wrw.67.2022.03.10.09.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 09:13:09 -0800 (PST)
Message-ID: <02b20949-82aa-665a-71ea-5a67c1766785@redhat.com>
Date:   Thu, 10 Mar 2022 18:13:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
 <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
In-Reply-To: <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.03.22 20:27, Linus Torvalds wrote:
> On Tue, Mar 8, 2022 at 9:40 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Hmm. The futex code actually uses "fixup_user_fault()" for this case.
>> Maybe fault_in_safe_writeable() should do that?
> 
> .. paging all the bits back in, I'm reminded that one of the worries
> was "what about large areas".
> 
> But I really think that the solution should be that we limit the size
> of fault_in_safe_writeable() to just a couple of pages.
> 
> Even if you were to fault in gigabytes, page-out can undo it anyway,
> so there is no semantic reason why that function should ever do more
> than a few pages to make sure. There's already even a comment about
> how there's no guarantee that the pages will stay.
> 
> Side note: the current GUP-based fault_in_safe_writeable() is buggy in
> another way anyway: it doesn't work right for stack extending
> accesses.
> 
> So I think the fix for this all might be something like the attached
> (TOTALLY UNTESTED)!
> 
> Comments? Andreas, mind (carefully - maybe it is totally broken and
> does unspeakable acts to your pets) testing this?

I'm late to the party, I agree with the "stack extending accesses" issue
and that using fixup_user_fault() looks "cleaner" than FOLL_TOUCH.


I'm just going to point out that fixup_user_fault() on a per-page basis
is sub-optimal, especially when dealing with something that's PMD- or
PUD-mapped (THP, hugetlb, ...). In contrast, GUP is optimized for that.

So that might be something interesting to look into optimizing in the
future, if relevant in pactice. Not sure how we could return that
information the best way to the caller ("the currently faulted
in/present page ends at address X").

For the time being, the idea LGTM.

-- 
Thanks,

David / dhildenb

