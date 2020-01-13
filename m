Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 843E91396E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 17:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgAMQ6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 11:58:12 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37873 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgAMQ6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:58:12 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so10542903ioc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2020 08:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n2qCWY9dDm8azp3DnmT/BcaCngFCq3W2JQHBtzBAlYY=;
        b=eRQXTp5+Fdsol+TwBhKVu36c+xEsubHFLEjWy9QFVzU1tB6qIF8pVl20WHhmQVxRFC
         yZMw4hZJpVz1PjtQbwHArQY38aNPdjVMS3CXL+JfvCw7iXwiZ41JMzuSjtpp7/RSUv25
         9vlS42r4EFT/QDwNGKJ9WLEgRuxUvroVRjD/tG9aHzVZVjzbZqEwyTm8LfqfyT6550Zd
         Al1MTC1QA2+JfmQQPqAHN/SHpOfgI1HXxP75fLNYbB+zSYPRRxqY7ACrh3Xj70tA6lQN
         Ef7nr8UozdVnu1wEdVOFSmQhtZVQqz9o36szU/uaAKGdLLb9jDo4OgzDl2FRFVJk8rU1
         4/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n2qCWY9dDm8azp3DnmT/BcaCngFCq3W2JQHBtzBAlYY=;
        b=oBZMqbqM0eI0Bu/WJx5NzEJJyoVEziJ/rbluaAhbtR0IS+1JurHhtpfIabDG8Z6PVj
         Umnl7miCzMAnc+Tm8sTJNWXjGPH5xEcgiyODIISpRHiLsgd8GslNTbQFlZxufXbGU38/
         8MclTmgR4XDg8apsRO9i+xoNeXwGISmngHn1eYG0SH5F69fPsdPXA9M60M5Tn1IUU6X3
         +5N5m0y2dFbPBat6kuNV1RNUkBcdyhnOa5Y5AAqjPSMmh7PMKOKS2hLWfImWjlUX6fYD
         TvfVlMAm0yi0L0aIGyQUndAgTHwNsIcajjmA2wXowV1q1BY8GBa0GSiQClohbAVuZimG
         iEjQ==
X-Gm-Message-State: APjAAAXiFT93t5mvebbCqY9P3wYSCXkgUuG7Quy6w1dwiCC3rvKK+jSS
        sSgbIsf9D/mo+f6IhmshUVCuKQ==
X-Google-Smtp-Source: APXvYqwyrhFsN2dBByOa3+7fTRrG+lp40kkZ9OndzVXmXHA7PqNVLg5aZ5lupvygNfFAdzHsiBTTaQ==
X-Received: by 2002:a5e:920a:: with SMTP id y10mr13634213iop.292.1578934691437;
        Mon, 13 Jan 2020 08:58:11 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m24sm2875133ioc.37.2020.01.13.08.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 08:58:10 -0800 (PST)
Subject: Re: [PATCH 3/3] io_uring: add IORING_OP_MADVISE
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20200110154739.2119-1-axboe@kernel.dk>
 <20200110154739.2119-4-axboe@kernel.dk>
 <a9a6be4f-2d81-7634-a2f5-38341f718a7e@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7bf2e663-eb82-d8d5-304b-d06e183de235@kernel.dk>
Date:   Mon, 13 Jan 2020 09:58:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a9a6be4f-2d81-7634-a2f5-38341f718a7e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/12/20 2:39 PM, Pavel Begunkov wrote:
> On 10/01/2020 18:47, Jens Axboe wrote:
>> This adds support for doing madvise(2) through io_uring. We assume that
>> any operation can block, and hence punt everything async. This could be
>> improved, but hard to make bullet proof. The async punt ensures it's
>> safe.
>>
> I don't like that it share structs/fields names with fadvise. E.g. madvise's
> context is called struct io_fadvise. Could it at least have fadvise_advice filed
> in struct io_uring_sqe? io_uring parts of the patchset look good.
> 
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

Thanks, I can add the separate union, not a big deal.

-- 
Jens Axboe

