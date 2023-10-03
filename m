Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF857B6F11
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 18:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbjJCQ4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 12:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240538AbjJCQ4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:56:02 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461431B9;
        Tue,  3 Oct 2023 09:55:44 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1c60cec8041so8245445ad.3;
        Tue, 03 Oct 2023 09:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696352143; x=1696956943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OTDR5NyHbb5QfDMSXNmt2Tc0LOejPzxDMttSZkL2/8=;
        b=WnnfO7+aeMjMYVsL9+tl0f+FVNbYr0lkeWaff6duPro/NnGxvZwDDnKZc7OEZD6V49
         Esd1l8CbORy4KX1EvAevdXtx6zvZhdjsYuIkFt2ilApQcXo9EFCfzw6mFBzAm/3ibSxU
         ywF+XIfY/xSI7uLR9a+pZDqHHGVgDTpzPqpU/wBYthqYTIV361qvSgLtd1EWrW/6ZwXi
         bojGkE1AzEqXysDm7OPEaKwBL5QQNl51GT2mCuESv3mfagNY7RPeJNFl6F8Oss83vtlx
         OOSFpDADfnzM6jhQpaY/87v18Erw4a2ya5+CRPV9Uc2HC+U1qpQH7ACcIa4Hp2WbS1PD
         JWKg==
X-Gm-Message-State: AOJu0YzqCwHu2g44Yphp90kHix7zGTeOqT46KYvGkEHcEXv/OMCiNFNa
        pmeYbJeTW1eLuXu0ZZM8pnI=
X-Google-Smtp-Source: AGHT+IHkImNltSCEcrQL09yiA54GtSP4oWfRcumNXnmrqYOlKYAw0cgN14lN/1BxGiHV1bJDHfZauw==
X-Received: by 2002:a17:902:a415:b0:1c7:443d:7412 with SMTP id p21-20020a170902a41500b001c7443d7412mr174904plq.26.1696352143218;
        Tue, 03 Oct 2023 09:55:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:fc96:5ba7:a6f5:b187? ([2620:15c:211:201:fc96:5ba7:a6f5:b187])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b001c5de42c185sm1801070plj.253.2023.10.03.09.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 09:55:42 -0700 (PDT)
Message-ID: <db6a950b-1308-4ca1-9f75-6275118bdcf5@acm.org>
Date:   Tue, 3 Oct 2023 09:55:40 -0700
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1lecktuoo.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/2/23 17:48, Martin K. Petersen wrote:
> 
> Bart,
> 
>> Are there any SCSI devices that we care about that report an ATOMIC
>> TRANSFER LENGTH GRANULARITY that is larger than a single logical
>> block?
> 
> Yes.
> 
> Note that code path used inside a storage device to guarantee atomicity
> of an entire I/O may be substantially different from the code path which
> only offers an incremental guarantee at a single logical or physical
> block level (to the extent that those guarantees are offered at all but
> that's a different kettle of fish).
> 
>> I'm wondering whether we really have to support such devices.
> 
> Yes.

Hi Martin,

I'm still wondering whether we really should support storage devices
that report an ATOMIC TRANSFER LENGTH GRANULARITY that is larger than
the logical block size. Is my understanding correct that the NVMe
specification makes it mandatory to support single logical block atomic
writes since the smallest value that can be reported as the AWUN 
parameter is one logical block because this parameter is a 0's based
value? Is my understanding correct that SCSI devices that report an 
ATOMIC TRANSFER LENGTH GRANULARITY that is larger than the logical block
size are not able to support the NVMe protocol?

 From the NVMe specification section about the identify controller 
response: "Atomic Write Unit Normal (AWUN): This field indicates the 
size of the write operation guaranteed to be written atomically to the 
NVM across all namespaces with any supported namespace format during 
normal operation. This field is specified in logical blocks and is a 0’s 
based value."

Thanks,

Bart.


