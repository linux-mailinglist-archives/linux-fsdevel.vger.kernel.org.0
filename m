Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1373188906
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 16:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCQPTy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 11:19:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgCQPTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=qF4Ay2037uPUSUMB4CI/jcU6NhGJJiHt+Bh9H6iNIEs=; b=MVUspZwlEA2YIkbP42nw6NcJtL
        26u0hkT7viWbxDgKHBjz41sks91K1gul9ypz4w0B20aTAHORhl9XVsvAuf+pAb01suGNactdhSBHe
        ITMWVfilrqglvQt3wOV0M70pfnTerGp3tlZMFmXpojwCZQbn5B6dU7f72QNYpZjvnY5bQnkYECs2p
        EU8ABg0rEmHCsY8XWA8ysZ2AVV72IZlwHjCDtqy1v2Pu4q8d7rEJpj0V1vCaGtOVQaRwx0NsC7+lS
        IATRml1c/6c83oFSKn2ud0hHYZBdLW+z/b012PQOMO9M7j0VP6OjjZVdJ/+wyJl21XZ4EnbSHUN9y
        50tlfEFg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEE0T-0004y7-Ef; Tue, 17 Mar 2020 15:19:49 +0000
Subject: Re: [PATCH] ext2: fix debug reference to ext2_xattr_cache
To:     Jan Kara <jack@suse.cz>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <88b8bde4-8c7a-6b44-9478-3ce13ecfab3a@infradead.org>
 <20200317114712.GH22684@quack2.suse.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9b4e1fa7-b4f8-b2a9-8269-04daeb3dfaaa@infradead.org>
Date:   Tue, 17 Mar 2020 08:19:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317114712.GH22684@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/17/20 4:47 AM, Jan Kara wrote:
> On Fri 13-03-20 20:42:05, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix a debug-only build error in ext2/xattr.c:
>>
>> When building without extra debugging, (and with another patch that uses
>> no_printk() instead of <empty> for the ext2-xattr debug-print macros,
>> this build error happens:
>>
>> ../fs/ext2/xattr.c: In function ‘ext2_xattr_cache_insert’:
>> ../fs/ext2/xattr.c:869:18: error: ‘ext2_xattr_cache’ undeclared (first use in this function); did you mean ‘ext2_xattr_list’?
>>      atomic_read(&ext2_xattr_cache->c_entry_count));
>>
>> Fix by moving struct mb_cache from fs/mbcache.c to <linux/mbcache.h>,
>> and then using the correct struct name in the debug-print macro.
>>
>> This wasn't converted when ext2 xattr cache was changed to use mbcache.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Jan Kara <jack@suse.com>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: linux-ext4@vger.kernel.org
>> Cc: linux-fsdevel@vger.kernel.org
> 
> Thanks for the patch! I don't think exporting 'struct mb_cache' just for
> this is reasonable. I've committed a patch which just removes the entry
> count from the debug message (attached).
> 

Sure, that's good.  I have a patch like that one on my system also. :)

> 
>> ---
>> This is ancient, from the beginning of git history.
>>
>> Or just kill of that print of c_entry_count...
>>
>>  fs/ext2/xattr.c         |    2 +-
>>  fs/mbcache.c            |   34 ----------------------------------
>>  include/linux/mbcache.h |   35 ++++++++++++++++++++++++++++++++++-
>>  3 files changed, 35 insertions(+), 36 deletions(-)

-- 
~Randy

