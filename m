Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1655516AE33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 18:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBXR4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 12:56:06 -0500
Received: from verein.lst.de ([213.95.11.211]:39459 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbgBXR4G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:56:06 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BF32268B20; Mon, 24 Feb 2020 18:56:03 +0100 (CET)
Date:   Mon, 24 Feb 2020 18:56:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 07/13] fs: Add locking for a dynamic address space
 operations state
Message-ID: <20200224175603.GE7771@lst.de>
References: <20200221004134.30599-1-ira.weiny@intel.com> <20200221004134.30599-8-ira.weiny@intel.com> <20200221174449.GB11378@lst.de> <20200221224419.GW10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200221224419.GW10776@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 22, 2020 at 09:44:19AM +1100, Dave Chinner wrote:
> > I am very much against this.  There is a reason why we don't support
> > changes of ops vectors at runtime anywhere else, because it is
> > horribly complicated and impossible to get right.  IFF we ever want
> > to change the DAX vs non-DAX mode (which I'm still not sold on) the
> > right way is to just add a few simple conditionals and merge the
> > aops, which is much easier to reason about, and less costly in overall
> > overhead.
> 
> *cough*
> 
> That's exactly what the original code did. And it was broken
> because page faults call multiple aops that are dependent on the
> result of the previous aop calls setting up the state correctly for
> the latter calls. And when S_DAX changes between those calls, shit
> breaks.

No, the original code was broken because it didn't serialize between
DAX and buffer access.

Take a step back and look where the problems are, and they are not
mostly with the aops.  In fact the only aop useful for DAX is
is ->writepages, and how it uses ->writepages is actually a bit of
an abuse of that interface.

So what we really need it just a way to prevent switching the flag
when a file is mapped, and in the normal read/write path ensure the
flag can't be switch while I/O is going on, which could either be
done by ensuring it is only switched under i_rwsem or equivalent
protection, or by setting the DAX flag once in the iocb similar to
IOCB_DIRECT.

And they easiest way to get all this done is as a first step to
just allowing switching the flag when no blocks are allocated at
all, similar to how the rt flag works.  Once that works properly
and use cases show up we can relax the requirements, and we need
to do that in a way without bloating the inode and various VFS
code paths, as DAX is a complete fringe feature, and ѕwitching
the flag and runtime is the fringe of a fringe.  It just isn't worth
bloating the inode and wasting tons of developer time on it.
