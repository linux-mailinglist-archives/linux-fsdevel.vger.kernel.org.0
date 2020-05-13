Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6BD1D10AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 13:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgEMLJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 07:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbgEMLJd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 07:09:33 -0400
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD905C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 04:09:32 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49MX4S5npLzlhSrK;
        Wed, 13 May 2020 13:09:28 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49MX4R0cRwzlhC5Z;
        Wed, 13 May 2020 13:09:27 +0200 (CEST)
Subject: Re: [PATCH v5 3/6] fs: Enable to enforce noexec mounts or file exec
 through O_MAYEXEC
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
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
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-4-mic@digikod.net> <202005121422.411001F1@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <6dbae682-e805-5567-39bd-4434d2cb9759@digikod.net>
Date:   Wed, 13 May 2020 13:09:26 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <202005121422.411001F1@keescook>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 12/05/2020 23:48, Kees Cook wrote:
> On Tue, May 05, 2020 at 05:31:53PM +0200, Mickaël Salaün wrote:
>> Enable to forbid access to files open with O_MAYEXEC.  Thanks to the
>> noexec option from the underlying VFS mount, or to the file execute
>> permission, userspace can enforce these execution policies.  This may
>> allow script interpreters to check execution permission before reading
>> commands from a file, or dynamic linkers to allow shared object loading.
> 
> Some language tailoring. I might change the first sentence to:
> 
> Allow for the enforcement of the O_MAYEXEC openat2(2) flag.

OK

> 
>> Add a new sysctl fs.open_mayexec_enforce to enable system administrators
>> to enforce two complementary security policies according to the
>> installed system: enforce the noexec mount option, and enforce
>> executable file permission.  Indeed, because of compatibility with
>> installed systems, only system administrators are able to check that
>> this new enforcement is in line with the system mount points and file
>> permissions.  A following patch adds documentation.
>>
>> For tailored Linux distributions, it is possible to enforce such
>> restriction at build time thanks to the CONFIG_OMAYEXEC_STATIC option.
>> The policy can then be configured with CONFIG_OMAYEXEC_ENFORCE_MOUNT and
>> CONFIG_OMAYEXEC_ENFORCE_FILE.
> 
> OMAYEXEC feels like the wrong name here. Maybe something closer to the
> sysctl name? CONFIG_OPEN_MAYEXEC?
> 
> And I think it's not needed to have 3 configs for this. That's a lot of
> mess for a corner case option. I think I would model this after other
> sysctl CONFIGs, and just call this CONFIG_OPEN_MAYEXEC_DEFAULT.
OK, I guess you mean to store the default integer value of the sysctl in
this config option.

> 
> Is _disabling_ the sysctl needed? This patch gets much smaller without
> the ..._STATIC bit. (And can we avoid "static", it means different
> things to different people. How about invert the logic and call it
> CONFIG_OPEN_MAYEXEC_SYSCTL?)

I added this in response to James's comment:
https://lore.kernel.org/lkml/alpine.LRH.2.21.2005020405210.5924@namei.org/
I'm fine to let the sysctl visible whatever the kernel config is. It
makes the code simpler. I guess tailored security distros already
protect sysctl entries anyway.

> 
> Further notes below...
> 
>> [...]
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 33b6d372e74a..70f179f6bc6c 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -39,6 +39,7 @@
>>  #include <linux/bitops.h>
>>  #include <linux/init_task.h>
>>  #include <linux/uaccess.h>
>> +#include <linux/sysctl.h>
>>  
>>  #include "internal.h"
>>  #include "mount.h"
>> @@ -411,10 +412,90 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
>>  	return 0;
>>  }
>>  
>> +#define OMAYEXEC_ENFORCE_NONE	0
> 
> Like the CONFIG, I'd stay close to the sysctl, OPEN_MAYEXEC_ENFORCE_...
> 
>> +#define OMAYEXEC_ENFORCE_MOUNT	(1 << 0)
>> +#define OMAYEXEC_ENFORCE_FILE	(1 << 1)
> 
> Please use BIT(0), BIT(1)...
> 
>> +#define _OMAYEXEC_LAST		OMAYEXEC_ENFORCE_FILE
>> +#define _OMAYEXEC_MASK		((_OMAYEXEC_LAST << 1) - 1)
>> +
>> +#ifdef CONFIG_OMAYEXEC_STATIC
>> +const int sysctl_omayexec_enforce =
>> +#ifdef CONFIG_OMAYEXEC_ENFORCE_MOUNT
>> +	OMAYEXEC_ENFORCE_MOUNT |
>> +#endif
>> +#ifdef CONFIG_OMAYEXEC_ENFORCE_FILE
>> +	OMAYEXEC_ENFORCE_FILE |
>> +#endif
>> +	OMAYEXEC_ENFORCE_NONE;
>> +#else /* CONFIG_OMAYEXEC_STATIC */
>> +int sysctl_omayexec_enforce __read_mostly = OMAYEXEC_ENFORCE_NONE;
>> +#endif /* CONFIG_OMAYEXEC_STATIC */
> 
> 
> If you keep CONFIG_OPEN_MAYEXEC_SYSCTL, you could do this in namei.h:
> 
> #ifdef CONFIG_OPEN_MAYEXEC_SYSCTL
> #define __sysctl_writable	__read_mostly
> #else
> #define __sysctl_write		const
> #endif
> 
> Then with my proposed change to the enforce CONFIG, all of this is
> reduced to simply:
> 
> int open_mayexec_enforce __sysctl_writable = CONFIG_OPEN_MAYEXEC_DEFAULT;

