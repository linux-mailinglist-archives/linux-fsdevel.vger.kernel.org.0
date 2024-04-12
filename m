Return-Path: <linux-fsdevel+bounces-16807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7AD8A30D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 16:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EB52828A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FB3142630;
	Fri, 12 Apr 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1N4TA4iS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="91MBCG5d";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1N4TA4iS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="91MBCG5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8EA1419BA;
	Fri, 12 Apr 2024 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932682; cv=none; b=b++O/tU/e1/BJW5OIuhYf+P0nOFQQU7hlQpG6MX/RmeoZpm1dRtqej2z4VGTzQQYtnc6JmKo7TRHakicSgSXR4QXrNp6jzXrpT3buVJiFoVKX8DtI7aA37YbKL0RPeavSefJQAAG15kzbRU1qUYN00OAsJarqObLnhuyW9SJvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932682; c=relaxed/simple;
	bh=Z55ySXlFlCDNEjr8HGsGHbc9q5i23Wo3obfcEoNpdvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtJeCnfCXQt7Zq1rJskTQyOIR3L6ZLJSdD7lSbcig0kTJ2lLHofklBvqWatIjwcajvRdy00zoa1Kbd1UIcCgVFcOqI4R96NYzZlSCLRSonuHhmP4XZuRZ45ia8OHK8Pkq0we+HOdABZUKTsSqBJPenTshQxy/dX46aFCuXjj97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1N4TA4iS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=91MBCG5d; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1N4TA4iS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=91MBCG5d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7044C5FDFC;
	Fri, 12 Apr 2024 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712932678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sCsDTBKE5BK0xtqcaioV7AbOpY2+77/u8JnnEMWVVZE=;
	b=1N4TA4iSTfxUqNz5D936xqF5zCSJDUQBPw+YYsE+KfyhAG1A6dw/HnUR1wLb9WFFP5+ICw
	R2AomD66IAwSQ0BMGElFbfk95nCAX54OM9vkzuZiryQrdIJOCyBwb46nGoHY9m8+EcsH74
	xlIh0Gucar30XspIjssbnGtftd6g8sg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712932678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sCsDTBKE5BK0xtqcaioV7AbOpY2+77/u8JnnEMWVVZE=;
	b=91MBCG5d18RAvnFExJRBaS9JJp3FA1woZQ557EaPDYo+k1UrUYikDzgpf8/2VIf3HLGlds
	oNyFG6cVlEl6KjBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712932678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sCsDTBKE5BK0xtqcaioV7AbOpY2+77/u8JnnEMWVVZE=;
	b=1N4TA4iSTfxUqNz5D936xqF5zCSJDUQBPw+YYsE+KfyhAG1A6dw/HnUR1wLb9WFFP5+ICw
	R2AomD66IAwSQ0BMGElFbfk95nCAX54OM9vkzuZiryQrdIJOCyBwb46nGoHY9m8+EcsH74
	xlIh0Gucar30XspIjssbnGtftd6g8sg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712932678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sCsDTBKE5BK0xtqcaioV7AbOpY2+77/u8JnnEMWVVZE=;
	b=91MBCG5d18RAvnFExJRBaS9JJp3FA1woZQ557EaPDYo+k1UrUYikDzgpf8/2VIf3HLGlds
	oNyFG6cVlEl6KjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D1371368B;
	Fri, 12 Apr 2024 14:37:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sl+yFkZHGWZJdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Apr 2024 14:37:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 088D3A071E; Fri, 12 Apr 2024 16:37:50 +0200 (CEST)
Date: Fri, 12 Apr 2024 16:37:49 +0200
From: Jan Kara <jack@suse.cz>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
	jhubbard@nvidia.com, rcampbell@nvidia.com, willy@infradead.org,
	jgg@nvidia.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	djwong@kernel.org, hch@lst.de, david@redhat.com,
	ruansy.fnst@fujitsu.com, nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	jglisse@redhat.com
Subject: Re: [RFC 05/10] fs/dax: Refactor wait for dax idle page
Message-ID: <20240412143749.3tryph4khox3euef@quack3>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <db13f495fc0addcff12b6b065b7a6b25f09c4be7.1712796818.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db13f495fc0addcff12b6b065b7a6b25f09c4be7.1712796818.git-series.apopple@nvidia.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,nvidia.com:email,suse.com:email]

On Thu 11-04-24 10:57:26, Alistair Popple wrote:
> A FS DAX page is considered idle when its refcount drops to one. This
> is currently open-coded in all file systems supporting FS DAX. Move
> the idle detection to a common function to make future changes easier.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

Good cleanup. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c     |  5 +----
>  fs/fuse/dax.c       |  4 +---
>  fs/xfs/xfs_file.c   |  4 +---
>  include/linux/dax.h | 11 +++++++++++
>  4 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4ce35f1..e9cef7d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3868,10 +3868,7 @@ int ext4_break_layouts(struct inode *inode)
>  		if (!page)
>  			return 0;
>  
> -		error = ___wait_var_event(&page->_refcount,
> -				atomic_read(&page->_refcount) == 1,
> -				TASK_INTERRUPTIBLE, 0, 0,
> -				ext4_wait_dax_page(inode));
> +		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
>  	} while (error == 0);
>  
>  	return error;
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 23904a6..8a62483 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -676,9 +676,7 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
>  		return 0;
>  
>  	*retry = true;
> -	return ___wait_var_event(&page->_refcount,
> -			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
> -			0, 0, fuse_wait_dax_page(inode));
> +	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
>  }
>  
>  /* dmap_end == 0 leads to unmapping of whole file */
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 2037002..099cd70 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -849,9 +849,7 @@ xfs_break_dax_layouts(
>  		return 0;
>  
>  	*retry = true;
> -	return ___wait_var_event(&page->_refcount,
> -			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
> -			0, 0, xfs_wait_dax_page(inode));
> +	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
>  }
>  
>  int
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 22cd990..bced4d4 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -212,6 +212,17 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  		const struct iomap_ops *ops);
>  
> +static inline int dax_wait_page_idle(struct page *page,
> +				void (cb)(struct inode *),
> +				struct inode *inode)
> +{
> +	int ret;
> +
> +	ret = ___wait_var_event(page, page_ref_count(page) == 1,
> +				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
> +	return ret;
> +}
> +
>  #if IS_ENABLED(CONFIG_DAX)
>  int dax_read_lock(void);
>  void dax_read_unlock(int id);
> -- 
> git-series 0.9.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

