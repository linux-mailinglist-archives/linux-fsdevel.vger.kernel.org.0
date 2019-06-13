Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9AFD43EF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbfFMPx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:53:59 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41183 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731590AbfFMI5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:57:07 -0400
Received: by mail-yb1-f196.google.com with SMTP id d2so7522858ybh.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2019 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5rpwm+WXYqpS5Yt4a3EFiaLIxY1PzE0lEAcH6B/6h0A=;
        b=fXL4Bw5Kwl/mMKIWGa1cdKDK4KAo0XR2yGRH64ZJ/I1MVExg0wWUUDX3vBHTYZkjOF
         vYFKvyecLJNLSA/E7m7sTD8zh55AOz/agx/OfhCByMjAe9qffdMIJXqrpeOoxi+v3NkU
         sXmf687D6xOZ2qyVaV0Av3gvkn68lJwqr/d2PEpnz/YSD7pg1u3UtvyzLDx4Mi3w75OR
         HJJI+g/bVt6L2m1CG0hBdOwJes2EebjVxjs/giB7QyWUieZGe5ei2HyxPmHI0pV+dWgb
         1hEim2OLo6wzfu6Jcv47M0Q4ZvWL5BNXddHdsTUs3Eu/hfMQJY2po5LVVP9PbG0vjMfb
         rW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5rpwm+WXYqpS5Yt4a3EFiaLIxY1PzE0lEAcH6B/6h0A=;
        b=t99xFip5qnyzGKe2v7ekFBGbzpvQgCBOJM5MdW5a2w/lXc2yCnBrWS7jojtAm0LQWB
         dQFC4aN2Yhns7ElC6omFpH0nge7YJFfS3tLMRSFHDFjqsrji4lPxTDvk2kindydS5tlR
         6rdhD4/RlEEmZQGfZEbuk4UDrWdGrSqMW8AkqPoWySjNx1XVnjyKJeXz0p6y17VtK2ut
         cMMajOC02GMS/3snEMg0Ui5K0rR4c9R8T0zjptsM76M5ESMZkEFdTrdZuUNvdA157koj
         +/DNEZ4xJh2JoU3sABkAz5+Wa3V8Pe5vo3qdJu7QdKXOMSYfXPGMzudsap4VObFLgmVb
         IhXw==
X-Gm-Message-State: APjAAAUmQnN+TUvXBnGD3Mc8XALD3iOYWw1xBKzdtkkkpHjqDFfndtG1
        /9UcDHUASbPuxAZbZgdCRruhag==
X-Google-Smtp-Source: APXvYqw1zJomCCuCV1QnOnfqSwphH8qY2fZ84XDZGajBAG2kedoKa5gZ+d1vm3seCvUptjeuiel9rQ==
X-Received: by 2002:a5b:b8b:: with SMTP id l11mr40277348ybq.165.1560416227034;
        Thu, 13 Jun 2019 01:57:07 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id i199sm607899ywe.89.2019.06.13.01.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 01:57:06 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix SQPOLL cpu check
To:     Stephen Bates <sbates@raithlin.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shhuiw@foxmail.com" <shhuiw@foxmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <5D2859FE-DB39-48F5-BBB5-6EDD3791B6C3@raithlin.com>
 <20190612092403.GA38578@lakrids.cambridge.arm.com>
 <DCE71F95-F72A-414C-8A02-98CC81237F40@raithlin.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b3c9138e-bf3b-0851-a63e-f52f926d5ed8@kernel.dk>
Date:   Thu, 13 Jun 2019 02:54:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <DCE71F95-F72A-414C-8A02-98CC81237F40@raithlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/12/19 3:47 AM, Stephen  Bates wrote:
>> Aargh. My original patch [1] handled that correctly, and this case was
>> explicitly called out in the commit message, which was retained even
>> when the patch was "simplified". That's rather disappointing. :/
>    
> It looks like Jens did a fix for this (44a9bd18a0f06bba
> " io_uring: fix failure to verify SQ_AFF cpu") which is in the 5.2-rc series
> but which hasn’t been applied to the stable series yet. I am not sure how
> I missed that but it makes my patch redundant.
> 
> Jens, will 44a9bd18a0f06bba be applied to stable kernels?

Yes, we can get it flagged for stable. Greg, can you pull in the above
commit for 5.1 stable?


-- 
Jens Axboe

