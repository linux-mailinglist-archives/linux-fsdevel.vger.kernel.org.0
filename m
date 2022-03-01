Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4106C4C8914
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 11:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiCAKQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 05:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiCAKP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:15:58 -0500
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E882C8CDB1
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 02:15:17 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K7Cmd6DjQzMq5kH;
        Tue,  1 Mar 2022 11:15:13 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4K7CmZ5H8YzljTgL;
        Tue,  1 Mar 2022 11:15:10 +0100 (CET)
Message-ID: <f6b63133-d555-a77c-0847-de15a9302283@digikod.net>
Date:   Tue, 1 Mar 2022 11:15:09 +0100
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Steve French <sfrench@samba.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20220228215935.748017-1-mic@digikod.net>
 <20220301092232.wh7m3fxbe7hyxmcu@wittgenstein>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v1] fs: Fix inconsistent f_mode
In-Reply-To: <20220301092232.wh7m3fxbe7hyxmcu@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 01/03/2022 10:22, Christian Brauner wrote:
> On Mon, Feb 28, 2022 at 10:59:35PM +0100, Mickaël Salaün wrote:
>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>
>> While transitionning to ACC_MODE() with commit 5300990c0370 ("Sanitize
>> f_flags helpers") and then fixing it with commit 6d125529c6cb ("Fix
>> ACC_MODE() for real"), we lost an open flags consistency check.  Opening
>> a file with O_WRONLY | O_RDWR leads to an f_flags containing MAY_READ |
>> MAY_WRITE (thanks to the ACC_MODE() helper) and an empty f_mode.
>> Indeed, the OPEN_FMODE() helper transforms 3 (an incorrect value) to 0.
>>
>> Fortunately, vfs_read() and vfs_write() both check for FMODE_READ, or
>> respectively FMODE_WRITE, and return an EBADF error if it is absent.
>> Before commit 5300990c0370 ("Sanitize f_flags helpers"), opening a file
>> with O_WRONLY | O_RDWR returned an EINVAL error.  Let's restore this safe
>> behavior.
> 
> That specific part seems a bit risky at first glance. Given that the
> patch referenced is from 2009 this means we've been allowing O_WRONLY |
> O_RDWR to succeed for almost 13 years now.

Yeah, it's an old bug, but we should keep in mind that a file descriptor 
created with such flags cannot be used to read nor write. However, 
unfortunately, it can be used for things like ioctl, fstat, chdir… I 
don't know if there is any user of this trick.

Either way, there is an inconsistency between those using ACC_MODE() and 
those using OPEN_FMODE(). If we decide to take a side for the behavior 
of one or the other, without denying to create such FD, it could also 
break security policies. We have to choose what to potentially break…


> 
>>
>> To make it consistent with ACC_MODE(), this patch also changes
>> OPEN_FMODE() to return FMODE_READ | FMODE_WRITE for O_WRONLY | O_RDWR.
>> This may help protect from potential spurious issues.
>>
>> This issue could result in inconsistencies with AppArmor, Landlock and
>> SELinux, but the VFS checks would still forbid read and write accesses.
>> Tomoyo uses the ACC_MODE() transformation which is correct, and Smack
>> doesn't check the file mode.  Filesystems using OPEN_FMODE() should also
>> be protected by the VFS checks.
>>
>> Fixes: 5300990c0370 ("Sanitize f_flags helpers")
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: Darrick J. Wong <djwong@kernel.org>
>> Cc: Eric Paris <eparis@parisplace.org>
>> Cc: John Johansen <john.johansen@canonical.com>
>> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
>> Cc: Steve French <sfrench@samba.org>
>> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>> Link: https://lore.kernel.org/r/20220228215935.748017-1-mic@digikod.net
>> ---
>>   fs/file_table.c    | 3 +++
>>   include/linux/fs.h | 5 +++--
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/file_table.c b/fs/file_table.c
>> index 7d2e692b66a9..b936f69525d0 100644
>> --- a/fs/file_table.c
>> +++ b/fs/file_table.c
>> @@ -135,6 +135,9 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
>>   	struct file *f;
>>   	int error;
>>   
>> +	if ((flags & O_ACCMODE) == O_ACCMODE)
>> +		return ERR_PTR(-EINVAL);
>> +
>>   	f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
>>   	if (unlikely(!f))
>>   		return ERR_PTR(-ENOMEM);
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index e2d892b201b0..83bc5aaf1c41 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -3527,8 +3527,9 @@ int __init list_bdev_fs_names(char *buf, size_t size);
>>   #define __FMODE_NONOTIFY	((__force int) FMODE_NONOTIFY)
>>   
>>   #define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])
>> -#define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE) | \
>> -					    (flag & __FMODE_NONOTIFY)))
>> +#define OPEN_FMODE(flag) ((__force fmode_t)( \
>> +			(((flag + 1) & O_ACCMODE) ?: O_ACCMODE) | \
>> +			(flag & __FMODE_NONOTIFY)))
>>   
>>   static inline bool is_sxid(umode_t mode)
>>   {
>>
>> base-commit: 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3
>> -- 
>> 2.35.1
>>
