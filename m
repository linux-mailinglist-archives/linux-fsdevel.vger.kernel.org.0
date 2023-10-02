Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E537B5915
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 19:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbjJBRUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238730AbjJBRUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:20:37 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BFCC4;
        Mon,  2 Oct 2023 10:20:34 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-690bd59322dso348b3a.3;
        Mon, 02 Oct 2023 10:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696267234; x=1696872034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oj8WCr3mnx49WEqp+D1QiL7KtQ7PeD9Y7BHxze9CSdM=;
        b=ScZMi4E2lLxlDer0N0TFsDjYcSV3dLZDmM3hMSmOfyrLRcGdJP1cHckqDpLEEDdu5c
         A3mTWn6+1Ab69NdqwF6ZsvVlest2Y0ivBy5WO8GnuYb9lyGWTbbyM0rJFxWk0/k18L2B
         nooi0ya1vkhbReTADuChZNNNDMvctwM9nbkvRLyxO41x0tgMN3tH+8ZtPilQ9e7x2cvh
         mnZdbAevPKwV/rfIMUBv84+SRy1Hk08pAmJeBFooqvpYsyhqN0eU9BmfAhtZq6XBjXug
         QQ8x7+ft3PSQIywRcUSwis3FCbSZic3RcCzzrNBmsd2M83Nzv1vGXefJN/n9FDbpkR7V
         Qang==
X-Gm-Message-State: AOJu0YwROcdGE/VT5Cgvl4sYjP5g1DQCHI5EdMuszEblu1EteX188dSF
        jOzmQpYoUb7BIC2Bc8Af/E0=
X-Google-Smtp-Source: AGHT+IEjzOa04+2Ufwx7GQqTs8I92CbDPQtHf7WsBybxCpOZvqdgOeg/9SHQiW6+6cz8p8MM8yAf+Q==
X-Received: by 2002:a05:6a00:2d1b:b0:690:41a1:9b67 with SMTP id fa27-20020a056a002d1b00b0069041a19b67mr11561705pfb.9.1696267233570;
        Mon, 02 Oct 2023 10:20:33 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6ad7:f663:5f97:db57? ([2620:15c:211:201:6ad7:f663:5f97:db57])
        by smtp.gmail.com with ESMTPSA id j7-20020aa783c7000000b0068ffd56f705sm12815755pfn.118.2023.10.02.10.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 10:20:33 -0700 (PDT)
Message-ID: <2af482c9-aad8-4b77-8969-10fe53ee8c5b@acm.org>
Date:   Mon, 2 Oct 2023 10:20:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <yq1o7hnzbsy.fsf@ca-mkp.ca.oracle.com> <ZRqrl7+oopXnn8r5@x1-carbon>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZRqrl7+oopXnn8r5@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/2/23 04:38, Niklas Cassel wrote:
> So there should probably be a good argument why we would want to 
> introduce yet another API for providing I/O hints, instead of 
> extending the I/O hint API that we already have in the kernel right 
> now. (Especially since it seems fairly easy to modify your patches
> to reuse the existing API.)

Here is a strong argument: there is user space software that is using
the F_SET_FILE_RW_HINT API, e.g. Samba. I don't think that the above
arguments are strong enough to tell all developers of user space
software to switch from F_SET_FILE_RW_HINT to another API. This would
force user space developers to check the kernel version before they
can decide which user space API to use. If the new user space API would
get backported to distro kernels then that would cause a real nightmare
for user space developers who want to use F_SET_FILE_RW_HINT or its
equivalent.

Thanks,

Bart.
