Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB94D707BAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 10:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjERINR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjERINQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 04:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDCBE49;
        Thu, 18 May 2023 01:13:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A15B7647AC;
        Thu, 18 May 2023 08:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFE3C433EF;
        Thu, 18 May 2023 08:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684397595;
        bh=wE2Pg/kCwJdUtmsHcw40//fG3o+xAL57sjl5H3XSKyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uOoLtCeYOecCLhbqEATjM5CStdPLQhpbdx5oaVkY6GmKcjfJQDPhpJRutlS5y+XVQ
         zgxAqeFenwIGe4GyIzjxmxLZRD+JXZhH+/E5MEgV4rsK5WXuAPqBC/5Q70JmPh2EiC
         NJfandZAKmrvYpfflIRfjir0KJumqsPGiAYl/le8bd5FUVudxgqjUxwp2VIqF6DjLG
         rjhz9OMKUB8/9BY2tLKUGjetm1JaenJ8hoa8/TC9cO5ms+pLZi3BUvdfy0lNqCMtIY
         8KGdaSCq+H6IfMxON4n0rZiqZ0eZu8dycyUcLKFjZh72y1f+m4jZYbQ5kKCV3VUM9/
         /hPfoxqFM+8/w==
Date:   Thu, 18 May 2023 10:13:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230518-teekanne-knifflig-a4ea8c3c885a@brauner>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-6-hch@lst.de>
 <20230516-kommode-weizen-4c410968c1f6@brauner>
 <20230517073031.GF27026@lst.de>
 <20230517-einreden-dermatologisch-9c6a3327a689@brauner>
 <20230517080613.GA31383@lst.de>
 <20230517-erhoffen-degradieren-d0aa039f0e1d@brauner>
 <20230517120259.GA16915@lst.de>
 <20230517-holzfiguren-anbot-490e5a7f74fe@brauner>
 <20230517142609.GA28898@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517142609.GA28898@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 04:26:09PM +0200, Christoph Hellwig wrote:
> On Wed, May 17, 2023 at 03:14:40PM +0200, Christian Brauner wrote:
> > > Why would we want to pin it?  That just means the device is open and
> > > you're have a non-O_PATH mount.
> > 
> > I think we're talking past each other. Both an O_PATH fd and a regular
> > fd would work. But its often desirable to pass a regular fd. If
> > userspace uses an O_PATH fd then the block device could be looked up
> > later during mounting via blkdev_open().
> > 
> > But when you use a regular fd blkdev_open() will be called and the
> > device resolved right at open time and we'll hold a reference to it.
> > 
> > So that way userspace can immediately know whether the device can be
> > opened/found. That's usually preferable. That's all I meant to say.
> 
> I know what you mean.  But based on the concept of how O_PATH and
> block devices work it really doesn't make any sense to have a block
> device handle for an O_PATH fd, except for the actual fd itself.

Fwiw, I didn't mean to have a special device handler for an O_PATH fd.
I really just tried to figure out whether it would make sense to have an
fd-based block device lookup function because right now we only have
blkdev_get_by_path() and we'd be passing blkdev fds through the mount
api. But I understand now how I'd likely do it. So now just finding time
to actually implement it.
