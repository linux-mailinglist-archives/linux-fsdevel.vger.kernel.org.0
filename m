Return-Path: <linux-fsdevel+bounces-54352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B0CAFE884
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 14:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A977A77FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303662D8DDD;
	Wed,  9 Jul 2025 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nZsaDZ+2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477872613;
	Wed,  9 Jul 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062489; cv=none; b=prEDwHMUUZ9/ZZ/+yb1rqtU2PzEqe4Vpk63pQA1s9CBQ9PCXx2YZjm1h4a5ayFwwOAZJJvXr7i0DRjMYh0x33mUjUuk7oqHVsvvMH6IjuwtAs+RzSzpUHw1T4WSClN6DdGeXLT3DSdfcHGcUUKmEaR6r03GCV6lL0JayMHsKxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062489; c=relaxed/simple;
	bh=RHCTs3+A/4OnLxn/NNUPFFn6hiAMaFzKBx7gnQ4ecZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhBMID2K5MzG84et29Xhnyt/xiI7uoWozoOYOu4ZjN8RG2Bh9QY2uAvUTPaXTiPGdAGqhzQst70KnLwDsgxIHx8Wtkbz+xjwfGTp0SUQwYyjbiM5Os2yzisl4xPGkT2m9GVy9X2Co0nA9El/MiZU7c7Vv1nJ56pG2G94gkmv4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nZsaDZ+2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aCD1Vk+598XmZoaVvVBGw0kyKKkEwsQ0LDbnHqtcCsQ=; b=nZsaDZ+2PpgYZ/tpSiBZv+4/Mr
	9yDJeXIJ0QbW4AtUEXDcll4jbT+/FY6wNULgtV7LtBiRr7P2HVFmwhcahbyIftC8ZeZF2PQLhkbtF
	3dLVGfIVvJYDH9lzFTYy2YsVHzIZhSBbc3F0i8ovLoUdN8vexzTvw2l4p6vrFRTqhw36xdVUL9mDu
	HB8GTT/stPayahZgIYdOHoGQKnqjyvyicFSWHun3DYwRgJOWn4mOYdHOfetJ0aSv5QcFOda6qgASH
	S4Q8qCmnsG8/Iafo6W/vOJm04OPZ3PD1SR6xZYdiFIpODCD4I0JX1hsUm+shNXSqk0fGmWw7p9Uee
	qcNQ7KZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZTUL-00000003pPa-1tGT;
	Wed, 09 Jul 2025 12:01:25 +0000
Date: Wed, 9 Jul 2025 13:01:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Why a lot of fses are using bdev's page cache to do super block
 read/write?
Message-ID: <aG5aFfflP_OPE_ND@casper.infradead.org>
References: <5459cd6d-3fdb-4a4e-b5c7-00ef74f17f7d@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5459cd6d-3fdb-4a4e-b5c7-00ef74f17f7d@gmx.com>

On Wed, Jul 09, 2025 at 06:35:00PM +0930, Qu Wenruo wrote:
> This leads more digging, and to my surprise using bdev's page cache to do
> superblock IOs is not an exception, in fact f2fs is doing exactly the same
> thing.

Almost all filesystems use the page cache (sometimes the buffer cache
which amounts to the exact same thing).  This is a good thing as many
filesystems put their superblock in the same place, so scanning block
devices to determine what filesystem they have results in less I/O.


