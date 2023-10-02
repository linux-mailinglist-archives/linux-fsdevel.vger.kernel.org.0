Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BB37B4BCA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 08:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbjJBGzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 02:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbjJBGy6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:54:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698F4C9
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 Oct 2023 23:54:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4B71668CFE; Mon,  2 Oct 2023 08:54:52 +0200 (CEST)
Date:   Mon, 2 Oct 2023 08:54:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] bdev: implement freeze and thaw holder operations
Message-ID: <20231002065451.GC2068@lst.de>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org> <20230927-vfs-super-freeze-v1-3-ecc36d9ab4d9@kernel.org> <20230927145350.GC11414@frogsfrogsfrogs> <20230927-werktag-kehlkopf-48d0c4bb0fc3@brauner> <20230927160142.GF11456@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927160142.GF11456@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 09:01:42AM -0700, Darrick J. Wong wrote:
> 
> For the bdev->bd_holder_ops == fs_holder_ops case, the freeze_super call
> will call sync_filesystem, which calls sync_blockdev.  If that fails,
> the fsfreeze aborts, and the bdev freeze (at least with the old code)
> would also abort.
> 
> For the !bdev->bd_holder_ops case, why not capture the sync_blockdev
> error code and decrement bd_fsfreeze_count if the sync failed?  Then
> this function either returns 0 with the fs and bdev frozen; or an error
> code and nothing frozen.

Yes, even if that is a behavior change it would be a lot more consistent.
Maybe do the capturing of the error code as a prep patch so that it
is clearly bisectable.

> (Also, does this mean that the new sync_blockdev call at the bottom of
> fs_bdev_freeze isn't necessary?  Filesystems that do IO in ->freeze_fs
> should be flushing the block device.)

Various methods including freeze do the sync_blockdev unconditionally.
I think this is a bad idea and should be moved into the file systems,
but I don't think this is in scope for this series.
