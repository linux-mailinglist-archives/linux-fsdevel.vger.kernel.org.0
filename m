Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73933B6701
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 18:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhF1Qxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 12:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhF1Qxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:53:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68890C061574;
        Mon, 28 Jun 2021 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6jOe7QTRNMP5xH4FY0Zc/Ud/5ESHtYwEOMpkxWcLIPc=; b=qhc5oKFc3JSPo9was/RPdC2Jwv
        WQgI+Eo+NVClb+IhpPEsFI+xMgMkU/HB4iMbwV3CfSWfw66lQjIXMRw2bKH8/pOVmXO/1WVuseokp
        Aamut+g+x6aNDsPkEWNy2uyNP2/W3mPREsF+Uv701/auYMiRi0cPkyAgBKJtmA5dP6e099I3D0qly
        3n4IG7/0U83eNyEQqB5mq/LiDphi7w+DHr1K7qFpBWMF0aj00tZVn1JSldqno7S0kQxSJTUQk9gtz
        MRVc05Oa/cH6N+Fs54lyLifjA43HXHKLqGqDjEwOLHhe1apKxmDUNEjCKYRGB/smhzTrKv3ervrHa
        9QYbUVew==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxuSp-003GGO-UR; Mon, 28 Jun 2021 16:50:44 +0000
Date:   Mon, 28 Jun 2021 17:50:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 6/6] btrfs: use the filemap_fdatawrite_wbc helper for
 delalloc shrinking
Message-ID: <YNn90xi1imSwCDr/@infradead.org>
References: <cover.1624894102.git.josef@toxicpanda.com>
 <2acb56dd851d31d7b5547099821f0cbf6dfb5d29.1624894102.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2acb56dd851d31d7b5547099821f0cbf6dfb5d29.1624894102.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 11:37:11AM -0400, Josef Bacik wrote:
> sync_inode() has some holes that can cause problems if we're under heavy
> ENOSPC pressure.  If there's writeback running on a separate thread
> sync_inode() will skip writing the inode altogether.  What we really
> want is to make sure writeback has been started on all the pages to make
> sure we can see the ordered extents and wait on them if appropriate.
> Switch to this new helper which will allow us to accomplish this and
> avoid ENOSPC'ing early.

The only other exported user of sync_inode is in btrfs as well.  What
is the difference vs this caller?  Mostly I'd like to kill sync_inode
to reduce the surface of different hooks into the writeback code, and
for something externally callable your new filemap_fdatawrite_wbc
helpers looks nassively preferable of sync_inode /
writeback_single_inode.
