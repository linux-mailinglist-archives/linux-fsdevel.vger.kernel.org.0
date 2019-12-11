Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2518D11A04A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 01:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfLKA4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 19:56:54 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42742 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbfLKA4y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:56:54 -0500
Received: from [10.130.0.36] (unknown [123.138.236.242])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj9PAPvBdJ2MJAA--.34S3;
        Wed, 11 Dec 2019 08:56:41 +0800 (CST)
Subject: Re: [PATCH v4] fs: introduce is_dot_or_dotdot helper for cleanup
To:     Eric Biggers <ebiggers@kernel.org>
References: <1575979801-32569-1-git-send-email-yangtiezhu@loongson.cn>
 <20191210191912.GA99557@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <98a07d66-8479-f780-89ce-13a6d2c85efd@loongson.cn>
Date:   Wed, 11 Dec 2019 08:56:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20191210191912.GA99557@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxj9PAPvBdJ2MJAA--.34S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1UZFy3Zw1kWr4UAryDGFg_yoW5GrWDpF
        Z8JFyvyF4xGryUur1Ivr1fAF1Fv393Wr15Cr9xKa4UArnIqr1vqayfCw4Y93Z3XFWrWw4F
        gan8JFy5C345JFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxU2JKsUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/2019 03:19 AM, Eric Biggers wrote:
> On Tue, Dec 10, 2019 at 08:10:01PM +0800, Tiezhu Yang wrote:
>> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
>> index 3da3707..ef7eba8 100644
>> --- a/fs/crypto/fname.c
>> +++ b/fs/crypto/fname.c
>> @@ -11,21 +11,11 @@
>>    * This has not yet undergone a rigorous security audit.
>>    */
>>   
>> +#include <linux/namei.h>
>>   #include <linux/scatterlist.h>
>>   #include <crypto/skcipher.h>
>>   #include "fscrypt_private.h"
>>   
>> -static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
>> -{
>> -	if (str->len == 1 && str->name[0] == '.')
>> -		return true;
>> -
>> -	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
>> -		return true;
>> -
>> -	return false;
>> -}
>> -
>>   /**
>>    * fname_encrypt() - encrypt a filename
>>    *
>> @@ -255,7 +245,7 @@ int fscrypt_fname_disk_to_usr(struct inode *inode,
>>   	const struct qstr qname = FSTR_TO_QSTR(iname);
>>   	struct fscrypt_digested_name digested_name;
>>   
>> -	if (fscrypt_is_dot_dotdot(&qname)) {
>> +	if (is_dot_or_dotdot(qname.name, qname.len)) {
> There's no need for the 'qname' variable anymore.  Can you please remove it and
> do:
>
> 	if (is_dot_or_dotdot(iname->name, iname->len)) {

Hi Eric,

Thanks for your review, I will do it in the v5 patch.

>
>> diff --git a/include/linux/namei.h b/include/linux/namei.h
>> index 7fe7b87..aba114a 100644
>> --- a/include/linux/namei.h
>> +++ b/include/linux/namei.h
>> @@ -92,4 +92,14 @@ retry_estale(const long error, const unsigned int flags)
>>   	return error == -ESTALE && !(flags & LOOKUP_REVAL);
>>   }
>>   
>> +static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
>> +{
>> +	if (unlikely(name[0] == '.')) {
>> +		if (len < 2 || (len == 2 && name[1] == '.'))
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
> This doesn't handle the len=0 case.  Did you check that none of the users pass
> in zero-length names?  It looks like fscrypt_fname_disk_to_usr() can, if the
> directory entry on-disk has a zero-length name.  Currently it will return
> -EUCLEAN in that case, but with this patch it may think it's the name ".".
>
> So I think there needs to either be a len >= 1 check added, *or* you need to
> make an argument for why it's okay to not care about the empty name case.

Anyway, let me modify the if condition "len < 2" to "len == 1".

static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
{
         if (unlikely(name[0] == '.')) {
                 if (len == 1 || (len == 2 && name[1] == '.'))
                         return true;
         }

         return false;
}

I will send v5 patch as soon as possible.

Thanks,

Tiezhu Yang

>
> - Eric

