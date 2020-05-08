Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEB31CB285
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgEHPH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 11:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHPH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 11:07:29 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AF8C061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2020 08:07:28 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id c18so1700861ile.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2020 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XfW90zo6T5KAPuSOZK0m1rceAYunAO3tCus7Ecsk/44=;
        b=DrZ7dJBMb2gXPW/MlynB0PhMDYS5RWpgZDN3qhCWiYnfMsQIs0JfrwfzCjqNFYgSgj
         siIgfrxvC4CefgaMBVAqwJXjVn0A/zoV+eEmn7OSIAK6GBpFkjIQQuLBuagyA/NUCwen
         3UywojBNh+0E6JpECOLO8Cc9n+XCDwqTHTFx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XfW90zo6T5KAPuSOZK0m1rceAYunAO3tCus7Ecsk/44=;
        b=V0t+V5/Dkfox/2kx/r7EbBofk5eI9xiNTIa29gQfhzhyx8rJF3qjWLMAE8m8yKREqz
         KlcZh7dKOjZAUZRs2egdVFHL0UvRNBkiTpABgwtmL3zFG4kXVzpyGNtqcW/QiGp2W7cd
         F4/8asrio3mWvf/kVCvHCPCtTe6y2fIp3iwXN0anzirTcL/dc7VedItSHfzWfaBOBa97
         Z7BT/LG+LxdJ8RawftQtJHybKTa0W7jgNfhMw0f0P4GNMpcXBM1omUu3CjbC/v+djiV8
         AijpwdqWGJ2XBg3YdwuTKMJtHFmjSDtNbf8hbvehrITE2ydP1YsVHlOcq82diPELzVbi
         ChPA==
X-Gm-Message-State: AGi0Pubxpznip56dpjGoKw/IrX9HMQdkzYgGgtqRX7dNzywv7bDlFNDY
        8Kczm1pvRbXYczke7HwiKqDE7A==
X-Google-Smtp-Source: APiQypLZ6wdxpHO7TnlOBfCn3vWaqdrCHX8bZENsqHjjjQiZYcM/1t27BVtHr2oouk546ImkXT2xWA==
X-Received: by 2002:a05:6e02:ca:: with SMTP id r10mr3308743ilq.41.1588950448273;
        Fri, 08 May 2020 08:07:28 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n65sm905604ila.69.2020.05.08.08.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 08:07:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] fs: avoid fdput() after failed fdget() in
 ksys_sync_file_range()
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     axboe@kernel.dk, zohar@linux.vnet.ibm.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1588894359.git.skhan@linuxfoundation.org>
 <31be6e0896eba59c06eb9d3d137b214f7220cc53.1588894359.git.skhan@linuxfoundation.org>
 <20200508000509.GK23230@ZenIV.linux.org.uk>
 <20200508002422.GL23230@ZenIV.linux.org.uk>
 <20200508022139.GD11244@42.do-not-panic.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7d3e7bf5-22e4-ab3d-798e-33d3657e1cf1@linuxfoundation.org>
Date:   Fri, 8 May 2020 09:07:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508022139.GD11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/7/20 8:21 PM, Luis Chamberlain wrote:
> On Fri, May 08, 2020 at 01:24:22AM +0100, Al Viro wrote:
>> On Fri, May 08, 2020 at 01:05:09AM +0100, Al Viro wrote:
>>> On Thu, May 07, 2020 at 05:57:09PM -0600, Shuah Khan wrote:
>>>> Fix ksys_sync_file_range() to avoid fdput() after a failed fdget().
>>>> fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
>>>> in fd.flags. Fix it anyway since failed fdget() doesn't require
>>>> a fdput().
>>>>
>>>> This was introdcued in a commit to add sync_file_range() helper.
>>>
>>> Er...  What's the point microoptimizing the slow path here?
>>
>> PS: I'm not saying the patch is incorrect, but Fixes: is IMO over the
>> top.  And looking at that thing,
>> {
>>          struct fd f = fdget(fd);
>>          int ret;
>>
>> 	if (unlikely(!f.file))
>> 		return -EBADF;
>>
>> 	ret = sync_file_range(f.file, offset, nbytes, flags);
>>          fdput(f);
>>          return ret;
>> }
>>
>> might be cleaner, but that's a matter of taste...
> 
> This makes it easier to read.
> 

Yes it does. I will make the changes and send v2.

thanks,
-- Shuah


