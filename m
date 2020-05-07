Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C3D1C9A7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 21:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgEGTFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 15:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGTFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 15:05:25 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C325C05BD43
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 12:05:25 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id 19so1645529ioz.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ALX0KlPOa5CmEMJbE+NcOQr52VcvkvocxSaJgPs417g=;
        b=Odrj/j3H0R7hU8+KYumKak54Bi+Nji00rmKhdstid0P4Ewljc7iDKHNEpARAT40gcH
         hzH0vj3WvTXm1ES6BIUNbnVw2YbUtEj9vl83wkIK26sOKxDubnJIlLmHbJ1mjPVGiK6b
         V1OEl8KM5n50UmVKne7i3ftrx8lMD6VoGvRH6+fK95wyRGwyZKJN3MlIz3wWy8IVhmQk
         mMBrDJSDXA5gBqgXRyntLHSM4Bx6J518MDCJ0dGdveW3Tgt0BO1sr6zDJc3v52Y35Gly
         r2SOi/5yoxTMcu8YaGwcTiCPZyC9uKNhDP3mmP0BIDXVx9OMi3OleEt5p85oOyO06FQb
         XmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ALX0KlPOa5CmEMJbE+NcOQr52VcvkvocxSaJgPs417g=;
        b=ePDPyhqFytS7ZXV5LDSdpdb7KySwj+0OrukRFKB0OSIttA3bld8AWhUU8e6x99pYjO
         Amt8r1CCGKuyQa6UNfrLQHah7IeyOkxkA1G520tVbuaiWssZHxdeQE1PjXf04yVLyLmK
         QcB7uclwAk9mjc6sVlvAGlYdTw2TqAksEB5f1UTxYGi4CYlZFtFnKMQrP4zF68P35OjE
         U2/SPTOYIMjzN+99oI7to5aKFUWmdYg3xq65MSaw0r3BQW3TXk4Cd6tVTjHr+YRJXE2t
         6qzNqFjQs/U+iKEb8AIxep+y535OfdaV+46Cg4MAZpcOD4cNUYVVsHaqCztBZIgmM2In
         jf8A==
X-Gm-Message-State: AGi0PuYwwajUQFaZ3Z2jlYnRDnWMnnpoebvzrC7HMWa04zt84KExaB1d
        V3O4XLMPmow40EyfbfbfhyNFHGN+VL8=
X-Google-Smtp-Source: APiQypIJCHCIpoM48c4qIZqQu9tdwVZS1I9D2iSqJLjDdhQcB6uT+NCdo27NSUgNnuII8pu0E8zfpA==
X-Received: by 2002:a6b:90f:: with SMTP id t15mr15169184ioi.188.1588878324422;
        Thu, 07 May 2020 12:05:24 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u16sm3076929ilg.55.2020.05.07.12.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 12:05:23 -0700 (PDT)
Subject: Re: [PATCH] fs/io_uring: fix O_PATH fds in openat, openat2, statx
To:     Al Viro <viro@zeniv.linux.org.uk>, Max Kellermann <mk@cm4all.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20200507185725.15840-1-mk@cm4all.com>
 <20200507190131.GF23230@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4cac0e53-656c-50f0-3766-ae3cc6c0310a@kernel.dk>
Date:   Thu, 7 May 2020 13:05:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507190131.GF23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/7/20 1:01 PM, Al Viro wrote:
> On Thu, May 07, 2020 at 08:57:25PM +0200, Max Kellermann wrote:
>> If an operation's flag `needs_file` is set, the function
>> io_req_set_file() calls io_file_get() to obtain a `struct file*`.
>>
>> This fails for `O_PATH` file descriptors, because those have no
>> `struct file*`
> 
> O_PATH descriptors most certainly *do* have that.  What the hell
> are you talking about?

Yeah, hence I was interested in the test case. Since this is
bypassing that part, was assuming we'd have some logic error
that attempted a file grab for a case where we shouldn't.

-- 
Jens Axboe

