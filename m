Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F673139091
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 13:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgAMMAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 07:00:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:50112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgAMMAw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:00:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3EC30AE17;
        Mon, 13 Jan 2020 12:00:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D25031E0D0E; Mon, 13 Jan 2020 13:00:49 +0100 (CET)
Date:   Mon, 13 Jan 2020 13:00:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [WIP PATCH 1/4] udf: Do not access LVIDIU revision members when
 they are not filled
Message-ID: <20200113120049.GF23642@quack2.suse.cz>
References: <20200112175933.5259-1-pali.rohar@gmail.com>
 <20200112175933.5259-2-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200112175933.5259-2-pali.rohar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 12-01-20 18:59:30, Pali Rohár wrote:
> minUDFReadRev, minUDFWriteRev and maxUDFWriteRev members were introduced in
> UDF 1.02. Previous UDF revisions used that area for implementation specific
> data. So in this case do not touch these members.
> 
> To check if LVIDIU contain revisions members, first read UDF revision from
> LVD. If revision is at least 1.02 LVIDIU should contain revision members.
> 
> This change should fix mounting UDF 1.01 images in R/W mode. Kernel would
> not touch, read overwrite implementation specific area of LVIDIU.
> 
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>

Maybe we could store the fs revision in the superblock as well to avoid
passing the udf_rev parameter?

Also this patch contains several lines over 80 columns.

									Honza

> ---
>  fs/udf/super.c  | 37 ++++++++++++++++++++++++++-----------
>  fs/udf/udf_sb.h |  3 +++
>  2 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 2d0b90800..8df6e9962 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -765,7 +765,7 @@ static int udf_check_vsd(struct super_block *sb)
>  }
>  
>  static int udf_verify_domain_identifier(struct super_block *sb,
> -					struct regid *ident, char *dname)
> +					struct regid *ident, char *dname, u16 *udf_rev)
>  {
>  	struct domainIdentSuffix *suffix;
>  
> @@ -779,6 +779,8 @@ static int udf_verify_domain_identifier(struct super_block *sb,
>  		goto force_ro;
>  	}
>  	suffix = (struct domainIdentSuffix *)ident->identSuffix;
> +	if (udf_rev)
> +		*udf_rev = le16_to_cpu(suffix->UDFRevision);
>  	if ((suffix->domainFlags & DOMAIN_FLAGS_HARD_WRITE_PROTECT) ||
>  	    (suffix->domainFlags & DOMAIN_FLAGS_SOFT_WRITE_PROTECT)) {
>  		if (!sb_rdonly(sb)) {
> @@ -801,7 +803,7 @@ static int udf_load_fileset(struct super_block *sb, struct fileSetDesc *fset,
>  {
>  	int ret;
>  
> -	ret = udf_verify_domain_identifier(sb, &fset->domainIdent, "file set");
> +	ret = udf_verify_domain_identifier(sb, &fset->domainIdent, "file set", NULL);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1404,7 +1406,7 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
>  	}
>  
>  	ret = udf_verify_domain_identifier(sb, &lvd->domainIdent,
> -					   "logical volume");
> +					   "logical volume", &sbi->s_lvd_udfrev);
>  	if (ret)
>  		goto out_bh;
>  	ret = udf_sb_alloc_partition_maps(sb, le32_to_cpu(lvd->numPartitionMaps));
> @@ -2055,12 +2057,19 @@ static void udf_close_lvid(struct super_block *sb)
>  	mutex_lock(&sbi->s_alloc_mutex);
>  	lvidiu->impIdent.identSuffix[0] = UDF_OS_CLASS_UNIX;
>  	lvidiu->impIdent.identSuffix[1] = UDF_OS_ID_LINUX;
> -	if (UDF_MAX_WRITE_VERSION > le16_to_cpu(lvidiu->maxUDFWriteRev))
> -		lvidiu->maxUDFWriteRev = cpu_to_le16(UDF_MAX_WRITE_VERSION);
> -	if (sbi->s_udfrev > le16_to_cpu(lvidiu->minUDFReadRev))
> -		lvidiu->minUDFReadRev = cpu_to_le16(sbi->s_udfrev);
> -	if (sbi->s_udfrev > le16_to_cpu(lvidiu->minUDFWriteRev))
> -		lvidiu->minUDFWriteRev = cpu_to_le16(sbi->s_udfrev);
> +
> +	/* minUDFReadRev, minUDFWriteRev and maxUDFWriteRev members were
> +	 * introduced in UDF 1.02. Previous UDF revisions used that area for
> +	 * implementation specific data. So in this case do not touch it. */
> +	if (sbi->s_lvd_udfrev >= 0x0102) {
> +		if (UDF_MAX_WRITE_VERSION > le16_to_cpu(lvidiu->maxUDFWriteRev))
> +			lvidiu->maxUDFWriteRev = cpu_to_le16(UDF_MAX_WRITE_VERSION);
> +		if (sbi->s_udfrev > le16_to_cpu(lvidiu->minUDFReadRev))
> +			lvidiu->minUDFReadRev = cpu_to_le16(sbi->s_udfrev);
> +		if (sbi->s_udfrev > le16_to_cpu(lvidiu->minUDFWriteRev))
> +			lvidiu->minUDFWriteRev = cpu_to_le16(sbi->s_udfrev);
> +	}
> +
>  	if (!UDF_QUERY_FLAG(sb, UDF_FLAG_INCONSISTENT))
>  		lvid->integrityType = cpu_to_le32(LVID_INTEGRITY_TYPE_CLOSE);
>  
> @@ -2220,8 +2229,14 @@ static int udf_fill_super(struct super_block *sb, void *options, int silent)
>  			ret = -EINVAL;
>  			goto error_out;
>  		}
> -		minUDFReadRev = le16_to_cpu(lvidiu->minUDFReadRev);
> -		minUDFWriteRev = le16_to_cpu(lvidiu->minUDFWriteRev);
> +
> +		if (sbi->s_lvd_udfrev >= 0x0102) { /* minUDFReadRev and minUDFWriteRev were introduced in UDF 1.02 */
> +			minUDFReadRev = le16_to_cpu(lvidiu->minUDFReadRev);
> +			minUDFWriteRev = le16_to_cpu(lvidiu->minUDFWriteRev);
> +		} else {
> +			minUDFReadRev = minUDFWriteRev = sbi->s_lvd_udfrev;
> +		}
> +
>  		if (minUDFReadRev > UDF_MAX_READ_VERSION) {
>  			udf_err(sb, "minUDFReadRev=%x (max is %x)\n",
>  				minUDFReadRev,
> diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
> index 3d83be54c..6bd0d4430 100644
> --- a/fs/udf/udf_sb.h
> +++ b/fs/udf/udf_sb.h
> @@ -137,6 +137,9 @@ struct udf_sb_info {
>  	/* Fileset Info */
>  	__u16			s_serial_number;
>  
> +	/* LVD UDF revision filled to media at format time */
> +	__u16			s_lvd_udfrev;
> +
>  	/* highest UDF revision we have recorded to this media */
>  	__u16			s_udfrev;
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
