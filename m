Return-Path: <linux-fsdevel+bounces-29606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E1997B539
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 23:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35091F25A04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 21:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3121C193063;
	Tue, 17 Sep 2024 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y4/7orci";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/s9sMfga";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y4/7orci";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/s9sMfga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201301925A2
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608576; cv=none; b=XwLs7SNGDDviCAxe7tCI5AOfi4x7/CmgezzpnLaX45fzeNGzjx2mJkGG4f/PNlEODXDL2mpnw1E4/Iewr9WL40s/G8k3tdw7dFNb7ZqLws6lKIZ/AS6muQzHC4yFtzCU0ZhkNky+uzh2FZkEGHk0rx/YXX+Z0FcxMEXqqFHTTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608576; c=relaxed/simple;
	bh=Yo8rERVKMqLvDsVJz4Jb48gjg/YwBz67KcczC5vOlQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVRKugtkiZ3NPl4vy096wZ3MV0D79qL8Q9vP5p7S27PQOXqf0dj+YGyh6rB+A8bQ9DS+RdgPZRlJsJnjJbiTylNPxwEtAyuqeFxz2FYcG81JFMDkRnb8jONxEpbRIaVfYWWfpKmF5TKy+Ynm4baogfI0PzQvsLKDNig8XHE2c84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y4/7orci; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/s9sMfga; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y4/7orci; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/s9sMfga; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44F6E201E1;
	Tue, 17 Sep 2024 21:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726608571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B1G/JagXIwgCIIUsQbVqrwl272qzrdnmNrmAQCiEuks=;
	b=y4/7orcigz3P1Thm0InJUQyH5r7G0G/UatFSGJQaeelrA8qw6kBa1OSleVR4b4FcU2+N01
	E5TL/vwGrmnfYeoTvaH70XANtaZzXnUz3xMGh0k3m6MgtJ0fE6LfgnqwnZOw1NuuU4oN01
	WeXioLKG14d34xT+ugWDW50IHAG9Lbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726608571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B1G/JagXIwgCIIUsQbVqrwl272qzrdnmNrmAQCiEuks=;
	b=/s9sMfgaXba8hu7Rga7+kd2tn6HARYn83tCS3FxpbIqzGOiOdBavzMNBcfAUAJZmF3oC/8
	6Z+xgZzITlUzn8Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="y4/7orci";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/s9sMfga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726608571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B1G/JagXIwgCIIUsQbVqrwl272qzrdnmNrmAQCiEuks=;
	b=y4/7orcigz3P1Thm0InJUQyH5r7G0G/UatFSGJQaeelrA8qw6kBa1OSleVR4b4FcU2+N01
	E5TL/vwGrmnfYeoTvaH70XANtaZzXnUz3xMGh0k3m6MgtJ0fE6LfgnqwnZOw1NuuU4oN01
	WeXioLKG14d34xT+ugWDW50IHAG9Lbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726608571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B1G/JagXIwgCIIUsQbVqrwl272qzrdnmNrmAQCiEuks=;
	b=/s9sMfgaXba8hu7Rga7+kd2tn6HARYn83tCS3FxpbIqzGOiOdBavzMNBcfAUAJZmF3oC/8
	6Z+xgZzITlUzn8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29E6113AD6;
	Tue, 17 Sep 2024 21:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3wbmCbv06WakMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Sep 2024 21:29:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1868AA0ABD; Tue, 17 Sep 2024 18:11:06 +0200 (CEST)
Date: Tue, 17 Sep 2024 18:11:06 +0200
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH 5/5] hfsplus: convert hfsplus to use the new mount api
Message-ID: <20240917161106.ps7ohqo45cnygnti@quack3>
References: <20240916172735.866916-1-sandeen@redhat.com>
 <20240916172735.866916-6-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916172735.866916-6-sandeen@redhat.com>
