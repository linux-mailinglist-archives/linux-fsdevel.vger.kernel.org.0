Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C458111A495
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 07:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfLKGjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 01:39:07 -0500
Received: from mail.loongson.cn ([114.242.206.163]:42610 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfLKGjH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 01:39:07 -0500
Received: from [10.130.0.36] (unknown [123.138.236.242])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxfxfvjvBdz38JAA--.103S3;
        Wed, 11 Dec 2019 14:38:41 +0800 (CST)
Subject: Re: [PATCH v5] fs: introduce is_dot_or_dotdot helper for cleanup
To:     Al Viro <viro@zeniv.linux.org.uk>
References: <1576030801-8609-1-git-send-email-yangtiezhu@loongson.cn>
 <20191211024858.GB732@sol.localdomain>
 <febbd7eb-5e53-6e7c-582d-5b224e441e37@loongson.cn>
 <20191211044723.GC4203@ZenIV.linux.org.uk>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <4a90aaa9-18c8-f0a7-19e4-1c5bd5915a28@loongson.cn>
Date:   Wed, 11 Dec 2019 14:38:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20191211044723.GC4203@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxfxfvjvBdz38JAA--.103S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xry3KF4UGF4furW3Xry5urg_yoWkGrX_ur
        18Cw1DAF4UZr13ZwsxJFW7JFZxWFW5Wr1jvFyvv3y7AF98A398urWkKrsIva1UZr4fZFZI
        kryjyrWIqrW29jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb-AYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7jjgUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/2019 12:47 PM, Al Viro wrote:
> On Wed, Dec 11, 2019 at 11:59:40AM +0800, Tiezhu Yang wrote:
>
>> static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
>> {
>>          if (len == 1 && name[0] == '.')
>>                  return true;
>>
>>          if (len == 2 && name[0] == '.' && name[1] == '.')
>>                  return true;
>>
>>          return false;
>> }
>>
>> Hi Matthew,
>>
>> How do you think? I think the performance influence is very small
>> due to is_dot_or_dotdot() is a such short static inline function.
> It's a very short inline function called on a very hot codepath.
> Often.
>
> I mean it - it's done literally for every pathname component of
> every pathname passed to a syscall.

OK. I understand. Let us do not use the helper function in fs/namei.c,
just use the following implementation for other callers:

static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
{
         if (len >= 1 && unlikely(name[0] == '.')) {
                 if (len < 2 || (len == 2 && name[1] == '.'))
                         return true;
         }

         return false;
}

Special thanks for Matthew, Darrick, Al and Eric.
If you have any more suggestion, please let me know.

Thanks,

Tiezhu Yang

