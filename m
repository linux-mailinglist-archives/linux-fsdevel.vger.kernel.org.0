Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912E13D6937
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 00:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhGZVZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 17:25:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45892 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhGZVZ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 17:25:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D0F802207A;
        Mon, 26 Jul 2021 22:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627337185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t1OOBggeUv9JvaojXQWKsfIektKETu87AVmNWxqA1cA=;
        b=1X/xlvhM/bUjR/tNbFExoJsUlL0M729uljt/3JfP+TgeOX1Fg+TnwDL+qI/EcxbHVWgkKu
        N7yf932gaCVU/quXBrcP+lbPin+omZ9bWjOrdTxhR6JRYF/0GBEUxJh4FnuNa8Vxx07zJp
        cO/YKRR1t2BB3SvPlin5+/BOWZcAGXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627337185;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t1OOBggeUv9JvaojXQWKsfIektKETu87AVmNWxqA1cA=;
        b=EsYGdWhsbgrBEUTeNZdP1j5ajhFJRi9R7T/YtClnjR/2JtCLq6SkCooo2Y957qIah67Htd
        MS6YDcTBSoqs+MDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34D6513B58;
        Mon, 26 Jul 2021 22:06:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Hf2UON8x/2C0SAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 26 Jul 2021 22:06:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Goldwyn Rodrigues" <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs: reduce pointers while using file_ra_state_init()
In-reply-to: <20210726164647.brx3l2ykwv3zz7vr@fiona>
References: <20210726164647.brx3l2ykwv3zz7vr@fiona>
Date:   Tue, 27 Jul 2021 08:06:21 +1000
Message-id: <162733718119.4153.5949006309014161476@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 27 Jul 2021, Goldwyn Rodrigues wrote:
> Simplification.
>=20
> file_ra_state_init() take struct address_space *, just to use inode
> pointer by dereferencing from mapping->host.
>=20
> The callers also derive mapping either by file->f_mapping, or
> even file->f_mapping->host->i_mapping.
>=20
> Change file_ra_state_init() to accept struct inode * to reduce pointer
> dereferencing, both in the callee and the caller.

You seem to be assuming that inode->i_mapping->host is always 'inode'.
That is not the case.

In particular, fs/coda/file.c contains

	if (coda_inode->i_mapping =3D=3D &coda_inode->i_data)
		coda_inode->i_mapping =3D host_inode->i_mapping;

So a "coda_inode" shares the mapping with a "host_inode".

This is why an inode has both i_data and i_mapping.

So I'm not really sure this patch is safe.  It might break codafs.

But it is more likely that codafs isn't used, doesn't work, should be
removed, and i_data should be renamed to i_mapping.

NeilBrown


