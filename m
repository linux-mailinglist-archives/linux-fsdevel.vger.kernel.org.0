Return-Path: <linux-fsdevel+bounces-76040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKW6EoyegGl2/wIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 13:54:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B88CC844
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 13:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49BEF3031306
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE381B4224;
	Mon,  2 Feb 2026 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qOtBRb8M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F+TTT06b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qOtBRb8M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F+TTT06b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F819E839
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770036688; cv=none; b=uCeij5Avxch8WRcHNUjYlB2esvGUSBoObE4BX+kryUIetI5UuWatF7uoY6q3vzSSADlg/O0KYDS5/lcvv+yw7RWPKfV3AUgKfweC/Va8LMq6c91sUbkSk7vUlhZC/9H7T0vgWxew1PHCXNbqUrU8kv1m9ObQ4MXXKIsk207+ejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770036688; c=relaxed/simple;
	bh=Rmi9fbqyYVLu5YFs9mHQOkJEiYezJ90ad93nF6DF5bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnV+h7ounx8pOQEiwOQsjzkBLxKNZXCLkVSJNPcOOFggUybyZfk2BNEUQr6DVot26izc6o/j7dgd2gVPCE5Df7cE8pIkHSngXl8QEJhVJXfKZA2BPfiJXQ4h0Qp3/9OCs0loP7DWlDqnyq6bDCoCUy8V8Eu0YtOla4i7tmwrynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qOtBRb8M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F+TTT06b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qOtBRb8M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F+TTT06b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DE8E3E719;
	Mon,  2 Feb 2026 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770036685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiMj2ZUH+N+OMxKqetmePeOKgPl4RibYfT9Pkjzu2DU=;
	b=qOtBRb8MZDZl5FzgWyIMDCcBSLvJJAvwr7ocOigaPJXHIX4NtpTyYUzX0bGi9INAIthMnG
	csSluu9tGaVF8xCp1ZuC97M1BfmM1LwLTA0RSP7zV0V63JbbmgM6/5gu04U6jmjEeU1BmU
	xSLZhR3mG3rknfv40/tsVYFXMu6X5rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770036685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiMj2ZUH+N+OMxKqetmePeOKgPl4RibYfT9Pkjzu2DU=;
	b=F+TTT06b63kjAZ9cstZLTfrSF/eXciwaAz2TcWxExtykyqjRKmxyHOyAZ5JBz554Psjx/a
	9iWIzWTuWAjSnGBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770036685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiMj2ZUH+N+OMxKqetmePeOKgPl4RibYfT9Pkjzu2DU=;
	b=qOtBRb8MZDZl5FzgWyIMDCcBSLvJJAvwr7ocOigaPJXHIX4NtpTyYUzX0bGi9INAIthMnG
	csSluu9tGaVF8xCp1ZuC97M1BfmM1LwLTA0RSP7zV0V63JbbmgM6/5gu04U6jmjEeU1BmU
	xSLZhR3mG3rknfv40/tsVYFXMu6X5rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770036685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiMj2ZUH+N+OMxKqetmePeOKgPl4RibYfT9Pkjzu2DU=;
	b=F+TTT06b63kjAZ9cstZLTfrSF/eXciwaAz2TcWxExtykyqjRKmxyHOyAZ5JBz554Psjx/a
	9iWIzWTuWAjSnGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55E2F3EA62;
	Mon,  2 Feb 2026 12:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QuTvFM2dgGlOVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Feb 2026 12:51:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1FC2DA08F8; Mon,  2 Feb 2026 13:51:25 +0100 (CET)
Date: Mon, 2 Feb 2026 13:51:25 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com, yizhang089@gmail.com, 
	libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH v2] ext4: do not check fast symlink during orphan recovery
Message-ID: <2sdp5frarezu3rq2pbg35i3lnlwby3mfnpayv7xnokiarx6qvs@nhus35dvxm3f>
References: <20260131091156.1733648-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131091156.1733648-1-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76040-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim,huawei.com:email,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,huawei.com,fnnas.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 63B88CC844
X-Rspamd-Action: no action

On Sat 31-01-26 17:11:56, Zhang Yi wrote:
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
> link when cleaning up orphan inodes. Instead, we should ensure that the
> nlink count is zero.
> 
> Fixes: 5f920d5d6083 ("ext4: verify fast symlink length")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes since v1:
>  - Improve the comment and add nlink check during orphan cleanup as Jan
>    suggested.
> 
>  fs/ext4/inode.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 129594bf8311..cfb66f7ad3d7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6073,18 +6073,36 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
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
> +			/*
> +			 * Orphan cleanup can see inodes with i_size == 0
> +			 * and i_data uninitialized. Skip size checks in
> +			 * that case. This is safe because the first thing
> +			 * ext4_evict_inode() does for fast symlinks is
> +			 * clearing of i_data and i_size.
> +			 */
> +			if ((EXT4_SB(sb)->s_mount_state & EXT4_ORPHAN_FS)) {
> +				if (inode->i_nlink != 0) {
> +					ext4_error_inode(inode, function, line, 0,
> +						"invalid orphan symlink nlink %d",
> +						inode->i_nlink);
> +					ret = -EFSCORRUPTED;
> +					goto bad_inode;
> +				}
> +			} else {
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

