Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D77325CBEB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 23:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgICVNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 17:13:12 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:38507 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgICVNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:13:12 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id DE6678233B3;
        Fri,  4 Sep 2020 07:13:07 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kDwXa-0005LV-HQ; Fri, 04 Sep 2020 07:13:06 +1000
Date:   Fri, 4 Sep 2020 07:13:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        ocfs2 list <ocfs2-devel@oss.oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Sandeen <sandeen@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: Broken O_{D,}SYNC behavior with FICLONE*?
Message-ID: <20200903211306.GE12131@dread.disaster.area>
References: <20200903035225.GJ6090@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903035225.GJ6090@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=XJ9OtjpE c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=FD1UHmYh5NI2xiT9T8wA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 02, 2020 at 08:52:25PM -0700, Darrick J. Wong wrote:
> Hi,
> 
> I have a question for everyone-- do FICLONE and FICLONERANGE count as a
> "write operation" for the purposes of reasoning about O_SYNC and
> O_DSYNC?

I'd say yes, because we are changing metadata that is used to
directly reference the data in the file. O_DSYNC implies all the
metadata needed to access the data is on stable storage when the
operation returns....

> So, that's inconsistent behavior and I want to know if remap_file_range
> is broken or if we all just don't care about O_SYNC for these fancy
> IO accelerators?

Perhaps we should pay attention to the NFSD implementation of CloneFR -
if the operation is sync then it will run fsync on the destination
and commit_metadata on the source inode. See
nfsd4_clone_file_range().

So, yeah, I think clone operations need to pay attention to
O_DSYNC/O_SYNC/IS_SYNC()....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
