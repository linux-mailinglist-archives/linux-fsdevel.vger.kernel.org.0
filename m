Return-Path: <linux-fsdevel+bounces-54918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53F6B05172
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 08:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77814A7608
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 06:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A15A2D375A;
	Tue, 15 Jul 2025 06:03:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E2E4431;
	Tue, 15 Jul 2025 06:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559379; cv=none; b=YP1cr6T/Eb22HKMR65/bEQWiIiz+I7bapN5rSV6W1D7pRiYa1zZGF1kyNCt7O5ac8d1m4uLmvKc2uMRHYxEgGug1KHRlzsYB6mpq0x6Trn8VfGfUBL8U0h1NlLT0LPM1wS8NpwxgpQg/a6mQFqXcB1oztQY66srhs0RvaNNTnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559379; c=relaxed/simple;
	bh=9ycfj4anq4K0MuKtw2awoiLCEwkGQM4mqjQd9S6Lpz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoorFLM3xfAdzXMNNpOefNahEx69t8oo1lDy3blRkCO8fZ3YpADot4hD43WBQof80UkE65Vf37HxWYJYoSIVH/7RWNVBP73pn40Xx+c5tskUq/g8sOFuNsMZfOJZ/pNckgXyBIrYG20Rj8ZVwAgWzqSnLXDegJBs9i1XYtDaUCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 371C4227AB1; Tue, 15 Jul 2025 08:02:49 +0200 (CEST)
Date: Tue, 15 Jul 2025 08:02:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715060247.GC18349@lst.de>
References: <20250714131713.GA8742@lst.de> <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com> <aHULEGt3d0niAz2e@infradead.org> <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 14, 2025 at 04:53:49PM +0100, John Garry wrote:
> I see. I figure that something like a FS_XFLAG could be used for that. But 
> we should still protect bdev fops users as well.

I'm not sure a XFLAG is all that useful.  It's not really a per-file
persistent thing.  It's more of a mount option, or better persistent
mount-option attr like we did for autofsck.

>
> JFYI, I have done a good bit of HW and SW-based atomic powerfail testing 
> with fio on a Linux dev board, so there is a decent method available for 
> users to verify their HW atomics. But then testing power failures is not 
> always practical. Crashing the kernel only tests AWUN, and AWUPF (for 
> NVMe).

Yes.  There's some ways to emulate power fail for file system level
power fail testing using dm-log-writes and similar, but that doesn't
help at all with testing the power fail behavior of the device which
we rely on here.

