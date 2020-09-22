Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D323C27387D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 04:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgIVC3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 22:29:46 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:21398 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729617AbgIVC3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 22:29:46 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 22:29:45 EDT
X-IronPort-AV: E=Sophos;i="5.77,288,1596470400"; 
   d="scan'208";a="99488774"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Sep 2020 10:19:38 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 2C55948990E9;
        Tue, 22 Sep 2020 10:19:38 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 22 Sep 2020 10:19:36 +0800
Received: from localhost.localdomain (10.167.225.206) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2 via Frontend Transport; Tue, 22 Sep 2020 10:19:35 +0800
Date:   Tue, 22 Sep 2020 10:19:35 +0800
From:   Hao Li <lihao2018.fnst@cn.fujitsu.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <y-goto@fujitsu.com>
Subject: Re: [PATCH v2] fs: Handle I_DONTCACHE in iput_final() instead of
 generic_drop_inode()
Message-ID: <20200922021935.GA56122@localhost.localdomain>
References: <20200904075939.176366-1-lihao2018.fnst@cn.fujitsu.com>
 <20200906214002.GI12131@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200906214002.GI12131@dread.disaster.area>
X-yoursite-MailScanner-ID: 2C55948990E9.AC9F3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 07, 2020 at 07:40:02AM +1000, Dave Chinner wrote:
> On Fri, Sep 04, 2020 at 03:59:39PM +0800, Hao Li wrote:
> > If generic_drop_inode() returns true, it means iput_final() can evict
> > this inode regardless of whether it is dirty or not. If we check
> > I_DONTCACHE in generic_drop_inode(), any inode with this bit set will be
> > evicted unconditionally. This is not the desired behavior because
> > I_DONTCACHE only means the inode shouldn't be cached on the LRU list.
> > As for whether we need to evict this inode, this is what
> > generic_drop_inode() should do. This patch corrects the usage of
> > I_DONTCACHE.
> > 
> > This patch was proposed in [1].
> > 
> > [1]: https://lore.kernel.org/linux-fsdevel/20200831003407.GE12096@dread.disaster.area/
> > 
> > Fixes: dae2f8ed7992 ("fs: Lift XFS_IDONTCACHE to the VFS layer")
> > Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
> > ---
> > Changes in v2:
> >  - Adjust code format
> >  - Add Fixes tag in commit message
> > 
> >  fs/inode.c         | 4 +++-
> >  include/linux/fs.h | 3 +--
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> Looks good.
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> 

Hi,

As discussed in [1], this patch is the basis of another one. Could I
submit the second patch now to change the DCACHE_DONTCACHE behavior or I
have to wait for this patch to be merged.

[1]: https://lkml.org/lkml/2020/8/30/360

Thanks,
Hao Li

> -- 
> Dave Chinner
> david@fromorbit.com
> 
> 


