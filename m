Return-Path: <linux-fsdevel+bounces-51504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5382AD753E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 17:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E463B7B75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3897927C162;
	Thu, 12 Jun 2025 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m74s/H9b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F0279795;
	Thu, 12 Jun 2025 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740628; cv=none; b=WzfBwLkBLUuOb5Vzqax3mCt1WPq+AHFtgQ5jAPtGv+/DbBveZXLvoarIOr5IghKmsUU4VxEtzdD8/kUeVokcX6IDnaqnQaG3mH39Jk81WmiLc3cI4F97Goe1QshcNJRKg6Ku1ghl185An1MbBBEta9/kSbM6F2hsRLZ3rD92NIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740628; c=relaxed/simple;
	bh=ONyFbl7eR0QXU3CRaThaUkea18g1Bd2HJqzSu8H2F5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVwdg6vIKF1xXsMiRSIRaSzB79GN8FbI2279dR5cLXr4bZVv0UIU/i789xnTwkcMjU6ud8IPiiocrIjnabH8BvyyuiQf5hjjvmx+ygS6MpJYiWjKjyvJ5fBBg7+m5lQglVPKeM+ZPG43Lsnk4v8F6rpnFGFU46wxjIHEWRM3IUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m74s/H9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65BDC4CEEB;
	Thu, 12 Jun 2025 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749740627;
	bh=ONyFbl7eR0QXU3CRaThaUkea18g1Bd2HJqzSu8H2F5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m74s/H9bViol79YmIelbep7cXyzEw47hdktzg1MN6vCsg0S24VQ/KqSDwpigubKeE
	 i41PpwJYbao8dKkGyE2Qqe80rDBt1KLstr08lFXyM7NrBpY5+1GLMitIsyHPH9pCI1
	 RYqA94+q4srgJ820hmzPT2j5D4utw51hYyphDzfmQ9/qugstzZiKxhOn3D8GrAvQ8j
	 X4Jo/C2BGR8LyZw47KY7cK2I3lFCTccQP4dr8up2k8RWnzpbNifNYM9Yn3+F7UHZR0
	 qapgcqmD42kiSJv9F9eFn76HvvhT8koJ4G37SFjrSwz0usnG0i9ighP1aKYvjTYnul
	 8U9pYzGL/Kbhg==
Date: Thu, 12 Jun 2025 08:03:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	martin.petersen@oracle.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 01/10] block: introduce BLK_FEAT_WRITE_ZEROES_UNMAP to
 queue limits features
Message-ID: <20250612150347.GK6138@frogsfrogsfrogs>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
 <20250611060900.GA4613@lst.de>
 <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com>
 <20250612044744.GA12828@lst.de>
 <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com>

On Thu, Jun 12, 2025 at 07:20:45PM +0800, Zhang Yi wrote:
> On 2025/6/12 12:47, Christoph Hellwig wrote:
> > On Wed, Jun 11, 2025 at 03:31:21PM +0800, Zhang Yi wrote:
> >>>> +/* supports unmap write zeroes command */
> >>>> +#define BLK_FEAT_WRITE_ZEROES_UNMAP	((__force blk_features_t)(1u << 17))
> >>>
> >>>
> >>> Should this be exposed through sysfs as a read-only value?
> >>
> >> Uh, are you suggesting adding another sysfs interface to expose
> >> this feature?
> > 
> > That was the idea.  Or do we have another way to report this capability?
> > 
> 
> Exposing this feature looks useful, but I think adding a new interface
> might be somewhat redundant, and it's also difficult to name the new
> interface. What about extend this interface to include 3 types? When
> read, it exposes the following:
> 
>  - none     : the device doesn't support BLK_FEAT_WRITE_ZEROES_UNMAP.
>  - enabled  : the device supports BLK_FEAT_WRITE_ZEROES_UNMAP, but the
>               BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED is not set.
>  - disabled : the device supports BLK_FEAT_WRITE_ZEROES_UNMAP, and the
>               BLK_FLAG_WRITE_ZEROES_UNMAP_DISABLED is set.
> 
> Users can write '0' and '1' to disable and enable this operation if it
> is not 'none', thoughts?

Perhaps it should reuse the enumeration pattern elsewhere in sysfs?
For example,

# cat /sys/block/sda/queue/scheduler
none [mq-deadline]
# echo none > /sys/block/sda/queue/scheduler
# cat /sys/block/sda/queue/scheduler
[none] mq-deadline

(Annoying that this seems to be opencoded wherever it appears...)

--D

> Best regards,
> Yi.
> 
> 

