Return-Path: <linux-fsdevel+bounces-1205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A83327D731F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 20:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3081F20F0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B96530FBF;
	Wed, 25 Oct 2023 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vBUvA9Dl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xjsjaSWS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DD220B00
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 18:20:29 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55190116;
	Wed, 25 Oct 2023 11:20:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F41041FD67;
	Wed, 25 Oct 2023 18:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698258025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7JFiEvc95CKRd6WeAoGdvwYsLEW+MbIRdqaeCCjiXbs=;
	b=vBUvA9Dljtv08X+6oCzyTiDf3iavdVMdyGhzIDZRhqknh2itXMajiQYdW3v7dtb7Xwzzh3
	4BnI0ozD6IRSepMRbZt1H0mvjbzFrkD4gVhXECaOML0sXA3taGaqiYrFaFZmuLKrPQCvT1
	5xtdbvCeakbuwtEAHls17DBAH3/RDiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698258025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7JFiEvc95CKRd6WeAoGdvwYsLEW+MbIRdqaeCCjiXbs=;
	b=xjsjaSWSAuM/89J87BFq/aeurglw+WN9l/J7hnsgroVwlQsS0HqXwYsbT7dIOXFS+vtFDe
	Rm37IYc7Ilr3oqDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E380D13524;
	Wed, 25 Oct 2023 18:20:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id rbmFN2hcOWXrdwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 18:20:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6AF79A0679; Wed, 25 Oct 2023 20:20:24 +0200 (CEST)
Date: Wed, 25 Oct 2023 20:20:24 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 08/10] ext2: Convert ext2_unlink() and ext2_rename() to
 use folios
Message-ID: <20231025182024.tsrvzcnwojsfrbbu@quack3>
References: <20230921200746.3303942-1-willy@infradead.org>
 <20230921200746.3303942-8-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921200746.3303942-8-willy@infradead.org>

On Thu 21-09-23 21:07:45, Matthew Wilcox (Oracle) wrote:
> This involves changing ext2_find_entry(), ext2_dotdot(),
> ext2_inode_by_name(), ext2_set_link() and ext2_delete_entry() to
> take a folio.  These were also the last users of ext2_get_page() and
> ext2_put_page(), so remove those at the same time.

BTW, missing signed-off-by here. Can I add it?

								Honza

