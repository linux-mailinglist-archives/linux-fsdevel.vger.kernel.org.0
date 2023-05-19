Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283F8708EA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 06:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjESELp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 00:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjESELl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 00:11:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319C010CF;
        Thu, 18 May 2023 21:11:40 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BAD3468C4E; Fri, 19 May 2023 06:11:36 +0200 (CEST)
Date:   Fri, 19 May 2023 06:11:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: introduce bdev holder ops and a file system shutdown method v2
Message-ID: <20230519041136.GA10931@lst.de>
References: <20230518042323.663189-1-hch@lst.de> <ZGbYLK0lOqYqPf9O@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGbYLK0lOqYqPf9O@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 10:00:12PM -0400, Theodore Ts'o wrote:
> On Thu, May 18, 2023 at 06:23:09AM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series fixes the long standing problem that we never had a good way
> > to communicate block device events to the user of the block device.
> > 
> > It fixes this by introducing a new set of holder ops registered at
> > blkdev_get_by_* time for the exclusive holder, and then wire that up
> > to a shutdown super operation to report the block device remove to the
> > file systems.
> 
> Thanks for working on this!  Is there going to be an fstest which
> simulates a device removal while we're running fsstress or some such,
> so we can exercise full device removal path?


So the problem with xfstests is that there isn't really any generic
way to remove a block device, and even less so to put it back.

xfstests has some scsi_debug based tests, maybe I can cook something up
for that.  My testing has been with nvme, so another option would be
to add nvme-loop support to xfstests and use that.  I'll see what I can
do.
