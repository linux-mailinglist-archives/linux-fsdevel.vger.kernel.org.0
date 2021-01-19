Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20B22FC3C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 23:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbhASOe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 09:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbhASMG5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:06:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0472BC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 04:06:15 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y17so19482782wrr.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 04:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8e/D2faN6CtLGH+7k+u4qfYvc54TqKJTGm6NyieDxDg=;
        b=GjCDE34Gg9IhslKROIfwXQhzH0RvJZrHAEVbsMdEZJS9kFGMDDV+Pkc/FBC95cNJHu
         NXmeHeR7sKJ3/Vmkgv4RfRoZ/RjHlQD7p90FlDyEzRvFrCtQtKFN5JyvQ7N/d5XKaLch
         zbLoUOO5K77hY87xpm3ttxwil7Hx5GdInN6Op7xEo6JEUywCeYNqrv0j2t4H0CZwoLhw
         V0iyIDFPBCkoO+5UXjidEsLwP6vWd7XygXOQk5CLMwuaEe4BIGrRUaMYgbtczDQKpwsi
         IEsVWqlI2MoeTgbFH9/BuB5Mo7syqL7hVqAf90EHY+JgSR7G3806XW667BmxM8egpq6D
         BKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8e/D2faN6CtLGH+7k+u4qfYvc54TqKJTGm6NyieDxDg=;
        b=IGDLIiSDHqRil3ECC9Cb3FUXv5TJ/j+tditOcyvJh1NI5m9dclcMDH5gYFeT8cjZ51
         LnoZcXYR9EmKKdL1rzd37x3pmPuMRmRsVC23iT5e0CnqxbVhASk6EzFGRyTTvQAom2M3
         WO9NmWedgLOaWt/nFz6czaLXvRfkQYrkW12Iq/DCSBN+/syE2YBRuJO/z9ofY4flxYmE
         mDc6OalJBRMB8fzA8P9W6SMaMgVsrSTyNYbhrrAybRsuZOBFtPenWXY9ecHKvEG1obSd
         oeD207gHxkoILd0yEyGNHh5pllmS8bOEsUcX325zh4ieFv2vkU/hsjA/Dv56EJDEl0aJ
         9QoA==
X-Gm-Message-State: AOAM530I/jH7AaoBdGI0EWBRbOJTkA/CBQBmd3bEs5UB2CULAnfC03zv
        GG2itOnqwvMzxwgyieQ5RkVEOw==
X-Google-Smtp-Source: ABdhPJzqhQ7FAQvj0zxxjmN0Vv3vciyX8X7Lx4xNOPidRNEFxZK2jL+G3FI9AOxJKIn9j9yJfJVjlw==
X-Received: by 2002:a5d:4712:: with SMTP id y18mr4145624wrq.229.1611057974449;
        Tue, 19 Jan 2021 04:06:14 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:41d4:8c90:d38:455d])
        by smtp.gmail.com with ESMTPSA id k16sm4128570wmj.45.2021.01.19.04.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:06:13 -0800 (PST)
Date:   Tue, 19 Jan 2021 12:06:12 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND V11 4/7] fuse: Passthrough initialization and
 release
Message-ID: <YAbLNAaeOVAfArqD@google.com>
References: <20210118192748.584213-1-balsini@android.com>
 <20210118192748.584213-5-balsini@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118192748.584213-5-balsini@android.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 07:27:45PM +0000, Alessio Balsini wrote:
