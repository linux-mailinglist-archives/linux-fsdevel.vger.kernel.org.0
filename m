Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54FC706B0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 16:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjEQO0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 10:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjEQO0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 10:26:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288B17A93;
        Wed, 17 May 2023 07:26:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E164168BEB; Wed, 17 May 2023 16:26:09 +0200 (CEST)
Date:   Wed, 17 May 2023 16:26:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230517142609.GA28898@lst.de>
References: <20230505175132.2236632-1-hch@lst.de> <20230505175132.2236632-6-hch@lst.de> <20230516-kommode-weizen-4c410968c1f6@brauner> <20230517073031.GF27026@lst.de> <20230517-einreden-dermatologisch-9c6a3327a689@brauner> <20230517080613.GA31383@lst.de> <20230517-erhoffen-degradieren-d0aa039f0e1d@brauner> <20230517120259.GA16915@lst.de> <20230517-holzfiguren-anbot-490e5a7f74fe@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517-holzfiguren-anbot-490e5a7f74fe@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 03:14:40PM +0200, Christian Brauner wrote:
> > Why would we want to pin it?  That just means the device is open and
> > you're have a non-O_PATH mount.
> 
> I think we're talking past each other. Both an O_PATH fd and a regular
> fd would work. But its often desirable to pass a regular fd. If
> userspace uses an O_PATH fd then the block device could be looked up
> later during mounting via blkdev_open().
> 
> But when you use a regular fd blkdev_open() will be called and the
> device resolved right at open time and we'll hold a reference to it.
> 
> So that way userspace can immediately know whether the device can be
> opened/found. That's usually preferable. That's all I meant to say.

I know what you mean.  But based on the concept of how O_PATH and
block devices work it really doesn't make any sense to have a block
device handle for an O_PATH fd, except for the actual fd itself.
