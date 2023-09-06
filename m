Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5B8793ECD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 16:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjIFOaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 10:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjIFOax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:30:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9301736;
        Wed,  6 Sep 2023 07:30:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D1CC433C8;
        Wed,  6 Sep 2023 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694010649;
        bh=QnzfYeDeyvRFcqm4Ye+NBx6RlwUFFjudlnjri8pCAFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8php/+wTRHPPgSgvTUYgcSH/RymURiko23cOcFnJj/BDXcedfwrKgCv3RHvP98u+
         h1uR8+97frrFuMkfH9t0wNYDeB5Q7fauAx79w3Ln2KlTQC2wevZSSCi0zHzRHhBahV
         7+k0mhGH2CI+jBi3MMhcd90WaCq7zZrNQ4JxMhqbhHngPqBw7+DXIpQASaYmmPQcXJ
         68Re+Yp7+dxMQ72SJI3b/lKBj1IJPsOEH44RRX4NvYoG+tOmebNgJYIUqovv7LShZb
         yKssvs/6ylEo+j/zOjPoWR9bTPDElBrmcZdjr/NsLuRAEjRv6+mzmf7FFkildRW1nI
         mfsVHmOy4LKJg==
Date:   Wed, 6 Sep 2023 16:30:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: handle error conditions more gracefully in
 iomap_to_bh
Message-ID: <20230906-waagrecht-schwester-f3d460199ae5@brauner>
References: <20230905124120.325518-1-hch@lst.de>
 <20230905153953.GG28202@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230905153953.GG28202@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:39:53AM -0700, Darrick J. Wong wrote:
> On Tue, Sep 05, 2023 at 02:41:20PM +0200, Christoph Hellwig wrote:
> > iomap_to_bh currently BUG()s when the passed in block number is not
> > in the iomap.  For file systems that have proper synchronization this
> > should never happen and so far hasn't in mainline, but for block devices
> > size changes aren't fully synchronized against ongoing I/O.  Instead
> > of BUG()ing in this case, return -EIO to the caller, which already has
> > proper error handling.  While we're at it, also return -EIO for an
> > unknown iomap state instead of returning garbage.
> > 
> > Fixes: 487c607df790 ("block: use iomap for writes to block devices")
> > Reported-by: syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> Looks like a good improvement.  Who should this go through, me (iomap)
> or viro/brauner (vfs*) ?
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> (lol is email down again?)

I can grab it if you want.
What's up with email? Did you send this a long time ago?
