Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117432ECB10
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 08:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbhAGHs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 02:48:57 -0500
Received: from verein.lst.de ([213.95.11.211]:39566 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbhAGHs5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 02:48:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C757C68AFE; Thu,  7 Jan 2021 08:48:12 +0100 (CET)
Date:   Thu, 7 Jan 2021 08:48:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH kernel] block: initialize block_device::bd_bdi for
 bdev_cache
Message-ID: <20210107074812.GA1089@lst.de>
References: <20210106092900.26595-1-aik@ozlabs.ru> <20210106104106.GA29271@quack2.suse.cz> <5e6716a6-0314-8360-4fb6-5c959022a24c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e6716a6-0314-8360-4fb6-5c959022a24c@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 10:58:39AM +1100, Alexey Kardashevskiy wrote:
>> And AFAICT the root inode on
>> bdev superblock can get only to bdev_evict_inode() and bdev_free_inode().
>> Looking at bdev_evict_inode() the only thing that's used there from struct
>> block_device is really bd_bdi. bdev_free_inode() will also access
>> bdev->bd_stats and bdev->bd_meta_info. So we need to at least initialize
>> these to NULL as well.
>
> These are all NULL.
>
>> IMO the most logical place for all these
>> initializations is in bdev_alloc_inode()...
>
>
> This works. We can also check for NULL where it crashes. But I do not know 
> the code to make an informed decision...

The root inode is the special case, so I think moving the the initializers
for everything touched in ->evict_inode and ->free_inode to
bdev_alloc_inode makes most sense.

Alexey, do you want to respin or should I send a patch?
