Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD70243C86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHMPcC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 11:32:02 -0400
Received: from smtp-bc08.mail.infomaniak.ch ([45.157.188.8]:53633 "EHLO
        smtp-bc08.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbgHMPb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:31:59 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BS9XG4mmCzlhLv2;
        Thu, 13 Aug 2020 17:31:26 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4BS9XC0vpZzlh8T5;
        Thu, 13 Aug 2020 17:31:23 +0200 (CEST)
Subject: Re: [PATCH v7 3/7] exec: Move path_noexec() check earlier
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200723171227.446711-1-mic@digikod.net>
 <20200723171227.446711-4-mic@digikod.net>
 <87a6z1m0u1.fsf@x220.int.ebiederm.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <89b6bb7f-d841-cf0a-8d5c-26c611b56ae7@digikod.net>
Date:   Thu, 13 Aug 2020 17:31:22 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <87a6z1m0u1.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook wrote this patch, which is in Andrew Morton's tree, but I
think you're talking about O_MAYEXEC, not this patch specifically.

On 11/08/2020 21:36, Eric W. Biederman wrote:
> Mickaël Salaün <mic@digikod.net> writes:
> 
>> From: Kees Cook <keescook@chromium.org>
>>
>> The path_noexec() check, like the regular file check, was happening too
>> late, letting LSMs see impossible execve()s. Check it earlier as well
>> in may_open() and collect the redundant fs/exec.c path_noexec() test
>> under the same robustness comment as the S_ISREG() check.
>>
>> My notes on the call path, and related arguments, checks, etc:
> 
> A big question arises, that I think someone already asked.

Al Viro and Jann Horn expressed such concerns for O_MAYEXEC:
https://lore.kernel.org/lkml/0cc94c91-afd3-27cd-b831-8ea16ca8ca93@digikod.net/

> 
> Why perform this test in may_open directly instead of moving
> it into inode_permission.  That way the code can be shared with
> faccessat, and any other code path that wants it?

This patch is just a refactoring.

About O_MAYEXEC, path-based LSM, IMA and IPE need to work on a struct
file, whereas inode_permission() only gives a struct inode. However,
faccessat2(2) (with extended flags) seems to be the perfect candidate if
we want to be able to check file descriptors.

> 
> That would look to provide a more maintainable kernel.

Why would it be more maintainable?

> 
> Eric
> 
> 
>> do_open_execat()
>>     struct open_flags open_exec_flags = {
>>         .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
>>         .acc_mode = MAY_EXEC,
>>         ...
>>     do_filp_open(dfd, filename, open_flags)
>>         path_openat(nameidata, open_flags, flags)
>>             file = alloc_empty_file(open_flags, current_cred());
>>             do_open(nameidata, file, open_flags)
>>                 may_open(path, acc_mode, open_flag)
>>                     /* new location of MAY_EXEC vs path_noexec() test */
>>                     inode_permission(inode, MAY_OPEN | acc_mode)
>>                         security_inode_permission(inode, acc_mode)
>>                 vfs_open(path, file)
>>                     do_dentry_open(file, path->dentry->d_inode, open)
>>                         security_file_open(f)
>>                         open()
>>     /* old location of path_noexec() test */
>>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Link: https://lore.kernel.org/r/20200605160013.3954297-4-keescook@chromium.org
>> ---
>>  fs/exec.c  | 12 ++++--------
>>  fs/namei.c |  4 ++++
>>  2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index bdc6a6eb5dce..4eea20c27b01 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -147,10 +147,8 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
>>  	 * and check again at the very end too.
>>  	 */
>>  	error = -EACCES;
>> -	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
>> -		goto exit;
>> -
>> -	if (path_noexec(&file->f_path))
>> +	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
>> +			 path_noexec(&file->f_path)))
>>  		goto exit;
>>  
>>  	fsnotify_open(file);
>> @@ -897,10 +895,8 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
>>  	 * and check again at the very end too.
>>  	 */
>>  	err = -EACCES;
>> -	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
>> -		goto exit;
>> -
>> -	if (path_noexec(&file->f_path))
>> +	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
>> +			 path_noexec(&file->f_path)))
>>  		goto exit;
>>  
>>  	err = deny_write_access(file);
>> diff --git a/fs/namei.c b/fs/namei.c
>> index a559ad943970..ddc9b25540fe 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -2863,6 +2863,10 @@ static int may_open(const struct path *path, int acc_mode, int flag)
>>  			return -EACCES;
>>  		flag &= ~O_TRUNC;
>>  		break;
>> +	case S_IFREG:
>> +		if ((acc_mode & MAY_EXEC) && path_noexec(path))
>> +			return -EACCES;
>> +		break;
>>  	}
>>  
>>  	error = inode_permission(inode, MAY_OPEN | acc_mode);
