Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E6811D9A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 23:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfLLWqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 17:46:15 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55030 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730707AbfLLWqO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:46:14 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9A3BC3A3756;
        Fri, 13 Dec 2019 09:46:09 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ifXDl-000626-3W; Fri, 13 Dec 2019 09:46:09 +1100
Date:   Fri, 13 Dec 2019 09:46:09 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        fdmanana@kernel.org, dsterba@suse.cz, jthumshirn@suse.de,
        nborisov@suse.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/8] iomap: Move lockdep_assert_held() to iomap_dio_rw()
 calls
Message-ID: <20191212224609.GI19213@dread.disaster.area>
References: <20191212003043.31093-1-rgoldwyn@suse.de>
 <20191212003043.31093-5-rgoldwyn@suse.de>
 <20191212095044.GD15977@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212095044.GD15977@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=iox4zFpeAAAA:8 a=7-415B0cAAAA:8 a=0qbdD3YL78Zpoe-PC_wA:9
        a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:50:44AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 11, 2019 at 06:30:39PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Filesystems such as btrfs can perform direct I/O without holding the
> > inode->i_rwsem in some of the cases like writing within i_size.
> 
> How is that safe?  
> 
> > +	lockdep_assert_held(&file_inode(file)->i_rwsem);
> 
> Having the asserts in the callers is pointless.  The assert is inside
> the iomap helper to ensure the expected calling conventions, as the
> code is written under the assumption that we have i_rwsem.

It's written under the assumption that the caller has already
performed the appropriate locking they require for serialisation
against other operations on that inode.

The fact that the filesystems up to this point all used the i_rwsem
is largely irrelevant, and filesystems don't have to use the i_rwsem
to serialise their IO. e.g. go back a handful of years and this
would have needed to take into account an XFS specific rwsem, not
the VFS inode mutex...

Indeed, the IO range locking patches I have for XFS get rid of this
lockdep assert in iomap because we no longer use the i_rwsem for IO
serialisation in XFS - we go back to using an internal XFS construct
for IO serialisation and don't use the i_rwsem at all.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
