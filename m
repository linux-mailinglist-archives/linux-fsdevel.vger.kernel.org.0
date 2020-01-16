Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3ED13E020
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgAPQaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 11:30:14 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44482 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgAPQaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:30:14 -0500
Received: by mail-io1-f67.google.com with SMTP id b10so22471534iof.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2020 08:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H0bxqq0C3ucXX8MRGglR7r12WdoPHtKKYN7fgSSxWGg=;
        b=H47NxRoDGlb9Xpk4hjnN3H5DX7/Y1nbHyooHSImAb/AuO91aQIFGkz5nukb3XJkFYv
         BCFJyRRwBEvzIYF9AfRc017mTLM9IhRny0GJr56Y/gybwsRwRQazXNKIwX42+sabdsLN
         X15X0BmyV6CSB6B1Y0jZ+xf0YMqxWgjogXUFVL8Y/KYiCwDz/+nV1XbCa9yYeU5MGCF8
         1T/UCC0X3pKY1oTWAPH2ZIvS3UdDEDvlcCzKmPNCOh3XoAgA/FTwnS5EKMetkIv9+Apq
         4JLhhIixxGEdCxKBIoAswpIjhjOkbeNcYmx9Vs77+dnLXnWv+kDj2QCiqbAPzVmQcn8D
         0Mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H0bxqq0C3ucXX8MRGglR7r12WdoPHtKKYN7fgSSxWGg=;
        b=N9eaeMqFSp6uBpNKjaSrp/6ZpPINn8cZjPGs824Cb9eRcBqfinifCq3SsE7QutbDvy
         qCYRlywgsdAUSZDjEnUV8cSrLPs8U1G+Akw3vwscyvUkiPMT0Mrq1YH+RhYFLe0Aq67m
         GFIodwSRe5ij3ks9xyQYJE0yrQMz99axIiM/lyWCU+q8/L6g2Brnqas1rVfewTplJe+L
         nJF01lEnmiJGbQBUIhsAgYF1QO5cEkEXsBwN/tkedFEP7OdIE+McdU5InaoZzvc4sz6s
         qqhAMr9RkE/tQrCw2hViS1CMKCgJd3TXoaI5f/YXUvqD86Do9gR2WqTfniWW4CT2RJWp
         eIoQ==
X-Gm-Message-State: APjAAAXvKoF/mUhQJjkszJYdLbUj44nYaOeKD7L0uP+MW8gnxv5tQbJK
        XN3jgmG7gbWdUtlJgmjBaABNt7160xw=
X-Google-Smtp-Source: APXvYqzhcTFfeK/8XtYJhf0WKLmiMNNTbsufwyWfMiIHFkki4IrO43BdrOKgAlrWUXZCft53+JVmMg==
X-Received: by 2002:a05:6602:1d1:: with SMTP id w17mr26645700iot.239.1579192213396;
        Thu, 16 Jan 2020 08:30:13 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l22sm7113816ilh.37.2020.01.16.08.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:30:13 -0800 (PST)
Subject: Re: [PATCH] io_uring: wakeup threads waiting for EPOLLOUT events
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200116134946.184711-1-sgarzare@redhat.com>
 <2d2dda92-3c50-ee62-5ffe-0589d4c8fc0d@kernel.dk>
 <20200116155557.mwjc7vu33xespiag@steredhat>
 <5723453a-9326-e954-978e-910b8b495b38@kernel.dk>
 <20200116162630.6r3xc55kdyyq5tvz@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a02a58dc-bf23-ed74-aec6-52c85360fe00@kernel.dk>
Date:   Thu, 16 Jan 2020 09:30:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116162630.6r3xc55kdyyq5tvz@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/16/20 9:26 AM, Stefano Garzarella wrote:
>> Since the use case is mostly single submitter, unless you're doing
>> something funky or unusual, you're not going to be needing POLLOUT ever.
> 
> The case that I had in mind was with kernel side polling enabled and
> a single submitter that can use epoll() to wait free slots in the SQ
> ring. (I don't have a test, maybe I can write one...)

Right, I think that's the only use case where it makes sense, because
you have someone else draining the sq side for you. A test case would
indeed be nice, liburing has a good arsenal of test cases and this would
be a good addition!

-- 
Jens Axboe

