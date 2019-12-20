Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7511285B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 00:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfLTXvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 18:51:10 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:39089 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfLTXvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 18:51:09 -0500
Received: by mail-pl1-f175.google.com with SMTP id g6so1818442plp.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2019 15:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NKQ9URZBMeV3OPseAAh2Xx7y2pXyxLatIKtNl8iLvXQ=;
        b=ykJu8gvYo2ySI4MYq3KAx12I/84YrqF+Q/U5WMmy9QswF5KWC7Km1ht1FtGvNaAqEP
         O5N9mcr7Ry87YOOCeMm9G9FT4U2Eg8KXvUxER0cexg2PiLXMO8kzbyibp6yHj99A0BwQ
         azvWMwgMPEzz53V3OcaFGUZMscgQ49MExbyF4PTQYnrMpJNaDUSPsxshj/pv3lDgiSEa
         V6iwl5I4A5vmr+Ob3uN9MzIuG2rz8qbK9VqN9mLJejdnI3ZW3+2VKhK3LRj+FC/uePhi
         Swb8KNcr8jc974+Q3z6dOxdd6nhs7IAAlnnRfXigkKsfolnY0ljiBl0xJMN8YmjPXtYj
         1Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NKQ9URZBMeV3OPseAAh2Xx7y2pXyxLatIKtNl8iLvXQ=;
        b=aa9bUg7RxUbR6q1CqjGFBZ2uDV+oH9Gos3zIs6uDbGvZZqUqlZAmFlxkwvk5W922Go
         6BT7Yh7fQ82wneGroDtoVjRRLHLaw0O0Dqf9B2fu7PerULV3bXHYGjyi/Xd5H0XZgbma
         SQnx+CRbnGScKNgbC7q+RNl5LbnwCDt5SSwONEVJFUd6Q+memn2/wNQ2y/XMJlmuP8mc
         Zj8BjLsOeZAo0yBvLiz6bsQelh5J8Y3GhezAJpIZd7/9tlHlpANa1PgAFv7QTkYHS1dC
         CUfSvp9pyRPi2datxlIhfjAjeQWEGl9w/XG3SzjYfTEI3tv+mph+z/ls98AZ4pMhbap2
         UEuQ==
X-Gm-Message-State: APjAAAVHWk+SVIyzXdoUuK+PXceTXGBxgJbGDgXiLQgzGXSdMIg2rusz
        IWxTPpx3W+XyuSPKDyB/HionLw==
X-Google-Smtp-Source: APXvYqzmkZWiV7MicyHExsLOg3UvxPLhXwAkPmhB5mHQM5D5YzarwPE7bcTHy/sqhKiuGY4VEVe9RA==
X-Received: by 2002:a17:902:76c9:: with SMTP id j9mr8890271plt.21.1576885852697;
        Fri, 20 Dec 2019 15:50:52 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id w38sm13024578pgk.45.2019.12.20.15.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 15:50:52 -0800 (PST)
Subject: Re: [PATCH][next] io_uring: fix missing error return when
 percpu_ref_init fails
To:     Colin Ian King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191220233322.13599-1-colin.king@canonical.com>
 <398f514a-e2ce-8b4f-16cf-4edeec5fa1e7@kernel.dk>
 <cf270359-fd06-3175-d0ef-ec2adc628235@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a1a36f72-50ff-9cce-bcde-6639f7ab6406@kernel.dk>
Date:   Fri, 20 Dec 2019 16:50:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cf270359-fd06-3175-d0ef-ec2adc628235@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/20/19 4:49 PM, Colin Ian King wrote:
> On 20/12/2019 23:48, Jens Axboe wrote:
>> On 12/20/19 4:33 PM, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Currently when the call to percpu_ref_init fails ctx->file_data is
>>> set to null and because there is a missing return statement the
>>> following statement dereferences this null pointer causing an oops.
>>> Fix this by adding the missing -ENOMEM return to avoid the oops.
>>
>> Nice, thanks! I'm guessing I didn't have the necessary magic debug
>> options to allow failure injection for failing.
> 
> Fortunately we have Coverity to the rescue :-)

Indeed!

-- 
Jens Axboe

