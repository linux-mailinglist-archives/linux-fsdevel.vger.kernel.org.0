Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0019F2A3F76
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 09:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgKCI5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 03:57:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:35140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgKCI5D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:57:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89B5DAD5C;
        Tue,  3 Nov 2020 08:57:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 145051E12FB; Tue,  3 Nov 2020 09:57:00 +0100 (CET)
Date:   Tue, 3 Nov 2020 09:57:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] quota: Don't overflow quota file offsets
Message-ID: <20201103085700.GA3440@quack2.suse.cz>
References: <20201102172733.23444-1-jack@suse.cz>
 <20201102172733.23444-2-jack@suse.cz>
 <30045F3F-B103-48DC-A14B-C16D08B32F9D@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30045F3F-B103-48DC-A14B-C16D08B32F9D@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 02-11-20 14:30:37, Andreas Dilger wrote:
> On Nov 2, 2020, at 10:27 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > The on-disk quota format supports quota files with upto 2^32 blocks. Be
> > careful when computing quota file offsets in the quota files from block
> > numbers as they can overflow 32-bit types. Since quota files larger than
> > 4GB would require ~26 millions of quota users, this is mostly a
> > theoretical concern now but better be careful, fuzzers would find the
> > problem sooner or later anyway...
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Out of curiosity, is this 26 million *quota entries*, or is it just a UID
> larger than 26M?  At one point the quota files were sparse and indexed by
> the UID, but I guess very file name "quota tree" means this is not correct.
> Is there some document/comment that describes the on-disk quota file format?

It is really 26M different UIDs/GIDs/ProjectIDs. The sparse file format you
describe is the original quota format (implemented by fs/quota/quota_v1.c)
that the current format superseeded sometime in 1999 or so ;). The current
format uses radix tree for structure lookup and then structures are just
stored in a linear array. There's documentation of the format in
quota-tools in doc/quotadoc.sgml.

> In any case, the change makes sense regardless, since ->quota_read() takes
> loff_t for the offset.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks!

									Honza
> 
> > ---
> > fs/quota/quota_tree.c | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
> > index a6f856f341dc..c5562c871c8b 100644
> > --- a/fs/quota/quota_tree.c
> > +++ b/fs/quota/quota_tree.c
> > @@ -62,7 +62,7 @@ static ssize_t read_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
> > 
> > 	memset(buf, 0, info->dqi_usable_bs);
> > 	return sb->s_op->quota_read(sb, info->dqi_type, buf,
> > -	       info->dqi_usable_bs, blk << info->dqi_blocksize_bits);
> > +	       info->dqi_usable_bs, (loff_t)blk << info->dqi_blocksize_bits);
> > }
> > 
> > static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
> > @@ -71,7 +71,7 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
> > 	ssize_t ret;
> > 
> > 	ret = sb->s_op->quota_write(sb, info->dqi_type, buf,
> > -	       info->dqi_usable_bs, blk << info->dqi_blocksize_bits);
> > +	       info->dqi_usable_bs, (loff_t)blk << info->dqi_blocksize_bits);
> > 	if (ret != info->dqi_usable_bs) {
> > 		quota_error(sb, "dquota write failed");
> > 		if (ret >= 0)
> > @@ -284,7 +284,7 @@ static uint find_free_dqentry(struct qtree_mem_dqinfo *info,
> > 			    blk);
> > 		goto out_buf;
> > 	}
> > -	dquot->dq_off = (blk << info->dqi_blocksize_bits) +
> > +	dquot->dq_off = ((loff_t)blk << info->dqi_blocksize_bits) +
> > 			sizeof(struct qt_disk_dqdbheader) +
> > 			i * info->dqi_entry_size;
> > 	kfree(buf);
> > @@ -559,7 +559,7 @@ static loff_t find_block_dqentry(struct qtree_mem_dqinfo *info,
> > 		ret = -EIO;
> > 		goto out_buf;
> > 	} else {
> > -		ret = (blk << info->dqi_blocksize_bits) + sizeof(struct
> > +		ret = ((loff_t)blk << info->dqi_blocksize_bits) + sizeof(struct
> > 		  qt_disk_dqdbheader) + i * info->dqi_entry_size;
> > 	}
> > out_buf:
> > --
> > 2.16.4
> > 
> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
