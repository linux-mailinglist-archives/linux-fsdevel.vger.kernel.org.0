Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81AC2243ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 21:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgGQTLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 15:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgGQTLe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:11:34 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A73C0619D4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 12:11:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so16479727wme.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ANR3bM9WoDNZme2eXqbjD+VVwWr+Pg7y8IOcp52zafo=;
        b=Dxz/h+2QtpKfi2V2MIRiLWspHxKnBOb+LTZCJQJcXrLXbCTI/zzk8g0vMz6lbwpirD
         RJgzZIfyprhgCbX7khnO37bOshkA0CO+OVqolpIod43sL+Y/1xK7beL9EgNaXDtd+1JG
         dVPoXc1C6hxeY1Z/gFQco1LhxYZxHIFaqOKNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ANR3bM9WoDNZme2eXqbjD+VVwWr+Pg7y8IOcp52zafo=;
        b=Zz7er29+VNPml6g4bnxP5l16jJlhJbZZvGmX91INYTJsziwAMlNCVHYWU18jnA+jp1
         LMMmQosvQq0p5+hYDPASXEiP+CazIXvy7+KvhTpjqDu9Yhz7ZHikSoUVMaTplPfbT+8x
         dRzyCVOqny08v8KEzw6Ad0yqG+GD6uaxLJ8wrD+KEC+vxxFXJeLFqBbknw9gd/hEU3Gs
         Jbh7GmEDnsgMo7UJyKbFM53C8QZMUo9s6aa9OpZMcLRaMXsDlDYm1UnrLjYYZjx+qdo5
         787NOW7BPkDnQCdWy86TnmHzkSD85wI5JILuzP/yThfE7/hd47fiwnHdnV57lQHHhd8t
         0Yzw==
X-Gm-Message-State: AOAM530URXSEfZKTa1wUygVha720dXWB8nwR5kyO9w8cn/9ejuoaMdCo
        B48Kdnik2SWWUHiY9DqMDoXDHA==
X-Google-Smtp-Source: ABdhPJxlrNLen9A3t/vx46qqIt/YgXG8pswjfadJMYTKEoR7BaUCnM8+uSX2YSwpVqtlfY0BhaM18A==
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr9985824wmh.96.1595013092984;
        Fri, 17 Jul 2020 12:11:32 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d132sm15249820wmd.35.2020.07.17.12.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 12:11:32 -0700 (PDT)
