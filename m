Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5752742D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIVNVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 09:21:30 -0400
Received: from verein.lst.de ([213.95.11.211]:44578 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgIVNVa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:21:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC5A667373; Tue, 22 Sep 2020 15:21:26 +0200 (CEST)
Date:   Tue, 22 Sep 2020 15:21:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 04/15] iomap: Call inode_dio_end() before
 generic_write_sync()
Message-ID: <20200922132126.GC20432@lst.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de> <20200921144353.31319-5-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921144353.31319-5-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:43:42AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> iomap complete routine can deadlock with btrfs_fallocate because of the
> call to generic_write_sync().
> 
> P0                      P1
> inode_lock()            fallocate(FALLOC_FL_ZERO_RANGE)
> __iomap_dio_rw()        inode_lock()
>                         <block>
> <submits IO>
> <completes IO>
> inode_unlock()
>                         <gets inode_lock()>
>                         inode_dio_wait()
> iomap_dio_complete()
>   generic_write_sync()
>     btrfs_file_fsync()
>       inode_lock()
>       <deadlock>
> 
> inode_dio_end() is used to notify the end of DIO data in order
> to synchronize with truncate. Call inode_dio_end() before calling
> generic_write_sync(), so filesystems can lock i_rwsem during a sync.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

You might want to mention in the commit log that this matches the
sequence in the old fs/direct-io.c implementation.
