Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9554A3DB509
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 10:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbhG3I3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 04:29:05 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:57109 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhG3I3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:29:01 -0400
Received: from [10.0.2.15] ([86.243.172.93])
        by mwinf5d81 with ME
        id bLUv2500421Fzsu03LUvMV; Fri, 30 Jul 2021 10:28:56 +0200
X-ME-Helo: [10.0.2.15]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 30 Jul 2021 10:28:56 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH v27 02/10] fs/ntfs3: Add initialization of super block
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-3-almaz.alexandrovich@paragon-software.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <22a587a2-a7d0-2250-7f3d-8e6fe3b98a28@wanadoo.fr>
Date:   Fri, 30 Jul 2021 10:28:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210729134943.778917-3-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

below are a few comments based on a cppcheck run.
Don't take it too seriously into consideration, this is just some minor 
clean-up.

The only one that may look interested is in 'indx_find()'

CJ


Le 29/07/2021 à 15:49, Konstantin Komarov a écrit :
> This adds initialization of super block
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>   fs/ntfs3/fsntfs.c | 2542 +++++++++++++++++++++++++++++++++++++++++++
>   fs/ntfs3/index.c  | 2641 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/ntfs3/inode.c  | 2034 ++++++++++++++++++++++++++++++++++
>   fs/ntfs3/super.c  | 1500 +++++++++++++++++++++++++
>   4 files changed, 8717 insertions(+)
>   create mode 100644 fs/ntfs3/fsntfs.c
>   create mode 100644 fs/ntfs3/index.c
>   create mode 100644 fs/ntfs3/inode.c
>   create mode 100644 fs/ntfs3/super.c
> 
> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> new file mode 100644
> index 000000000..327356b08
> --- /dev/null
> +++ b/fs/ntfs3/fsntfs.c

[...]

