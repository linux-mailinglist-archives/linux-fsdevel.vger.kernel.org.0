Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39383217DD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 06:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgGHEBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 00:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgGHEBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:01:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5530AC061755
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 21:01:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dr13so48902742ejc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 21:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iS+uNXYPY26KqkhXGAUgcP6coEJuRxsiMtPW4MUxU0s=;
        b=XK3KlUh4/W0DUCgaiMXTJHxu6D0kpSY58oYj+vkMpdKWNEZgk7QvvlSxjKQZ+TpLSD
         25fuLWRNGXaiUpaseIUVKI2kK+k/g/1YUy2JA80pNgxdhvsWCYWVNH3whpnap5l5a+BO
         kgBudmroHFFYjmJ3rfiO+PJPpLZpcvx785Ox0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iS+uNXYPY26KqkhXGAUgcP6coEJuRxsiMtPW4MUxU0s=;
        b=oGdF5kLnrIOGnlMD8sMN8RorDBEEmSKWnoCE0L6M3nK4exFKBbQFcxSEx1kJZwZN56
         wqTSbaoYnxBe8hOwRLUFn7IDE2HfA5Ho78z7o9UhUfzx/lFZHY5Qd7WWVZyhK7UB0mCx
         OpNrvwjMYEO0G2IEA270SiM+X9uavAHuybDLusBq91Jjo31kPzsxWXP1Om9K8rlngpdL
         6H4uAaThvlts+jVb7aqEoeBJZfk16IpuStGLrJ6TwIhEJStrVhGb/jEAdlqiIsvtguEO
         FuE3577tdzLRcsMGl1UYorR6K4hVyd1Qxqg6GK99EvxuSxi5xSsvhevAY8ZLkehr6lqU
         y/Tg==
X-Gm-Message-State: AOAM530qRMtxp24A4NwddaR55WKB5Yu8w2CBPNDUm/MnQdyvi/QBvFYp
        uMJMfsMpsom1bxUVGSyKlSvBMw==
X-Google-Smtp-Source: ABdhPJzINX7bVcpaG3QdY0rMXkXqp0pOAP8UsPUPqwKzcc1zUZKNkb7HEgSyYeMiDi1Qh3RR2vC+LQ==
X-Received: by 2002:a17:906:3bd5:: with SMTP id v21mr48157684ejf.329.1594180870873;
        Tue, 07 Jul 2020 21:01:10 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b98sm27827514edf.24.2020.07.07.21.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 21:01:10 -0700 (PDT)
Subject: Re: [PATCH v10 2/9] fs: introduce kernel_pread_file* support
To:     Kees Cook <keescook@chromium.org>
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
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-3-scott.branden@broadcom.com>
 <202007071642.AA705B2A@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <42169718-d1b8-27f8-eeee-6cdef75a30d9@broadcom.com>
