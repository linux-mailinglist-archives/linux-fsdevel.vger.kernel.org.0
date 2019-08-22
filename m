Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08F599795
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389238AbfHVPAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 11:00:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:32828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731841AbfHVPAn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:00:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C68EAD7C;
        Thu, 22 Aug 2019 15:00:42 +0000 (UTC)
Date:   Thu, 22 Aug 2019 10:00:38 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     RITESH HARJANI <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, darrick.wong@oracle.com, ruansy.fnst@cn.fujitsu.com
Subject: Re: [PATCH 07/13] btrfs: basic direct read operation
Message-ID: <20190822150038.rebfrmyk2m6ljzoo@fiona>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-8-rgoldwyn@suse.de>
 <20190812123201.904205204F@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812123201.904205204F@d06av21.portsmouth.uk.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18:02 12/08, RITESH HARJANI wrote:
> 
> On 8/3/19 3:30 AM, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Add btrfs_dio_iomap_ops for iomap.begin() function. In order to
> > accomodate dio reads, add a new function btrfs_file_read_iter()
> > which would call btrfs_dio_iomap_read() for DIO reads and
> > fallback to generic_file_read_iter otherwise.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >   fs/btrfs/ctree.h |  2 ++
> >   fs/btrfs/file.c  | 10 +++++++++-
> >   fs/btrfs/iomap.c | 20 ++++++++++++++++++++
> >   3 files changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 7a4ff524dc77..9eca2d576dd1 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -3247,7 +3247,9 @@ int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
> >   loff_t btrfs_remap_file_range(struct file *file_in, loff_t pos_in,
> >   			      struct file *file_out, loff_t pos_out,
> >   			      loff_t len, unsigned int remap_flags);
> > +/* iomap.c */
> >   size_t btrfs_buffered_iomap_write(struct kiocb *iocb, struct iov_iter *from);
> > +ssize_t btrfs_dio_iomap_read(struct kiocb *iocb, struct iov_iter *to);
> >   /* tree-defrag.c */
> >   int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index f7087e28ac08..997eb152a35a 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -2839,9 +2839,17 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
> >   	return generic_file_open(inode, filp);
> >   }
> > +static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > +{
> > +	if (iocb->ki_flags & IOCB_DIRECT)
> > +		return btrfs_dio_iomap_read(iocb, to);
> 
> No provision to fallback to bufferedIO read? Not sure from btrfs
> perspective,
> but earlier generic_file_read_iter may fall through to bufferedIO read say
> in case where directIO could not be completed (returned 0 or less than the
> requested read bytes).
> Is it not required anymore in case of btrfs when we move to iomap
> infrastructure, to still fall back to bufferedIO read?
> Correct me if I am missing anything here.
> 

No, you are right here. We should fallback to buffered reads in case of
incomplete reads. Thanks for pointing it out. I will incorporate it in the
next series.

-- 
Goldwyn
