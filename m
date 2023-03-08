Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175716B1279
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 20:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCHTzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 14:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCHTzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:55:38 -0500
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7473AF69E;
        Wed,  8 Mar 2023 11:55:36 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id a2so18783328plm.4;
        Wed, 08 Mar 2023 11:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678305336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2KyRd7VKCzbszMhr3z8iSKufATfqtl+JwH7yP0z5aM=;
        b=vbeLSZyuWzuzIOAOtrn42rXibYs/+aGMO+HcnJ0bVpYhkUU+DpQ3HCP+Y/n1BTStYq
         5vw8rXYHPF28syTu5QgZrsv+CqcDFgrjv8Iqr5w1zHnzu/OmH4B4009bj2XwILQjqpI7
         rEfTqjgmSbWgH+FS+V09zuSMroFUrWG2MP2WnVrTfjnH7WlnOlgz07xOiipojaSlXTHW
         NsS39ubjmNvC9c/oqf8H472C6lqbTTGpzn3MY2XBSfa+7Ir8PFmfL9z4RPgr93f1kG56
         gVr8FcqepobafOs44kY5TxpFcuVd9e1B2homX7W54oy1hgtDGcziQDbMrJjg3nVt5gSk
         3GYw==
X-Gm-Message-State: AO0yUKXCiFhvRFoqoYMr62E4cG/9a0/WT4fbZTHvuPdCYe47UqXQpp44
        PavkOq/09wMILxq2FV6W864=
X-Google-Smtp-Source: AK7set8al4dgNTBDhLRAvwij2RVmfeIMBq2588DUae2qTDL/Rg9HAdFuOFFWQGXgcsP5C64t6UlfjA==
X-Received: by 2002:a17:902:bb8c:b0:19b:c498:fd01 with SMTP id m12-20020a170902bb8c00b0019bc498fd01mr14904305pls.11.1678305336051;
        Wed, 08 Mar 2023 11:55:36 -0800 (PST)
Received: from [192.168.132.235] ([63.145.95.70])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001992e74d055sm10222787plh.12.2023.03.08.11.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 11:55:35 -0800 (PST)
Message-ID: <5f9aee65-c321-6638-bda7-4252889f5276@acm.org>
Date:   Wed, 8 Mar 2023 11:55:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
 <ZAN2HYXDI+hIsf6W@casper.infradead.org>
 <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
 <ZAOF3p+vqA6pd7px@casper.infradead.org>
 <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/5/23 03:22, Hannes Reinecke wrote:
> My point being that zones are just there because the I/O stack can only 
> deal with sectors up to 4k. If the I/O stack would be capable of dealing
> with larger LBAs one could identify a zone with an LBA, and the entire 
> issue of append-only and sequential writes would be moot.
> Even the entire concept of zones becomes irrelevant as the OS would 
> trivially only write entire zones.

That's not correct. Even if the block layer core would support logical 
block sizes of 1 GiB or higher, a logical block size of 16 KiB will 
yield better performance than logical block size = zone size. The write 
amplification factor (WAF) would be huge for databases if the logical 
block size would be much larger than the typical amount of data written 
during a database update (16 KiB?).

Bart.
