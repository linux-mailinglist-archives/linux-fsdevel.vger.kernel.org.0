Return-Path: <linux-fsdevel+bounces-42664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7ECA4589B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7095F188AD29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A2F224242;
	Wed, 26 Feb 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e31grfa8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03E20AF73
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559224; cv=none; b=U16c9XpfTZh/N2zK0UtaVqmnbjAxRi4Z01OL7UIrFO1R4PBsEK/zJq6uG6XIIWf2zk+Fd1+upIV02Nsk+d/emGCGlWZWVW+jBtLSUI1DYCfpziLII0kL1kGqBL0eY2G9Vs+rgmnSraR2ZLvFm1XmjgTljAVcyYrg3zeczspcE5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559224; c=relaxed/simple;
	bh=P82lKlUp5mhB/W+wpQ6LFt1fMUQB+NjN0Q9oo1W5Gmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiKcw9qD6dPa8LTB1fEs6p+nQLko1Lq08dcfNov/PosSYbPBf58V2zbVsJ3z01AZq917hBovu9pJ+VBqLvxR2vhEHaEdi1vt0dHwgllxWs8KSqyDYFv9RIrcNrFTqKk0xsWX87mLBn0BrVXlvu7S8LWe5qyFCV+FLijm8k8A/8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e31grfa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02006C4CEE2;
	Wed, 26 Feb 2025 08:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559224;
	bh=P82lKlUp5mhB/W+wpQ6LFt1fMUQB+NjN0Q9oo1W5Gmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e31grfa8yK0MCrQhPP8hpUkTfZIWN0cH2ns39ayPpqbAD2DxJQFNykoloxZjRPVgn
	 EoVRveGl6LzLz96icCIkUqf4PJ9JUjlXNrcM6Nb3vQj/9QlgcEJBPMeDpYU02RT7xz
	 SQSc/rB1/zTFZZukb00yyKMuEfYAMaO0uHGIzN4r/z8PCEq1McLZgDiaK6Ehj8k4Ec
	 zzApTIiFLLlTZDXKoFLj8YvaWUJfZf+KnnNpP+8NOsYzv783umv2xZeG5JFwbqK3i/
	 080XtNFPM0/Wdp5gdMWt0O6sF0ru5DxD2Cjal+q1g8PBbujmU7DllW9XmLSpjWepTH
	 yFIlK7v6NjyEA==
Date: Wed, 26 Feb 2025 09:40:20 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 18/21] efivarfs: use DCACHE_DONTCACHE instead of
 always_delete_dentry()
Message-ID: <20250226-pfeifen-ausarbeiten-402b43e78b5b@brauner>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-18-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224212051.1756517-18-viro@zeniv.linux.org.uk>

On Mon, Feb 24, 2025 at 09:20:48PM +0000, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/efivarfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 3f3188e0cfa7..e5d3147cfcea 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -175,7 +175,6 @@ static int efivarfs_d_hash(const struct dentry *dentry, struct qstr *qstr)
>  static const struct dentry_operations efivarfs_d_ops = {
>  	.d_compare = efivarfs_d_compare,
>  	.d_hash = efivarfs_d_hash,
> -	.d_delete = always_delete_dentry,
>  };
>  
>  static struct dentry *efivarfs_alloc_dentry(struct dentry *parent, char *name)
> @@ -346,6 +345,7 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_magic             = EFIVARFS_MAGIC;
>  	sb->s_op                = &efivarfs_ops;
>  	set_default_d_op(sb, &efivarfs_d_ops);
> +	sb->s_d_flags |= DCACHE_DONTCACHE;
>  	sb->s_time_gran         = 1;
>  
>  	if (!efivar_supports_writes())
> -- 
> 2.39.5
> 