Except the position of the const, this is clearer indeed.

> 
>> +
>> +/*
>> + * Handle open_mayexec_enforce sysctl
>> + */
>> +#if defined(CONFIG_SYSCTL) && !defined(CONFIG_OMAYEXEC_STATIC)
>> +int proc_omayexec(struct ctl_table *table, int write, void __user *buffer,
>> +		size_t *lenp, loff_t *ppos)
>> +{
>> +	int error;
>> +
>> +	if (write) {
>> +		struct ctl_table table_copy;
>> +		int tmp_mayexec_enforce;
>> +
>> +		if (!capable(CAP_MAC_ADMIN))
>> +			return -EPERM;
>> +
>> +		tmp_mayexec_enforce = *((int *)table->data);
>> +		table_copy = *table;
>> +		/* Do not erase sysctl_omayexec_enforce. */
>> +		table_copy.data = &tmp_mayexec_enforce;
>> +		error = proc_dointvec(&table_copy, write, buffer, lenp, ppos);
>> +		if (error)
>> +			return error;
>> +
>> +		if ((tmp_mayexec_enforce | _OMAYEXEC_MASK) != _OMAYEXEC_MASK)
>> +			return -EINVAL;
>> +
>> +		*((int *)table->data) = tmp_mayexec_enforce;
>> +	} else {
>> +		error = proc_dointvec(table, write, buffer, lenp, ppos);
>> +		if (error)
>> +			return error;
>> +	}
>> +	return 0;
>> +}
>> +#endif
> 
> I don't think any of this is needed. There are no complex bit field
> interactions to check for. The sysctl is min=0, max=3. The only thing
> special here is checking CAP_MAC_ADMIN. I would just add
> proc_dointvec_minmax_macadmin(), like we have for ..._minmax_sysadmin().

OK

> 
>> +
>> +/**
>> + * omayexec_inode_permission - Check O_MAYEXEC before accessing an inode
>> + *
>> + * @inode: Inode to check permission on
>> + * @mask: Right to check for (%MAY_OPENEXEC, %MAY_EXECMOUNT, %MAY_EXEC)
>> + *
>> + * Returns 0 if access is permitted, -EACCES otherwise.
>> + */
>> +static inline int omayexec_inode_permission(struct inode *inode, int mask)
>> +{
>> +	if (!(mask & MAY_OPENEXEC))
>> +		return 0;
>> +
>> +	if ((sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_MOUNT) &&
>> +			!(mask & MAY_EXECMOUNT))
>> +		return -EACCES;
>> +
>> +	if (sysctl_omayexec_enforce & OMAYEXEC_ENFORCE_FILE)
>> +		return generic_permission(inode, MAY_EXEC);
>> +
>> +	return 0;
>> +}
> 
> More naming nits: I think this should be called may_openexec() to match
> the other may_*() functions.

Other *_inode_permission() functions have a similar meaning and the same
signature. The may_*() functions have various signatures. What do the
filesystem folks prefer?

