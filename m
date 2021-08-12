Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC283EA2DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 12:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhHLKOT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 06:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236419AbhHLKOP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628763229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8fNLHegk5RzvmFVmibZ710pAngI+WF9X5zWgbKhZ8g=;
        b=TJwEb5GGr6u2YYcI3F2FXTd1YoDeBbXngd0o7bYp379yNm5huhyHAJEnmEZ+IN3Cz/uek4
        lwoVrf3TML2aOccac8WuSm0TEnurIoVeIicq5agtFd+xwXc6JJKO7miayB6D7hdUHGKQ/v
        UpDDQNLx5RfLWi9JahJDe1x2YEm+OLA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-AjBmfIO-OxOoE7w-LiL3rA-1; Thu, 12 Aug 2021 06:13:48 -0400
X-MC-Unique: AjBmfIO-OxOoE7w-LiL3rA-1
Received: by mail-wm1-f69.google.com with SMTP id n17-20020a7bc5d10000b0290228d7e174f1so1689200wmk.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 03:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J8fNLHegk5RzvmFVmibZ710pAngI+WF9X5zWgbKhZ8g=;
        b=IZbSqYpagu4wjuHZDyEUefS0judljizbxophHVDzvFUcJrwlVaaAwhgDy+ftmDfDvv
         ViUzcg5kUaaytFnBM2V80qbD7K16xRg791bvviVRUUHxMT/cTwcw70HzpWx2l+YiV1KL
         nUEiDqqCBVCzEZ2vNTx6RXW9uIMipUsdrZZ1y4GHllKWsfCkZwEjQOc0RU0PwHOwcsO2
         dMR59hcfDAHauF4YCh8rmmbSh3tEVD0gy9Y4Zhju0rfdHqYKLWkLcJwbZ+v9b+cOBwMN
         7xHs5mWNnMOPcfioeAtg8cn8PhOUCrm12gY3NIrzFJe+8dmoHC2svRHkYUF+0X2oJBBK
         QKKA==
X-Gm-Message-State: AOAM532ByIk3U+mRstPBxwZrGSlBMXeB7Z6XBqH0l2ZNaI651CRMrQfJ
        uaNNnWrkefdsOTyVIew3pCvaNJ0KpGhgwSEyicut9Z/oho0zRmSiQ62tK8oVtvByHt3v71pQMLt
        Hbq5EAsxCBjYLlovkke9YgYvOaQ==
X-Received: by 2002:a05:600c:4f85:: with SMTP id n5mr3185700wmq.146.1628763227422;
        Thu, 12 Aug 2021 03:13:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVPOFrEbL/sos2RT24E1z82P1IG5Ylm0/152IG6CScUCHtpvAEXWsNjyopV1zDkbIpjnwS6A==
X-Received: by 2002:a05:600c:4f85:: with SMTP id n5mr3185661wmq.146.1628763227156;
        Thu, 12 Aug 2021 03:13:47 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d8b.dip0.t-ipconnect.de. [79.242.61.139])
        by smtp.gmail.com with ESMTPSA id d15sm2768384wri.96.2021.08.12.03.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 03:13:46 -0700 (PDT)
Subject: Re: [PATCH v1 3/7] kernel/fork: always deny write access to current
 MM exe_file
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrei Vagin <avagin@gmail.com>
References: <20210812084348.6521-1-david@redhat.com>
 <20210812084348.6521-4-david@redhat.com>
 <20210812100544.uhsfp75b4jcrv3qx@wittgenstein>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <1b6d27cf-2238-0c1c-c563-b38728fbabc2@redhat.com>
Date:   Thu, 12 Aug 2021 12:13:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812100544.uhsfp75b4jcrv3qx@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.08.21 12:05, Christian Brauner wrote:
> [+Cc Andrei]
> 
> On Thu, Aug 12, 2021 at 10:43:44AM +0200, David Hildenbrand wrote:
>> We want to remove VM_DENYWRITE only currently only used when mapping the
>> executable during exec. During exec, we already deny_write_access() the
>> executable, however, after exec completes the VMAs mapped
>> with VM_DENYWRITE effectively keeps write access denied via
>> deny_write_access().
>>
>> Let's deny write access when setting the MM exe_file. With this change, we
>> can remove VM_DENYWRITE for mapping executables.
>>
>> This represents a minor user space visible change:
>> sys_prctl(PR_SET_MM_EXE_FILE) can now fail if the file is already
>> opened writable. Also, after sys_prctl(PR_SET_MM_EXE_FILE), the file
> 
> Just for completeness, this also affects PR_SET_MM_MAP when exe_fd is
> set.

