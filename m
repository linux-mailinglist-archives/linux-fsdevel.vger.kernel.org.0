Return-Path: <linux-fsdevel+bounces-29603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7751F97B534
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 23:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4028128404B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9F8192D6B;
	Tue, 17 Sep 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X48GYiKf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9fjsH/x7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X48GYiKf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9fjsH/x7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201771925A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608575; cv=none; b=MCsBKUojvcvRW1WkgRoJCD67dS6A+ljvb+5YwyJNYv/q1XABxDodcWWU1C134ZIo5ZGnCnCgJ16kaEXapHtaJTWfdzPrqzltPad5jOog2snbML0ySQ4h67sc/feIqzE8QSpaW/damwGrVuYw5mRKflOPKRDy+xM2C3Nd9Iav3Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608575; c=relaxed/simple;
	bh=QhIs/BoOmss6EFtqGdn39P7K0VzSGRWuSy5SaueNufE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOZ3YrAqixwqnu/9QFcf0BYblPPM3DTKFXRPD9rffIgWAazm5ygKyLygI8+o3IZtHxeoqQyHfzA3jUN1Sz1ObAvm/li87Mrmf/S5QkHSv7fJ7ZjLPWYkdSYNGT2KsN/kwtlAqNcKh83zaoSrgXdLjSzsaGJOK2jwny3bfijqYIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X48GYiKf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9fjsH/x7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X48GYiKf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9fjsH/x7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A415201DF;
	Tue, 17 Sep 2024 21:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726608571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N+D5jLI2L5hMvCN5NhpVP+kBi47HDAzocwrCk5JSk5E=;
	b=X48GYiKfKTeZUoTSL2NOZSzp88ziSdw/qc85J1k6Hpcq/YKDxmA/jL+BeLxtejmEuYJg4J
	ZBrffBYU12q2M0/mTFpoSNgKWj9sU/T+LxfVkHzfY+6mhKQHZy1RR6/QQeChvg6e7I2VRm
	P+2QGnY3bI3VmdspRQqj3Beq2FO6gm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726608571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N+D5jLI2L5hMvCN5NhpVP+kBi47HDAzocwrCk5JSk5E=;
	b=9fjsH/x7T4JIoA4z/9Hqkw9uB/LdKEXm8XIIPKnHToaB4zpk/oFF79y/cPBC0vbLc9oXa1
	gJeEpYR27XQSQOCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X48GYiKf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="9fjsH/x7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726608571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N+D5jLI2L5hMvCN5NhpVP+kBi47HDAzocwrCk5JSk5E=;
	b=X48GYiKfKTeZUoTSL2NOZSzp88ziSdw/qc85J1k6Hpcq/YKDxmA/jL+BeLxtejmEuYJg4J
	ZBrffBYU12q2M0/mTFpoSNgKWj9sU/T+LxfVkHzfY+6mhKQHZy1RR6/QQeChvg6e7I2VRm
	P+2QGnY3bI3VmdspRQqj3Beq2FO6gm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726608571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N+D5jLI2L5hMvCN5NhpVP+kBi47HDAzocwrCk5JSk5E=;
	b=9fjsH/x7T4JIoA4z/9Hqkw9uB/LdKEXm8XIIPKnHToaB4zpk/oFF79y/cPBC0vbLc9oXa1
	gJeEpYR27XQSQOCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EE91139CE;
	Tue, 17 Sep 2024 21:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sFASB7v06WaaMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Sep 2024 21:29:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 040E2A0989; Tue, 17 Sep 2024 17:55:22 +0200 (CEST)
Date: Tue, 17 Sep 2024 17:55:22 +0200
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH 4/5] hfs: convert hfs to use the new mount api
Message-ID: <20240917155522.wbjqxpmrub7kolkf@quack3>
References: <20240916172735.866916-1-sandeen@redhat.com>
 <20240916172735.866916-5-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916172735.866916-5-sandeen@redhat.com>
