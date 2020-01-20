Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7408B1430E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 18:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgATRjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 12:39:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:42962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATRjK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:39:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ACC18AEFF;
        Mon, 20 Jan 2020 17:39:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5D6931E0CF1; Mon, 20 Jan 2020 14:02:15 +0100 (CET)
Date:   Mon, 20 Jan 2020 14:02:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: udf: Suspicious values in udf_statfs()
Message-ID: <20200120130215.GH19861@quack2.suse.cz>
References: <20200112162311.khkvcu2u6y4gbbr7@pali>
 <20200113120851.GG23642@quack2.suse.cz>
 <20200117120511.GI17141@quack2.suse.cz>
 <20200118001107.aove7ohhuosdsvgx@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200118001107.aove7ohhuosdsvgx@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 18-01-20 01:11:07, Pali Rohár wrote:
> On Friday 17 January 2020 13:05:11 Jan Kara wrote:
> > On Mon 13-01-20 13:08:51, Jan Kara wrote:
> > > Hello,
> > > 
> > > On Sun 12-01-20 17:23:11, Pali Rohár wrote:
> > > > I looked at udf_statfs() implementation and I see there two things which
> > > > are probably incorrect:
> > > > 
> > > > First one:
> > > > 
> > > > 	buf->f_blocks = sbi->s_partmaps[sbi->s_partition].s_partition_len;
> > > > 
> > > > If sbi->s_partition points to Metadata partition then reported number
> > > > of blocks seems to be incorrect. Similar like in udf_count_free().
> > > 
> > > Oh, right. This needs similar treatment like udf_count_free(). I'll fix it.
> > > Thanks for spotting.
> > 
> > Patch for this is attached.
> 
> I was wrong. After reading UDF specification and kernel implementation
> again I realized that there is a complete mess what "partition" means.
> 
> Sometimes it is Partition Map, sometimes it is Partition Descriptor,
> sometimes it is index of Partition Map, sometimes index of Partition
> Descriptor, sometimes it refers to data referenced by Partition
> Descriptor and sometimes it refers to data referenced by Partition Map.
> 
> And "length" means length of any of above structure (either of map
> structure, either of data pointed by map structure, either of descriptor
> or either of data pointed by descriptor).
> 
> So to make it clear, member "s_partition_len" refers to length of data
> pointed by Partition Descriptor, therefore length of physical partition.

Yes, now that you say it I remember :)

> As kernel probably does not support UDF fs with more then one Partition
> Descriptor, whatever Partition Map we choose (s_partmaps[i] member) we
> would always get same value in "s_partition_len" as it does not refer to
> data of Partition Map, but rather to data of Partition Descriptor.
> 
> As both Metadata Partition Map and Type 1 Partition Map (or Sparable
> Partition Map) shares same Partition Descriptor, this patch does not
> change value of "f_blocks" member and therefore is not needed at all.
> So current code should be correct.
> 
> But please, double check that I'm correct as "partition" naming in
> probably every one variable is misleading.
> 
> Just to note, free space is calculated from Partition Map index
> (not from Partition Descriptor index), therefore previous patch for
> udf_count_free() is really needed and should be correct.

Right, I've checked the code and I completely agree with your analysis so
I've dropped the patch from my tree. Thanks for checking!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
