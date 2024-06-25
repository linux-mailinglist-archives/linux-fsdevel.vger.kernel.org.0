Return-Path: <linux-fsdevel+bounces-22340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C4D9167D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 14:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB531F26EEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DF7156899;
	Tue, 25 Jun 2024 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fUwshDz3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LHGjjM0l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fUwshDz3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LHGjjM0l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD404149DE2
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318539; cv=none; b=KLufgIsJJnpOeZ40dpYbl/+hTH3nyiT5h6m7T6tzAy9yabbz8UAISOPV+oeVIoTSpp1I8aK3wOZ/F4UDw/wD/Eo7Wtc4EGVhFw+dSD4Lm+Hg8nZhsebqtVBOAN8TH/rdLybd9/sHqnPcJvMaa8VTdeUvty6mBb1KDmqLFLbVbBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318539; c=relaxed/simple;
	bh=Gz+GLNANtsjWa0AX98H0jJPLvOLew2o1NMaP49qsIY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlJGgNETma9WHBZvikdg+V3X1wb64uS2Y1haBdvW7Qgghz/rULd9uDBIPZ0JNbvM4IR7xW7BQKUQwBC25+/e36FFq0o0VLz8qP3TP6aNbSGH6nE4kBScUqx7mYO8giyJpVM00TFpxGScfHA1StTPE5Z0KyYqPJg1BGzwdC1NMs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fUwshDz3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LHGjjM0l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fUwshDz3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LHGjjM0l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B54FF1F854;
	Tue, 25 Jun 2024 12:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719318535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXihO1FqpoFrazesHOZkpnl/kuRxoBEv255iNaqbl+8=;
	b=fUwshDz3LLfFsNp1gmwduPH7RxrJ7orecBQhrprNoHLBwFpHes85S3lmrQGTd0G1SOf7J7
	/I9GRLQ/TUr+3tUPAH/dCvEbuB+wuEXRll/hlFTBY/ORBv7vomryNajML+5o2A8cDB3RPh
	IAldRzBXrkNc9tNFeXYPgHl/vKwzWMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719318535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXihO1FqpoFrazesHOZkpnl/kuRxoBEv255iNaqbl+8=;
	b=LHGjjM0lPhIpodcn4ZAmURtjDWbNbIQtQSAJYVscB579lYs7NBweoNx0AMqgORANgiohm7
	iGPFgQvc6utapXBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fUwshDz3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LHGjjM0l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719318535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXihO1FqpoFrazesHOZkpnl/kuRxoBEv255iNaqbl+8=;
	b=fUwshDz3LLfFsNp1gmwduPH7RxrJ7orecBQhrprNoHLBwFpHes85S3lmrQGTd0G1SOf7J7
	/I9GRLQ/TUr+3tUPAH/dCvEbuB+wuEXRll/hlFTBY/ORBv7vomryNajML+5o2A8cDB3RPh
	IAldRzBXrkNc9tNFeXYPgHl/vKwzWMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719318535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XXihO1FqpoFrazesHOZkpnl/kuRxoBEv255iNaqbl+8=;
	b=LHGjjM0lPhIpodcn4ZAmURtjDWbNbIQtQSAJYVscB579lYs7NBweoNx0AMqgORANgiohm7
	iGPFgQvc6utapXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A99DA1384C;
	Tue, 25 Jun 2024 12:28:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PSJjKQe4emYuBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 12:28:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 59FC2A087F; Tue, 25 Jun 2024 14:28:51 +0200 (CEST)
Date: Tue, 25 Jun 2024 14:28:51 +0200
From: Jan Kara <jack@suse.cz>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs: fsconfig: intercept non-new mount API in advance
 for FSCONFIG_CMD_CREATE_EXCL command
Message-ID: <20240625122851.hpswxrq4kwt64der@quack3>
References: <20240625121831.1833081-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625121831.1833081-1-lihongbo22@huawei.com>
X-Rspamd-Queue-Id: B54FF1F854
X-Spam-Score: -3.99
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-2.98)[99.92%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue 25-06-24 20:18:31, Hongbo Li wrote:
> fsconfig with FSCONFIG_CMD_CREATE_EXCL command requires the new mount api,
> here we should return -EOPNOTSUPP in advance to avoid extra procedure.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

The patch is already in VFS tree:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.misc&id=ef44c8ab06b300a5b9b30e5b630f491ac7bc4d3e

It just didn't reach Linus' tree yet because it is not urgent fix.

								Honza

> ---
> v3:
>   - Add reviewed-by.
> 
> v2: https://lore.kernel.org/all/20240522030422.315892-1-lihongbo22@huawei.com/
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

