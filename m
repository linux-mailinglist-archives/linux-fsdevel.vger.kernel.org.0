Return-Path: <linux-fsdevel+bounces-39554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41762A158B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 21:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708E71685CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 20:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457F1AA786;
	Fri, 17 Jan 2025 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvC/ZXmQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5B1A8413;
	Fri, 17 Jan 2025 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737146229; cv=none; b=U8Iq+oX9A8GxqZ1htcq7TCQ+gYBwJgS6Tb0k7gSkXkIh9E1zLYLbkT7WFbv+9DeBkxlbSwgPVoFfPHvO/Z8P32R/n4LLh9FHheUQeHxtc0I591/Ym7RFifF2AcRhTq5MRSN2e8y8+RpkFdqzTjUEXFk9BNngJcTzTS/M/rBMb2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737146229; c=relaxed/simple;
	bh=rT1bqZdwVFd/2xyZ7/+BbcEOFeWh4PZPt3GS1lV3PbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijQsShYYhNuq4UbXDLGrEQ28w4vzSFTbZ/IuWiZAV5/5ovtXn4t5LfCKxJAueMtPLLOTWd8P/Jfw1hxccH2iZAesk3xG6Lkbn+rMKsF3c7NjLs9fv8uirJs+PGgeNc0fpVuUsiEwdwD5GqF9JZge0/mLOp1hXccDIrIc1Qiahe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvC/ZXmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC88FC4CEDD;
	Fri, 17 Jan 2025 20:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737146227;
	bh=rT1bqZdwVFd/2xyZ7/+BbcEOFeWh4PZPt3GS1lV3PbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvC/ZXmQy/UI/n7UEmqmFhKXCQqFLoft41IaIEt96y8IYO/kIq26qxnidq1YP6Ek7
	 fPPvEYvIZvip5712h5y5P9whbfeukKXnoHdQVbP8erZtDZzIHh4fZ0gjStkuswJ08y
	 dR18apYB5mqA2QKdTt43zg/7WHGAWIO4H1LLZ0mQZ+JnoYFrzFs1/dN5tCylPNWJ3s
	 NFKVrVz5SGhi3+tcN/5ozF46va10ge2x2+WKwdRxcsXuHN46LVe8sKENXmerYWWUql
	 3NqexdFJbzAGOHCxO+AdowcAHITO+j86ZKbHU5CmG9ebVAX/ra4hQ5F6G87r9bRQi1
	 NzpTUGQp2xNig==
Date: Fri, 17 Jan 2025 20:37:05 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2 v6] add ioctl/sysfs to donate file-backed pages
Message-ID: <Z4q_cd5qNRjqSG8i@google.com>
References: <20250117164350.2419840-1-jaegeuk@kernel.org>
 <Z4qb9Pv-mEQZrrXc@casper.infradead.org>
 <Z4qmF2n2pzuHqad_@google.com>
 <Z4qpurL9YeCHk5v2@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4qpurL9YeCHk5v2@casper.infradead.org>

On 01/17, Matthew Wilcox wrote:
> On Fri, Jan 17, 2025 at 06:48:55PM +0000, Jaegeuk Kim wrote:
> > > I don't understand how this is different from MADV_COLD.  Please
> > > explain.
> > 
> > MADV_COLD is a vma range, while this is a file range. So, it's more close to
> > fadvise(POSIX_FADV_DONTNEED) which tries to reclaim the file-backed pages
> > at the time when it's called. The idea is to keep the hints only, and try to
> > reclaim all later when admin expects system memory pressure soon.
> 
> So you're saying you want POSIX_FADV_COLD?

Yeah, the intention looks similar like marking it cold and paging out later.

