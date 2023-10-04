Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451C27B8E67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 23:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjJDVBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 17:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjJDVBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:01:04 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAD89E;
        Wed,  4 Oct 2023 14:01:01 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-69101d33315so204680b3a.3;
        Wed, 04 Oct 2023 14:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696453261; x=1697058061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqWCjpGoPtGeBxPj6NXaJjfTI+0jdvkGwu/+8Rx4Pz4=;
        b=LCtAqZbXV5EEBnFNAca0GPoeTLEa2hsqHrwR7Pls/FiUK7wc98ledPW4TKRH0pXfqH
         uT8SIsiC2ayCfIGuiDpPeOtnoh/bVV6ig6sryt17Mrzyc9w6T+EKGQFAkSkIeyXKbmSP
         RyxJM/kArK9xkwaZwjGwLym7OfguHOsGRMPDBhTpKtrZuQyU2U22kbO5KFQNaE7dA9HB
         gOwS8YEK8/9/XD50PMCB86wqvtyBRLNZ1iT0mGNF4do0QPqGLqkmkEFTlI9VZkrCV6qS
         D7SgUM9srYhxtWYfXDOIg+lG3y/rKt2Gk3JqJ3rJCDr/ZAJOdZW0E3UKSLsQMxKvibv4
         HIfg==
X-Gm-Message-State: AOJu0YxiLL41GZnvhwRwoh7lUo0woL0sDiAaOgWg1HdQV2S6PRkoCI/O
        zzs61cbnOApW1NQbPUlT3rM=
X-Google-Smtp-Source: AGHT+IEuGjzH8Kj7y4GInNBPROGHOmz2jLurje3529a8epyygBEeFbbe5C5V5No2qUQIED/PIYh8gA==
X-Received: by 2002:a05:6a00:b84:b0:68f:ccea:8e14 with SMTP id g4-20020a056a000b8400b0068fccea8e14mr4137143pfj.32.1696453260897;
        Wed, 04 Oct 2023 14:01:00 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:969d:167a:787c:a6c7? ([2620:15c:211:201:969d:167a:787c:a6c7])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b006934e7ceb79sm3657241pfo.32.2023.10.04.14.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 14:01:00 -0700 (PDT)
Message-ID: <45bc1c01-09c7-4c54-b305-f349d0d0e19b@acm.org>
Date:   Wed, 4 Oct 2023 14:00:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] block: Add atomic write operations to request_queue
 limits
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-2-john.g.garry@oracle.com>
 <7f031c7a-1830-4331-86f9-4d5fbca94b8a@acm.org>
 <yq1bkdfrt8l.fsf@ca-mkp.ca.oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1bkdfrt8l.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/3/23 20:00, Martin K. Petersen wrote:
> 
> Bart,
> 
>>    also that there are no guarantees that the data written by an atomic
>>    write will survive a power failure. See also the difference between
>>    the NVMe parameters AWUN and AWUPF.
> 
> We only care about *PF. The *N variants were cut from the same cloth as
> TRIM and UNMAP.

Hi Martin,

Has the following approach been considered? RWF_ATOMIC only guarantees 
atomicity. Persistence is not guaranteed without fsync() / fdatasync().

I think this would be more friendly towards battery-powered devices
(smartphones). On these devices it can be safe to skip fsync() / 
fdatasync() if the battery level is high enough.

Thanks,

Bart.



