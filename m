Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C095349D161
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 19:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbiAZSFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 13:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiAZSFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:05:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7FFC06161C;
        Wed, 26 Jan 2022 10:05:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAB58B80EB0;
        Wed, 26 Jan 2022 18:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5813C340E3;
        Wed, 26 Jan 2022 18:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643220307;
        bh=0a2V7J6xaCLaV5Cod9PsPrvBBg8SjjTYVv4EL30ji0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wnj9CmvCHRfhEf8acSJ9ypKyoWP3qxKMeC3MHpll5wFxOHYfZw/DqvNJ5t8Qg8+tP
         CCRDd86oNizYSKbDU74H+MeDgNgXzqCn5j8OvnDTrRa5VL0orf4ATAe/XNNqzDk42Z
         sHtZRn+uZpKoW2pXGGgYhYSYtzA1xl+NOwkcPlPSBGpoR5c07tQXazKxFLx6btGxom
         tBv60WG1oKQNNKUVtKwWkDShk2g4OEn5tKquy9arOrKOtJ5vt9D2XTdyMloI1Wbo+w
         xisPFuqpHnPFaOvG3wmBaIj9g4h9dpBZUp7rwSfiBqyTxNAmh46Co0xRIs/OfCVly7
         sZuNQi6wIUoLw==
Date:   Wed, 26 Jan 2022 10:05:07 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.com
Subject: Re: [PATCHSET 0/4] vfs: actually return fs errors from ->sync_fs
Message-ID: <20220126180507.GB13499@magnolia>
References: <164316348940.2600168.17153575889519271710.stgit@magnolia>
 <20220126082153.mz5prdistkkvc6bc@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126082153.mz5prdistkkvc6bc@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 09:21:53AM +0100, Christian Brauner wrote:
> On Tue, Jan 25, 2022 at 06:18:09PM -0800, Darrick J. Wong wrote:
> > Hi all,
> > 
> > While auditing the VFS code, I noticed that while ->sync_fs is allowed
> > to return error codes to reflect some sort of internal filesystem error,
> > none of the callers actually check the return value.  Back when this
> > callout was introduced for sync_filesystem in 2.5 this didn't matter
> 
> (Also, it looks like that most(/none?) of the filesystems that
> implemented ->sync_fs around 2.5/2.6 (ext3, jfs, jffs2, reiserfs etc.)
> actually did return an error?

Yes, some of them do -- ext4 will bubble up jbd2 errors and the results
of flushing the bdev write cache.

> In fact, 5.8 seems to be the first kernel to report other errors than
> -EBADF since commit 735e4ae5ba28 ("vfs: track per-sb writeback errors
> and report them to syncfs"?)

Yeah.  I think the bdev pagecache flush might occasionally return errors
if there happened to be dirty pages, but (a) that doesn't help XFS which
has its own buffer cache and (b) that doesn't capture the state "fs has
errored out but media is fine".

As it is I think the ext4 syncfs needs to start returning EIO if someone
forced a shutdown, and probably some auditing for dropped error codes
due to the 'traditional' vfs behavior.  btrfs probably ought to return
the result of filemap_flush too.

--D
