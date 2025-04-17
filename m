Return-Path: <linux-fsdevel+bounces-46607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68772A913FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 08:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7888A3BAB80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 06:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4641F91E3;
	Thu, 17 Apr 2025 06:25:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5F192D8E;
	Thu, 17 Apr 2025 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744871141; cv=none; b=iSrbIH4c1W6kmfzbdt0RG8242whKm/HfjtKfnT1Fmo+M5diNNHMzSSNihVO+dAKfLT9oxlwzzwtP9IHVl1Qtc57VADW61OlsRm192KDq1n8QU5gajhlcSGRjgQRTXDVS3woMSZjhRnnMeqPplTYdiVgPm8ZQGmTxSJb+ScKpKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744871141; c=relaxed/simple;
	bh=zDr5hWPrer64LbtkD7OLbXPk7E7SiI9kJJJM048iqIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvDbJ6dr/qAldtsD9RlD/0Cw3fWxi3oPqQUfXN/J7ttsYTs4p2XrhCLOOV95mZhLNlFPzn0T658qqvvGw7x+oOdnx8tLeElesDB5frkH73G3Yphi6NHFL7kiADQPU+bBZKedfS1LxYC2+C+bovClrFeUtuKogm3gt5mzMen0WjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D5F868AFE; Thu, 17 Apr 2025 08:25:27 +0200 (CEST)
Date: Thu, 17 Apr 2025 08:25:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, ming.lei@redhat.com,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] loop: fix min directio size detection for nested loop
 devices
Message-ID: <20250417062527.GA22173@lst.de>
References: <20250417034639.GG25659@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417034639.GG25659@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 16, 2025 at 08:46:39PM -0700, Darrick J. Wong wrote:
> If however SCRATCH_DEV is itself a loop device that we've used to
> simulate 4k LBA block devices, the minimum directio size discovery
> introduced in commit f4774e92aab85d is wrong -- we should query the
> logical block size of the underlying block device because file->f_path
> points whatever filesystem /dev is.

No, the problem is that special handling of block devices in stat
sits in vfs_statx_path and not the exported vfs_getattr helper,
and thus we don't call into bdev_statx which would return the right
value.  I'll send a separate VFS-level fix for this.


