Return-Path: <linux-fsdevel+bounces-46444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A3AA8976B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D451654D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C537527FD66;
	Tue, 15 Apr 2025 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rCb+dbdq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rMTgtWCS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rCb+dbdq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rMTgtWCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4C1E3761
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707931; cv=none; b=Umzq1emGdRf8uBet/qWqrBJ5Fy6u7W/ekKuDUd1r97Ps368Xn0J35GJNRlwWGgIy8zUTmPJqowYz4rjiRfsOYHdHKFJH79tyilqqqPZElVOijgc1iEPXQsCpFEURY24PNhIxSTdTYbWTfbLwe1jWQ37e/IM0slJx5QKiFzORmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707931; c=relaxed/simple;
	bh=akoyEmg5FFAps9x3hqllg39y+pIZnWVgc6aRE+0dVJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9W8otfVA/JJJOpK2Peiwj04Zkos5bufa4PIJHfc9ENL9Aivtet1GIhj/eo3OVyA+eARuLk6Nh0O0E4rVUZ/akufEJfH8/3NHDGIo1xS7ReHMEGPVshfXfStqBtIY9TlZrIKvQ/jmMOP7++PPN74sTzVJPPI22A7Bs/eCpgaklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rCb+dbdq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rMTgtWCS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rCb+dbdq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rMTgtWCS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D584021162;
	Tue, 15 Apr 2025 09:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744707925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gt8X9OwuX4DE3dmRd6541p+mCcrnU8QiPB3p9GbZKFg=;
	b=rCb+dbdq7YVfmZ+K7cSqijtOv4piofNRPNccHTjNTOxFA8mksU3+EdYR85sxmAqYjmWglx
	JJ7hCgiJ30rQ9GLKycfnMOlOzdpxa7SKP3/UdKnTb3mzS6QDpWHN+//o/VYnvV934xxfmW
	hsiFoAGsXTRW5rbADkSmT7Wa3eaLDi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744707925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gt8X9OwuX4DE3dmRd6541p+mCcrnU8QiPB3p9GbZKFg=;
	b=rMTgtWCSK5cTrOWfZj2MD94hDSUOuTqRkb+/iJDjbn5RS5v40Z6HYebeXtFq79BrfR1rZd
	XcGo62e+hMjdD8DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744707925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gt8X9OwuX4DE3dmRd6541p+mCcrnU8QiPB3p9GbZKFg=;
	b=rCb+dbdq7YVfmZ+K7cSqijtOv4piofNRPNccHTjNTOxFA8mksU3+EdYR85sxmAqYjmWglx
	JJ7hCgiJ30rQ9GLKycfnMOlOzdpxa7SKP3/UdKnTb3mzS6QDpWHN+//o/VYnvV934xxfmW
	hsiFoAGsXTRW5rbADkSmT7Wa3eaLDi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744707925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gt8X9OwuX4DE3dmRd6541p+mCcrnU8QiPB3p9GbZKFg=;
	b=rMTgtWCSK5cTrOWfZj2MD94hDSUOuTqRkb+/iJDjbn5RS5v40Z6HYebeXtFq79BrfR1rZd
	XcGo62e+hMjdD8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAEAA137A5;
	Tue, 15 Apr 2025 09:05:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0zuCMVUh/meTUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 09:05:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3178DA0947; Tue, 15 Apr 2025 11:05:25 +0200 (CEST)
Date: Tue, 15 Apr 2025 11:05:25 +0200
From: Jan Kara <jack@suse.cz>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: hch@infradead.org, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr
Message-ID: <q5zbucxhdxsso7r3ydtnsz7jjkohc2zevz5swfbzwjizceqicp@32vssyaakhqo>
References: <Z_yiPk7AkwJo0c6n@infradead.org>
 <20250415010518.2008216-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415010518.2008216-1-lizhi.xu@windriver.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[e36cc3297bd3afd25e19];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 15-04-25 09:05:18, Lizhi Xu wrote:
> On Sun, 13 Apr 2025 22:50:54 -0700, Christoph Hellwig wrote:
> > On Fri, Apr 11, 2025 at 09:24:27AM +0800, Lizhi Xu wrote:
> > > The ntfs3 can use the page cache directly, so its address_space_operations
> > > need direct_IO.
> > 
> > I can't parse that sentence.  What are you trying to say with it?
> The comments [1] of generic_file_read_iter() clearly states "read_iter()
> for all filesystems that can use the page cache directly".
> 
> In the calltrace of this example, it is clear that direct_IO is not set.
> In [3], it is also clear that the lack of direct_IO in ntfs_aops_cmpr
> caused this problem.
> 
> In summary, direct_IO must be set in this issue.

I agree that you need to set .direct_IO in ntfs_aops_cmpr but since
compressed files do not *support* direct IO (at least I don't see any such
support in ntfs_direct_IO()) you either need to also handle these files in
ntfs_direct_IO() or you need to set special direct IO handler that will
just return 0 and thus fall back to buffered IO. So I don't think your
patch is correct as is.

									Honza

> [1]
>  * generic_file_read_iter - generic filesystem read routine
>  * @iocb:	kernel I/O control block
>  * @iter:	destination for the data read
>  *
>  * This is the "read_iter()" routine for all filesystems
>  * that can use the page cache directly.
> 
> [2]
> generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> {
> 	size_t count = iov_iter_count(iter);
> 	ssize_t retval = 0;
> 
> 	if (!count)
> 		return 0; /* skip atime */
> 
> 	if (iocb->ki_flags & IOCB_DIRECT) {
> 		struct file *file = iocb->ki_filp;
> 		struct address_space *mapping = file->f_mapping;
> 		struct inode *inode = mapping->host;
> 
> 		retval = kiocb_write_and_wait(iocb, count);
> 		if (retval < 0)
> 			return retval;
> 		file_accessed(file);
> 
> 		retval = mapping->a_ops->direct_IO(iocb, iter); 
> [3]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b432163ebd15a0fb74051949cb61456d6c55ccbd
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 4d9d84cc3c6f55..9b6a3f8d2e7c5c 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -101,8 +101,26 @@ int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>  	/* Allowed to change compression for empty files and for directories only. */
>  	if (!is_dedup(ni) && !is_encrypted(ni) &&
>  	    (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
> -		/* Change compress state. */
> -		int err = ni_set_compress(inode, flags & FS_COMPR_FL);
> +		int err = 0;
> +		struct address_space *mapping = inode->i_mapping;
> +
> +		/* write out all data and wait. */
> +		filemap_invalidate_lock(mapping);
> +		err = filemap_write_and_wait(mapping);
> +
> +		if (err >= 0) {
> +			/* Change compress state. */
> +			bool compr = flags & FS_COMPR_FL;
> +			err = ni_set_compress(inode, compr);
> +
> +			/* For files change a_ops too. */
> +			if (!err)
> +				mapping->a_ops = compr ? &ntfs_aops_cmpr :
> +							 &ntfs_aops;
> 
> BR,
> Lizhi
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

