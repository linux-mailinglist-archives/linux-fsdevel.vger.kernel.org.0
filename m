Return-Path: <linux-fsdevel+bounces-51876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812D5ADC7BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 12:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB4E1892101
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A232D12FF;
	Tue, 17 Jun 2025 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lYQbxJ10";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6Svwy5fM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lYQbxJ10";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6Svwy5fM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CE32C08B5
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155174; cv=none; b=owLoAni4m8rjaMdtZ0qy/8ZM2y0tU8JzaJu0i/BxFdTEQ2csCOsU4o6qapKiUVE93DnLw0Q3Ax7gG0C3KEt2Y/iro+8HvmdL50oVgjOvB75WWjQ2TN2M6EDlHcD0VzNgjhMKEmz4XnOY2tZBGXjKugn+gKcBZ4fQqXDRlXU3Cak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155174; c=relaxed/simple;
	bh=Yvgz2Vh1swh/z+T1bpq5S1pxyzucSxoZA9u+bTmfFpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP+9WF30w0myHXezR6qInTKOwX36DfSh48QFtf2ii+xCxOzu6SYYWdazJo0jC0B5CaV9+kkDcdAOIwUh3VEz1PatLrsXNDNtgorCZB/qssAvgfBEkLQwEgpdkmPd0oBaJqL06qUYrYgROMfvpzhErObLco7a7QgnfQowGAZQpzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lYQbxJ10; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6Svwy5fM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lYQbxJ10; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6Svwy5fM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17CD01F454;
	Tue, 17 Jun 2025 10:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750155169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4vW1BLf3KmtZV1m8k5bHUaabgyxSpXUIU3DYk4FH3CY=;
	b=lYQbxJ10XiF36NJ1nZX42utoD9Yi9TyH4Ri/ANfsedxpT2Cx0Qq8W/p6zKiFmiP7s3zPkO
	vbi/Khf10BE1V8jJeg5U2LP+5M9mZ+tGSED0JBxpGQbaWchHGHnUfgJnCPLHc2FZta69oj
	vTfJbMV67J/+PmBScr0eGy8Ap6QA134=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750155169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4vW1BLf3KmtZV1m8k5bHUaabgyxSpXUIU3DYk4FH3CY=;
	b=6Svwy5fMZHrfWJ0JoGLiBFzbzdphbHyONhbgAax6JbhOcNZmQutxQUD0ZOoTNQkgIB0GQQ
	bUpA7yCdSF8Rm6Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lYQbxJ10;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6Svwy5fM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750155169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4vW1BLf3KmtZV1m8k5bHUaabgyxSpXUIU3DYk4FH3CY=;
	b=lYQbxJ10XiF36NJ1nZX42utoD9Yi9TyH4Ri/ANfsedxpT2Cx0Qq8W/p6zKiFmiP7s3zPkO
	vbi/Khf10BE1V8jJeg5U2LP+5M9mZ+tGSED0JBxpGQbaWchHGHnUfgJnCPLHc2FZta69oj
	vTfJbMV67J/+PmBScr0eGy8Ap6QA134=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750155169;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4vW1BLf3KmtZV1m8k5bHUaabgyxSpXUIU3DYk4FH3CY=;
	b=6Svwy5fMZHrfWJ0JoGLiBFzbzdphbHyONhbgAax6JbhOcNZmQutxQUD0ZOoTNQkgIB0GQQ
	bUpA7yCdSF8Rm6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 060D213AE2;
	Tue, 17 Jun 2025 10:12:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AD51AaE/UWgGGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Jun 2025 10:12:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A6C44A29F0; Tue, 17 Jun 2025 12:12:48 +0200 (CEST)
Date: Tue, 17 Jun 2025 12:12:48 +0200
From: Jan Kara <jack@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Tigran A . Aivazian" <aivazian.tigran@gmail.com>, 
	Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Dave Kleikamp <shaggy@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Hans de Goede <hdegoede@redhat.com>, 
	Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-afs@lists.infradead.org, linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-mm@kvack.org, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH 07/10] mm/filemap: introduce
 generic_file_*_mmap_prepare() helpers
