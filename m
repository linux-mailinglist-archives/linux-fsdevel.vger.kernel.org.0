Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0650370CFF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 03:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjEWBBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 21:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjEWBBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 21:01:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AE8E50;
        Mon, 22 May 2023 17:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95B0E62D48;
        Tue, 23 May 2023 00:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF473C433EF;
        Tue, 23 May 2023 00:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684803502;
        bh=Whm3F+BaEDtTHWv5CVbTMbR2wtAjinD7dfq3GQH8gJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwQB9AzQgK/gdEKKM3BjL9vPedjDik6d1UA3j5F/gUVmcA8wN4pK0FxwD8hrZBFpD
         SKekKphgQHbZGR3BXCFtG+nRijmHWxf2ekR3a9OJBY1VFh2txnNztS6MMS6f49Wuvo
         CxQzevNKCsppfZ1c80xdW0RYFoaB2y5SHyNoFlClxJ4Eeuyrz+7mHV/qqxFjkM0RGb
         ivnpo6nJiWqvPGzFIVuc+ikjfgKVukjZUyE4prnm+QsEXzv2fPyX4yNxVd7KxYeLfu
         yUyCJMYsmZOqzgauqffAjwSCZjl4Y/AgGzCG9UmYagDoPkwVW1t0uNbsZv3TXk4HIx
         yw8TaJ+3FOq6g==
Date:   Mon, 22 May 2023 17:58:21 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: introduce bdev holder ops and a file system shutdown method v2
Message-ID: <20230523005821.GF11620@frogsfrogsfrogs>
References: <20230518042323.663189-1-hch@lst.de>
 <ZGbYLK0lOqYqPf9O@mit.edu>
 <20230519041136.GA10931@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519041136.GA10931@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 06:11:36AM +0200, Christoph Hellwig wrote:
> On Thu, May 18, 2023 at 10:00:12PM -0400, Theodore Ts'o wrote:
> > On Thu, May 18, 2023 at 06:23:09AM +0200, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series fixes the long standing problem that we never had a good way
> > > to communicate block device events to the user of the block device.
> > > 
> > > It fixes this by introducing a new set of holder ops registered at
> > > blkdev_get_by_* time for the exclusive holder, and then wire that up
> > > to a shutdown super operation to report the block device remove to the
> > > file systems.
> > 
> > Thanks for working on this!  Is there going to be an fstest which
> > simulates a device removal while we're running fsstress or some such,
> > so we can exercise full device removal path?
> 
> 
> So the problem with xfstests is that there isn't really any generic
> way to remove a block device, and even less so to put it back.
> 
> xfstests has some scsi_debug based tests, maybe I can cook something up
> for that.  My testing has been with nvme, so another option would be
> to add nvme-loop support to xfstests and use that.  I'll see what I can
> do.

Could you make dm-error accept a 'message' telling it to invoke all
these bdev removal actions?  There's already a bunch of helpers in
fstests to make that less awful for test authors.

--D
