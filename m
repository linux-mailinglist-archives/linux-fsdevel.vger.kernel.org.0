Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A847C7BA7C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 19:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjJERSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 13:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjJERRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:17:49 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D8F271F;
        Thu,  5 Oct 2023 10:10:48 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-694f3444f94so1023701b3a.2;
        Thu, 05 Oct 2023 10:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696525848; x=1697130648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mau3Ytqwy7TZu9wwYpopAHbH4XlNKRL4d1UxE9xBpfw=;
        b=an0tRdeZR8L82BbTIXPQpuym7qXuraJsgB6jec+r9avljTJrywnf5bxAvKZvN+RaFL
         1IOxRUHqDNqO0HjCx8a4Cn++qr6f8C47fM+zlrpwQOwxDXF7LKKrlLmYLBLruad+e/4w
         yChHYbMonF+VPwbrN8Fv7OzbrOyrdKowNaG5ln++F0oPOg9UHpD6YMyt5v2N+DPFyLCx
         ToR0Fo7Of7qWsS8yxefsnzvb7UWu/QF/KCAywDdJ6t+PbUE5qIil+SyKPbpF4rLLXop7
         ye/Cp4TBjuTt/V45gJb5nC4VcYuA2olgH2xnew0UphcDHDla+vzsqyLddhGPRo/QZ75n
         9tBg==
X-Gm-Message-State: AOJu0YzA3AHjB+UzjywzPsjodr4qGObGPpdsdruSfWx05rf+rt4gxe+g
        fGX9KWE9PC4KgtOK8CNnEvA=
X-Google-Smtp-Source: AGHT+IGnVdp8oICK4V8pUUfksO9nmUjiTQt7WLAzT5URUjUrgm7Kl0ihNxBLzaBBJ2yggv4nt+XNYg==
X-Received: by 2002:a05:6a00:1410:b0:68b:eb3d:8030 with SMTP id l16-20020a056a00141000b0068beb3d8030mr6024179pfu.1.1696525847811;
        Thu, 05 Oct 2023 10:10:47 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ca3e:70ef:bad:2f? ([2620:15c:211:201:ca3e:70ef:bad:2f])
        by smtp.gmail.com with ESMTPSA id t16-20020a63b250000000b00565eb4fa8d1sm1641495pgo.16.2023.10.05.10.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 10:10:47 -0700 (PDT)
Message-ID: <a2077ddf-9a8f-4101-aeb9-605d6dee3c6e@acm.org>
Date:   Thu, 5 Oct 2023 10:10:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
 <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
 <yq1h6n7rume.fsf@ca-mkp.ca.oracle.com>
 <34c08488-a288-45f9-a28f-a514a408541d@acm.org>
 <yq1ttr6qoqp.fsf@ca-mkp.ca.oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1ttr6qoqp.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/23 11:17, Martin K. Petersen wrote:
> 
> Hi Bart!
> 
>> In other words, also for the above example it is guaranteed that 
>> writes of a single logical block (512 bytes) are atomic, no matter
>> what value is reported as the ATOMIC TRANSFER LENGTH GRANULARITY.
> 
> There is no formal guarantee that a disk drive sector 
> read-modify-write operation results in a readable sector after a 
> power failure. We have definitely seen blocks being mangled in the 
> field.

Aren't block devices expected to use a capacitor that provides enough
power to handle power failures cleanly?

How about blacklisting block devices that mangle blocks if a power
failure occurs? I think such block devices are not compatible with
journaling filesystems nor with log-structured filesystems.

Thanks,

Bart.

