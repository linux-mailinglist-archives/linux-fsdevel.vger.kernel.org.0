Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3C8706973
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 15:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjEQNQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 09:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjEQNPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 09:15:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5061876A9;
        Wed, 17 May 2023 06:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7101961D97;
        Wed, 17 May 2023 13:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3FCC433D2;
        Wed, 17 May 2023 13:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329285;
        bh=QDeKK3lGWeAVDXx3JAnHSDS8JJcJQVKIgIKQJ5bYlBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d088o4jvtbl5q3pJB1jlunZXT+nBdFC4JURNrp34ZS+XJ2CsHYy2X6huCFLt2kMnC
         SCR3XSBp4S/6eiUwIrgMI63FYwjnGpYm4cPvf3k7Th20kpOHXKzZaDLNedeshBnr5E
         rBvA58d2ysS4TXRt5oA1lFDmCzHmy22/ZyxvKBFQwM95/RUf+Ji26mHpS6SfoKring
         cV5XuXjq1SCQVQuBVxLNCY7Y8vqSkZr6t+NwK5yk0h0YhjGGoHt13+U0DvlsojWCnA
         ivf/GORIzENUdPkvLNaUEVy2OcAyPMh4Xq1YPBsvTWdl4y4XQUYBIEWGuAz7HD4ki4
         4zTV3Kytoh+1g==
Date:   Wed, 17 May 2023 15:14:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230517-holzfiguren-anbot-490e5a7f74fe@brauner>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-6-hch@lst.de>
 <20230516-kommode-weizen-4c410968c1f6@brauner>
 <20230517073031.GF27026@lst.de>
 <20230517-einreden-dermatologisch-9c6a3327a689@brauner>
 <20230517080613.GA31383@lst.de>
 <20230517-erhoffen-degradieren-d0aa039f0e1d@brauner>
 <20230517120259.GA16915@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517120259.GA16915@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 02:02:59PM +0200, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 10:42:01AM +0200, Christian Brauner wrote:
> > So with an O_PATH fd the device wouldn't really be opened at all we'd
> > just hold a reference to a struct file with f->f_op set to empty_fops.
> > (See the FMODE_PATH code in fs/open.c:do_dentry_open().)
> >
> > So blkdev_open() is never called for O_PATH fds. Consequently an O_PATH
> > fd to a block device would only be useful if the intention is to later
> > lookup the block device based on inode->i_rdev.
> 
> Yes.  That's pretty much the definition of O_PATH..
> 
> > So my earlier question should have been why there's no method to lookup
> > a block device purely by non-O_PATH fd since that way you do actually
> > pin the block device which is probably what you almost always want to do.
> 
> Why would we want to pin it?  That just means the device is open and
> you're have a non-O_PATH mount.

I think we're talking past each other. Both an O_PATH fd and a regular
fd would work. But its often desirable to pass a regular fd. If
userspace uses an O_PATH fd then the block device could be looked up
later during mounting via blkdev_open().

But when you use a regular fd blkdev_open() will be called and the
device resolved right at open time and we'll hold a reference to it.

So that way userspace can immediately know whether the device can be
opened/found. That's usually preferable. That's all I meant to say.

> 
> > I'm asking because it would be nice if we could allow callers to specify
> > the source of a filesystem mount as an fd and not just as a string as
> > the mount api currently does. That's probably not super straightforward
> > but might be really worth it.
> 
> What you seem to want is a way to convert an O_PATH fs into a non-O_PATH
> one.  Which seems generally useful, but isn't really anything block
> device specific.

That already exists, indirectly. You can reopen an O_PATH fd via
/proc/$pid/$nr. And Aleksa is working on O_EMPTYPATH to make this a
first class API including restrictions for how an O_PATH fd can be
reopened. We discussed that during LSFMM.
