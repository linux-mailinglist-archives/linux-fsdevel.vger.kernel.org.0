Return-Path: <linux-fsdevel+bounces-29604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7CA97B536
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 23:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0010A284306
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30611192D76;
	Tue, 17 Sep 2024 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hqAc3YQU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ilAUebLi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hqAc3YQU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ilAUebLi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C21925A4
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608575; cv=none; b=X6FHcNxj2iemVBHMTBUCrF5WN6oDDi3qADb5kwZmn1K9sJg505hEtthC9P9+/hmyFrLlpWQDCurT2hauHQxYu7dASX10I+O0OC/UyH69POpbOt40rGEsf8oyKAj0BCxL0C+soW3Qe3O+zL4pCg9oYv1HW8GcyA5kimzMMrpApKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608575; c=relaxed/simple;
	bh=WLmJoekLClcBArF0BzGGVpetgZXVEr/WaXWhyvj0Wfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsEwnaVbpX1Paib5nqdwz0o5jwSciXlhtXWW+9SXprS2Yx5JM2n2AWgOc8DEdXMXmpKz6f9a6AJSgrQRnbbsl8ccg/zSlMqd8h+rcWfJh5Tox9MlG1I3oiu1SfcFzsujXLnRPfRX8tJZQXYhDXfsPUKNRLqX4OteOXfdvFCSnNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hqAc3YQU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ilAUebLi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hqAc3YQU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ilAUebLi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 369702250C;
	Tue, 17 Sep 2024 21:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726608571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kMGUk0VoH6sbRT585DG1xyLsQxgpgA8+fowuiKKa2aw=;
	b=hqAc3YQU6wIhHmVmoUo99/9jlA4ELJI7wjsu2h3+n/R0J8zMsq2LfD9NTlNXiqIkeesnmL
	IYYXghx3MnH5eBN8DKIIo1lWgx6fKc8zSGHEKgf0YE8I+U5YLhE/F9XjhMl4MgktNTAnvK
	X/ssfXcG9XaxRlQDua88xy+wQSdG6mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726608571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kMGUk0VoH6sbRT585DG1xyLsQxgpgA8+fowuiKKa2aw=;
	b=ilAUebLiW8bEClDBe9eFUMKKPZmaAMYKDB+I41h4ocONxykzm4jaU00D1UZL3zUiq0EVUj
	tJcShhJ2OBpf8oDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hqAc3YQU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ilAUebLi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726608571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kMGUk0VoH6sbRT585DG1xyLsQxgpgA8+fowuiKKa2aw=;
	b=hqAc3YQU6wIhHmVmoUo99/9jlA4ELJI7wjsu2h3+n/R0J8zMsq2LfD9NTlNXiqIkeesnmL
	IYYXghx3MnH5eBN8DKIIo1lWgx6fKc8zSGHEKgf0YE8I+U5YLhE/F9XjhMl4MgktNTAnvK
	X/ssfXcG9XaxRlQDua88xy+wQSdG6mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726608571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kMGUk0VoH6sbRT585DG1xyLsQxgpgA8+fowuiKKa2aw=;
	b=ilAUebLiW8bEClDBe9eFUMKKPZmaAMYKDB+I41h4ocONxykzm4jaU00D1UZL3zUiq0EVUj
	tJcShhJ2OBpf8oDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24BB813AB5;
	Tue, 17 Sep 2024 21:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +aDyCLv06WafMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Sep 2024 21:29:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 75F20A08B3; Tue, 17 Sep 2024 17:50:51 +0200 (CEST)
Date: Tue, 17 Sep 2024 17:50:51 +0200
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>
Subject: Re: [PATCH 3/5] befs: convert befs to use the new mount api
Message-ID: <20240917155051.mwzaeq2d3u74acsi@quack3>
References: <20240916172735.866916-1-sandeen@redhat.com>
 <20240916172735.866916-4-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916172735.866916-4-sandeen@redhat.com>
