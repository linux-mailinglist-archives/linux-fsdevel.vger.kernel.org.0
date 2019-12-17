Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3064E1232BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 17:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLQQmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 11:42:38 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46354 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQQmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:42:37 -0500
Received: by mail-io1-f68.google.com with SMTP id t26so11292982ioi.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 08:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=85tJwjfPsvm0o1CtqUKLxcZhYUO7faTPrBd2G2sD4nI=;
        b=Ln434Cl87LG0Fhc5QQ+fjnUtO5EBQMmZiQA99NPbXKIHMXwk/CPV+7eXQR+spZiR05
         7NZSGPylcPDhe+hrtQph4Tcz0HA/+Ps3tu/nv5ff6mp21dQy/mT2GfSpvy2N/T6TD1n8
         y7F97PxPMZbr+l/VcpvRiEZuGi6A7oz61Hv1tz6+m5uZtiCdhpmrDGf1JSiEfNX9q2XT
         ePkiPEVerc7ksamxDVA0yRuJogydPUe7WKUtflNHHlZ358RLNEeBBDLR/nh8su474x//
         /ViR/BWI7rg1ZfJ8neJTkrDj2ChUBd4naTOK7WEH37/hFINrV+PS56fZ3tN2QekQzt53
         1Wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=85tJwjfPsvm0o1CtqUKLxcZhYUO7faTPrBd2G2sD4nI=;
        b=kaTZCXkUe/lX2HENi9Yvf5rYm0+rwbrjFM1wk/9nAV9HDsk3ZW5Jvhdti9/bQAZ+ih
         bAeWVuZguOKPYn1JVRzsLZpzSlhckZgYVVL28QWW7d+rOPJRWsk98SQrDlO/4EE7l8Ki
         1otUZgNUiHyglpR4ZAyqV+ghF/qdHPGHfgqKSc/q4lUwL43gYwsR3erxxns3qaLAK2rl
         U/lN1/N3AX5KHS3I62shUOgPbjiaO9v8o2LC6teZdOHYOtkwwtE7iR1oUl8JFMDxgL1U
         rN/wlPtmHnv3aMU1CzzTWnMyNp/8z6dbmuc77jHWmcxxZrEKzv9yPIUFb5FEYe9N0bCB
         AtBQ==
X-Gm-Message-State: APjAAAWbX5IcVKqJc/FgFMD5IzIFGH1VzA5vctMqMsqXp0BnUYn5C5KD
        egK8CL+3OwVswrfjQ9+f3ePx8w==
X-Google-Smtp-Source: APXvYqyYO5RxUVG/bXRqYescBr8YitSiwk6ahy0P0Apkt/Qsr+xKR6Zn0kyBe2qQk4SjmxlWjKkIeQ==
X-Received: by 2002:a5d:9d4a:: with SMTP id k10mr4619158iok.134.1576600957011;
        Tue, 17 Dec 2019 08:42:37 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y75sm6925426ill.87.2019.12.17.08.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 08:42:36 -0800 (PST)
Subject: Re: [PATCH 1/6] fs: add read support for RWF_UNCACHED
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com
References: <20191217143948.26380-1-axboe@kernel.dk>
 <20191217143948.26380-2-axboe@kernel.dk>
 <1d0bf482-8786-00b7-310d-4de38607786d@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb1112f5-01e7-4c6b-361c-213a919d9529@kernel.dk>
Date:   Tue, 17 Dec 2019 09:42:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1d0bf482-8786-00b7-310d-4de38607786d@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/17/19 8:16 AM, Guoqing Jiang wrote:
> 
> On 12/17/19 3:39 PM, Jens Axboe wrote:
>> If RWF_UNCACHED is set for io_uring (or preadv2(2)), we'll use private
>> pages for the buffered reads. These pages will never be inserted into
>> the page cache, and they are simply droped when we have done the copy at
>> the end of IO.
>>
>> If pages in the read range are already in the page cache, then use those
>> for just copying the data instead of starting IO on private pages.
>>
>> A previous solution used the page cache even for non-cached ranges, but
>> the cost of doing so was too high. Removing nodes at the end is
>> expensive, even with LRU bypass. On top of that, repeatedly
>> instantiating new xarray nodes is very costly, as it needs to memset 576
>> bytes of data, and freeing said nodes involve an RCU call per node as
>> well. All that adds up, making uncached somewhat slower than O_DIRECT.
>>
>> With the current*solition*, we're basically at O_DIRECT levels of
> 
> Maybe it is 'solution' here.

Indeed, fixed up, thanks.

-- 
Jens Axboe

