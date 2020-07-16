Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF12225DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 16:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgGPOjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 10:39:24 -0400
Received: from smtp-190e.mail.infomaniak.ch ([185.125.25.14]:48303 "EHLO
        smtp-190e.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728126AbgGPOjY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:39:24 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4B6xj50yGczlhmqm;
        Thu, 16 Jul 2020 16:39:21 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4B6xhz5Kbbzlh8Tq;
        Thu, 16 Jul 2020 16:39:15 +0200 (CEST)
Subject: Re: [PATCH v6 5/7] fs,doc: Enable to enforce noexec mounts or file
 exec through O_MAYEXEC
To:     Kees Cook <keescook@chromium.org>
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
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200714181638.45751-1-mic@digikod.net>
 <20200714181638.45751-6-mic@digikod.net> <202007151312.C28D112013@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <35ea0914-7360-43ab-e381-9614d18cceba@digikod.net>
Date:   Thu, 16 Jul 2020 16:39:14 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202007151312.C28D112013@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 15/07/2020 22:37, Kees Cook wrote:
> On Tue, Jul 14, 2020 at 08:16:36PM +0200, Mickaël Salaün wrote:
>> @@ -2849,7 +2855,7 @@ static int may_open(const struct path *path, int acc_mode, int flag)
>>  	case S_IFLNK:
>>  		return -ELOOP;
>>  	case S_IFDIR:
>> -		if (acc_mode & (MAY_WRITE | MAY_EXEC))
>> +		if (acc_mode & (MAY_WRITE | MAY_EXEC | MAY_OPENEXEC))
>>  			return -EISDIR;
>>  		break;
> 
> (I need to figure out where "open for reading" rejects S_IFDIR, since
> it's clearly not here...)
> 
>>  	case S_IFBLK:
>> @@ -2859,13 +2865,26 @@ static int may_open(const struct path *path, int acc_mode, int flag)
>>  		fallthrough;
>>  	case S_IFIFO:
>>  	case S_IFSOCK:
>> -		if (acc_mode & MAY_EXEC)
>> +		if (acc_mode & (MAY_EXEC | MAY_OPENEXEC))
>>  			return -EACCES;
>>  		flag &= ~O_TRUNC;
>>  		break;
> 
> This will immediately break a system that runs code with MAY_OPENEXEC
> set but reads from a block, char, fifo, or socket, even in the case of
> a sysadmin leaving the "file" sysctl disabled.

As documented, O_MAYEXEC is for regular files. The only legitimate use
case seems to be with pipes, which should probably be allowed when
enforcement is disabled.

> 
>>  	case S_IFREG:
>> -		if ((acc_mode & MAY_EXEC) && path_noexec(path))
>> -			return -EACCES;
>> +		if (path_noexec(path)) {
>> +			if (acc_mode & MAY_EXEC)
>> +				return -EACCES;
>> +			if ((acc_mode & MAY_OPENEXEC) &&
>> +					(sysctl_open_mayexec_enforce & OPEN_MAYEXEC_ENFORCE_MOUNT))
>> +				return -EACCES;
>> +		}
>> +		if ((acc_mode & MAY_OPENEXEC) &&
>> +				(sysctl_open_mayexec_enforce & OPEN_MAYEXEC_ENFORCE_FILE))
>> +			/*
>> +			 * Because acc_mode may change here, the next and only
>> +			 * use of acc_mode should then be by the following call
>> +			 * to inode_permission().
>> +			 */
>> +			acc_mode |= MAY_EXEC;
>>  		break;
>>  	}
> 
> Likely very minor, but I'd like to avoid the path_noexec() call in the
> fast-path (it dereferences a couple pointers where as doing bit tests on
> acc_mode is fast).
> 
> Given that and the above observations, I think that may_open() likely
> needs to start with:
> 
> 	if (acc_mode & MAY_OPENEXEC) {
> 		/* Reject all file types when mount enforcement set. */
> 		if ((sysctl_open_mayexec_enforce & OPEN_MAYEXEC_ENFORCE_MOUNT) &&
> 		    path_noexec(path))
> 			return -EACCES;
> 		/* Treat the same as MAY_EXEC. */
> 		if (sysctl_open_mayexec_enforce & OPEN_MAYEXEC_ENFORCE_FILE))
> 			acc_mode |= MAY_EXEC;
> 	}

OK

> 
> (Though I'm not 100% sure that path_noexec() is safe to be called for
> all file types: i.e. path->mnt and path->-mnt->mnt_sb *always* non-NULL?)

path->mnt should always be non-NULL:
https://lore.kernel.org/lkml/20200317164709.GA23230@ZenIV.linux.org.uk/

> 
> This change would also imply that OPEN_MAYEXEC_ENFORCE_FILE *includes*
> OPEN_MAYEXEC_ENFORCE_MOUNT (i.e. the sysctl should not be a bitfield),
> since path_noexec() would get checked for S_ISREG. I can't come up with
> a rationale where one would want OPEN_MAYEXEC_ENFORCE_FILE but _not_
> OPEN_MAYEXEC_ENFORCE_MOUNT?

I don't see why it is an inclusion.

> 
> (I can absolutely see wanting only OPEN_MAYEXEC_ENFORCE_MOUNT, or
> suddenly one has to go mark every loaded thing with the exec bit and
> most distros haven't done this to, for example, shared libraries. But
> setting the exec bit and then NOT wanting to enforce the mount check
> seems... not sensible?)
> 
> Outside of this change, yes, I like this now -- it's much cleaner
> because we have all the checks in the same place where they belong. :)
> 
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index db1ce7af2563..5008a2566e79 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -113,6 +113,7 @@ static int sixty = 60;
>>  
>>  static int __maybe_unused neg_one = -1;
>>  static int __maybe_unused two = 2;
>> +static int __maybe_unused three = 3;
>>  static int __maybe_unused four = 4;
>>  static unsigned long zero_ul;
>>  static unsigned long one_ul = 1;
> 
> Oh, are these still here? I thought they got removed (or at least made
> const). Where did that series go? Hmpf, see sysctl_vals, but yes, for
> now, this is fine.
> 
>> @@ -888,7 +889,6 @@ static int proc_taint(struct ctl_table *table, int write,
>>  	return err;
>>  }
>>  
>> -#ifdef CONFIG_PRINTK
>>  static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>>  				void *buffer, size_t *lenp, loff_t *ppos)
>>  {
>> @@ -897,7 +897,6 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>>  
>>  	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>>  }
>> -#endif
>>  
>>  /**
>>   * struct do_proc_dointvec_minmax_conv_param - proc_dointvec_minmax() range checking structure
>> @@ -3264,6 +3263,15 @@ static struct ctl_table fs_table[] = {
>>  		.extra1		= SYSCTL_ZERO,
>>  		.extra2		= &two,
>>  	},
>> +	{
>> +		.procname       = "open_mayexec_enforce",
>> +		.data           = &sysctl_open_mayexec_enforce,
>> +		.maxlen         = sizeof(int),
>> +		.mode           = 0600,
>> +		.proc_handler	= proc_dointvec_minmax_sysadmin,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= &three,
>> +	},
>>  #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
>>  	{
>>  		.procname	= "binfmt_misc",
>> -- 
>> 2.27.0
>>
> 
