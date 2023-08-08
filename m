Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D7E774717
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjHHTJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjHHTIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:08:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9A6D4BE3;
        Tue,  8 Aug 2023 09:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A13686276F;
        Tue,  8 Aug 2023 16:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C35C433C9;
        Tue,  8 Aug 2023 16:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691512206;
        bh=5G8mzHZ/G+TV3SAivIUtEjhWmnKt5Abi9P5huMAAAyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzjjbdoUOt5x4D0Yfv5R/88faJhkZIrd4hGV+rkSauI4c3hQonvorKA5KXe45USG1
         7x04BEcfo9G2Ke3tH42RwvEqb3ixB2p/PecsB9QG4QKEAVSmx8HoJwmVr8PFrFsCn7
         p+4GLps36CGRJ6XwyCWrzsX2uZomuGQEijiiW6q/tZr7Eddpjat3US3HTVrKDVAzUD
         oMB3JEdiASacZazzbtobqcWRsh7agCy4QQLm27peDt2RRNJMxg2YAsU0IqFNDq4QqP
         US5vziwcXZV+0CehvRWLX0Zug9XZEx/TMDpkaTdB+1MTKRrF+xRLa7UnvHU7FAeCig
         lx+M7dDKYKcYg==
Date:   Tue, 8 Aug 2023 18:30:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 (kindof)] fs: use __fput_sync in close(2)
Message-ID: <20230808-lebst-vorgibt-75c3010b4e54@brauner>
References: <20230806230627.1394689-1-mjguzik@gmail.com>
 <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <20230808-eingaben-lumpen-e3d227386e23@brauner>
 <CAGudoHF=cEvXy3v96dN_ruXHnPv33BA6fA+dCWCm-9L3xgMPNQ@mail.gmail.com>
 <20230808-unsensibel-scham-c61a71622ae7@brauner>
 <CAGudoHEQ6Tq=88VKqurypjHqOzfU2eBmPts4+H8C7iNu96MRKQ@mail.gmail.com>
 <CAGudoHGqRr_WNz86pmgK9Kmnwsox+_XXqqbp+rLW53e5t8higg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHGqRr_WNz86pmgK9Kmnwsox+_XXqqbp+rLW53e5t8higg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 05:07:22PM +0200, Mateusz Guzik wrote:
> I slapped the following variant just for illustration purposes.
> 
> - adds __close_fd which returns a struct file
> - adds __filp_close with a flag whether to fput
> - makes close(2) use both
> - transparent to everyone else
> 
> Downside is that __fput_sync still loses the assert. Instead of
> losing, it could perhaps be extended with a hack to check syscall
> number -- pass if either this is close (or binary compat close) or a
> kthread, BUG out otherwise. Alternatively perhaps deref could be
> opencoded along with a comment about real fput that this is taking
> place. Or maybe some other cosmetic choice.
> 
> I cannot compile-test right now, so down below is a rough copy make
> sure it is clear what I mean.
> 
> I feel compelled to note that simple patches get microbenchmarked all
> the time, with these results being the only justification provided.
> I'm confused why this patch is supposed to be an exception given its
> simplicity.
> 
> Serious justification should be expected from tough calls --
> complicated, invasive changes, maybe with numerous tradeoffs.
> 
> In contrast close(2) doing __fput_sync looks a clear cut thing to do,
> at worst one can argue which way to do it.
> 
> diff --git a/fs/file.c b/fs/file.c
> index 3fd003a8604f..c341b07533b0 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -651,20 +651,30 @@ static struct file *pick_file(struct
> files_struct *files, unsigned fd)
>         return file;
>  }
> 
> -int close_fd(unsigned fd)
> +struct file *__close_fd(unsigned fd, struct file_struct *files)
>  {
> -       struct files_struct *files = current->files;
>         struct file *file;
> 
>         spin_lock(&files->file_lock);
>         file = pick_file(files, fd);
>         spin_unlock(&files->file_lock);
> +
> +       return file;
> +}
> +EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
> +
> +int close_fd(unsigned fd)
> +{
> +       struct files_struct *files = current->files;
> +       struct file *file;
> +
> +       file = __close_fd(fd, files);
>         if (!file)
>                 return -EBADF;
> 
>         return filp_close(file, files);
>  }
> -EXPORT_SYMBOL(close_fd); /* for ksys_close() */
> +EXPORT_SYMBOL(close_fd);
> 
>  /**
>   * last_fd - return last valid index into fd table
> diff --git a/fs/file_table.c b/fs/file_table.c
> index fc7d677ff5ad..b7461f0b73f4 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -463,6 +463,11 @@ void __fput_sync(struct file *file)
>  {
>         if (atomic_long_dec_and_test(&file->f_count)) {
>                 struct task_struct *task = current;
> +               /*
> +                * I see 2 basic options
> +                * 1. just remove the assert
> +                * 2. demand the flag *or* that the caller is close(2)
> +                */
>                 BUG_ON(!(task->flags & PF_KTHREAD));
>                 __fput(file);
>         }
> diff --git a/fs/open.c b/fs/open.c
> index e6ead0f19964..b1602307c1c3 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1533,7 +1533,16 @@ EXPORT_SYMBOL(filp_close);
>   */
>  SYSCALL_DEFINE1(close, unsigned int, fd)
>  {
> -       int retval = close_fd(fd);
> +       struct files_struct *files = current->files;
> +       struct file *file;
> +       int retval;
> +
> +       file = __close_fd(fd);
> +       if (!file)
> +               return -EBADF;
> +
> +       retval = __filp_close(file, files, false);
> +       __fput_sync(file);
> 
>         /* can't restart close syscall because file table entry was cleared */
>         if (unlikely(retval == -ERESTARTSYS ||
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 562f2623c9c9..e64c0238a65f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2388,7 +2388,11 @@ static inline struct file
> *file_clone_open(struct file *file)
>  {
>         return dentry_open(&file->f_path, file->f_flags, file->f_cred);
>  }
> -extern int filp_close(struct file *, fl_owner_t id);
> +extern int __filp_close(struct file *file, fl_owner_t id, bool dofput);
> +static inline int filp_close(struct file *file, fl_owner_t id)
> +{
> +       return __filp_close(file, id, true);
> +}
> 
>  extern struct filename *getname_flags(const char __user *, int, int *);
>  extern struct filename *getname_uflags(const char __user *, int);

At least make this really dumb and obvious and keep the ugliness to
internal.h and open.c

---
 fs/file_table.c | 10 ++++++++++
 fs/internal.h   |  1 +
 fs/open.c       | 21 +++++++++++++++------
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index fc7d677ff5ad..18f8adaba972 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -471,6 +471,16 @@ void __fput_sync(struct file *file)
 EXPORT_SYMBOL(fput);
 EXPORT_SYMBOL(__fput_sync);
 
+/*
+ * Same as __fput_sync() but for regular close.
+ * Not exported, not for general use.
+ */
+void fput_sync(struct file *file)
+{
+	if (atomic_long_dec_and_test(&file->f_count))
+		__fput(file);
+}
+
 void __init files_init(void)
 {
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
diff --git a/fs/internal.h b/fs/internal.h
index f7a3dc111026..1ad2a4ce728b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -297,6 +297,7 @@ static inline ssize_t do_get_acl(struct mnt_idmap *idmap,
 #endif
 
 ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos);
+void fput_sync(struct file *file);
 
 /*
  * fs/attr.c
diff --git a/fs/open.c b/fs/open.c
index e6ead0f19964..2540b22fb114 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1499,11 +1499,7 @@ SYSCALL_DEFINE2(creat, const char __user *, pathname, umode_t, mode)
 }
 #endif
 
-/*
- * "id" is the POSIX thread ID. We use the
- * files pointer for this..
- */
-int filp_close(struct file *filp, fl_owner_t id)
+static int __filp_close(struct file *filp, fl_owner_t id, bool may_delay)
 {
 	int retval = 0;
 
@@ -1520,10 +1516,23 @@ int filp_close(struct file *filp, fl_owner_t id)
 		dnotify_flush(filp, id);
 		locks_remove_posix(filp, id);
 	}
-	fput(filp);
+
+	if (may_delay)
+		fput(filp);
+	else
+		fput_sync(filp);
 	return retval;
 }
 
+/*
+ * "id" is the POSIX thread ID. We use the
+ * files pointer for this..
+ */
+int filp_close(struct file *filp, fl_owner_t id)
+{
+	return __filp_close(filp, id, true);
+}
+
 EXPORT_SYMBOL(filp_close);
 
 /*
-- 
2.34.1