Date:   Tue, 7 Jul 2020 21:01:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202007071642.AA705B2A@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-07-07 4:56 p.m., Kees Cook wrote:
> On Mon, Jul 06, 2020 at 04:23:02PM -0700, Scott Branden wrote:
>> Add kernel_pread_file* support to kernel to allow for partial read
>> of files with an offset into the file.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   fs/exec.c                        | 93 ++++++++++++++++++++++++--------
>>   include/linux/kernel_read_file.h | 17 ++++++
>>   2 files changed, 87 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 4ea87db5e4d5..e6a8a65f7478 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -928,10 +928,14 @@ struct file *open_exec(const char *name)
>>   }
>>   EXPORT_SYMBOL(open_exec);
>>   
>> -int kernel_read_file(struct file *file, void **buf, loff_t *size,
>> -		     loff_t max_size, enum kernel_read_file_id id)
>> -{
>> -	loff_t i_size, pos;
>> +int kernel_pread_file(struct file *file, void **buf, loff_t *size,
>> +		      loff_t max_size, loff_t pos,
>> +		      enum kernel_read_file_id id)
>> +{
>> +	loff_t alloc_size;
>> +	loff_t buf_pos;
>> +	loff_t read_end;
>> +	loff_t i_size;
>>   	ssize_t bytes = 0;
>>   	int ret;
>>   
>> @@ -951,21 +955,32 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>>   		ret = -EINVAL;
>>   		goto out;
>>   	}
>> -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
>> +
>> +	/* Default read to end of file */
>> +	read_end = i_size;
>> +
>> +	/* Allow reading partial portion of file */
>> +	if ((id == READING_FIRMWARE_PARTIAL_READ) &&
>> +	    (i_size > (pos + max_size)))
>> +		read_end = pos + max_size;
> There's no need to involve "id" here. There are other signals about
> what's happening (i.e. pos != 0, max_size != i_size, etc).
There are other signals other than the fact that kernel_read_file requires
the entire file to be read while kernel_pread_file allows partial files 
to be read.
So if you do a pread at pos = 0 you need another key to indicate it is 
"ok" if max_size < i_size.
If id == READING_FIRMWARE_PARTIAL_READ is removed (and we want to share 
99% of the code
between kernel_read_file and kernel_pread_file then I need to add 
another parameter to a common function
called between these functions.  And adding another parameter was 
rejected previously in the review as a "swiss army knife approach" by 
another reviewer.  I am happy to add it back in because it is necessary 
to share code and differentiate whether we are performing a partial read 
or not.
>
>> +
>> +	alloc_size = read_end - pos;
>> +	if (i_size > SIZE_MAX || (max_size > 0 && alloc_size > max_size)) {
>>   		ret = -EFBIG;
>>   		goto out;
>>   	}
>>   
>> -	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
>> -		*buf = vmalloc(i_size);
>> +	if ((id != READING_FIRMWARE_PARTIAL_READ) &&
>> +	    (id != READING_FIRMWARE_PREALLOC_BUFFER))
>> +		*buf = vmalloc(alloc_size);
>>   	if (!*buf) {
>>   		ret = -ENOMEM;
>>   		goto out;
>>   	}
> The id usage here was a mistake in upstream, and the series I sent is
> trying to clean that up.
I see that cleanup and it works fine with the pread.  Other than I need 
some sort of key to share code and indicate whether it is "ok" to do a 
partial read of the file or not.
>
> Greg, it seems this series is going to end up in your tree due to it
> being drivers/misc? I guess I need to direct my series to Greg then, but
> get LSM folks Acks.
>
>>   
>> -	pos = 0;
>> -	while (pos < i_size) {
>> -		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
>> +	buf_pos = 0;
>> +	while (pos < read_end) {
>> +		bytes = kernel_read(file, *buf + buf_pos, read_end - pos, &pos);
>>   		if (bytes < 0) {
>>   			ret = bytes;
>>   			goto out_free;
>> @@ -973,20 +988,23 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>>   
>>   		if (bytes == 0)
>>   			break;
>> +
>> +		buf_pos += bytes;
>>   	}
>>   
>> -	if (pos != i_size) {
>> +	if (pos != read_end) {
>>   		ret = -EIO;
>>   		goto out_free;
>>   	}
>>   
>> -	ret = security_kernel_post_read_file(file, *buf, i_size, id);
>> +	ret = security_kernel_post_read_file(file, *buf, alloc_size, id);
>>   	if (!ret)
>>   		*size = pos;
> This call cannot be inside kernel_pread_file(): any future LSMs will see
> a moving window of contents, etc. It'll need to be in kernel_read_file()
> proper.
If IMA still passes (after testing my next patch series with your 
changes and my modifications)
I will need some more help here.
>
>>   
>>   out_free:
>>   	if (ret < 0) {
>> -		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
>> +		if ((id != READING_FIRMWARE_PARTIAL_READ) &&
>> +		    (id != READING_FIRMWARE_PREALLOC_BUFFER)) {
>>   			vfree(*buf);
>>   			*buf = NULL;
>>   		}
>> @@ -996,10 +1014,18 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>>   	allow_write_access(file);
>>   	return ret;
>>   }
>> +
>> +int kernel_read_file(struct file *file, void **buf, loff_t *size,
>> +		     loff_t max_size, enum kernel_read_file_id id)
>> +{
>> +	return kernel_pread_file(file, buf, size, max_size, 0, id);
>> +}
>>   EXPORT_SYMBOL_GPL(kernel_read_file);
>>   
>> -int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
>> -			       loff_t max_size, enum kernel_read_file_id id)
>> +int kernel_pread_file_from_path(const char *path, void **buf,
>> +				loff_t *size,
>> +				loff_t max_size, loff_t pos,
>> +				enum kernel_read_file_id id)
>>   {
>>   	struct file *file;
>>   	int ret;
>> @@ -1011,15 +1037,22 @@ int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
>>   	if (IS_ERR(file))
>>   		return PTR_ERR(file);
>>   
>> -	ret = kernel_read_file(file, buf, size, max_size, id);
>> +	ret = kernel_pread_file(file, buf, size, max_size, pos, id);
>>   	fput(file);
>>   	return ret;
>>   }
>> +
>> +int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
>> +			       loff_t max_size, enum kernel_read_file_id id)
>> +{
>> +	return kernel_pread_file_from_path(path, buf, size, max_size, 0, id);
>> +}
>>   EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
>>   
>> -int kernel_read_file_from_path_initns(const char *path, void **buf,
>> -				      loff_t *size, loff_t max_size,
>> -				      enum kernel_read_file_id id)
>> +int kernel_pread_file_from_path_initns(const char *path, void **buf,
>> +				       loff_t *size,
>> +				       loff_t max_size, loff_t pos,
>> +				       enum kernel_read_file_id id)
>>   {
>>   	struct file *file;
>>   	struct path root;
>> @@ -1037,14 +1070,22 @@ int kernel_read_file_from_path_initns(const char *path, void **buf,
>>   	if (IS_ERR(file))
>>   		return PTR_ERR(file);
>>   
>> -	ret = kernel_read_file(file, buf, size, max_size, id);
>> +	ret = kernel_pread_file(file, buf, size, max_size, pos, id);
>>   	fput(file);
>>   	return ret;
>>   }
>> +
>> +int kernel_read_file_from_path_initns(const char *path, void **buf,
>> +				      loff_t *size, loff_t max_size,
>> +				      enum kernel_read_file_id id)
>> +{
>> +	return kernel_pread_file_from_path_initns(path, buf, size, max_size, 0, id);
>> +}
>>   EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
>>   
>> -int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
>> -			     enum kernel_read_file_id id)
>> +int kernel_pread_file_from_fd(int fd, void **buf, loff_t *size,
>> +			      loff_t max_size, loff_t pos,
>> +			      enum kernel_read_file_id id)
>>   {
>>   	struct fd f = fdget(fd);
>>   	int ret = -EBADF;
>> @@ -1052,11 +1093,17 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
>>   	if (!f.file)
>>   		goto out;
>>   
>> -	ret = kernel_read_file(f.file, buf, size, max_size, id);
>> +	ret = kernel_pread_file(f.file, buf, size, max_size, pos, id);
>>   out:
>>   	fdput(f);
>>   	return ret;
>>   }
>> +
>> +int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
>> +			     enum kernel_read_file_id id)
>> +{
>> +	return kernel_pread_file_from_fd(fd, buf, size, max_size, 0, id);
>> +}
>>   EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
> For each of these execution path, the mapping to LSM hooks is:
>
> - all path must call security_kernel_read_file(file, id) before reading
>    (this appears to be fine as-is in your series).
>
> - anything doing a "full" read needs to call
>    security_kernel_post_read_file() with the file and full buffer, size,
>    etc (so all the kernel_read_file*() paths). I imagine instead of
>    adding 3 copy/pasted versions of this, it may be possible to refactor
>    the helpers into a single core "full" caller that takes struct file,
>    or doing some logic in kernel_pread_file() that notices it has the
>    entire file in the buffer and doing the call then.
>    As an example of what I mean about doing the call, here's how I might
>    imagine it for one of the paths if it took struct file:
>
> int kernel_read_file_from_file(struct file *file, void **buf, loff_t *size,
> 			       loff_t max_size, enum kernel_read_file_id id)
> {
> 	int ret;
>
> 	ret = kernel_pread_file_from_file(file, buf, size, max_size, 0, id);
> 	if (ret)
> 		return ret;
> 	return security_kernel_post_read_file(file, buf, *size, id);
> }
>
>>   
>>   #if defined(CONFIG_HAVE_AOUT) || defined(CONFIG_BINFMT_FLAT) || \
>> diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
>> index 53f5ca41519a..f061ccb8d0b4 100644
>> --- a/include/linux/kernel_read_file.h
>> +++ b/include/linux/kernel_read_file.h
>> @@ -8,6 +8,7 @@
>>   #define __kernel_read_file_id(id) \
>>   	id(UNKNOWN, unknown)		\
>>   	id(FIRMWARE, firmware)		\
>> +	id(FIRMWARE_PARTIAL_READ, firmware)	\
>>   	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
>>   	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
> And again, sorry that this was in here as a misleading example.
>
>>   	id(MODULE, kernel-module)		\
>> @@ -36,15 +37,31 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
>>   	return kernel_read_file_str[id];
>>   }
>>   
>> +int kernel_pread_file(struct file *file,
>> +		      void **buf, loff_t *size, loff_t pos,
>> +		      loff_t max_size,
>> +		      enum kernel_read_file_id id);
>>   int kernel_read_file(struct file *file,
>>   		     void **buf, loff_t *size, loff_t max_size,
>>   		     enum kernel_read_file_id id);
>> +int kernel_pread_file_from_path(const char *path,
>> +				void **buf, loff_t *size, loff_t pos,
>> +				loff_t max_size,
>> +				enum kernel_read_file_id id);
>>   int kernel_read_file_from_path(const char *path,
>>   			       void **buf, loff_t *size, loff_t max_size,
>>   			       enum kernel_read_file_id id);
>> +int kernel_pread_file_from_path_initns(const char *path,
>> +				       void **buf, loff_t *size, loff_t pos,
>> +				       loff_t max_size,
>> +				       enum kernel_read_file_id id);
>>   int kernel_read_file_from_path_initns(const char *path,
>>   				      void **buf, loff_t *size, loff_t max_size,
>>   				      enum kernel_read_file_id id);
>> +int kernel_pread_file_from_fd(int fd,
>> +			      void **buf, loff_t *size, loff_t pos,
>> +			      loff_t max_size,
>> +			      enum kernel_read_file_id id);
>>   int kernel_read_file_from_fd(int fd,
>>   			     void **buf, loff_t *size, loff_t max_size,
>>   			     enum kernel_read_file_id id);
> I remain concerned that adding these helpers will lead a poor
> interaction with LSMs, but I guess I get to hold my tongue. :)
We could add pread functions that are "unsafe" in nature instead then?
As I certainly do not need any integrity checks on the file for my 
driver.  The real check is done by the card the data is loaded to 
whether is passes the linux security checks or not.
And then, if someone does want to do something "safe" with preads 
another kernel_read_file_securelock/unlock could be added for those that 
need security for their partial reads?
>

