Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B5D10F4CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 03:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLCCIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 21:08:00 -0500
Received: from mail.loongson.cn ([114.242.206.163]:41560 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfLCCH7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 21:07:59 -0500
Received: from [10.130.0.36] (unknown [123.138.236.242])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9dyw+VdzjYGAA--.0S3;
        Tue, 03 Dec 2019 10:07:47 +0800 (CST)
Subject: Re: [PATCH] fs: introduce is_dot_dotdot helper for cleanup
To:     Matthew Wilcox <willy@infradead.org>
References: <1575281413-6753-1-git-send-email-yangtiezhu@loongson.cn>
 <20191202200302.GN20752@bombadil.infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <357ad021-a58c-ad46-42bd-d5012126276f@loongson.cn>
Date:   Tue, 3 Dec 2019 10:07:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20191202200302.GN20752@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxr9dyw+VdzjYGAA--.0S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4UCFy7tr4kXr1rJrWDurg_yoW5XryDpa
        y8Ja9FgFn7tFyUC3Wjqr4DX3yY93yxXr1DGr90va47ursIvrn0ga4rAr4j93s7tFWDur4r
        X390yr45u34FyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBEb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8Jw
        CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
        6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
        vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07b5nQbUUUUU
        =
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/03/2019 04:03 AM, Matthew Wilcox wrote:
> On Mon, Dec 02, 2019 at 06:10:13PM +0800, Tiezhu Yang wrote:
>> There exists many similar and duplicate codes to check "." and "..",
>> so introduce is_dot_dotdot helper to make the code more clean.
> The idea is good.  The implementation is, I'm afraid, badly chosen.
> Did you benchmark this change at all?  In general, you should prefer the
> core kernel implementation to that of some less-interesting filesystems.
> I measured the performance with the attached test program on my laptop
> (Core-i7 Kaby Lake):
>
> qstr . time_1 0.020531 time_2 0.005786
> qstr .. time_1 0.017892 time_2 0.008798
> qstr a time_1 0.017633 time_2 0.003634
> qstr matthew time_1 0.011820 time_2 0.003605
> qstr .a time_1 0.017909 time_2 0.008710
> qstr , time_1 0.017631 time_2 0.003619
>
> The results are quite stable:
>
> qstr . time_1 0.021137 time_2 0.005780
> qstr .. time_1 0.017964 time_2 0.008675
> qstr a time_1 0.017899 time_2 0.003654
> qstr matthew time_1 0.011821 time_2 0.003620
> qstr .a time_1 0.017889 time_2 0.008662
> qstr , time_1 0.017764 time_2 0.003613
>
> Feel free to suggest some different strings we could use for testing.
> These seemed like interesting strings to test with.  It's always possible
> I've messed up something with this benchmark that causes it to not
> accurately represent the performance of each algorithm, so please check
> that too.

[Sorry to resend this email because the mail list server
was denied due to it is not plain text.]

Hi Matthew,

Thanks for your reply and suggestion. I measured the
performance with the test program, the following
implementation is better for various of test cases:

bool is_dot_dotdot(const struct qstr *str)
{
         if (unlikely(str->name[0] == '.')) {
                 if (str->len < 2 || (str->len == 2 && str->name[1] == '.'))
                         return true;
         }

         return false;
}

I will send a v2 patch used with this implementation.

Thanks,

Tiezhu Yang

>
>> +bool is_dot_dotdot(const struct qstr *str)
>> +{
>> +	if (str->len == 1 && str->name[0] == '.')
>> +		return true;
>> +
>> +	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
>> +		return true;
>> +
>> +	return false;
>> +}
>> +EXPORT_SYMBOL(is_dot_dotdot);
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 2dda552..7730a3b 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -2458,10 +2458,8 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
>>   	if (!len)
>>   		return -EACCES;
>>   
>> -	if (unlikely(name[0] == '.')) {
>> -		if (len < 2 || (len == 2 && name[1] == '.'))
>> -			return -EACCES;
>> -	}
>> +	if (unlikely(is_dot_dotdot(this)))
>> +		return -EACCES;
>>   
>>   	while (len--) {
>>   		unsigned int c = *(const unsigned char *)name++;

