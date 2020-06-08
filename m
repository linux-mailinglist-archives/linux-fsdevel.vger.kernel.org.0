Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE881F21D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 00:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgFHW3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 18:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgFHW3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:29:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CEBC08C5C2
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2020 15:29:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so7199765pld.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2020 15:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ivfzr79vmJM2ezUGqOHZFSzxnQToj12hwiva2AjxDYk=;
        b=YsGDe0JsHjrhCdZfhLSt+zXND+h5/vcEmVjSaGonV8inAFYY2m6YDRobjI4HRJ16kW
         LxARXowlzaNoerKwRoTiT7xgryv5CVO4/qugFUasKxbLS7jXkvbjS9gkuSalDnBUvniq
         ixYgSQ7tGlOF8FSM/PVKb4CbMYUkHpy8rntWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ivfzr79vmJM2ezUGqOHZFSzxnQToj12hwiva2AjxDYk=;
        b=ZDlzaFFYK6vO5OtQ8HBzyn25TIMpAVM7ZqaRq4gU2VTCPKADarXazUW+L4sdzTq/Wt
         /CHgY/uw41ao4KHuT59UBTelalu9pVftUJT/QxiKPKRgfJZ3hHNlZWFoNsE91imuQfQe
         XD4YuOzLvlWVD/v9Gbb6WpSRVagRqXZE7v4ugypTzLwdGqj8GAePrrhIny5LGxtpkZtA
         m4B8dRzf/ea2FAGn9jr6FjsKRozwbDFxJAI/2Xw9p9fqNHyIaCAZKmH0sXqjU5FOk8Uk
         a5oxy6XH+Zbbp4avrEQPpTGGY6P4myriZbR21Npt6CcmMvdI9kZJqjfO37IER5JNCySQ
         Gmnw==
X-Gm-Message-State: AOAM5307mqzvuREOKOyL5JmOq0zYYc7TbpKBLrC1h/ZTh4RhKUvsPQT/
        Sh0pdIM1g47zfkdS1CIVKGXbDw==
X-Google-Smtp-Source: ABdhPJwKi2BxlrETO2znZc4aO5UDzp8kr5PBqQNwoJ+QnwSe4jXBo2gq9ETf+gqzDgFASjIn4X+7Ow==
X-Received: by 2002:a17:902:7c8f:: with SMTP id y15mr739497pll.95.1591655378632;
        Mon, 08 Jun 2020 15:29:38 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a14sm7807017pfc.133.2020.06.08.15.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 15:29:37 -0700 (PDT)
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
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <ea16c19e-bd60-82ec-4825-05e233667f9f@broadcom.com>
Date:   Mon, 8 Jun 2020 15:29:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200606155216.GP19604@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

I am requesting the experts in the filesystem subsystem to come to a 
consensus here.
This is not my area of expertise at all but every time I have addressed 
all of the
outstanding concerns someone else comes along and raises another one.

Please see me comments below.

On 2020-06-06 8:52 a.m., Matthew Wilcox wrote:
> On Fri, Jun 05, 2020 at 10:04:51PM -0700, Scott Branden wrote:
>> -int kernel_read_file(struct file *file, void **buf, loff_t *size,
>> -		     loff_t max_size, enum kernel_read_file_id id)
>> -{
>> -	loff_t i_size, pos;
Please note that how checkpatch generated the diff here.  The code 
modifications
below are for a new function kernel_pread_file, they do not modify the 
existing API
kernel_read_file.  kernel_read_file requests the ENTIRE file is read.  
So we need to be
able to differentiate whether it is ok to read just a portion of the 
file or not.
>> +int kernel_pread_file(struct file *file, void **buf, loff_t *size,
>> +		      loff_t pos, loff_t max_size,
>> +		      enum kernel_pread_opt opt,
>> +		      enum kernel_read_file_id id)
So, to share common code a new kernel_pread_opt needed to be added in 
order to specify whether
it was ok to read a partial file or not, and provide an offset into the 
file where to begin reading.
The meaning of parameters doesn't change in the bonkers API. max_size 
still means max size, etc.
These options are needed so common code can be shared with 
kernel_read_file api.

The partial read option is then needed further in the depths of the 
kernel read for IMA operation as IMA does
things differently for optimization of whether it is OK to do a partial 
read of the file or not.
>> +{
>> +	loff_t alloc_size;
>> +	loff_t buf_pos;
>> +	loff_t read_end;
>> +	loff_t i_size;
>>   	ssize_t bytes = 0;
>>   	int ret;
>>   
> Look, it's not your fault, but this is a great example of how we end
> up with atrocious interfaces.  Someone comes along and implements a
> simple DWIM interface that solves their problem.  Then somebody else
> adds a slight variant that solves their problem, and so on and so on,
> and we end up with this bonkers API where the arguments literally change
> meaning depending on other arguments.
I don't see what arguments are changing meaning.  Please explain what is 
changing meaning.
The diff below is for kernel_pread_file, not kernel_read_file. Perhaps 
that is where your confusion is.
>
>> @@ -950,21 +955,31 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>>   		ret = -EINVAL;
>>   		goto out;
>>   	}
>> -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
>> +
>> +	/* Default read to end of file */
>> +	read_end = i_size;
>> +
>> +	/* Allow reading partial portion of file */
>> +	if ((opt == KERNEL_PREAD_PART) &&
>> +	    (i_size > (pos + max_size)))
>> +		read_end = pos + max_size;
>> +
>> +	alloc_size = read_end - pos;
>> +	if (i_size > SIZE_MAX || (max_size > 0 && alloc_size > max_size)) {
>>   		ret = -EFBIG;
>>   		goto out;
> ... like that.
like what?  We need to determine how much of the file to read based on 
size of file, position in file, and max size we can read.
>
> I think what we actually want is:
>
> ssize_t vmap_file_range(struct file *, loff_t start, loff_t end, void **bufp);
> void vunmap_file_range(struct file *, void *buf);
>
> If end > i_size, limit the allocation to i_size.  Returns the number
> of bytes allocated, or a negative errno.  Writes the pointer allocated
> to *bufp.  Internally, it should use the page cache to read in the pages
> (taking appropriate reference counts).  Then it maps them using vmap()
> instead of copying them to a private vmalloc() array.
> kernel_read_file() can be converted to use this API.  The users will
> need to be changed to call kernel_read_end(struct file *file, void *buf)
> instead of vfree() so it can call allow_write_access() for them.
>
> vmap_file_range() has a lot of potential uses.  I'm surprised we don't
> have it already, to be honest.
Such a change sounds like it could be done in a later patch series.
It's an incomplete solution.  It would work for some of the needed 
operations but not others.
For kernel_read_file, I don't see how in your new API it indicates if 
the end of the file was reached or not.
Also, please note that buffers may be preallocated  and shouldn't be 
freed by the kernel in some cases and
allocated and freed by the kernel in others.

Your proposed change doesn't exist and is not simple as it sounds or 
meet all the needs of the existing kernel_read_file
function, IMA, and new partial kernel_pread_file?

Patch v7 does not break existing functions or rearchitect things in a 
dramatic way.  They fit into existing code,
will not break the existing codepaths (which some didn't even have a 
test case until I added one), and can
be improved upon as need with your vmap_file_range or others once those 
have been developed, tested, and
proven by someone.

I would like the experts here to decide on what needs to be done so we 
can move forward
and get kernel_pread_file support added soon.
Thanks,
Scott