>=20
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/free-space-cache.c | 2 +-
>  fs/btrfs/ioctl.c            | 2 +-
>  fs/btrfs/relocation.c       | 2 +-
>  fs/btrfs/send.c             | 2 +-
>  fs/nfs/nfs4file.c           | 2 +-
>  fs/open.c                   | 2 +-
>  fs/verity/enable.c          | 2 +-
>  include/linux/fs.h          | 2 +-
>  mm/readahead.c              | 4 ++--
>  9 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 4806295116d8..c43bf9915cda 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -351,7 +351,7 @@ static void readahead_cache(struct inode *inode)
>  	if (!ra)
>  		return;
> =20
> -	file_ra_state_init(ra, inode->i_mapping);
> +	file_ra_state_init(ra, inode);
>  	last_index =3D (i_size_read(inode) - 1) >> PAGE_SHIFT;
> =20
>  	page_cache_sync_readahead(inode->i_mapping, ra, NULL, 0, last_index);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 5dc2fd843ae3..b3508887d466 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1399,7 +1399,7 @@ int btrfs_defrag_file(struct inode *inode, struct fil=
e *file,
>  	if (!file) {
>  		ra =3D kzalloc(sizeof(*ra), GFP_KERNEL);
>  		if (ra)
> -			file_ra_state_init(ra, inode->i_mapping);
> +			file_ra_state_init(ra, inode);
>  	} else {
>  		ra =3D &file->f_ra;
>  	}
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index b70be2ac2e9e..4f35672b93a5 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2911,7 +2911,7 @@ static int relocate_file_extent_cluster(struct inode =
*inode,
>  	if (ret)
>  		goto out;
> =20
> -	file_ra_state_init(ra, inode->i_mapping);
> +	file_ra_state_init(ra, inode);
> =20
>  	ret =3D setup_extent_mapping(inode, cluster->start - offset,
>  				   cluster->end - offset, cluster->start);
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index bd69db72acc5..3eb8d2277a3d 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -4949,7 +4949,7 @@ static int put_file_data(struct send_ctx *sctx, u64 o=
ffset, u32 len)
> =20
>  	/* initial readahead */
>  	memset(&sctx->ra, 0, sizeof(struct file_ra_state));
> -	file_ra_state_init(&sctx->ra, inode->i_mapping);
> +	file_ra_state_init(&sctx->ra, inode);
> =20
>  	while (index <=3D last_index) {
>  		unsigned cur_len =3D min_t(unsigned, len,
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index a1e5c6b85ded..c810a6151c93 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -385,7 +385,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount *s=
s_mnt,
>  	nfs_file_set_open_context(filep, ctx);
>  	put_nfs_open_context(ctx);
> =20
> -	file_ra_state_init(&filep->f_ra, filep->f_mapping->host->i_mapping);
> +	file_ra_state_init(&filep->f_ra, file_inode(filep));
>  	res =3D filep;
>  out_free_name:
>  	kfree(read_name);
> diff --git a/fs/open.c b/fs/open.c
> index e53af13b5835..9c6773a4fb30 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -840,7 +840,7 @@ static int do_dentry_open(struct file *f,
>  	f->f_write_hint =3D WRITE_LIFE_NOT_SET;
>  	f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
> =20
> -	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
> +	file_ra_state_init(&f->f_ra, inode);
> =20
>  	/* NB: we're sure to have correct a_ops only after f_op->open */
>  	if (f->f_flags & O_DIRECT) {
> diff --git a/fs/verity/enable.c b/fs/verity/enable.c
> index 77e159a0346b..460d881080ac 100644
> --- a/fs/verity/enable.c
> +++ b/fs/verity/enable.c
> @@ -66,7 +66,7 @@ static int build_merkle_tree_level(struct file *filp, uns=
igned int level,
>  		dst_block_num =3D 0; /* unused */
>  	}
> =20
> -	file_ra_state_init(&ra, filp->f_mapping);
> +	file_ra_state_init(&ra, inode);
> =20
>  	for (i =3D 0; i < num_blocks_to_hash; i++) {
>  		struct page *src_page;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c3c88fdb9b2a..3b8ce0221477 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3260,7 +3260,7 @@ extern long do_splice_direct(struct file *in, loff_t =
*ppos, struct file *out,
> =20
> =20
>  extern void
> -file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping=
);
> +file_ra_state_init(struct file_ra_state *ra, struct inode *inode);
>  extern loff_t noop_llseek(struct file *file, loff_t offset, int whence);
>  extern loff_t no_llseek(struct file *file, loff_t offset, int whence);
>  extern loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize);
> diff --git a/mm/readahead.c b/mm/readahead.c
> index d589f147f4c2..3541941df5e7 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -31,9 +31,9 @@
>   * memset *ra to zero.
>   */
>  void
> -file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
> +file_ra_state_init(struct file_ra_state *ra, struct inode *inode)
>  {
> -	ra->ra_pages =3D inode_to_bdi(mapping->host)->ra_pages;
> +	ra->ra_pages =3D inode_to_bdi(inode)->ra_pages;
>  	ra->prev_pos =3D -1;
>  }
>  EXPORT_SYMBOL_GPL(file_ra_state_init);
> --=20
> 2.32.0
>=20
>=20
> --=20
> Goldwyn
>=20
>=20
