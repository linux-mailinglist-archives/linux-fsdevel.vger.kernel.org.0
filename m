Return-Path: <linux-fsdevel+bounces-51592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A8DAD9042
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 16:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397677ACF58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 14:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66171E1E1F;
	Fri, 13 Jun 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0Pct+Gi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663715573F;
	Fri, 13 Jun 2025 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826475; cv=none; b=h05kQregjzWd5WbxzKA2uwySHhQgMDRwiHVuX7xf06/dcn+OWwQqqmdqjnF4d3qtQC5+Aev3QzG2gN8v0Ltiibm19dd7uWeUkXcpoiYpvXXlgqj7cdlXnGAGVkisJnBcatmS6eyBfF64kLWklGPtm94fCyTzLwmwm/JFsGnx4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826475; c=relaxed/simple;
	bh=+637aPsLSU1UEPvOQGQyJUY4IglUTgPupGHZwaGPQ9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCE9DC352qGtv/GEfl4Ll+Bkw+WHDem1kDw7IUqJ7JARZXwQX6y0oZqprlqh1K1pqItBHBC4UMpWjkGd2Ec4kywIJa1ZNFmRYk6ABYp3XMaAEVgcWpMZZQYTaZ8XUSRyFMICgDlxYVq1LJ29DhWEUT7NWDT6iMzGNbsQwcj5xs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0Pct+Gi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A72CC4CEE3;
	Fri, 13 Jun 2025 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749826474;
	bh=+637aPsLSU1UEPvOQGQyJUY4IglUTgPupGHZwaGPQ9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0Pct+Gi1hoDM0LZBCspzjOIqDTyyl/V2GwGBXdSGFwBLlkILUhpHpVlgfCrMUpLJ
	 ft/YOmBjSQkitEQeADRDy2IJMuk2s5qeBmYAfOLlPe0KfidAf0uWqoe3GG3Quh0jbo
	 vp59Zhbn5w3KL5AqV7PvQSSpyi9eG2fk5e6Zy6Qs1qFJrouqOACDQ4QVEPy68nKiWv
	 m3H7my7AX4igycSxvPU6isS/XSrmG3VhiMT6KxJXgvyR2tEjCKY7d1g5iorVm6fZVk
	 0LaMA8e65dqZijj1V1l+R6N9sVXHtRmMSZOPejxKl/4h0RJMRbDrFlJsHL7+g8myjt
	 N3zheeKbLKx8w==
Date: Fri, 13 Jun 2025 07:54:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
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
Message-ID: <20250613145433.GF6134@frogsfrogsfrogs>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
 <20250604020850.1304633-2-yi.zhang@huaweicloud.com>
 <20250611060900.GA4613@lst.de>
 <343f7f06-9bf6-442f-8e77-0a774203ec3f@huaweicloud.com>
 <20250612044744.GA12828@lst.de>
 <41c21e20-5439-4157-ad73-6f133df42d28@huaweicloud.com>
 <20250612150347.GK6138@frogsfrogsfrogs>
 <3569a77f-1f38-4764-b1e3-d0075775c7bb@huaweicloud.com>
 <20250613055630.GA9119@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613055630.GA9119@lst.de>

On Fri, Jun 13, 2025 at 07:56:30AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 13, 2025 at 11:15:41AM +0800, Zhang Yi wrote:
> > Yeah, this solution looks good to me. However, we currently have only
> > two selections (none and unmap). What if we keep it as is and simply
> > hide this interface if BLK_FEAT_WRITE_ZEROES_UNMAP is not set, making
> > it visible only when the device supports this feature? Something like
> > below:
> 
> I really hate having all kinds of different interfaces for configurations.

I really hate the open-coded string parsing nonsense that is sysfs. ;)

> Maybe we should redo this similar to the other hardware/software interfaces
> and have a hw_ limit that is exposed by the driver and re-only in
> sysfs, and then the user configurable one without _hw.  Setting it to
> zero disables the feature.

Yeah, that fits the /sys/block/foo/queue model better.

--D

