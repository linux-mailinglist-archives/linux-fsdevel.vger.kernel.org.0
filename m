Return-Path: <linux-fsdevel+bounces-10990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF9A84FA62
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03ECC28CDF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FCA85C56;
	Fri,  9 Feb 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elFz1iYs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9548562A
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497756; cv=none; b=heunCNidMNrLZeYmH3cn0t3P+QC8w11mfRTHFYnMkDIzOAHKmoxAtDpXeLQQBStquimjDQ/ZuEG/r0jZmYOOTWoLK7lKiLBMPct5LgkKzhZYFQ47NlsSyyD9Dt6/f1+JfE+chSa4B92sXar8/K3CpRSq/nkyUmi1pw6HQDM6xz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497756; c=relaxed/simple;
	bh=7714CKHW48PHFblzrTkdEL2BUKx67e7+0EV/IV50A/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZRLxl3KoW9oJtBtfVT2f0O1TOHd6twzWB1PuSRW5JVd6JPlEvkGYdlf+TyOmYvd2ojHE3/UgKGk5GwwFNOoJDw3+kwWzhIk82lEzCwUR/bOfIydWRZDBlV8kYIc3zqQ9x67+EJe8PQuqfBZ5Pe8VO/5OIgYoulmXcDqxgtzBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elFz1iYs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707497753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sL+ofHaA6qkvKS8NQqYBzY53+wD0U1HeESIJKFSgtF4=;
	b=elFz1iYsRpjL7ayKig1KEBl+e2Yfibu/0BkrCcr2Kx9OvVcySZ9xfy3m7HxeJ+X4lkaG6q
	FpjqrX6NaEINw01sjl9gADBDX3gWpKCeFoSo4KFl+2gidRP2OWSws8NmsClpk3Eb2f1D1S
	JYIR+KpePFtimV1rEbYJgkpBwVapt28=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-xl4UwJNzOKqwE4WOCyb2iw-1; Fri, 09 Feb 2024 11:55:52 -0500
X-MC-Unique: xl4UwJNzOKqwE4WOCyb2iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BC03862DC2;
	Fri,  9 Feb 2024 16:55:52 +0000 (UTC)
Received: from redhat.com (unknown [10.22.32.174])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0524D2026D06;
	Fri,  9 Feb 2024 16:55:51 +0000 (UTC)
Date: Fri, 9 Feb 2024 10:55:50 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] zonefs: convert zonefs to use the new mount api
Message-ID: <ZcZZFseicmkgzTwU@redhat.com>
References: <20240209000857.21040-1-bodonnel@redhat.com>
 <54dca606-e67f-4933-b8ca-a5e2095193ae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54dca606-e67f-4933-b8ca-a5e2095193ae@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Fri, Feb 09, 2024 at 11:10:00AM +0900, Damien Le Moal wrote:
> On 2/9/24 09:08, Bill O'Donnell wrote:
> > Convert the zonefs filesystem to use the new mount API.
> > Tested using the zonefs test suite from:
> > https://github.com/damien-lemoal/zonefs-tools
> > 
> > Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> 
> Thanks for doing this. I will run tests on this but I do have a few nits below.

I will provide a v2 with the changes you suggest, with one exception (please
see my note within).

