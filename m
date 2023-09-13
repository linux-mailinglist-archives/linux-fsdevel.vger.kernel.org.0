Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A117179F3F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 23:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjIMVqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 17:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjIMVqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:46:32 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C376B1996
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 14:46:27 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-64a5bc53646so1888896d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 14:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694641587; x=1695246387; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nda2q6wYjkVchJzeBWpwmDb8+Qe5kJW9ubrvPXdmKHY=;
        b=eYo/ESjDGlK0HS+nZEYY9IDycDxIFNawvRxRqNXXbKNMW2KfNmDJ5dMk2cAb5TPv1j
         VMqPLu5e9yEDeipEIT2nXltrOe8vFPIEjOVbDpRWj0/z6liyDkTvBTGC1wvHIJhNqbxL
         uaPwf296VOqlMnCwWxU+6dcaUCe0vosQK3VlmMGImMsTnxphTrGT+pAhNZqHO260sU8P
         H1OFOBNvnE0vWnDnmq9Ys2zgf3jFMOaWm2aylIxawIEBk6kkeg4sb9nvMUF+EQgX/vTY
         yGykRkctsO+0IX9m6cKQaVOZsvfhiUL6h0odir4OECIba8Vnu1mk14BEzw5u/2oCydL1
         Q1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694641587; x=1695246387;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nda2q6wYjkVchJzeBWpwmDb8+Qe5kJW9ubrvPXdmKHY=;
        b=CKA6YW1zdweb89m2esRo5UwsOgG5SI2FJrX2yl21Z/W5N4FCIm+B7AsDfaXIZd0zBu
         wjC/HQbo/mD7XSkh2m5XtdAQDjeFuiQmUu3ItLDkfgPrOuQCR72IyucnGs3zGK/8w3QS
         FlscX45N+isMgzLQerPSxyXqmVtEzoPtctnJd32fb44TWyQbx0x4+n2WvxShs7vsYxl0
         l+gIC313gD9c90sTZIRbFqZKuuzTlZeKzQdoiqze+feclKjZJb2j1+oNJH4z5Lg0QyOh
         OjRbo+4HX2BXnMJhSb5/Ya+z83pwM3mUGSSOVhb0wLBaZ/AXoW3L8EYnSzfjARZtaxwd
         1b9g==
X-Gm-Message-State: AOJu0YzYgNSSH9FqHLfW952tSK1QO+1TM9hGpMcpD9c5Q5AXwv5HdWKI
        AH8bwsZ0eBVxeSTgOn0YZB0f0fKEeDsY3/55Qg==
X-Google-Smtp-Source: AGHT+IHHBcytPmYCTrbqFNPFGvQsnG7Gn+Pv+t+VJ99WvAYAOs6YAnq8k+smf0Fsj+j1rLCWjvOUSQ==
X-Received: by 2002:a05:6214:28b:b0:63c:f856:8aa7 with SMTP id l11-20020a056214028b00b0063cf8568aa7mr4016854qvv.59.1694641586748;
        Wed, 13 Sep 2023 14:46:26 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id q6-20020a0cf5c6000000b00655cfda65d7sm51158qvm.34.2023.09.13.14.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:46:26 -0700 (PDT)
