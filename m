Return-Path: <linux-fsdevel+bounces-37316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E29F0F5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DD81880979
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC821E1C26;
	Fri, 13 Dec 2024 14:38:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B461E1A3F;
	Fri, 13 Dec 2024 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100728; cv=none; b=l2kPGbRD/DxwcqXUhK8LdQhrvroZX4mklRe4AErVH2+DcInA4VkGLWvUiurWwlxE1LqvHb+dPXLpEwFOZsT29cyDmF/YaeR5ZCJptsRQfth9kxfnk7UE8WuNYb6L1GiS+tskbIE402/pvcGRhbQuE+pdMcd2plGCYtb421rIYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100728; c=relaxed/simple;
	bh=yC2qjJ0KFbww/rP0l1Por3/dUYaM2XpDttf+3ul07+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv7BabYcbXoaH9k4p8/MdTJcqxVvF3RInVZ/T39773f+UhOblB9oZfm6USS6rnxX+HUrPlWgElDf3iPaOD09lnLZj8sev59JxPUY1Z0BzbJZVjttLa0QyelXMUebS1RH0kz2JcZzN+HSwReKBGatclABO+WDl/RfnUV5ayzCKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C614B68AA6; Fri, 13 Dec 2024 15:38:41 +0100 (CET)
Date: Fri, 13 Dec 2024 15:38:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, ritesh.list@gmail.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH v2 0/7] large atomic writes for xfs
Message-ID: <20241213143841.GC16111@lst.de>
References: <20241210125737.786928-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210125737.786928-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 10, 2024 at 12:57:30PM +0000, John Garry wrote:
> Currently the atomic write unit min and max is fixed at the FS blocksize
> for xfs and ext4.
> 
> This series expands support to allow multiple FS blocks to be written
> atomically.

Can you explain the workload you're interested in a bit more? 

I'm still very scared of expanding use of the large allocation sizes.

IIRC you showed some numbers where increasing the FSB size to something
larger did not look good in your benchmarks, but I'd like to understand
why.  Do you have a link to these numbers just to refresh everyones minds
why that wasn't a good idea.  Did that also include supporting atomic
writes in the sector size <= write size <= FS block size range, which
aren't currently supported, but very useful?


