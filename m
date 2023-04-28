Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC756F1180
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 07:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345285AbjD1FvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 01:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjD1FvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:51:21 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E2D2D65
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 22:51:20 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33S5lMlM026990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 01:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682660846; bh=n45cV6emPGhOhWVrM3aPDXulvuQpgauHWb0nGls0bOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HdOr1NcmCK3MvPO2flI/Eva8KXzuIVfF5D3UOs5MkdFFBoUxAslYlHnX2IUEEGUmg
         dcw7Zved6ZgTRwJw3fO/GEQBxgRKwQy986GY+v3jl6XgEpqrsNHyH3e18DjI3gTBpM
         4J3jqLQAJ3gnOgxeweK4gZbDact/GWtxUHMpOciVtFAcv6mSTup4dQRkrDyrVY8vXY
         5UNs20kH3oBnNCJljcpMWHSw5NgJ82Xp2aqUF7Hoh5MdUZBY1LfxHtHhe7slW6iAYM
         0nHIgyBJogWvJ3XbAhzJy5SkWAqswP/A+yi7Q0GGJxoB5KuJg0v+5rx6W4hmZxrWcK
         AEfZtOOyql9zA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 0C1D48C0208; Fri, 28 Apr 2023 01:47:22 -0400 (EDT)
Date:   Fri, 28 Apr 2023 01:47:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <ZEtd6qZOgRxYnNq9@mit.edu>
References: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
 <ZEny7Izr8iOc/23B@casper.infradead.org>
 <ZEn/KB0fZj8S1NTK@ovpn-8-24.pek2.redhat.com>
 <dbb8d8a7-3a80-34cc-5033-18d25e545ed1@huawei.com>
 <ZEpH+GEj33aUGoAD@ovpn-8-26.pek2.redhat.com>
 <663b10eb-4b61-c445-c07c-90c99f629c74@huawei.com>
 <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com>
 <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com>
 <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 28, 2023 at 11:47:26AM +0800, Baokun Li wrote:
> Ext4 just detects I/O Error and remounts it as read-only, it doesn't know
> if the current disk is dead or not.
> 
> I asked Yu Kuai and he said that disk_live() can be used to determine
> whether
> a disk has been removed based on the status of the inode corresponding to
> the block device, but this is generally not done in file systems.

What really needs to happen is that del_gendisk() needs to inform file
systems that the disk is gone, so that the file system can shutdown
the file system and tear everything down.

disk_live() is relatively new; it was added in August 2021.  Back in
2015, I had added the following in fs/ext4/super.c:

/*
 * The del_gendisk() function uninitializes the disk-specific data
 * structures, including the bdi structure, without telling anyone
 * else.  Once this happens, any attempt to call mark_buffer_dirty()
 * (for example, by ext4_commit_super), will cause a kernel OOPS.
 * This is a kludge to prevent these oops until we can put in a proper
 * hook in del_gendisk() to inform the VFS and file system layers.
 */
static int block_device_ejected(struct super_block *sb)
{
	struct inode *bd_inode = sb->s_bdev->bd_inode;
	struct backing_dev_info *bdi = inode_to_bdi(bd_inode);

	return bdi->dev == NULL;
}

As the comment states, it's rather awkward to have the file system
check to see if the block device is dead in various places; the real
problem is that the block device shouldn't just *vanish*, with the
block device structures egetting partially de-initialized, without the
block layer being polite enough to let the file system know.

> Those dirty pages that are already there are piling up and can't be
> written back, which I think is a real problem. Can the block layer
> clear those dirty pages when it detects that the disk is deleted?

Well, the dirty pages belong to the file system, and so it needs to be
up to the file system to clear out the dirty pages.  But I'll also
what the right thing to do when a disk gets removed is not necessarily
obvious.

For example, suppose some process has a file mmap'ed into its address
space, and that file is on the disk which the user has rudely yanked
out from their laptop; what is the right thing to do?  Do we kill the
process?  Do we let the process write to the mmap'ed region, and
silently let the modified data go *poof* when the process exits?  What
if there is an executable file on the removable disk, and there are
one or more processes running that executable when the device
disappears?  Do we kill the process?  Do we let the process run unti
it tries to access a page which hasn't been paged in and then kill the
process?

We should design a proper solution for What Should Happen when a
removable disk gets removed unceremoniously without unmounting the
file system first.  It's not just a matter of making some tests go
green....

						- Ted
						
