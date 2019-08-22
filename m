Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F0999FAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 21:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391543AbfHVTRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 15:17:43 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46571 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391860AbfHVTRn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:17:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id z17so6471255otk.13;
        Thu, 22 Aug 2019 12:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=24eP7T52+CYL2dNJV8R097RDf634lSS5yuSIePFHGwk=;
        b=eAbrKm5FJNzAHkCS/Z5RTD47hOZKeWADSxBDfsmBNfsJa31aNePzf2DAaBqnqn+TcN
         cE6/kDiRsa4mthXJs42kKSP5E3jo1dtIjG1EoYi8ecz9tgmWp3xWrNniJhAxNcU5cT6B
         5N57E849AJefGrd7xA4mMC5jrWcWLH/P0B1gaPs+wEwfvKVe3gEw5/eBrVebsO0CrZPI
         5ifJJOXkzLBJMYgJr0qz+HSfHrRieVvlty7C3ioBSzq5L+GbxOW5RWJo2esyu3cQuIqh
         pB38rZMsIIQ6K5avEvVQzxHRuU2q/uGX1GyIjlAADceGGKw5vMCY/+Y+VOIgkQXyOpc0
         XcQA==
X-Gm-Message-State: APjAAAUbqws7Ok41kGbUAZJeq/ROhgLjIO9Jcz0rWCtbhYtQusVcm/mR
        EPc19iKyO2mt6bZtfTqBiPI=
X-Google-Smtp-Source: APXvYqxop+1c9JiQDuqjxLlVpuweprhgD1ihezKlsMDwXHi6Dx3GUbjgB7f6MqabctH5Zf2GXdALrg==
X-Received: by 2002:a05:6830:1db2:: with SMTP id z18mr1087490oti.110.1566501462198;
        Thu, 22 Aug 2019 12:17:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id j6sm157680otq.16.2019.08.22.12.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 12:17:41 -0700 (PDT)
Subject: Re: [PATCH v7 08/14] nvmet-core: allow one host per passthru-ctrl
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Max Gurtovoy <maxg@mellanox.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-9-logang@deltatee.com>
 <05a74e81-1dbd-725f-1369-5ca5c5918db1@mellanox.com>
 <a6b9db95-a7f0-d1f6-1fa2-8dc13a6aa29e@deltatee.com>
 <5717f515-e051-c420-07b7-299bcfcd1f32@mellanox.com>
 <b0921c72-93f1-f67a-c4b3-31baeb1c39cb@grimberg.me>
 <b352c7f1-2629-e72f-9c85-785e0cf7c2c1@mellanox.com>
 <24e2ddd0-4b2a-8092-cf91-df8c0fb482e5@grimberg.me>
Message-ID: <e4430207-7def-8776-0289-0d58689dc0cd@grimberg.me>
Date:   Thu, 22 Aug 2019 12:17:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <24e2ddd0-4b2a-8092-cf91-df8c0fb482e5@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>> I don't understand why we don't limit a regular ctrl to single 
>>>> access and we do it for the PT ctrl.
>>>>
>>>> I guess the block layer helps to sync between multiple access in 
>>>> parallel but we can do it as well.
>>>>
>>>> Also, let's say you limit the access to this subsystem to 1 user, 
>>>> the bdev is still accessibly for local user and also you can create 
>>>> a different subsystem that will use this device (PT and non-PT ctrl).
>>>>
>>>> Sagi,
>>>>
>>>> can you explain the trouble you meant and how this limitation solve 
>>>> it ?
>>>
>>> Its different to emulate the controller with all its admin
>>> commands vs. passing it through to the nvme device.. (think of format 
>>> nvm)
>>>
>>>
>>>
>> we don't need to support format command for PT ctrl as we don't 
>> support other commands such create_sq/cq.
> 
> That is just an example, basically every command that we are not aware
> of we simply passthru to the drive without knowing the implications
> on a multi-host environment..

If we were to change the logic of nvmet_parse_passthru_admin_cmd to
have the default case do nvmet_parse_admin_cmd, and only have
the vendor-specific space opcodes do nvmet_passthru_execute_cmd
then I could not see at the moment how we can break a multi-host
export...
