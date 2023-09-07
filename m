Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1222B7977B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjIGQbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbjIGQbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:31:31 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4B85251
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 09:21:44 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6bcae8c4072so821164a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Sep 2023 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694103321; x=1694708121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpAncpsnxY7aC1ou9acM0h7ym6Wf8QSElbvjg5hra5A=;
        b=MIqPIIyW73fYXSM1IpVlA2ehcUS6YfGdWIYqWe5zFFPLoPAKIv8lzSeYDRUSJo2svW
         e0j0+rx/lQVR8RTLTASxQM0/Y2EBaDhA6KQq/9AFjkCRDZxsNrgEEq8ThjP2MyyTz9cs
         7wqls7Nfx32FqQjR/83erIXBgfxW1epeYoDus3Gz3SxyH3ExaKp4Cn46tNFfEaddwiap
         xleXpq8DADnc4wZleCG8aeN6Jz6qJqlCY4z4b/J8w04ree1avsGVngM0OByS4x/Ra/3R
         3q9Tf4OfhHmHMSZukoU9jPXG7GYr3ivZDk0Z8xv5qXX8BgUvxCPyIlqxJgkFnFag7elA
         /QHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103321; x=1694708121;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpAncpsnxY7aC1ou9acM0h7ym6Wf8QSElbvjg5hra5A=;
        b=LUs4ywfHH2L4STyMoeVphCzwWfwGcK01aF+9opKk93TXQZ+RExkmdUYQWYEJMe/D/0
         I2LmafZEoM6RCzkAi10BJVviNoAx04ns4AHKZZ3fC/z2anPvzesGPBpYXzj4V30+PZVl
         n5Naesyr0UM0OvWVxyGmg/d4WKLDNgTP6VMZfIq/Xr4c2/eWdeCHp0n+aOwG2UoneVFp
         ytvF8hegtDEjDIec8Cqp85OVO3U9TlRzWGTF6BD8CE4MqyQMeyBkrxd5LTNBrGZt9e9y
         CAHDGQyfx9uQAOCiMwUNO+0GDCMgGKZLyuv9i4/lS5QW3sTGsCwf9RwK2YFlJVVPB3ll
         vAyg==
X-Gm-Message-State: AOJu0YyJeBDl+9XrC75tQ8GwPO7PDcGllJUZHTCcnL1na1X7umLG9ypF
        5s+Zu+1rfqSRGtSCSelXFZFFIgQ8Aks=
X-Google-Smtp-Source: AGHT+IHAe8UshzC+ci2VJWs1XhLXI14inSCq20rj6Saz8wM90SJzwKqtmMYRcTiJwoBMCIX9HIxUuA==
X-Received: by 2002:a17:902:db12:b0:1bc:28a8:f856 with SMTP id m18-20020a170902db1200b001bc28a8f856mr22601053plx.47.1694091469006;
        Thu, 07 Sep 2023 05:57:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902a5cb00b001bfd92ec592sm12738065plq.292.2023.09.07.05.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 05:57:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0ece94aa-141e-564c-f43c-2d6d4b9e61c4@roeck-us.net>
Date:   Thu, 7 Sep 2023 05:57:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Christian Brauner <brauner@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area>
 <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlC0pf2XA1ZGr6j@casper.infradead.org>
 <c89ebbb2-1249-49f3-b80f-0b08711bc29b@leemhuis.info>
 <20230907-kauern-kopfkissen-d8147fb40469@brauner>
 <d62225ae-73dc-4b45-a1d9-078137224eb5@leemhuis.info>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
In-Reply-To: <d62225ae-73dc-4b45-a1d9-078137224eb5@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/7/23 04:18, Thorsten Leemhuis wrote:
> On 07.09.23 12:29, Christian Brauner wrote:
>>> So why can't that work similarly for unmaintained file systems? We could
>>> even establish the rule that Linus should only apply patches to some
>>> parts of the kernel if the test suite for unmaintained file systems
>>> succeeded without regressions. And only accept new file system code if a
>>
>> Reading this mail scared me.
> 
> Sorry about that, I can fully understand that. It's just that some
> statements in this thread sounded a whole lot like "filesystems want to
> opt-out of the no regression rule" to me. That's why I at some point
> thought I had to speak up.
> 
>> The list of reiserfs bugs alone is crazy.
> 
> Well, we regularly remove drivers or even support for whole archs
> without getting into conflict with the "no regressions" rule, so I'd say
> that should be possible for file systems as well.
> 
> And I think for reiserfs we are on track with that.
> 
> But what about hfsplus? From hch's initial mail of this thread it sounds
> like that is something users would miss. So removing it without a very
> strong need[1] seems wrong to me. That's why I got involved in this
> discussion.
> 

The original mail also suggested that there would be essentially no means
to create a hfsplus file system in Linux. That would mean it would, for all
practical purposes, be untestable.

However:

$ sudo apt-get install hfsprogs
$ truncate -s 64M filesystem.hfsplus
$ mkfs.hfsplus filesystem.hfsplus
Initialized filesystem.hfsplus as a 64 MB HFS Plus volume
$ file filesystem.hfsplus
filesystem.hfsplus: Macintosh HFS Extended version 4 data last mounted by: '10.0', created: Thu Sep  7 05:41:21 2023, last modified: Thu Sep  7 12:41:21 2023, last checked: Thu Sep  7 12:41:7

So I am not really sure I understand what the problem actually is.

No a side note, the crash I observed with ntfs3 was introduced by
commit a4f64a300a29 ("ntfs3: free the sbi in ->kill_sb").

Guenter

