Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A8D33403D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 15:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhCJOV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 09:21:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:52472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232776AbhCJOVo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:21:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7ACEEAEB6;
        Wed, 10 Mar 2021 14:21:42 +0000 (UTC)
Date:   Wed, 10 Mar 2021 08:21:59 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Neal Gompa <ngompa13@gmail.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        darrick.wong@oracle.com, dan.j.williams@intel.com, jack@suse.cz,
        viro@zeniv.linux.org.uk, Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <20210310142159.kudk7q2ogp4yqn36@fiona>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310130227.GN3479805@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13:02 10/03, Matthew Wilcox wrote:
> On Wed, Mar 10, 2021 at 07:30:41AM -0500, Neal Gompa wrote:
> > Forgive my ignorance, but is there a reason why this isn't wired up to
> > Btrfs at the same time? It seems weird to me that adding a feature
> 
> btrfs doesn't support DAX.  only ext2, ext4, XFS and FUSE have DAX support.
> 
> If you think about it, btrfs and DAX are diametrically opposite things.
> DAX is about giving raw access to the hardware.  btrfs is about offering
> extra value (RAID, checksums, ...), none of which can be done if the
> filesystem isn't in the read/write path.
> 
> That's why there's no DAX support in btrfs.  If you want DAX, you have
> to give up all the features you like in btrfs.  So you may as well use
> a different filesystem.

DAX on btrfs has been attempted[1]. Of course, we could not
have checksums or multi-device with it. However, got stuck on
associating a shared extent on the same page mapping: basically the
TODO above dax_associate_entry().

Shiyang has proposed a way to disassociate existing mapping, but I
don't think that is the best solution. DAX for CoW will not work until
we have a way of mapping a page to multiple inodes (page->mapping),
which will convert a 1-N inode-page mapping to M-N inode-page mapping.

[1] https://lore.kernel.org/linux-btrfs/20190429172649.8288-1-rgoldwyn@suse.de/

-- 
Goldwyn
