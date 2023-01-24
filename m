Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865E067A0C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 19:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjAXSCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 13:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjAXSCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:02:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B755648A1B
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 10:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674583314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4GsIE1GSxlV0HQh0Yz88+Hk9WYYpPDJ0PT4qaQWpMU=;
        b=dvl1MoVjInFntnyZapQluV/B/M0DDxcnRIvM11hwh6ghXRSCYp8jMuj1xPSILzfh5Ci90i
        b4KRunW+IectH+ojRL3Dd4YTEXrbZ0iUDHAvIvX6XZZEw90KOtGII8Z5/KSS2l1W9iL8V/
        +eQVEi3jQ/cjHqgVb1rYmOH6casnDX0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-amoahMBYMW21GTEM_NgxmQ-1; Tue, 24 Jan 2023 13:01:52 -0500
X-MC-Unique: amoahMBYMW21GTEM_NgxmQ-1
Received: by mail-wr1-f69.google.com with SMTP id o15-20020a5d684f000000b002be540246e1so2231234wrw.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 10:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4GsIE1GSxlV0HQh0Yz88+Hk9WYYpPDJ0PT4qaQWpMU=;
        b=cmDmU7QynidQj1aKTMVLCu0Qr6aEsdZIgkqdC5AaQ4C7Kpmv1/cklfTEyc0nqhj8Aj
         VZBmTl8o1J7quq+4w9YZkivg0BPsnp4/vmEifOsrrqhNRa2G8qn77ULqzf09ei1U08uH
         uAJTme5o21x4Nh0+DVsCNqxxY+dh0UgEz2mu1dwQtl7KIW2Pg+pFfYmU7qVqm85ZaJYX
         ruJHdVFURYLZNJ3QJu7lHfFNc9IZuLSn4otJoQEj26mks7IhsW91urOR/8lzYHnUQHG+
         HZWakGnDtpAV/VUCS3snJZ1ZiqMu5HyROx3QqKXX7+VSMadwSnhW/DV/8RVsLKPu3zze
         wCJw==
X-Gm-Message-State: AO0yUKWOhjMnmCHNrCxTqdhcE3aCcH6Yo1rCF+Iva23HGAQa4qrRoasa
        qat+1lc/1AmlzERQBX5ICk6aGXD8cAZUQCftSFS7B6hm+h6p54vGpJJO7HXu27nnEuoDaUwvcuc
        wmAKrU8JMpYQ0QDZ8aYeNz+HJrQ==
X-Received: by 2002:a5d:4685:0:b0:2bf:ae16:98f4 with SMTP id u5-20020a5d4685000000b002bfae1698f4mr3118747wrq.30.1674583310936;
        Tue, 24 Jan 2023 10:01:50 -0800 (PST)
X-Google-Smtp-Source: AK7set+f/wEQyb7wiJGifDkW4tcgmJixb8037hpkHxzpE8CVSRS/wpQrWTf9+ZFjZ9BMojqBqe5nlA==
X-Received: by 2002:a5d:4685:0:b0:2bf:ae16:98f4 with SMTP id u5-20020a5d4685000000b002bfae1698f4mr3118719wrq.30.1674583310617;
        Tue, 24 Jan 2023 10:01:50 -0800 (PST)
Received: from [192.168.3.108] (p5b0c62c4.dip0.t-ipconnect.de. [91.12.98.196])
        by smtp.gmail.com with ESMTPSA id q6-20020adff946000000b002bdd155ca4dsm2410577wrr.48.2023.01.24.10.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 10:01:49 -0800 (PST)
Message-ID: <a391e98c-88af-886c-0426-c41c9980afa1@redhat.com>
Date:   Tue, 24 Jan 2023 19:01:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, CGEL <cgel.zte@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>
References: <20230123173748.1734238-1-shr@devkernel.io>
 <5844ee9f-1992-a62a-2141-3b694a1e1915@redhat.com>
 <qvqwbkmnj014.fsf@dev0134.prn3.facebook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RESEND RFC PATCH v1 00/20] mm: process/cgroup ksm support
In-Reply-To: <qvqwbkmnj014.fsf@dev0134.prn3.facebook.com>
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

[...]

>> I'm going to point out the security aspect, and that e.g., Windows used to
>> enable it system-wide before getting taught by security experts otherwise.
>> Details on KSM and security aspects can be found in that thread.
>>
> If I'm not mistaken the security aspect exists today. When KSM is
> enabled with madvise this is the same.

Yes, and we mostly only use it for virtual machines -- and to be 
precise, guest memory only -- where it has to be enabled explicitly on a 
well documented basis ...

Impossible for an admin to force it on other parts of the hypervisor 
process that might be more security sensitive. Or on other arbitrary 
applications, for now.

> 
>> Long story short: one has to be very careful with that and only enable it for
>> very carefully selected worklads. Letting a workload opt-in on a VMA level is
>> most probably safer than an admin blindly turning this on for random processes
>> ... >>
[...]

>>
>> [1] https://lore.kernel.org/all/20220517092701.1662641-1-xu.xin16@zte.com.cn/
>> [2] https://lore.kernel.org/all/20220609055658.703472-1-xu.xin16@zte.com.cn/
>>
> My understanding is that there were problems with the patch and how it
> exposed KSM. The other objection was the enable-all configuration
> option.

I don't remember all the discussions, but one concern was how to handle 
processes that deliberately want to disable it on some parts of memory.

Anyhow, I cc'ed the relevant parties already.

-- 
Thanks,

David / dhildenb

