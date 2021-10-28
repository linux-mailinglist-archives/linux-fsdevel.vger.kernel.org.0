Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E461E43E66E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 18:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhJ1QpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 12:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhJ1QpE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 12:45:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACC78610D2;
        Thu, 28 Oct 2021 16:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635439356;
        bh=NE7XYNiuhZ3BSTKFyi5m971OKu0ViyxEHVsbDZV7WMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZXiXYrlqNYfjtFTt6cVBKAQuMZGnXi832MbFrM7jkCLQHW/01Y6BgNFnsNM7Io2kE
         z9mQx+msHIEwZxjp6MinC3DV2WDbWAySTbh2q3lvoSUD69JF32pa8wjKtRaorFw46o
         fS3Z91bS+wZ/KaKo8N+5VlWGMJl8Fg/Dj5SdDJAmTZifDJsEKozl+Ng6pl4HPw6DY2
         GF/DJkP3lj7oDjleYoIiyRopzqLqRWZNpk0cqzG1xLQaAFrfvj6rbRIVC9CpVahW4a
         ujqY/O8BBd9dI43lk5EJNunk7o7N/U/C8FZy08+TR1HCyE+8dKAduJT/aI69E0PA4Z
         JxMBo9+GtJVCw==
Date:   Thu, 28 Oct 2021 09:42:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        ira.weiny@intel.com, linux-xfs@vger.kernel.org,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [Question] ext4/xfs: Default behavior changed after per-file DAX
Message-ID: <20211028164236.GD24307@magnolia>
References: <26ddaf6d-fea7-ed20-cafb-decd63b2652a@linux.alibaba.com>
 <20211026154834.GB24307@magnolia>
 <YXhWP/FCkgHG/+ou@redhat.com>
 <20211026223317.GB5111@dread.disaster.area>
 <YXlQyMfXDQnO/5E3@redhat.com>
 <ef95af19-4b0a-61e8-5dfa-3e223118da8e@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef95af19-4b0a-61e8-5dfa-3e223118da8e@sandeen.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 28, 2021 at 11:29:08AM -0500, Eric Sandeen wrote:
> On 10/27/21 8:14 AM, Vivek Goyal wrote:
> > On Wed, Oct 27, 2021 at 09:33:17AM +1100, Dave Chinner wrote:
> 
> ...
> 
> > Hi Dave,
> > 
> > Thanks for all the explanaiton and background. It helps me a lot in
> > wrapping my head around the rationale for current design.
> > 
> > > It's perfectly reasonable. If the hardware doesn't support DAX, then
> > > we just always behave as if dax=never is set.
> > 
> > I tried mounting non-DAX block device with dax=always and it failed
> > saying DAX can't be used with reflink.
> > 
> > [  100.371978] XFS (vdb): DAX unsupported by block device. Turning off DAX.
> > [  100.374185] XFS (vdb): DAX and reflink cannot be used together!
> > 
> > So looks like first check tried to fallback to dax=never as device does
> > not support DAX. But later reflink check thought dax is enabled and
> > did not fallback to dax=never.
> 
> We need to think hard about this stuff and audit it to be sure.
> 
> But, I think that reflink check should probably just be removed, now that
> DAX files and reflinked files can co-exist on a filesystem - it's just
> that they can't both be active on the /same file/.
> 
> I think that even "dax=always" is still just "advisory" - it means,
> try to enable dax on every file. It may still fail in the same ways as
> dax=inode (default) + flag set may fail.
> 
> But ... we should go through the whole mount option / feature set /
> device capability logic to be sure this is all consistent. Thanks for
> pointing it out!

I was rather hoping that we'd solve this problem by helping Shiyang get
his two patchsets landed, and then we can eliminate the dax+reflink
check entirely.

[1] (dax poison notifications via rmap V7)
https://lore.kernel.org/linux-xfs/20210924130959.2695749-1-ruansy.fnst@fujitsu.com/
[2] (reflink + dax V10)
https://lore.kernel.org/linux-xfs/20210928062311.4012070-1-ruansy.fnst@fujitsu.com/

(The second patchset is AFAICT ready to go, but we still need to iron
out the difficulties pointed out in the last review of patchset #1)

--D

> -Eric
> 
> > > IO
