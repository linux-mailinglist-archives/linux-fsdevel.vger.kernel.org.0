Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B33EA1CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 11:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbhHLJSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 05:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235317AbhHLJSX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:18:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C8256056B;
        Thu, 12 Aug 2021 09:17:44 +0000 (UTC)
Date:   Thu, 12 Aug 2021 11:17:42 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Hildenbrand <david@redhat.com>
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
        Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 2/7] kernel/fork: factor out atomcially replacing the
 current MM exe_file
Message-ID: <20210812091742.nbnmsa37adaqkxwd@wittgenstein>
References: <20210812084348.6521-1-david@redhat.com>
 <20210812084348.6521-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210812084348.6521-3-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 10:43:43AM +0200, David Hildenbrand wrote:
> Let's factor the main logic out into atomic_set_mm_exe_file(), such that
> all mm->exe_file logic is contained in kernel/fork.c.
> 
> While at it, perform some simple cleanups that are possible now that
> we're simplifying the individual functions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Looks good.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  include/linux/mm.h |  2 ++
>  kernel/fork.c      | 35 +++++++++++++++++++++++++++++++++--
>  kernel/sys.c       | 33 +--------------------------------
>  3 files changed, 36 insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7ca22e6e694a..197505324b74 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2581,6 +2581,8 @@ extern int mm_take_all_locks(struct mm_struct *mm);
>  extern void mm_drop_all_locks(struct mm_struct *mm);
>  
>  extern void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file);
> +extern int atomic_set_mm_exe_file(struct mm_struct *mm,
> +				  struct file *new_exe_file);
>  extern struct file *get_mm_exe_file(struct mm_struct *mm);
>  extern struct file *get_task_exe_file(struct task_struct *task);
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index bc94b2cc5995..6bd2e52bcdfb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1149,8 +1149,8 @@ void mmput_async(struct mm_struct *mm)
>   * Main users are mmput() and sys_execve(). Callers prevent concurrent
>   * invocations: in mmput() nobody alive left, in execve task is single
>   * threaded. sys_prctl(PR_SET_MM_MAP/EXE_FILE) also needs to set the
> - * mm->exe_file, but does so without using set_mm_exe_file() in order
> - * to avoid the need for any locks.
> + * mm->exe_file, but uses atomic_set_mm_exe_file(), avoiding the need
> + * for any locks.
>   */
>  void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>  {
> @@ -1170,6 +1170,37 @@ void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>  		fput(old_exe_file);
>  }
>  
> +int atomic_set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
> +{
> +	struct vm_area_struct *vma;
> +	struct file *old_exe_file;
> +	int ret = 0;
> +
> +	/* Forbid mm->exe_file change if old file still mapped. */
> +	old_exe_file = get_mm_exe_file(mm);
> +	if (old_exe_file) {
> +		mmap_read_lock(mm);
> +		for (vma = mm->mmap; vma && !ret; vma = vma->vm_next) {
> +			if (!vma->vm_file)
> +				continue;
> +			if (path_equal(&vma->vm_file->f_path,
> +				       &old_exe_file->f_path))
> +				ret = -EBUSY;
> +		}
> +		mmap_read_unlock(mm);
> +		fput(old_exe_file);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* set the new file, lockless */
> +	get_file(new_exe_file);
> +	old_exe_file = xchg(&mm->exe_file, new_exe_file);
> +	if (old_exe_file)
> +		fput(old_exe_file);
> +	return 0;
> +}
> +
>  /**
>   * get_mm_exe_file - acquire a reference to the mm's executable file
>   *
> diff --git a/kernel/sys.c b/kernel/sys.c
> index ef1a78f5d71c..40551b411fda 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1846,7 +1846,6 @@ SYSCALL_DEFINE1(umask, int, mask)
>  static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
>  {
>  	struct fd exe;
> -	struct file *old_exe, *exe_file;
>  	struct inode *inode;
>  	int err;
>  
> @@ -1869,40 +1868,10 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
>  	if (err)
>  		goto exit;
>  
> -	/*
> -	 * Forbid mm->exe_file change if old file still mapped.
> -	 */
> -	exe_file = get_mm_exe_file(mm);
> -	err = -EBUSY;
> -	if (exe_file) {
> -		struct vm_area_struct *vma;
> -
> -		mmap_read_lock(mm);
> -		for (vma = mm->mmap; vma; vma = vma->vm_next) {
> -			if (!vma->vm_file)
> -				continue;
> -			if (path_equal(&vma->vm_file->f_path,
> -				       &exe_file->f_path))
> -				goto exit_err;
> -		}
> -
> -		mmap_read_unlock(mm);
> -		fput(exe_file);
> -	}
> -
> -	err = 0;
> -	/* set the new file, lockless */
> -	get_file(exe.file);
> -	old_exe = xchg(&mm->exe_file, exe.file);
> -	if (old_exe)
> -		fput(old_exe);
> +	err = atomic_set_mm_exe_file(mm, exe.file);
>  exit:
>  	fdput(exe);
>  	return err;
> -exit_err:
> -	mmap_read_unlock(mm);
> -	fput(exe_file);
> -	goto exit;
>  }
>  
>  /*
> -- 
> 2.31.1
> 
