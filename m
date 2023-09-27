Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BAC7B097E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 18:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjI0QBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjI0QBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:01:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1629C
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 09:01:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BA2C433C8;
        Wed, 27 Sep 2023 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695830503;
        bh=gq+t/bJAhKMXK+rGhCd044LajNh6CGq0hsxTUAFazwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NaTgJvmtz22X11vYYGPPGI7vbHdOsJENFnAgUwex3aP4t/xyzjYOT462Hq9W0wtmQ
         mW5AeeaXkpSkAZ8lucCvXqq+3r12IEC/5iv5KZ/7qHUREUdQMTzI3xoVTrn8ewxjN1
         t8DiKgypP44ixErfu1PaVGduYtc94Cl7vMhm/hXdT0OPep4axGz4NiL4gSit+DMmMw
         ybDfbHDsMORRUoqtOOtIGQLfPquTt+yjyT4OTGXHK7okFaCVAd6pInJ8cm1HyJjW/o
         Oqy67vipT3sJyZd9M8Afh+WToxvHpCd4bxI2Wc9LCS3Uc/kIdZ7cD9dYkKkggY37B6
         qL6CzsL2FzOlg==
Date:   Wed, 27 Sep 2023 09:01:42 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] bdev: implement freeze and thaw holder operations
Message-ID: <20230927160142.GF11456@frogsfrogsfrogs>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-3-ecc36d9ab4d9@kernel.org>
 <20230927145350.GC11414@frogsfrogsfrogs>
 <20230927-werktag-kehlkopf-48d0c4bb0fc3@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-werktag-kehlkopf-48d0c4bb0fc3@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 05:15:28PM +0200, Christian Brauner wrote:
> > > +		sync_blockdev(bdev);
> > 
> > Why ignore the return value from sync_blockdev?  It calls
> > filemap_write_and_wait, which clears AS_EIO/AS_ENOSPC from the bdev
> > mapping, which means that we'll silently drop accumulated IO errors.
> 
> Because freeze_bdev() has always ignored sync_blockdev() errors so far
> and I'm not sure what we'd do with that error. We can report it but we
> might confuse callers that think that the freeze failed when it hasn't.

Thinking about this some more...

I got confused that fs_bdev_freeze drops the bd_fsfreeze_count if
freeze_super fails.  But I guess that has to get done before letting go
of bd_holder_lock.

For the bdev->bd_holder_ops == fs_holder_ops case, the freeze_super call
will call sync_filesystem, which calls sync_blockdev.  If that fails,
the fsfreeze aborts, and the bdev freeze (at least with the old code)
would also abort.

For the !bdev->bd_holder_ops case, why not capture the sync_blockdev
error code and decrement bd_fsfreeze_count if the sync failed?  Then
this function either returns 0 with the fs and bdev frozen; or an error
code and nothing frozen.

(Also, does this mean that the new sync_blockdev call at the bottom of
fs_bdev_freeze isn't necessary?  Filesystems that do IO in ->freeze_fs
should be flushing the block device.)

--D

> > 
> > > +		mutex_unlock(&bdev->bd_holder_lock);
> > 
> > Also not sure why this fallback case holds bd_holder_lock across the
> > sync_blockdev but fs_bdev_freeze doesn't?
> 
> I'll massage that to be consistent. Thanks!
