Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A738FDE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhEYJcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 05:32:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:57316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231567AbhEYJcE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 05:32:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621935034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0CdEZyXokWEWrMrTbuIjD3UsGMWpkePMFwkVTcnpOc=;
        b=tsF3jStH+uP7PBxkE+CNdkHM65GKSFwbKw2lMMMi/Z0xtBMaIVYAkXKlLDlaMG/CVm+C2u
        lrtiTCkbHkzflAS9UP7hEMbp+0tbyn51EM0dn3Dj+9ChRI7UQeKonQ827VEdkERV3mIVX+
        PMpuOLaKRJeMhi+xzkzNOb8Hpw8cRIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621935034;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0CdEZyXokWEWrMrTbuIjD3UsGMWpkePMFwkVTcnpOc=;
        b=8REuD+9jpJlx0/O/Ads7yUxELxouZLc3AQ2dposoYYFFVDqhUGw7kjYuV6srN+6+x2CRJV
        F8ymMDCG3u8102BA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 818A2AECE;
        Tue, 25 May 2021 09:30:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 330A91F2C98; Tue, 25 May 2021 11:30:34 +0200 (CEST)
Date:   Tue, 25 May 2021 11:30:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, ocfs2-devel@oss.oracle.com,
        joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] ocfs2: fix data corruption by fallocate
Message-ID: <20210525093034.GB4112@quack2.suse.cz>
References: <20210521233612.75185-1-junxiao.bi@oracle.com>
 <20210524085508.GD32705@quack2.suse.cz>
 <479301ea-042b-855d-fc52-0d7bbdc55bdc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <479301ea-042b-855d-fc52-0d7bbdc55bdc@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 24-05-21 09:14:16, Junxiao Bi wrote:
> On 5/24/21 1:55 AM, Jan Kara wrote:
> 
> > On Fri 21-05-21 16:36:12, Junxiao Bi wrote:
> > > When fallocate punches holes out of inode size, if original isize is in
> > > the middle of last cluster, then the part from isize to the end of the
> > > cluster will be zeroed with buffer write, at that time isize is not
> > > yet updated to match the new size, if writeback is kicked in, it will
> > > invoke ocfs2_writepage()->block_write_full_page() where the pages out
> > > of inode size will be dropped. That will cause file corruption. Fix
> > > this by zero out eof blocks when extending the inode size.
> > > 
> > > Running the following command with qemu-image 4.2.1 can get a corrupted
> > > coverted image file easily.
> > > 
> > >      qemu-img convert -p -t none -T none -f qcow2 $qcow_image \
> > >               -O qcow2 -o compat=1.1 $qcow_image.conv
> > > 
> > > The usage of fallocate in qemu is like this, it first punches holes out of
> > > inode size, then extend the inode size.
> > > 
> > >      fallocate(11, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE, 2276196352, 65536) = 0
> > >      fallocate(11, 0, 2276196352, 65536) = 0
> > > 
> > > v1: https://www.spinics.net/lists/linux-fsdevel/msg193999.html
> > > 
> > > Cc: <stable@vger.kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> > > ---
> > > 
> > > Changes in v2:
> > > - suggested by Jan Kara, using sb_issue_zeroout to zero eof blocks in disk directly.
> > > 
> > >   fs/ocfs2/file.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 47 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> > > index f17c3d33fb18..17469fc7b20e 100644
> > > --- a/fs/ocfs2/file.c
> > > +++ b/fs/ocfs2/file.c
> > > @@ -1855,6 +1855,45 @@ int ocfs2_remove_inode_range(struct inode *inode,
> > >   	return ret;
> > >   }
> > > +/*
> > > + * zero out partial blocks of one cluster.
> > > + *
> > > + * start: file offset where zero starts, will be made upper block aligned.
> > > + * len: it will be trimmed to the end of current cluster if "start + len"
> > > + *      is bigger than it.
> > You write this here but ...
> > 
> > > + */
> > > +static int ocfs2_zeroout_partial_cluster(struct inode *inode,
> > > +					u64 start, u64 len)
> > > +{
> > > +	int ret;
> > > +	u64 start_block, end_block, nr_blocks;
> > > +	u64 p_block, offset;
> > > +	u32 cluster, p_cluster, nr_clusters;
> > > +	struct super_block *sb = inode->i_sb;
> > > +	u64 end = ocfs2_align_bytes_to_clusters(sb, start);
> > > +
> > > +	if (start + len < end)
> > > +		end = start + len;
> > ... here you check actually something else and I don't see where else would
> > the trimming happen.
> 
> Before the "if", end = ocfs2_align_bytes_to_clusters(sb, start), that is
> the end of the cluster where "start" located.

Ah sorry, I got confused. The code is correct.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
