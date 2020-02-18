Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D301620FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 07:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgBRGhh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 01:37:37 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:38081 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbgBRGhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 01:37:37 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 76F237EA064;
        Tue, 18 Feb 2020 17:37:33 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j3wVg-0006PR-Ey; Tue, 18 Feb 2020 17:37:32 +1100
Date:   Tue, 18 Feb 2020 17:37:32 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Junxiao Bi <junxiao.bi@oracle.com>
Subject: Re: [PATCH v6 10/19] fs: Convert mpage_readpages to mpage_readahead
Message-ID: <20200218063732.GP10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-18-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=VP4A6UuYfbXrVXFT8kYA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:45:58AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Implement the new readahead aop and convert all callers (block_dev,
> exfat, ext2, fat, gfs2, hpfs, isofs, jfs, nilfs2, ocfs2, omfs, qnx6,
> reiserfs & udf).  The callers are all trivial except for GFS2 & OCFS2.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Junxiao Bi <junxiao.bi@oracle.com> # ocfs2
> ---
>  drivers/staging/exfat/exfat_super.c |  7 +++---
>  fs/block_dev.c                      |  7 +++---
>  fs/ext2/inode.c                     | 10 +++-----
>  fs/fat/inode.c                      |  7 +++---
>  fs/gfs2/aops.c                      | 23 ++++++-----------
>  fs/hpfs/file.c                      |  7 +++---
>  fs/iomap/buffered-io.c              |  2 +-
>  fs/isofs/inode.c                    |  7 +++---
>  fs/jfs/inode.c                      |  7 +++---
>  fs/mpage.c                          | 38 +++++++++--------------------
>  fs/nilfs2/inode.c                   | 15 +++---------
>  fs/ocfs2/aops.c                     | 34 ++++++++++----------------
>  fs/omfs/file.c                      |  7 +++---
>  fs/qnx6/inode.c                     |  7 +++---
>  fs/reiserfs/inode.c                 |  8 +++---
>  fs/udf/inode.c                      |  7 +++---
>  include/linux/mpage.h               |  4 +--
>  mm/migrate.c                        |  2 +-
>  18 files changed, 73 insertions(+), 126 deletions(-)

That's actually pretty simple changeover. Nothing really scary
there. :)

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
