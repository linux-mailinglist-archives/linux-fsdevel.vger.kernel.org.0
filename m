Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B98E51FA45
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 12:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiEIKuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 06:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiEIKtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 06:49:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF432D4B6E;
        Mon,  9 May 2022 03:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E05160F8F;
        Mon,  9 May 2022 10:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDBFC385A8;
        Mon,  9 May 2022 10:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652092922;
        bh=dWO437yasD3GcndqysBDT1qLt6e+Ur4kAmYturrtEAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+4cIrkcMwV2Mt8qdAC66bphsNEP4VGgOG4oYvYPKusHZML+eO+/MnjGRwTRc2M/k
         YfGmIbw0iki6zZ2dDalAAAQR0z/LE2C5C/S1NY83SG5/WvRS8aNDqfWoC2l9RTzZw3
         e0na3y80GKwEYxwcsc3VO/8v1osdiAZiryDiWpZnCIhC+0N69efvgQNuVy4b0tNhOM
         QMab6QPuRba3JLhlPl7YQxDtxG1a46PlZWQf5Ow45QoxPQhQiSJXcRRs15dcyjNZd9
         x8MRwr9wie+ItEhH+floVg8KKrJH4FU7nHlTT8qThRJRgV21urZ/+S/AKJc7wE63cg
         gE1KYZqFriX7g==
Date:   Mon, 9 May 2022 12:41:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     zhanglin <zhang.lin16@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, keescook@chromium.org,
        adobriyan@gmail.com, sfr@canb.auug.org.au,
        zhengqi.arch@bytedance.com, ebiederm@xmission.com,
        kaleshsingh@google.com, stephen.s.brennan@oracle.com,
        ohoono.kwon@samsung.com, haolee.swjtu@gmail.com,
        fweimer@redhat.com, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        jiang.xuexin@zte.com.cn, zealci@zte.com.cn
Subject: Re: [PATCH] fs/proc: add mask_secrets to prevent sensitive
 information leakage.
Message-ID: <20220509104154.mnl2dm5z4nnnoda2@wittgenstein>
References: <20220509054613.6620-1-zhang.lin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509054613.6620-1-zhang.lin16@zte.com.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 01:46:13PM +0800, zhanglin wrote:
> There are about 17000+ packages exists on centos. After investigation on
> 10000+ pacakges, About 200+ commands support passing plain(or encrypted)
> passwords through command line arguments. Those sensitive information are
> exposed through a global readable interface: /proc/$pid/cmdline.
> 
> To prevent the leakcage, adding mask_secrets procfs entry will hook the
> get_mm_cmdline()'s output and mask sensitive fields in /proc/$pid/cmdline
> using repeating 'Z's.
> 
> Signed-off-by: zhanglin <zhang.lin16@zte.com.cn>
> ---

Hey zhanglin, thanks for the patch but I think that's a NAK.

* Applications that worry about this should use other means of passing
  sensitive information and there are a multitude of ways of doing so.
* This is a huge amount of (fragile looking) code to get this working.
* Introducing a special secret --password= seems hacky and a bad
  precedent for more --ARG= patches following this. The kernel should
  care about such calling conventions.
* It seems that this has potential to introduce conflicts and or
  regression for tools that make use of a --password command line switch
  in creative ways.
* Tools that currently pass passwords via the command line need to
  switch their argument passing to --password=. But if they do that they
  might as well just rework their secret passing to not pass them on the
  command line or introduce a safe way to do so.

IOW, this is all solvable in userspace without the kernel to learn about
--password and growing a huge amount of code to do so. Bad userspace
practice may but in general shouldn't require the kernel to make up for it.

