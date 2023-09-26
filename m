Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C177AF6AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 01:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjIZXUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 19:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjIZXR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:17:59 -0400
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED541A668;
        Tue, 26 Sep 2023 15:19:11 -0700 (PDT)
Received: from quad.stoffel.org (097-095-183-072.res.spectrum.com [97.95.183.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id D38E51E132;
        Tue, 26 Sep 2023 16:59:55 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 4452DA899D; Tue, 26 Sep 2023 16:59:55 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25875.17995.247620.601505@quad.stoffel.home>
Date:   Tue, 26 Sep 2023 16:59:55 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] vfs: shave work on failed file open
In-Reply-To: <20230925205545.4135472-1-mjguzik@gmail.com>
References: <20230925205545.4135472-1-mjguzik@gmail.com>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>>>> "Mateusz" == Mateusz Guzik <mjguzik@gmail.com> writes:

> Failed opens (mostly ENOENT) legitimately happen a lot, for example here
> are stats from stracing kernel build for few seconds (strace -fc make):

>   % time     seconds  usecs/call     calls    errors syscall
>   ------ ----------- ----------- --------- --------- ------------------
>     0.76    0.076233           5     15040      3688 openat

> (this is tons of header files tried in different paths)

> Apart from a rare corner case where the file object is fully constructed
> and we need to abort, there is a lot of overhead which can be avoided.

> Most notably delegation of freeing to task_work, which comes with an
> enormous cost (see 021a160abf62 ("fs: use __fput_sync in close(2)" for
> an example).

> Benched with will-it-scale with a custom testcase based on
> tests/open1.c:
> [snip]
>         while (1) {
>                 int fd = open("/tmp/nonexistent", O_RDONLY);
>                 assert(fd == -1);

>                 (*iterations)++;
>         }
> [/snip]

> Sapphire Rapids, one worker in single-threaded case (ops/s):
> before:	1950013
> after:	2914973 (+49%)


So what are the times in a multi-threaded case?  Just wondering what
happens if you have a bunch of makes or other jobs like that all
running at once. 


> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/file_table.c      | 39 +++++++++++++++++++++++++++++++++++++++
>  fs/namei.c           |  2 +-
>  include/linux/file.h |  1 +
>  3 files changed, 41 insertions(+), 1 deletion(-)

> diff --git a/fs/file_table.c b/fs/file_table.c
> index ee21b3da9d08..320dc1f9aa0e 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -82,6 +82,16 @@ static inline void file_free(struct file *f)
>  	call_rcu(&f->f_rcuhead, file_free_rcu);
>  }
 
> +static inline void file_free_badopen(struct file *f)
> +{
> +	BUG_ON(f->f_mode & (FMODE_BACKING | FMODE_OPENED));

eww... what a BUG_ON() here?  This seems *way* overkill to crash the
system here, and you don't even check if f exists first as well, since
I assume the caller checks it or already knows it?  

Why not just return an error here and keep going?  What happens if you do?


> +	security_file_free(f);
> +	put_cred(f->f_cred);
> +	if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
> +		percpu_counter_dec(&nr_files);
> +	kmem_cache_free(filp_cachep, f);
> +}
> +
>  /*
>   * Return the total number of open files in the system
>   */
> @@ -468,6 +478,35 @@ void __fput_sync(struct file *file)
>  EXPORT_SYMBOL(fput);
>  EXPORT_SYMBOL(__fput_sync);
 
> +/*
> + * Clean up after failing to open (e.g., open(2) returns with -ENOENT).
> + *
> + * This represents opportunities to shave on work in the common case compared
> + * to the usual fput:
> + * 1. vast majority of the time FMODE_OPENED is not set, meaning there is no
> + *    need to delegate to task_work
> + * 2. if the above holds then we are guaranteed we have the only reference with
> + *    nobody else seeing the file, thus no need to use atomics to release it
> + * 3. then there is no need to delegate freeing to RCU
> + */
> +void fput_badopen(struct file *file)
> +{
> +	if (unlikely(file->f_mode & (FMODE_BACKING | FMODE_OPENED))) {
> +		fput(file);
> +		return;
> +	}
> +
> +	if (WARN_ON(atomic_long_read(&file->f_count) != 1)) {
> +		fput(file);
> +		return;
> +	}
> +
> +	/* zero out the ref count to appease possible asserts */
> +	atomic_long_set(&file->f_count, 0);
> +	file_free_badopen(file);
> +}
> +EXPORT_SYMBOL(fput_badopen);
> +
>  void __init files_init(void)
>  {
>  	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
> diff --git a/fs/namei.c b/fs/namei.c
> index 567ee547492b..67579fe30b28 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3802,7 +3802,7 @@ static struct file *path_openat(struct nameidata *nd,
>  		WARN_ON(1);
>  		error = -EINVAL;
>  	}
> -	fput(file);
> +	fput_badopen(file);
>  	if (error == -EOPENSTALE) {
>  		if (flags & LOOKUP_RCU)
>  			error = -ECHILD;
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 6e9099d29343..96300e27d9a8 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -15,6 +15,7 @@
>  struct file;
 
>  extern void fput(struct file *);
> +extern void fput_badopen(struct file *);
 
>  struct file_operations;
>  struct task_struct;
> -- 
> 2.39.2

