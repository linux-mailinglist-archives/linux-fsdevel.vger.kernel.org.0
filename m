Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9F46D8A94
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 00:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjDEW3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 18:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjDEW3E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:29:04 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0222139
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 15:29:02 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h8-20020a654688000000b0050fa9ced8e3so11055503pgr.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Apr 2023 15:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680733742;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GWR9MlnovPb4azeMHr07bRFmjnPJymKEQvz5exk2wDc=;
        b=VmY8UlSKwzQO0K5HFS4LZyNPsx2yz03z8VFeH0jzD3xNKquWByhUadcUB64clw/ukK
         PS0lE7ms2N4zjfi8yBjDa838Jv9P/Ebe1rmQaDpZapGQHrRUF7T36fqfDV4nrOsV5AMd
         SGz0kry10Itl5RDl9lqCNIJymFOfJXu3eyUU9TTKRLkH+oIyMJ/lPP7ew2v5fMpzLKgu
         h2uPt2YYNrcvek8x7z9xu1hq0h+WSNdpNf1iKUK96UPq7N13/VzzDBzL4pGp1LrBOcqG
         9eHu/EI4kCb1GuSPO4OgPgpAKgvx41nOj6p+bBeCRlZUmYgF2jGC97zqN3Q2IAWdiWYG
         FlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680733742;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWR9MlnovPb4azeMHr07bRFmjnPJymKEQvz5exk2wDc=;
        b=x7tMuz00OdSsJMJjj1oMRtyevTySM7jvhS5kDWKsCg5eJ3NYd8QGvJfm4IrB+x9yn1
         +pJAQWIk0qmDAQwPoTNOSgINTk5eAFnEhpYSFnOElrwaHHpCuogtnaSIf7j7jbVQCqSZ
         fq452Ui7zN8HvWzGJ0TqsyGuSpntxAxPUdRGGS5NRDKsbmLv4YkUklXNu6riSNVltFPe
         ZLXACOX192AgC/ZF8vowTLCO14thM3F6t96RjUtGtq17gT5y2jLimQv9yHnyEaU1X+Tk
         hiwmzF7mulYUqMnSC/rGZiXtDDYckGvMLGihGnM5TnQG2oBjWbZbdx+Sxftz0aG3yLSy
         12hQ==
X-Gm-Message-State: AAQBX9dz8OpBeep2MV4u2e/cAFy9JGBREWZkKa3Ip3om25Bxt57TKqoo
        yVrGjOvQXKp2kWKSE75DvU0xhFVNZ4pgcb7BoA==
X-Google-Smtp-Source: AKy350YZoCywDUVBhRVt0H67teuAx9CW+FCj9ARmbfK2XibL5Z5UEPVhVCnv/dIxeX7eINO95mUrqIM2r7ufZiriPQ==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:7308:b0:23f:1caa:233a with
 SMTP id m8-20020a17090a730800b0023f1caa233amr1734038pjk.1.1680733741709; Wed,
 05 Apr 2023 15:29:01 -0700 (PDT)
Date:   Wed, 05 Apr 2023 22:29:00 +0000
In-Reply-To: <f0232380-4171-f4d3-f1a6-07993e551b46@redhat.com> (message from
 David Hildenbrand on Mon, 3 Apr 2023 10:21:48 +0200)
Mime-Version: 1.0
Message-ID: <diqzilea0xqr.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [RFC PATCH v3 1/2] mm: restrictedmem: Allow userspace to specify
 mount for memfd_restricted
From:   Ackerley Tng <ackerleytng@google.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, chao.p.peng@linux.intel.com,
        corbet@lwn.net, dave.hansen@intel.com, ddutile@redhat.com,
        dhildenb@redhat.com, hpa@zytor.com, hughd@google.com,
        jlayton@kernel.org, jmattson@google.com, joro@8bytes.org,
        jun.nakajima@intel.com, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, luto@kernel.org, mail@maciej.szmigiero.name,
        mhocko@suse.com, michael.roth@amd.com, mingo@redhat.com,
        naoya.horiguchi@nec.com, pbonzini@redhat.com, qperret@google.com,
        rppt@kernel.org, seanjc@google.com, shuah@kernel.org,
        steven.price@arm.com, tabba@google.com, tglx@linutronix.de,
        vannapurve@google.com, vbabka@suse.cz, vkuznets@redhat.com,
        wanpengli@tencent.com, wei.w.wang@intel.com, x86@kernel.org,
        yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Thanks for your review!

David Hildenbrand <david@redhat.com> writes:

> On 01.04.23 01:50, Ackerley Tng wrote:

>> ...

>> diff --git a/include/uapi/linux/restrictedmem.h  
>> b/include/uapi/linux/restrictedmem.h
>> new file mode 100644
>> index 000000000000..22d6f2285f6d
>> --- /dev/null
>> +++ b/include/uapi/linux/restrictedmem.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +#ifndef _UAPI_LINUX_RESTRICTEDMEM_H
>> +#define _UAPI_LINUX_RESTRICTEDMEM_H
>> +
>> +/* flags for memfd_restricted */
>> +#define RMFD_USERMNT		0x0001U

