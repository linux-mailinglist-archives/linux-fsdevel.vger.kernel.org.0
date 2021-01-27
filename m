Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F2E305F6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 16:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343832AbhA0PVP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 10:21:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343724AbhA0PUU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611760732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y8CI0qhLiRTzgvTJnz39fBqQX6rleE9goWMGoeQDUHM=;
        b=hdyTJd5ccf/N6MdfncJHTvpTOAhYOcfmQ2FVTNHDuhVGSCQ9qvloGU5D1ATcNvYAnsKdIT
        ZVHLYTfIVIRljT9+4dywjtC4xwwg8C+8MndIlv4vqqIG4lpnyJVzhqx7Y9EFe2O/QrXtIq
        VcGh4KXYsY3+P1OtiEFKNnLrLVQtCnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-Q_p0DMDDOLWzMbA0s1tO-Q-1; Wed, 27 Jan 2021 10:18:50 -0500
X-MC-Unique: Q_p0DMDDOLWzMbA0s1tO-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 826648797E7;
        Wed, 27 Jan 2021 15:18:48 +0000 (UTC)
Received: from T590 (ovpn-12-152.pek2.redhat.com [10.72.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 634A45D9CA;
        Wed, 27 Jan 2021 15:18:44 +0000 (UTC)
Date:   Wed, 27 Jan 2021 23:18:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Maxim Mikityanskiy <maxtram95@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "block: simplify set_init_blocksize" to regain
 lost performance
Message-ID: <20210127151838.GA1325688@T590>
References: <20210126195907.2273494-1-maxtram95@gmail.com>
 <d3effbdc-12c2-c6aa-98ba-7bde006fc4e1@acm.org>
 <CAKErNvpCdTvg-Bx-U+k3jYiazoz-Pr0LwruaSh+LszH9yP5c8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKErNvpCdTvg-Bx-U+k3jYiazoz-Pr0LwruaSh+LszH9yP5c8A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 09:44:50AM +0200, Maxim Mikityanskiy wrote:
> On Wed, Jan 27, 2021 at 6:23 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 1/26/21 11:59 AM, Maxim Mikityanskiy wrote:
> > > The cited commit introduced a serious regression with SATA write speed,
> > > as found by bisecting. This patch reverts this commit, which restores
> > > write speed back to the values observed before this commit.
> > >
> > > The performance tests were done on a Helios4 NAS (2nd batch) with 4 HDDs
> > > (WD8003FFBX) using dd (bs=1M count=2000). "Direct" is a test with a
> > > single HDD, the rest are different RAID levels built over the first
> > > partitions of 4 HDDs. Test results are in MB/s, R is read, W is write.
> > >
> > >                 | Direct | RAID0 | RAID10 f2 | RAID10 n2 | RAID6
> > > ----------------+--------+-------+-----------+-----------+--------
> > > 9011495c9466    | R:256  | R:313 | R:276     | R:313     | R:323
> > > (before faulty) | W:254  | W:253 | W:195     | W:204     | W:117
> > > ----------------+--------+-------+-----------+-----------+--------
> > > 5ff9f19231a0    | R:257  | R:398 | R:312     | R:344     | R:391
> > > (faulty commit) | W:154  | W:122 | W:67.7    | W:66.6    | W:67.2
> > > ----------------+--------+-------+-----------+-----------+--------
> > > 5.10.10         | R:256  | R:401 | R:312     | R:356     | R:375
> > > unpatched       | W:149  | W:123 | W:64      | W:64.1    | W:61.5
> > > ----------------+--------+-------+-----------+-----------+--------
> > > 5.10.10         | R:255  | R:396 | R:312     | R:340     | R:393
> > > patched         | W:247  | W:274 | W:220     | W:225     | W:121
> > >
> > > Applying this patch doesn't hurt read performance, while improves the
> > > write speed by 1.5x - 3.5x (more impact on RAID tests). The write speed
> > > is restored back to the state before the faulty commit, and even a bit
> > > higher in RAID tests (which aren't HDD-bound on this device) - that is
> > > likely related to other optimizations done between the faulty commit and
> > > 5.10.10 which also improved the read speed.
> > >
> > > Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> > > Fixes: 5ff9f19231a0 ("block: simplify set_init_blocksize")
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Jens Axboe <axboe@kernel.dk>
> > > ---
> > >  fs/block_dev.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > > index 3b8963e228a1..235b5042672e 100644
> > > --- a/fs/block_dev.c
> > > +++ b/fs/block_dev.c
> > > @@ -130,7 +130,15 @@ EXPORT_SYMBOL(truncate_bdev_range);
> > >
> > >  static void set_init_blocksize(struct block_device *bdev)
> > >  {
> > > -     bdev->bd_inode->i_blkbits = blksize_bits(bdev_logical_block_size(bdev));
> > > +     unsigned int bsize = bdev_logical_block_size(bdev);
> > > +     loff_t size = i_size_read(bdev->bd_inode);
> > > +
> > > +     while (bsize < PAGE_SIZE) {
> > > +             if (size & bsize)
> > > +                     break;
> > > +             bsize <<= 1;
> > > +     }
> > > +     bdev->bd_inode->i_blkbits = blksize_bits(bsize);
> > >  }
> > >
> > >  int set_blocksize(struct block_device *bdev, int size)
> >
> > How can this patch affect write speed? I haven't found any calls of
> > set_init_blocksize() in the I/O path. Did I perhaps overlook something?
> 
> I don't know the exact mechanism how this change affects the speed,
> I'm not an expert in the block device subsystem (I'm a networking
> guy). This commit was found by git bisect, and my performance test
> confirmed that reverting it fixes the bug.
> 
> It looks to me as this function sets the block size as part of control
> flow, and this size is used later in the fast path, and the commit
> that removed the loop decreased this block size.

Right, the issue is stupid __block_write_full_page() which submits single bio
for each buffer head. And I have tried to improve the situation by merging
BHs into single bio, see below patch:

	https://lore.kernel.org/linux-block/20201230000815.3448707-1-ming.lei@redhat.com/

The above patch should improve perf for your test case.

-- 
Ming