> +int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
> +			     CLST *new_lcn, CLST *new_len,
> +			     enum ALLOCATE_OPT opt)
> +{

[...]

> +
> +	if (zlen <= NTFS_MIN_MFT_ZONE)
> +		goto no_space;
> +
> +	/* How many clusters to cat from zone */
> +	zlcn = wnd_zone_bit(wnd);
> +	zlen2 = zlen >> 1;
> +	ztrim = len > zlen ? zlen : (len > zlen2 ? len : zlen2);
> +	new_zlen = zlen - ztrim;
> +
> +	if (new_zlen < NTFS_MIN_MFT_ZONE) {
> +		new_zlen = NTFS_MIN_MFT_ZONE;
> +		if (new_zlen > zlen)
> +			new_zlen = zlen;

Unless I missed something, 'zlen' is known to be > NTFS_MIN_MFT_ZONE 
here (see a few lines above).
And, if this 'if' is taken, 'new_zlen' is <= NTFS_MIN_MFT_ZONE.

So this test can never match and can be removed. (or removed by a 
comment if it makes sense)

> +	}
> +
> +	wnd_zone_set(wnd, zlcn, new_zlen);
> +
> +	/* allocate continues clusters */
> +	*new_len =
> +		wnd_find(wnd, len, 0,
> +			 BITMAP_FIND_MARK_AS_USED | BITMAP_FIND_FULL, &a_lcn);

[...]

> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> new file mode 100644
> index 000000000..931a7241e
> --- /dev/null
> +++ b/fs/ntfs3/index.c
> @@ -0,0 +1,2641 @@

[...]

> +static const struct NTFS_DE *hdr_find_split(const struct INDEX_HDR *hdr)
> +{
> +	size_t o;
> +	const struct NTFS_DE *e = hdr_first_de(hdr);
> +	u32 used_2 = le32_to_cpu(hdr->used) >> 1;
> +	u16 esize = le16_to_cpu(e->size);

e is NULL check the line after.

> +
> +	if (!e || de_is_last(e))
> +		return NULL;
> +
> +	for (o = le32_to_cpu(hdr->de_off) + esize; o < used_2; o += esize) {
> +		const struct NTFS_DE *p = e;
> +
> +		e = Add2Ptr(hdr, o);
> +
> +		/* We must not return END entry */
> +		if (de_is_last(e))
> +			return p;
> +
> +		esize = le16_to_cpu(e->size);
> +	}
> +
> +	return e;
> +}

[...]

> +int indx_find(struct ntfs_index *indx, struct ntfs_inode *ni,
> +	      const struct INDEX_ROOT *root, const void *key, size_t key_len,
> +	      const void *ctx, int *diff, struct NTFS_DE **entry,
> +	      struct ntfs_fnd *fnd)
> +{
> +	int err;
> +	struct NTFS_DE *e;
> +	const struct INDEX_HDR *hdr;
> +	struct indx_node *node;
> +
> +	if (!root)
> +		root = indx_get_root(&ni->dir, ni, NULL, NULL);
> +
> +	if (!root) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	hdr = &root->ihdr;
> +
> +	/* Check cache */
> +	e = fnd->level ? fnd->de[fnd->level - 1] : fnd->root_de;
> +	if (e && !de_is_last(e) &&
> +	    !(*indx->cmp)(key, key_len, e + 1, le16_to_cpu(e->key_size), ctx)) {
> +		*entry = e;
> +		*diff = 0;
> +		return 0;
> +	}
> +
> +	/* Soft finder reset */
> +	fnd_clear(fnd);
> +
> +	/* Lookup entry that is <= to the search value */
> +	e = hdr_find_e(indx, hdr, key, key_len, ctx, diff);
> +	if (!e)
> +		return -EINVAL;
> +
> +	if (fnd)

This NULL check looks spurious because 'fnd' has already been 
dereferenced several times at this point.
Either it is useless, either there is some trouble elsewhere.

> +		fnd->root_de = e;
> +
> +	err = 0;
> +

[...]

> +static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
> +				CLST *vbn)
> +{
> +	int err = -ENOMEM;

This initialization is overwritten below.
It can be removed.

> +	struct ntfs_sb_info *sbi = ni->mi.sbi;
> +	struct ATTRIB *bitmap;
> +	struct ATTRIB *alloc;
> +	u32 data_size = 1u << indx->index_bits;
> +	u32 alloc_size = ntfs_up_cluster(sbi, data_size);
> +	CLST len = alloc_size >> sbi->cluster_bits;
> +	const struct INDEX_NAMES *in = &s_index_names[indx->type];
> +	CLST alen;
> +	struct runs_tree run;
> +
> +	run_init(&run);
> +
> +	err = attr_allocate_clusters(sbi, &run, 0, 0, len, NULL, 0, &alen, 0,
> +				     NULL);

here

> +	if (err)
> +		goto out;
> +
> +	err = ni_insert_nonresident(ni, ATTR_ALLOC, in->name, in->name_len,
> +				    &run, 0, len, 0, &alloc, NULL);

[...]

> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> new file mode 100644
> index 000000000..c56343124
> --- /dev/null
> +++ b/fs/ntfs3/super.c

[...]

> +static int ntfs_sync_fs(struct super_block *sb, int wait)
> +{
> +	int err = 0, err2;
> +	struct ntfs_sb_info *sbi = sb->s_fs_info;
> +	struct ntfs_inode *ni;
> +	struct inode *inode;
> +
> +	ni = sbi->security.ni;
> +	if (ni) {
> +		inode = &ni->vfs_inode;
> +		err2 = _ni_write_inode(inode, wait);
> +		if (err2 && !err)

'err' is known to be 0 here, so this test can be simplified.

> +			err = err2;
> +	}
> +
> +	ni = sbi->objid.ni;
> +	if (ni) {
> +		inode = &ni->vfs_inode;
> +		err2 = _ni_write_inode(inode, wait);
> +		if (err2 && !err)
> +			err = err2;
> +	}

[...]
