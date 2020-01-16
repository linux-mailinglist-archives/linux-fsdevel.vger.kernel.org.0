Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A062813DF74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 17:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgAPQA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 11:00:27 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41118 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAPQA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:00:26 -0500
Received: by mail-io1-f66.google.com with SMTP id m25so6750126ioo.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2020 08:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9JA64lSSGZhM2+AlaRyGX22gJ8cKrvAPGqj8KNteWAA=;
        b=eBfQSPTl2scwswbOFhSakwoAF8PgLkNlYnC3C6QeLqCeox/H7wcY+SIlR+lNSUw42o
         WOIT5oBuVgYd+Y1OGGrbGJNKNmktZTmNXZ16cIQuyAPm4YWbbgoXZnpe06HrfjhZe4wh
         Jvjp4VXvd7d0e1EMKTINBcMvDAv1ptgp5VdEi5x2MQSm3xy5BAWpnG4nDc8SWGvlFXF0
         09mWFcUSVHjoTgkHypCGBi7RfnLUUYN7U9ZoE3UVeSBmMhUBAUqOMOwjHSseREsHpuz5
         yEpQvoDQq9aZOqAgUm/bE5JmNmhYThEmhhBzTgBD2xFEjKfYh2Rhaz0m+v9VGIkXZF7p
         qPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9JA64lSSGZhM2+AlaRyGX22gJ8cKrvAPGqj8KNteWAA=;
        b=BAukbAVHlL5+yYYBvwtz874DycK0oQ9moK0i1ivxQMjusyQUZWa/bxMZK0eAW/xYJ+
         uqrpORIzhG3y/BQiL/w3+ahwgAwoVgsWcO/Pqh+4TloC+DGqsOo+WRakHuuPdakp5Bf3
         M44EmVYnBOauhIN9M9UfsEMWUguO33XaVbXS/a7YZQkgOboL7YZ7o1L6oLX4CgcHLGLt
         HqSW5cs6paDhv6cBtAZ8IV70TlVarm8/7A/IEr15AbAdNO/cffWyD6qqVQy8rX4KjubU
         /VHFC+F6mFNYfitLmInrDzWpDU1qc6LWbvfSpHJBOLbGDfnoVC5FHsHj7fQm43Z8kmKB
         mieg==
X-Gm-Message-State: APjAAAXr1mEkweK4gGuvzsw3vOf1IfqWIxOXHNY+VxoHBVtyI0BgDfXQ
        qQtOo+v4rcd5Ul3Rhseo/RUQ5zjAQhU=
X-Google-Smtp-Source: APXvYqyeh93woLPz87vdCJmNQys9BCZFkfr63nCTiExdwxydYs0bn+NUXt5EfOG2vH3juJG/+gxrNQ==
X-Received: by 2002:a6b:740c:: with SMTP id s12mr28568449iog.108.1579190425642;
        Thu, 16 Jan 2020 08:00:25 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y14sm2002012ioa.12.2020.01.16.08.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:00:25 -0800 (PST)
Subject: Re: [PATCH] io_uring: wakeup threads waiting for EPOLLOUT events
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200116134946.184711-1-sgarzare@redhat.com>
 <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
 <20200116155557.mwjc7vu33xespiag@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5723453a-9326-e954-978e-910b8b495b38@kernel.dk>
Date:   Thu, 16 Jan 2020 09:00:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116155557.mwjc7vu33xespiag@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/16/20 8:55 AM, Stefano Garzarella wrote:
> On Thu, Jan 16, 2020 at 08:29:07AM -0700, Jens Axboe wrote:
>> On 1/16/20 6:49 AM, Stefano Garzarella wrote:
>>> io_uring_poll() sets EPOLLOUT flag if there is space in the
>>> SQ ring, then we should wakeup threads waiting for EPOLLOUT
>>> events when we expose the new SQ head to the userspace.
>>>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>>
>>> Do you think is better to change the name of 'cq_wait' and 'cq_fasync'?
>>
>> I honestly think it'd be better to have separate waits for in/out poll,
>> the below patch will introduce some unfortunate cacheline traffic
>> between the submitter and completer side.
> 
> Agree, make sense. I'll send a v2 with a new 'sq_wait'.
> 
> About fasync, do you think could be useful the POLL_OUT support?
> In this case, maybe is not simple to have two separate fasync_struct,
> do you have any advice?

The fasync should not matter, it's all in the checking of whether the sq
side has any sleepers. This is rarely going to be the case, so as long
as we can keep the check cheap, then I think we're fine.

Since the use case is mostly single submitter, unless you're doing
something funky or unusual, you're not going to be needing POLLOUT ever.
Hence I don't want to add any cost for it, I'd even advocate just doing
waitqueue_active() perhaps, if we can safely pull it off.

-- 
Jens Axboe