X-Rspamd-Queue-Id: 369702250C
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Mon 16-09-24 13:26:20, Eric Sandeen wrote:
> Convert the befs filesystem to use the new mount API.
> Tested by comparing random mount & remount options before and after
> the change.
> 
> Cc: Luis de Bethencourt <luisbg@kernel.org>
> Cc: Salah Triki <salah.triki@gmail.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/befs/linuxvfs.c | 199 +++++++++++++++++++++++----------------------
>  1 file changed, 102 insertions(+), 97 deletions(-)
> 
> diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
> index f92f108840f5..8f430ff8e445 100644
> --- a/fs/befs/linuxvfs.c
> +++ b/fs/befs/linuxvfs.c
> @@ -11,12 +11,13 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/fs.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/errno.h>
>  #include <linux/stat.h>
>  #include <linux/nls.h>
>  #include <linux/buffer_head.h>
>  #include <linux/vfs.h>
> -#include <linux/parser.h>
>  #include <linux/namei.h>
>  #include <linux/sched.h>
>  #include <linux/cred.h>
> @@ -54,22 +55,20 @@ static int befs_utf2nls(struct super_block *sb, const char *in, int in_len,
>  static int befs_nls2utf(struct super_block *sb, const char *in, int in_len,
>  			char **out, int *out_len);
>  static void befs_put_super(struct super_block *);
> -static int befs_remount(struct super_block *, int *, char *);
>  static int befs_statfs(struct dentry *, struct kstatfs *);
>  static int befs_show_options(struct seq_file *, struct dentry *);
> -static int parse_options(char *, struct befs_mount_options *);
>  static struct dentry *befs_fh_to_dentry(struct super_block *sb,
>  				struct fid *fid, int fh_len, int fh_type);
>  static struct dentry *befs_fh_to_parent(struct super_block *sb,
>  				struct fid *fid, int fh_len, int fh_type);
>  static struct dentry *befs_get_parent(struct dentry *child);
> +static void befs_free_fc(struct fs_context *fc);
>  
>  static const struct super_operations befs_sops = {
>  	.alloc_inode	= befs_alloc_inode,	/* allocate a new inode */
>  	.free_inode	= befs_free_inode, /* deallocate an inode */
>  	.put_super	= befs_put_super,	/* uninit super */
>  	.statfs		= befs_statfs,	/* statfs */
> -	.remount_fs	= befs_remount,
>  	.show_options	= befs_show_options,
>  };
>  
> @@ -672,92 +671,53 @@ static struct dentry *befs_get_parent(struct dentry *child)
>  }
>  
>  enum {
> -	Opt_uid, Opt_gid, Opt_charset, Opt_debug, Opt_err,
> +	Opt_uid, Opt_gid, Opt_charset, Opt_debug,
>  };
>  
> -static const match_table_t befs_tokens = {
> -	{Opt_uid, "uid=%d"},
> -	{Opt_gid, "gid=%d"},
> -	{Opt_charset, "iocharset=%s"},
> -	{Opt_debug, "debug"},
> -	{Opt_err, NULL}
> +static const struct fs_parameter_spec befs_param_spec[] = {
> +	fsparam_uid	("uid",		Opt_uid),
> +	fsparam_gid	("gid",		Opt_gid),
> +	fsparam_string	("iocharset",	Opt_charset),
> +	fsparam_flag	("debug",	Opt_debug),
> +	{}
>  };
>  
>  static int
> -parse_options(char *options, struct befs_mount_options *opts)
> +befs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
> -	char *p;
> -	substring_t args[MAX_OPT_ARGS];
> -	int option;
> -	kuid_t uid;
> -	kgid_t gid;
> -
> -	/* Initialize options */
> -	opts->uid = GLOBAL_ROOT_UID;
> -	opts->gid = GLOBAL_ROOT_GID;
> -	opts->use_uid = 0;
> -	opts->use_gid = 0;
> -	opts->iocharset = NULL;
> -	opts->debug = 0;
> -
> -	if (!options)
> -		return 1;
> -
> -	while ((p = strsep(&options, ",")) != NULL) {
> -		int token;
> -
> -		if (!*p)
> -			continue;
> -
> -		token = match_token(p, befs_tokens, args);
> -		switch (token) {
> -		case Opt_uid:
> -			if (match_int(&args[0], &option))
> -				return 0;
> -			uid = INVALID_UID;
> -			if (option >= 0)
> -				uid = make_kuid(current_user_ns(), option);
> -			if (!uid_valid(uid)) {
> -				pr_err("Invalid uid %d, "
> -				       "using default\n", option);
> -				break;
> -			}
> -			opts->uid = uid;
> -			opts->use_uid = 1;
> -			break;
> -		case Opt_gid:
> -			if (match_int(&args[0], &option))
> -				return 0;
> -			gid = INVALID_GID;
> -			if (option >= 0)
> -				gid = make_kgid(current_user_ns(), option);
> -			if (!gid_valid(gid)) {
> -				pr_err("Invalid gid %d, "
> -				       "using default\n", option);
> -				break;
> -			}
> -			opts->gid = gid;
> -			opts->use_gid = 1;
> -			break;
> -		case Opt_charset:
> -			kfree(opts->iocharset);
> -			opts->iocharset = match_strdup(&args[0]);
> -			if (!opts->iocharset) {
> -				pr_err("allocation failure for "
> -				       "iocharset string\n");
> -				return 0;
> -			}
> -			break;
> -		case Opt_debug:
> -			opts->debug = 1;
> -			break;
> -		default:
> -			pr_err("Unrecognized mount option \"%s\" "
> -			       "or missing value\n", p);
> -			return 0;
> -		}
> +	struct befs_mount_options *opts = fc->fs_private;
> +	int token;
> +	struct fs_parse_result result;
> +
> +	/* befs ignores all options on remount */
> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
> +		return 0;
> +
> +	token = fs_parse(fc, befs_param_spec, param, &result);
> +	if (token < 0)
> +		return token;
> +
> +	switch (token) {
> +	case Opt_uid:
> +		opts->uid = result.uid;
> +		opts->use_uid = 1;
> +		break;
> +	case Opt_gid:
> +		opts->gid = result.gid;
> +		opts->use_gid = 1;
> +		break;
> +	case Opt_charset:
> +		kfree(opts->iocharset);
> +		opts->iocharset = param->string;
> +		param->string = NULL;
> +		break;
> +	case Opt_debug:
> +		opts->debug = 1;
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
> -	return 1;
> +	return 0;
>  }
>  
>  static int befs_show_options(struct seq_file *m, struct dentry *root)
> @@ -793,6 +753,21 @@ befs_put_super(struct super_block *sb)
>  	sb->s_fs_info = NULL;
>  }
>  
> +/*
> + * Copy the parsed options into the sbi mount_options member
> + */
> +static void
> +befs_set_options(struct befs_sb_info *sbi, struct befs_mount_options *opts)
> +{
> +	sbi->mount_opts.uid = opts->uid;
> +	sbi->mount_opts.gid = opts->gid;
> +	sbi->mount_opts.use_uid = opts->use_uid;
> +	sbi->mount_opts.use_gid = opts->use_gid;
> +	sbi->mount_opts.debug = opts->debug;
> +	sbi->mount_opts.iocharset = opts->iocharset;
> +	opts->iocharset = NULL;
> +}
> +
>  /* Allocate private field of the superblock, fill it.
>   *
>   * Finish filling the public superblock fields
> @@ -800,7 +775,7 @@ befs_put_super(struct super_block *sb)
>   * Load a set of NLS translations if needed.
>   */
>  static int
> -befs_fill_super(struct super_block *sb, void *data, int silent)
> +befs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct buffer_head *bh;
>  	struct befs_sb_info *befs_sb;
> @@ -810,6 +785,8 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
>  	const unsigned long sb_block = 0;
>  	const off_t x86_sb_off = 512;
>  	int blocksize;
> +	struct befs_mount_options *parsed_opts = fc->fs_private;
> +	int silent = fc->sb_flags & SB_SILENT;
>  
>  	sb->s_fs_info = kzalloc(sizeof(*befs_sb), GFP_KERNEL);
>  	if (sb->s_fs_info == NULL)
> @@ -817,11 +794,7 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	befs_sb = BEFS_SB(sb);
>  
> -	if (!parse_options((char *) data, &befs_sb->mount_opts)) {
> -		if (!silent)
> -			befs_error(sb, "cannot parse mount options");
> -		goto unacquire_priv_sbp;
> -	}
> +	befs_set_options(befs_sb, parsed_opts);
>  
>  	befs_debug(sb, "---> %s", __func__);
>  
> @@ -934,10 +907,10 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
>  }
>  
>  static int
> -befs_remount(struct super_block *sb, int *flags, char *data)
> +befs_reconfigure(struct fs_context *fc)
>  {
> -	sync_filesystem(sb);
> -	if (!(*flags & SB_RDONLY))
> +	sync_filesystem(fc->root->d_sb);
> +	if (!(fc->sb_flags & SB_RDONLY))
>  		return -EINVAL;
>  	return 0;
>  }
> @@ -965,19 +938,51 @@ befs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	return 0;
>  }
>  
> -static struct dentry *
> -befs_mount(struct file_system_type *fs_type, int flags, const char *dev_name,
> -	    void *data)
> +static int befs_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_bdev(fc, befs_fill_super);
> +}
> +
> +static const struct fs_context_operations befs_context_ops = {
> +	.parse_param	= befs_parse_param,
> +	.get_tree	= befs_get_tree,
> +	.reconfigure	= befs_reconfigure,
> +	.free		= befs_free_fc,
> +};
> +
> +static int befs_init_fs_context(struct fs_context *fc)
> +{
> +	struct befs_mount_options *opts;
> +
> +	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
> +	if (!opts)
> +		return -ENOMEM;
> +
> +	/* Initialize options */
> +	opts->uid = GLOBAL_ROOT_UID;
> +	opts->gid = GLOBAL_ROOT_GID;
> +
> +	fc->fs_private = opts;
> +	fc->ops = &befs_context_ops;
> +
> +	return 0;
> +}
> +
> +static void befs_free_fc(struct fs_context *fc)
>  {
> -	return mount_bdev(fs_type, flags, dev_name, data, befs_fill_super);
> +	struct befs_mount_options *opts = fc->fs_private;
> +
> +	kfree(opts->iocharset);
> +	kfree(fc->fs_private);
>  }
>  
>  static struct file_system_type befs_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "befs",
> -	.mount		= befs_mount,
>  	.kill_sb	= kill_block_super,
>  	.fs_flags	= FS_REQUIRES_DEV,
> +	.init_fs_context = befs_init_fs_context,
> +	.parameters	= befs_param_spec,
>  };
>  MODULE_ALIAS_FS("befs");
>  
> -- 
> 2.46.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

