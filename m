Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC6D26AFFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 23:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgIOVta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 17:49:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:50804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgIOVtB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:49:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4CF4AC7D;
        Tue, 15 Sep 2020 21:49:12 +0000 (UTC)
Date:   Tue, 15 Sep 2020 16:48:53 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Message-ID: <20200915214853.iurg43dt52h5z2gp@fiona>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200903163236.GA26043@lst.de>
 <20200907000432.GM12096@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907000432.GM12096@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10:04 07/09, Dave Chinner wrote:
> On Thu, Sep 03, 2020 at 06:32:36PM +0200, Christoph Hellwig wrote:
> > We could trivially do something like this to allow the file system
> > to call iomap_dio_complete without i_rwsem:
> 
> That just exposes another deadlock vector:
> 
> P0			P1
> inode_lock()		fallocate(FALLOC_FL_ZERO_RANGE)
> __iomap_dio_rw()	inode_lock()
> 			<block>
> <submits IO>
> <completes IO>
> inode_unlock()
> 			<gets inode_lock()>
> 			inode_dio_wait()
> iomap_dio_complete()
>   generic_write_sync()
>     btrfs_file_fsync()
>       inode_lock()
>       <deadlock>

Can inode_dio_end() be called before generic_write_sync(), as it is done
in fs/direct-io.c:dio_complete()?

Christoph's solution is a clean approach and would prefer to use it as
the final solution.


-- 
Goldwyn
