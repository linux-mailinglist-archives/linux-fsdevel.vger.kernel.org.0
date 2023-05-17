Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C742E70678A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 14:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjEQMGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 08:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjEQMGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 08:06:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C27883D2;
        Wed, 17 May 2023 05:03:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 963E168C4E; Wed, 17 May 2023 14:02:59 +0200 (CEST)
Date:   Wed, 17 May 2023 14:02:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230517120259.GA16915@lst.de>
References: <20230505175132.2236632-1-hch@lst.de> <20230505175132.2236632-6-hch@lst.de> <20230516-kommode-weizen-4c410968c1f6@brauner> <20230517073031.GF27026@lst.de> <20230517-einreden-dermatologisch-9c6a3327a689@brauner> <20230517080613.GA31383@lst.de> <20230517-erhoffen-degradieren-d0aa039f0e1d@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517-erhoffen-degradieren-d0aa039f0e1d@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 10:42:01AM +0200, Christian Brauner wrote:
> So with an O_PATH fd the device wouldn't really be opened at all we'd
> just hold a reference to a struct file with f->f_op set to empty_fops.
> (See the FMODE_PATH code in fs/open.c:do_dentry_open().)
>
> So blkdev_open() is never called for O_PATH fds. Consequently an O_PATH
> fd to a block device would only be useful if the intention is to later
> lookup the block device based on inode->i_rdev.

Yes.  That's pretty much the definition of O_PATH..

> So my earlier question should have been why there's no method to lookup
> a block device purely by non-O_PATH fd since that way you do actually
> pin the block device which is probably what you almost always want to do.

Why would we want to pin it?  That just means the device is open and
you're have a non-O_PATH mount.

> I'm asking because it would be nice if we could allow callers to specify
> the source of a filesystem mount as an fd and not just as a string as
> the mount api currently does. That's probably not super straightforward
> but might be really worth it.

What you seem to want is a way to convert an O_PATH fs into a non-O_PATH
one.  Which seems generally useful, but isn't really anything block
device specific.