> 
>> +
>>  /**
>>   * inode_permission - Check for access rights to a given inode
>>   * @inode: Inode to check permission on
>> - * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
>> + * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC, %MAY_OPENEXEC,
>> + *        %MAY_EXECMOUNT)
>>   *
>>   * Check for read/write/execute permissions on an inode.  We use fs[ug]id for
>>   * this, letting us set arbitrary permissions for filesystem access without
>> @@ -454,6 +535,10 @@ int inode_permission(struct inode *inode, int mask)
>>  	if (retval)
>>  		return retval;
>>  
>> +	retval = omayexec_inode_permission(inode, mask);
>> +	if (retval)
>> +		return retval;
>> +
>>  	return security_inode_permission(inode, mask);
>>  }
>>  EXPORT_SYMBOL(inode_permission);
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 79435fca6c3e..39c80a64d054 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -83,6 +83,9 @@ extern int sysctl_protected_symlinks;
>>  extern int sysctl_protected_hardlinks;
>>  extern int sysctl_protected_fifos;
>>  extern int sysctl_protected_regular;
>> +#ifndef CONFIG_OMAYEXEC_STATIC
>> +extern int sysctl_omayexec_enforce;
>> +#endif
> 
> Now there's no need to wrap this in ifdef.

Right, if the sysctl can't be disabled with a kernel configuration.

> 
>>  
>>  typedef __kernel_rwf_t rwf_t;
>>  
>> @@ -3545,6 +3548,8 @@ int proc_nr_dentry(struct ctl_table *table, int write,
>>  		  void __user *buffer, size_t *lenp, loff_t *ppos);
>>  int proc_nr_inodes(struct ctl_table *table, int write,
>>  		   void __user *buffer, size_t *lenp, loff_t *ppos);
>> +int proc_omayexec(struct ctl_table *table, int write, void __user *buffer,
>> +		size_t *lenp, loff_t *ppos);
>>  int __init get_filesystem_list(char *buf);
>>  
>>  #define __FMODE_EXEC		((__force int) FMODE_EXEC)
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 8a176d8727a3..29bbf79f444c 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -1892,6 +1892,15 @@ static struct ctl_table fs_table[] = {
>>  		.extra1		= SYSCTL_ZERO,
>>  		.extra2		= &two,
>>  	},
>> +#ifndef CONFIG_OMAYEXEC_STATIC
>> +	{
>> +		.procname       = "open_mayexec_enforce",
>> +		.data           = &sysctl_omayexec_enforce,
>> +		.maxlen         = sizeof(int),
>> +		.mode           = 0600,
>> +		.proc_handler   = proc_omayexec,
> 
> This can just be min/max of 0/3 with a new macadmin handler.

OK

> 
>> +	},
>> +#endif
>>  #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
>>  	{
>>  		.procname	= "binfmt_misc",
>> diff --git a/security/Kconfig b/security/Kconfig
>> index cd3cc7da3a55..d8fac9240d14 100644
>> --- a/security/Kconfig
>> +++ b/security/Kconfig
>> @@ -230,6 +230,32 @@ config STATIC_USERMODEHELPER_PATH
>>  	  If you wish for all usermode helper programs to be disabled,
>>  	  specify an empty string here (i.e. "").
>>  
>> +menuconfig OMAYEXEC_STATIC
>> +	tristate "Configure O_MAYEXEC behavior at build time"
>> +	---help---
>> +	  Enable to enforce O_MAYEXEC at build time, and disable the dedicated
>> +	  fs.open_mayexec_enforce sysctl.
>> +
>> +	  See Documentation/admin-guide/sysctl/fs.rst for more details.
>> +
>> +if OMAYEXEC_STATIC
>> +
>> +config OMAYEXEC_ENFORCE_MOUNT
>> +	bool "Mount restriction"
>> +	default y
>> +	---help---
>> +	  Forbid opening files with the O_MAYEXEC option if their underlying VFS is
>> +	  mounted with the noexec option or if their superblock forbids execution
>> +	  of its content (e.g., /proc).
>> +
>> +config OMAYEXEC_ENFORCE_FILE
>> +	bool "File permission restriction"
>> +	---help---
>> +	  Forbid opening files with the O_MAYEXEC option if they are not marked as
>> +	  executable for the current process (e.g., POSIX permissions).
>> +
>> +endif # OMAYEXEC_STATIC
>> +
>>  source "security/selinux/Kconfig"
>>  source "security/smack/Kconfig"
>>  source "security/tomoyo/Kconfig"
>> -- 
>> 2.26.2
>>
> 
> Otherwise, yeah, the intent here looks good to me.
> 