Correct.

> 
>> cannot be opened writable. Note that we can already fail with -EACCES if
>> the file doesn't have execute permissions.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> 
> The biggest user I know and that I'm involved in is CRIU which heavily
> uses PR_SET_MM_MAP (with a fallback to PR_SET_MM_EXE_FILE on older
> kernels) during restore. Afair, criu opens the exe fd as an O_PATH
> during dump and thus will use the same flag during restore when
> opening it. So that should be fine.

Yes.

> 
> However, if I understand the consequences of this change correctly, a
> problem could be restoring workloads that hold a writable fd open to
> their exe file at dump time which would mean that during restore that fd
> would be reopened writable causing CRIU to fail when setting the exe
> file for the task to be restored.

If it's their exe file, then the existing VM_DENYWRITE handling would 
have forbidden these workloads to open the fd of their exe file 
writable, right? At least before doing any 
PR_SET_MM_MAP/PR_SET_MM_EXE_FILE. But that should rule out quite a lot 
of cases we might be worried about, right?

> 
> Which honestly, no idea how many such workloads exist. (I know at least
> of runC and LXC need to sometimes reopen to rexec themselves (weird bug
> to protect against attacking the exe file) and thus re-open
> /proc/self/exe but read-only.)
> 
>>   kernel/fork.c | 39 ++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 34 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 6bd2e52bcdfb..5d904878f19b 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -476,6 +476,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   {
>>   	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
>>   	struct rb_node **rb_link, *rb_parent;
>> +	struct file *exe_file;
>>   	int retval;
>>   	unsigned long charge;
>>   	LIST_HEAD(uf);
>> @@ -493,7 +494,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>   	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
>>   
>>   	/* No ordering required: file already has been exposed. */
>> -	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
>> +	exe_file = get_mm_exe_file(oldmm);
>> +	RCU_INIT_POINTER(mm->exe_file, exe_file);
>> +	if (exe_file)
>> +		deny_write_access(exe_file);
>>   
>>   	mm->total_vm = oldmm->total_vm;
>>   	mm->data_vm = oldmm->data_vm;
>> @@ -638,8 +642,13 @@ static inline void mm_free_pgd(struct mm_struct *mm)
>>   #else
>>   static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>>   {
>> +	struct file *exe_file;
>> +
>>   	mmap_write_lock(oldmm);
>> -	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
>> +	exe_file = get_mm_exe_file(oldmm);
>> +	RCU_INIT_POINTER(mm->exe_file, exe_file);
>> +	if (exe_file)
>> +		deny_write_access(exe_file);
>>   	mmap_write_unlock(oldmm);
>>   	return 0;
>>   }
>> @@ -1163,11 +1172,19 @@ void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>>   	 */
>>   	old_exe_file = rcu_dereference_raw(mm->exe_file);
>>   
>> -	if (new_exe_file)
>> +	if (new_exe_file) {
>>   		get_file(new_exe_file);
>> +		/*
>> +		 * exec code is required to deny_write_access() successfully,
>> +		 * so this cannot fail
>> +		 */
>> +		deny_write_access(new_exe_file);
>> +	}
>>   	rcu_assign_pointer(mm->exe_file, new_exe_file);
>> -	if (old_exe_file)
>> +	if (old_exe_file) {
>> +		allow_write_access(old_exe_file);
>>   		fput(old_exe_file);
>> +	}
>>   }
>>   
>>   int atomic_set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>> @@ -1194,10 +1211,22 @@ int atomic_set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>>   	}
>>   
>>   	/* set the new file, lockless */
>> +	ret = deny_write_access(new_exe_file);
>> +	if (ret)
>> +		return -EACCES;
>>   	get_file(new_exe_file);
>> +
>>   	old_exe_file = xchg(&mm->exe_file, new_exe_file);
>> -	if (old_exe_file)
>> +	if (old_exe_file) {
>> +		/*
>> +		 * Don't race with dup_mmap() getting the file and disallowing
>> +		 * write access while someone might open the file writable.
>> +		 */
>> +		mmap_read_lock(mm);
>> +		allow_write_access(old_exe_file);
>>   		fput(old_exe_file);
>> +		mmap_read_unlock(mm);
>> +	}
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.31.1
>>
> 


-- 
Thanks,

David / dhildenb

