Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C1CDE173
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 02:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfJUA01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Oct 2019 20:26:27 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:39633 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbfJUA00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Oct 2019 20:26:26 -0400
Received: from dread.disaster.area (pa49-180-40-48.pa.nsw.optusnet.com.au [49.180.40.48])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B1C8A3639AA;
        Mon, 21 Oct 2019 11:26:22 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iMLWf-0002md-68; Mon, 21 Oct 2019 11:26:21 +1100
Date:   Mon, 21 Oct 2019 11:26:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] fs/xfs: Isolate the physical DAX flag from effective
Message-ID: <20191021002621.GC8015@dread.disaster.area>
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <20191020155935.12297-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020155935.12297-3-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=y881pOMu+B+mZdf5UrsJdA==:117 a=y881pOMu+B+mZdf5UrsJdA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=SKUv1dWzumgnk67EJ3kA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 20, 2019 at 08:59:32AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> xfs_ioctl_setattr_dax_invalidate() currently checks if the DAX flag is
> changing as a quick check.
> 
> But the implementation mixes the physical (XFS_DIFLAG2_DAX) and
> effective (S_DAX) DAX flags.

More nuanced than that.

The idea was that if the mount option was set, clearing the
per-inode flag would override the mount option. i.e. the mount
option sets the S_DAX flag at inode instantiation, so using
FSSETXATTR to ensure the FS_XFLAG_DAX is not set would override the
mount option setting, giving applications a way of guranteeing they
aren't using DAX to access the data.

So if the mount option is going to live on, I suspect that we want
to keep this code as it stands.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
