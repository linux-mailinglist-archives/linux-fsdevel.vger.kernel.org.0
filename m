Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAED997AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 17:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbfHVPFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 11:05:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:35104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733195AbfHVPFi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:05:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14567AD88;
        Thu, 22 Aug 2019 15:05:37 +0000 (UTC)
Date:   Thu, 22 Aug 2019 10:05:35 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, darrick.wong@oracle.com, ruansy.fnst@cn.fujitsu.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/13] btrfs: Add a simple buffered iomap write
Message-ID: <20190822150535.quzdzrvjqhzzo2sv@fiona>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-5-rgoldwyn@suse.de>
 <20190805001107.GF7689@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805001107.GF7689@dread.disaster.area>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10:11 05/08, Dave Chinner wrote:
> On Fri, Aug 02, 2019 at 05:00:39PM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Introduce a new btrfs_iomap structure which contains information
> > about the filesystem between the iomap_begin() and iomap_end() calls.
> > This contains information about reservations and extent locking.
> > 
> > This one is a long patch. Most of the code is "inspired" by
> > fs/btrfs/file.c. To keep the size small, all removals are in
> > following patches.
> 
> I can't comment on the btrfs code but this:
> 
> > +size_t btrfs_buffered_iomap_write(struct kiocb *iocb, struct iov_iter *from)
> > +{
> > +	ssize_t written;
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +	written = iomap_file_buffered_write(iocb, from, &btrfs_buffered_iomap_ops);
> > +	if (written > 0)
> > +		iocb->ki_pos += written;
> > +	if (iocb->ki_pos > i_size_read(inode))
> > +		i_size_write(inode, iocb->ki_pos);
> > +	return written;
> 
> Looks like it fails to handle O_[D]SYNC writes.
> 

It does in btrfs_file_write_iter(), which calls btrfs_buffered_iomap_write().
btrfs_file_write_iter() calls generic_write_sync().

-- 
Goldwyn