X-Rspamd-Queue-Id: 44F6E201E1
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon 16-09-24 13:26:22, Eric Sandeen wrote:
> Convert the hfsplus filesystem to use the new mount API.
> Tested by comparing random mount & remount options before and after
> the change.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/hfsplus/hfsplus_fs.h |   4 +-
>  fs/hfsplus/options.c    | 263 ++++++++++++++--------------------------
>  fs/hfsplus/super.c      |  84 ++++++++-----
>  3 files changed, 149 insertions(+), 202 deletions(-)
> 
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 9e78f181c24f..53cb3c7dfc73 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -21,6 +21,7 @@
>  #include <linux/mutex.h>
>  #include <linux/buffer_head.h>
>  #include <linux/blkdev.h>
> +#include <linux/fs_context.h>
>  #include "hfsplus_raw.h"
>  
>  #define DBG_BNODE_REFS	0x00000001
> @@ -496,8 +497,7 @@ long hfsplus_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>  
>  /* options.c */
>  void hfsplus_fill_defaults(struct hfsplus_sb_info *opts);
> -int hfsplus_parse_options_remount(char *input, int *force);
> -int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi);
> +int hfsplus_parse_param(struct fs_context *fc, struct fs_parameter *param);
>  int hfsplus_show_options(struct seq_file *seq, struct dentry *root);
>  
>  /* part_tbl.c */
> diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
> index c94a58762ad6..a66a09a56bf7 100644
> --- a/fs/hfsplus/options.c
> +++ b/fs/hfsplus/options.c
> @@ -12,7 +12,8 @@
>  #include <linux/string.h>
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
> -#include <linux/parser.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/nls.h>
>  #include <linux/mount.h>
>  #include <linux/seq_file.h>
> @@ -23,26 +24,23 @@ enum {
>  	opt_creator, opt_type,
>  	opt_umask, opt_uid, opt_gid,
>  	opt_part, opt_session, opt_nls,
> -	opt_nodecompose, opt_decompose,
> -	opt_barrier, opt_nobarrier,
> -	opt_force, opt_err
> +	opt_decompose, opt_barrier,
> +	opt_force,
>  };
>  
> -static const match_table_t tokens = {
> -	{ opt_creator, "creator=%s" },
> -	{ opt_type, "type=%s" },
> -	{ opt_umask, "umask=%o" },
> -	{ opt_uid, "uid=%u" },
> -	{ opt_gid, "gid=%u" },
> -	{ opt_part, "part=%u" },
> -	{ opt_session, "session=%u" },
> -	{ opt_nls, "nls=%s" },
> -	{ opt_decompose, "decompose" },
> -	{ opt_nodecompose, "nodecompose" },
> -	{ opt_barrier, "barrier" },
> -	{ opt_nobarrier, "nobarrier" },
> -	{ opt_force, "force" },
> -	{ opt_err, NULL }
> +static const struct fs_parameter_spec hfs_param_spec[] = {
> +	fsparam_string	("creator",	opt_creator),
> +	fsparam_string	("type",	opt_type),
> +	fsparam_u32oct	("umask",	opt_umask),
> +	fsparam_u32	("uid",		opt_uid),
> +	fsparam_u32	("gid",		opt_gid),
> +	fsparam_u32	("part",	opt_part),
> +	fsparam_u32	("session",	opt_session),
> +	fsparam_string	("nls",		opt_nls),
> +	fsparam_flag_no	("decompose",	opt_decompose),
> +	fsparam_flag_no	("barrier",	opt_barrier),
> +	fsparam_flag	("force",	opt_force),
> +	{}
>  };
>  
>  /* Initialize an options object to reasonable defaults */
> @@ -60,162 +58,89 @@ void hfsplus_fill_defaults(struct hfsplus_sb_info *opts)
>  	opts->session = -1;
>  }
>  
> -/* convert a "four byte character" to a 32 bit int with error checks */
> -static inline int match_fourchar(substring_t *arg, u32 *result)
> +/* Parse options from mount. Returns nonzero errno on failure */
> +int hfsplus_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
> -	if (arg->to - arg->from != 4)
> -		return -EINVAL;
> -	memcpy(result, arg->from, 4);
> -	return 0;
> -}
> -
> -int hfsplus_parse_options_remount(char *input, int *force)
> -{
> -	char *p;
> -	substring_t args[MAX_OPT_ARGS];
> -	int token;
> -
> -	if (!input)
> -		return 1;
> -
> -	while ((p = strsep(&input, ",")) != NULL) {
> -		if (!*p)
> -			continue;
> -
> -		token = match_token(p, tokens, args);
> -		switch (token) {
> -		case opt_force:
> -			*force = 1;
> -			break;
> -		default:
> -			break;
> +	struct hfsplus_sb_info *sbi = fc->s_fs_info;
> +	struct fs_parse_result result;
> +	int opt;
> +
> +	/*
> +	 * Only the force option is examined during remount, all others
> +	 * are ignored.
> +	 */
> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE &&
> +	    strncmp(param->key, "force", 5))
> +		return 0;
> +
> +	opt = fs_parse(fc, hfs_param_spec, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case opt_creator:
> +		if (strlen(param->string) != 4) {
> +			pr_err("creator requires a 4 character value\n");
> +			return -EINVAL;
>  		}
> -	}
> -
> -	return 1;
> -}
> -
> -/* Parse options from mount. Returns 0 on failure */
> -/* input is the options passed to mount() as a string */
> -int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi)
> -{
> -	char *p;
> -	substring_t args[MAX_OPT_ARGS];
> -	int tmp, token;
> -
> -	if (!input)
> -		goto done;
> -
> -	while ((p = strsep(&input, ",")) != NULL) {
> -		if (!*p)
> -			continue;
> -
> -		token = match_token(p, tokens, args);
> -		switch (token) {
> -		case opt_creator:
> -			if (match_fourchar(&args[0], &sbi->creator)) {
> -				pr_err("creator requires a 4 character value\n");
> -				return 0;
> -			}
> -			break;
> -		case opt_type:
> -			if (match_fourchar(&args[0], &sbi->type)) {
> -				pr_err("type requires a 4 character value\n");
> -				return 0;
> -			}
> -			break;
> -		case opt_umask:
> -			if (match_octal(&args[0], &tmp)) {
> -				pr_err("umask requires a value\n");
> -				return 0;
> -			}
> -			sbi->umask = (umode_t)tmp;
> -			break;
> -		case opt_uid:
> -			if (match_int(&args[0], &tmp)) {
> -				pr_err("uid requires an argument\n");
> -				return 0;
> -			}
> -			sbi->uid = make_kuid(current_user_ns(), (uid_t)tmp);
> -			if (!uid_valid(sbi->uid)) {
> -				pr_err("invalid uid specified\n");
> -				return 0;
> -			} else {
> -				set_bit(HFSPLUS_SB_UID, &sbi->flags);
> -			}
> -			break;
> -		case opt_gid:
> -			if (match_int(&args[0], &tmp)) {
> -				pr_err("gid requires an argument\n");
> -				return 0;
> -			}
> -			sbi->gid = make_kgid(current_user_ns(), (gid_t)tmp);
> -			if (!gid_valid(sbi->gid)) {
> -				pr_err("invalid gid specified\n");
> -				return 0;
> -			} else {
> -				set_bit(HFSPLUS_SB_GID, &sbi->flags);
> -			}
> -			break;
> -		case opt_part:
> -			if (match_int(&args[0], &sbi->part)) {
> -				pr_err("part requires an argument\n");
> -				return 0;
> -			}
> -			break;
> -		case opt_session:
> -			if (match_int(&args[0], &sbi->session)) {
> -				pr_err("session requires an argument\n");
> -				return 0;
> -			}
> -			break;
> -		case opt_nls:
> -			if (sbi->nls) {
> -				pr_err("unable to change nls mapping\n");
> -				return 0;
> -			}
> -			p = match_strdup(&args[0]);
> -			if (p)
> -				sbi->nls = load_nls(p);
> -			if (!sbi->nls) {
> -				pr_err("unable to load nls mapping \"%s\"\n",
> -				       p);
> -				kfree(p);
> -				return 0;
> -			}
> -			kfree(p);
> -			break;
> -		case opt_decompose:
> -			clear_bit(HFSPLUS_SB_NODECOMPOSE, &sbi->flags);
> -			break;
> -		case opt_nodecompose:
> +		memcpy(&sbi->creator, param->string, 4);
> +		break;
> +	case opt_type:
> +		if (strlen(param->string) != 4) {
> +			pr_err("type requires a 4 character value\n");
> +			return -EINVAL;
> +		}
> +		memcpy(&sbi->type, param->string, 4);
> +		break;
> +	case opt_umask:
> +		sbi->umask = (umode_t)result.uint_32;
> +		break;
> +	case opt_uid:
> +		sbi->uid = result.uid;
> +		set_bit(HFSPLUS_SB_UID, &sbi->flags);
> +		break;
> +	case opt_gid:
> +		sbi->gid = result.gid;
> +		set_bit(HFSPLUS_SB_GID, &sbi->flags);
> +		break;
> +	case opt_part:
> +		sbi->part = result.uint_32;
> +		break;
> +	case opt_session:
> +		sbi->session = result.uint_32;
> +		break;
> +	case opt_nls:
> +		if (sbi->nls) {
> +			pr_err("unable to change nls mapping\n");
> +			return -EINVAL;
> +		}
> +		sbi->nls = load_nls(param->string);
> +		if (!sbi->nls) {
> +			pr_err("unable to load nls mapping \"%s\"\n",
> +			       param->string);
> +			return -EINVAL;
> +		}
> +		break;
> +	case opt_decompose:
> +		if (result.negated)
>  			set_bit(HFSPLUS_SB_NODECOMPOSE, &sbi->flags);
> -			break;
> -		case opt_barrier:
> -			clear_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags);
> -			break;
> -		case opt_nobarrier:
> +		else
> +			clear_bit(HFSPLUS_SB_NODECOMPOSE, &sbi->flags);
> +		break;
> +	case opt_barrier:
> +		if (result.negated)
>  			set_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags);
> -			break;
> -		case opt_force:
> -			set_bit(HFSPLUS_SB_FORCE, &sbi->flags);
> -			break;
> -		default:
> -			return 0;
> -		}
> -	}
> -
> -done:
> -	if (!sbi->nls) {
> -		/* try utf8 first, as this is the old default behaviour */
> -		sbi->nls = load_nls("utf8");
> -		if (!sbi->nls)
> -			sbi->nls = load_nls_default();
> -		if (!sbi->nls)
> -			return 0;
> +		else
> +			clear_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags);
> +		break;
> +	case opt_force:
> +		set_bit(HFSPLUS_SB_FORCE, &sbi->flags);
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
> -	return 1;
> +	return 0;
>  }
>  
>  int hfsplus_show_options(struct seq_file *seq, struct dentry *root)
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 8f986f30a1ce..261af016efd3 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -14,6 +14,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/backing-dev.h>
>  #include <linux/fs.h>
> +#include <linux/fs_context.h>
>  #include <linux/slab.h>
>  #include <linux/vfs.h>
>  #include <linux/nls.h>
> @@ -332,34 +333,33 @@ static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	return 0;
>  }
>  
> -static int hfsplus_remount(struct super_block *sb, int *flags, char *data)
> +static int hfsplus_reconfigure(struct fs_context *fc)
>  {
> +	struct super_block *sb = fc->root->d_sb;
> +
>  	sync_filesystem(sb);
> -	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
> +	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
>  		return 0;
> -	if (!(*flags & SB_RDONLY)) {
> -		struct hfsplus_vh *vhdr = HFSPLUS_SB(sb)->s_vhdr;
> -		int force = 0;
> -
> -		if (!hfsplus_parse_options_remount(data, &force))
> -			return -EINVAL;
> +	if (!(fc->sb_flags & SB_RDONLY)) {
> +		struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
> +		struct hfsplus_vh *vhdr = sbi->s_vhdr;
>  
>  		if (!(vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_UNMNT))) {
>  			pr_warn("filesystem was not cleanly unmounted, running fsck.hfsplus is recommended.  leaving read-only.\n");
>  			sb->s_flags |= SB_RDONLY;
> -			*flags |= SB_RDONLY;
> -		} else if (force) {
> +			fc->sb_flags |= SB_RDONLY;
> +		} else if (test_bit(HFSPLUS_SB_FORCE, &sbi->flags)) {
>  			/* nothing */
>  		} else if (vhdr->attributes &
>  				cpu_to_be32(HFSPLUS_VOL_SOFTLOCK)) {
>  			pr_warn("filesystem is marked locked, leaving read-only.\n");
>  			sb->s_flags |= SB_RDONLY;
> -			*flags |= SB_RDONLY;
> +			fc->sb_flags |= SB_RDONLY;
>  		} else if (vhdr->attributes &
>  				cpu_to_be32(HFSPLUS_VOL_JOURNALED)) {
>  			pr_warn("filesystem is marked journaled, leaving read-only.\n");
>  			sb->s_flags |= SB_RDONLY;
> -			*flags |= SB_RDONLY;
> +			fc->sb_flags |= SB_RDONLY;
>  		}
>  	}
>  	return 0;
> @@ -373,38 +373,33 @@ static const struct super_operations hfsplus_sops = {
>  	.put_super	= hfsplus_put_super,
>  	.sync_fs	= hfsplus_sync_fs,
>  	.statfs		= hfsplus_statfs,
> -	.remount_fs	= hfsplus_remount,
>  	.show_options	= hfsplus_show_options,
>  };
>  
> -static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
> +static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct hfsplus_vh *vhdr;
> -	struct hfsplus_sb_info *sbi;
> +	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
>  	hfsplus_cat_entry entry;
>  	struct hfs_find_data fd;
>  	struct inode *root, *inode;
>  	struct qstr str;
> -	struct nls_table *nls = NULL;
> +	struct nls_table *nls;
>  	u64 last_fs_block, last_fs_page;
> +	int silent = fc->sb_flags & SB_SILENT;
>  	int err;
>  
> -	err = -ENOMEM;
> -	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> -	if (!sbi)
> -		goto out;
> -
> -	sb->s_fs_info = sbi;
>  	mutex_init(&sbi->alloc_mutex);
>  	mutex_init(&sbi->vh_mutex);
>  	spin_lock_init(&sbi->work_lock);
>  	INIT_DELAYED_WORK(&sbi->sync_work, delayed_sync_fs);
> -	hfsplus_fill_defaults(sbi);
>  
>  	err = -EINVAL;
> -	if (!hfsplus_parse_options(data, sbi)) {
> -		pr_err("unable to parse mount options\n");
> -		goto out_unload_nls;
> +	if (!sbi->nls) {
> +		/* try utf8 first, as this is the old default behaviour */
> +		sbi->nls = load_nls("utf8");
> +		if (!sbi->nls)
> +			sbi->nls = load_nls_default();
>  	}
>  
>  	/* temporarily use utf8 to correctly find the hidden dir below */
> @@ -616,7 +611,6 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
>  	unload_nls(sbi->nls);
>  	unload_nls(nls);
>  	kfree(sbi);
> -out:
>  	return err;
>  }
>  
> @@ -641,18 +635,46 @@ static void hfsplus_free_inode(struct inode *inode)
>  
>  #define HFSPLUS_INODE_SIZE	sizeof(struct hfsplus_inode_info)
>  
> -static struct dentry *hfsplus_mount(struct file_system_type *fs_type,
> -			  int flags, const char *dev_name, void *data)
> +static int hfsplus_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_bdev(fc, hfsplus_fill_super);
> +}
> +
> +static void hfsplus_free_fc(struct fs_context *fc)
>  {
> -	return mount_bdev(fs_type, flags, dev_name, data, hfsplus_fill_super);
> +	kfree(fc->s_fs_info);
> +}
> +
> +static const struct fs_context_operations hfsplus_context_ops = {
> +	.parse_param	= hfsplus_parse_param,
> +	.get_tree	= hfsplus_get_tree,
> +	.reconfigure	= hfsplus_reconfigure,
> +	.free		= hfsplus_free_fc,
> +};
> +
> +static int hfsplus_init_fs_context(struct fs_context *fc)
> +{
> +	struct hfsplus_sb_info *sbi;
> +
> +	sbi = kzalloc(sizeof(struct hfsplus_sb_info), GFP_KERNEL);
> +	if (!sbi)
> +		return -ENOMEM;
> +
> +	if (fc->purpose != FS_CONTEXT_FOR_RECONFIGURE)
> +		hfsplus_fill_defaults(sbi);
> +
> +	fc->s_fs_info = sbi;
> +	fc->ops = &hfsplus_context_ops;
> +
> +	return 0;
>  }
>  
>  static struct file_system_type hfsplus_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "hfsplus",
> -	.mount		= hfsplus_mount,
>  	.kill_sb	= kill_block_super,
>  	.fs_flags	= FS_REQUIRES_DEV,
> +	.init_fs_context = hfsplus_init_fs_context,
>  };
>  MODULE_ALIAS_FS("hfsplus");
>  
> -- 
> 2.46.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

