Return-Path: <linux-fsdevel+bounces-17960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796258B4422
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 06:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B101F226D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 04:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B373F8DE;
	Sat, 27 Apr 2024 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OBY8m/D7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880973D0C2;
	Sat, 27 Apr 2024 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714193226; cv=none; b=MJyEf6RehSeQ6o6eOm5xqn6kUpdtcrAVNS7h6pxZDz6xZfd6ROqzXLnhCLOlm2H3dexZT9mygXx9tR7SLc/l38n5K2zUrN1SSVL6A0SCI5mSjJgitO692sr++jWGq4w7s27WcxPPQOt47hZnuY0CUlT8gEt16l85SZc6fgBnTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714193226; c=relaxed/simple;
	bh=LRCIkuejIh2ioIHP5AzHL7iNdWGaOmpp8+XXWy0KtuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oInT/+/IL6sqA+bJT7Fcq173XDT302+FVMobaDp75vdLv1J8zZiPcLa1EjOb/ubUaed7Z2GEUhSXNNgzhjOfyQfxNR6O2euwh19kExUZJLNIQJkFzW/dheCFPdfMlFK3vxqXF0FZkOWZyWa3ZccuTzeBcRm/xATWXJ5GV6bXZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OBY8m/D7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6xpU9VR8a6K2/jLYXQfcQD1fDuHqlmP2r7odFKj3g8U=; b=OBY8m/D7mwHz4ZirDPL3GuMhrA
	1nIRnLfqU1zETqu5iRU3Xu42z5jxSSK1IGacS68+brIzlm3Q4G/lkhEyqC4y6zcOXJoKUDLf+CwWe
	LWZV/4oJydHICNuF4Lggf02Wy+tRXvF8/lwYWM44ZCNSpI3XkhJQ4WD/cinz4zdBGqGNR+9JxVwvG
	81RoL+92Bvo4nmcNzMOlQeKnCDjAaeESx6cBSekseILTgr9zON0w1d6Hjcf8WK2kCihgtHLOLvWac
	RvfODVaiBpLNzqjK29Y061Mabsq4tVTI1QN4IdSJuUW62Ct3bhpgH4U60zksZext7EUEI5Sghc0lR
	mhlZBx3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Zxn-0000000EonU-2S8c;
	Sat, 27 Apr 2024 04:47:03 +0000
Date: Fri, 26 Apr 2024 21:47:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 7/7] iomap: Optimize data access patterns for filesystems
 with indirect mappings
Message-ID: <ZiyDRw5zuF-jcBhZ@infradead.org>
References: <cover.1714046808.git.ritesh.list@gmail.com>
 <4e2752e99f55469c4eb5f2fe83e816d529110192.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2752e99f55469c4eb5f2fe83e816d529110192.1714046808.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 25, 2024 at 06:58:51PM +0530, Ritesh Harjani (IBM) wrote:
> Currently the bios for reads within iomap are only submitted at
> 2 places -
> 1. If we cannot merge the new req. with previous bio, only then we
>    submit the previous bio.
> 2. Submit the bio at the end of the entire read processing.
> 
> This means for filesystems with indirect block mapping, we call into
> ->iomap_begin() again w/o submitting the previous bios. That causes
> unoptimized data access patterns for blocks which are of BH_Boundary type.

The same is true for extent mappings.  And it's not ideal there either,
although it only inreases the bio submission latency.


