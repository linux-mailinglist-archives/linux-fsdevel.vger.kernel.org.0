Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2E7AB182
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjIVL7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 07:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIVL7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:59:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E0FB;
        Fri, 22 Sep 2023 04:59:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733CFC433C7;
        Fri, 22 Sep 2023 11:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695383973;
        bh=ORzIDixyYNN/jJb/Sxa5K2h12YMiO0mDofirvWtUYDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fbA9AsP6p4xsjJaKQy9RAcs3SFDkJUxohUtLbQfIivmE20XLy+RMcYpcwNxR+Y33d
         mqGSO32J30z4pjw1IUvNWnfU27xq7uksjaYhXUpPOzTrlR8fj/8lcNE5GBZZHyX7FU
         IlNnm93Nhzzs2RpERpkh0yqFoR/fGKcvMtM1/0MRy3LDIvcf4ikJIq4xpiEiCKEzBE
         Rk9bUkaKnEhyaCzWgSKEEHX5OHCLPshTO8ueyaJAnF5VLtlDn0euzEvuOvhFaEEdJs
         9oGHb78rRcxDQa57tYaUDigbJtw8Dqg+8QptH5vNcKT+bSHL8RP+XPGV2McBFYXCDC
         KbjE0uN4eFWnA==
Date:   Fri, 22 Sep 2023 13:59:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 7/8] autofs: convert autofs to use the new mount api
Message-ID: <20230922-vorbringen-spaghetti-946729122076@brauner>
References: <20230922041215.13675-1-raven@themaw.net>
 <20230922041215.13675-8-raven@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230922041215.13675-8-raven@themaw.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	fsparam_fd	("fd",			Opt_fd),

> +/*
> + * Open the fd.  We do it here rather than in get_tree so that it's done in the
> + * context of the system call that passed the data and not the one that
> + * triggered the superblock creation, lest the fd gets reassigned.
> + */
> +static int autofs_parse_fd(struct fs_context *fc, int fd)
>  {
> +	struct autofs_sb_info *sbi = fc->s_fs_info;
>  	struct file *pipe;
>  	int ret;
>  
>  	pipe = fget(fd);
>  	if (!pipe) {
> -		pr_err("could not open pipe file descriptor\n");
> +		errorf(fc, "could not open pipe file descriptor");
>  		return -EBADF;
>  	}
>  
>  	ret = autofs_check_pipe(pipe);
>  	if (ret < 0) {
> -		pr_err("Invalid/unusable pipe\n");
> +		errorf(fc, "Invalid/unusable pipe");
>  		fput(pipe);
>  		return -EBADF;
>  	}

> +static int autofs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
> +		return autofs_parse_fd(fc, result.int_32);

Mah, so there's a difference between the new and the old mount api that we
should probably hide on the VFS level for fsparam_fd. Basically, if you're
coming through the new mount api via fsconfig(FSCONFIG_SET_FD, fd) then the vfs
will have done param->file = fget(fd) for you already so there's no need to
call fget() again. We can just take ownership of the reference that the vfs
took for us.

But if we're coming in through the old mount api then we need to call fget.
There's nothing wrong with your code but it doesn't take advantage of the new
mount api which would be unfortunate. So I folded a small extension into this
see [1].

There's an unrelated bug in fs_param_is_fd() that I'm also fixing see [2].

I've tested both changes with the old and new mount api.

[1]:
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 3f2dfed428f9..0477bce7d277 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -150,13 +150,20 @@ struct autofs_fs_context {
  * context of the system call that passed the data and not the one that
  * triggered the superblock creation, lest the fd gets reassigned.
  */
-static int autofs_parse_fd(struct fs_context *fc, int fd)
+static int autofs_parse_fd(struct fs_context *fc, struct autofs_sb_info *sbi,
+                          struct fs_parameter *param,
+                          struct fs_parse_result *result)
 {
-       struct autofs_sb_info *sbi = fc->s_fs_info;
        struct file *pipe;
        int ret;

-       pipe = fget(fd);
+       if (param->type == fs_value_is_file) {
+               /* came through the new api */
+               pipe = param->file;
+               param->file = NULL;
+       } else {
+               pipe = fget(result->uint_32);
+       }
        if (!pipe) {
                errorf(fc, "could not open pipe file descriptor");
                return -EBADF;
@@ -165,14 +172,15 @@ static int autofs_parse_fd(struct fs_context *fc, int fd)
        ret = autofs_check_pipe(pipe);
        if (ret < 0) {
                errorf(fc, "Invalid/unusable pipe");
-               fput(pipe);
+               if (param->type != fs_value_is_file)
+                       fput(pipe);
                return -EBADF;
        }

        if (sbi->pipe)
                fput(sbi->pipe);

-       sbi->pipefd = fd;
+       sbi->pipefd = result->uint_32;
        sbi->pipe = pipe;

        return 0;

[2]:
From 2f9171200505c82e744a235c85377e36ed190109 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 22 Sep 2023 13:49:05 +0200
Subject: [PATCH] fsconfig: ensure that dirfd is set to aux

The code in fs_param_is_fd() expects param->dirfd to be set to the fd
that was used to set param->file to initialize result->uint_32. So make
sure it's set so users like autofs using FSCONFIG_SET_FD with the new
mount api can rely on this to be set to the correct value.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fsopen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index ce03f6521c88..6593ae518115 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -465,6 +465,7 @@ SYSCALL_DEFINE5(fsconfig,
 		param.file = fget(aux);
 		if (!param.file)
 			goto out_key;
+		param.dirfd = aux;
 		break;
 	default:
 		break;
-- 
2.34.1

