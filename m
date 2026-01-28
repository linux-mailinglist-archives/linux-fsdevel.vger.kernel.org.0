Return-Path: <linux-fsdevel+bounces-75708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKDdLNLeeWnI0QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 11:02:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BC89F2D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 11:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C27743051497
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1389834DB57;
	Wed, 28 Jan 2026 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lm+geycE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1BADMmB8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lm+geycE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1BADMmB8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8734D912
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594397; cv=none; b=ZgVGHi8mrqQ1hgACu7DEsXHmQ1W4+ZKHLt+csjF4Q0lwbqxnouFPbA9/1q4gCYvru5QHN2O9GVqBiMp7/Mrxa9Bkl+CU36nPVdju19Awu81LpNo01T64o6Uo1U/mQV/nz+mbBJE+BmSONCMTxtGDyNND4KXhalxrrFFd1P8aa8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594397; c=relaxed/simple;
	bh=xV1vYChwhYRmc/bF7XwFJ8ZSFp7wEcfpN9syg+o06Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhIa6CFKg4VjKvvgqIBuitFTmN9osdv/jQuKcmTHioLThsLQLEKHOK8l5XWmoQ4Lq8gUZbQWTgXfoPlOH0P5SA+962CormWOhf9qZNesrV9x4w36pO0d0F0PU1364OmeVaNDfJbyVgXu/VsCewZdf9Ysq3d/Wzo0D6xFVVmufZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lm+geycE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1BADMmB8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lm+geycE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1BADMmB8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E7BA5BCDF;
	Wed, 28 Jan 2026 09:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769594394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5a0VbQCrSFMhLlj8sFch50B6xVZhARSEZpCYRhnc7o=;
	b=lm+geycEfFRyCrpurGiNtDnVXVr5PcbNpGv0lyEXNXAadPpUvECRWNndQC74XYITNxP8bX
	/CoYecElGMr8edw+0pwZ9UUNRSZymLP+DEG46Q/jDLVTRyD5mGu/h+YAZwUe4BXj/omRuD
	TZGNCzprEAxX3N7Wd4HxOnwsdh93OLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769594394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5a0VbQCrSFMhLlj8sFch50B6xVZhARSEZpCYRhnc7o=;
	b=1BADMmB8KT0Is5gjli39JUNkHUrsxWdsHhBizrfTyZyYevP2i152B3HosO17PKmvrpdi68
	zRaGbWE410UBG2CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lm+geycE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1BADMmB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769594394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5a0VbQCrSFMhLlj8sFch50B6xVZhARSEZpCYRhnc7o=;
	b=lm+geycEfFRyCrpurGiNtDnVXVr5PcbNpGv0lyEXNXAadPpUvECRWNndQC74XYITNxP8bX
	/CoYecElGMr8edw+0pwZ9UUNRSZymLP+DEG46Q/jDLVTRyD5mGu/h+YAZwUe4BXj/omRuD
	TZGNCzprEAxX3N7Wd4HxOnwsdh93OLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769594394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5a0VbQCrSFMhLlj8sFch50B6xVZhARSEZpCYRhnc7o=;
	b=1BADMmB8KT0Is5gjli39JUNkHUrsxWdsHhBizrfTyZyYevP2i152B3HosO17PKmvrpdi68
	zRaGbWE410UBG2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14B143EA61;
	Wed, 28 Jan 2026 09:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qe8GBRreeWlkdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Jan 2026 09:59:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C66FEA0A1B; Wed, 28 Jan 2026 10:59:53 +0100 (CET)
Date: Wed, 28 Jan 2026 10:59:53 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com, yizhang089@gmail.com, 
	libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH] ext4: do not check fast symlink during orphan recovery
Message-ID: <ardxpk4lmdigmoren3o4gz6stg36vfywdpu5p24t56mlsjrhgo@buwmke3azxba>
References: <20260128021609.4061686-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128021609.4061686-1-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75708-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,huawei.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,huawei.com,fnnas.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 03BC89F2D8
X-Rspamd-Action: no action

On Wed 28-01-26 10:16:09, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Commit '5f920d5d6083 ("ext4: verify fast symlink length")' causes the
> generic/475 test to fail during orphan cleanup of zero-length symlinks.
> 
>   generic/475  84s ... _check_generic_filesystem: filesystem on /dev/vde is inconsistent
> 
> The fsck reports are provided below:
> 
>   Deleted inode 9686 has zero dtime.
>   Deleted inode 158230 has zero dtime.
>   ...
>   Inode bitmap differences:  -9686 -158230
>   Orphan file (inode 12) block 13 is not clean.
>   Failed to initialize orphan file.
> 
> In ext4_symlink(), a newly created symlink can be added to the orphan
> list due to ENOSPC. Its data has not been initialized, and its size is
> zero. Therefore, we need to disregard the length check of the symbolic
> link when cleaning up orphan inodes.
> 
> Fixes: 5f920d5d6083 ("ext4: verify fast symlink length")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks for the patch!

> @@ -6079,18 +6079,22 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  			inode->i_op = &ext4_encrypted_symlink_inode_operations;
>  		} else if (ext4_inode_is_fast_symlink(inode)) {
>  			inode->i_op = &ext4_fast_symlink_inode_operations;
> -			if (inode->i_size == 0 ||
> -			    inode->i_size >= sizeof(ei->i_data) ||
> -			    strnlen((char *)ei->i_data, inode->i_size + 1) !=
> -								inode->i_size) {
> -				ext4_error_inode(inode, function, line, 0,
> -					"invalid fast symlink length %llu",
> -					 (unsigned long long)inode->i_size);
> -				ret = -EFSCORRUPTED;
> -				goto bad_inode;
> +
> +			/* Orphan cleanup can get a zero-sized symlink. */

I was mulling over this for a while. I'd expand the comment here a bit:

			/*
			 * Orphan cleanup can see inodes with i_size == 0
			 * and i_data uninitialized. Skip size checks in
			 * that case. This is safe because the first thing
			 * ext4_evict_inode() does for fast symlinks is
			 * clearing of i_data and i_size.
			 */

and I think we also need to verify that i_nlink is 0 (as otherwise we'd
leave potentially invalid accessible inode in cache).

								Honza

> +			if (!(EXT4_SB(sb)->s_mount_state & EXT4_ORPHAN_FS)) {
> +				if (inode->i_size == 0 ||
> +				    inode->i_size >= sizeof(ei->i_data) ||
> +				    strnlen((char *)ei->i_data, inode->i_size + 1) !=
> +						inode->i_size) {
> +					ext4_error_inode(inode, function, line, 0,
> +						"invalid fast symlink length %llu",
> +						(unsigned long long)inode->i_size);
> +					ret = -EFSCORRUPTED;
> +					goto bad_inode;
> +				}
> +				inode_set_cached_link(inode, (char *)ei->i_data,
> +						      inode->i_size);
>  			}
> -			inode_set_cached_link(inode, (char *)ei->i_data,
> -					      inode->i_size);
>  		} else {
>  			inode->i_op = &ext4_symlink_inode_operations;
>  		}
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

