Return-Path: <linux-fsdevel+bounces-63949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248A9BD2CA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450B1189C47E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FA9261B7F;
	Mon, 13 Oct 2025 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oeF8rY9Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IpA0k+fj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oeF8rY9Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IpA0k+fj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD731547F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355186; cv=none; b=evpN9QykRT6YQJITUD5rGOx5KEiwRJdDBb4FaBKW/OndW+HxJgPLsaR0J/jxpeOA64yjz/hzkW2Vu5gnf7ioQ160e2a9UWegmM7wYI/4FtChvjzIzSEmBCxfKfck7am6/i1q51VottUzG0CuJC/76F3KtmHstJarY2IsEuLMEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355186; c=relaxed/simple;
	bh=MXavbzIDi+BJUHmeTZZcYeENsmg6owbN+HOFlmCbDJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua+/JCy6P1LAxpD8q3fu8YUE8Ha7DoutfrJBV28TUHMYEJ6a0OVu59Psenj2/AyHQ0TQ1alr/jddbtrlXg8zJjOwn1DbTQOZo+eMyGfXfETh26o/g01SdK6YyULolW/uvxaoemtp5Rv2I9WHR+wx8k/ZFe9EsRAOofRVfjJfgpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oeF8rY9Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IpA0k+fj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oeF8rY9Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IpA0k+fj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B3DC61F385;
	Mon, 13 Oct 2025 11:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760355181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FjA3pivDdgLh9qrZtx0E12mcR60zwdtloy+2zU3PjFA=;
	b=oeF8rY9Q/Uvu8apVgpQdJlOswy7dt6UocwzUR/f+RTfPqKYiFHdKQrp+6FmfQF9c6U3/0B
	pICPq7nBPvsZNxODAgH7yZi++Fj49s8yj4UnoeOpx6L4YdqIaIjf5Mhphg7fVPhaDBej8p
	guZHc4SNPIId/TkGmVg3FZLrGrLcVAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760355181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FjA3pivDdgLh9qrZtx0E12mcR60zwdtloy+2zU3PjFA=;
	b=IpA0k+fj4k/tvd6VNkefE1txs1XtfoHuTIEMXxBUf7MHAXbZy0tcwybjvJrMId+YC1NFQP
	t3pkXSodL9ywF8DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oeF8rY9Q;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IpA0k+fj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760355181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FjA3pivDdgLh9qrZtx0E12mcR60zwdtloy+2zU3PjFA=;
	b=oeF8rY9Q/Uvu8apVgpQdJlOswy7dt6UocwzUR/f+RTfPqKYiFHdKQrp+6FmfQF9c6U3/0B
	pICPq7nBPvsZNxODAgH7yZi++Fj49s8yj4UnoeOpx6L4YdqIaIjf5Mhphg7fVPhaDBej8p
	guZHc4SNPIId/TkGmVg3FZLrGrLcVAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760355181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FjA3pivDdgLh9qrZtx0E12mcR60zwdtloy+2zU3PjFA=;
	b=IpA0k+fj4k/tvd6VNkefE1txs1XtfoHuTIEMXxBUf7MHAXbZy0tcwybjvJrMId+YC1NFQP
	t3pkXSodL9ywF8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A546C1374A;
	Mon, 13 Oct 2025 11:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yvhYKG3j7GjRZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Oct 2025 11:33:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5C0D0A0A58; Mon, 13 Oct 2025 13:33:01 +0200 (CEST)
Date: Mon, 13 Oct 2025 13:33:01 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 02/10] 9p: don't opencode filemap_fdatawrite_range in
 v9fs_mmap_vm_close
Message-ID: <5k34nbj3dej7ffoh3ihcqzaaamb43lfef3dyptwlhflzcu6nwq@pnkdrqdiwyx6>
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013025808.4111128-3-hch@lst.de>
X-Rspamd-Queue-Id: B3DC61F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 13-10-25 11:57:57, Christoph Hellwig wrote:
> Use filemap_fdatawrite_range instead of opencoding the logic using
> filemap_fdatawrite_wbc.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/9p/vfs_file.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index eb0b083da269..612a230bc012 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -483,24 +483,15 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
>  
>  static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
>  {
> -	struct inode *inode;
> -
> -	struct writeback_control wbc = {
> -		.nr_to_write = LONG_MAX,
> -		.sync_mode = WB_SYNC_ALL,
> -		.range_start = (loff_t)vma->vm_pgoff * PAGE_SIZE,
> -		 /* absolute end, byte at end included */
> -		.range_end = (loff_t)vma->vm_pgoff * PAGE_SIZE +
> -			(vma->vm_end - vma->vm_start - 1),
> -	};
> -
>  	if (!(vma->vm_flags & VM_SHARED))
>  		return;
>  
>  	p9_debug(P9_DEBUG_VFS, "9p VMA close, %p, flushing", vma);
>  
> -	inode = file_inode(vma->vm_file);
> -	filemap_fdatawrite_wbc(inode->i_mapping, &wbc);
> +	filemap_fdatawrite_range(file_inode(vma->vm_file)->i_mapping,
> +			(loff_t)vma->vm_pgoff * PAGE_SIZE,
> +			(loff_t)vma->vm_pgoff * PAGE_SIZE +
> +				(vma->vm_end - vma->vm_start - 1));
>  }
>  
>  static const struct vm_operations_struct v9fs_mmap_file_vm_ops = {
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