> ---
>  fs/ext2/dir.c   | 75 ++++++++++++++++++++-----------------------------
>  fs/ext2/ext2.h  | 23 ++++++---------
>  fs/ext2/namei.c | 32 ++++++++++-----------
>  3 files changed, 55 insertions(+), 75 deletions(-)
> 
> diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> index 7e75cfaa709c..dad71ef38395 100644
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@ -209,17 +209,6 @@ static void *ext2_get_folio(struct inode *dir, unsigned long n,
>  	return ERR_PTR(-EIO);
>  }
>  
> -static void *ext2_get_page(struct inode *dir, unsigned long n,
> -				   int quiet, struct page **pagep)
> -{
> -	struct folio *folio;
> -	void *kaddr = ext2_get_folio(dir, n, quiet, &folio);
> -
> -	if (!IS_ERR(kaddr))
> -		*pagep = &folio->page;
> -	return kaddr;
> -}
> -
>  /*
>   * NOTE! unlike strncmp, ext2_match returns 1 for success, 0 for failure.
>   *
> @@ -342,38 +331,35 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
>   * and the entry itself. Page is returned mapped and unlocked.
>   * Entry is guaranteed to be valid.
>   *
> - * On Success ext2_put_page() should be called on *res_page.
> + * On Success folio_release_kmap() should be called on *foliop.
>   *
> - * NOTE: Calls to ext2_get_page()/ext2_put_page() must be nested according to
> - * the rules documented in kmap_local_page()/kunmap_local().
> + * NOTE: Calls to ext2_get_folio()/folio_release_kmap() must be nested
> + * according to the rules documented in kmap_local_folio()/kunmap_local().
>   *
> - * ext2_find_entry() and ext2_dotdot() act as a call to ext2_get_page() and
> - * should be treated as a call to ext2_get_page() for nesting purposes.
> + * ext2_find_entry() and ext2_dotdot() act as a call to ext2_get_folio()
> + * and should be treated as a call to ext2_get_folio() for nesting
> + * purposes.
>   */
>  struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
> -			const struct qstr *child, struct page **res_page)
> +			const struct qstr *child, struct folio **foliop)
>  {
>  	const char *name = child->name;
>  	int namelen = child->len;
>  	unsigned reclen = EXT2_DIR_REC_LEN(namelen);
>  	unsigned long start, n;
>  	unsigned long npages = dir_pages(dir);
> -	struct page *page = NULL;
>  	struct ext2_inode_info *ei = EXT2_I(dir);
>  	ext2_dirent * de;
>  
>  	if (npages == 0)
>  		goto out;
>  
> -	/* OFFSET_CACHE */
> -	*res_page = NULL;
> -
>  	start = ei->i_dir_start_lookup;
>  	if (start >= npages)
>  		start = 0;
>  	n = start;
>  	do {
> -		char *kaddr = ext2_get_page(dir, n, 0, &page);
> +		char *kaddr = ext2_get_folio(dir, n, 0, foliop);
>  		if (IS_ERR(kaddr))
>  			return ERR_CAST(kaddr);
>  
> @@ -383,18 +369,18 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
>  			if (de->rec_len == 0) {
>  				ext2_error(dir->i_sb, __func__,
>  					"zero-length directory entry");
> -				ext2_put_page(page, de);
> +				folio_release_kmap(*foliop, de);
>  				goto out;
>  			}
>  			if (ext2_match(namelen, name, de))
>  				goto found;
>  			de = ext2_next_entry(de);
>  		}
> -		ext2_put_page(page, kaddr);
> +		folio_release_kmap(*foliop, kaddr);
>  
>  		if (++n >= npages)
>  			n = 0;
> -		/* next page is past the blocks we've got */
> +		/* next folio is past the blocks we've got */
>  		if (unlikely(n > (dir->i_blocks >> (PAGE_SHIFT - 9)))) {
>  			ext2_error(dir->i_sb, __func__,
>  				"dir %lu size %lld exceeds block count %llu",
> @@ -407,7 +393,6 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
>  	return ERR_PTR(-ENOENT);
>  
>  found:
> -	*res_page = page;
>  	ei->i_dir_start_lookup = n;
>  	return de;
>  }
> @@ -416,17 +401,18 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
>   * Return the '..' directory entry and the page in which the entry was found
>   * (as a parameter - p).
>   *
> - * On Success ext2_put_page() should be called on *p.
> + * On Success folio_release_kmap() should be called on *foliop.
>   *
> - * NOTE: Calls to ext2_get_page()/ext2_put_page() must be nested according to
> - * the rules documented in kmap_local_page()/kunmap_local().
> + * NOTE: Calls to ext2_get_folio()/folio_release_kmap() must be nested
> + * according to the rules documented in kmap_local_folio()/kunmap_local().
>   *
> - * ext2_find_entry() and ext2_dotdot() act as a call to ext2_get_page() and
> - * should be treated as a call to ext2_get_page() for nesting purposes.
> + * ext2_find_entry() and ext2_dotdot() act as a call to ext2_get_folio()
> + * and should be treated as a call to ext2_get_folio() for nesting
> + * purposes.
>   */
> -struct ext2_dir_entry_2 *ext2_dotdot(struct inode *dir, struct page **p)
> +struct ext2_dir_entry_2 *ext2_dotdot(struct inode *dir, struct folio **foliop)
>  {
> -	ext2_dirent *de = ext2_get_page(dir, 0, 0, p);
> +	ext2_dirent *de = ext2_get_folio(dir, 0, 0, foliop);
>  
>  	if (!IS_ERR(de))
>  		return ext2_next_entry(de);
> @@ -436,14 +422,14 @@ struct ext2_dir_entry_2 *ext2_dotdot(struct inode *dir, struct page **p)
>  int ext2_inode_by_name(struct inode *dir, const struct qstr *child, ino_t *ino)
>  {
>  	struct ext2_dir_entry_2 *de;
> -	struct page *page;
> -	
> -	de = ext2_find_entry(dir, child, &page);
> +	struct folio *folio;
> +
> +	de = ext2_find_entry(dir, child, &folio);
>  	if (IS_ERR(de))
>  		return PTR_ERR(de);
>  
>  	*ino = le32_to_cpu(de->inode);
> -	ext2_put_page(page, de);
> +	folio_release_kmap(folio, de);
>  	return 0;
>  }
>  
> @@ -464,21 +450,21 @@ static int ext2_handle_dirsync(struct inode *dir)
>  }
>  
>  int ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
> -		struct page *page, struct inode *inode, bool update_times)
> +		struct folio *folio, struct inode *inode, bool update_times)
>  {
> -	loff_t pos = page_offset(page) + offset_in_page(de);
> +	loff_t pos = folio_pos(folio) + offset_in_folio(folio, de);
>  	unsigned len = ext2_rec_len_from_disk(de->rec_len);
>  	int err;
>  
> -	lock_page(page);
> -	err = ext2_prepare_chunk(page, pos, len);
> +	folio_lock(folio);
> +	err = ext2_prepare_chunk(&folio->page, pos, len);
>  	if (err) {
> -		unlock_page(page);
> +		folio_unlock(folio);
>  		return err;
>  	}
>  	de->inode = cpu_to_le32(inode->i_ino);
>  	ext2_set_de_type(de, inode);
> -	ext2_commit_chunk(page, pos, len);
> +	ext2_commit_chunk(&folio->page, pos, len);
>  	if (update_times)
>  		dir->i_mtime = inode_set_ctime_current(dir);
>  	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
> @@ -584,9 +570,8 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
>   * ext2_delete_entry deletes a directory entry by merging it with the
>   * previous entry. Page is up-to-date.
>   */
> -int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct page *page)
> +int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
>  	struct inode *inode = folio->mapping->host;
>  	size_t from, to;
>  	char *kaddr;
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index 7fdd685c384d..677a9ad45dcb 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -717,22 +717,17 @@ extern void ext2_init_block_alloc_info(struct inode *);
>  extern void ext2_rsv_window_add(struct super_block *sb, struct ext2_reserve_window_node *rsv);
>  
>  /* dir.c */
> -extern int ext2_add_link (struct dentry *, struct inode *);
> -extern int ext2_inode_by_name(struct inode *dir,
> +int ext2_add_link(struct dentry *, struct inode *);
> +int ext2_inode_by_name(struct inode *dir,
>  			      const struct qstr *child, ino_t *ino);
> -extern int ext2_make_empty(struct inode *, struct inode *);
> -extern struct ext2_dir_entry_2 *ext2_find_entry(struct inode *, const struct qstr *,
> -						struct page **);
> -extern int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct page *page);
> -extern int ext2_empty_dir (struct inode *);
> -extern struct ext2_dir_entry_2 *ext2_dotdot(struct inode *dir, struct page **p);
> +int ext2_make_empty(struct inode *, struct inode *);
> +struct ext2_dir_entry_2 *ext2_find_entry(struct inode *, const struct qstr *,
> +		struct folio **foliop);
> +int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct folio *folio);
> +int ext2_empty_dir(struct inode *);
> +struct ext2_dir_entry_2 *ext2_dotdot(struct inode *dir, struct folio **foliop);
>  int ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
> -		struct page *page, struct inode *inode, bool update_times);
> -static inline void ext2_put_page(struct page *page, void *page_addr)
> -{
> -	kunmap_local(page_addr);
> -	put_page(page);
> -}
> +		struct folio *folio, struct inode *inode, bool update_times);
>  
>  /* ialloc.c */
>  extern struct inode * ext2_new_inode (struct inode *, umode_t, const struct qstr *);
> diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
> index 059517068adc..65f702b1da5b 100644
> --- a/fs/ext2/namei.c
> +++ b/fs/ext2/namei.c
> @@ -273,21 +273,21 @@ static int ext2_unlink(struct inode *dir, struct dentry *dentry)
>  {
>  	struct inode *inode = d_inode(dentry);
>  	struct ext2_dir_entry_2 *de;
> -	struct page *page;
> +	struct folio *folio;
>  	int err;
>  
>  	err = dquot_initialize(dir);
>  	if (err)
>  		goto out;
>  
> -	de = ext2_find_entry(dir, &dentry->d_name, &page);
> +	de = ext2_find_entry(dir, &dentry->d_name, &folio);
>  	if (IS_ERR(de)) {
>  		err = PTR_ERR(de);
>  		goto out;
>  	}
>  
> -	err = ext2_delete_entry(de, page);
> -	ext2_put_page(page, de);
> +	err = ext2_delete_entry(de, folio);
> +	folio_release_kmap(folio, de);
>  	if (err)
>  		goto out;
>  
> @@ -321,9 +321,9 @@ static int ext2_rename (struct mnt_idmap * idmap,
>  {
>  	struct inode * old_inode = d_inode(old_dentry);
>  	struct inode * new_inode = d_inode(new_dentry);
> -	struct page * dir_page = NULL;
> +	struct folio *dir_folio = NULL;
>  	struct ext2_dir_entry_2 * dir_de = NULL;
> -	struct page * old_page;
> +	struct folio * old_folio;
>  	struct ext2_dir_entry_2 * old_de;
>  	int err;
>  
> @@ -338,19 +338,19 @@ static int ext2_rename (struct mnt_idmap * idmap,
>  	if (err)
>  		return err;
>  
> -	old_de = ext2_find_entry(old_dir, &old_dentry->d_name, &old_page);
> +	old_de = ext2_find_entry(old_dir, &old_dentry->d_name, &old_folio);
>  	if (IS_ERR(old_de))
>  		return PTR_ERR(old_de);
>  
>  	if (S_ISDIR(old_inode->i_mode)) {
>  		err = -EIO;
> -		dir_de = ext2_dotdot(old_inode, &dir_page);
> +		dir_de = ext2_dotdot(old_inode, &dir_folio);
>  		if (!dir_de)
>  			goto out_old;
>  	}
>  
>  	if (new_inode) {
> -		struct page *new_page;
> +		struct folio *new_folio;
>  		struct ext2_dir_entry_2 *new_de;
>  
>  		err = -ENOTEMPTY;
> @@ -358,13 +358,13 @@ static int ext2_rename (struct mnt_idmap * idmap,
>  			goto out_dir;
>  
>  		new_de = ext2_find_entry(new_dir, &new_dentry->d_name,
> -					 &new_page);
> +					 &new_folio);
>  		if (IS_ERR(new_de)) {
>  			err = PTR_ERR(new_de);
>  			goto out_dir;
>  		}
> -		err = ext2_set_link(new_dir, new_de, new_page, old_inode, true);
> -		ext2_put_page(new_page, new_de);
> +		err = ext2_set_link(new_dir, new_de, new_folio, old_inode, true);
> +		folio_release_kmap(new_folio, new_de);
>  		if (err)
>  			goto out_dir;
>  		inode_set_ctime_current(new_inode);
> @@ -386,19 +386,19 @@ static int ext2_rename (struct mnt_idmap * idmap,
>  	inode_set_ctime_current(old_inode);
>  	mark_inode_dirty(old_inode);
>  
> -	err = ext2_delete_entry(old_de, old_page);
> +	err = ext2_delete_entry(old_de, old_folio);
>  	if (!err && dir_de) {
>  		if (old_dir != new_dir)
> -			err = ext2_set_link(old_inode, dir_de, dir_page,
> +			err = ext2_set_link(old_inode, dir_de, dir_folio,
>  					    new_dir, false);
>  
>  		inode_dec_link_count(old_dir);
>  	}
>  out_dir:
>  	if (dir_de)
> -		ext2_put_page(dir_page, dir_de);
> +		folio_release_kmap(dir_folio, dir_de);
>  out_old:
> -	ext2_put_page(old_page, old_de);
> +	folio_release_kmap(old_folio, old_de);
>  	return err;
>  }
>  
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

