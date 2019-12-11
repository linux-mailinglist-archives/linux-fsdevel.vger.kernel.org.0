Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9332711A342
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 05:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLKEA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 23:00:28 -0500
Received: from mail.loongson.cn ([114.242.206.163]:47994 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbfLKEA2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 23:00:28 -0500
Received: from [10.130.0.36] (unknown [123.138.236.242])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxDxe3afBd0nEJAA--.6S3;
        Wed, 11 Dec 2019 12:00:08 +0800 (CST)
Subject: Re: [PATCH v5] fs: introduce is_dot_or_dotdot helper for cleanup
To:     Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <1576030801-8609-1-git-send-email-yangtiezhu@loongson.cn>
 <20191211024858.GB732@sol.localdomain>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <febbd7eb-5e53-6e7c-582d-5b224e441e37@loongson.cn>
Date:   Wed, 11 Dec 2019 11:59:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20191211024858.GB732@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxDxe3afBd0nEJAA--.6S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4rXryxJFW5WFyDWF4DArb_yoW8Zr1UpF
        y5CFZYyF1IgFyUZF4vyw4fZF4Yvrs3XFyjy347K3s8AF1aqFnaqrW5Kr1093Z3JrZ5ZF1S
        gay3WFyYk398AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxU2rcTDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/2019 10:48 AM, Eric Biggers wrote:
> On Wed, Dec 11, 2019 at 10:20:01AM +0800, Tiezhu Yang wrote:
>> diff --git a/include/linux/namei.h b/include/linux/namei.h
>> index 7fe7b87..0fd9315 100644
>> --- a/include/linux/namei.h
>> +++ b/include/linux/namei.h
>> @@ -92,4 +92,14 @@ retry_estale(const long error, const unsigned int flags)
>>   	return error == -ESTALE && !(flags & LOOKUP_REVAL);
>>   }
>>   
>> +static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
>> +{
>> +	if (unlikely(name[0] == '.')) {
>> +		if (len == 1 || (len == 2 && name[1] == '.'))
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   #endif /* _LINUX_NAMEI_H */
> I had suggested adding a len >= 1 check to handle the empty name case correctly.
> What I had in mind was
>
> static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
> {
> 	if (len >= 1 && unlikely(name[0] == '.')) {
> 		if (len < 2 || (len == 2 && name[1] == '.'))
> 			return true;
> 	}
>
> 	return false;
> }
>
> As is, you're proposing that it always dereference the first byte even when
> len=0, which seems like a bad idea for a shared helper function.  Did you check
> whether it's okay for all the existing callers?  fscrypt_fname_disk_to_usr() is
> called from 6 places, did you check all of them?
>
> How about keeping the existing optimized code for the hot path in fs/namei.c
> (i.e. not using the helper function), while having the helper function do the
> extra check to handle len=0 correctly?

Hi Eric,

Thank you for reminding me.  How about using the following helper for
all callers?

static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
{
         if (len == 1 && name[0] == '.')
                 return true;

         if (len == 2 && name[0] == '.' && name[1] == '.')
                 return true;

         return false;
}

Hi Matthew,

How do you think? I think the performance influence is very small
due to is_dot_or_dotdot() is a such short static inline function.

Thanks,

Tiezhu Yang

>
> - Eric