>  fs/proc/Kconfig        |  20 ++
>  fs/proc/Makefile       |   1 +
>  fs/proc/base.c         |  10 +
>  fs/proc/mask_secrets.c | 593 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 624 insertions(+)
>  create mode 100644 fs/proc/mask_secrets.c
> 
> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> index c93000105..3e5ce7162 100644
> --- a/fs/proc/Kconfig
> +++ b/fs/proc/Kconfig
> @@ -107,3 +107,23 @@ config PROC_PID_ARCH_STATUS
>  config PROC_CPU_RESCTRL
>  	def_bool n
>  	depends on PROC_FS
> +
> +config PROC_MASK_SECRETS
> +	bool "mask secret fields in process cmdline"
> +	default n
> +	help
> +	  mask secret fields in process cmdline to prevent sensitive information
> +	  leakage. Enable this feature, credentials including username, passwords
> +	  will be masked with repeating 'Z'. "ZZZZZZ..." but no real sensitive
> +	  information will appear in /proc/$pid/cmdline. for example: useradd -rp
> +	  ZZZZZZ will appear in /proc/$pid/cmdline instead iif you run 'echo 1 >
> +	  /proc/mask_secrets/enabled && echo "+/usr/sbin/useradd:-p:--password" >
> +	  /proc/mask_secrets/cmdtab'.
> +
> +	  Say Y if you want to enable this feature.
> +	  Enable/Disable: echo 1/0 > /proc/mask_secrets/enabled.
> +	  Add masking rules: echo '+${command}:--${secret_opt1}:-${secret_opt2}:...
> +	  ' > /proc/mask_secrets/cmdtab.
> +	  Remove masking rules: echo '-${command}' > /proc/mask_secrets/cmdtab.
> +	  Commands must be well written in absolute path form.
> +
> diff --git a/fs/proc/Makefile b/fs/proc/Makefile
> index bd08616ed..06521b7ff 100644
> --- a/fs/proc/Makefile
> +++ b/fs/proc/Makefile
> @@ -34,3 +34,4 @@ proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
>  proc-$(CONFIG_PRINTK)	+= kmsg.o
>  proc-$(CONFIG_PROC_PAGE_MONITOR)	+= page.o
>  proc-$(CONFIG_BOOT_CONFIG)	+= bootconfig.o
> +proc-$(CONFIG_PROC_MASK_SECRETS)	+= mask_secrets.o
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index d89526cfe..9fe0de79a 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -103,6 +103,10 @@
>  
>  #include "../../lib/kstrtox.h"
>  
> +#ifdef CONFIG_PROC_MASK_SECRETS
> +extern size_t mask_secrets(struct mm_struct *mm, char __user *buf, size_t count, loff_t pos);
> +#endif
> +
>  /* NOTE:
>   *	Implementing inode permission operations in /proc is almost
>   *	certainly an error.  Permission checks need to happen during
> @@ -312,6 +316,12 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
>  	if (count > arg_end - pos)
>  		count = arg_end - pos;
>  
> +#ifdef CONFIG_PROC_MASK_SECRETS
> +	len = mask_secrets(mm, buf, count, pos);
> +	if (len > 0)
> +		return len;
> +#endif
> +
>  	page = (char *)__get_free_page(GFP_KERNEL);
>  	if (!page)
>  		return -ENOMEM;
> diff --git a/fs/proc/mask_secrets.c b/fs/proc/mask_secrets.c
> new file mode 100644
> index 000000000..035230d1e
> --- /dev/null
> +++ b/fs/proc/mask_secrets.c
> @@ -0,0 +1,593 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  linux/fs/proc/mask_secrets.c
> + *
> + *  Copyright (C) 2022, 2022 zhanglin
> + *
> + *  /proc/mask_secrets directory handling functions
> + */
> +
> +#include <linux/ctype.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/hashtable.h>
> +#include <linux/mm.h>
> +#include <linux/proc_fs.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +
> +#define CMDLINE_HASHTABSIZE	1024
> +#define cmdline_hash(x)		((x) % CMDLINE_HASHTABSIZE)
> +
> +static const char *SECRET_SEPARATOR = ":";
> +static const int MASK_SECRETS_ENABLED = 1;
> +static const int MASK_SECRETS_DISABLED;
> +static DEFINE_SPINLOCK(mask_secrets_enabled_spinlock);
> +static int __rcu *mask_secrets_enabled __read_mostly = (int *)&MASK_SECRETS_DISABLED;
> +static DEFINE_SPINLOCK(cmdline_hashtab_spinlock);
> +static struct hlist_head __rcu cmdline_hashtab[CMDLINE_HASHTABSIZE] __read_mostly = {
> +	[0 ... (CMDLINE_HASHTABSIZE-1)] = HLIST_HEAD_INIT };
> +static struct kmem_cache *cmdline_hashtab_item_cachep;
> +
> +struct cmdline_hashtab_item {
> +	struct hlist_node hlist;
> +	char *cmdline;
> +	char *progname;
> +	char *secrets;
> +};
> +
> +static int is_mask_secrets_enabled(void)
> +{
> +	int ret = 0;
> +
> +	rcu_read_lock();
> +	ret = *(rcu_dereference(mask_secrets_enabled));
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +size_t mask_secrets(struct mm_struct *mm, char __user *buf,
> +			      size_t count, loff_t pos)
> +{
> +	unsigned long arg_start = 0;
> +	unsigned long arg_end = 0;
> +	int mask_arg_len = 0;
> +	size_t remote_vm_copied = 0;
> +	struct file *file = 0;
> +	struct inode *inode = 0;
> +	char *kbuf = 0;
> +	char *progname = 0;
> +	int proghash = -1;
> +	int prog_found = 0;
> +	char *mask_arg_start = 0;
> +	char *mask_arg_end = 0;
> +	struct cmdline_hashtab_item *chi = 0;
> +	char *psecret = 0;
> +	size_t psecret_len = 0;
> +	char *pmask = 0;
> +	size_t pmask_len = 0;
> +	size_t size;
> +	size_t total_copied = 0;
> +	int err = 0;
> +
> +	if (!is_mask_secrets_enabled()) {
> +		err = -EPERM;
> +		goto exit_err;
> +	}
> +
> +	spin_lock(&mm->arg_lock);
> +	arg_start = mm->arg_start;
> +	arg_end = mm->arg_end;
> +	spin_unlock(&mm->arg_lock);
> +	if (arg_start >= arg_end) {
> +		err = -ERANGE;
> +		goto exit_err;
> +	}
> +	mask_arg_len = arg_end - arg_start + 1;
> +
> +	file = get_mm_exe_file(mm);
> +	if (!file) {
> +		err = -ENOENT;
> +		goto exit_err;
> +	}
> +	inode = file_inode(file);
> +	if (!inode) {
> +		err = -ENOENT;
> +		goto exit_err;
> +	}
> +	proghash = cmdline_hash(inode->i_ino);
> +	kbuf = kzalloc(max(PATH_MAX, mask_arg_len), GFP_KERNEL);
> +	if (!kbuf) {
> +		err = -ENOMEM;
> +		goto exit_err;
> +	}
> +	progname = d_path(&file->f_path, kbuf, PATH_MAX);
> +	if (IS_ERR_OR_NULL(progname)) {
> +		err = -ENOENT;
> +		goto cleanup_kbuf;
> +	}
> +
> +	rcu_read_lock();
> +	prog_found = 0;
> +	hash_for_each_possible_rcu(cmdline_hashtab, chi, hlist, proghash)
> +		if (strcmp(chi->progname, progname) == 0) {
> +			prog_found = 1;
> +			break;
> +		}
> +
> +	if (!prog_found) {
> +		rcu_read_unlock();
> +		goto cleanup_kbuf;
> +	}
> +
> +	mask_arg_start = kbuf;
> +	mask_arg_end = mask_arg_start + (arg_end - arg_start);
> +	remote_vm_copied = access_remote_vm(mm, arg_start, mask_arg_start, mask_arg_len, FOLL_ANON);

While I'm not a core mm person and don't feel able to review this it all
seems very dodgy to me.

> +	if (remote_vm_copied <= 0) {
> +		rcu_read_unlock();
> +		err = -EIO;
> +		goto cleanup_kbuf;
> +	}
> +	/*skip progname */
> +	for (pmask = mask_arg_start; *pmask && (pmask <= mask_arg_end); pmask++)
> +		;
> +
> +	if (!chi->secrets) {
> +		rcu_read_unlock();
> +		/*mask everything, such as: xxxconnect host port username password.*/
> +		for (pmask = pmask + 1; (pmask <= mask_arg_end); pmask++)
> +			for (; (pmask <= mask_arg_end) && (*pmask); pmask++)
> +				*pmask = 'Z';
> +		goto copydata;
> +	}
> +
> +	for (pmask = pmask + 1; pmask <= mask_arg_end; pmask++) {
> +		psecret = chi->secrets;
> +		while (*psecret) {
> +			psecret_len = strlen(psecret);
> +			if (psecret_len < 2) {
> +				rcu_read_unlock();
> +				err = -EINVAL;
> +				goto cleanup_kbuf;
> +			}
> +
> +			if (strcmp(pmask, psecret) == 0) {
> +				pmask += psecret_len + 1;
> +				goto mask_secret;
> +			}
> +
> +			if (strncmp(pmask, psecret, psecret_len) == 0) {
> +				/*handle case: --password=xxxx */
> +				if ((psecret[0] == '-') && (psecret[1] == '-'))
> +					if (pmask[psecret_len] == '=') {
> +						pmask += psecret_len + 1;
> +						goto mask_secret;
> +					}
> +
> +				if (psecret[0] == '-') {
> +					/*handle case: -password=xxxx or -p=xxxx*/
> +					if (pmask[psecret_len] == '=') {
> +						pmask += psecret_len + 1;
> +						goto mask_secret;
> +					}
> +
> +					/*handle case: -pxxxx*/
> +					if (psecret_len == 2) {
> +						pmask += psecret_len;
> +						goto mask_secret;
> +					}
> +				}
> +			}
> +
> +			if (psecret_len == 2) {
> +				pmask_len = strlen(pmask);
> +				/*handle case: -yp xxxx, such as: useradd -rp xxxx*/
> +				if ((pmask_len > 2) && (*pmask == '-')
> +				      && (pmask[pmask_len - 1] == psecret[1])) {
> +					pmask += pmask_len + 1;
> +					goto mask_secret;
> +				}
> +			}
> +
> +			psecret += psecret_len + 1;
> +		}
> +
> +		pmask += strlen(pmask);
> +		continue;
> +
> +mask_secret:
> +		for (; (pmask <= mask_arg_end) && (*pmask); pmask++)
> +			*pmask = 'Z';
> +	}
> +	rcu_read_unlock();
> +
> +copydata:
> +	size = arg_end - pos;
> +	size = min_t(size_t, size, count);
> +	if (copy_to_user(buf, mask_arg_start + pos - arg_start, size))
> +		goto cleanup_kbuf;
> +
> +	total_copied = size;
> +
> +cleanup_kbuf:
> +	kfree(kbuf);
> +
> +exit_err:
> +	return total_copied;
> +}
> +
> +static int show_mask_secrets_enabled(struct seq_file *m, void *v)
> +{
> +	rcu_read_lock();
> +	seq_printf(m, "%d\n", *(rcu_dereference(mask_secrets_enabled)));
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +
> +static int open_mask_secrets_enabled(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, show_mask_secrets_enabled, NULL);
> +}
> +
> +static ssize_t write_mask_secrets_enabled(struct file *file, const char __user *buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	int val, old_val;
> +	int err = kstrtoint_from_user(buf, count, 0, &val);
> +
> +	if (err)
> +		return err;
> +
> +	if ((val != 0) && (val != 1))
> +		return -EINVAL;
> +
> +	rcu_read_lock();
> +	old_val = *(rcu_dereference(mask_secrets_enabled));
> +	rcu_read_unlock();
> +
> +	if (val == old_val)
> +		return count;
> +	spin_lock(&mask_secrets_enabled_spinlock);
> +	rcu_assign_pointer(mask_secrets_enabled,
> +		       val ? &MASK_SECRETS_ENABLED : &MASK_SECRETS_DISABLED);
> +	spin_unlock(&mask_secrets_enabled_spinlock);
> +	synchronize_rcu();
> +
> +	return count;
> +}
> +
> +static const struct proc_ops mask_secrets_enabled_proc_ops = {
> +	.proc_open	= open_mask_secrets_enabled,
> +	.proc_read	= seq_read,
> +	.proc_write	= write_mask_secrets_enabled,
> +	.proc_lseek	= seq_lseek,
> +	.proc_release	= single_release,
> +};
> +
> +
> +static int show_mask_secrets_cmdtab(struct seq_file *m, void *v)
> +{
> +	struct cmdline_hashtab_item *chi = 0;
> +	char *secret;
> +	int proghash = 0;
> +	int err = 0;
> +
> +	if (!is_mask_secrets_enabled()) {
> +		err = -EPERM;
> +		return err;
> +	}
> +
> +	rcu_read_lock();
> +	hash_for_each_rcu(cmdline_hashtab, proghash, chi, hlist) {
> +		seq_printf(m, "[%04d]: %s", proghash, chi->progname);
> +		if (chi->secrets) {
> +			secret = chi->secrets;
> +			while (*secret) {
> +				seq_printf(m, ":%s", secret);
> +				secret += strlen(secret) + 1;
> +			}
> +		}
> +		seq_puts(m, "\n");
> +	}
> +	rcu_read_unlock();
> +
> +	return err;
> +}
> +
> +static int open_mask_secrets_cmdtab(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, show_mask_secrets_cmdtab, NULL);
> +}
> +
> +static size_t serialize_cmdtab(char *buf)
> +{
> +	struct cmdline_hashtab_item *chi = 0;
> +	size_t secrets_prefix_len = strlen("[xxxx]: ");
> +	size_t secrets_cmdtab_len = 0;
> +	char *secret = 0;
> +	size_t secret_len = 0;
> +	int proghash = 0;
> +
> +	rcu_read_lock();
> +	secrets_cmdtab_len = 0;
> +	hash_for_each_rcu(cmdline_hashtab, proghash, chi, hlist) {
> +		if (buf)
> +			sprintf(buf + secrets_cmdtab_len, "[%04d]: %s", proghash, chi->progname);
> +		secrets_cmdtab_len += secrets_prefix_len + strlen(chi->progname);
> +		if (chi->secrets) {
> +			secret = chi->secrets;
> +			while (*secret) {
> +				if (buf)
> +					sprintf(buf + secrets_cmdtab_len, ":%s", secret);
> +				secret_len = strlen(secret);
> +				secret += secret_len + 1;
> +				secrets_cmdtab_len += secret_len + 1;
> +			}
> +		}
> +		if (buf)
> +			buf[secrets_cmdtab_len++] = '\n';
> +	}
> +	rcu_read_unlock();
> +
> +	return secrets_cmdtab_len;
> +}
> +
> +static ssize_t read_mask_secrets_cmdtab(struct file *file, char __user *buf,
> +		size_t len, loff_t *offset)
> +{
> +	char *secrets_cmdtab = 0;
> +	size_t secrets_cmdtab_len = 0;
> +	ssize_t ret = 0;
> +
> +	secrets_cmdtab_len = serialize_cmdtab(0);
> +	secrets_cmdtab = kzalloc(secrets_cmdtab_len, GFP_KERNEL);
> +	if (!secrets_cmdtab)
> +		return 0;
> +	secrets_cmdtab_len = serialize_cmdtab(secrets_cmdtab);
> +
> +	ret = simple_read_from_buffer(buf, len, offset,
> +			secrets_cmdtab, secrets_cmdtab_len);
> +
> +	kfree(secrets_cmdtab);
> +
> +	return ret;
> +}
> +
> +static int cmdline_hashtab_add(char *cmdline)
> +{
> +	struct cmdline_hashtab_item *chi = 0;
> +	char *progname = 0, *progname_start = cmdline + 1;
> +	char *secrets_start = 0;
> +	char *secret = 0;
> +	int secret_len = 0;
> +	int proghash = -1;
> +	struct file *file;
> +	struct inode *inode;
> +	int err = 0;
> +
> +	progname = strsep(&progname_start, SECRET_SEPARATOR);
> +	if (progname == NULL) {
> +		err = -EINVAL;
> +		goto exit_err;
> +	}
> +	if (progname[0] != '/') {
> +		err = -EINVAL;
> +		goto exit_err;
> +	}
> +	secrets_start = progname_start;
> +	if (secrets_start) {
> +		secret = secrets_start + strlen(secrets_start) - 1;
> +		while ((!isspace(*secret)) && (secret >= secrets_start))
> +			secret--;
> +		if (isspace(*secret) && (secret >= secrets_start)) {
> +			err = -EINVAL;
> +			goto exit_err;
> +		}
> +
> +		while ((secret = strsep(&secrets_start, SECRET_SEPARATOR)) != NULL) {
> +			secret_len = strlen(secret);
> +			if (secret_len < 2) {
> +				err = -EINVAL;
> +				goto exit_err;
> +			}
> +			if (secret[0] != '-') {
> +				err = -EINVAL;
> +				goto exit_err;
> +			}
> +		}
> +		secrets_start = progname_start;
> +	}
> +
> +	file = filp_open(progname, O_PATH, 0);
> +	if (IS_ERR(file)) {
> +		err = -ENOENT;
> +		goto exit_err;
> +	}
> +	inode = file_inode(file);
> +	if (!inode) {
> +		filp_close(file, 0);
> +		err = -ENOENT;
> +		goto exit_err;
> +	}
> +	proghash = cmdline_hash(inode->i_ino);
> +	filp_close(file, 0);
> +
> +	rcu_read_lock();
> +	hash_for_each_possible_rcu(cmdline_hashtab, chi, hlist, proghash)
> +		if (strcmp(chi->progname, progname) == 0) {
> +			rcu_read_unlock();
> +			err = -EEXIST;
> +			goto exit_err;
> +		}
> +	rcu_read_unlock();
> +
> +	chi = kmem_cache_zalloc(cmdline_hashtab_item_cachep, GFP_KERNEL);
> +	if (!chi) {
> +		err = -ENOMEM;
> +		goto exit_err;
> +	}
> +	INIT_HLIST_NODE(&chi->hlist);
> +	chi->cmdline = cmdline;
> +	chi->progname = progname;
> +	chi->secrets = secrets_start;
> +
> +	spin_lock(&cmdline_hashtab_spinlock);
> +	hash_add_rcu(cmdline_hashtab, &chi->hlist, proghash);
> +	spin_unlock(&cmdline_hashtab_spinlock);
> +	synchronize_rcu();
> +
> +exit_err:
> +	return err;
> +}
> +
> +
> +static int cmdline_hashtab_remove(char *cmdline)
> +{
> +	char *progname = cmdline + 1;
> +	struct file *file = 0;
> +	struct inode *inode = 0;
> +	int proghash = 0;
> +	struct cmdline_hashtab_item *chi = 0;
> +	int err = 0;
> +
> +	if (progname[0] != '/')
> +		goto exit_noent;
> +
> +	file = filp_open(progname, O_PATH, 0);
> +	if (IS_ERR(file))
> +		goto exit_noent;
> +	inode = file_inode(file);
> +	if (!inode) {
> +		filp_close(file, 0);
> +		goto exit_noent;
> +	}
> +	proghash = cmdline_hash(inode->i_ino);
> +	filp_close(file, 0);
> +
> +	rcu_read_lock();
> +	hash_for_each_possible_rcu(cmdline_hashtab, chi, hlist, proghash)
> +		if (strcmp(chi->progname, progname) == 0) {
> +			rcu_read_unlock();
> +			goto prog_found;
> +		}
> +	rcu_read_unlock();
> +
> +exit_noent:
> +	return (err = -ENOENT);
> +
> +prog_found:
> +	spin_lock(&cmdline_hashtab_spinlock);
> +	hash_del_rcu(&chi->hlist);
> +	spin_unlock(&cmdline_hashtab_spinlock);
> +	synchronize_rcu();
> +	kfree(chi->cmdline);
> +	kmem_cache_free(cmdline_hashtab_item_cachep, chi);
> +	kfree(cmdline);
> +	return err;
> +}
> +
> +static ssize_t write_mask_secrets_cmdtab(struct file *file, const char __user *buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	char *kbuf = 0;
> +	char *op = 0;
> +	int err = 0;
> +
> +	if (count < 3) {
> +		err = -EINVAL;
> +		goto exit_err;
> +	}
> +
> +	if (!is_mask_secrets_enabled()) {
> +		err = -EPERM;
> +		goto exit_err;
> +	}
> +
> +	kbuf = kzalloc(count + 1, GFP_KERNEL);
> +	if (!kbuf) {
> +		err = -ENOMEM;
> +		goto exit_err;
> +	}
> +
> +	if (copy_from_user(kbuf, buf, count)) {
> +		err = -EFAULT;
> +		goto cleanup_kbuf;
> +	}
> +	kbuf[count - 1] = '\0';
> +	kbuf[count] = '\0';
> +
> +	op = kbuf;
> +	if ((*op != '+') && (*op != '-')) {
> +		err = -EINVAL;
> +		goto cleanup_kbuf;
> +	}
> +
> +	if (op[0] == '+')
> +		err = cmdline_hashtab_add(kbuf);
> +	else
> +		err = cmdline_hashtab_remove(kbuf);
> +
> +	if (err)
> +		goto cleanup_kbuf;
> +
> +	return count;
> +
> +cleanup_kbuf:
> +	kfree(kbuf);
> +
> +exit_err:
> +	return err;
> +}
> +
> +static const struct proc_ops mask_secrets_cmdtab_proc_ops = {
> +	.proc_open	= open_mask_secrets_cmdtab,
> +	.proc_lseek	= seq_lseek,
> +	.proc_read	= read_mask_secrets_cmdtab,
> +	.proc_write	= write_mask_secrets_cmdtab,
> +	.proc_release	= single_release,
> +};
> +
> +static int __init proc_mask_secrets_init(void)
> +{
> +	struct proc_dir_entry *pde_mask_secrets = NULL;
> +	struct proc_dir_entry *pde_mask_secrets_enabled = NULL;
> +	struct proc_dir_entry *pde_mask_secrets_cmdtab = NULL;
> +
> +	pde_mask_secrets = proc_mkdir("mask_secrets", NULL);
> +	if (!pde_mask_secrets)
> +		goto exit_nomem;
> +
> +	pde_mask_secrets_enabled = proc_create("enabled", 0644,
> +			pde_mask_secrets, &mask_secrets_enabled_proc_ops);
> +	if (!pde_mask_secrets_enabled)
> +		goto cleanup_pde_mask_secrets;
> +
> +	pde_mask_secrets_cmdtab = proc_create("cmdtab", 0644,
> +			pde_mask_secrets, &mask_secrets_cmdtab_proc_ops);
> +	if (!pde_mask_secrets_cmdtab)
> +		goto cleanup_pde_mask_secrets_enabled;
> +
> +	cmdline_hashtab_item_cachep = kmem_cache_create("cmdline_hashtab_item_cachep",
> +		       sizeof(struct cmdline_hashtab_item), 0, 0, NULL);
> +	if (!cmdline_hashtab_item_cachep)
> +		goto cleanup_pde_mask_secrets_cmdtab;
> +
> +	*((int *)&MASK_SECRETS_ENABLED) = 1;
> +	*((int *)&MASK_SECRETS_DISABLED) = 0;
> +
> +	return 0;
> +
> +cleanup_pde_mask_secrets_cmdtab:
> +	proc_remove(pde_mask_secrets_cmdtab);
> +
> +cleanup_pde_mask_secrets_enabled:
> +	proc_remove(pde_mask_secrets_enabled);
> +
> +cleanup_pde_mask_secrets:
> +	proc_remove(pde_mask_secrets);
> +
> +exit_nomem:
> +	return -ENOMEM;
> +}
> +fs_initcall(proc_mask_secrets_init);
> -- 
> 2.17.1
