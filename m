Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33194D1F63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 18:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349253AbiCHRtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 12:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349246AbiCHRs6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:48:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F06F48316
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 09:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646761680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FakVQP6MiE/Zi0gwIeYZLkyYTc78bBZSuWUh+KCXbNw=;
        b=bkI/8vsdbf5tHIN9D31azGMqzZ6vgbXJjyaMDy2KzrEbwwihMdev6daB9f+2H82Hx5ntqG
        3byqYnlK+ZKHufoTdCMrZsrDF7A7gyYiWNvop06FF/sS36pll7hjhK2m1SezGU8NRhkFQQ
        7yjoFi8Ylar7Pzt13DmV80R0LUuQbqw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-xmqNy2kiMgOPHr3WqOQYcQ-1; Tue, 08 Mar 2022 12:47:59 -0500
X-MC-Unique: xmqNy2kiMgOPHr3WqOQYcQ-1
Received: by mail-wr1-f70.google.com with SMTP id a5-20020adfdd05000000b001f023fe32ffso5698021wrm.18
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 09:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=FakVQP6MiE/Zi0gwIeYZLkyYTc78bBZSuWUh+KCXbNw=;
        b=d4TLdckEIxq107BrTVW7C7GvOwYlfu0387PDCzsoDcSHvDk28LhxNKpqFH/NW8shJJ
         xgvGOkD3tWh96uM59RMrjyIXes3zA+fgprV4R3sFQLuDGINsjBhVQVZYjKlja1KYg0aN
         accg1saG186NugphI8BN37F6NxE8P70W3h/+sYxk2Em3LOFmQX/oVrZM70uY8mi1rkR9
         rHiVYBEbUAuxsOcI3lQrIcFhBzrwYpFau2cnPdooHT75zoJ/mnDwV7YGjJeOGIgOOY00
         yq2yzA5RLgL3ZFD57/ZHYDGybSMyh3WSySYgPY8w6yChpgF21Of2mZAtI+b+3AE5BFLB
         jEqw==
X-Gm-Message-State: AOAM5315rTtd0RLfb+5BJ1QGxQ5hA7crwKi3H4d7nx5aAgVZKy0fVCv+
        +0hyBqhN4nyKeXYdw5XKUJCdeZaVuyQ7oga4YNLKTslRwuo+/VbDZrrZw99fmb3Ow7dDplCgjSa
        HB3pA+u+JrWg2d8dnm+0Ejv/scw==
X-Received: by 2002:a5d:4487:0:b0:1f1:232b:794f with SMTP id j7-20020a5d4487000000b001f1232b794fmr13637145wrq.715.1646761677979;
        Tue, 08 Mar 2022 09:47:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSc5uWGLBJT5WFw8W0WWnMeFJYAnXme99qyz4GnTqJ1cWsvoBhhkzFi7FmWm0wZEHWPxW2pQ==
X-Received: by 2002:a5d:4487:0:b0:1f1:232b:794f with SMTP id j7-20020a5d4487000000b001f1232b794fmr13637130wrq.715.1646761677718;
        Tue, 08 Mar 2022 09:47:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:b000:acda:b420:16aa:6b67? (p200300cbc708b000acdab42016aa6b67.dip0.t-ipconnect.de. [2003:cb:c708:b000:acda:b420:16aa:6b67])
        by smtp.gmail.com with ESMTPSA id z2-20020a056000110200b001e7140ddb44sm14380253wrw.49.2022.03.08.09.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:47:57 -0800 (PST)
Message-ID: <6614d129-7635-5908-bab4-bb1f121e1742@redhat.com>
Date:   Tue, 8 Mar 2022 18:47:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
In-Reply-To: <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
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

On 08.03.22 18:26, Linus Torvalds wrote:
> On Tue, Mar 8, 2022 at 12:21 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> As raised offline already, I suspect
>>
>> shrink_active_list()
>> ->page_referenced()
>>  ->page_referenced_one()
>>   ->ptep_clear_flush_young_notify()
>>    ->ptep_clear_flush_young()
>>
>> which results on s390x in:
>>
>> static inline pte_t pte_mkold(pte_t pte)
>> {
>>         pte_val(pte) &= ~_PAGE_YOUNG;
>>         pte_val(pte) |= _PAGE_INVALID;
>>         return pte;
>> }
> 
> Yeah, that looks likely.
> 
> It looks to me like GUP just doesn't care about _PAGE_INVALID on s390,
> and happily looks up that page despite it not being "present" as far
> as hardware is concerned.
> 
> Your actual patch looks pretty nasty, though. We avoid marking it
> accessed on purpose (to avoid atomicity issues wrt hw-dirty bits etc),
> but still, that patch makes me go "there has to be a better way".

It certainly only works if we don't have hw dirty bits that might get
set concurrently -- for example, on s390x there is no such requirement.

As raised by Gerald, arch_faults_for_dirty_pte (and existing
arch_faults_on_old_pte) might be one option to get rid of the s390x
special-casing, and detect any arch that might update the dirty bit
concurrently.

Interestingly, mm/huge_memory.c:touch_pmd() doesn't seem to care about
concurrent dirty-bit updates by the hardware. Hmm.

But, of course, I'm open for alternatives, maybe we could adjust
fault_in_safe_writeable() to not use GUP as raised by you in the other
reply.

-- 
Thanks,

David / dhildenb

