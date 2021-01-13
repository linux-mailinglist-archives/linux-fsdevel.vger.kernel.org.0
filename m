Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244FA2F52B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 19:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbhAMSuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 13:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbhAMSuX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:50:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D0DB207A3;
        Wed, 13 Jan 2021 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610563782;
        bh=jxqvBKT6pKQlxpXnEcXRV+aAp3XKL18v0jD9gTxQod8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XRBnyiwLdpRSOKPhWinMw36N+TRus/Bi7up7HkQNZcTu2N7ZEE5asNNB3uZspYeQg
         XcCoNUuqI1V2/BmdZLbkPwyHPtPbzjGpWZw4eczh/1yXQQQGrbs8A4z3LiXQRkI5MK
         O4SkOlqoZUA7DfFx5rFh2kHxEveVBymvHDMPzvsr7WQo31jKRyCrV8y82pcbuy7nZG
         dsN2Xo37P+r1DIWl/vx3NhN6Aa9WEwnVax+49O6+LlCfiTiRrH6vhe/2U27DOG+0RX
         sf3TdtlncT9iMYdzLxzujczxx3cNDXyhlEGX4np6afd/3GFHuniQgAjnR64Gy18mt4
         MZJUIPQ0MGpPA==
Date:   Wed, 13 Jan 2021 10:49:40 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 00/11] lazytime fix and cleanups
Message-ID: <X/9AxL5Mrt+CiKHx@sol.localdomain>
References: <20210112190253.64307-1-ebiggers@kernel.org>
 <20210113162957.GA26686@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113162957.GA26686@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 13, 2021 at 05:29:58PM +0100, Jan Kara wrote:
> Hello!
> 
> On Tue 12-01-21 11:02:42, Eric Biggers wrote:
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
> > Patches 2-11 then clean up various things related to lazytime and
> > writeback, such as clarifying the semantics of ->dirty_inode() and the
> > inode dirty flags, and improving comments.
> > 
> > This patchset applies to v5.11-rc2.
> 
> Thanks for the patches. I've picked the patches to my tree. I plan to push
> patch 1/11 to Linus later this week, the rest of the cleanups will go to
> him during the next merge window.
> 
> 								Honza

Sounds good, thanks!

- Eric
