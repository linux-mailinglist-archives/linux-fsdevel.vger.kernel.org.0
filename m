Return-Path: <linux-fsdevel+bounces-63775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6FDBCD928
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5CA34F987E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9BF1799F;
	Fri, 10 Oct 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zIq9ifNG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sKTHNjzP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oHV0vwpv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jZPzR8qo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0242F3601
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107293; cv=none; b=VylkxZMttIFxqj0h5OF9GC0U5vvfYhEijJfnSX6Bfuh+V9HCnmtFOCyxxo0wFJTK9Dxdj12jn4QyIumCqLLiOsbF76rkn1c7lx6PSzObK2TTWJfZOApfE5HEQZ/Be7V3gYaFm2+RKeL4b1iE/PvH1faNbAqvGgwPRBvY3gfc6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107293; c=relaxed/simple;
	bh=sCIUZWQCl8s5LiKfHt4OAO05fKvlszY++fniEl/8m9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzzQH2ZAPq4EU+NEHC4442q/CPKIVyZ7ucZpKx9jk/5r7hJb7L0XX3YRqqG1vfOCHq9ZSu+z6QjzFWkH9ManUY+J6Cafkgsa+OTQbdf3s147NlTjM02nkVZu2XpNzZJkaHKkMzXyVJt2Mm2TgIDkF1NreD9lAy28dPltLXENwQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zIq9ifNG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sKTHNjzP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oHV0vwpv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jZPzR8qo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3B351F397;
	Fri, 10 Oct 2025 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760107290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sh8afuSklgP8R6OwH+PVFLZnr35LOcviwXSRFVPl2go=;
	b=zIq9ifNGGnSWNKuEtdZXODrupBHw7SKGLyE/9DF6feYWqVPLOVdH58Q6IQG54QvcuGrnGh
	moY3UMIa2GbCVoZPnxl1JkDPeVP0ZSXqwZkQCMU9mzszNaHbQEygxiPllL9VI8lTaniJ+g
	IcMN4k+3x37mu4F1aKPlefwFXhqrYHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760107290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sh8afuSklgP8R6OwH+PVFLZnr35LOcviwXSRFVPl2go=;
	b=sKTHNjzPZXtVptWOJw6/vYrdx/KMU2R1ZrqGLnP6Y/7qcKQCDlNHQFlqCv7VZ4kWt2ywEF
	FR7vbxbYOanw7MAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oHV0vwpv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jZPzR8qo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760107289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sh8afuSklgP8R6OwH+PVFLZnr35LOcviwXSRFVPl2go=;
	b=oHV0vwpvPaRjDEAthTPKSTOZ8X/AyboQFA/ngZJ3ce4cJ5MNzKnP+rxSRRMgg1y0vYvguY
	FYRwnpb9hpQUwi9wTOdzCVQnwO+N2+cQFj8Qee6Is+2zexmC4dNHoPr/5SJju7nW9p34Zp
	vj/fjL3eGv4/NU6gAe+OTx4QtOYZFuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760107289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sh8afuSklgP8R6OwH+PVFLZnr35LOcviwXSRFVPl2go=;
	b=jZPzR8qopWB56r0Wf3Kh5BcEG8zxi1YJMX+rscsbH1HrC/KhrfQd8GxGYktmQLmNrIRtC3
	WsBPlzZVG+5CGCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B171613A40;
	Fri, 10 Oct 2025 14:41:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8jZQKxkb6WgqIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 14:41:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 181C9A0A58; Fri, 10 Oct 2025 16:41:28 +0200 (CEST)
Date: Fri, 10 Oct 2025 16:41:28 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 13/14] xfs: use the new ->i_state accessors
Message-ID: <ua3koqbakm6e4dpbzfmhei2evc566c5p2t65nsvmlab5yyibxu@u6zp4pwex5s7>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-14-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-14-mjguzik@gmail.com>
X-Rspamd-Queue-Id: D3B351F397
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Thu 09-10-25 09:59:27, Mateusz Guzik wrote:
> Change generated with coccinelle and fixed up by hand as appropriate.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

...

> @@ -2111,7 +2111,7 @@ xfs_rename_alloc_whiteout(
>  	 */
>  	xfs_setup_iops(tmpfile);
>  	xfs_finish_inode_setup(tmpfile);
> -	VFS_I(tmpfile)->i_state |= I_LINKABLE;
> +	inode_state_set_raw(VFS_I(tmpfile), I_LINKABLE);
>  
>  	*wip = tmpfile;
>  	return 0;
> @@ -2330,7 +2330,7 @@ xfs_rename(
>  		 * flag from the inode so it doesn't accidentally get misused in
>  		 * future.
>  		 */
> -		VFS_I(du_wip.ip)->i_state &= ~I_LINKABLE;
> +		inode_state_clear_raw(VFS_I(du_wip.ip), I_LINKABLE);
>  	}
>  
>  out_commit:

These two accesses look fishy (not your fault but when we are doing this
i_state exercise better make sure all the places are correct before
papering over bugs with _raw function variant). How come they cannot race
with other i_state modifications and thus corrupt i_state?

> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index caff0125faea..ad94fbf55014 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1420,7 +1420,7 @@ xfs_setup_inode(
>  	bool			is_meta = xfs_is_internal_inode(ip);
>  
>  	inode->i_ino = ip->i_ino;
> -	inode->i_state |= I_NEW;
> +	inode_state_set_raw(inode, I_NEW);
>  
>  	inode_sb_list_add(inode);
>  	/* make the inode look hashed for the writeback code */

Frankly, the XFS i_state handling is kind of messy and I suspect we should
be getting i_state == 0 here. But we need to confirm with XFS guys. I'm
poking into this because this is actually the only case where we need
inode_state_set_raw() or inode_state_clear_raw() outside of core VFS and
I'd like to get rid of these functions because IMHO they are actively
dangerous to use.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

