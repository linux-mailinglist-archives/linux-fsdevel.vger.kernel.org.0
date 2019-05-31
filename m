Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3306314A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfEaS3J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 14:29:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41702 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfEaS3I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 14:29:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7056B261164
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH] ext4: Optimize case-insensitive lookups
Organization: Collabora
References: <20190529185446.22757-1-krisman@collabora.com>
        <20190530210156.GI2998@mit.edu>
Date:   Fri, 31 May 2019 14:29:04 -0400
In-Reply-To: <20190530210156.GI2998@mit.edu> (Theodore Ts'o's message of "Thu,
        30 May 2019 17:01:56 -0400")
Message-ID: <851s0eiikv.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Wed, May 29, 2019 at 02:54:46PM -0400, Gabriel Krisman Bertazi wrote:
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index c18ab748d20d..e3809cfda9f4 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -2078,6 +2078,10 @@ struct ext4_filename {
>>  #ifdef CONFIG_FS_ENCRYPTION
>>  	struct fscrypt_str crypto_buf;
>>  #endif
>> +#ifdef CONFIG_UNICODE
>> +	int cf_len;
>> +	unsigned char cf_name[EXT4_NAME_LEN];
>> +#endif
>>  };
>>  
>>  #define fname_name(p) ((p)->disk_name.name)
>
> EXT4_NAME_LEN is 256, and struct ext4_filename is allocated on the
> stack.  So this is going to increase the stack usage by 258 bytes.
> Perhaps should we just kmalloc the temporary buffer when it's needed?

I wanted to avoid adding an allocation to this path, but maybe that was
misguided, since this is out of the dcache critical path.  I also wanted
to remove the allocation from d_hash, but we'd require a similar size
allocation in the stack. Is that a good idea?

> The other thing that this patch reminds me is that there is great
> interest in supporting case folded directories and fscrypt at the same
> time.  Today fscrypt works by encrypting the filename, and stashes it
> in fname->crypto_buf, and this allows for a byte-for-byte comparison
> of the encrypted name.  To support fscrypt && casefold, what we would
> need to do is to change the htree hash so that the hash is caluclated
> on the normalized form, and then we'll have to decrypt each filename
> in the directory block and then compare it against the normalized form
> that stashed in cf_name.  So that means we'll never need to allocate
> memory for cf_name and crypto_buf at the same time.

fscrypt and case-insensitive is getting to the top of my to-do list,
i'll something there early next week.  Thanks for the explanation on
it.

>
> We can also use struct fscrypt_str for cf_name; it's defined as a
> combined unsighed char *name and u32 len.  We already use fscrypt_str
> even the !CONFIG_FS_ENCRYPTION case, since it's a convenient way of
> handling a non-NULL terminated filename blob.  And this will hopefully
> make it simpler to deal with integrating casefolding and fscrypt in
> the future.

I will send a v2 with this change already, to simplify
fscrypt+casefolding support.
>
> Cheers,
>
> 					- Ted

-- 
Gabriel Krisman Bertazi
