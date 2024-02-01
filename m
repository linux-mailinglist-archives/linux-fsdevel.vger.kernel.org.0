Return-Path: <linux-fsdevel+bounces-9841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE4B8454F6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E53C1C23D03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2A715B102;
	Thu,  1 Feb 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bK9qqF3p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQw9TXfH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bK9qqF3p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQw9TXfH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9FE15B979;
	Thu,  1 Feb 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782433; cv=none; b=lSeLIgDtOEcpk76Suvf4EBYdy9NvlV5oyG9zIFfrExcldRVTo++Ow8gzxBo01q617TMD1rAfSw42KFhkvzECdTcajUa/8dmJ3FJrU9vsnk4wnqziw/wIlHCuX0fyGtvauMrzYh709T6fNvCoHq3PyCY/AWEbtdppLZ4uDDgmnuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782433; c=relaxed/simple;
	bh=7hO+wcWI20D7BmU7DB57mrpycK5In4oGq2Vj9Wfqves=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rndYrC9W6L+5l81rqKCpBvAwDrYO9kEMh5tQloux/J5/MLmNjNlGH1FFeM0S/dF72czJ5uaeuUAAzO/aZ5E/73LW7+5diBU9qBYRNiWNQLL/b5SUGaZtkde4NgWYdsm0NHDaxLQvmolcW0BXS9m5tp32dUTS3OG8ULqAzGsODPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bK9qqF3p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQw9TXfH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bK9qqF3p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQw9TXfH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C5641FB9D;
	Thu,  1 Feb 2024 10:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zPoNQcQ+2B1WYUmgI3lr0iNYHrdj7WOIT75odD/Baw=;
	b=bK9qqF3p7SHyuthEaGsV4G+0od0dUOIDBvUtVOEq6MAAPbSDOK1O3dMVq5OxMpMu5hg/kd
	60W6jRqMzyF5zV87PpJz/eWZ2m2qsgH6i73Ju5zSl+On2mhmqz8aa/wTb+/fTHdIJstJxy
	YVCiY/YNAh21hgMbogh6MKxw0Xvg1Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zPoNQcQ+2B1WYUmgI3lr0iNYHrdj7WOIT75odD/Baw=;
	b=mQw9TXfHc6DgwcBrt8ovTVO7uHmb9ldKkOpC5f05gLT3gvs6mhS98FlMsb25ABq9cIRah1
	PrmslFsN3O5snnBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zPoNQcQ+2B1WYUmgI3lr0iNYHrdj7WOIT75odD/Baw=;
	b=bK9qqF3p7SHyuthEaGsV4G+0od0dUOIDBvUtVOEq6MAAPbSDOK1O3dMVq5OxMpMu5hg/kd
	60W6jRqMzyF5zV87PpJz/eWZ2m2qsgH6i73Ju5zSl+On2mhmqz8aa/wTb+/fTHdIJstJxy
	YVCiY/YNAh21hgMbogh6MKxw0Xvg1Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0zPoNQcQ+2B1WYUmgI3lr0iNYHrdj7WOIT75odD/Baw=;
	b=mQw9TXfHc6DgwcBrt8ovTVO7uHmb9ldKkOpC5f05gLT3gvs6mhS98FlMsb25ABq9cIRah1
	PrmslFsN3O5snnBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 832671329F;
	Thu,  1 Feb 2024 10:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EED+H95uu2VBXQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:13:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47A2AA0809; Thu,  1 Feb 2024 11:13:46 +0100 (CET)
Date: Thu, 1 Feb 2024 11:13:46 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 18/34] bcachefs: port block device access to file
Message-ID: <20240201101346.zjf2owkfbgftnamv@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-18-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-18-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue 23-01-24 14:26:35, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/bcachefs/super-io.c    | 20 ++++++++++----------
>  fs/bcachefs/super_types.h |  2 +-
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
> index d60c7d27a047..ce8cf2d91f84 100644
> --- a/fs/bcachefs/super-io.c
> +++ b/fs/bcachefs/super-io.c
> @@ -142,8 +142,8 @@ void bch2_sb_field_delete(struct bch_sb_handle *sb,
>  void bch2_free_super(struct bch_sb_handle *sb)
>  {
>  	kfree(sb->bio);
> -	if (!IS_ERR_OR_NULL(sb->bdev_handle))
> -		bdev_release(sb->bdev_handle);
> +	if (!IS_ERR_OR_NULL(sb->s_bdev_file))
> +		fput(sb->s_bdev_file);
>  	kfree(sb->holder);
>  	kfree(sb->sb_name);
>  
> @@ -704,22 +704,22 @@ static int __bch2_read_super(const char *path, struct bch_opts *opts,
>  	if (!opt_get(*opts, nochanges))
>  		sb->mode |= BLK_OPEN_WRITE;
>  
> -	sb->bdev_handle = bdev_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> -	if (IS_ERR(sb->bdev_handle) &&
> -	    PTR_ERR(sb->bdev_handle) == -EACCES &&
> +	sb->s_bdev_file = bdev_file_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> +	if (IS_ERR(sb->s_bdev_file) &&
> +	    PTR_ERR(sb->s_bdev_file) == -EACCES &&
>  	    opt_get(*opts, read_only)) {
>  		sb->mode &= ~BLK_OPEN_WRITE;
>  
> -		sb->bdev_handle = bdev_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> -		if (!IS_ERR(sb->bdev_handle))
> +		sb->s_bdev_file = bdev_file_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> +		if (!IS_ERR(sb->s_bdev_file))
>  			opt_set(*opts, nochanges, true);
>  	}
>  
> -	if (IS_ERR(sb->bdev_handle)) {
> -		ret = PTR_ERR(sb->bdev_handle);
> +	if (IS_ERR(sb->s_bdev_file)) {
> +		ret = PTR_ERR(sb->s_bdev_file);
>  		goto out;
>  	}
> -	sb->bdev = sb->bdev_handle->bdev;
> +	sb->bdev = file_bdev(sb->s_bdev_file);
>  
>  	ret = bch2_sb_realloc(sb, 0);
>  	if (ret) {
> diff --git a/fs/bcachefs/super_types.h b/fs/bcachefs/super_types.h
> index 0e5a14fc8e7f..ec784d975f66 100644
> --- a/fs/bcachefs/super_types.h
> +++ b/fs/bcachefs/super_types.h
> @@ -4,7 +4,7 @@
>  
>  struct bch_sb_handle {
>  	struct bch_sb		*sb;
> -	struct bdev_handle	*bdev_handle;
> +	struct file		*s_bdev_file;
>  	struct block_device	*bdev;
>  	char			*sb_name;
>  	struct bio		*bio;
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

