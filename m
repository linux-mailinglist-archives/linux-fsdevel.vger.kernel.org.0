Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480B7735094
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 11:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjFSJlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 05:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFSJlk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:41:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE59AF;
        Mon, 19 Jun 2023 02:41:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59D6B60A2B;
        Mon, 19 Jun 2023 09:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B8CC433C0;
        Mon, 19 Jun 2023 09:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687167697;
        bh=JPP0ry2uSWQZJydpPH9yezDhLuZp/NJUKm1C2dIlEUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKMi9pwvVX+EnBt6hmSZBq8q420kMIUNgTTIIWzsE8zO14/gOj763qbheI2ctRM9l
         IT7kY0wB7l5ilE6+u8nzeSu2m1BLwsKt6mziqtXyqVd07zoHvjlrfjrJsrHqJjShZC
         kyBngEpFEyUsTVfUgrZTYp3Ji39ZY0JEpTlpc6eMEnfbWlrvj36Zm8NjbKxL5lN5xy
         jY+WLe9GMxuQwuXaF9utiLkOJWsd97FK1sLdRFcTaOPB3RMJvO6MwAKfTRAaKWCmAe
         1dL5fjf4rAAZJbFFucDWUcZgEYhTotT6FSkDXC85CYPO8Q0qNzlkRyF2fmVC0aJ5fN
         Jv/CH1qrGvvXg==
Date:   Mon, 19 Jun 2023 10:41:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/14] fs/ntfs3: Check fields while reading
Message-ID: <20230619094133.GA1500182@google.com>
References: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
 <0ec81044-062c-29e0-c081-dff9484f0368@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ec81044-062c-29e0-c081-dff9484f0368@paragon-software.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 28 Oct 2022, Konstantin Komarov wrote:

> Added new functions index_hdr_check and index_buf_check.
> Now we check all stuff for correctness while reading from disk.
> Also fixed bug with stale nfs data.
> 
> Reported-by: van fantasy <g1042620637@gmail.com>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/index.c   |  84 ++++++++++++++++++++++++++++++----
>  fs/ntfs3/inode.c   |  18 ++++----
>  fs/ntfs3/ntfs_fs.h |   4 +-
>  fs/ntfs3/run.c     |   7 ++-
>  fs/ntfs3/xattr.c   | 109 +++++++++++++++++++++++++++++----------------
>  5 files changed, 164 insertions(+), 58 deletions(-)

It's not clear to me what route this patch took into Mainline [0].  My
guess it was authored by and then merged by the maintainer after no one
raised any review comments.

It does appear that this particular patch was identified as the fix for
a published CVE however [1], and with no Fixes: tag I'm concerned that
the Stable AUTOSEL bot may miss this.  With that in mind, would you mind
submitting to the relevant Stable branches please?  [2] contains all of
the relevant information if you're not 100% certain of the process.

Thank you.

[0] 0e8235d28f3a0 fs/ntfs3: Check fields while reading
[1] https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-48502
[2] Documentation/process/stable-kernel-rules.rst

> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 35369ae5c438..51ab75954640 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -605,11 +605,58 @@ static const struct NTFS_DE *hdr_insert_head(struct INDEX_HDR *hdr,
>  	return e;
>  }
> +/*
> + * index_hdr_check
> + *
> + * return true if INDEX_HDR is valid
> + */
> +static bool index_hdr_check(const struct INDEX_HDR *hdr, u32 bytes)
> +{
> +	u32 end = le32_to_cpu(hdr->used);
> +	u32 tot = le32_to_cpu(hdr->total);
> +	u32 off = le32_to_cpu(hdr->de_off);
> +
> +	if (!IS_ALIGNED(off, 8) || tot > bytes || end > tot ||
> +	    off + sizeof(struct NTFS_DE) > end) {
> +		/* incorrect index buffer. */
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * index_buf_check
> + *
> + * return true if INDEX_BUFFER seems is valid
> + */
> +static bool index_buf_check(const struct INDEX_BUFFER *ib, u32 bytes,
> +			    const CLST *vbn)
> +{
> +	const struct NTFS_RECORD_HEADER *rhdr = &ib->rhdr;
> +	u16 fo = le16_to_cpu(rhdr->fix_off);
> +	u16 fn = le16_to_cpu(rhdr->fix_num);
> +
> +	if (bytes <= offsetof(struct INDEX_BUFFER, ihdr) ||
> +	    rhdr->sign != NTFS_INDX_SIGNATURE ||
> +	    fo < sizeof(struct INDEX_BUFFER)
> +	    /* Check index buffer vbn. */
> +	    || (vbn && *vbn != le64_to_cpu(ib->vbn)) || (fo % sizeof(short)) ||
> +	    fo + fn * sizeof(short) >= bytes ||
> +	    fn != ((bytes >> SECTOR_SHIFT) + 1)) {
> +		/* incorrect index buffer. */
> +		return false;
> +	}
> +
> +	return index_hdr_check(&ib->ihdr,
> +			       bytes - offsetof(struct INDEX_BUFFER, ihdr));
> +}
> +
>  void fnd_clear(struct ntfs_fnd *fnd)
>  {
>  	int i;
> -	for (i = 0; i < fnd->level; i++) {
> +	for (i = fnd->level - 1; i >= 0; i--) {
>  		struct indx_node *n = fnd->nodes[i];
>  		if (!n)
> @@ -819,9 +866,16 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
>  	u32 t32;
>  	const struct INDEX_ROOT *root = resident_data(attr);
> +	t32 = le32_to_cpu(attr->res.data_size);
> +	if (t32 <= offsetof(struct INDEX_ROOT, ihdr) ||
> +	    !index_hdr_check(&root->ihdr,
> +			     t32 - offsetof(struct INDEX_ROOT, ihdr))) {
> +		goto out;
> +	}
> +
>  	/* Check root fields. */
>  	if (!root->index_block_clst)
> -		return -EINVAL;
> +		goto out;
>  	indx->type = type;
>  	indx->idx2vbn_bits = __ffs(root->index_block_clst);
> @@ -833,19 +887,19 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
>  	if (t32 < sbi->cluster_size) {
>  		/* Index record is smaller than a cluster, use 512 blocks. */
>  		if (t32 != root->index_block_clst * SECTOR_SIZE)
> -			return -EINVAL;
> +			goto out;
>  		/* Check alignment to a cluster. */
>  		if ((sbi->cluster_size >> SECTOR_SHIFT) &
>  		    (root->index_block_clst - 1)) {
> -			return -EINVAL;
> +			goto out;
>  		}
>  		indx->vbn2vbo_bits = SECTOR_SHIFT;
>  	} else {
>  		/* Index record must be a multiple of cluster size. */
>  		if (t32 != root->index_block_clst << sbi->cluster_bits)
> -			return -EINVAL;
> +			goto out;
>  		indx->vbn2vbo_bits = sbi->cluster_bits;
>  	}
> @@ -853,7 +907,14 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
>  	init_rwsem(&indx->run_lock);
>  	indx->cmp = get_cmp_func(root);
> -	return indx->cmp ? 0 : -EINVAL;
> +	if (!indx->cmp)
> +		goto out;
> +
> +	return 0;
> +
> +out:
> +	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
> +	return -EINVAL;
>  }
>  static struct indx_node *indx_new(struct ntfs_index *indx,
> @@ -1011,6 +1072,13 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
>  		goto out;
>  ok:
> +	if (!index_buf_check(ib, bytes, &vbn)) {
> +		ntfs_inode_err(&ni->vfs_inode, "directory corrupted");
> +		ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>  	if (err == -E_NTFS_FIXUP) {
>  		ntfs_write_bh(ni->mi.sbi, &ib->rhdr, &in->nb, 0);
>  		err = 0;
> @@ -1601,9 +1669,9 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  	if (err) {
>  		/* Restore root. */
> -		if (mi_resize_attr(mi, attr, -ds_root))
> +		if (mi_resize_attr(mi, attr, -ds_root)) {
>  			memcpy(attr, a_root, asize);
> -		else {
> +		} else {
>  			/* Bug? */
>  			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
>  		}
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 78ec3e6bbf67..719cf6fbb5ed 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -81,7 +81,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>  			 le16_to_cpu(ref->seq), le16_to_cpu(rec->seq));
>  		goto out;
>  	} else if (!is_rec_inuse(rec)) {
> -		err = -EINVAL;
> +		err = -ESTALE;
>  		ntfs_err(sb, "Inode r=%x is not in use!", (u32)ino);
>  		goto out;
>  	}
> @@ -92,8 +92,10 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>  		goto out;
>  	}
> -	if (!is_rec_base(rec))
> -		goto Ok;
> +	if (!is_rec_base(rec)) {
> +		err = -EINVAL;
> +		goto out;
> +	}
>  	/* Record should contain $I30 root. */
>  	is_dir = rec->flags & RECORD_FLAG_DIR;
> @@ -465,7 +467,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
>  		inode->i_flags |= S_NOSEC;
>  	}
> -Ok:
>  	if (ino == MFT_REC_MFT && !sb->s_root)
>  		sbi->mft.ni = NULL;
> @@ -519,6 +520,9 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
>  		_ntfs_bad_inode(inode);
>  	}
> +	if (IS_ERR(inode) && name)
> +		ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
> +
>  	return inode;
>  }
> @@ -1652,10 +1656,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>  		ntfs_remove_reparse(sbi, IO_REPARSE_TAG_SYMLINK, &new_de->ref);
>  out5:
> -	if (S_ISDIR(mode) || run_is_empty(&ni->file.run))
> -		goto out4;
> -
> -	run_deallocate(sbi, &ni->file.run, false);
> +	if (!S_ISDIR(mode))
> +		run_deallocate(sbi, &ni->file.run, false);
>  out4:
>  	clear_rec_inuse(rec);
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index d73d1c837ba7..c9b8a6f1ba0b 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -795,12 +795,12 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
>  	     u32 run_buf_size, CLST *packed_vcns);
>  int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
>  	       CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
> -	       u32 run_buf_size);
> +	       int run_buf_size);
>  #ifdef NTFS3_CHECK_FREE_CLST
>  int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
>  		  CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
> -		  u32 run_buf_size);
> +		  int run_buf_size);
>  #else
>  #define run_unpack_ex run_unpack
>  #endif
> diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
> index aaaa0d3d35a2..12d8682f33b5 100644
> --- a/fs/ntfs3/run.c
> +++ b/fs/ntfs3/run.c
> @@ -919,12 +919,15 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
>   */
>  int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
>  	       CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
> -	       u32 run_buf_size)
> +	       int run_buf_size)
>  {
>  	u64 prev_lcn, vcn64, lcn, next_vcn;
>  	const u8 *run_last, *run_0;
>  	bool is_mft = ino == MFT_REC_MFT;
> +	if (run_buf_size < 0)
> +		return -EINVAL;
> +
>  	/* Check for empty. */
>  	if (evcn + 1 == svcn)
>  		return 0;
> @@ -1046,7 +1049,7 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
>   */
>  int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
>  		  CLST svcn, CLST evcn, CLST vcn, const u8 *run_buf,
> -		  u32 run_buf_size)
> +		  int run_buf_size)
>  {
>  	int ret, err;
>  	CLST next_vcn, lcn, len;
> diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
> index aeee5fb12092..385c50831a8d 100644
> --- a/fs/ntfs3/xattr.c
> +++ b/fs/ntfs3/xattr.c
> @@ -42,28 +42,26 @@ static inline size_t packed_ea_size(const struct EA_FULL *ea)
>   * Assume there is at least one xattr in the list.
>   */
>  static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
> -			   const char *name, u8 name_len, u32 *off)
> +			   const char *name, u8 name_len, u32 *off, u32 *ea_sz)
>  {
> -	*off = 0;
> +	u32 ea_size;
> -	if (!ea_all || !bytes)
> +	*off = 0;
> +	if (!ea_all)
>  		return false;
> -	for (;;) {
> +	for (; *off < bytes; *off += ea_size) {
>  		const struct EA_FULL *ea = Add2Ptr(ea_all, *off);
> -		u32 next_off = *off + unpacked_ea_size(ea);
> -
> -		if (next_off > bytes)
> -			return false;
> -
> +		ea_size = unpacked_ea_size(ea);
>  		if (ea->name_len == name_len &&
> -		    !memcmp(ea->name, name, name_len))
> +		    !memcmp(ea->name, name, name_len)) {
> +			if (ea_sz)
> +				*ea_sz = ea_size;
>  			return true;
> -
> -		*off = next_off;
> -		if (next_off >= bytes)
> -			return false;
> +		}
>  	}
> +
> +	return false;
>  }
>  /*
> @@ -74,12 +72,12 @@ static inline bool find_ea(const struct EA_FULL *ea_all, u32 bytes,
>  static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
>  			size_t add_bytes, const struct EA_INFO **info)
>  {
> -	int err;
> +	int err = -EINVAL;
>  	struct ntfs_sb_info *sbi = ni->mi.sbi;
>  	struct ATTR_LIST_ENTRY *le = NULL;
>  	struct ATTRIB *attr_info, *attr_ea;
>  	void *ea_p;
> -	u32 size;
> +	u32 size, off, ea_size;
>  	static_assert(le32_to_cpu(ATTR_EA_INFO) < le32_to_cpu(ATTR_EA));
> @@ -96,24 +94,31 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
>  	*info = resident_data_ex(attr_info, sizeof(struct EA_INFO));
>  	if (!*info)
> -		return -EINVAL;
> +		goto out;
>  	/* Check Ea limit. */
>  	size = le32_to_cpu((*info)->size);
> -	if (size > sbi->ea_max_size)
> -		return -EFBIG;
> +	if (size > sbi->ea_max_size) {
> +		err = -EFBIG;
> +		goto out;
> +	}
> +
> +	if (attr_size(attr_ea) > sbi->ea_max_size) {
> +		err = -EFBIG;
> +		goto out;
> +	}
> -	if (attr_size(attr_ea) > sbi->ea_max_size)
> -		return -EFBIG;
> +	if (!size) {
> +		/* EA info persists, but xattr is empty. Looks like EA problem. */
> +		goto out;
> +	}
>  	/* Allocate memory for packed Ea. */
>  	ea_p = kmalloc(size_add(size, add_bytes), GFP_NOFS);
>  	if (!ea_p)
>  		return -ENOMEM;
> -	if (!size) {
> -		/* EA info persists, but xattr is empty. Looks like EA problem. */
> -	} else if (attr_ea->non_res) {
> +	if (attr_ea->non_res) {
>  		struct runs_tree run;
>  		run_init(&run);
> @@ -124,24 +129,52 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
>  		run_close(&run);
>  		if (err)
> -			goto out;
> +			goto out1;
>  	} else {
>  		void *p = resident_data_ex(attr_ea, size);
> -		if (!p) {
> -			err = -EINVAL;
> -			goto out;
> -		}
> +		if (!p)
> +			goto out1;
>  		memcpy(ea_p, p, size);
>  	}
>  	memset(Add2Ptr(ea_p, size), 0, add_bytes);
> +
> +	/* Check all attributes for consistency. */
> +	for (off = 0; off < size; off += ea_size) {
> +		const struct EA_FULL *ef = Add2Ptr(ea_p, off);
> +		u32 bytes = size - off;
> +
> +		/* Check if we can use field ea->size. */
> +		if (bytes < sizeof(ef->size))
> +			goto out1;
> +
> +		if (ef->size) {
> +			ea_size = le32_to_cpu(ef->size);
> +			if (ea_size > bytes)
> +				goto out1;
> +			continue;
> +		}
> +
> +		/* Check if we can use fields ef->name_len and ef->elength. */
> +		if (bytes < offsetof(struct EA_FULL, name))
> +			goto out1;
> +
> +		ea_size = ALIGN(struct_size(ef, name,
> +					    1 + ef->name_len +
> +						    le16_to_cpu(ef->elength)),
> +				4);
> +		if (ea_size > bytes)
> +			goto out1;
> +	}
> +
>  	*ea = ea_p;
>  	return 0;
> -out:
> +out1:
>  	kfree(ea_p);
> -	*ea = NULL;
> +out:
> +	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
>  	return err;
>  }
> @@ -163,6 +196,7 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
>  	const struct EA_FULL *ea;
>  	u32 off, size;
>  	int err;
> +	int ea_size;
>  	size_t ret;
>  	err = ntfs_read_ea(ni, &ea_all, 0, &info);
> @@ -175,8 +209,9 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
>  	size = le32_to_cpu(info->size);
>  	/* Enumerate all xattrs. */
> -	for (ret = 0, off = 0; off < size; off += unpacked_ea_size(ea)) {
> +	for (ret = 0, off = 0; off < size; off += ea_size) {
>  		ea = Add2Ptr(ea_all, off);
> +		ea_size = unpacked_ea_size(ea);
>  		if (buffer) {
>  			if (ret + ea->name_len + 1 > bytes_per_buffer) {
> @@ -227,7 +262,8 @@ static int ntfs_get_ea(struct inode *inode, const char *name, size_t name_len,
>  		goto out;
>  	/* Enumerate all xattrs. */
> -	if (!find_ea(ea_all, le32_to_cpu(info->size), name, name_len, &off)) {
> +	if (!find_ea(ea_all, le32_to_cpu(info->size), name, name_len, &off,
> +		     NULL)) {
>  		err = -ENODATA;
>  		goto out;
>  	}
> @@ -269,7 +305,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
>  	struct EA_FULL *new_ea;
>  	struct EA_FULL *ea_all = NULL;
>  	size_t add, new_pack;
> -	u32 off, size;
> +	u32 off, size, ea_sz;
>  	__le16 size_pack;
>  	struct ATTRIB *attr;
>  	struct ATTR_LIST_ENTRY *le;
> @@ -304,9 +340,8 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
>  		size_pack = ea_info.size_pack;
>  	}
> -	if (info && find_ea(ea_all, size, name, name_len, &off)) {
> +	if (info && find_ea(ea_all, size, name, name_len, &off, &ea_sz)) {
>  		struct EA_FULL *ea;
> -		size_t ea_sz;
>  		if (flags & XATTR_CREATE) {
>  			err = -EEXIST;
> @@ -329,8 +364,6 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
>  		if (ea->flags & FILE_NEED_EA)
>  			le16_add_cpu(&ea_info.count, -1);
> -		ea_sz = unpacked_ea_size(ea);
> -
>  		le16_add_cpu(&ea_info.size_pack, 0 - packed_ea_size(ea));
>  		memmove(ea, Add2Ptr(ea, ea_sz), size - off - ea_sz);
> -- 
> 2.37.0
> 
> 

-- 
Lee Jones [李琼斯]
