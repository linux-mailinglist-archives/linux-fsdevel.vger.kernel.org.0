Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026512DD396
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 16:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgLQPCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 10:02:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727543AbgLQPCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608217237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZrUawnXtjtGun/f0FYscqL21akIuvo9XyiO75S1bCyI=;
        b=a/S3yMMMSbgESvAEp0rhOCqbLNzTjSDCHqwfQrg1rVaulwIosfP9vq299JTfLMjs9Uvys1
        OW8CE01K5xCNT2HSB9sw0xvLkN33mOSEUKgcIVK9uwHfvjloenOLZ45HOtMDn+aAtiEQMs
        U7Ljc/FeCjTstpzRci2AL8AiYuMNEQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-OuBLCoJNOXS57Vl_F-3VSQ-1; Thu, 17 Dec 2020 10:00:35 -0500
X-MC-Unique: OuBLCoJNOXS57Vl_F-3VSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C6F7800D53;
        Thu, 17 Dec 2020 15:00:31 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-107.rdu2.redhat.com [10.10.112.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E69035D9D7;
        Thu, 17 Dec 2020 15:00:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 78420220BCF; Thu, 17 Dec 2020 10:00:29 -0500 (EST)
Date:   Thu, 17 Dec 2020 10:00:29 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, jlayton@kernel.org,
        amir73il@gmail.com, sargun@sargun.me, miklos@szeredi.hu,
        willy@infradead.org, jack@suse.cz, neilb@suse.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] vfs: add new f_op->syncfs vector
Message-ID: <20201217150029.GA3630@redhat.com>
References: <20201216233149.39025-1-vgoyal@redhat.com>
 <20201216233149.39025-2-vgoyal@redhat.com>
 <20201217004935.GN3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217004935.GN3579531@ZenIV.linux.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 12:49:35AM +0000, Al Viro wrote:
> [Christoph added to Cc...]
> On Wed, Dec 16, 2020 at 06:31:47PM -0500, Vivek Goyal wrote:
> > Current implementation of __sync_filesystem() ignores the return code
> > from ->sync_fs(). I am not sure why that's the case. There must have
> > been some historical reason for this.
> > 
> > Ignoring ->sync_fs() return code is problematic for overlayfs where
> > it can return error if sync_filesystem() on upper super block failed.
> > That error will simply be lost and sycnfs(overlay_fd), will get
> > success (despite the fact it failed).
> > 
> > If we modify existing implementation, there is a concern that it will
> > lead to user space visible behavior changes and break things. So
> > instead implement a new file_operations->syncfs() call which will
> > be called in syncfs() syscall path. Return code from this new
> > call will be captured. And all the writeback error detection
> > logic can go in there as well. Only filesystems which implement
> > this call get affected by this change. Others continue to fallback
> > to existing mechanism.
> 
> That smells like a massive source of confusion down the road.  I'd just
> looked through the existing instances; many always return 0, but quite
> a few sometimes try to return an error:
> fs/btrfs/super.c:2412:  .sync_fs        = btrfs_sync_fs,
> fs/exfat/super.c:204:   .sync_fs        = exfat_sync_fs,
> fs/ext4/super.c:1674:   .sync_fs        = ext4_sync_fs,
> fs/f2fs/super.c:2480:   .sync_fs        = f2fs_sync_fs,
> fs/gfs2/super.c:1600:   .sync_fs                = gfs2_sync_fs,
> fs/hfsplus/super.c:368: .sync_fs        = hfsplus_sync_fs,
> fs/nilfs2/super.c:689:  .sync_fs        = nilfs_sync_fs,
> fs/ocfs2/super.c:139:   .sync_fs        = ocfs2_sync_fs,
> fs/overlayfs/super.c:399:       .sync_fs        = ovl_sync_fs,
> fs/ubifs/super.c:2052:  .sync_fs       = ubifs_sync_fs,
> is the list of such.  There are 4 method callers:
> dquot_quota_sync(), dquot_disable(), __sync_filesystem() and
> sync_fs_one_sb().  For sync_fs_one_sb() we want to ignore the
> return value; for __sync_filesystem() we almost certainly
> do *not* - it ends with return __sync_blockdev(sb->s_bdev, wait),
> after all.  The question for that one is whether we want
> __sync_blockdev() called even in case of ->sync_fs() reporting
> a failure, and I suspect that it's safer to call it anyway and
> return the first error value we'd got.

I posted V1 patch to do exactly above. In __sync_filesystem(), capture
return code from ->sync_fs() but continue to call __sync_blockdev() and
and return error code from ->sync_fs() if there is one otherwise
return error code from __sync_blockdev().

https://lore.kernel.org/linux-fsdevel/20201216143802.GA10550@redhat.com/

Thanks
Vivek

> No idea about quota situation.
> 

