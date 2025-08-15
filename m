Return-Path: <linux-fsdevel+bounces-58031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DD7B281CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A3618927AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54B0235C01;
	Fri, 15 Aug 2025 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s69DztBf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931C1E230E;
	Fri, 15 Aug 2025 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268149; cv=none; b=jMShbJBWOfUuXKYQ/JD5stk5qu1hBquKi7r6z+WfzpXudUXxl3duHhk1wc+6Qx0lzIKzoCq6VxBmYQoR94xbbNTgHU0MQ2RgOwwfiQ+339cxNn6C4yjzlDvaliS0Y2xt9EuQ900mXqmi9aHFXNp9orZpyxJQjD1aKDh8X/bW1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268149; c=relaxed/simple;
	bh=H81prq1QS9ngg/A1qE6OG7MnMnv7zcnpHYeSRdGdZx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmnZjzKB0I23fV3BZt96Gfxoq0Qw8o2OMJ5/Qq+T/xOola8VpZKY0ZPkPrCxRrySmKPwhIdQxCqhfHuVxdM0Bs3f/kWpOMgNMCgi5ilrFQ/5O/NOL7SgUelqK1xVfDuV9ZPQB/CV0mZp4/W7hoGc414K2xjUh+GKFuNSpFCw44I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s69DztBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF939C4CEEB;
	Fri, 15 Aug 2025 14:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755268148;
	bh=H81prq1QS9ngg/A1qE6OG7MnMnv7zcnpHYeSRdGdZx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s69DztBfXres7T+IGhWSm85kpDCZD1LuzBjTqvlPeazZ2xDoT7onrcIjC0CaPq8bs
	 iD6N/+Zk/GT+qO4Ph8IN5wbiy8vunaKBWLp5btluDma1LO0TQFm/UeTe7cUSECYDhd
	 DzGkZQIC1cHW6+P9IxTaGO+r8/nCY+AvJObL29xsrIxfGfEOyqHTP+DnWzN90UVIUd
	 0ARf0GxAJW30/LZPs4pIVYqqTtSAX2Mh5ft7njos/J8iAMdMypui9QR0elLt3ThP5j
	 AZ66f2EC/SlK7IDOn1Q1JLgG6Iare8/Wc96BkubrlFWA+SyzHZClNs1G44Ht9zQ41y
	 +aC7ReJZAkj3A==
Date: Fri, 15 Aug 2025 07:29:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, hch@lst.de, tytso@mit.edu,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH util-linux v2] fallocate: add FALLOC_FL_WRITE_ZEROES
 support
Message-ID: <20250815142908.GG7981@frogsfrogsfrogs>
References: <20250813024015.2502234-1-yi.zhang@huaweicloud.com>
 <20250814165218.GQ7942@frogsfrogsfrogs>
 <a0eda581-ae6c-4b49-8b4f-7bb039b17487@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0eda581-ae6c-4b49-8b4f-7bb039b17487@huaweicloud.com>

On Fri, Aug 15, 2025 at 05:29:19PM +0800, Zhang Yi wrote:
> Thank you for your review comments!
> 
> On 2025/8/15 0:52, Darrick J. Wong wrote:
> > On Wed, Aug 13, 2025 at 10:40:15AM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> The Linux kernel (since version 6.17) supports FALLOC_FL_WRITE_ZEROES in
> >> fallocate(2). Add support for FALLOC_FL_WRITE_ZEROES to the fallocate
> >> utility by introducing a new option -w|--write-zeroes.
> >>
> >> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=278c7d9b5e0c
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >> v1->v2:
> >>  - Minor description modification to align with the kernel.
> >>
> >>  sys-utils/fallocate.1.adoc | 11 +++++++++--
> >>  sys-utils/fallocate.c      | 20 ++++++++++++++++----
> >>  2 files changed, 25 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/sys-utils/fallocate.1.adoc b/sys-utils/fallocate.1.adoc
> >> index 44ee0ef4c..0ec9ff9a9 100644
> >> --- a/sys-utils/fallocate.1.adoc
> >> +++ b/sys-utils/fallocate.1.adoc
> >> @@ -12,7 +12,7 @@ fallocate - preallocate or deallocate space to a file
> > 
> > <snip all the long lines>
> > 
> >> +*-w*, *--write-zeroes*::
> >> +Zeroes space in the byte range starting at _offset_ and continuing
> >> for _length_ bytes. Within the specified range, blocks are
> >> preallocated for the regions that span the holes in the file. After a
> >> successful call, subsequent reads from this range will return zeroes,
> >> subsequent writes to that range do not require further changes to the
> >> file mapping metadata.
> > 
> > "...will return zeroes and subsequent writes to that range..." ?
> > 
> 
> Yeah.
> 
> >> ++
> >> +Zeroing is done within the filesystem by preferably submitting write
> > 
> > I think we should say less about what the filesystem actually does to
> > preserve some flexibility:
> > 
> > "Zeroing is done within the filesystem. The filesystem may use a
> > hardware accelerated zeroing command, or it may submit regular writes.
> > The behavior depends on the filesystem design and available hardware."
> > 
> 
> Sure.
> 
> >> zeores commands, the alternative way is submitting actual zeroed data,
> >> the specified range will be converted into written extents. The write
> >> zeroes command is typically faster than write actual data if the
> >> device supports unmap write zeroes, the specified range will not be
> >> physically zeroed out on the device.
> >> ++
> >> +Options *--keep-size* can not be specified for the write-zeroes
> >> operation.
> >> +
> >>  include::man-common/help-version.adoc[]
> >>  
> >>  == AUTHORS
> [..]
> >> @@ -429,6 +438,9 @@ int main(int argc, char **argv)
> >>  			else if (mode & FALLOC_FL_ZERO_RANGE)
> >>  				fprintf(stdout, _("%s: %s (%ju bytes) zeroed.\n"),
> >>  								filename, str, length);
> >> +			else if (mode & FALLOC_FL_WRITE_ZEROES)
> >> +				fprintf(stdout, _("%s: %s (%ju bytes) write zeroed.\n"),
> > 
> > "write zeroed" is a little strange, but I don't have a better
> > suggestion. :)
> > 
> 
> Hmm... What about simply using "zeroed", the same to FALLOC_FL_ZERO_RANGE?
> Users should be aware of the parameters they have passed to fallocate(),
> so they should not use this print for further differentiation.

No thanks, different inputs should produce different outputs. :)

--D

> Thanks,
> Yi.
> 