Subject: Re: [PATCH 05/13] fs/kernel_read_file: Split into separate source
 file
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-6-keescook@chromium.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <b574b926-58f3-0f4c-0bbc-1ca978836917@broadcom.com>
Date:   Fri, 17 Jul 2020 12:11:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717174309.1164575-6-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-07-17 10:43 a.m., Kees Cook wrote:
> These routines are used in places outside of exec(2), so in preparation
> for refactoring them, move them into a separate source file,
> fs/kernel_read_file.c.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   fs/Makefile           |   3 +-
>   fs/exec.c             | 132 ----------------------------------------
>   fs/kernel_read_file.c | 138 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 140 insertions(+), 133 deletions(-)
>   create mode 100644 fs/kernel_read_file.c
>
> diff --git a/fs/Makefile b/fs/Makefile
> index 2ce5112b02c8..a05fc247b2a7 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -13,7 +13,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
>   		seq_file.o xattr.o libfs.o fs-writeback.o \
>   		pnode.o splice.o sync.o utimes.o d_path.o \
>   		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
> -		fs_types.o fs_context.o fs_parser.o fsopen.o
> +		fs_types.o fs_context.o fs_parser.o fsopen.o \
> +		kernel_read_file.o
>   
>   ifeq ($(CONFIG_BLOCK),y)
>   obj-y +=	buffer.o block_dev.o direct-io.o mpage.o
> diff --git a/fs/exec.c b/fs/exec.c
> index 07a7fe9ac5be..d619b79aab30 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -923,138 +923,6 @@ struct file *open_exec(const char *name)
>   }
>   EXPORT_SYMBOL(open_exec);
>   
> -int kernel_read_file(struct file *file, void **buf, loff_t *size,
> -		     loff_t max_size, enum kernel_read_file_id id)
> -{
> -	loff_t i_size, pos;
> -	ssize_t bytes = 0;
> -	void *allocated = NULL;
> -	int ret;
> -
> -	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
> -		return -EINVAL;
> -
> -	ret = deny_write_access(file);
> -	if (ret)
> -		return ret;
> -
> -	ret = security_kernel_read_file(file, id);
> -	if (ret)
> -		goto out;
> -
> -	i_size = i_size_read(file_inode(file));
> -	if (i_size <= 0) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> -		ret = -EFBIG;
> -		goto out;
> -	}
> -
> -	if (!*buf)
> -		*buf = allocated = vmalloc(i_size);
> -	if (!*buf) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
> -	pos = 0;
> -	while (pos < i_size) {
> -		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
> -		if (bytes < 0) {
> -			ret = bytes;
> -			goto out_free;
> -		}
> -
> -		if (bytes == 0)
> -			break;
> -	}
> -
> -	if (pos != i_size) {
> -		ret = -EIO;
> -		goto out_free;
> -	}
> -
> -	ret = security_kernel_post_read_file(file, *buf, i_size, id);
> -	if (!ret)
> -		*size = pos;
> -
> -out_free:
> -	if (ret < 0) {
> -		if (allocated) {
> -			vfree(*buf);
> -			*buf = NULL;
> -		}
> -	}
> -
> -out:
> -	allow_write_access(file);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(kernel_read_file);
> -
> -int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
> -			       loff_t max_size, enum kernel_read_file_id id)
> -{
> -	struct file *file;
> -	int ret;
> -
> -	if (!path || !*path)
> -		return -EINVAL;
> -
> -	file = filp_open(path, O_RDONLY, 0);
> -	if (IS_ERR(file))
> -		return PTR_ERR(file);
> -
> -	ret = kernel_read_file(file, buf, size, max_size, id);
> -	fput(file);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
> -
> -int kernel_read_file_from_path_initns(const char *path, void **buf,
> -				      loff_t *size, loff_t max_size,
> -				      enum kernel_read_file_id id)
> -{
> -	struct file *file;
> -	struct path root;
> -	int ret;
> -
> -	if (!path || !*path)
> -		return -EINVAL;
> -
> -	task_lock(&init_task);
> -	get_fs_root(init_task.fs, &root);
> -	task_unlock(&init_task);
> -
> -	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
> -	path_put(&root);
> -	if (IS_ERR(file))
> -		return PTR_ERR(file);
> -
> -	ret = kernel_read_file(file, buf, size, max_size, id);
> -	fput(file);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
> -
> -int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> -			     enum kernel_read_file_id id)
> -{
> -	struct fd f = fdget(fd);
> -	int ret = -EBADF;
> -
> -	if (!f.file)
> -		goto out;
> -
> -	ret = kernel_read_file(f.file, buf, size, max_size, id);
> -out:
> -	fdput(f);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);
> -
>   #if defined(CONFIG_HAVE_AOUT) || defined(CONFIG_BINFMT_FLAT) || \
>       defined(CONFIG_BINFMT_ELF_FDPIC)
>   ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> new file mode 100644
> index 000000000000..54d972d4befc
> --- /dev/null
> +++ b/fs/kernel_read_file.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/fs.h>
> +#include <linux/fs_struct.h>
> +#include <linux/kernel_read_file.h>
> +#include <linux/security.h>
> +#include <linux/vmalloc.h>
> +
> +int kernel_read_file(struct file *file, void **buf, loff_t *size,
> +		     loff_t max_size, enum kernel_read_file_id id)
> +{
> +	loff_t i_size, pos;
> +	ssize_t bytes = 0;
> +	void *allocated = NULL;
> +	int ret;
> +
> +	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
> +		return -EINVAL;
> +
> +	ret = deny_write_access(file);
> +	if (ret)
> +		return ret;
> +
> +	ret = security_kernel_read_file(file, id);
> +	if (ret)
> +		goto out;
> +
> +	i_size = i_size_read(file_inode(file));
> +	if (i_size <= 0) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	if (i_size > SIZE_MAX || (max_size > 0 && i_size > max_size)) {
> +		ret = -EFBIG;
> +		goto out;
> +	}
> +
> +	if (!*buf)
> +		*buf = allocated = vmalloc(i_size);
> +	if (!*buf) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	pos = 0;
> +	while (pos < i_size) {
> +		bytes = kernel_read(file, *buf + pos, i_size - pos, &pos);
> +		if (bytes < 0) {
> +			ret = bytes;
> +			goto out_free;
> +		}
> +
> +		if (bytes == 0)
> +			break;
> +	}
> +
> +	if (pos != i_size) {
> +		ret = -EIO;
> +		goto out_free;
> +	}
> +
> +	ret = security_kernel_post_read_file(file, *buf, i_size, id);
> +	if (!ret)
> +		*size = pos;
> +
> +out_free:
> +	if (ret < 0) {
> +		if (allocated) {
> +			vfree(*buf);
> +			*buf = NULL;
> +		}
> +	}
> +
> +out:
> +	allow_write_access(file);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kernel_read_file);
> +
> +int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
> +			       loff_t max_size, enum kernel_read_file_id id)
> +{
> +	struct file *file;
> +	int ret;
> +
> +	if (!path || !*path)
> +		return -EINVAL;
> +
> +	file = filp_open(path, O_RDONLY, 0);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	ret = kernel_read_file(file, buf, size, max_size, id);
> +	fput(file);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
> +
> +int kernel_read_file_from_path_initns(const char *path, void **buf,
> +				      loff_t *size, loff_t max_size,
> +				      enum kernel_read_file_id id)
> +{
> +	struct file *file;
> +	struct path root;
> +	int ret;
> +
> +	if (!path || !*path)
> +		return -EINVAL;
> +
> +	task_lock(&init_task);
> +	get_fs_root(init_task.fs, &root);
> +	task_unlock(&init_task);
> +
> +	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
> +	path_put(&root);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	ret = kernel_read_file(file, buf, size, max_size, id);
> +	fput(file);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
> +
> +int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
> +			     enum kernel_read_file_id id)
> +{
> +	struct fd f = fdget(fd);
> +	int ret = -EBADF;
> +
> +	if (!f.file)
> +		goto out;
> +
> +	ret = kernel_read_file(f.file, buf, size, max_size, id);
> +out:
> +	fdput(f);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kernel_read_file_from_fd);

