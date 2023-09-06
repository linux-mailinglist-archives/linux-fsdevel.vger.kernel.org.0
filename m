Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA2793FAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbjIFOzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 10:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbjIFOzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:55:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE1C1990;
        Wed,  6 Sep 2023 07:54:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55710C433C8;
        Wed,  6 Sep 2023 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694012080;
        bh=x4KcQuBfQvpvFpE5R4CSNGNTjDDTjo0HmHdevrDUcco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gX+CqMYTkuJHb/XfQoCXfubeJYWMqL00Os53jov/lcE/IiXXVIU8fW2Beh/RS1Ya+
         Rpkh9Z2Cu4xBxs5pWzbIrMwE88FcfSlv1B0hhQLk8XzVKfeGQCvm/Tg4GsiZnF5YcG
         ik+BrcCQ5lXb1oFItOuX9EKCocA4Bg8yCQ5ESpAqY94qvhx+8Gplmy7ho1E3gd4KUT
         d4dPEoNwNnasm4uHT9TakHoAsFgwJJkUyChv6D3CsqwsaXN1+GNeI1rxxqg2LM3gi9
         ppSuAql56pVN33SJE6TPZ6FPsn0So0yjh2gZ6ryg6Aqs5xUkESCBaS2dtsHHW4dzpj
         LJwIUxxoqM8ng==
Date:   Wed, 6 Sep 2023 07:54:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: handle error conditions more gracefully in
 iomap_to_bh
Message-ID: <20230906145439.GC28160@frogsfrogsfrogs>
References: <20230905124120.325518-1-hch@lst.de>
 <20230905153953.GG28202@frogsfrogsfrogs>
 <20230906-waagrecht-schwester-f3d460199ae5@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906-waagrecht-schwester-f3d460199ae5@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 04:30:39PM +0200, Christian Brauner wrote:
> On Tue, Sep 05, 2023 at 08:39:53AM -0700, Darrick J. Wong wrote:
> > On Tue, Sep 05, 2023 at 02:41:20PM +0200, Christoph Hellwig wrote:
> > > iomap_to_bh currently BUG()s when the passed in block number is not
> > > in the iomap.  For file systems that have proper synchronization this
> > > should never happen and so far hasn't in mainline, but for block devices
> > > size changes aren't fully synchronized against ongoing I/O.  Instead
> > > of BUG()ing in this case, return -EIO to the caller, which already has
> > > proper error handling.  While we're at it, also return -EIO for an
> > > unknown iomap state instead of returning garbage.
> > > 
> > > Fixes: 487c607df790 ("block: use iomap for writes to block devices")
> > > Reported-by: syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > 
> > Looks like a good improvement.  Who should this go through, me (iomap)
> > or viro/brauner (vfs*) ?
> > 
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > (lol is email down again?)
> 
> I can grab it if you want.
> What's up with email? Did you send this a long time ago?

This reply I only sent yesterday, but last week Konstantin reported that
gmail was DDOSing vger again, and then I didn't get any emails for 4
days.

On the bright side I did have a good sprint for online fsck. :)

--D
