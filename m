Return-Path: <linux-fsdevel+bounces-44589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E5BA6A83F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E98C188374D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ED8222591;
	Thu, 20 Mar 2025 14:12:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA923A6;
	Thu, 20 Mar 2025 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479929; cv=none; b=fnJoAkOpyCChlX7wUjumTx5dJPvWmfA5uUv+ZD5a7IdISsjFdm44WzadN6+kDCS0tk7EiyFqhY/MQTJbMrzCZ2yWpwQAkm1R0LNvJFbS4VfsZhPtFPrpU3us+iyeBfcDukSCOjdF+MaQUpeHWC89qbOQRgnKtI5YV1zXmojS9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479929; c=relaxed/simple;
	bh=46cyrVALgIwl5K4rEkc+kbFDQZxmipOxlZOKz2dY5HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snHy4u00/xLj3lBm5GP+PW+FyDwSIW1P7I5SZCqK+79OH0IQwrb+t1Qk/vUVEPuufKiSTpRka8pyAOLhXkynRunM7+WbyFTnx0sfZWsszGkZkwJ6LoeGe1fK2WHyuvrvgBZ5JPaODoOD1ywa6fmq9REhx1vO8YoGMv+4nGcKKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A83568BFE; Thu, 20 Mar 2025 15:12:01 +0100 (CET)
Date: Thu, 20 Mar 2025 15:12:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, alx@kernel.org, brauner@kernel.org,
	djwong@kernel.org, dchinner@redhat.com, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC] statx.2: Add stx_atomic_write_unit_max_opt
Message-ID: <20250320141200.GC10939@lst.de>
References: <20250319114402.3757248-1-john.g.garry@oracle.com> <20250320070048.GA14099@lst.de> <c656fa4d-eb76-4caa-8a71-a8d8a2ba6206@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c656fa4d-eb76-4caa-8a71-a8d8a2ba6206@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 20, 2025 at 09:19:40AM +0000, John Garry wrote:
> But is there value in reporting this limit? I am not sure. I am not sure 
> what the user would do with this info.

Align their data structures to it, e.g. size the log buffers to it.

> Maybe, for example, they want to write 1K consecutive 16K pages, each 
> atomically, and decide to do a big 16M atomic write but find that it is 
> slow as bdev atomic limit is < 16M.
>
> Maybe I should just update the documentation to mention that for XFS they 
> should check the mounted bdev atomic limits.

For something working on files having to figure out the underlying
block device (which is non-trivial given the various methods of
multi-device support) and then looking into block sysfs is a no-go.

So if we have any sort of use case for it we should expose the limit.