Date:   Wed, 13 Sep 2023 17:46:25 -0400
Message-ID: <3808036a0b32a17a7fd9e7d671b5458d.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Subject: Re: [PATCH v4 2/12] bpf: introduce BPF token object
References: <20230912212906.3975866-3-andrii@kernel.org>
In-Reply-To: <20230912212906.3975866-3-andrii@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sep 12, 2023 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> Add new kind of BPF kernel object, BPF token. BPF token is meant to
> allow delegating privileged BPF functionality, like loading a BPF
> program or creating a BPF map, from privileged process to a *trusted*
> unprivileged process, all while have a good amount of control over which
> privileged operations could be performed using provided BPF token.
> 
> This is achieved through mounting BPF FS instance with extra delegation
> mount options, which determine what operations are delegatable, and also
> constraining it to the owning user namespace (as mentioned in the
> previous patch).
> 
> BPF token itself is just a derivative from BPF FS and can be created
> through a new bpf() syscall command, BPF_TOKEN_CREAT, which accepts
> a path specification (using the usual fd + string path combo) to a BPF
> FS mount. Currently, BPF token "inherits" delegated command, map types,
> prog type, and attach type bit sets from BPF FS as is. In the future,
> having an BPF token as a separate object with its own FD, we can allow
> to further restrict BPF token's allowable set of things either at the creation
> time or after the fact, allowing the process to guard itself further
> from, e.g., unintentionally trying to load undesired kind of BPF
> programs. But for now we keep things simple and just copy bit sets as is.
> 
> When BPF token is created from BPF FS mount, we take reference to the
> BPF super block's owning user namespace, and then use that namespace for
> checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> capabilities that are normally only checked against init userns (using
> capable()), but now we check them using ns_capable() instead (if BPF
> token is provided). See bpf_token_capable() for details.
> 
> Such setup means that BPF token in itself is not sufficient to grant BPF
> functionality. User namespaced process has to *also* have necessary
> combination of capabilities inside that user namespace. So while
> previously CAP_BPF was useless when granted within user namespace, now
> it gains a meaning and allows container managers and sys admins to have
> a flexible control over which processes can and need to use BPF
> functionality within the user namespace (i.e., container in practice).
> And BPF FS delegation mount options and derived BPF tokens serve as
> a per-container "flag" to grant overall ability to use bpf() (plus further
> restrict on which parts of bpf() syscalls are treated as namespaced).
> 
> The alternative to creating BPF token object was:
>   a) not having any extra object and just pasing BPF FS path to each
>      relevant bpf() command. This seems suboptimal as it's racy (mount
>      under the same path might change in between checking it and using it
>      for bpf() command). And also less flexible if we'd like to further
>      restrict ourselves compared to all the delegated functionality
>      allowed on BPF FS.
>   b) use non-bpf() interface, e.g., ioctl(), but otherwise also create
>      a dedicated FD that would represent a token-like functionality. This
>      doesn't seem superior to having a proper bpf() command, so
>      BPF_TOKEN_CREATE was chosen.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h            |  36 +++++++
>  include/uapi/linux/bpf.h       |  39 +++++++
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/inode.c             |   4 +-
>  kernel/bpf/syscall.c           |  17 +++
>  kernel/bpf/token.c             | 189 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  39 +++++++
>  7 files changed, 324 insertions(+), 2 deletions(-)
>  create mode 100644 kernel/bpf/token.c

...

> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> new file mode 100644
> index 000000000000..f6ea3eddbee6
> --- /dev/null
> +++ b/kernel/bpf/token.c
> @@ -0,0 +1,189 @@
> +#include <linux/bpf.h>
> +#include <linux/vmalloc.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/fdtable.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/idr.h>
> +#include <linux/namei.h>
> +#include <linux/user_namespace.h>
> +
> +bool bpf_token_capable(const struct bpf_token *token, int cap)
> +{
> +	/* BPF token allows ns_capable() level of capabilities */
> +	if (token) {
> +		if (ns_capable(token->userns, cap))
> +			return true;
> +		if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))
> +			return true;
> +	}
> +	/* otherwise fallback to capable() checks */
> +	return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> +}

While the above looks to be equivalent to the bpf_capable() function it
replaces, for callers checking CAP_BPF and CAP_SYS_ADMIN, I'm looking
quickly at patch 3/12 and this is also being used to replace a
capable(CAP_NET_ADMIN) call which results in a change in behavior.
The current code which performs a capable(CAP_NET_ADMIN) check cannot
be satisfied by CAP_SYS_ADMIN, but this patchset using
bpf_token_capable(token, CAP_NET_ADMIN) can be satisfied by either
CAP_NET_ADMIN or CAP_SYS_ADMIN.

It seems that while bpf_token_capable() can be used as a replacement
for bpf_capable(), it is not currently a suitable replacement for a
generic capable() call.  Perhaps this is intentional, but I didn't see
it mentioned in the commit description, or in the comments, and I
wanted to make sure it wasn't an oversight.

