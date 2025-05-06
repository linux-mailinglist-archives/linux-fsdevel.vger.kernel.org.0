Return-Path: <linux-fsdevel+bounces-48174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD17AABC41
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D086A3BF978
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FF129824F;
	Tue,  6 May 2025 05:47:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14121882F;
	Tue,  6 May 2025 05:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746510456; cv=none; b=Z1zDHjii0JmnBznguzHo2Smmn9eXloAH09o8p4qPZPg1S8rTK1Ro98aMw1+1st2s+6K94UxtE+SdAk/hzaFxDigrJ0ku2UoaZ9BgrWDYrKubXUb+DmGQ0GdV8C+i8s4OxuW3ajMyZStNhhRwiCHgAobLfnoyNhb/eJGDn9upUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746510456; c=relaxed/simple;
	bh=Kja15JnQcWh9hBhq9PpQeyg/ixVWzLRhidOCQ9f/PCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKsLX+kWHgvD0+wQtzuxEAj3OGhrYyZHOKZj3S5HBVxjHjDUyHu9D/eMX6yQ81hUbpfB93EdrlwQctHKHvVUgltAwratS6Rq1eH6NdAnBnc5nm3IkIvCs1n9QUG1LYr/O4gCe2kkszqrJOFteoC7dTEtkAJ8ZrgW2VXBpRXzgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 16BA567373; Tue,  6 May 2025 07:47:23 +0200 (CEST)
Date: Tue, 6 May 2025 07:47:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@huaweicloud.com>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, john.g.garry@oracle.com, bmarzins@redhat.com,
	chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
	brauner@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Message-ID: <20250506054722.GA28781@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-8-yi.zhang@huaweicloud.com> <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs> <20250506050239.GA27687@lst.de> <20250506053654.GA25700@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506053654.GA25700@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 05, 2025 at 10:36:54PM -0700, Darrick J. Wong wrote:
> I think STATX_* (i.e. not STATX_ATTR_*) flags have two purposes: 1) to
> declare that specific fields in struct statx actually have meaning, most
> notably in scenarios where zeroes are valid field contents; and 2) if
> filling out the field is expensive, userspace can elect not to have it
> filled by leaving the bit unset.  I don't know how userspace is supposed
> to figure out which fields are expensive.

Yes.

> (I'm confused about the whole premise of /this/ patch -- it's a "fast
> zeroing" fallocate flag that causes the *device* to unmap, so that the
> filesystem can preallocate and avoid unwritten extent conversions?

Yes.

> What happens if the block device is thinp and it runs out of space?
> That seems antithetical to fallocate...)

While the origin posix_fallocate was about space preallocatіon, these
days fallocate seems to be more about extent layout and/or fast
zeroing.

I'm not a huge fan of either this or the hardware atomics as they
force a FTL layer world view which is quite ingrained but also
rather stupid, but some folks really want to go down there full
throttle, so..

