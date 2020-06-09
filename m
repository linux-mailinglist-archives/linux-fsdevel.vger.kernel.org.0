Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6A41F49A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 00:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgFIWz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 18:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgFIWz0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:55:26 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F86C05BD1E
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 15:55:25 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so358322ejd.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2020 15:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LYBqerZassKlqNTxy3as16L4QGqXx7iCtOa8miVjhI8=;
        b=AaHx/ZOa9ijt0PdstPCqR8gBnbdFESmopPjGBDGxffkQDRZL90jPY01sy1MWqGcObY
         87HwROzIZQ1L2Q8YQ484vcTEd7UOjhD9Mh94qQSIgwWMA2uHWRbBLDUTAa5IfouA/y67
         bTJJY6ohZDhx97w2+JHLpCjKB9x/XZi6Tvn/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LYBqerZassKlqNTxy3as16L4QGqXx7iCtOa8miVjhI8=;
        b=bcTpFkvPZyGkyPuRKibv+lKLjMaeD760xyVfsnmr1cq1RldYU8WdGyYKPugPc5mzTB
         gJmgenXPywkvFXNjzuiXZINdkaSqUUVk1keW/bbecBn+eRc6VSywRGSkFgYyzK39dgkf
         PD7kl25Q6R/wZrmg9awACEjnl7cAu9hJic0uS2G9AXnpdAOrqeqDyQcwGTADaW/qfS2M
         R8Dxo8OiAsOBUzhfe+3O7YJQ5MA8F3px1r6K+bT4JG76OU38cOoe+V6TADDgJXJScWRU
         nWZzpsqEDhdUu2nWzU9qZxchu1mDgzPD/f4XTWBGJQMVjeKGF3pYcNGa/KMmqi3l/l+R
         j/Vg==
X-Gm-Message-State: AOAM530k+pGHvJz2apPK7h1U4N89B0VZsSmCqf6G63QQjbQMdp2uovvZ
        wZ8jt9wPHhlZ0UuOlMUTP+GOQw==
X-Google-Smtp-Source: ABdhPJwjSrIRSIC7d+hmQ2dLRib2BwauXuZ6u2RlliwND0Gn7sBoGqarx5XYRfMDchpEAnJnjtTpgg==
X-Received: by 2002:a17:906:1c02:: with SMTP id k2mr592170ejg.37.1591743323900;
        Tue, 09 Jun 2020 15:55:23 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id ck11sm14207643ejb.41.2020.06.09.15.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 15:55:23 -0700 (PDT)
Subject: Re: [PATCH v7 1/8] fs: introduce kernel_pread_file* support
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <20200606050458.17281-1-scott.branden@broadcom.com>
 <20200606050458.17281-2-scott.branden@broadcom.com>
 <20200606155216.GP19604@bombadil.infradead.org>
 <ea16c19e-bd60-82ec-4825-05e233667f9f@broadcom.com>
 <20200609132151.GC19604@bombadil.infradead.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <c983b910-d216-559a-60b5-dc8b4b2435a2@broadcom.com>
