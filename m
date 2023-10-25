Return-Path: <linux-fsdevel+bounces-1204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1387D7314
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 20:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8A51C20E48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 18:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E4E30FBD;
	Wed, 25 Oct 2023 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N0fn0rQ9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6j5LWuNi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B76E2771A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 18:17:57 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB859128;
	Wed, 25 Oct 2023 11:17:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B417621B92;
	Wed, 25 Oct 2023 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698257870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+vbdhd2yAu7gd457T3ti6BWwAUO+s257Y2GNVgdylao=;
	b=N0fn0rQ9XdGFJJ/xyvmMrLS83x6ox5xPkWzFW1FrXrmb+/RC4H5WeIWqrXJa1aADMNKwtC
	uGEb98aKeQY9D3AGIlkk9e34sbp2ZxkuCZ8fyzm5s+OsWNWGlFG2ujNHYVtTAEIyittki1
	gyMJVCEbBVrHTc0nCSrQGIh5Fsay2U8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698257870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+vbdhd2yAu7gd457T3ti6BWwAUO+s257Y2GNVgdylao=;
	b=6j5LWuNiaRruS3yEe8pyBGlv4H5Uh+joYbwndNQgx3c+8VBR0NiouwI/XImW/vJTTmq6de
	mTk1PLAsEhGu9KAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A658D13524;
	Wed, 25 Oct 2023 18:17:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id AeqRKM5bOWUNdwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 25 Oct 2023 18:17:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 220AEA0679; Wed, 25 Oct 2023 20:17:50 +0200 (CEST)
Date: Wed, 25 Oct 2023 20:17:50 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH 07/10] ext2: Handle large block size directories in
 ext2_delete_entry()
Message-ID: <20231025181750.i2ibf27imrmpkqnt@quack3>
References: <20230921200746.3303942-1-willy@infradead.org>
 <20230921200746.3303942-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921200746.3303942-7-willy@infradead.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.60
X-Spamd-Result: default: False [-6.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,gmail.com]

On Thu 21-09-23 21:07:44, Matthew Wilcox (Oracle) wrote:
> If the block size is > PAGE_SIZE, we need to calculate these offsets
> relative to the start of the folio, not the page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

So I had a fresh look at the patches and I like them so I'll take them into
my tree for the merge window. Just this patch has somewhat surprising
subject and changelog - I guess it should be standard "convert to folios"
kind of thing, shouldn't it? Because a lot of dir code is not prepared for
"large block size" so it is strange to speak about it in
ext2_delete_entry(). I can fix it up on commit.

								Honza

> ---
>  fs/ext2/dir.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> index 2fc910e99234..7e75cfaa709c 100644
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@ -586,16 +586,20 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
>   */
>  int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct page *page)
>  {
> -	struct inode *inode = page->mapping->host;
> -	char *kaddr = (char *)((unsigned long)dir & PAGE_MASK);
> -	unsigned from = offset_in_page(dir) & ~(ext2_chunk_size(inode)-1);
> -	unsigned to = offset_in_page(dir) +
> -				ext2_rec_len_from_disk(dir->rec_len);
> +	struct folio *folio = page_folio(page);
> +	struct inode *inode = folio->mapping->host;
> +	size_t from, to;
> +	char *kaddr;
>  	loff_t pos;
> -	ext2_dirent *pde = NULL;
> -	ext2_dirent *de = (ext2_dirent *)(kaddr + from);
> +	ext2_dirent *de, *pde = NULL;
>  	int err;
>  
> +	from = offset_in_folio(folio, dir);
> +	to = from + ext2_rec_len_from_disk(dir->rec_len);
> +	kaddr = (char *)dir - from;
> +	from &= ~(ext2_chunk_size(inode)-1);
> +	de = (ext2_dirent *)(kaddr + from);
> +
>  	while ((char*)de < (char*)dir) {
>  		if (de->rec_len == 0) {
>  			ext2_error(inode->i_sb, __func__,
> @@ -606,18 +610,18 @@ int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct page *page)
>  		de = ext2_next_entry(de);
>  	}
>  	if (pde)
> -		from = offset_in_page(pde);
> -	pos = page_offset(page) + from;
> -	lock_page(page);
> -	err = ext2_prepare_chunk(page, pos, to - from);
> +		from = offset_in_folio(folio, pde);
> +	pos = folio_pos(folio) + from;
> +	folio_lock(folio);
> +	err = ext2_prepare_chunk(&folio->page, pos, to - from);
>  	if (err) {
> -		unlock_page(page);
> +		folio_unlock(folio);
>  		return err;
>  	}
>  	if (pde)
>  		pde->rec_len = ext2_rec_len_to_disk(to - from);
>  	dir->inode = 0;
> -	ext2_commit_chunk(page, pos, to - from);
> +	ext2_commit_chunk(&folio->page, pos, to - from);
>  	inode->i_mtime = inode_set_ctime_current(inode);
>  	EXT2_I(inode)->i_flags &= ~EXT2_BTREE_FL;
>  	mark_inode_dirty(inode);
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

