Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F38139080
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 12:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgAML6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 06:58:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:49292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgAML6Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:58:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AD415AE17;
        Mon, 13 Jan 2020 11:58:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 493401E0D0E; Mon, 13 Jan 2020 12:58:22 +0100 (CET)
Date:   Mon, 13 Jan 2020 12:58:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [WIP PATCH 2/4] udf: Fix reading numFiles and numDirs from UDF
 2.00+ VAT discs
Message-ID: <20200113115822.GE23642@quack2.suse.cz>
References: <20200112175933.5259-1-pali.rohar@gmail.com>
 <20200112175933.5259-3-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200112175933.5259-3-pali.rohar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 12-01-20 18:59:31, Pali Rohár wrote:
> These two fields are stored in VAT and override previous values stored in
> LVIDIU.
> 
> This change contains only implementation for UDF 2.00+. For UDF 1.50 there
> is an optional structure "Logical Volume Extended Information" which is not
> implemented in this change yet.
> 
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>

For this and the following patch, I'd rather have the 'additional data'
like number of files, dirs, or revisions, stored in the superblock than
having them hidden in the VAT partition structure. And places that parse
corresponding on-disk structures would fill in the numbers into the
superblock.

								Honza
> ---
>  fs/udf/super.c  | 25 ++++++++++++++++++++++---
>  fs/udf/udf_sb.h |  3 +++
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 8df6e9962..e8661bf01 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -1202,6 +1202,8 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
>  		map->s_type_specific.s_virtual.s_start_offset = 0;
>  		map->s_type_specific.s_virtual.s_num_entries =
>  			(sbi->s_vat_inode->i_size - 36) >> 2;
> +		/* TODO: Add support for reading Logical Volume Extended Information (UDF 1.50 Errata, DCN 5003, 3.3.4.5.1.3) */
> +		map->s_type_specific.s_virtual.s_has_additional_data = false;
>  	} else if (map->s_partition_type == UDF_VIRTUAL_MAP20) {
>  		vati = UDF_I(sbi->s_vat_inode);
>  		if (vati->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
> @@ -1215,6 +1217,12 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
>  							vati->i_ext.i_data;
>  		}
>  
> +		map->s_type_specific.s_virtual.s_has_additional_data =
> +			true;
> +		map->s_type_specific.s_virtual.s_num_files =
> +			le32_to_cpu(vat20->numFiles);
> +		map->s_type_specific.s_virtual.s_num_dirs =
> +			le32_to_cpu(vat20->numDirs);
>  		map->s_type_specific.s_virtual.s_start_offset =
>  			le16_to_cpu(vat20->lengthHeader);
>  		map->s_type_specific.s_virtual.s_num_entries =
> @@ -2417,9 +2425,20 @@ static int udf_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	buf->f_blocks = sbi->s_partmaps[sbi->s_partition].s_partition_len;
>  	buf->f_bfree = udf_count_free(sb);
>  	buf->f_bavail = buf->f_bfree;
> -	buf->f_files = (lvidiu != NULL ? (le32_to_cpu(lvidiu->numFiles) +
> -					  le32_to_cpu(lvidiu->numDirs)) : 0)
> -			+ buf->f_bfree;
> +
> +	if ((sbi->s_partmaps[sbi->s_partition].s_partition_type == UDF_VIRTUAL_MAP15 ||
> +	     sbi->s_partmaps[sbi->s_partition].s_partition_type == UDF_VIRTUAL_MAP20) &&
> +	     sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.s_has_additional_data)
> +		buf->f_files = sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.s_num_files +
> +			       sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.s_num_dirs +
> +			       buf->f_bfree;
> +	else if (lvidiu != NULL)
> +		buf->f_files = le32_to_cpu(lvidiu->numFiles) +
> +			       le32_to_cpu(lvidiu->numDirs) +
> +			       buf->f_bfree;
> +	else
> +		buf->f_files = buf->f_bfree;
> +
>  	buf->f_ffree = buf->f_bfree;
>  	buf->f_namelen = UDF_NAME_LEN;
>  	buf->f_fsid.val[0] = (u32)id;
> diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
> index 6bd0d4430..c74abbc84 100644
> --- a/fs/udf/udf_sb.h
> +++ b/fs/udf/udf_sb.h
> @@ -78,6 +78,9 @@ struct udf_sparing_data {
>  struct udf_virtual_data {
>  	__u32	s_num_entries;
>  	__u16	s_start_offset;
> +	bool	s_has_additional_data;
> +	__u32	s_num_files;
> +	__u32	s_num_dirs;
>  };
>  
>  struct udf_bitmap {
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
