Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90BC7AACB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 10:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjIVIb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 04:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjIVIb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:31:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E68C8F;
        Fri, 22 Sep 2023 01:31:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A71C433C7;
        Fri, 22 Sep 2023 08:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695371509;
        bh=Skwpb1KLcQdKy7MKh1L9QT77S3+jQE5C8QaP3kqYiBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQzComXhXZGvl7G5wtkxVHvHbwcf5+8KcdIeohPb6+hxGS85lPGoUkc89m62RIT40
         4pIOVmUcHuW/Cd1MYkikaqStRRPvOAPO/wWcyX7GNTqX6aXOJenPzP2XuT8dC8DYeP
         Puli961YyXoj7dB/ixbbdVU974cLFFruEIZG4OaUVWmaPoA3EOsPDGwC3pP4KJnTl6
         XKQ6aadnyhMwbaMuj5p/N4827wAn2nmaAn/XeszAWgFnaHeCPxKtE3rFjCkT8KaTWI
         rE61WEw4FJZQd9B2f3HUWQ5pWN4GJ1OlHJn9r05F6oexe4+KG5jbH+U70qiBKQ4628
         +uNx8VHFZ6GLw==
Date:   Fri, 22 Sep 2023 10:31:44 +0200
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
Message-ID: <20230922-appell-vordach-1608445c5251@brauner>
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

On Fri, Sep 22, 2023 at 12:12:14PM +0800, Ian Kent wrote:
> Convert the autofs filesystem to use the mount API.
> 
> The conversion patch was originally written by David Howells.
> I have taken that patch and broken it into several patches in an effort
> to make the change easier to review.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/autofs/autofs_i.h |   5 +-
>  fs/autofs/init.c     |   9 +-
>  fs/autofs/inode.c    | 247 ++++++++++++++++++++++++-------------------
>  3 files changed, 142 insertions(+), 119 deletions(-)
> 
> diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
> index c24d32be7937..244f18cdf23c 100644
> --- a/fs/autofs/autofs_i.h
> +++ b/fs/autofs/autofs_i.h
> @@ -25,6 +25,8 @@
>  #include <linux/completion.h>
>  #include <linux/file.h>
>  #include <linux/magic.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  
>  /* This is the range of ioctl() numbers we claim as ours */
>  #define AUTOFS_IOC_FIRST     AUTOFS_IOC_READY
> @@ -205,7 +207,8 @@ static inline void managed_dentry_clear_managed(struct dentry *dentry)
>  
>  /* Initializing function */
>  
> -int autofs_fill_super(struct super_block *, void *, int);
> +extern const struct fs_parameter_spec autofs_param_specs[];
> +int autofs_init_fs_context(struct fs_context *fc);
>  struct autofs_info *autofs_new_ino(struct autofs_sb_info *);
>  void autofs_clean_ino(struct autofs_info *);
>  
> diff --git a/fs/autofs/init.c b/fs/autofs/init.c
> index d3f55e874338..b5e4dfa04ed0 100644
> --- a/fs/autofs/init.c
> +++ b/fs/autofs/init.c
> @@ -7,16 +7,11 @@
>  #include <linux/init.h>
>  #include "autofs_i.h"
>  
> -static struct dentry *autofs_mount(struct file_system_type *fs_type,
> -	int flags, const char *dev_name, void *data)
> -{
> -	return mount_nodev(fs_type, flags, data, autofs_fill_super);
> -}
> -
>  struct file_system_type autofs_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "autofs",
> -	.mount		= autofs_mount,
> +	.init_fs_context = autofs_init_fs_context,
> +	.parameters	= autofs_param_specs,
>  	.kill_sb	= autofs_kill_sb,
>  };
>  MODULE_ALIAS_FS("autofs");
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index e2026e063d8c..3f2dfed428f9 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -6,7 +6,6 @@
>  
>  #include <linux/seq_file.h>
>  #include <linux/pagemap.h>
> -#include <linux/parser.h>
>  
>  #include "autofs_i.h"
>  
> @@ -111,7 +110,6 @@ static const struct super_operations autofs_sops = {
>  };
>  
>  enum {
> -	Opt_err,
>  	Opt_direct,
>  	Opt_fd,
>  	Opt_gid,
> @@ -125,35 +123,48 @@ enum {
>  	Opt_uid,
>  };
>  
> -static const match_table_t tokens = {
> -	{Opt_fd, "fd=%u"},
> -	{Opt_uid, "uid=%u"},
> -	{Opt_gid, "gid=%u"},
> -	{Opt_pgrp, "pgrp=%u"},
> -	{Opt_minproto, "minproto=%u"},
> -	{Opt_maxproto, "maxproto=%u"},
> -	{Opt_indirect, "indirect"},
> -	{Opt_direct, "direct"},
> -	{Opt_offset, "offset"},
> -	{Opt_strictexpire, "strictexpire"},
> -	{Opt_ignore, "ignore"},
> -	{Opt_err, NULL}
> +const struct fs_parameter_spec autofs_param_specs[] = {
> +	fsparam_flag	("direct",		Opt_direct),
> +	fsparam_fd	("fd",			Opt_fd),
> +	fsparam_u32	("gid",			Opt_gid),
> +	fsparam_flag	("ignore",		Opt_ignore),
> +	fsparam_flag	("indirect",		Opt_indirect),
> +	fsparam_u32	("maxproto",		Opt_maxproto),
> +	fsparam_u32	("minproto",		Opt_minproto),
> +	fsparam_flag	("offset",		Opt_offset),
> +	fsparam_u32	("pgrp",		Opt_pgrp),
> +	fsparam_flag	("strictexpire",	Opt_strictexpire),
> +	fsparam_u32	("uid",			Opt_uid),
> +	{}
>  };
>  
> -static int autofs_parse_fd(struct autofs_sb_info *sbi, int fd)
> +struct autofs_fs_context {
> +	kuid_t	uid;
> +	kgid_t	gid;
> +	int	pgrp;
> +	bool	pgrp_set;
> +};
> +
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
> @@ -167,58 +178,43 @@ static int autofs_parse_fd(struct autofs_sb_info *sbi, int fd)
>  	return 0;
>  }
>  
> -static int autofs_parse_param(char *optstr, struct inode *root,
> -			      int *pgrp, bool *pgrp_set,
> -			      struct autofs_sb_info *sbi)
> +static int autofs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
> -	substring_t args[MAX_OPT_ARGS];
> -	int option;
> -	int pipefd = -1;
> +	struct autofs_fs_context *ctx = fc->fs_private;
> +	struct autofs_sb_info *sbi = fc->s_fs_info;
> +	struct fs_parse_result result;
>  	kuid_t uid;
>  	kgid_t gid;
> -	int token;
> -	int ret;
> +	int opt;
>  
> -	token = match_token(optstr, tokens, args);
> -	switch (token) {
> +	opt = fs_parse(fc, autofs_param_specs, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
>  	case Opt_fd:
> -		if (match_int(args, &pipefd))
> -			return 1;
> -		ret = autofs_parse_fd(sbi, pipefd);
> -		if (ret)
> -			return 1;
> -		break;
> +		return autofs_parse_fd(fc, result.int_32);
>  	case Opt_uid:
> -		if (match_int(args, &option))
> -			return 1;
> -		uid = make_kuid(current_user_ns(), option);
> +		uid = make_kuid(current_user_ns(), result.uint_32);
>  		if (!uid_valid(uid))
>  			return 1;

This and the make_kgid() instance below need to return -EINVAL or use
invalfc() to return an error message. I can fix this up though so no
need to resend for this.
