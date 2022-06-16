Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E434F54DA6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 08:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359107AbiFPGTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 02:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358728AbiFPGTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:19:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE8A527FE;
        Wed, 15 Jun 2022 23:19:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32F29B82281;
        Thu, 16 Jun 2022 06:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3A3C34114;
        Thu, 16 Jun 2022 06:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655360374;
        bh=9WtnFezIM4KX4P3ySZStpuq8OOCxc7UiGqUdRTu14IU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zbm83yfLXoLOCTJN/17SG94P7h8qzzoKuhRyDkoMLpxUMLdpOIYf9Ina/d/ccOi+m
         2DfdrqmNMNxXflN8F0chJjQwfj+Ga32syiPjxwTrXN3T5X/44cLAgo//HC/ssjlKE0
         L9c07K5/7Epq7PUTKf79rU3eaAUqTFt8pqu/vcQo5p9C2hxXO3nRszdTm2E/IU8Gpu
         6wx/4Df69k+QH6WRs5N4xQ9J5HYk+hvYgT6yR8aDjXmIzK1GE9Hb/g9DjEJ0llglRV
         fF+XpJQ0TxrQKHAApO9bvDo5m+XaZ0ehIal+LLBJ0N0D/tCgIAEW7A877NxmcVRVVn
         N48OrEtqGZlqw==
Date:   Wed, 15 Jun 2022 23:19:32 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH v2 1/7] statx: add I/O alignment information
Message-ID: <YqrLdORPM5qm9PC0@sol.localdomain>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
 <YobNXbYnhBiqniTH@magnolia>
 <20220520032739.GB1098723@dread.disaster.area>
 <YqgbuDbdH2OLcbC7@sol.localdomain>
 <YqnapOLvHDmX/3py@infradead.org>
 <YqpzqZQgu0Zz+vW1@sol.localdomain>
 <YqrIlVtI85zF9qyO@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqrIlVtI85zF9qyO@infradead.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:07:17PM -0700, Christoph Hellwig wrote:
> On Wed, Jun 15, 2022 at 05:04:57PM -0700, Eric Biggers wrote:
> > One more thing.  I'm trying to add support for STATX_DIOALIGN on block devices.
> > Unfortunately I don't think it is going to work, at all, since the inode is for
> > the device node and not the block device itself.  This is true even after the
> > file is opened (I previously thought that at least that case would work).
> 
> For an open file the block device inode is pointed to by
> file->f_mapping->host.
> 
> > Were you expecting that this would work on block devices?  It seems they will
> > need a different API -- a new BLK* ioctl, or files in /sys/block/$dev/queue.
> 
> blkdev_get_no_open on inode->i_rdev gets you the block device, which
> then has bdev->bd_inode point to the underlying block device, although
> for a block device those limit probably would be retrieved not from
> the inode but the gendisk / request_queue anyway.

Yes I know that.  The issue is that the inode that statx() is operating on is
the device node, so *all* the other statx fields come from that inode.  Size,
nlink, uid, gid, mode, timestamps (including btime if the filesystem supports
it), inode number, device number of the containing filesystem, mount ID, etc.
If we were to randomly grab one field from the underlying block device instead,
that would be inconsistent with everything else.

- Eric
