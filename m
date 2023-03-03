Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A486AA5DA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 00:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjCCXvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 18:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCCXvc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:51:32 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B96151E;
        Fri,  3 Mar 2023 15:51:32 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id oj5so4269629pjb.5;
        Fri, 03 Mar 2023 15:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677887491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfklnDDGGeRj+YrVE+coJVUFAR6xwhAQosjIVIpTsZs=;
        b=wzclQzOcMuax/Unrn5fPtY3Be8U0KbYvllniLUEFDfCYLYy7eAWAderxmARAhS0SnO
         ETkWjwtbXz/OIckpBruSMZoRgQTw+VSP/z8aOguwtnAbsLirZVRhXpR3HcMWGJjqa3CQ
         STFsMmsZiSLMs7zzEMTeCdsHyQAP5Q+DabXHytDnoISiWIb5XJyCRheT0AUEaOIvN40+
         5R3EehTjPeNIjEcw38AMtzI7A6Z6ie7eShP50Yj1YWwHQCJ1I573nEez1HkqiF6Cc0XP
         tw+lB52WtDDeoNMNhWvbMkUxatqizTRhvKpXYJxAyGX2enMSpXCC5PWN+NhObDAYPS8V
         yMeA==
X-Gm-Message-State: AO0yUKUYovhtlUtmmkNDn2fqU/Q8PjNR3VBGVpyhrnhQ5w7xPOuqPbbs
        Y505hlYksEH6y4jGhgycKf+N6RQSLFk=
X-Google-Smtp-Source: AK7set/2YIxijfhsrpo63xHChEZlLV5G3u+6plFHFcL0xlJ0Ubs3M7+JRHwkrO4Gy3f8fdJmZyF15A==
X-Received: by 2002:a17:902:7594:b0:19e:6659:90db with SMTP id j20-20020a170902759400b0019e665990dbmr3135662pll.45.1677887491320;
        Fri, 03 Mar 2023 15:51:31 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:efb8:1cdc:a06f:1b53? ([2620:15c:211:201:efb8:1cdc:a06f:1b53])
        by smtp.gmail.com with ESMTPSA id kd5-20020a17090313c500b00198f256a192sm518141plb.171.2023.03.03.15.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 15:51:29 -0800 (PST)
Message-ID: <88c2c5c6-972f-d089-b1bd-03e0c083c886@acm.org>
Date:   Fri, 3 Mar 2023 15:51:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/23 13:45, Luis Chamberlain wrote:
> I'm gathering there is generic interest in this topic though.

Some Android storage vendors are interested in larger block sizes, e.g. 
16 KiB. Android currently uses UFS storage and may switch to NVMe in the 
future.

> This also got me thinking about ways to try to replicate
> larger IO virtual devices a bit better too.

Is null_blk good enough to test large block size support in filesystems 
and the block layer?

Thanks,

Bart.
