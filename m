Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248CA793739
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 10:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjIFIha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 04:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjIFIh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F1EE43
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 01:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693989399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8kxl0a4T7fw0FkcqLI3LPI8DvJ1AdEWlSu5wSZFK0FM=;
        b=i1TxdcZcLFxLIFsvaKRsQNC5u2YG7E3kKOqkT1nPeuZKZES6osmxfUIcerPUK4cSKw5G57
        vUfzUaMVL1fsurnkxyDU+RCNJJdP1DZrzj204hxpc6BJtfVlLwt0wlCDl1OrGBo1+D1sGF
        GJcICoDUCLsZqHjzjs8BVt098X4p6m4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-vj52HvuGNjGNzbPwJPtRcw-1; Wed, 06 Sep 2023 04:36:38 -0400
X-MC-Unique: vj52HvuGNjGNzbPwJPtRcw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3180237cef3so1859556f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 01:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693989397; x=1694594197;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kxl0a4T7fw0FkcqLI3LPI8DvJ1AdEWlSu5wSZFK0FM=;
        b=OkrL2hpYfOz3DTq3a/Nsw+IBVFHLl4PuK5SogFajYp4a3+My+Jm0VWjnzZlVgtN3Eo
         HWeP29rQiK4BqcWdl4UJdTtLbAYTOt3BChc8+TdUSpiBkcPpVlqYLJTO8yDrkx2oB9C1
         LvberAuMdE0NxcvwQ1AOracKxRNOw+oYXLrA4pmaMsAwjG0k4KTeKs1FMgnd+iVMTYNU
         5n6tBGkE6efC+MSS1YvMAJavyANDg6NiYY1niqzgmLKx6tX7SRg0oT+w+o/WSzTFVSQ5
         AwT6RrNh1AlNdocDeAytCRreBhBFutHlXRjceZCr06KpByb2lW6vSNSDGyzBiMX8Hb0w
         jK+Q==
X-Gm-Message-State: AOJu0Yz1o8WeFH/bfDbwtIUHIkF+/t5U/MFJbXE8ovb2Sb6RUdI3EPsN
        0Ih8zh0K6cgkMTG1C/TGYR2+dnxIEKiS40HgnvxfZP2r7dbngbbzx29UHWS+0UneK25zHiyJCGk
        5skBcELSDZzz7vjbKwPVDvRBzt2b7pZbyZQ==
X-Received: by 2002:adf:f106:0:b0:319:6d20:49c7 with SMTP id r6-20020adff106000000b003196d2049c7mr1970071wro.3.1693989396875;
        Wed, 06 Sep 2023 01:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFovfwa+rNzl6czUglrSJTNG8ZOkBhlMPLZKJyE4MkoRjEEuhGKhjJyrYPse3cVSXxQhy3ecA==
X-Received: by 2002:adf:f106:0:b0:319:6d20:49c7 with SMTP id r6-20020adff106000000b003196d2049c7mr1970055wro.3.1693989396597;
        Wed, 06 Sep 2023 01:36:36 -0700 (PDT)
Received: from [192.168.1.165] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id s12-20020a5d4ecc000000b0031423a8f4f7sm19895490wrv.56.2023.09.06.01.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 01:36:35 -0700 (PDT)
Message-ID: <91aae40f-deed-1637-b083-764a5dff4a41@redhat.com>
Date:   Wed, 6 Sep 2023 09:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [ANNOUNCE] Goodbye cluster-devel, hello gfs2@lists.linux.dev
Content-Language: en-US
From:   Andrew Price <anprice@redhat.com>
To:     cluster-devel <cluster-devel@redhat.com>
Cc:     gfs2@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <9830d291-a86b-df63-0b03-c99c583609c8@redhat.com>
In-Reply-To: <9830d291-a86b-df63-0b03-c99c583609c8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/08/2023 18:07, Andrew Price wrote:
> Hi all,
> 
> As cluster-devel is now only used for gfs2 and dlm development, we will 
> be moving them to a new list hosted by kernel.org alongside other Linux 
> subsystems' lists. The new list is gfs2@lists.linux.dev and it will be 
> used for both gfs2 and dlm development.
> 
> The Linux MAINTAINERS file and other references will be updated shortly 
> to reflect the change. Information about the list hosting can be found 
> here:

Updates to the MAINTAINERS file have now been merged into mainline so 
gfs2@lists.linux.dev is now the official mailing list for gfs2 and dlm 
development.

(CC+ linux-fsdevel for awareness.)

Thanks,
Andy


> https://subspace.kernel.org/lists.linux.dev.html
> 
> To subscribe, send an email (the subject and body doesn't matter) to:
> 
> Subscribe:   gfs2+subscribe@lists.linux.dev
> Unsubscribe: gfs2+unsubscribe@lists.linux.dev
> 
> If you prefer, the list can also be read via NNTP at:
> 
> nntp://nntp.lore.kernel.org/dev.linux.lists.gfs2
> 
> The archives can be found here:
> 
> https://lore.kernel.org/gfs2/
> 
> and filters can use the "List-Id: <gfs2.lists.linux.dev>" header.
> 
> Thanks,
> Andy