> Implement the FUSE passthrough ioctl() that associates the lower
> (passthrough) file system file with the fuse_file.
> 
> The file descriptor passed to the ioctl() by the FUSE daemon is used to
> access the relative file pointer, that will be copied to the fuse_file
> data structure to consolidate the link between the FUSE and lower file
> system.
> 
> To enable the passthrough mode, user space triggers the
> FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl() and, if the call succeeds,
> receives back an identifier that will be used at open/create response
> time in the fuse_open_out field to associate the FUSE file to the lower
> file system file.
> The value returned by the ioctl() to user space can be:
> - > 0: success, the identifier can be used as part of an open/create
>   reply.
> - < 0: an error occurred.
> The value 0 has been left unused for backward compatibility: the
> fuse_open_out field that is used to pass the passthrough_fh back to the
> kernel uses the same bits that were previously as struct padding,
> zero-initialized in the common libfuse implementation. Removing the 0
> value fixes the ambiguity between the case in which 0 corresponds to a
> real passthrough_fh or a missing implementation, simplifying the user
> space implementation.
> 
> For the passthrough mode to be successfully activated, the lower file
> system file must implement both read_iter and write_iter file
> operations. This extra check avoids special pseudo files to be targeted
> for this feature.
> Passthrough comes with another limitation: if a FUSE file systems
> enables passthrough, this feature is no more available to other FUSE
> file systems stacked on top of it. This check is only performed when
> FUSE passthrough is requested for a specific file and would simply
> prevent the use of FUSE passthrough for that file, not limiting other
> file operations.
> 
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  fs/fuse/inode.c       |  5 +++
>  fs/fuse/passthrough.c | 87 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index d5c46eafb419..bc327789f25d 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1133,6 +1133,11 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
>  
>  static int free_fuse_passthrough(int id, void *p, void *data)
>  {
> +	struct fuse_passthrough *passthrough = (struct fuse_passthrough *)p;
> +
> +	fuse_passthrough_release(passthrough);
> +	kfree(p);
> +
>  	return 0;
>  }
>  
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 594060c654f8..cf720ca14a45 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -3,19 +3,102 @@
>  #include "fuse_i.h"
>  
>  #include <linux/fuse.h>
> +#include <linux/idr.h>
>  
>  int fuse_passthrough_open(struct fuse_dev *fud,
>  			  struct fuse_passthrough_out *pto)
>  {
> -	return -EINVAL;
> +	int res;
> +	struct file *passthrough_filp;
> +	struct fuse_conn *fc = fud->fc;
> +	struct inode *passthrough_inode;
> +	struct super_block *passthrough_sb;
> +	struct fuse_passthrough *passthrough;
> +
> +	if (!fc->passthrough)
> +		return -EPERM;
> +
> +	/* This field is reserved for future implementation */
> +	if (pto->len != 0)
> +		return -EINVAL;
> +
> +	passthrough_filp = fget(pto->fd);
> +	if (!passthrough_filp) {
> +		pr_err("FUSE: invalid file descriptor for passthrough.\n");
> +		return -EBADF;
> +	}
> +
> +	if (!passthrough_filp->f_op->read_iter ||
> +	    !passthrough_filp->f_op->write_iter) {
> +		pr_err("FUSE: passthrough file misses file operations.\n");
> +		res = -EBADF;
> +		goto err_free_file;
> +	}
> +
> +	passthrough_inode = file_inode(passthrough_filp);
> +	passthrough_sb = passthrough_inode->i_sb;
> +	if (passthrough_sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> +		pr_err("FUSE: fs stacking depth exceeded for passthrough\n");
> +		res = -EINVAL;
> +		goto err_free_file;
> +	}
> +
> +	passthrough = kmalloc(sizeof(struct fuse_passthrough), GFP_KERNEL);
> +	if (!passthrough) {
> +		res = -ENOMEM;
> +		goto err_free_file;
> +	}
> +
> +	passthrough->filp = passthrough_filp;
> +
> +	idr_preload(GFP_KERNEL);
> +	spin_lock(&fc->passthrough_req_lock);
> +	res = idr_alloc(&fc->passthrough_req, passthrough, 1, 0, GFP_ATOMIC);
> +	spin_unlock(&fc->passthrough_req_lock);
> +	idr_preload_end();
> +
> +	if (res > 0)
> +		return res;
> +
> +	fuse_passthrough_release(passthrough);
> +	kfree(passthrough);
> +
> +err_free_file:
> +	fput(passthrough_filp);
> +
> +	return res;
>  }
>  
>  int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
>  			   struct fuse_open_out *openarg)
>  {
> -	return -EINVAL;
> +	struct fuse_passthrough *passthrough;
> +	int passthrough_fh = openarg->passthrough_fh;
> +
> +	if (!fc->passthrough)
> +		return -EPERM;
> +
> +	/* Default case, passthrough is not requested */
> +	if (passthrough_fh <= 0)
> +		return -EINVAL;
> +
> +	spin_lock(&fc->passthrough_req_lock);
> +	passthrough = idr_remove(&fc->passthrough_req, passthrough_fh);
> +	spin_unlock(&fc->passthrough_req_lock);
> +
> +	if (!passthrough)
> +		return -EINVAL;
> +
> +	ff->passthrough = *passthrough;
> +	kfree(passthrough);
> +
> +	return 0;
>  }
>  
>  void fuse_passthrough_release(struct fuse_passthrough *passthrough)
>  {
> +	if (passthrough->filp) {
> +		fput(passthrough->filp);
> +		passthrough->filp = NULL;
> +	}
>  }
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 

Hi,

As Amir was noticing, the stacking policy proposed in this series (as
opposed to V10) is not enough to ensure that the same file undergoes
multiple FUSE passthrough paths, moreover, checking for:

  passthrough_sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH

looks misleading and hacky.
The simplest solution at this point in time would be to just go back to
the policy introduced in V10 and, if for some use use cases FUSE
passthrough is desirable in systems where complex stackings are
involved, the stacking policy can be revisited.

Before sending out the V12 of this series, I would love to have the
consensus both from the community and from Miklos on what is the best
way to go.

Here follows a simple diff that restores the policy as in V10.

Thanks,
Alessio

---8<---

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bc327789f25d..7ebc398fbacb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1058,7 +1058,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
                                fc->passthrough = 1;
                                /* Prevent further stacking */
                                fm->sb->s_stack_depth =
-                                       FILESYSTEM_MAX_STACK_DEPTH + 1;
+                                       FILESYSTEM_MAX_STACK_DEPTH;
                        }
                } else {
                        ra_pages = fc->max_read / PAGE_SIZE;
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index cf720ca14a45..cf993e83803e 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -37,7 +37,7 @@ int fuse_passthrough_open(struct fuse_dev *fud,

        passthrough_inode = file_inode(passthrough_filp);
        passthrough_sb = passthrough_inode->i_sb;
-       if (passthrough_sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
+       if (passthrough_sb->s_stack_depth >= FILESYSTEM_MAX_STACK_DEPTH) {
                pr_err("FUSE: fs stacking depth exceeded for passthrough\n");
                res = -EINVAL;
                goto err_free_file;

--->8---
