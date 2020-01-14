Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F4913A82E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 12:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgANLST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 06:18:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:49342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgANLST (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:18:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7A85AC54;
        Tue, 14 Jan 2020 11:18:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AB5771E0D0E; Tue, 14 Jan 2020 12:18:17 +0100 (CET)
Date:   Tue, 14 Jan 2020 12:18:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [WIP PATCH 2/4] udf: Fix reading numFiles and numDirs from UDF
 2.00+ VAT discs
Message-ID: <20200114111817.GF6466@quack2.suse.cz>
References: <20200112175933.5259-1-pali.rohar@gmail.com>
 <20200112175933.5259-3-pali.rohar@gmail.com>
 <20200113115822.GE23642@quack2.suse.cz>
 <20200113181138.iqmo33ml2kpnmsfo@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113181138.iqmo33ml2kpnmsfo@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-01-20 19:11:38, Pali Rohár wrote:
> On Monday 13 January 2020 12:58:22 Jan Kara wrote:
> > On Sun 12-01-20 18:59:31, Pali Rohár wrote:
> > > These two fields are stored in VAT and override previous values stored in
> > > LVIDIU.
> > > 
> > > This change contains only implementation for UDF 2.00+. For UDF 1.50 there
> > > is an optional structure "Logical Volume Extended Information" which is not
> > > implemented in this change yet.
> > > 
> > > Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
> > 
> > For this and the following patch, I'd rather have the 'additional data'
> > like number of files, dirs, or revisions, stored in the superblock than
> > having them hidden in the VAT partition structure. And places that parse
> > corresponding on-disk structures would fill in the numbers into the
> > superblock.
> 
> This is not simple. Kernel first reads and parses VAT and later parses
> LVIDIU. VAT is optional UDF feature and in UDF 1.50 are even those data
> optional.
> 
> Logic for determining minimal write UDF revision is currently in code
> which parse LVIDIU. And this is the only place which needs access UDF
> revisions stored in VAT and LVIDIU.
> 
> UDF revision from LVD is already stored into superblock.
> 
> And because VAT is parsed prior to parsing LVIDIU is is also not easy to
> store number of files and directories into superblock. LVIDIU needs to
> know if data from VAT were loaded to superblock or not and needs to know
> if data from LVIDIU should be stored into superblock or not.
> 
> Any idea how to do it without complicating whole code?

Let's take the discussion about revision storage to the thread about the
other patch. But for number of directories and files I was thinking like:

We could initialize values in the superblock to -1 (or whatever invalid
value - define a constant for it). The first place that has valid values
available (detected by the superblock having still invalid values) stores them
in the superblock. We are guaranteed to parse VAT before LVIDIU because we
need VAT to locate LVIDIU in the first place so this logic should be
reliable.

And later when using the values, we can also easily check whether we
actually have sensible values available in the first place...

								Honza

> > >  fs/udf/super.c  | 25 ++++++++++++++++++++++---
> > >  fs/udf/udf_sb.h |  3 +++
> > >  2 files changed, 25 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/udf/super.c b/fs/udf/super.c
> > > index 8df6e9962..e8661bf01 100644
> > > --- a/fs/udf/super.c
> > > +++ b/fs/udf/super.c
> > > @@ -1202,6 +1202,8 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
> > >  		map->s_type_specific.s_virtual.s_start_offset = 0;
> > >  		map->s_type_specific.s_virtual.s_num_entries =
> > >  			(sbi->s_vat_inode->i_size - 36) >> 2;
> > > +		/* TODO: Add support for reading Logical Volume Extended Information (UDF 1.50 Errata, DCN 5003, 3.3.4.5.1.3) */
> > > +		map->s_type_specific.s_virtual.s_has_additional_data = false;
> > >  	} else if (map->s_partition_type == UDF_VIRTUAL_MAP20) {
> > >  		vati = UDF_I(sbi->s_vat_inode);
> > >  		if (vati->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
> > > @@ -1215,6 +1217,12 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
> > >  							vati->i_ext.i_data;
> > >  		}
> > >  
> > > +		map->s_type_specific.s_virtual.s_has_additional_data =
> > > +			true;
> > > +		map->s_type_specific.s_virtual.s_num_files =
> > > +			le32_to_cpu(vat20->numFiles);
> > > +		map->s_type_specific.s_virtual.s_num_dirs =
> > > +			le32_to_cpu(vat20->numDirs);
> > >  		map->s_type_specific.s_virtual.s_start_offset =
> > >  			le16_to_cpu(vat20->lengthHeader);
> > >  		map->s_type_specific.s_virtual.s_num_entries =
> > > @@ -2417,9 +2425,20 @@ static int udf_statfs(struct dentry *dentry, struct kstatfs *buf)
> > >  	buf->f_blocks = sbi->s_partmaps[sbi->s_partition].s_partition_len;
> > >  	buf->f_bfree = udf_count_free(sb);
> > >  	buf->f_bavail = buf->f_bfree;
> > > -	buf->f_files = (lvidiu != NULL ? (le32_to_cpu(lvidiu->numFiles) +
> > > -					  le32_to_cpu(lvidiu->numDirs)) : 0)
> > > -			+ buf->f_bfree;
> > > +
> > > +	if ((sbi->s_partmaps[sbi->s_partition].s_partition_type == UDF_VIRTUAL_MAP15 ||
> > > +	     sbi->s_partmaps[sbi->s_partition].s_partition_type == UDF_VIRTUAL_MAP20) &&
> > > +	     sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.s_has_additional_data)
> > > +		buf->f_files = sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.s_num_files +
> > > +			       sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.s_num_dirs +
> > > +			       buf->f_bfree;
> > > +	else if (lvidiu != NULL)
> > > +		buf->f_files = le32_to_cpu(lvidiu->numFiles) +
> > > +			       le32_to_cpu(lvidiu->numDirs) +
> > > +			       buf->f_bfree;
> > > +	else
> > > +		buf->f_files = buf->f_bfree;
> > > +
> > >  	buf->f_ffree = buf->f_bfree;
> > >  	buf->f_namelen = UDF_NAME_LEN;
> > >  	buf->f_fsid.val[0] = (u32)id;
> > > diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
> > > index 6bd0d4430..c74abbc84 100644
> > > --- a/fs/udf/udf_sb.h
> > > +++ b/fs/udf/udf_sb.h
> > > @@ -78,6 +78,9 @@ struct udf_sparing_data {
> > >  struct udf_virtual_data {
> > >  	__u32	s_num_entries;
> > >  	__u16	s_start_offset;
> > > +	bool	s_has_additional_data;
> > > +	__u32	s_num_files;
> > > +	__u32	s_num_dirs;
> > >  };
> > >  
> > >  struct udf_bitmap {
> > > -- 
> > > 2.20.1
> > > 
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
