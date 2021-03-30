Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D547434E7FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 14:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhC3Mya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 08:54:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41120 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhC3MyK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:54:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 8DE8A1F44E69
Subject: Re: [PATCH 1/3] fs/dcache: Add d_clear_dir_neg_dentries()
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        kernel@collabora.com, Daniel Rosenberg <drosen@google.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        krisman@collabora.com
References: <20210328144356.12866-1-andrealmeid@collabora.com>
 <20210328144356.12866-2-andrealmeid@collabora.com>
 <YGKDfo1vZfFXwG/v@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <8ea3ba8e-2699-8786-5ca3-33ee3c70961b@collabora.com>
Date:   Tue, 30 Mar 2021 09:54:01 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGKDfo1vZfFXwG/v@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric,

Às 22:48 de 29/03/21, Eric Biggers escreveu:
> On Sun, Mar 28, 2021 at 11:43:54AM -0300, André Almeida wrote:
>> For directories with negative dentries that are becoming case-insensitive
>> dirs, we need to remove all those negative dentries, otherwise they will
>> become dangling dentries. During the creation of a new file, if a d_hash
>> collision happens and the names match in a case-insensitive way, the name
>> of the file will be the name defined at the negative dentry, that may be
>> different from the specified by the user. To prevent this from
>> happening, we need to remove all dentries in a directory. Given that the
>> directory must be empty before we call this function we are sure that
>> all dentries there will be negative.
>>
>> Create a function to remove all negative dentries from a directory, to
>> be used as explained above by filesystems that support case-insensitive
>> lookups.
>>
>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
>> ---
>>   fs/dcache.c            | 27 +++++++++++++++++++++++++++
>>   include/linux/dcache.h |  1 +
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/fs/dcache.c b/fs/dcache.c
>> index 7d24ff7eb206..fafb3016d6fd 100644
>> --- a/fs/dcache.c
>> +++ b/fs/dcache.c
>> @@ -1723,6 +1723,33 @@ void d_invalidate(struct dentry *dentry)
>>   }
>>   EXPORT_SYMBOL(d_invalidate);
>>   
>> +/**
>> + * d_clear_dir_neg_dentries - Remove negative dentries in an inode
>> + * @dir: Directory to clear negative dentries
>> + *
>> + * For directories with negative dentries that are becoming case-insensitive
>> + * dirs, we need to remove all those negative dentries, otherwise they will
>> + * become dangling dentries. During the creation of a new file, if a d_hash
>> + * collision happens and the names match in a case-insensitive, the name of
>> + * the file will be the name defined at the negative dentry, that can be
>> + * different from the specified by the user. To prevent this from happening, we
>> + * need to remove all dentries in a directory. Given that the directory must be
>> + * empty before we call this function we are sure that all dentries there will
>> + * be negative.
>> + */
>> +void d_clear_dir_neg_dentries(struct inode *dir)
>> +{
>> +	struct dentry *alias, *dentry;
>> +
>> +	hlist_for_each_entry(alias, &dir->i_dentry, d_u.d_alias) {
>> +		list_for_each_entry(dentry, &alias->d_subdirs, d_child) {
>> +			d_drop(dentry);
>> +			dput(dentry);
>> +		}
>> +	}
>> +}
>> +EXPORT_SYMBOL(d_clear_dir_neg_dentries);
> 
> As Al already pointed out, this doesn't work as intended, for a number of
> different reasons.
> 
> Did you consider just using shrink_dcache_parent()?  That already does what you
> are trying to do here, I think.

When I wrote this patch, I didn't know it, but after Al Viro comments I 
get back to the code and found it, and it seems do do what I intend 
indeed, and my test is happy as well.

> 
> The harder part (which I don't think you've considered) is how to ensure that
> all negative dentries really get invalidated even if there are lookups of them
> happening concurrently.  Concurrent lookups can take temporary references to the
> negative dentries, preventing them from being invalidated.
> 

I didn't consider that, thanks for the feedback. So this means that 
those lookups will increase the refcount of the dentry, and it will only 
get really invalidated when refcount reaches 0? Or do would I need to 
call d_invalidate() again, until I succeed?

> - Eric
> 
