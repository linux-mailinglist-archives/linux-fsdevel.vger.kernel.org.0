Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7354B35E132
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 16:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhDMORc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 10:17:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:35586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhDMORc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:17:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73746B178;
        Tue, 13 Apr 2021 14:17:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 06D941E37A2; Tue, 13 Apr 2021 16:17:11 +0200 (CEST)
Date:   Tue, 13 Apr 2021 16:17:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 0/7 RFC v3] fs: Hole punch vs page cache filling races
Message-ID: <20210413141710.GE15752@quack2.suse.cz>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210413130950.GD1366579@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413130950.GD1366579@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 13-04-21 14:09:50, Christoph Hellwig wrote:
> > Also when writing the documentation I came across one question: Do we mandate
> > i_mapping_sem for truncate + hole punch for all filesystems or just for
> > filesystems that support hole punching (or other complex fallocate operations)?
> > I wrote the documentation so that we require every filesystem to use
> > i_mapping_sem. This makes locking rules simpler, we can also add asserts when
> > all filesystems are converted. The downside is that simple filesystems now pay
> > the overhead of the locking unnecessary for them. The overhead is small
> > (uncontended rwsem acquisition for truncate) so I don't think we care and the
> > simplicity is worth it but I wanted to spell this out.
> 
> I think all makes for much better to understand and document rules,
> so I'd shoot for that eventually.

OK.

> Btw, what about locking for DAX faults?  XFS seems to take
> the mmap sem for those as well currently.

Yes, I've mechanically converted all those uses to i_mapping_sem for XFS,
ext4, and ext2 as well. Longer term we may be able to move some locking
into generic DAX code now that the lock is in struct inode. But I want to
leave that for later since DAX locking is different enough that it needs
some careful thinking and justification...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
