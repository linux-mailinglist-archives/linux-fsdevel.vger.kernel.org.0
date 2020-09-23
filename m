Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68163275969
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 16:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgIWOID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 10:08:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:34064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgIWOIC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:08:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4C28ACC6;
        Wed, 23 Sep 2020 14:08:37 +0000 (UTC)
Date:   Wed, 23 Sep 2020 09:07:57 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, darrick.wong@oracle.com, josef@toxicpanda.com
Subject: Re: [PATCH 07/15] btrfs: Move FS error state bit early during write
Message-ID: <20200923140757.bspzgzwajcvpr62i@fiona>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-8-rgoldwyn@suse.de>
 <832c6168-42cf-4ba1-1254-ce0057ff8c0a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <832c6168-42cf-4ba1-1254-ce0057ff8c0a@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12:10 23/09, Nikolay Borisov wrote:
> 
> 
> On 21.09.20 г. 17:43 ч., Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > fs_info->fs_state is a filesystem bit check as opposed to inode
> > and can be performed before we begin with write checks. This eliminates
> > inode lock/unlock in case of error bit is set.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >  fs/btrfs/file.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 4c40a2742aab..ca374cb5ffc9 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -1981,6 +1981,15 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
> >  	size_t count;
> >  	loff_t oldsize;
> >  
> > +	/*
> > +	 * If BTRFS flips readonly due to some impossible error
> > +	 * (fs_info->fs_state now has BTRFS_SUPER_FLAG_ERROR),
> > +	 * although we have opened a file as writable, we have
> > +	 * to stop this write operation to ensure FS consistency.
> > +	 */
> > +	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
> > +		return -EROFS;
> > +
> 
> nit: Actually can't this check be eliminated altogether or the comment
> vastly simplified because BTRFS_SUPER_FLAG_ERROR check is performed only
> during mount so the description in the parantheses is invalid i.e the fs
> won't flip to RO because BTRFS_SUPER_FLAG_ERROR is now set in the super
> block. As a matter of fact how is this flag set - because I don't see it
> set in the kernel code nor in btrfs-progs ?

You are right. This flag originated from 
acce952b0263 ("Btrfs: forced readonly mounts on errors")

However, the following commit removed writing the super in case of the
error:
68ce9682a4bb ("Btrfs: remove superblock writing after fatal error")

So, it does not land in the super flags anyways.
The flag does not make sense if we use BTRFS_FS_STATE_ERROR.

I will remove BTRFS_SUPER_FLAG_ERROR comment for now.

-- 
Goldwyn
