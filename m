Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1446EBA1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 23:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfJaW6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 18:58:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46084 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJaW6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:58:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id 193so4252507pfc.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2019 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=46k+3hqW0/dPZNwHSjPbavFBxD39tv+Rsfe11che4hg=;
        b=udMUm6wTvvdFJ/zRvD6RPf0L20u0DA/XUzx3OeL6vIhKfYyss/0HeBDTMQofaSR4kx
         0ZWuOK2fpZkJ4TV7G5Es+RgIguseFTTxdCfKKljx/9KYlZ0xc8FSSBhX3Veh6RL/4EKi
         nU9rAesmYrMPGJ5MRahM9KM1DGtfZErbJ3D0xbgaoYIF7EyxO/UyMEd2Vj5AaZHIX1vX
         /R7EUegftcrZYkobZiai9q3+C9/T2j+dxPLl7NEWC0m4xdOdDIW01RajPcgxs8W4osy3
         thd3fWVhc/Gghy4d9X+zszZ2Y9YmriagzXwAWzWtTG9X+4UrYQXFkw1AX/SloHoeYaNv
         ojwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=46k+3hqW0/dPZNwHSjPbavFBxD39tv+Rsfe11che4hg=;
        b=CjHXHCyaUfkpfzqEpf3Bx4dfcSIYd5XvmeGIiTY59XU4SHZdsL09fQzSaMSw6G0enn
         c6dboGkhqnQzk+O4OxcIvzuKZZlgxM3TV2f8qQOQJ82hCQBrHVSvQGPiVe1tpgdHzAne
         jFByJC7FdZT5wfYcBwRdU7qDaSJaBKbqAdDQ8eXoe1YbN4Yl360obyw9KrGS/0n7j36V
         CX06aSHsQ4FYLq+o5nUsHLb5gnnr3EtolBFB7SkPtPie+TYEOgW+BJtvmrP42gcdE+wi
         rmQKbJMzA81qfHkytgnuwl9KXHgt1jzv6ep2H1nlFdbYbpva/Hb/BrUAtuqZgLKO9uUC
         aEnA==
X-Gm-Message-State: APjAAAVzmoVMp57ZDy32W+CgxUCvb6N9sQBEH/4hwvJFuXeSxGJe0ovB
        Z3m6a6WRUSub/a+1PVS+3NWu
X-Google-Smtp-Source: APXvYqyilGepJ51cH+VFa92B37EottRPmYnQ9xfu4h4gvaHfct7GwnosA2pXhnRbei+47fnLrIcGGQ==
X-Received: by 2002:a17:90a:b88f:: with SMTP id o15mr11033654pjr.5.1572562716245;
        Thu, 31 Oct 2019 15:58:36 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id y80sm4946828pfc.30.2019.10.31.15.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:58:35 -0700 (PDT)
Date:   Fri, 1 Nov 2019 09:58:28 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v6 00/11] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191031225826.GA19790@bobrowski>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <20191029233159.GA8537@mit.edu>
 <20191029233401.GB8537@mit.edu>
 <20191030020022.GA7392@bobrowski>
 <20191030112652.GF28525@quack2.suse.cz>
 <20191030113918.GG28525@quack2.suse.cz>
 <20191031091639.GB28679@bobrowski>
 <20191031165416.GD13321@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031165416.GD13321@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 05:54:16PM +0100, Jan Kara wrote:
> On Thu 31-10-19 20:16:41, Matthew Bobrowski wrote:
> > On Wed, Oct 30, 2019 at 12:39:18PM +0100, Jan Kara wrote:
> > > On Wed 30-10-19 12:26:52, Jan Kara wrote:
> > > Hum, actually no. This write from fsx output:
> > > 
> > > 24( 24 mod 256): WRITE    0x23000 thru 0x285ff  (0x5600 bytes)
> > > 
> > > should have allocated blocks to where the failed write was going (0x24000).
> > > But still I'd expect some interaction between how buffered writes to holes
> > > interact with following direct IO writes... One of the subtle differences
> > > we have introduced with iomap conversion is that the old code in
> > > __generic_file_write_iter() did fsync & invalidate written range after
> > > buffered write fallback and we don't seem to do that now (probably should
> > > be fixed regardless of relation to this bug).
> > 
> > After performing some debugging this afternoon, I quickly realised
> > that the fix for this is rather trivial. Within the previous direct
> > I/O implementation, we passed EXT4_GET_BLOCKS_CREATE to
> > ext4_map_blocks() for any writes to inodes without extents. I seem to
> > have missed that here and consequently block allocation for a write
> > wasn't performing correctly in such cases.
> 
> No, this is not correct. For inodes without extents we used
> ext4_dio_get_block() and we pass DIO_SKIP_HOLES to __blockdev_direct_IO().
> Now DIO_SKIP_HOLES means that if starting block is within i_size, we pass
> 'create == 0' to get_blocks() function and thus ext4_dio_get_block() uses
> '0' argument to ext4_map_blocks() similarly to what you do.

Ah right, I missed that part. :(

> And indeed for inodes without extents we must fallback to buffered IO for
> filling holes inside a file to avoid stale data exposure (racing DIO read
> could read block contents before data is written to it if we used
> EXT4_GET_BLOCKS_CREATE).

Well in this case I'm pretty sure I know exactly where the problem
resides. I seem to be falling back to buffered I/O from
ext4_dio_write_iter() without actually taking into account any of the
data that may have partially been written by the direct I/O. So, when
returning the bytes written back to userspace it's whatever actually
is returned by ext4_buffered_write_iter(), which may not necessarily
be the amount of bytes that were expected, so it should rather be
ext4_dio_write_iter() + ext4_buffered_write_iter()...

> > Also, I agree, the fsync + page cache invalidation bits need to be
> > implemented. I'm just thinking to branch out within
> > ext4_buffered_write_iter() and implement those bits there i.e.
> > 
> > 	...
> > 	ret = generic_perform_write();
> > 
> > 	if (ret > 0 && iocb->ki_flags & IOCB_DIRECT) {
> > 	   	err = filemap_write_and_wait_range();
> > 
> > 		if (!err)
> > 			invalidate_mapping_pages();
> > 	...
> > 
> > AFAICT, this would be the most appropriate place to put it? Or, did
> > you have something else in mind?
> 
> Yes, either this, or maybe in ext4_dio_write_iter() after returning from
> ext4_buffered_write_iter() would be even more logical.

Yes, let's stick with doing it within ext4_dio_write_iter().

--<M>--

