Return-Path: <linux-fsdevel+bounces-22298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B454E9161B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CFA3287190
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FC4148FF5;
	Tue, 25 Jun 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v+9AZcbR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XlTDAOuP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v+9AZcbR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XlTDAOuP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B3146A92;
	Tue, 25 Jun 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305655; cv=none; b=WVuoYEtBFVo9L6vF6NpJvkWj7e6fLbdat9Xa3Zf4Jx+RcVta9wvBDi9t3NHKTILz1Tp78uyVCQCu+X6WwOAoWFVBEZJMbacXdn+fbFwGmaP4OhHw0JvDuoyZGtabe8C80By8gaXdg9HJuUekA3HY64w7TRxseU0jkvgCQdyYyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305655; c=relaxed/simple;
	bh=bkFP8nw/oGL2K5jvWI18IvJmPA1/d1daWZ9k+VnEBGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWD4THiNFxyAYhvOXvRtx4yMpAnPt1v6b6mqvmmiGtV/RsJKBwYPvfaU2CIPswF4zVp9/1NMRvawBcUHbAJ9J3vo3s/UDvJkl1fXkY8QC+GnHeodFy4dIEtb7f+Ud9nFpYT5LDgB4fT7+su8Ezevk9sylxKVMl4dMQfDq46MRtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v+9AZcbR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XlTDAOuP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v+9AZcbR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XlTDAOuP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A4BF21F7D3;
	Tue, 25 Jun 2024 08:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719305651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dLtP8yR3zI88QJSRwPEXeVNKhmP5aSeQ9B2p9bauRMs=;
	b=v+9AZcbRcR8uiec0HN3k6Y0VXfau6dUarUZKm0eztY6ICrhDKEXvi0gFnhaOTj/kmhXand
	X0udk7xlTvoG+fspyLFnfyTtVds7gDnb/cCVyLsFsU6N0Y8lsQYFgFpWQgygQOs7W2odvs
	Kne8ZrFsttU/ibd1EI+/nvjaoq8/mxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719305651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dLtP8yR3zI88QJSRwPEXeVNKhmP5aSeQ9B2p9bauRMs=;
	b=XlTDAOuP69AJePLAGJjIrATe2D+NxYp4uKvFLH162ooRJYjQwHCpzRsiegnHPmEdIwxqfz
	8DhBObACrWJ0mSDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v+9AZcbR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XlTDAOuP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719305651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dLtP8yR3zI88QJSRwPEXeVNKhmP5aSeQ9B2p9bauRMs=;
	b=v+9AZcbRcR8uiec0HN3k6Y0VXfau6dUarUZKm0eztY6ICrhDKEXvi0gFnhaOTj/kmhXand
	X0udk7xlTvoG+fspyLFnfyTtVds7gDnb/cCVyLsFsU6N0Y8lsQYFgFpWQgygQOs7W2odvs
	Kne8ZrFsttU/ibd1EI+/nvjaoq8/mxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719305651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dLtP8yR3zI88QJSRwPEXeVNKhmP5aSeQ9B2p9bauRMs=;
	b=XlTDAOuP69AJePLAGJjIrATe2D+NxYp4uKvFLH162ooRJYjQwHCpzRsiegnHPmEdIwxqfz
	8DhBObACrWJ0mSDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9714F13AC1;
	Tue, 25 Jun 2024 08:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FFjfJLOFemZTPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 08:54:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3DFACA08A4; Tue, 25 Jun 2024 10:54:11 +0200 (CEST)
Date: Tue, 25 Jun 2024 10:54:11 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] vfs: remove redundant smp_mb for thp handling in
 do_dentry_open
Message-ID: <20240625085411.yqowxadalnha5t3f@quack3>
References: <20240624085402.493630-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624085402.493630-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A4BF21F7D3
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 24-06-24 10:54:02, Mateusz Guzik wrote:
> opening for write performs:
> 
> if (f->f_mode & FMODE_WRITE) {
> [snip]
>         smp_mb();
>         if (filemap_nr_thps(inode->i_mapping)) {
> [snip]
>         }
> }
> 
> filemap_nr_thps on kernels built without CONFIG_READ_ONLY_THP_FOR
> expands to 0, allowing the compiler to eliminate the entire thing, with
> exception of the fence (and the branch leading there).
> 
> So happens required synchronisation between i_writecount and nr_thps
> changes is already provided by the full fence coming from
> get_write_access -> atomic_inc_unless_negative, thus the smp_mb instance
> above can be removed regardless of CONFIG_READ_ONLY_THP_FOR.
> 
> While I updated commentary in places claiming to match the now-removed
> fence, I did not try to patch them to act on the compile option.
> 
> I did not bother benchmarking it, not issuing a spurious full fence in
> the fast path does not warrant justification from perf standpoint.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Yeah, I didn't like the ifdef but this version looks good to me. Feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> v2:
> - just whack the fence instead of ifdefing
> - change To recipient, the person who committed the original change is
>   no longer active
> 
>  fs/open.c       |  9 ++++-----
>  mm/khugepaged.c | 10 +++++-----
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 28f2fcbebb1b..64976b6dc75f 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -986,12 +986,11 @@ static int do_dentry_open(struct file *f,
>  	 */
>  	if (f->f_mode & FMODE_WRITE) {
>  		/*
> -		 * Paired with smp_mb() in collapse_file() to ensure nr_thps
> -		 * is up to date and the update to i_writecount by
> -		 * get_write_access() is visible. Ensures subsequent insertion
> -		 * of THPs into the page cache will fail.
> +		 * Depends on full fence from get_write_access() to synchronize
> +		 * against collapse_file() regarding i_writecount and nr_thps
> +		 * updates. Ensures subsequent insertion of THPs into the page
> +		 * cache will fail.
>  		 */
> -		smp_mb();
>  		if (filemap_nr_thps(inode->i_mapping)) {
>  			struct address_space *mapping = inode->i_mapping;
>  
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 409f67a817f1..2e017585f813 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1997,9 +1997,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	if (!is_shmem) {
>  		filemap_nr_thps_inc(mapping);
>  		/*
> -		 * Paired with smp_mb() in do_dentry_open() to ensure
> -		 * i_writecount is up to date and the update to nr_thps is
> -		 * visible. Ensures the page cache will be truncated if the
> +		 * Paired with the fence in do_dentry_open() -> get_write_access()
> +		 * to ensure i_writecount is up to date and the update to nr_thps
> +		 * is visible. Ensures the page cache will be truncated if the
>  		 * file is opened writable.
>  		 */
>  		smp_mb();
> @@ -2187,8 +2187,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	if (!is_shmem && result == SCAN_COPY_MC) {
>  		filemap_nr_thps_dec(mapping);
>  		/*
> -		 * Paired with smp_mb() in do_dentry_open() to
> -		 * ensure the update to nr_thps is visible.
> +		 * Paired with the fence in do_dentry_open() -> get_write_access()
> +		 * to ensure the update to nr_thps is visible.
>  		 */
>  		smp_mb();
>  	}
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