> I wonder if we can come up with a more expressive prefix than RMFD.
> Sounds more like "rm fd" ;) Maybe it should better match the
> "memfd_restricted" syscall name, like "MEMFD_RSTD_USERMNT".


RMFD did actually sound vulgar, I'm good with MEMFD_RSTD_USERMNT!

>> +
>> +#endif /* _UAPI_LINUX_RESTRICTEDMEM_H */
>> diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
>> index c5d869d8c2d8..f7b62364a31a 100644
>> --- a/mm/restrictedmem.c
>> +++ b/mm/restrictedmem.c
>> @@ -1,11 +1,12 @@
>>    // SPDX-License-Identifier: GPL-2.0
>> -#include "linux/sbitmap.h"

> Looks like an unrelated change?


Will remove this in the next revision.

>> +#include <linux/namei.h>
>>    #include <linux/pagemap.h>
>>    #include <linux/pseudo_fs.h>
>>    #include <linux/shmem_fs.h>
>>    #include <linux/syscalls.h>
>>    #include <uapi/linux/falloc.h>
>>    #include <uapi/linux/magic.h>
>> +#include <uapi/linux/restrictedmem.h>
>>    #include <linux/restrictedmem.h>

>>    struct restrictedmem {
>> @@ -189,19 +190,20 @@ static struct file  
>> *restrictedmem_file_create(struct file *memfd)
>>    	return file;
>>    }

>> -SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
>> +static int restrictedmem_create(struct vfsmount *mount)
>>    {
>>    	struct file *file, *restricted_file;
>>    	int fd, err;

>> -	if (flags)
>> -		return -EINVAL;
>> -
>>    	fd = get_unused_fd_flags(0);
>>    	if (fd < 0)
>>    		return fd;

>> -	file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
>> +	if (mount)
>> +		file = shmem_file_setup_with_mnt(mount, "memfd:restrictedmem", 0,  
>> VM_NORESERVE);
>> +	else
>> +		file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
>> +
>>    	if (IS_ERR(file)) {
>>    		err = PTR_ERR(file);
>>    		goto err_fd;
>> @@ -223,6 +225,66 @@ SYSCALL_DEFINE1(memfd_restricted, unsigned int,  
>> flags)
>>    	return err;
>>    }

>> +static bool is_shmem_mount(struct vfsmount *mnt)
>> +{
>> +	return mnt && mnt->mnt_sb && mnt->mnt_sb->s_magic == TMPFS_MAGIC;
>> +}
>> +
>> +static bool is_mount_root(struct file *file)
>> +{
>> +	return file->f_path.dentry == file->f_path.mnt->mnt_root;
>> +}

> I'd inline at least that function, pretty self-explaining.


Will inline this in the next revision.

>> +
>> +static int restrictedmem_create_on_user_mount(int mount_fd)
>> +{
>> +	int ret;
>> +	struct fd f;
>> +	struct vfsmount *mnt;
>> +
>> +	f = fdget_raw(mount_fd);
>> +	if (!f.file)
>> +		return -EBADF;
>> +
>> +	ret = -EINVAL;
>> +	if (!is_mount_root(f.file))
>> +		goto out;
>> +
>> +	mnt = f.file->f_path.mnt;
>> +	if (!is_shmem_mount(mnt))
>> +		goto out;
>> +
>> +	ret = file_permission(f.file, MAY_WRITE | MAY_EXEC);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = mnt_want_write(mnt);
>> +	if (unlikely(ret))
>> +		goto out;
>> +
>> +	ret = restrictedmem_create(mnt);
>> +
>> +	mnt_drop_write(mnt);
>> +out:
>> +	fdput(f);
>> +
>> +	return ret;
>> +}
>> +
>> +SYSCALL_DEFINE2(memfd_restricted, unsigned int, flags, int, mount_fd)
>> +{
>> +	if (flags & ~RMFD_USERMNT)
>> +		return -EINVAL;
>> +
>> +	if (flags == RMFD_USERMNT) {
>> +		if (mount_fd < 0)
>> +			return -EINVAL;
>> +
>> +		return restrictedmem_create_on_user_mount(mount_fd);
>> +	} else {
>> +		return restrictedmem_create(NULL);
>> +	}


> You can drop the else case:

> if (flags == RMFD_USERMNT) {
> 	...
> 	return restrictedmem_create_on_user_mount(mount_fd);
> }
> return restrictedmem_create(NULL);


I'll be refactoring this to adopt Kirill's suggestion of using a single
restrictedmem_create(mnt) call.


> I do wonder if you want to properly check for a flag instead of
> comparing values. Results in a more natural way to deal with flags:

> if (flags & RMFD_USERMNT) {

> }


Will use this in the next revision.

>> +}
>> +
>>    int restrictedmem_bind(struct file *file, pgoff_t start, pgoff_t end,
>>    		       struct restrictedmem_notifier *notifier, bool exclusive)
>>    {

> The "memfd_restricted" vs. "restrictedmem" terminology is a bit
> unfortunate, but not your fault here.


> I'm not a FS person, but it does look good to me.