> 
> > ---
> >  fs/zonefs/super.c | 156 ++++++++++++++++++++++++++--------------------
> >  1 file changed, 90 insertions(+), 66 deletions(-)
> > 
> > diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> > index e6a75401677d..6b8ecd2e55b8 100644
> > --- a/fs/zonefs/super.c
> > +++ b/fs/zonefs/super.c
> > @@ -15,13 +15,13 @@
> >  #include <linux/writeback.h>
> >  #include <linux/quotaops.h>
> >  #include <linux/seq_file.h>
> > -#include <linux/parser.h>
> >  #include <linux/uio.h>
> >  #include <linux/mman.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/crc32.h>
> >  #include <linux/task_io_accounting_ops.h>
> > -
> > +#include <linux/fs_parser.h>
> > +#include <linux/fs_context.h>
> 
> Please keep the whiteline here.
> 
> >  #include "zonefs.h"
> >  
> >  #define CREATE_TRACE_POINTS
> > @@ -460,58 +460,47 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >  }
> >  
> >  enum {
> > -	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,
> > -	Opt_explicit_open, Opt_err,
> > +	Opt_errors, Opt_explicit_open,
> >  };
> >  
> > -static const match_table_t tokens = {
> > -	{ Opt_errors_ro,	"errors=remount-ro"},
> > -	{ Opt_errors_zro,	"errors=zone-ro"},
> > -	{ Opt_errors_zol,	"errors=zone-offline"},
> > -	{ Opt_errors_repair,	"errors=repair"},
> > -	{ Opt_explicit_open,	"explicit-open" },
> > -	{ Opt_err,		NULL}
> > +struct zonefs_context {
> > +	unsigned long s_mount_opts;
> >  };
> >  
> > -static int zonefs_parse_options(struct super_block *sb, char *options)
> > -{
> > -	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> > -	substring_t args[MAX_OPT_ARGS];
> > -	char *p;
> > -
> > -	if (!options)
> > -		return 0;
> > -
> > -	while ((p = strsep(&options, ",")) != NULL) {
> > -		int token;
> > +static const struct constant_table zonefs_param_errors[] = {
> > +	{"remount-ro",		ZONEFS_MNTOPT_ERRORS_RO},
> > +	{"zone-ro",		ZONEFS_MNTOPT_ERRORS_ZRO},
> > +	{"zone-offline",	ZONEFS_MNTOPT_ERRORS_ZOL},
> > +	{"repair", 		ZONEFS_MNTOPT_ERRORS_REPAIR},
> > +	{}
> > +};
> >  
> > -		if (!*p)
> > -			continue;
> > +static const struct fs_parameter_spec zonefs_param_spec[] = {
> > +	fsparam_enum	("errors",		Opt_errors, zonefs_param_errors),
> > +	fsparam_flag	("explicit-open",	Opt_explicit_open),
> > +	{}
> > +};
> >  
> > -		token = match_token(p, tokens, args);
> > -		switch (token) {
> > -		case Opt_errors_ro:
> > -			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
> > -			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_RO;
> > -			break;
> > -		case Opt_errors_zro:
> > -			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
> > -			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_ZRO;
> > -			break;
> > -		case Opt_errors_zol:
> > -			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
> > -			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_ZOL;
> > -			break;
> > -		case Opt_errors_repair:
> > -			sbi->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
> > -			sbi->s_mount_opts |= ZONEFS_MNTOPT_ERRORS_REPAIR;
> > -			break;
> > -		case Opt_explicit_open:
> > -			sbi->s_mount_opts |= ZONEFS_MNTOPT_EXPLICIT_OPEN;
> > -			break;
> > -		default:
> > -			return -EINVAL;
> > -		}
> > +static int zonefs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> > +{
> > +	struct zonefs_context *ctx = fc->fs_private;
> > +	struct fs_parse_result result;
> > +	int opt;
> > +
> > +	opt = fs_parse(fc, zonefs_param_spec, param, &result);
> > +	if (opt < 0)
> > +		return opt;
> > +
> > +	switch (opt) {
> > +	case Opt_errors:
> > +		ctx->s_mount_opts &= ~ZONEFS_MNTOPT_ERRORS_MASK;
> > +		ctx->s_mount_opts |= result.uint_32;
> > +		break;
> > +	case Opt_explicit_open:
> > +		ctx->s_mount_opts |= ZONEFS_MNTOPT_EXPLICIT_OPEN;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> >  	}
> >  
> >  	return 0;
> > @@ -533,11 +522,19 @@ static int zonefs_show_options(struct seq_file *seq, struct dentry *root)
> >  	return 0;
> >  }
> >  
> > -static int zonefs_remount(struct super_block *sb, int *flags, char *data)
> > +static int zonefs_get_tree(struct fs_context *fc);
> 
> Why the forward definition ? It seems that you could define this function here
> directly.
> 
> > +
> > +static int zonefs_reconfigure(struct fs_context *fc)
> >  {
> > -	sync_filesystem(sb);
> > +	struct zonefs_context *ctx = fc->fs_private;
> > +	struct super_block *sb = fc->root->d_sb;
> > +	struct zonefs_sb_info *sbi = sb->s_fs_info;
> >  
> > -	return zonefs_parse_options(sb, data);
> > +	sync_filesystem(fc->root->d_sb);
> > +	/* Copy new options from ctx into sbi. */
> > +	sbi->s_mount_opts = ctx->s_mount_opts;
> > +
> > +	return 0;
> >  }
> >  
> >  static int zonefs_inode_setattr(struct mnt_idmap *idmap,
> > @@ -1197,7 +1194,6 @@ static const struct super_operations zonefs_sops = {
> >  	.alloc_inode	= zonefs_alloc_inode,
> >  	.free_inode	= zonefs_free_inode,
> >  	.statfs		= zonefs_statfs,
> > -	.remount_fs	= zonefs_remount,
> >  	.show_options	= zonefs_show_options,
> >  };
> >  
> > @@ -1242,9 +1238,10 @@ static void zonefs_release_zgroup_inodes(struct super_block *sb)
> >   * sub-directories and files according to the device zone configuration and
> >   * format options.
> >   */
> > -static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
> > +static int zonefs_fill_super(struct super_block *sb, struct fs_context *fc)
> >  {
> >  	struct zonefs_sb_info *sbi;
> > +	struct zonefs_context *ctx = fc->fs_private;
> >  	struct inode *inode;
> >  	enum zonefs_ztype ztype;
> >  	int ret;
> > @@ -1281,21 +1278,17 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
> >  	sbi->s_uid = GLOBAL_ROOT_UID;
> >  	sbi->s_gid = GLOBAL_ROOT_GID;
> >  	sbi->s_perm = 0640;
> > -	sbi->s_mount_opts = ZONEFS_MNTOPT_ERRORS_RO;
> > -
> > +	sbi->s_mount_opts = ctx->s_mount_opts;
> 
> Please keep the white line here...
> 
> >  	atomic_set(&sbi->s_wro_seq_files, 0);
> >  	sbi->s_max_wro_seq_files = bdev_max_open_zones(sb->s_bdev);
> >  	atomic_set(&sbi->s_active_seq_files, 0);
> > +
> 
> ...and remove this one. The initializations here are "grouped" together byt
> "theme" (sbi standard stuff first and zone resource accounting in a second
> "paragraph". I like to keep it that way.
> 
> >  	sbi->s_max_active_seq_files = bdev_max_active_zones(sb->s_bdev);
> >  
> >  	ret = zonefs_read_super(sb);
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = zonefs_parse_options(sb, data);
> > -	if (ret)
> > -		return ret;
> > -
> >  	zonefs_info(sb, "Mounting %u zones", bdev_nr_zones(sb->s_bdev));
> >  
> >  	if (!sbi->s_max_wro_seq_files &&
> > @@ -1356,12 +1349,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
> >  	return ret;
> >  }
> >  
> > -static struct dentry *zonefs_mount(struct file_system_type *fs_type,
> > -				   int flags, const char *dev_name, void *data)
> > -{
> > -	return mount_bdev(fs_type, flags, dev_name, data, zonefs_fill_super);
> > -}
> > -
> >  static void zonefs_kill_super(struct super_block *sb)
> >  {
> >  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> > @@ -1376,17 +1363,54 @@ static void zonefs_kill_super(struct super_block *sb)
> >  	kfree(sbi);
> >  }
> >  
> > +static void zonefs_free_fc(struct fs_context *fc)
> > +{
> > +	struct zonefs_context *ctx = fc->fs_private;
> 
> I do not think you need this variable.
> 
> > +
> > +	kfree(ctx);
> 
> Is it safe to not set fc->fs_private to NULL ?

I agree that ctx is not needed, and instead kfree(fc->fs_private) is
sufficient. However, since other fs conversions do not simply set
fc->fs_private to NULL, kfree(fc_fs_private) is preferred here.

> 
> > +}
> > +
> > +static const struct fs_context_operations zonefs_context_ops = {
> > +	.parse_param    = zonefs_parse_param,
> > +	.get_tree       = zonefs_get_tree,
> > +	.reconfigure	= zonefs_reconfigure,
> > +	.free           = zonefs_free_fc,
> > +};
> > +
> > +/*
> > + * Set up the filesystem mount context.
> > + */
> > +static int zonefs_init_fs_context(struct fs_context *fc)
> > +{
> > +	struct zonefs_context *ctx;
> > +
> > +	ctx = kzalloc(sizeof(struct zonefs_context), GFP_KERNEL);
> > +	if (!ctx)
> > +		return 0;
> 
> return 0 ? Shouldn't this be "return -ENOMEM" ?
> 
> > +	ctx->s_mount_opts = ZONEFS_MNTOPT_ERRORS_RO;
> > +	fc->ops = &zonefs_context_ops;
> > +	fc->fs_private = ctx;
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * File system definition and registration.
> >   */
> >  static struct file_system_type zonefs_type = {
> >  	.owner		= THIS_MODULE,
> >  	.name		= "zonefs",
> > -	.mount		= zonefs_mount,
> >  	.kill_sb	= zonefs_kill_super,
> >  	.fs_flags	= FS_REQUIRES_DEV,
> > +	.init_fs_context	= zonefs_init_fs_context,
> > +	.parameters	= zonefs_param_spec,
> 
> Please re-align everything together.
> 
> >  };
> >  
> > +static int zonefs_get_tree(struct fs_context *fc)
> > +{
> > +	return get_tree_bdev(fc, zonefs_fill_super);
> > +}
> > +
> >  static int __init zonefs_init_inodecache(void)
> >  {
> >  	zonefs_inode_cachep = kmem_cache_create("zonefs_inode_cache",
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 


