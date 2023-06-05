Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C251722D79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 19:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjFERSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 13:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjFERSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:18:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152119E;
        Mon,  5 Jun 2023 10:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A406D622C3;
        Mon,  5 Jun 2023 17:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013D0C433D2;
        Mon,  5 Jun 2023 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685985527;
        bh=zy4OYg5iAjuFpxS6eDlvpz+l89Wg9QaBuKy175VsrDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ttLD82w1O2tP4dTvksawB8IZOT/0vUz9IMYY0uq7p8wELeSxnFWBoTvu3Yn6qsyPw
         mnzAac5g1Il2wEst59f7KdsbQb4AILKVJpq6WFCc4G9cAXX5hqMx+HKLffPrcGwHtK
         xmeUTREm/G2RAD5GVXNLFJHJTqlZXlFIzP9cDQyA/yIzHXI6ezOXuFv1phqFVF/pVj
         rwr/fL3Xlk/2N3nI2eiUu+wHsV9WWeNAZdbpBm2X5wVlzMwRhk45wIq1USlWSRTAhy
         182sIn7eAxs3Dp5IetfEIHQ/1uZn9O9f7TN/9c6USOW0fMnLT02Xq3zcKDqAl0FjxP
         VNbCf4U/A4Nvw==
Date:   Mon, 5 Jun 2023 10:18:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: DIO hangs in 6.4.0-rc2
Message-ID: <20230605171846.GM72241@frogsfrogsfrogs>
References: <ZGN20Hp1ho/u4uPY@casper.infradead.org>
 <ZGP/H1UQgMYemYP1@dread.disaster.area>
 <ZH4KaEtLS1bdSl1c@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH4KaEtLS1bdSl1c@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 05:16:40PM +0100, Matthew Wilcox wrote:
> On Wed, May 17, 2023 at 08:09:35AM +1000, Dave Chinner wrote:
> > On Tue, May 16, 2023 at 01:28:00PM +0100, Matthew Wilcox wrote:
> > > Plain 6.4.0-rc2 with a relatively minor change to the futex code that
> > > I cannot believe was in any way responsible for this.
> > > 
> > > kworkers blocked all over the place.  Some on XFS_ILOCK_EXCL.  Some on
> > > xfs_buf_lock.  One in xfs_btree_split() calling wait_for_completion.
> > > 
> > > This was an overnight test run that is now dead, so I can't get any
> > > more info from the locked up kernel.  I have the vmlinux if some
> > > decoding of offsets is useful.
> > 
> > This is likely the same AGF try-lock bug that was discovered in this
> > thread:
> > 
> > https://lore.kernel.org/linux-xfs/202305090905.aff4e0e6-oliver.sang@intel.com/
> > 
> > The fact that the try-lock was ignored means that out of order AGF
> > locking can be attempted, and the try-lock prevents deadlocks from
> > occurring.
> > 
> > Can you try the patch below - I was going to send it for review
> > anyway this morning so it can't hurt to see if it also fixes this
> > issue.
> 
> I still have this patch in my tree and it's not in rc5.  Was this
> problem fixed some other way, or does it still need to land upstream?
> I don't see any changes to XFS since May 11th's pull request.

Seems to have landed in for-next last night?

https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=00dcd17cfa7f103f7d640ffd34645a2ddab96330

--D
