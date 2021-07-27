Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993E33D79E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 17:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhG0PfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 11:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236974AbhG0Pen (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:34:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F65161B30;
        Tue, 27 Jul 2021 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627400016;
        bh=4PZARTzEx+NyszsOAu6lbi7w9h8FOGeHdmwe6pE+9NE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMfiwaUj6xWzdeDehxp1Kzifwu3wYRSTIGzv9URGKhVGQ7a5oKrqU5xwTPvM8rNx8
         pL33hpdBVSGbU0eDKRD5kdDDGpSsg07OudM+eVRisgp4MLTvCbY68gt6AFwrlEaWeL
         aopLejmyoFelH+9R0wF/F8FIhMojSeOMTZFJVWxqpP5Rgqa4t4zjqH2VX+AdH5XtWu
         uSZlHgfJSee0K/66CiOCohm2St51HvN8o1LX6E39pR4NUcaFuF7YLB9uTQuObrvHCe
         87yYD/bifuFjreteUYJGN6RMd5ynEbjBdzoY0CxjBKru8RyTZKG4/VRSpIqcus1Gg1
         6rq0L0f6sjiKQ==
Date:   Tue, 27 Jul 2021 08:33:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 3/9] f2fs: rework write preallocations
Message-ID: <20210727153335.GE559212@magnolia>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-4-ebiggers@kernel.org>
 <14782036-f6a5-878a-d21f-e7dd7008a285@kernel.org>
 <YP2l+1umf9ct/4Sp@sol.localdomain>
 <YP9oou9sx4oJF1sc@google.com>
 <70f16fec-02f6-cb19-c407-856101cacc23@kernel.org>
 <YP+38QzXS6kpLGn0@sol.localdomain>
 <70d9c954-d7f0-bbe2-f078-62273229342f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70d9c954-d7f0-bbe2-f078-62273229342f@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 04:30:16PM +0800, Chao Yu wrote:
> On 2021/7/27 15:38, Eric Biggers wrote:
> > That's somewhat helpful, but I've been doing some more investigation and now I'm
> > even more confused.  How can f2fs support non-overwrite DIO writes at all
> > (meaning DIO writes in LFS mode as well as DIO writes to holes in non-LFS mode),
> > given that it has no support for unwritten extents?  AFAICS, as-is users can
> 
> I'm trying to pick up DAX support patch created by Qiuyang from huawei, and it
> looks it faces the same issue, so it tries to fix this by calling sb_issue_zeroout()
> in f2fs_map_blocks() before it returns.

I really hope you don't, because zeroing the region before memcpy'ing it
is absurd.  I don't know if f2fs can do that (xfs can't really) without
pinning resources during a potentially lengthy memcpy operation, but you
/could/ allocate the space in ->iomap_begin, attach some record of that
to iomap->private, and only commit the mapping update in ->iomap_end.

--D

> > easily leak uninitialized disk contents on f2fs by issuing a DIO write that
> > won't complete fully (or might not complete fully), then reading back the blocks
> > that got allocated but not written to.
> > 
> > I think that f2fs will have to take the ext2 approach of not allowing
> > non-overwrite DIO writes at all...
> Yes,
> 
> Another option is to enhance f2fs metadata's scalability which needs to update layout
> of dnode block or SSA block, after that we can record the status of unwritten data block
> there... it's a big change though...
> 
> Thanks,
> 
> > 
> > - Eric
> > 