X-Rspamd-Queue-Id: 3A415201DF
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 16-09-24 13:26:21, Eric Sandeen wrote:
> Convert the hfs filesystem to use the new mount API.
> Tested by comparing random mount & remount options before and after
> the change.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/hfs/super.c | 341 ++++++++++++++++++++++---------------------------
>  1 file changed, 154 insertions(+), 187 deletions(-)
> 
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index eeac99765f0d..ee314f3e39f8 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -15,10 +15,11 @@
>  #include <linux/module.h>
>  #include <linux/blkdev.h>
>  #include <linux/backing-dev.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/mount.h>
>  #include <linux/init.h>
>  #include <linux/nls.h>
> -#include <linux/parser.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/vfs.h>
> @@ -111,21 +112,24 @@ static int hfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	return 0;
>  }
>  
> -static int hfs_remount(struct super_block *sb, int *flags, char *data)
> +static int hfs_reconfigure(struct fs_context *fc)
>  {
> +	struct super_block *sb = fc->root->d_sb;
> +
>  	sync_filesystem(sb);
> -	*flags |= SB_NODIRATIME;
> -	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
> +	fc->sb_flags |= SB_NODIRATIME;
> +	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
>  		return 0;
> -	if (!(*flags & SB_RDONLY)) {
> +
> +	if (!(fc->sb_flags & SB_RDONLY)) {
>  		if (!(HFS_SB(sb)->mdb->drAtrb & cpu_to_be16(HFS_SB_ATTRIB_UNMNT))) {
>  			pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is recommended.  leaving read-only.\n");
>  			sb->s_flags |= SB_RDONLY;
> -			*flags |= SB_RDONLY;
> +			fc->sb_flags |= SB_RDONLY;
>  		} else if (HFS_SB(sb)->mdb->drAtrb & cpu_to_be16(HFS_SB_ATTRIB_SLOCK)) {
>  			pr_warn("filesystem is marked locked, leaving read-only.\n");
>  			sb->s_flags |= SB_RDONLY;
> -			*flags |= SB_RDONLY;
> +			fc->sb_flags |= SB_RDONLY;
>  		}
>  	}
>  	return 0;
> @@ -180,7 +184,6 @@ static const struct super_operations hfs_super_operations = {
>  	.put_super	= hfs_put_super,
>  	.sync_fs	= hfs_sync_fs,
>  	.statfs		= hfs_statfs,
> -	.remount_fs     = hfs_remount,
>  	.show_options	= hfs_show_options,
>  };
>  
> @@ -188,181 +191,112 @@ enum {
>  	opt_uid, opt_gid, opt_umask, opt_file_umask, opt_dir_umask,
>  	opt_part, opt_session, opt_type, opt_creator, opt_quiet,
>  	opt_codepage, opt_iocharset,
> -	opt_err
>  };
>  
> -static const match_table_t tokens = {
> -	{ opt_uid, "uid=%u" },
> -	{ opt_gid, "gid=%u" },
> -	{ opt_umask, "umask=%o" },
> -	{ opt_file_umask, "file_umask=%o" },
> -	{ opt_dir_umask, "dir_umask=%o" },
> -	{ opt_part, "part=%u" },
> -	{ opt_session, "session=%u" },
> -	{ opt_type, "type=%s" },
> -	{ opt_creator, "creator=%s" },
> -	{ opt_quiet, "quiet" },
> -	{ opt_codepage, "codepage=%s" },
> -	{ opt_iocharset, "iocharset=%s" },
> -	{ opt_err, NULL }
> +static const struct fs_parameter_spec hfs_param_spec[] = {
> +	fsparam_u32	("uid",		opt_uid),
> +	fsparam_u32	("gid",		opt_gid),
> +	fsparam_u32oct	("umask",	opt_umask),
> +	fsparam_u32oct	("file_umask",	opt_file_umask),
> +	fsparam_u32oct	("dir_umask",	opt_dir_umask),
> +	fsparam_u32	("part",	opt_part),
> +	fsparam_u32	("session",	opt_session),
> +	fsparam_string	("type",	opt_type),
> +	fsparam_string	("creator",	opt_creator),
> +	fsparam_flag	("quiet",	opt_quiet),
> +	fsparam_string	("codepage",	opt_codepage),
> +	fsparam_string	("iocharset",	opt_iocharset),
> +	{}
>  };
>  
> -static inline int match_fourchar(substring_t *arg, u32 *result)
> -{
> -	if (arg->to - arg->from != 4)
> -		return -EINVAL;
> -	memcpy(result, arg->from, 4);
> -	return 0;
> -}
> -
>  /*
> - * parse_options()
> + * hfs_parse_param()
>   *
> - * adapted from linux/fs/msdos/inode.c written 1992,93 by Werner Almesberger
> - * This function is called by hfs_read_super() to parse the mount options.
> + * This function is called by the vfs to parse the mount options.
>   */
> -static int parse_options(char *options, struct hfs_sb_info *hsb)
> +static int hfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
> -	char *p;
> -	substring_t args[MAX_OPT_ARGS];
> -	int tmp, token;
> -
> -	/* initialize the sb with defaults */
> -	hsb->s_uid = current_uid();
> -	hsb->s_gid = current_gid();
> -	hsb->s_file_umask = 0133;
> -	hsb->s_dir_umask = 0022;
> -	hsb->s_type = hsb->s_creator = cpu_to_be32(0x3f3f3f3f);	/* == '????' */
> -	hsb->s_quiet = 0;
> -	hsb->part = -1;
> -	hsb->session = -1;
> -
> -	if (!options)
> -		return 1;
> -
> -	while ((p = strsep(&options, ",")) != NULL) {
> -		if (!*p)
> -			continue;
> -
> -		token = match_token(p, tokens, args);
> -		switch (token) {
> -		case opt_uid:
> -			if (match_int(&args[0], &tmp)) {
> -				pr_err("uid requires an argument\n");
> -				return 0;
> -			}
> -			hsb->s_uid = make_kuid(current_user_ns(), (uid_t)tmp);
> -			if (!uid_valid(hsb->s_uid)) {
> -				pr_err("invalid uid %d\n", tmp);
> -				return 0;
> -			}
> -			break;
> -		case opt_gid:
> -			if (match_int(&args[0], &tmp)) {
> -				pr_err("gid requires an argument\n");
> -				return 0;
> -			}
> -			hsb->s_gid = make_kgid(current_user_ns(), (gid_t)tmp);
> -			if (!gid_valid(hsb->s_gid)) {
> -				pr_err("invalid gid %d\n", tmp);
> -				return 0;
> -			}
> -			break;
> -		case opt_umask:
> -			if (match_octal(&args[0], &tmp)) {
> -				pr_err("umask requires a value\n");
> -				return 0;
> -			}
> -			hsb->s_file_umask = (umode_t)tmp;
> -			hsb->s_dir_umask = (umode_t)tmp;
> -			break;
> -		case opt_file_umask:
> -			if (match_octal(&args[0], &tmp)) {
> -				pr_err("file_umask requires a value\n");
> -				return 0;
> -			}
> -			hsb->s_file_umask = (umode_t)tmp;
> -			break;
> -		case opt_dir_umask:
> -			if (match_octal(&args[0], &tmp)) {
> -				pr_err("dir_umask requires a value\n");
> -				return 0;
> -			}
> -			hsb->s_dir_umask = (umode_t)tmp;
> -			break;
> -		case opt_part:
> -			if (match_int(&args[0], &hsb->part)) {
> -				pr_err("part requires an argument\n");
> -				return 0;
> -			}
> -			break;
> -		case opt_session:
> -			if (match_int(&args[0], &hsb->session)) {
> -				pr_err("session requires an argument\n");
> -				return 0;
> -			}
> -			break;
> -		case opt_type:
> -			if (match_fourchar(&args[0], &hsb->s_type)) {
> -				pr_err("type requires a 4 character value\n");
> -				return 0;
> -			}
> -			break;
> -		case opt_creator:
> -			if (match_fourchar(&args[0], &hsb->s_creator)) {
> -				pr_err("creator requires a 4 character value\n");
> -				return 0;
> -			}
> -			break;
> -		case opt_quiet:
> -			hsb->s_quiet = 1;
> -			break;
> -		case opt_codepage:
> -			if (hsb->nls_disk) {
> -				pr_err("unable to change codepage\n");
> -				return 0;
> -			}
> -			p = match_strdup(&args[0]);
> -			if (p)
> -				hsb->nls_disk = load_nls(p);
> -			if (!hsb->nls_disk) {
> -				pr_err("unable to load codepage \"%s\"\n", p);
> -				kfree(p);
> -				return 0;
> -			}
> -			kfree(p);
> -			break;
> -		case opt_iocharset:
> -			if (hsb->nls_io) {
> -				pr_err("unable to change iocharset\n");
> -				return 0;
> -			}
> -			p = match_strdup(&args[0]);
> -			if (p)
> -				hsb->nls_io = load_nls(p);
> -			if (!hsb->nls_io) {
> -				pr_err("unable to load iocharset \"%s\"\n", p);
> -				kfree(p);
> -				return 0;
> -			}
> -			kfree(p);
> -			break;
> -		default:
> -			return 0;
> -		}
> -	}
> +	struct hfs_sb_info *hsb = fc->s_fs_info;
> +	struct fs_parse_result result;
> +	int opt;
> +
> +	/* hfs does not honor any fs-specific options on remount */
> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)
> +		return 0;
>  
> -	if (hsb->nls_disk && !hsb->nls_io) {
> -		hsb->nls_io = load_nls_default();
> +	opt = fs_parse(fc, hfs_param_spec, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case opt_uid:
> +		hsb->s_uid = result.uid;
> +		break;
> +	case opt_gid:
> +		hsb->s_gid = result.gid;
> +		break;
> +	case opt_umask:
> +		hsb->s_file_umask = (umode_t)result.uint_32;
> +		hsb->s_dir_umask = (umode_t)result.uint_32;
> +		break;
> +	case opt_file_umask:
> +		hsb->s_file_umask = (umode_t)result.uint_32;
> +		break;
> +	case opt_dir_umask:
> +		hsb->s_dir_umask = (umode_t)result.uint_32;
> +		break;
> +	case opt_part:
> +		hsb->part = result.uint_32;
> +		break;
> +	case opt_session:
> +		hsb->session = result.uint_32;
> +		break;
> +	case opt_type:
> +		if (strlen(param->string) != 4) {
> +			pr_err("type requires a 4 character value\n");
> +			return -EINVAL;
> +		}
> +		memcpy(&hsb->s_type, param->string, 4);
> +		break;
> +	case opt_creator:
> +		if (strlen(param->string) != 4) {
> +			pr_err("creator requires a 4 character value\n");
> +			return -EINVAL;
> +		}
> +		memcpy(&hsb->s_creator, param->string, 4);
> +		break;
> +	case opt_quiet:
> +		hsb->s_quiet = 1;
> +		break;
> +	case opt_codepage:
> +		if (hsb->nls_disk) {
> +			pr_err("unable to change codepage\n");
> +			return -EINVAL;
> +		}
> +		hsb->nls_disk = load_nls(param->string);
> +		if (!hsb->nls_disk) {
> +			pr_err("unable to load codepage \"%s\"\n",
> +					param->string);
> +			return -EINVAL;
> +		}
> +		break;
> +	case opt_iocharset:
> +		if (hsb->nls_io) {
> +			pr_err("unable to change iocharset\n");
> +			return -EINVAL;
> +		}
> +		hsb->nls_io = load_nls(param->string);
>  		if (!hsb->nls_io) {
> -			pr_err("unable to load default iocharset\n");
> -			return 0;
> +			pr_err("unable to load iocharset \"%s\"\n",
> +					param->string);
> +			return -EINVAL;
>  		}
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
> -	hsb->s_dir_umask &= 0777;
> -	hsb->s_file_umask &= 0577;
>  
> -	return 1;
> +	return 0;
>  }
>  
>  /*
> @@ -376,29 +310,24 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
>   * hfs_btree_init() to get the necessary data about the extents and
>   * catalog B-trees and, finally, reading the root inode into memory.
>   */
> -static int hfs_fill_super(struct super_block *sb, void *data, int silent)
> +static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
> -	struct hfs_sb_info *sbi;
> +	struct hfs_sb_info *sbi = HFS_SB(sb);
>  	struct hfs_find_data fd;
>  	hfs_cat_rec rec;
>  	struct inode *root_inode;
> +	int silent = fc->sb_flags & SB_SILENT;
>  	int res;
>  
> -	sbi = kzalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
> -	if (!sbi)
> -		return -ENOMEM;
> +	/* load_nls_default does not fail */
> +	if (sbi->nls_disk && !sbi->nls_io)
> +		sbi->nls_io = load_nls_default();
> +	sbi->s_dir_umask &= 0777;
> +	sbi->s_file_umask &= 0577;
>  
> -	sbi->sb = sb;
> -	sb->s_fs_info = sbi;
>  	spin_lock_init(&sbi->work_lock);
>  	INIT_DELAYED_WORK(&sbi->mdb_work, flush_mdb);
>  
> -	res = -EINVAL;
> -	if (!parse_options((char *)data, sbi)) {
> -		pr_err("unable to parse mount options\n");
> -		goto bail;
> -	}
> -
>  	sb->s_op = &hfs_super_operations;
>  	sb->s_xattr = hfs_xattr_handlers;
>  	sb->s_flags |= SB_NODIRATIME;
> @@ -451,18 +380,56 @@ static int hfs_fill_super(struct super_block *sb, void *data, int silent)
>  	return res;
>  }
>  
> -static struct dentry *hfs_mount(struct file_system_type *fs_type,
> -		      int flags, const char *dev_name, void *data)
> +static int hfs_get_tree(struct fs_context *fc)
>  {
> -	return mount_bdev(fs_type, flags, dev_name, data, hfs_fill_super);
> +	return get_tree_bdev(fc, hfs_fill_super);
> +}
> +
> +static void hfs_free_fc(struct fs_context *fc)
> +{
> +	kfree(fc->s_fs_info);
> +}
> +
> +static const struct fs_context_operations hfs_context_ops = {
> +	.parse_param	= hfs_parse_param,
> +	.get_tree	= hfs_get_tree,
> +	.reconfigure	= hfs_reconfigure,
> +	.free		= hfs_free_fc,
> +};
> +
> +static int hfs_init_fs_context(struct fs_context *fc)
> +{
> +	struct hfs_sb_info *hsb;
> +
> +	hsb = kzalloc(sizeof(struct hfs_sb_info), GFP_KERNEL);
> +	if (!hsb)
> +		return -ENOMEM;
> +
> +	fc->s_fs_info = hsb;
> +	fc->ops = &hfs_context_ops;
> +
> +	if (fc->purpose != FS_CONTEXT_FOR_RECONFIGURE) {
> +		/* initialize options with defaults */
> +		hsb->s_uid = current_uid();
> +		hsb->s_gid = current_gid();
> +		hsb->s_file_umask = 0133;
> +		hsb->s_dir_umask = 0022;
> +		hsb->s_type = cpu_to_be32(0x3f3f3f3f); /* == '????' */
> +		hsb->s_creator = cpu_to_be32(0x3f3f3f3f); /* == '????' */
> +		hsb->s_quiet = 0;
> +		hsb->part = -1;
> +		hsb->session = -1;
> +	}
> +
> +	return 0;
>  }
>  
>  static struct file_system_type hfs_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "hfs",
> -	.mount		= hfs_mount,
>  	.kill_sb	= kill_block_super,
>  	.fs_flags	= FS_REQUIRES_DEV,
> +	.init_fs_context = hfs_init_fs_context,
>  };
>  MODULE_ALIAS_FS("hfs");
>  
> -- 
> 2.46.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