Message-ID: <cxjn2u5nokhbgjvlb5qm6sgcrhbo7o6owhxz6ke5h43tydgrxm@yrcmyxzjzh4n>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <30622c1f0b98c66840bc8c02668bda276a810b70.1750099179.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30622c1f0b98c66840bc8c02668bda276a810b70.1750099179.git.lorenzo.stoakes@oracle.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,oracle.com,kernel.dk,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,kernel.org,ionkov.net,codewreck.org,crudebyte.com,suse.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,kvack.org,szeredi.hu,linux.dev,fb.com,toxicpanda.com,cs.cmu.edu,tyhicks.com,linux.alibaba.com,google.com,huawei.com,samsung.com,sony.com,mit.edu,dilger.ca,mail.parknet.co.jp,dubeyko.com,physik.fu-berlin.de,vivo.com,nod.at,cambridgegreys.com,sipsolutions.net,artax.karlin.mff.cuni.cz,infradead.org,paragon-software.com,fasheh.com,evilplan.org,bobcopeland.com,omnibond.com,samba.org,manguebit.org,microsoft.com,talpey.com,wdc.com,suse.de,vger.kernel.org,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,coda.cs.cmu.edu,lists.ozlabs.org,lists.sourceforge.net,lists.orangefs.org,lists.samba.org];
	RCPT_COUNT_GT_50(0.00)[113];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 17CD01F454
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -2.51

On Mon 16-06-25 20:33:26, Lorenzo Stoakes wrote:
> Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> callback"), the f_op->mmap() hook has been deprecated in favour of
> f_op->mmap_prepare().
> 
> The generic mmap handlers are very simple, so we can very easily convert
> these in advance of converting file systems which use them.
> 
> This patch does so.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h |  6 ++++--
>  mm/filemap.c       | 29 +++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7120f80255b3..65cffc445fcc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3395,8 +3395,10 @@ extern void inode_add_lru(struct inode *inode);
>  extern int sb_set_blocksize(struct super_block *, int);
>  extern int sb_min_blocksize(struct super_block *, int);
>  
> -extern int generic_file_mmap(struct file *, struct vm_area_struct *);
> -extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
> +int generic_file_mmap(struct file *, struct vm_area_struct *);
> +int generic_file_mmap_prepare(struct vm_area_desc *desc);
> +int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
> +int generic_file_readonly_mmap_prepare(struct vm_area_desc *desc);
>  extern ssize_t generic_write_checks(struct kiocb *, struct iov_iter *);
>  int generic_write_checks_count(struct kiocb *iocb, loff_t *count);
>  extern int generic_write_check_limits(struct file *file, loff_t pos,
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 93fbc2ef232a..e75608cbf420 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3847,6 +3847,18 @@ int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +int generic_file_mmap_prepare(struct vm_area_desc *desc)
> +{
> +	struct file *file = desc->file;
> +	struct address_space *mapping = file->f_mapping;
> +
> +	if (!mapping->a_ops->read_folio)
> +		return -ENOEXEC;
> +	file_accessed(file);
> +	desc->vm_ops = &generic_file_vm_ops;
> +	return 0;
> +}
> +
>  /*
>   * This is for filesystems which do not implement ->writepage.
>   */
> @@ -3856,6 +3868,13 @@ int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
>  		return -EINVAL;
>  	return generic_file_mmap(file, vma);
>  }
> +
> +int generic_file_readonly_mmap_prepare(struct vm_area_desc *desc)
> +{
> +	if (is_shared_maywrite(desc->vm_flags))
> +		return -EINVAL;
> +	return generic_file_mmap_prepare(desc);
> +}
>  #else
>  vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
>  {
> @@ -3865,15 +3884,25 @@ int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	return -ENOSYS;
>  }
> +int generic_file_mmap_prepare(struct vm_area_desc *desc)
> +{
> +	return -ENOSYS;
> +}
>  int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	return -ENOSYS;
>  }
> +int generic_file_readonly_mmap_prepare(struct vm_area_desc *desc)
> +{
> +	return -ENOSYS;
> +}
>  #endif /* CONFIG_MMU */
>  
>  EXPORT_SYMBOL(filemap_page_mkwrite);
>  EXPORT_SYMBOL(generic_file_mmap);
> +EXPORT_SYMBOL(generic_file_mmap_prepare);
>  EXPORT_SYMBOL(generic_file_readonly_mmap);
> +EXPORT_SYMBOL(generic_file_readonly_mmap_prepare);
>  
>  static struct folio *do_read_cache_folio(struct address_space *mapping,
>  		pgoff_t index, filler_t filler, struct file *file, gfp_t gfp)
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