Date:   Tue, 9 Jun 2020 15:55:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609132151.GC19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On 2020-06-09 6:21 a.m., Matthew Wilcox wrote:
> On Mon, Jun 08, 2020 at 03:29:22PM -0700, Scott Branden wrote:
>> Hi Matthew,
>>
>> I am requesting the experts in the filesystem subsystem to come to a
>> consensus here.
>> This is not my area of expertise at all but every time I have addressed all
>> of the
>> outstanding concerns someone else comes along and raises another one.
> I appreciate it's frustrating for you, but this is the nature of
> patch review.  I haven't even read the first five or so submissions.
> I can see them in my inbox and they look like long threads.  I'm not
> particularly inclined to read them.  I happened to read v6, and reacted
> to the API being ugly.
Thanks for the review.  Yes, I do see the enum being ugly now
and have removed it in v8 of the patch.  Hopefully it addresses
your concerns.  More comments below.
>
>> Please see me comments below.
>>
>> On 2020-06-06 8:52 a.m., Matthew Wilcox wrote:
>>> On Fri, Jun 05, 2020 at 10:04:51PM -0700, Scott Branden wrote:
>>>> -int kernel_read_file(struct file *file, void **buf, loff_t *size,
>>>> -		     loff_t max_size, enum kernel_read_file_id id)
>>>> -{
>>>> -	loff_t i_size, pos;
>> Please note that how checkpatch generated the diff here.  The code
>> modifications
>> below are for a new function kernel_pread_file, they do not modify the
>> existing API
>> kernel_read_file.  kernel_read_file requests the ENTIRE file is read.  So we
>> need to be
>> able to differentiate whether it is ok to read just a portion of the file or
>> not.
> You've gone about this in entirely the wrong way though.  This enum to
> read the entire file or a partial is just bad design.
Your point on the enum is valid.
I've removed it from design.  Hopefully it is cleaner now.
>
>>>> +int kernel_pread_file(struct file *file, void **buf, loff_t *size,
>>>> +		      loff_t pos, loff_t max_size,
>>>> +		      enum kernel_pread_opt opt,
>>>> +		      enum kernel_read_file_id id)
>> So, to share common code a new kernel_pread_opt needed to be added in order
>> to specify whether
>> it was ok to read a partial file or not, and provide an offset into the file
>> where to begin reading.
>> The meaning of parameters doesn't change in the bonkers API. max_size still
>> means max size, etc.
>> These options are needed so common code can be shared with kernel_read_file
>> api.
> Does pread() in userspace take seven parameters?  No.  It takes four.
> What you're doing is taking all the complexity of all of the interfaces
> and stuffing it all down into the bottom function instead of handling
> some of the complexity in the wrapper functions.  For example, you
> could support the functionality of 'max_size' in kernel_read_file()
> and leave it out of the kernel_pread_file() interface.
I have removed the enum necessary in the kernel pread call now,
so it is down to 6.
The other 2 parameters are necessary as they are in kernel read.

max_size makes no sense to remove - it serves the same purpose
as in userspace pread and read functions.  To specify the max size
to read.
>>> I think what we actually want is:
>>>
>>> ssize_t vmap_file_range(struct file *, loff_t start, loff_t end, void **bufp);
>>> void vunmap_file_range(struct file *, void *buf);
>>>
>>> If end > i_size, limit the allocation to i_size.  Returns the number
>>> of bytes allocated, or a negative errno.  Writes the pointer allocated
>>> to *bufp.  Internally, it should use the page cache to read in the pages
>>> (taking appropriate reference counts).  Then it maps them using vmap()
>>> instead of copying them to a private vmalloc() array.
>>> kernel_read_file() can be converted to use this API.  The users will
>>> need to be changed to call kernel_read_end(struct file *file, void *buf)
>>> instead of vfree() so it can call allow_write_access() for them.
>>>
>>> vmap_file_range() has a lot of potential uses.  I'm surprised we don't
>>> have it already, to be honest.
>> Such a change sounds like it could be done in a later patch series.
>> It's an incomplete solution.  It would work for some of the needed
>> operations but not others.
>> For kernel_read_file, I don't see how in your new API it indicates if the
>> end of the file was reached or not.
> That's the point.  It doesn't.  If a caller needs that, then they can
> figure that out themselves.
No, they can't.  The caller only calls kernel_read_file once and expects
the whole file to be read.  The kernel_read_file doesn't work like 
userspace.
There is no tracking like userspace of where in the file you read?
>
>> Also, please note that buffers may be preallocated  and shouldn't be freed
>> by the kernel in some cases and
>> allocated and freed by the kernel in others.
> You're trying to build the swiss army knife of functions.  Swiss army
> knives are useful, but they're no good for carving a steak.
Hopefully I'm carving steak now.
>> I would like the experts here to decide on what needs to be done so we can
>> move forward
>> and get kernel_pread_file support added soon.
> You know, you haven't even said _why_ you want this.  The cover letter
> just says "I want this", and doesn't say why it's needed.
Cover letter updated.

Thanks,
Scott
