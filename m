Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF4B7D294
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 03:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfHABLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 21:11:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34548 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfHABLW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:11:22 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6295B2C0F960B1BEB31C;
        Thu,  1 Aug 2019 09:11:19 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 1 Aug 2019
 09:11:14 +0800
Subject: Re: [PATCH v4 3/3] f2fs: Support case-insensitive file name lookups
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Daniel Rosenberg <drosen@google.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <kernel-team@android.com>
References: <20190723230529.251659-1-drosen@google.com>
 <20190723230529.251659-4-drosen@google.com>
 <20190731175748.GA48637@archlinux-threadripper>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <5d6c5da8-ad1e-26e2-0a3d-84949cd4e9aa@huawei.com>
Date:   Thu, 1 Aug 2019 09:11:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190731175748.GA48637@archlinux-threadripper>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nathan,

Thanks for the report! :)

On 2019/8/1 1:57, Nathan Chancellor wrote:
> Hi all,
> 
> <snip>
> 
>> diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
>> index cc82f142f811f..99e79934f5088 100644
>> --- a/fs/f2fs/hash.c
>> +++ b/fs/f2fs/hash.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/f2fs_fs.h>
>>  #include <linux/cryptohash.h>
>>  #include <linux/pagemap.h>
>> +#include <linux/unicode.h>
>>  
>>  #include "f2fs.h"
>>  
>> @@ -67,7 +68,7 @@ static void str2hashbuf(const unsigned char *msg, size_t len,
>>  		*buf++ = pad;
>>  }
>>  
>> -f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info,
>> +static f2fs_hash_t __f2fs_dentry_hash(const struct qstr *name_info,
>>  				struct fscrypt_name *fname)
>>  {
>>  	__u32 hash;
>> @@ -103,3 +104,35 @@ f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info,
>>  	f2fs_hash = cpu_to_le32(hash & ~F2FS_HASH_COL_BIT);
>>  	return f2fs_hash;
>>  }
>> +
>> +f2fs_hash_t f2fs_dentry_hash(const struct inode *dir,
>> +		const struct qstr *name_info, struct fscrypt_name *fname)
>> +{
>> +#ifdef CONFIG_UNICODE
>> +	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
>> +	const struct unicode_map *um = sbi->s_encoding;
>> +	int r, dlen;
>> +	unsigned char *buff;
>> +	struct qstr *folded;
>> +
>> +	if (name_info->len && IS_CASEFOLDED(dir)) {
>> +		buff = f2fs_kzalloc(sbi, sizeof(char) * PATH_MAX, GFP_KERNEL);
>> +		if (!buff)
>> +			return -ENOMEM;
>> +
>> +		dlen = utf8_casefold(um, name_info, buff, PATH_MAX);
>> +		if (dlen < 0) {
>> +			kvfree(buff);
>> +			goto opaque_seq;
>> +		}
>> +		folded->name = buff;
>> +		folded->len = dlen;
>> +		r = __f2fs_dentry_hash(folded, fname);
>> +
>> +		kvfree(buff);
>> +		return r;
>> +	}
>> +opaque_seq:
>> +#endif
>> +	return __f2fs_dentry_hash(name_info, fname);
>> +}
> 
> Clang now warns:
> 
> fs/f2fs/hash.c:128:3: warning: variable 'folded' is uninitialized when used here [-Wuninitialized]
>                 folded->name = buff;
>                 ^~~~~~
> fs/f2fs/hash.c:116:21: note: initialize the variable 'folded' to silence this warning
>         struct qstr *folded;
>                            ^
>                             = NULL
> 1 warning generated.
> 
> I assume that it wants to be initialized with f2fs_kzalloc as well but
> I am not familiar with this code and what it expects to do.
> 
> Please look into this when you get a chance!

That should be a bug, it needs to define a struct qstr type variable rather than
a pointer there.

Jaegeuk, could you fix this in you branch?

Thanks,

> Nathan
> .
> 
