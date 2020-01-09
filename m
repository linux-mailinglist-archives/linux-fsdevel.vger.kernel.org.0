Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D3135999
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 13:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgAIM5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 07:57:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39362 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgAIM5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:57:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so2718020wmj.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2020 04:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HdgBoiqb/5M9uNKbCbWpoa3xP7p9aDSpar3pytRDOBo=;
        b=dWYCbdH6HmFoVNt0q8WpL8t+qewp+c/IGHUfhbgJhRGJW3+WGN4XsYujCtk8Zo5kff
         ISsQpg97U6c1UhltN4V8WxDHxr4O4iVxND+cBhJJIUF9XNeBBJ+eR8ZtDfe+6zF2rQ7n
         qBZLWE/Psl44e4GvF1zfKgNXDuLsJTq86iwuEUNMAV0iMedeYesCh3aC/MeVZk4XE8bN
         iW+B7kHmLvrQFEinDWcL7XxHBaT1+AVYGoReojjKAJnDiBClB8rPWBrZX69cPjuSUk5n
         xnN1dwCm1CAwXBqcuV4bShBF63fZztCZVWhY4ZV2sPxXOrgd/f5pZJEf2zYhYFNQ4YRT
         Aejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HdgBoiqb/5M9uNKbCbWpoa3xP7p9aDSpar3pytRDOBo=;
        b=HzsgWh5d+amoq14RptAz3JMfa5GfWPhkdG36dSRg0Y7bPj1H9oxIl+2BjU6Qrqm3NQ
         /pyGr4pmJEG3W5Te8ty4+gt1PjsjT58FPIsZVS+ELSoRFnkAnUrF2nx8yXobxqNt9/mT
         z8Q3G/VXDne7O50oHejQOS4pnWqazHm3bK/sFlsyI6i1IAqVKrbGGvUIQpZ6Wj+QID0u
         Qi3nnbZMpeKM+b2+2evAf0x8LdzGdN7JbMtRndrMjpGO4DXXxyaBQiP7YT1Wj9d088Pb
         eb/kkgU+oo5THebCqkGymePA+bweM6/oV9gEmrGQ4yxwpMsEcoPnyOkD5a/H3Mp35GM1
         Ojkw==
X-Gm-Message-State: APjAAAWVtTdgykB8OaUBKl3zcdYV+LMWUlGf9VoWAvS69Ot394PMju6I
        6gcQZJBF3gvjJ3KK9p0eM3MSiu9f
X-Google-Smtp-Source: APXvYqxnd1JdS6rzfsVayGrOP65UDR90Xj1XN6QgasoZC844sSNMGEe5m7CF4llavEJq9LiQQHT0lg==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr4622934wml.176.1578574618457;
        Thu, 09 Jan 2020 04:56:58 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id e18sm8032299wrw.70.2020.01.09.04.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 04:56:57 -0800 (PST)
Date:   Thu, 9 Jan 2020 13:56:57 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] udf: Fix free space reporting for metadata and virtual
 partitions
Message-ID: <20200109125657.ir264jcd6oujox3a@pali>
References: <20200108121919.12343-1-jack@suse.cz>
 <20200108223240.gi5g2jza3rxuzk6z@pali>
 <20200109124405.GE22232@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200109124405.GE22232@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 09 January 2020 13:44:05 Jan Kara wrote:
> On Wed 08-01-20 23:32:40, Pali Rohár wrote:
> > On Wednesday 08 January 2020 13:19:19 Jan Kara wrote:
> > > Free space on filesystems with metadata or virtual partition maps
> > > currently gets misreported. This is because these partitions are just
> > > remapped onto underlying real partitions from which keep track of free
> > > blocks. Take this remapping into account when counting free blocks as
> > > well.
> > > 
> > > Reported-by: Pali Rohár <pali.rohar@gmail.com>
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/udf/super.c | 19 ++++++++++++++-----
> > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > > 
> > > I plan to take this patch to my tree.
> > > 
> > > diff --git a/fs/udf/super.c b/fs/udf/super.c
> > > index 8c28e93e9b73..b89e420a4b85 100644
> > > --- a/fs/udf/super.c
> > > +++ b/fs/udf/super.c
> > > @@ -2492,17 +2492,26 @@ static unsigned int udf_count_free_table(struct super_block *sb,
> > >  static unsigned int udf_count_free(struct super_block *sb)
> > >  {
> > >  	unsigned int accum = 0;
> > > -	struct udf_sb_info *sbi;
> > > +	struct udf_sb_info *sbi = UDF_SB(sb);
> > >  	struct udf_part_map *map;
> > > +	unsigned int part = sbi->s_partition;
> > > +	int ptype = sbi->s_partmaps[part].s_partition_type;
> > > +
> > > +	if (ptype == UDF_METADATA_MAP25) {
> > > +		part = sbi->s_partmaps[part].s_type_specific.s_metadata.
> > > +							s_phys_partition_ref;
> > > +	} else if (ptype == UDF_VIRTUAL_MAP15 || ptype == UDF_VIRTUAL_MAP20) {
> > > +		part = UDF_I(sbi->s_vat_inode)->i_location.
> > > +							partitionReferenceNum;
> > 
> > Hello! I do not think that it make sense to report "free blocks" for
> > discs with Virtual partition. By definition of VAT, all blocks prior to
> > VAT are already "read-only" and therefore these blocks cannot be use for
> > writing new data by any implementation. And because VAT is stored on the
> > last block, in our model all blocks are "occupied".
> 
> Fair enough. Let's just always return 0 for disks with VAT partition.
> 
> > > +	}
> > >  
> > > -	sbi = UDF_SB(sb);
> > >  	if (sbi->s_lvid_bh) {
> > >  		struct logicalVolIntegrityDesc *lvid =
> > >  			(struct logicalVolIntegrityDesc *)
> > >  			sbi->s_lvid_bh->b_data;
> > > -		if (le32_to_cpu(lvid->numOfPartitions) > sbi->s_partition) {
> > > +		if (le32_to_cpu(lvid->numOfPartitions) > part) {
> > >  			accum = le32_to_cpu(
> > > -					lvid->freeSpaceTable[sbi->s_partition]);
> > > +					lvid->freeSpaceTable[part]);
> > 
> > And in any case freeSpaceTable should not be used for discs with VAT.
> > And we should ignore its value for discs with VAT.
> > 
> > UDF 2.60 2.2.6.2: Free Space Table values be maintained ... except ...
> > for a virtual partition ...
> > 
> > And same applies for "partition with Access Type pseudo-overwritable".
> 
> Well this is handled by the 'accum == 0xffffffff' condition below. So we
> effectively ignore these values.

Ok.

> > >  			if (accum == 0xFFFFFFFF)
> > >  				accum = 0;
> > >  		}
> 
> 								Honza

-- 
Pali Rohár
pali.rohar@gmail.com
