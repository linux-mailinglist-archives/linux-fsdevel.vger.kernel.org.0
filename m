Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D425F11F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 02:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIGAEj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 20:04:39 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:52046 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbgIGAEj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 20:04:39 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id ADCF18238CF;
        Mon,  7 Sep 2020 10:04:33 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kF4e8-00077a-Ni; Mon, 07 Sep 2020 10:04:32 +1000
Date:   Mon, 7 Sep 2020 10:04:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Message-ID: <20200907000432.GM12096@dread.disaster.area>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200903163236.GA26043@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903163236.GA26043@lst.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=IuRgj43g c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=YVNzv9zeh_ecUhYyJ8IA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 03, 2020 at 06:32:36PM +0200, Christoph Hellwig wrote:
> We could trivially do something like this to allow the file system
> to call iomap_dio_complete without i_rwsem:

That just exposes another deadlock vector:

P0			P1
inode_lock()		fallocate(FALLOC_FL_ZERO_RANGE)
__iomap_dio_rw()	inode_lock()
			<block>
<submits IO>
<completes IO>
inode_unlock()
			<gets inode_lock()>
			inode_dio_wait()
iomap_dio_complete()
  generic_write_sync()
    btrfs_file_fsync()
      inode_lock()
      <deadlock>

Basically, the only safe thing to do is implement ->fsync without
holding the DIO IO submission lock....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