> +void bpf_token_inc(struct bpf_token *token)
> +{
> +	atomic64_inc(&token->refcnt);
> +}
> +
> +static void bpf_token_free(struct bpf_token *token)
> +{
> +	put_user_ns(token->userns);
> +	kvfree(token);
> +}
> +
> +static void bpf_token_put_deferred(struct work_struct *work)
> +{
> +	struct bpf_token *token = container_of(work, struct bpf_token, work);
> +
> +	bpf_token_free(token);
> +}
> +
> +void bpf_token_put(struct bpf_token *token)
> +{
> +	if (!token)
> +		return;
> +
> +	if (!atomic64_dec_and_test(&token->refcnt))
> +		return;
> +
> +	INIT_WORK(&token->work, bpf_token_put_deferred);
> +	schedule_work(&token->work);
> +}
> +
> +static int bpf_token_release(struct inode *inode, struct file *filp)
> +{
> +	struct bpf_token *token = filp->private_data;
> +
> +	bpf_token_put(token);
> +	return 0;
> +}
> +
> +static ssize_t bpf_dummy_read(struct file *filp, char __user *buf, size_t siz,
> +			      loff_t *ppos)
> +{
> +	/* We need this handler such that alloc_file() enables
> +	 * f_mode with FMODE_CAN_READ.
> +	 */
> +	return -EINVAL;
> +}
> +
> +static ssize_t bpf_dummy_write(struct file *filp, const char __user *buf,
> +			       size_t siz, loff_t *ppos)
> +{
> +	/* We need this handler such that alloc_file() enables
> +	 * f_mode with FMODE_CAN_WRITE.
> +	 */
> +	return -EINVAL;
> +}
> +
> +static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
> +{
> +	struct bpf_token *token = filp->private_data;
> +	u64 mask;
> +
> +	mask = (1ULL << __MAX_BPF_CMD) - 1;
> +	if ((token->allowed_cmds & mask) == mask)
> +		seq_printf(m, "allowed_cmds:\tany\n");
> +	else
> +		seq_printf(m, "allowed_cmds:\t0x%llx\n", token->allowed_cmds);
> +}
> +
> +static const struct file_operations bpf_token_fops = {
> +	.release	= bpf_token_release,
> +	.read		= bpf_dummy_read,
> +	.write		= bpf_dummy_write,
> +	.show_fdinfo	= bpf_token_show_fdinfo,
> +};
> +
> +static struct bpf_token *bpf_token_alloc(void)
> +{
> +	struct bpf_token *token;
> +
> +	token = kvzalloc(sizeof(*token), GFP_USER);
> +	if (!token)
> +		return NULL;
> +
> +	atomic64_set(&token->refcnt, 1);
> +
> +	return token;
> +}
> +
> +int bpf_token_create(union bpf_attr *attr)
> +{
> +	struct path path;
> +	struct bpf_mount_opts *mnt_opts;
> +	struct bpf_token *token;
> +	int ret;
> +
> +	ret = user_path_at(attr->token_create.bpffs_path_fd,
> +			   u64_to_user_ptr(attr->token_create.bpffs_pathname),
> +			   LOOKUP_FOLLOW | LOOKUP_EMPTY, &path);
> +	if (ret)
> +		return ret;
> +
> +	if (path.mnt->mnt_root != path.dentry) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	ret = path_permission(&path, MAY_ACCESS);
> +	if (ret)
> +		goto out;
> +
> +	token = bpf_token_alloc();
> +	if (!token) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* remember bpffs owning userns for future ns_capable() checks */
> +	token->userns = get_user_ns(path.dentry->d_sb->s_user_ns);
> +
> +	mnt_opts = path.dentry->d_sb->s_fs_info;
> +	token->allowed_cmds = mnt_opts->delegate_cmds;
> +
> +	ret = bpf_token_new_fd(token);
> +	if (ret < 0)
> +		bpf_token_free(token);
> +out:
> +	path_put(&path);
> +	return ret;
> +}
> +
> +#define BPF_TOKEN_INODE_NAME "bpf-token"
> +
> +/* Alloc anon_inode and FD for prepared token.
> + * Returns fd >= 0 on success; negative error, otherwise.
> + */
> +int bpf_token_new_fd(struct bpf_token *token)
> +{
> +	return anon_inode_getfd(BPF_TOKEN_INODE_NAME, &bpf_token_fops, token, O_CLOEXEC);
> +}
> +
> +struct bpf_token *bpf_token_get_from_fd(u32 ufd)
> +{
> +	struct fd f = fdget(ufd);
> +	struct bpf_token *token;
> +
> +	if (!f.file)
> +		return ERR_PTR(-EBADF);
> +	if (f.file->f_op != &bpf_token_fops) {
> +		fdput(f);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	token = f.file->private_data;
> +	bpf_token_inc(token);
> +	fdput(f);
> +
> +	return token;
> +}
> +
> +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
> +{
> +	if (!token)
> +		return false;
> +
> +	return token->allowed_cmds & (1ULL << cmd);
> +}

I mentioned this a while back, likely in the other threads where this
token-based approach was only being discussed in general terms, but I
think we want to have a LSM hook at the point of initial token
delegation for this and a hook when the token is used.  My initial
thinking is that we should be able to address the former with a hook
in bpf_fill_super() and the latter either in bpf_token_get_from_fd()
or bpf_token_allow_XXX(); bpf_token_get_from_fd() would be simpler,
but it doesn't allow for much in the way of granularity.  Inserting the
LSM hooks in bpf_token_allow_XXX() would also allow the BPF code to fall
gracefully fallback to the system-wide checks if the LSM denied the
requested access whereas an access denial in bpf_token_get_from_fd()
denial would cause the operation to error out.

--
paul-moore.com
