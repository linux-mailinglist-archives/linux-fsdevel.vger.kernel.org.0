Return-Path: <linux-fsdevel+bounces-29586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7370497B065
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 14:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300C02833BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 12:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5787D171E76;
	Tue, 17 Sep 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eyBdbiCF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="66M8RDWz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A+3QBsY3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X3gUdlBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DB915B548
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726577605; cv=none; b=Xzh4JTXiPVMAwz4EkStOeWCr0kUYaUE+ZZBkkabncUhbIl55YfNf6aLwRnroZ/FrzEHTm3WLHeD8eTPZJQYA1omAXSvCoAYcsCCWwUiuvjdkjGHzuz2kZFuWonWkp/uDg5VOhY/PCAjAlC2/3X1vHx1PrhlPn2qdDMXx/9rJaZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726577605; c=relaxed/simple;
	bh=zbAEWfXTKju9jfK7hkrbw3TtQaBpBUQZHlMZc+HxPRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0Eth/Ov5xs162p031gaku7SAIR1LS4LXa6evG6tSGdjIzMQZi6oAH1n/ZMp1EZGGSZjyV22XiQf4ojF9gVhJp8eihfe0c0J6y4jhpwvdTmdBi1r3+28htocQZ0sdEIaWGRioM1metu6PPbeMS5Rz3hkndaKR+FzIcSaJYnsIBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eyBdbiCF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=66M8RDWz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A+3QBsY3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X3gUdlBd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4C0120065;
	Tue, 17 Sep 2024 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726577602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTP7lI0n73pJDUbBUHNCE6b12TOCY2Qn+jKgKV3U664=;
	b=eyBdbiCFJULZYtt7I531M+cIxgisNGFN5m4NrttVKAvaq2rm1MbZYzDIi/rgXlwiyvMNV6
	NTOR6I2DQeE8UpvdSBg11/ZlmWXljB+D35F3CQmN5WfaqdS2J1a7dxPHLS+2JbP+4TwugG
	KME6P3f5070WiXT71G4qlvfwnJJ55Z0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726577602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTP7lI0n73pJDUbBUHNCE6b12TOCY2Qn+jKgKV3U664=;
	b=66M8RDWz1dHAUrzuZsBCE5dPoN+gQs9AdfUTWYSejEblVMEkwmsNTj3ZGVEvxWw6lFOxd8
	U91VeupOngGQbwCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726577600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTP7lI0n73pJDUbBUHNCE6b12TOCY2Qn+jKgKV3U664=;
	b=A+3QBsY3N7ggbDwHaaWDuWwrFhb4XPikBls3xwUGelKpXZeRfOTXm2z7dzaMYAzIqLAnb5
	z/tx4YZND1TkMOLtBzCNC9sRTUb3+DwR/ZlEslmRsCXHkepwdQMVi4WWZDjYHW9R8ifRWh
	cR+gcP1vcn1jfKdk9XCTrfmO8qvTQ8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726577600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTP7lI0n73pJDUbBUHNCE6b12TOCY2Qn+jKgKV3U664=;
	b=X3gUdlBdj2n30iHQ3gJNjrg/tLVkqzdA40k/RvHoZUA9m8up+8YGaBqfIaOT38meWBtrQV
	mf0+BDldiIloUZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6499139CE;
	Tue, 17 Sep 2024 12:53:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tPxLKMB76WbMJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Sep 2024 12:53:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8FFD5A08B3; Tue, 17 Sep 2024 14:52:58 +0200 (CEST)
Date: Tue, 17 Sep 2024 14:52:58 +0200
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH 1/5] adfs: convert adfs to use the new mount api
Message-ID: <20240917125258.gpnolxntcsklaicz@quack3>
References: <20240916172735.866916-1-sandeen@redhat.com>
 <20240916172735.866916-2-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916172735.866916-2-sandeen@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 16-09-24 13:26:18, Eric Sandeen wrote:
