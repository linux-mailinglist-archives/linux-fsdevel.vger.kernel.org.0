Return-Path: <linux-fsdevel+bounces-44619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2500A6AB35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFA518928CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A694421D001;
	Thu, 20 Mar 2025 16:38:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E181E9B09;
	Thu, 20 Mar 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488693; cv=none; b=iIQIEIhU8GGGr1UEft2ueAphEuXG1bJ7uWjlbtAgd6lrL9Z8JYDUkF4xtdUyPBPF+8BI9dp8mooUsBdfT0g21ZvBJ876nnMp1svt/J3NFRVfmsPyd53s7zoVZqXlwysMBwVYITPERUDVp7tjR5MxwYe6pOS4u2xwmKtQL99aiG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488693; c=relaxed/simple;
	bh=mDCrbJnamOC18bRvR4z1gGCqfQ1to/utJ7eWaIJSBrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuweCxCiAy5Gy08giRs8z9MamfvCWvxrQsmo+vkoxJ2BAUNswPiUk2incQOxWLPNAgvVgp84euXTlD72s0aGSf4ckfXxZUUBQ6xnkk/1VH/+liLA+ziTwgUUS4R8D4a7lYmoiXT2BrLfStSxyiAOdqkUe5+2zbDQRNaovVg0eyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E0EA68AA6; Thu, 20 Mar 2025 17:38:05 +0100 (CET)
Date: Thu, 20 Mar 2025 17:38:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org, david@fromorbit.com,
	leon@kernel.org, sagi@grimberg.me, axboe@kernel.dk, joro@8bytes.org,
	brauner@kernel.org, hare@suse.de, willy@infradead.org,
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	p.raghav@samsung.com, gost.dev@samsung.com, da.gomez@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
Message-ID: <20250320163804.GA21242@lst.de>
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org> <20250320141846.GA11512@lst.de> <a40a704f-22c8-4ae9-9800-301c9865cee4@acm.org> <Z9w7Nz-CxWSqj__H@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9w7Nz-CxWSqj__H@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 20, 2025 at 09:58:47AM -0600, Keith Busch wrote:
> I allocate out of hugetlbfs to reliably send direct IO at this size
> because the nvme driver's segment count is limited to 128.

It also works pretty well for buffered I/O for file systems supporting
larger folios.  I can trivially create 1MB folios in the page cache
on XFS and then do I/O on them.


