Return-Path: <linux-fsdevel+bounces-46063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E2CA8224D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 12:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360EF460E5B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 10:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3763525DAE2;
	Wed,  9 Apr 2025 10:35:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6825A33C;
	Wed,  9 Apr 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194953; cv=none; b=h5w+UPL4RBpZkfodYepPDIuIrIXWHg4iPYDpL4NDlGBpaqV1ixWhhPdZZ5MB1VEUEx0CRt2rY/wbYlalXZVwEvQbUdbQp0djuuEKedZqF2uPeiqXLg9aB7E983saWjbRL73bvIqdGQNEC/Eo4/hqCXDOrC+ab0s5xV8KZiOYktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194953; c=relaxed/simple;
	bh=IHiHhIuYP9SAzOslZwOE2KYY14rqvkvRl05SFm5a9uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXv7rpgpzGFKBa/a2GSyn4zx+490DQgWo7G5d5lWn83b4qlMhVF5lZyM74HzeVja8jXBAMpMoYVoiyUkO/vUGEuE7Qio41siKjExJXqZjimhRi18Ou4dd1bf/rC6tvGbdPl/IayFPznKNgvbdf3sB9hZSZNp+NFnftDcj3VU/gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D9EE68AA6; Wed,  9 Apr 2025 12:35:48 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:35:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH -next v3 07/10] fs: introduce
 FALLOC_FL_WRITE_ZEROES to fallocate
Message-ID: <20250409103548.GC4950@lst.de>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com> <20250318073545.3518707-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318073545.3518707-8-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 03:35:42PM +0800, Zhang Yi wrote:
> Users can check the disk support of unmap write zeroes command by
> querying:
> 
>     /sys/block/<disk>/queue/write_zeroes_unmap

No, that is not in any way a good user interface.  Users need to be
able to query this on a per-file basis.

> Finally, this flag should not be specified in conjunction with the
> FALLOC_FL_KEEP_SIZE since allocating written extents beyond file EOF is
> not permitted, and filesystems that always require out-of-place writes
> should not support this flag since they still need to allocated new
> blocks during subsequent overwrites.

Should not or can't?  You're returning an error if this happens, so it
doesn't look like should is the right word here.


