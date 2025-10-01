Return-Path: <linux-fsdevel+bounces-63173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5E0BB059F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 14:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CB74C0405
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 12:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961302EB84B;
	Wed,  1 Oct 2025 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qc0wqb4q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o47yNtek";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qc0wqb4q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o47yNtek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EA22EACF6
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321596; cv=none; b=gL7FJGlN3pRIJ/JoeHp6fyPojEhVk5O68lme5tXx95YE5FA5pyiJTJSPkn1RokHBnUVOJ/T8zsVsAnCTxybKcLjKQMnVixwHdB1HOXagoISoUpRXTFm1Iuvr35HfWSf4IgzmIQBbOioyeU2e8tZVuborU3R5Tz7/PrNEPUqRmfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321596; c=relaxed/simple;
	bh=Y2lOccTT6DHYE1YxsduTzoZeS06ygXIVnQ/arTuWchQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUa9sQ1Tx1ScXuTycFhIebmykjcuCwvka2klJsIUOhuym8SD5ixoR0bDfI2p1U//sBmNk5Wbn4AsBAGCtVDr4jLerUjiPyQTi03GTCcNes3CGn4g3jVZZc1Y9xTiYHPuF5dthfHhq0oU9zWuVh6vCcinvt6a9x7Z5UqOrtdY0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qc0wqb4q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o47yNtek; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qc0wqb4q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o47yNtek; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 292741F80F;
	Wed,  1 Oct 2025 12:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759321591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4ZI2Tw0qp+ZL8CdEKa6XhK0mA/qTvAEXVyDVeiKM34=;
	b=qc0wqb4qK6ljg8zCjrP842ipgPTACcGTVPh+L7fZIvgVzS9Q9iOnvs3+xErscazP9ursxe
	8gNewe6lRSix4OcmR+34eAIe0b9J8RyYyjnewQxg/Rx0DPpxPFBm3Q0PJ4w4I1BPK5J3wU
	n9t6CtScxiKd6YNlaVAvIZvwxn+2M8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759321591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4ZI2Tw0qp+ZL8CdEKa6XhK0mA/qTvAEXVyDVeiKM34=;
	b=o47yNtekbfbORhcvHglmybgkxa1cGObNuz3nbil4DoWLkLXq9uYKMNDd5BZKI9chulxyla
	Q12uaaZZay5x41AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759321591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4ZI2Tw0qp+ZL8CdEKa6XhK0mA/qTvAEXVyDVeiKM34=;
	b=qc0wqb4qK6ljg8zCjrP842ipgPTACcGTVPh+L7fZIvgVzS9Q9iOnvs3+xErscazP9ursxe
	8gNewe6lRSix4OcmR+34eAIe0b9J8RyYyjnewQxg/Rx0DPpxPFBm3Q0PJ4w4I1BPK5J3wU
	n9t6CtScxiKd6YNlaVAvIZvwxn+2M8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759321591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4ZI2Tw0qp+ZL8CdEKa6XhK0mA/qTvAEXVyDVeiKM34=;
	b=o47yNtekbfbORhcvHglmybgkxa1cGObNuz3nbil4DoWLkLXq9uYKMNDd5BZKI9chulxyla
	Q12uaaZZay5x41AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AAB013A42;
	Wed,  1 Oct 2025 12:26:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wLF6Bvcd3WjZfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Oct 2025 12:26:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A5D45A0A2D; Wed,  1 Oct 2025 14:26:30 +0200 (CEST)
Date: Wed, 1 Oct 2025 14:26:30 +0200
From: Jan Kara <jack@suse.cz>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
Subject: Re: [PATCH] isofs: fix inode leak caused by disconnected dentries
 from exportfs
Message-ID: <okjvr65bw4u3ird44qfzuby2dptgn7bs74wsijq2jpj73ydlus@clx3fwq63nrt>
References: <20251001094310.1672933-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001094310.1672933-1-kartikey406@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	URIBL_BLOCKED(0.00)[appspotmail.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[1d79ebe5383fc016cf07];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Wed 01-10-25 15:13:10, Deepanshu Kartikey wrote:
> When open_by_handle_at() is used with iso9660 filesystems, exportfs
> creates disconnected dentries during file handle resolution. If the
> operation fails (e.g., with -ESTALE during reconnect_path()), these
> dentries remain cached with their associated inodes.
> 
> During unmount, shrink_dcache_for_umount() does not fully evict these
> disconnected dentries, leaving their inodes with non-zero reference
> counts. This triggers the "VFS: Busy inodes after unmount" warning
> and causes inode leaks that accumulate across mount/unmount cycles.
> 
> The issue occurs because:
> 1. open_by_handle_at() calls exportfs_decode_fh_raw() to resolve
>    file handles
> 2. For iso9660 with Joliet extensions, this creates disconnected
>    dentries for both primary (iso9660) and secondary (Joliet) root
>    inodes
> 3. When path reconnection fails with -ESTALE, the dentries are left
>    in DCACHE_DISCONNECTED state

True, but when reconnection fails, exportfs_decode_fh_raw() calls dput() on
the created dentry and dput() immediately destroys DCACHE_DISCONNECTED
dentries. So I'm not following how these dentries could still survive until
umount(). Can you please explain?

> 4. shrink_dcache_for_umount() in generic_shutdown_super() does not
>    aggressively evict these disconnected dentries
> 5. The associated inodes (typically root inodes 1792 and 1807)
>    remain with i_count=1, triggering the busy inode check
> 
> Add explicit shrink_dcache_sb() call in isofs_put_super() to ensure
> all cached dentries, including disconnected ones created by exportfs
> operations, are released before the superblock is destroyed.

This is almost certainly a wrong way of fixing the problem. First we need
to better understand why DCACHE_DISCONNECTED aren't getting properly
evicted...

								Honza

> 
> Reported-by: syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
> Tested-by: syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/isofs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
> index 6f0e6b19383c..bee410705442 100644
> --- a/fs/isofs/inode.c
> +++ b/fs/isofs/inode.c
> @@ -52,6 +52,7 @@ static int isofs_dentry_cmp_ms(const struct dentry *dentry,
>  static void isofs_put_super(struct super_block *sb)
>  {
>  	struct isofs_sb_info *sbi = ISOFS_SB(sb);
> +	shrink_dcache_sb(sb);
>  
>  #ifdef CONFIG_JOLIET
>  	unload_nls(sbi->s_nls_iocharset);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