> Convert the adfs filesystem to use the new mount API.
> Tested by comparing random mount & remount options before and after
> the change.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/adfs/super.c | 186 +++++++++++++++++++++++++-----------------------
>  1 file changed, 95 insertions(+), 91 deletions(-)
> 
> diff --git a/fs/adfs/super.c b/fs/adfs/super.c
> index f0b999a4961b..017c48a80203 100644
> --- a/fs/adfs/super.c
> +++ b/fs/adfs/super.c
> @@ -6,7 +6,8 @@
>   */
>  #include <linux/module.h>
>  #include <linux/init.h>
> -#include <linux/parser.h>
> +#include <linux/fs_parser.h>
> +#include <linux/fs_context.h>
>  #include <linux/mount.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
> @@ -115,87 +116,61 @@ static int adfs_show_options(struct seq_file *seq, struct dentry *root)
>  	return 0;
>  }
>  
> -enum {Opt_uid, Opt_gid, Opt_ownmask, Opt_othmask, Opt_ftsuffix, Opt_err};
> +enum {Opt_uid, Opt_gid, Opt_ownmask, Opt_othmask, Opt_ftsuffix};
>  
> -static const match_table_t tokens = {
> -	{Opt_uid, "uid=%u"},
> -	{Opt_gid, "gid=%u"},
> -	{Opt_ownmask, "ownmask=%o"},
> -	{Opt_othmask, "othmask=%o"},
> -	{Opt_ftsuffix, "ftsuffix=%u"},
> -	{Opt_err, NULL}
> +static const struct fs_parameter_spec adfs_param_spec[] = {
> +	fsparam_uid	("uid",		Opt_uid),
> +	fsparam_gid	("gid",		Opt_gid),
> +	fsparam_u32oct	("ownmask",	Opt_ownmask),
> +	fsparam_u32oct	("othmask",	Opt_othmask),
> +	fsparam_u32	("ftsuffix",	Opt_ftsuffix),
> +	{}
>  };
>  
> -static int parse_options(struct super_block *sb, struct adfs_sb_info *asb,
> -			 char *options)
> +static int adfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
> -	char *p;
> -	int option;
> -
> -	if (!options)
> -		return 0;
> -
> -	while ((p = strsep(&options, ",")) != NULL) {
> -		substring_t args[MAX_OPT_ARGS];
> -		int token;
> -		if (!*p)
> -			continue;
> -
> -		token = match_token(p, tokens, args);
> -		switch (token) {
> -		case Opt_uid:
> -			if (match_int(args, &option))
> -				return -EINVAL;
> -			asb->s_uid = make_kuid(current_user_ns(), option);
> -			if (!uid_valid(asb->s_uid))
> -				return -EINVAL;
> -			break;
> -		case Opt_gid:
> -			if (match_int(args, &option))
> -				return -EINVAL;
> -			asb->s_gid = make_kgid(current_user_ns(), option);
> -			if (!gid_valid(asb->s_gid))
> -				return -EINVAL;
> -			break;
> -		case Opt_ownmask:
> -			if (match_octal(args, &option))
> -				return -EINVAL;
> -			asb->s_owner_mask = option;
> -			break;
> -		case Opt_othmask:
> -			if (match_octal(args, &option))
> -				return -EINVAL;
> -			asb->s_other_mask = option;
> -			break;
> -		case Opt_ftsuffix:
> -			if (match_int(args, &option))
> -				return -EINVAL;
> -			asb->s_ftsuffix = option;
> -			break;
> -		default:
> -			adfs_msg(sb, KERN_ERR,
> -				 "unrecognised mount option \"%s\" or missing value",
> -				 p);
> -			return -EINVAL;
> -		}
> +	struct adfs_sb_info *asb = fc->s_fs_info;
> +	struct fs_parse_result result;
> +	int opt;
> +
> +	opt = fs_parse(fc, adfs_param_spec, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_uid:
> +		asb->s_uid = result.uid;
> +		break;
> +	case Opt_gid:
> +		asb->s_gid = result.gid;
> +		break;
> +	case Opt_ownmask:
> +		asb->s_owner_mask = result.uint_32;
> +		break;
> +	case Opt_othmask:
> +		asb->s_other_mask = result.uint_32;
> +		break;
> +	case Opt_ftsuffix:
> +		asb->s_ftsuffix = result.uint_32;
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
>  	return 0;
>  }
>  
> -static int adfs_remount(struct super_block *sb, int *flags, char *data)
> +static int adfs_reconfigure(struct fs_context *fc)
>  {
> -	struct adfs_sb_info temp_asb;
> -	int ret;
> +	struct adfs_sb_info *new_asb = fc->s_fs_info;
> +	struct adfs_sb_info *asb = ADFS_SB(fc->root->d_sb);
>  
> -	sync_filesystem(sb);
> -	*flags |= ADFS_SB_FLAGS;
> +	sync_filesystem(fc->root->d_sb);
> +	fc->sb_flags |= ADFS_SB_FLAGS;
>  
> -	temp_asb = *ADFS_SB(sb);
> -	ret = parse_options(sb, &temp_asb, data);
> -	if (ret == 0)
> -		*ADFS_SB(sb) = temp_asb;
> +	/* Structure copy newly parsed options */
> +	*asb = *new_asb;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int adfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> @@ -273,7 +248,6 @@ static const struct super_operations adfs_sops = {
>  	.write_inode	= adfs_write_inode,
>  	.put_super	= adfs_put_super,
>  	.statfs		= adfs_statfs,
> -	.remount_fs	= adfs_remount,
>  	.show_options	= adfs_show_options,
>  };
>  
> @@ -361,34 +335,21 @@ static int adfs_validate_dr0(struct super_block *sb, struct buffer_head *bh,
>  	return 0;
>  }
>  
> -static int adfs_fill_super(struct super_block *sb, void *data, int silent)
> +static int adfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>  	struct adfs_discrecord *dr;
>  	struct object_info root_obj;
> -	struct adfs_sb_info *asb;
> +	struct adfs_sb_info *asb = sb->s_fs_info;
>  	struct inode *root;
>  	int ret = -EINVAL;
> +	int silent = fc->sb_flags & SB_SILENT;
>  
>  	sb->s_flags |= ADFS_SB_FLAGS;
>  
> -	asb = kzalloc(sizeof(*asb), GFP_KERNEL);
> -	if (!asb)
> -		return -ENOMEM;
> -
>  	sb->s_fs_info = asb;
>  	sb->s_magic = ADFS_SUPER_MAGIC;
>  	sb->s_time_gran = 10000000;
>  
> -	/* set default options */
> -	asb->s_uid = GLOBAL_ROOT_UID;
> -	asb->s_gid = GLOBAL_ROOT_GID;
> -	asb->s_owner_mask = ADFS_DEFAULT_OWNER_MASK;
> -	asb->s_other_mask = ADFS_DEFAULT_OTHER_MASK;
> -	asb->s_ftsuffix = 0;
> -
> -	if (parse_options(sb, asb, data))
> -		goto error;
> -
>  	/* Try to probe the filesystem boot block */
>  	ret = adfs_probe(sb, ADFS_DISCRECORD, 1, adfs_validate_bblk);
>  	if (ret == -EILSEQ)
> @@ -453,18 +414,61 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
>  	return ret;
>  }
>  
> -static struct dentry *adfs_mount(struct file_system_type *fs_type,
> -	int flags, const char *dev_name, void *data)
> +static int adfs_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_bdev(fc, adfs_fill_super);
> +}
> +
> +static void adfs_free_fc(struct fs_context *fc)
>  {
> -	return mount_bdev(fs_type, flags, dev_name, data, adfs_fill_super);
> +	struct adfs_context *asb = fc->s_fs_info;
> +
> +	kfree(asb);
> +}
> +
> +static const struct fs_context_operations adfs_context_ops = {
> +	.parse_param	= adfs_parse_param,
> +	.get_tree	= adfs_get_tree,
> +	.reconfigure	= adfs_reconfigure,
> +	.free		= adfs_free_fc,
> +};
> +
> +static int adfs_init_fs_context(struct fs_context *fc)
> +{
> +	struct adfs_sb_info *asb;
> +
> +	asb = kzalloc(sizeof(struct adfs_sb_info), GFP_KERNEL);
> +	if (!asb)
> +		return -ENOMEM;
> +
> +	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
> +		struct super_block *sb = fc->root->d_sb;
> +		struct adfs_sb_info *old_asb = ADFS_SB(sb);
> +
> +		/* structure copy existing options before parsing */
> +		*asb = *old_asb;
> +	} else {
> +		/* set default options */
> +		asb->s_uid = GLOBAL_ROOT_UID;
> +		asb->s_gid = GLOBAL_ROOT_GID;
> +		asb->s_owner_mask = ADFS_DEFAULT_OWNER_MASK;
> +		asb->s_other_mask = ADFS_DEFAULT_OTHER_MASK;
> +		asb->s_ftsuffix = 0;
> +	}
> +
> +	fc->ops = &adfs_context_ops;
> +	fc->s_fs_info = asb;
> +
> +	return 0;
>  }
>  
>  static struct file_system_type adfs_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "adfs",
> -	.mount		= adfs_mount,
>  	.kill_sb	= kill_block_super,
>  	.fs_flags	= FS_REQUIRES_DEV,
> +	.init_fs_context = adfs_init_fs_context,
> +	.parameters	= adfs_param_spec,
>  };
>  MODULE_ALIAS_FS("adfs");
>  
> -- 
> 2.46.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

