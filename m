Return-Path: <linux-fsdevel+bounces-73473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA4D1A583
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 045BC307303F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6314D30F921;
	Tue, 13 Jan 2026 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q3jmgY0T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263329D27D;
	Tue, 13 Jan 2026 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322209; cv=none; b=J4zKVxogWJrVbaaop+gXZM+G5Q4YPRhEDAKfXVO3gkMfVIsdSz9twoYZndbW6TR4viwau77ODDLNfdDkDuINuQk8QA7Z+krn+ixP0LHfbQcniqoecBJsqa1J2USTIobNnYpdx/B0mDMbzSgY8cOx4AFzttzs+mEfnxAHXSStt2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322209; c=relaxed/simple;
	bh=IMkOO6Zc4yhuZg1yzQK+w2Bp/BdGAWInBxXY74VNhMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9oZ0/U5suU8VpGjW3DZimT6QjLzUW1ThEGV1NbF+cXLgwoRI+SG2JXDx31r+NNlE+6u/HH9teA+tXbUKSqmfj52G88Gn6tO2ENSWu1rdWjk/1IxrEDhSBkdmleNsgtx1Yi5uflTgchf/n1gISbTC3wza4U/x9ksajFZtUABlog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q3jmgY0T; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bUxWTnK1QbCgjrUYIs0Qsd9Vhlvn6TGbfq2LUKED7So=; b=q3jmgY0TlCA0o7WFV5Z39f2vBH
	tp2ge+v5hF1mwyBqCHQmMEyauJ/QfDxHLhpTWnirEq6aIGShClfknmGziM70L8dVCySvqcY+0AdQo
	SPMbTRFYVpA906vH8DYHVudTdmJN3gerGQAFqyCmEZLQqEXn3kZHw5gLAMM2aDbtOcndfDrN1zR+6
	C4VXGvpan09WJMqIielGkLpdh0TNNX8HTg62JGCqxuS8EzDOHLxlSUP4X9R4hh2Zf2EhhKlFHwvGT
	OGqNcW3dSNXKO/gyap5ZgALhQU2ArysHYCcsE3HuJisdiHIxaVKYBaVqCSOvfsnhDnNtSy7i5ec02
	aNxdsbgQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfhNs-00000004y8Y-2UsQ;
	Tue, 13 Jan 2026 16:36:44 +0000
Date: Tue, 13 Jan 2026 16:36:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, djwong@kernel.org, david@fromorbit.com,
	hch@lst.de
Subject: Re: [PATCH v2 0/23] fs-verity support for XFS with post EOF merkle
 tree
Message-ID: <aWZ0nJNVTnyuFTmM@casper.infradead.org>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

On Mon, Jan 12, 2026 at 03:49:44PM +0100, Andrey Albershteyn wrote:
> The tree is read by iomap into page cache at offset 1 << 53. This is far
> enough to handle any supported file size.

What happens on 32-bit systems?  (I presume you mean "offset" as
"index", so this is 1 << 65 bytes on machines with a 4KiB page size)

