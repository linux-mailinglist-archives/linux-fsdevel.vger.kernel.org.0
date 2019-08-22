Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1509C99D47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 19:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404260AbfHVRlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 13:41:18 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33561 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404269AbfHVRlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:41:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id l2so5014692oil.0;
        Thu, 22 Aug 2019 10:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S3Wtmx63qYO2RYwlc+u7gYjYEryNsm6UT+kYuRsp+wI=;
        b=sslPEcfdgZ9KQvOL+TIkZ3p39+WJ/J1pxAnS69kBC5lwFuS1liEHgWhwPwHsB4YgnZ
         1a2a38KNO3cCxO93DUcaUQEqA+czK18SqAATh2ZaVt5hFmRVr55jKzLdyn2bLoHlVNUG
         72WePR9MVNTtEbEYjiF8IbClzrD0EpwSiO8A1ALSvjSgfskZewtIpBr6CX7D76EiKG5E
         Ui6JWU1bpQHU+TRnFq0Buki8SxfL1IlSXx107CeGu8ImQpd6GbU9+/Fdo+NR6n4E2olf
         tO/JYLdOJ2+/MdobZKxY82rtEZ0F9enWAySyYVOdMe4WKXSsJ+PxOwH+/H5HY6oHEapQ
         dygQ==
X-Gm-Message-State: APjAAAWB4coirRjoeXyl9gDo33VOcK6VtRUwkcKYe0n6dzuJWcTIHekX
        J07Rv+RKxaDi7YFF1WT37Bg=
X-Google-Smtp-Source: APXvYqxXzyiGzvP9QOEziqdHlRZkxskbjNq0zGJS3yjldmavVtqqk7S7wFueDS6GCxtSQweXW/XKyg==
X-Received: by 2002:aca:3887:: with SMTP id f129mr224476oia.108.1566495671970;
        Thu, 22 Aug 2019 10:41:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id o26sm71264otl.34.2019.08.22.10.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 10:41:11 -0700 (PDT)
Subject: Re: [PATCH v7 08/14] nvmet-core: allow one host per passthru-ctrl
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <24e2ddd0-4b2a-8092-cf91-df8c0fb482e5@grimberg.me>
Date:   Thu, 22 Aug 2019 10:41:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b352c7f1-2629-e72f-9c85-785e0cf7c2c1@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>> I don't understand why we don't limit a regular ctrl to single access 
>>> and we do it for the PT ctrl.
>>>
>>> I guess the block layer helps to sync between multiple access in 
>>> parallel but we can do it as well.
>>>
>>> Also, let's say you limit the access to this subsystem to 1 user, the 
>>> bdev is still accessibly for local user and also you can create a 
>>> different subsystem that will use this device (PT and non-PT ctrl).
>>>
>>> Sagi,
>>>
>>> can you explain the trouble you meant and how this limitation solve it ?
>>
>> Its different to emulate the controller with all its admin
>> commands vs. passing it through to the nvme device.. (think of format 
>> nvm)
>>
>>
>>
> we don't need to support format command for PT ctrl as we don't support 
> other commands such create_sq/cq.

That is just an example, basically every command that we are not aware
of we simply passthru to the drive without knowing the implications
on a multi-host environment..
