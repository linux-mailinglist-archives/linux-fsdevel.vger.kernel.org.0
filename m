Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51AB212A31C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 17:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfLXQNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 11:13:33 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36247 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfLXQNd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 11:13:33 -0500
Received: by mail-pj1-f67.google.com with SMTP id n59so1394167pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2019 08:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nMi7a9jSqUZMAu/b8TapOOHFxEObE8A/Xz8veWpg0BM=;
        b=nz81BWD2b0msWRjjlepOFGHqrgBHt0hep2ADeZWnWUkyZJjdlA3EQLMpF38mafIy5V
         H8hYU0DLpr0zG++oViAZrYUt56iJUwvOSGYoumm0Pr1GaWSwjVZVMhAJfpS3zUUG6rYd
         Trb7OPRwowEFY1WxLBo57NsIMTYS9crGaL75lsrJ60a550Er2AggeBzoaXfenrLI5pJl
         WdOnVU3Er87Qvlnq2WuWXsQlkgzgILhLo9eEOdEPOYaIxpDiM41a671lYIHfndBhxq6v
         ErFJ8W7CJfr2SeEvJ6Z7L+hLSRUApdjZPzawACw62S1pFTcQ2txOzQ9ZfvOgDHtzsK4a
         My8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nMi7a9jSqUZMAu/b8TapOOHFxEObE8A/Xz8veWpg0BM=;
        b=pVByVk2HkrJweGxjW2rbLLDUuqIQNIWIyhdo8J1DoM0TyqAP44j6i2xXgB8i5PcEgP
         p6VC7sBX+DsVyF6hAUFCVj3xELPlKhOVNcSLefhPgn8y4+bYqhrX7X5t8ULBu9a9aFnz
         mQlzSQk67w4umPyuNFgSJm2iCTCt41PtsK4L3NcIEchGIrkNNiWuyNO3PqPSy37IJNqJ
         PfPcM3/mANVCRKPfT4gkQbRH+qeGMuZFbomsQEsYrFySVswKNICCsjC1EQUADOaCu6As
         ApofxIP1BL0RGuuePonL6jSOOkT9Gqofj5oGZOAgvWwFU/Yp6DgsJnNhcjV4ETF+x0mo
         u7Lg==
X-Gm-Message-State: APjAAAUZ+3qwlmVuqso55Bs3l0GYHOReKm11Q1SEABw896xkLpcgJlBV
        ILJ6rxPAnsi07q0yWCvPHcYl4g==
X-Google-Smtp-Source: APXvYqy1k33O0k6F6ENbx6WIu6dnM0hipGrM41CdQmUPPJ0Ih+tPafK+KJ2wsudsTu8wyJoHps5deQ==
X-Received: by 2002:a17:90a:1b4d:: with SMTP id q71mr6679503pjq.82.1577204012697;
        Tue, 24 Dec 2019 08:13:32 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id s131sm9738627pfs.135.2019.12.24.08.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2019 08:13:32 -0800 (PST)
Subject: Re: [RFC PATCH] io-wq: kill cpu hog worker
To:     Hillf Danton <hdanton@sina.com>
Cc:     io-uring@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
References: <20191223024145.11580-1-hdanton@sina.com>
 <20191224115415.1360-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b91775e3-e6f4-d5dc-0790-60599c96dfd3@kernel.dk>
Date:   Tue, 24 Dec 2019 09:13:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191224115415.1360-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/24/19 4:54 AM, Hillf Danton wrote:
> 
> On Mon, 23 Dec 2019 08:15:00 -0700 Jens Axboe wrote:
>>
>> On 12/22/19 7:41 PM, Hillf Danton wrote:
>>>
>>> Reschedule the current IO worker if it is becoming a cpu hog.
>>
>> Might make more sense to put this a bit earlier, to avoid the
>> awkward lock juggle. In theory it shouldn't make a difference
>> if we do it _before_ doing new work, or _after_ doing work. We
>> should only be rescheduling if it's running for quite a while.
>>
>> How about putting it after the flushing of signals instead?
> 
> 
> All right, thanks.
> 
> Hillf
> --->8---
> From: Hillf Danton <hdanton@sina.com>
> Subject: [RFC PATCH] io-wq: kill cpu hog worker
> 
> Reschedule the current IO worker to cut the risk that it is becoming
> a cpu hog.
> 
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -432,6 +432,8 @@ next:
>  		if (signal_pending(current))
>  			flush_signals(current);
>  
> +		cond_resched();
> +
>  		spin_lock_irq(&worker->lock);
>  		worker->cur_work = work;
>  		spin_unlock_irq(&worker->lock);
> --

That looks better, applied.

-- 
Jens Axboe

