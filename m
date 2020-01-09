Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC562135ED1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 17:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbgAIQ7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 11:59:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:46026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731320AbgAIQ7l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:59:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4803CAE03;
        Thu,  9 Jan 2020 16:59:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 666A21E0798; Thu,  9 Jan 2020 17:53:24 +0100 (CET)
Date:   Thu, 9 Jan 2020 17:53:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] udf: Fix free space reporting for metadata and virtual
 partitions
Message-ID: <20200109165324.GA6145@quack2.suse.cz>
References: <20200108121919.12343-1-jack@suse.cz>
 <20200108223240.gi5g2jza3rxuzk6z@pali>
 <20200109124405.GE22232@quack2.suse.cz>
 <20200109125657.ir264jcd6oujox3a@pali>
 <20200109130837.b6f62jpeb3myns64@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200109130837.b6f62jpeb3myns64@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 09-01-20 14:08:37, Pali Rohár wrote:
> On Thursday 09 January 2020 13:56:57 Pali Rohár wrote:
> > On Thursday 09 January 2020 13:44:05 Jan Kara wrote:
> > > On Wed 08-01-20 23:32:40, Pali Rohár wrote:
> > > > On Wednesday 08 January 2020 13:19:19 Jan Kara wrote:
> > > > > Free space on filesystems with metadata or virtual partition maps
> > > > > currently gets misreported. This is because these partitions are just
> > > > > remapped onto underlying real partitions from which keep track of free
> > > > > blocks. Take this remapping into account when counting free blocks as
> > > > > well.
> > > > > 
> > > > > Reported-by: Pali Rohár <pali.rohar@gmail.com>
> > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > > ---
> > > > >  fs/udf/super.c | 19 ++++++++++++++-----
> > > > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > > > > 
> > > > > I plan to take this patch to my tree.
> > > > > 
> > > > > diff --git a/fs/udf/super.c b/fs/udf/super.c
> > > > > index 8c28e93e9b73..b89e420a4b85 100644
> > > > > --- a/fs/udf/super.c
> > > > > +++ b/fs/udf/super.c
> > > > > @@ -2492,17 +2492,26 @@ static unsigned int udf_count_free_table(struct super_block *sb,
> > > > >  static unsigned int udf_count_free(struct super_block *sb)
> > > > >  {
> > > > >  	unsigned int accum = 0;
> > > > > -	struct udf_sb_info *sbi;
> > > > > +	struct udf_sb_info *sbi = UDF_SB(sb);
> > > > >  	struct udf_part_map *map;
> > > > > +	unsigned int part = sbi->s_partition;
> > > > > +	int ptype = sbi->s_partmaps[part].s_partition_type;
> > > > > +
> > > > > +	if (ptype == UDF_METADATA_MAP25) {
> > > > > +		part = sbi->s_partmaps[part].s_type_specific.s_metadata.
> > > > > +							s_phys_partition_ref;
> > > > > +	} else if (ptype == UDF_VIRTUAL_MAP15 || ptype == UDF_VIRTUAL_MAP20) {
> > > > > +		part = UDF_I(sbi->s_vat_inode)->i_location.
> > > > > +							partitionReferenceNum;
> > > > 
> > > > Hello! I do not think that it make sense to report "free blocks" for
> > > > discs with Virtual partition. By definition of VAT, all blocks prior to
> > > > VAT are already "read-only" and therefore these blocks cannot be use for
> > > > writing new data by any implementation. And because VAT is stored on the
> > > > last block, in our model all blocks are "occupied".
> > > 
> > > Fair enough. Let's just always return 0 for disks with VAT partition.
> > > 
> > > > > +	}
> > > > >  
> > > > > -	sbi = UDF_SB(sb);
> > > > >  	if (sbi->s_lvid_bh) {
> > > > >  		struct logicalVolIntegrityDesc *lvid =
> > > > >  			(struct logicalVolIntegrityDesc *)
> > > > >  			sbi->s_lvid_bh->b_data;
> > > > > -		if (le32_to_cpu(lvid->numOfPartitions) > sbi->s_partition) {
> > > > > +		if (le32_to_cpu(lvid->numOfPartitions) > part) {
> > > > >  			accum = le32_to_cpu(
> > > > > -					lvid->freeSpaceTable[sbi->s_partition]);
> > > > > +					lvid->freeSpaceTable[part]);
> > > > 
> > > > And in any case freeSpaceTable should not be used for discs with VAT.
> > > > And we should ignore its value for discs with VAT.
> > > > 
> > > > UDF 2.60 2.2.6.2: Free Space Table values be maintained ... except ...
> > > > for a virtual partition ...
> > > > 
> > > > And same applies for "partition with Access Type pseudo-overwritable".
> > > 
> > > Well this is handled by the 'accum == 0xffffffff' condition below. So we
> > > effectively ignore these values.
> > 
> > Ok.
> 
> Now I'm thinking about another scenario: UDF allows you to have two
> partitions of Type1 (physical) on one volume: one with read-only access
> type and one with overwritable access type.
> 
> UDF 2.60 2.2.6.2 says: For a partition with Access Type read-only, the
> Free Space Table value shall be set to zero. And therefore we should
> ignore it.

That's what's going to happen (the code ends up ignoring values -1 and 0).

> But current implementation for discs without Metadata partition (all
> with UDF 2.01) reads free space table (only) from partition
> 
>   unsigned int part = sbi->s_partition;
> 
> So is this s_partition one with read-only or overwritable access type?

Well, this is the partition we've got fileset from. I presume that's going
to be on overwritable partition but who knows. Honestly, I have my doubts
we'll handle disks with two Type1 partitions correctly since I never met
such disks :) Do you have some disk image to try? :)

> And to make it more complicated, UDF 2.60 2.2.10 requires that such discs
> (with two partitions) needs to have also Metadata Partition Map.

But in this case Metadata Partition Map is presumably over the overwritable
partition so we should fine, shouldn't we?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
