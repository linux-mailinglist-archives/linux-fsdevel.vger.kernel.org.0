Return-Path: <linux-fsdevel+bounces-30037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE7A985491
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 09:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942831F22E44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 07:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211FE157490;
	Wed, 25 Sep 2024 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BEtKj0PY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SY2EILmz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1GsAthUc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qxgGRju6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D491514FB;
	Wed, 25 Sep 2024 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250672; cv=none; b=PdsC/hd2fjVRxowSWqrRnSv51XcNW1RqOuw4PfQpECCo5WT1j3+MSVcQuuelq8N+VO0PDDpruu9EkimmN3C8HsZckNHx+o6XAbAE2+XMkl9P331TuDmZKitwJamm+mYYLA8DI6G8NWWWoROCwizciyC+gZrfPkB3SPp3ap+9q3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250672; c=relaxed/simple;
	bh=P6EM7CjUmudXu24m5a5KMuNB4z4035P8is3WYIMEwyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/SBbQG8eoRB/WgjEwcRZ33cff165yrPvoGZfVpQTtXjLhKrMhJnELhiBKkM9B/DwmEtbAxXxhOOWe8SeIkjpyd3dnrG5Uq7Vt9+4RyvZ+UJjReWKFY2ob6bL5tEmFe2wh3lGTCAPSNs0mUegLV5vQz/qIauapEeUz6AMo3Xgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BEtKj0PY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SY2EILmz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1GsAthUc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qxgGRju6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 622EB1FD32;
	Wed, 25 Sep 2024 07:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727250667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7tZKvELgP2CV3ZxG3iamR09vzvAr4dxu7WWEjB/ZSec=;
	b=BEtKj0PYj/l/RXudDv77VLXZoKiEac+llVXhT5xDKhObYqnnPiScKlvYb99Q3OrMVA0awD
	RZp4/ms3ga4YBwnZ9R/vKjelhWnBnczcUxcmmq9vNy7iOgMasN68JGEVQUwRMsWDcf6Ej5
	3SAbxKFnx8QlqfjncOrPzngW0Cubysg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727250667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7tZKvELgP2CV3ZxG3iamR09vzvAr4dxu7WWEjB/ZSec=;
	b=SY2EILmz4QtpfENT3VpLsc1agqD8FSkj0cglm0KJQFUU4J7wzaS/dnMLwX+gLW9rRNIc2U
	I8f5djUm/hHnbrAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727250666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7tZKvELgP2CV3ZxG3iamR09vzvAr4dxu7WWEjB/ZSec=;
	b=1GsAthUc4ib/D9fqh2YRu6DDcVSBk/0IWBG+QdkgXZ6Kjy+VCJYUQgan5fUjeE6wZElQCz
	0A0tBsreYmshCJus7hhzd7Q9yB56O71+h0zzaIZZxk5oI1PYTVRAyVwDMQFr6I+WBpUSpX
	PLqF7ig6llj668HoWiMSES+VjCRP85E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727250666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7tZKvELgP2CV3ZxG3iamR09vzvAr4dxu7WWEjB/ZSec=;
	b=qxgGRju6AxZxkT4vg4nH4w84dWpYiq4H+WV1KaLvo9HNVGfgJDMPQ0+P0GMrmK8mQEpfMQ
	JKSfIk7I9oyQGwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 551CD13A6A;
	Wed, 25 Sep 2024 07:51:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 46x3FOrA82aRdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Sep 2024 07:51:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0AD5EA08A7; Wed, 25 Sep 2024 09:51:06 +0200 (CEST)
Date: Wed, 25 Sep 2024 09:51:05 +0200
From: Jan Kara <jack@suse.cz>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chris.zjh@huawei.com
Subject: Re: [PATCH v2] fs: ext4: support relative path for `journal_path` in
 mount option.
Message-ID: <20240925075105.lnssx7gcgfh5s743@quack3>
References: <20240925015624.3817878-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925015624.3817878-1-lihongbo22@huawei.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 25-09-24 09:56:24, Hongbo Li wrote:
> The `fs_lookup_param` did not consider the relative path for
> block device. When we mount ext4 with `journal_path` option using
> relative path, `param->dirfd` was not set which will cause mounting
> error.
> 
> This can be reproduced easily like this:
> 
> mke2fs -F -O journal_dev $JOURNAL_DEV -b 4096 100M
> mkfs.ext4 -F -J device=$JOURNAL_DEV -b 4096 $FS_DEV
> cd /dev; mount -t ext4 -o journal_path=`basename $JOURNAL_DEV` $FS_DEV $MNT
> 
> Fixes: 461c3af045d3 ("ext4: Change handle_mount_opt() to use fs_parameter")
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
> v2:
>   - Change the journal_path parameter as string not bdev, and
>     determine the relative path situation inside fs_lookup_param.
>   - Add Suggested-by.
> 
> v1: https://lore.kernel.org/all/20240527-mahlen-packung-3fe035ab390d@brauner/
> ---
>  fs/ext4/super.c | 4 ++--
>  fs/fs_parser.c  | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16a4ce704460..cd23536ce46e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1744,7 +1744,7 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
>  	fsparam_u32	("min_batch_time",	Opt_min_batch_time),
>  	fsparam_u32	("max_batch_time",	Opt_max_batch_time),
>  	fsparam_u32	("journal_dev",		Opt_journal_dev),
> -	fsparam_bdev	("journal_path",	Opt_journal_path),
> +	fsparam_string	("journal_path",	Opt_journal_path),

Why did you change this? As far as I can see the only effect would be that
empty path will not be allowed (which makes sense) but that seems like an
independent change which would deserve a comment in the changelog? Or am I
missing something?

>  	fsparam_flag	("journal_checksum",	Opt_journal_checksum),
>  	fsparam_flag	("nojournal_checksum",	Opt_nojournal_checksum),
>  	fsparam_flag	("journal_async_commit",Opt_journal_async_commit),
> @@ -2301,7 +2301,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  			return -EINVAL;
>  		}
>  
> -		error = fs_lookup_param(fc, param, 1, LOOKUP_FOLLOW, &path);
> +		error = fs_lookup_param(fc, param, true, LOOKUP_FOLLOW, &path);
>  		if (error) {
>  			ext4_msg(NULL, KERN_ERR, "error: could not find "
>  				 "journal device path");
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index 24727ec34e5a..2ae296764b69 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -156,6 +156,9 @@ int fs_lookup_param(struct fs_context *fc,
>  		f = getname_kernel(param->string);
>  		if (IS_ERR(f))
>  			return PTR_ERR(f);
> +		/* for relative path */
> +		if (f->name[0] != '/')
> +			param->dirfd = AT_FDCWD;

What Al meant is that you can do simply:
		param->dirfd = AT_FDCWD;

and everything will work the same because 'dfd' is ignored for absolute
pathnames in path_init().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

