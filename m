Return-Path: <linux-fsdevel+bounces-20038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B36C8CCD17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 09:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69246B21747
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 07:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA8F13CF89;
	Thu, 23 May 2024 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dkKSJ4z3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r0sO68rL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LRIoinol";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zKz5+Tuc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD233A1BF
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449760; cv=none; b=A2VV42EZdlCh3uipCup88hN5ZpuXzR7iwx4JkwWN0cAoqBvBrRApuZGSdPhTu71ogLHE5lb2gRA3NvbcARycLRS8/G7cUbAEO+Q/bbblgUoAL2VNrTHj3jrcSafdZFQTyR3KsodDFKPwgLhrJt72683OvFhYENSmXC3sRdLXXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449760; c=relaxed/simple;
	bh=WrL1EvlCJrNkv9ASTnMORSkXxvFhzf/9d++DYMsYLtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmTfrPDZSWD97uiLrK+KJywU7tPZ+RRufqMceORNIKgn3/OVARuqHiMrnGuvuRMStGwfkJIpfuV9Nx1nUUY8fzLDObfg/kpVpp3B7FBOCjlS4Cf679CJXxTp4F95yDLLym7oGIiH0hsKnZ5cSQmtQ0LZ8b0FEjvL1X2bu70TLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dkKSJ4z3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r0sO68rL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LRIoinol; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zKz5+Tuc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A08131FFAA;
	Thu, 23 May 2024 07:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716449754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rerjGir8dZ1THcCx+R0zRqJlZz+ZHBoLVD+uT8yKmkc=;
	b=dkKSJ4z3hXj3E3AvRB/qGforsyeu3YrpFaAUA+C9rsrQw0YlluX9S/Vq0ryIZcLSL+tK11
	4N8zulDgDkQEquOz+FYKCGayWqD3ZiPk57k/pzUAoe7qxv9/GgepV3Tyn81GKFjmxcDuih
	RdtIW10iFJHQTVQNewUkdLbu73swZuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716449754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rerjGir8dZ1THcCx+R0zRqJlZz+ZHBoLVD+uT8yKmkc=;
	b=r0sO68rL2dVJJ6nigj2vPgTbJNnWPVgwElZn5suwEFSNENT8G89rYnPSO7P4b6TEEVNNxZ
	iu0M6GCFkPRg85BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716449753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rerjGir8dZ1THcCx+R0zRqJlZz+ZHBoLVD+uT8yKmkc=;
	b=LRIoinolPgEEZeM1o90usvkH99IY3vKcW8BBKTCmwTFyCyVpe8VE5ew6mpxZeXCaGNb9qq
	SaEEb6I2RXtC4qKZnu2XKi0P3lgihXdXw6vGvKAK6aU8Az8HTpNm/3WyTcoPi1yrJxpULw
	rHbJAyFr9pc6QYx0Bnq6Uiuel4RSD74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716449753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rerjGir8dZ1THcCx+R0zRqJlZz+ZHBoLVD+uT8yKmkc=;
	b=zKz5+TucePihV8Rom0Mx5dhUvFTyVvKqGjtw/VXpVlcQMnNaJ41mV4QP6LGLgx2wUFM6C7
	3vZUdwFTlyrMXpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BD3E13A6C;
	Thu, 23 May 2024 07:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lPkeItnxTmalJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 23 May 2024 07:35:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2DC07A0770; Thu, 23 May 2024 09:35:53 +0200 (CEST)
Date: Thu, 23 May 2024 09:35:53 +0200
From: Jan Kara <jack@suse.cz>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: fsconfig: intercept non-new mount API in advance
 for FSCONFIG_CMD_CREATE_EXCL command
Message-ID: <20240523073553.llh6es6zlecblcsh@quack3>
References: <20240522030422.315892-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522030422.315892-1-lihongbo22@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.com:email,suse.cz:email]

On Wed 22-05-24 11:04:22, Hongbo Li wrote:
> fsconfig with FSCONFIG_CMD_CREATE_EXCL command requires the new mount api,
> here we should return -EOPNOTSUPP in advance to avoid extra procedure.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2:
>   - Fix misspelling and change the target branch.
> 
> v1: https://lore.kernel.org/all/20240511062147.3312801-1-lihongbo22@huawei.com/T/
> ---
>  fs/fsopen.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 6593ae518115..18fe979da7e2 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -220,10 +220,6 @@ static int vfs_cmd_create(struct fs_context *fc, bool exclusive)
>  	if (!mount_capable(fc))
>  		return -EPERM;
>  
> -	/* require the new mount api */
> -	if (exclusive && fc->ops == &legacy_fs_context_ops)
> -		return -EOPNOTSUPP;
> -
>  	fc->phase = FS_CONTEXT_CREATING;
>  	fc->exclusive = exclusive;
>  
> @@ -411,6 +407,7 @@ SYSCALL_DEFINE5(fsconfig,
>  		case FSCONFIG_SET_PATH:
>  		case FSCONFIG_SET_PATH_EMPTY:
>  		case FSCONFIG_SET_FD:
> +		case FSCONFIG_CMD_CREATE_EXCL:
>  			ret = -EOPNOTSUPP;
>  			goto out_f;
>  		}
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

