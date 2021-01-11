Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E896F2F210D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 21:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390882AbhAKUpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 15:45:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391313AbhAKUpS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:45:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0922F222B6;
        Mon, 11 Jan 2021 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610397877;
        bh=M1OSN1vteho8Huw58TPHtw4Wnq7VMtKCfQ1CREQhDR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g6E1CBBApgNQRIvnyUYpczU4snTK3TxTIWiGp2D7l9axmxnf6NKFoHnat6vVu4e2x
         I9XIFx85m+OaASnJa35GO1Lnq6n9jCT+wDbjGwYs6QheK3MCRNoAdJlZfYYodREnYB
         o+3ziJVlenNjdNHZNq3EDaRlJJAlbS6mK1P7kvZryDnMiAPy1kFnfILWddwBcW6wxu
         SELSewJq8rbzB/ndE+t+XbX/vEKHxLvi2jQezrrvts8jJ1y/+Ad2x5xKCgaHtetEX3
         OZcpXXl3Hsh8sIV0cn0ov2lVF0/F8gETBM8QdHmHtC59U75feIsb+nL+o6/OlT3c++
         dyjRmmLboidRg==
Date:   Mon, 11 Jan 2021 12:44:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 00/12] lazytime fix and cleanups
Message-ID: <X/y4s12YrXiUwWfN@sol.localdomain>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210111151517.GK18475@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111151517.GK18475@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 04:15:17PM +0100, Jan Kara wrote:
> Hi!
> 
> On Fri 08-01-21 23:58:51, Eric Biggers wrote:
> > Hello,
> > 
> > Patch 1 fixes a bug in how __writeback_single_inode() handles lazytime
> > expirations.  I originally reported this last year
> > (https://lore.kernel.org/r/20200306004555.GB225345@gmail.com) because it
> > causes the FS_IOC_REMOVE_ENCRYPTION_KEY ioctl to not work properly, as
> > the bug causes inodes to remain dirty after a sync.
> > 
> > It also turns out that lazytime on XFS is partially broken because it
> > doesn't actually write timestamps to disk after a sync() or after
> > dirtytime_expire_interval.  This is fixed by the same fix.
> > 
> > This supersedes previously proposed fixes, including
> > https://lore.kernel.org/r/20200307020043.60118-1-tytso@mit.edu and
> > https://lore.kernel.org/r/20200325122825.1086872-3-hch@lst.de from last
> > year (which had some issues and didn't fix the XFS bug), and v1 of this
> > patchset which took a different approach
> > (https://lore.kernel.org/r/20210105005452.92521-1-ebiggers@kernel.org).
> > 
> > Patches 2-12 then clean up various things related to lazytime and
> > writeback, such as clarifying the semantics of ->dirty_inode() and the
> > inode dirty flags, and improving comments.  Most of these patches could
> > be applied independently if needed.
> > 
> > This patchset applies to v5.11-rc2.
> 
> The series look good to me. How do you plan to merge it (after resolving
> Christoph's remarks)? I guess either Ted can take it through the ext4 tree
> or I can take it through my tree...
> 

I think taking it through your tree would be best, unless Al or Ted wants to
take it.

I'll probably separate out
"xfs: remove a stale comment from xfs_file_aio_write_checks()",
since it isn't really related anymore and could go in through the XFS tree.

- Eric
