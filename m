Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8DBEF90AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKLNa7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 08:30:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:47964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfKLNa6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:30:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44A94AEEE;
        Tue, 12 Nov 2019 13:30:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 462B11E4AD2; Tue, 12 Nov 2019 14:30:55 +0100 (CET)
Date:   Tue, 12 Nov 2019 14:30:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     ira.weiny@intel.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/2] fs: Move swap_[de]activate to file_operations
Message-ID: <20191112133055.GI1241@quack2.suse.cz>
References: <20191112003452.4756-1-ira.weiny@intel.com>
 <20191112003452.4756-3-ira.weiny@intel.com>
 <20191112065507.GA15915@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112065507.GA15915@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 11-11-19 22:55:07, Christoph Hellwig wrote:
> On Mon, Nov 11, 2019 at 04:34:52PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > swap_activate() and swap_deactivate() have nothing to do with
> > address spaces.  We want to eventually make the address space operations
> > dynamic to switch inode flags on the fly.  So to simplify this code as
> > well as properly track these operations we move these functions to the
> > file_operations vector.
> 
> What is the point?  If we switch aops for DAX vs not we might as well
> switch file operations as well, as they pretty much are entirely
> different.

Ira is trying to make switching of inodes between DAX and non-DAX mode
work. Currently, we have different address_space_operations for DAX vs
non-DAX and that makes sense because operation for address_space is vastly
different for DAX compared to page cache. But switching of aops is
difficult to do reliably so I've suggested to move functions that don't
make too much sense in aops out to simplify the picture.

Currently file_operations are the same (both on XFS and ext4) for DAX and
non-DAX case so we don't need to switch them. And although I agree that for
some operations split may make sense, I think most of the operations would
be actually the same for DAX vs non-DAX case so I don't see a point in
separating file_operations for DAX vs non-DAX case.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
