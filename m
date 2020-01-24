Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 840321476B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 02:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgAXB2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 20:28:10 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53047 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbgAXB2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:28:09 -0500
Received: by mail-pj1-f67.google.com with SMTP id a6so304965pjh.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2020 17:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3UtLf7+5DucsSWidbQFY9Ttw4iR1dzCtjU7T/DXapxA=;
        b=gVP6U6Q+p98YXgmlCFAuFYsRrG2LhhCKcAevido9e2FXnwhgzhQaMBNzIcZnbZPgme
         vMsV9dcOv+/XVfmge9n3XbCfPWsrNNvY5lxoQ37yHSs4zMSn5o3RFqKJV4Ws1eFc7nDC
         dSd+YFogdIS74Xp1TMCIElLjf0t+sT91d0F478AknsxEjXLtCwxxZ4ti7orpg6BADF/f
         lgWNOGUtqRRzQUXvRi/TIn08j8fcxszdGDLsfZLJ3S+V44+31NRSHEr98BLSE0B8EWbi
         cGP+aJzOSus2vIBCEFejX63wsTfcVEmYaKA/7J0ir4nr/jUtj8vOhZ+ephw+aGFdOQ/v
         dqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3UtLf7+5DucsSWidbQFY9Ttw4iR1dzCtjU7T/DXapxA=;
        b=ShtsGA/ZBzD3I9TFJIREfse73nUXsurSkBFsu7Hd+Yvq3A6Rnx22JyNLVYZ5WAakIw
         LHOJUT33h1TGcOBmf6ZUrJ8A7oEvpUJB0H4FoItQRga2smBq/giT/GZQlH/yUXxFOS4f
         uK8VzaemsfXxrqTwlcmKy7984uoLPDdcVloaKENUJ/kjI62U2NQArQFmEn1jej12PSZ/
         nK/GoMDZnP2+vwrZ4YlRsCf4OGQ1bxbgqqCOaDj95uBEtAlecFYekf1noY//qBzEwYQW
         Y6DYIe4xq7vPdRTzPnS89Do9JgIgaclXNvOAGc7Oo5zeXBL/nkgzT4++2DByqxSe1mhk
         veyA==
X-Gm-Message-State: APjAAAVnDJg7DBJxCQsc3S7ujgvZC29qaikeD/7v0lR8PzWFWDJ9Lovp
        o5qn0oK7Suy8PXsFJKAb9IGZUi1OSio=
X-Google-Smtp-Source: APXvYqzx5MP5rjHYQq3kzzvu651bu9Kdur2mhOsrCqElHx/Qa+CIW2Rn8N1iwWP9tMyek247IQy+tQ==
X-Received: by 2002:a17:90a:da04:: with SMTP id e4mr571675pjv.26.1579829288529;
        Thu, 23 Jan 2020 17:28:08 -0800 (PST)
Received: from [192.168.201.136] ([50.234.116.4])
        by smtp.gmail.com with ESMTPSA id b8sm4091967pff.114.2020.01.23.17.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 17:28:08 -0800 (PST)
Subject: Re: [PATCH] io_uring: wakeup threads waiting for EPOLLOUT events
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200116134946.184711-1-sgarzare@redhat.com>
 <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
 <20200116155557.mwjc7vu33xespiag@steredhat>
 <5723453a-9326-e954-978e-910b8b495b38@kernel.dk>
 <20200116162630.6r3xc55kdyyq5tvz@steredhat>
 <a02a58dc-bf23-ed74-aec6-52c85360fe00@kernel.dk>
 <20200116170342.4jvkhbbw4x6z3txn@steredhat>
 <2d3d4932-8894-6969-4006-25141ca1286e@kernel.dk>
 <20200123214533.ikn4olf7k5dfbaq6@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3805d100-c687-e49e-9317-7cd9b387a3a7@kernel.dk>
Date:   Thu, 23 Jan 2020 18:28:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123214533.ikn4olf7k5dfbaq6@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/20 2:45 PM, Stefano Garzarella wrote:
> On Thu, Jan 23, 2020 at 12:13:57PM -0700, Jens Axboe wrote:
>> On 1/16/20 10:03 AM, Stefano Garzarella wrote:
>>> On Thu, Jan 16, 2020 at 09:30:12AM -0700, Jens Axboe wrote:
>>>> On 1/16/20 9:26 AM, Stefano Garzarella wrote:
>>>>>> Since the use case is mostly single submitter, unless you're doing
>>>>>> something funky or unusual, you're not going to be needing POLLOUT ever.
>>>>>
>>>>> The case that I had in mind was with kernel side polling enabled and
>>>>> a single submitter that can use epoll() to wait free slots in the SQ
>>>>> ring. (I don't have a test, maybe I can write one...)
>>>>
>>>> Right, I think that's the only use case where it makes sense, because
>>>> you have someone else draining the sq side for you. A test case would
>>>> indeed be nice, liburing has a good arsenal of test cases and this would
>>>> be a good addition!
>>>
>>> Sure, I'll send a test to liburing for this case!
>>
>> Gentle ping on the test case :-)
>>
> 
> Yes, you are right :-)
> 
> I was a little busy this week to finish some works before DevConf.  I
> hope to work on the test case these days, so by Monday I hope I have
> it ;-)

Thanks, all good, just a gentle nudge ;-)

-- 
Jens Axboe

