Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9BB3EA2AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 12:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbhHLKGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 06:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231470AbhHLKGY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:06:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6346160FBF;
        Thu, 12 Aug 2021 10:05:47 +0000 (UTC)
Date:   Thu, 12 Aug 2021 12:05:44 +0200
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
        x86@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v1 3/7] kernel/fork: always deny write access to current
 MM exe_file
Message-ID: <20210812100544.uhsfp75b4jcrv3qx@wittgenstein>
References: <20210812084348.6521-1-david@redhat.com>
 <20210812084348.6521-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210812084348.6521-4-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+Cc Andrei]

On Thu, Aug 12, 2021 at 10:43:44AM +0200, David Hildenbrand wrote:
> We want to remove VM_DENYWRITE only currently only used when mapping the
> executable during exec. During exec, we already deny_write_access() the
> executable, however, after exec completes the VMAs mapped
> with VM_DENYWRITE effectively keeps write access denied via
> deny_write_access().
> 
> Let's deny write access when setting the MM exe_file. With this change, we
> can remove VM_DENYWRITE for mapping executables.
> 
> This represents a minor user space visible change:
> sys_prctl(PR_SET_MM_EXE_FILE) can now fail if the file is already
> opened writable. Also, after sys_prctl(PR_SET_MM_EXE_FILE), the file

Just for completeness, this also affects PR_SET_MM_MAP when exe_fd is
set.

> cannot be opened writable. Note that we can already fail with -EACCES if
> the file doesn't have execute permissions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

The biggest user I know and that I'm involved in is CRIU which heavily
uses PR_SET_MM_MAP (with a fallback to PR_SET_MM_EXE_FILE on older
kernels) during restore. Afair, criu opens the exe fd as an O_PATH
during dump and thus will use the same flag during restore when
opening it. So that should be fine.

However, if I understand the consequences of this change correctly, a
problem could be restoring workloads that hold a writable fd open to
their exe file at dump time which would mean that during restore that fd
would be reopened writable causing CRIU to fail when setting the exe
file for the task to be restored.

Which honestly, no idea how many such workloads exist. (I know at least
of runC and LXC need to sometimes reopen to rexec themselves (weird bug
to protect against attacking the exe file) and thus re-open
/proc/self/exe but read-only.)

>  kernel/fork.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 6bd2e52bcdfb..5d904878f19b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -476,6 +476,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  {
>  	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
>  	struct rb_node **rb_link, *rb_parent;
> +	struct file *exe_file;
>  	int retval;
>  	unsigned long charge;
>  	LIST_HEAD(uf);
> @@ -493,7 +494,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
>  
>  	/* No ordering required: file already has been exposed. */
> -	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
> +	exe_file = get_mm_exe_file(oldmm);
> +	RCU_INIT_POINTER(mm->exe_file, exe_file);
> +	if (exe_file)
> +		deny_write_access(exe_file);
>  
>  	mm->total_vm = oldmm->total_vm;
>  	mm->data_vm = oldmm->data_vm;
> @@ -638,8 +642,13 @@ static inline void mm_free_pgd(struct mm_struct *mm)
>  #else
>  static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
> +	struct file *exe_file;
> +
>  	mmap_write_lock(oldmm);
> -	RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
> +	exe_file = get_mm_exe_file(oldmm);
> +	RCU_INIT_POINTER(mm->exe_file, exe_file);
> +	if (exe_file)
> +		deny_write_access(exe_file);
>  	mmap_write_unlock(oldmm);
>  	return 0;
>  }
> @@ -1163,11 +1172,19 @@ void set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>  	 */
>  	old_exe_file = rcu_dereference_raw(mm->exe_file);
>  
> -	if (new_exe_file)
> +	if (new_exe_file) {
>  		get_file(new_exe_file);
> +		/*
> +		 * exec code is required to deny_write_access() successfully,
> +		 * so this cannot fail
> +		 */
> +		deny_write_access(new_exe_file);
> +	}
>  	rcu_assign_pointer(mm->exe_file, new_exe_file);
> -	if (old_exe_file)
> +	if (old_exe_file) {
> +		allow_write_access(old_exe_file);
>  		fput(old_exe_file);
> +	}
>  }
>  
>  int atomic_set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
> @@ -1194,10 +1211,22 @@ int atomic_set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
>  	}
>  
>  	/* set the new file, lockless */
> +	ret = deny_write_access(new_exe_file);
> +	if (ret)
> +		return -EACCES;
>  	get_file(new_exe_file);
> +
>  	old_exe_file = xchg(&mm->exe_file, new_exe_file);
> -	if (old_exe_file)
> +	if (old_exe_file) {
> +		/*
> +		 * Don't race with dup_mmap() getting the file and disallowing
> +		 * write access while someone might open the file writable.
> +		 */
> +		mmap_read_lock(mm);
> +		allow_write_access(old_exe_file);
>  		fput(old_exe_file);
> +		mmap_read_unlock(mm);
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.31.1
> 
