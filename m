Return-Path: <linux-fsdevel+bounces-45926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C93A7F526
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 08:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1587A4FF6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 06:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EECF25F98B;
	Tue,  8 Apr 2025 06:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ea/4QlTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E0C148;
	Tue,  8 Apr 2025 06:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744094677; cv=none; b=MS/qD37pxba1N3mN4gvVn+Ck4n8ptHfL8ZbuDpF21ED0c3UyaH/prEN3WGmGsMcb7n6f/gwHBY07W/ZAQEreC++h0nPW/Sy2tkKpUbaQBD1ntbX/Z98cDBH9VXA9GRayLwWZ+/Iia/cgEGMSxUbDp6D/KShe4dvdqheUQAf7sBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744094677; c=relaxed/simple;
	bh=VeXfcXgjhoh10nSVTefyJ2jyhYL4QrU3n3MlEAdqUa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVospzGwuwD4f9118Hs8HPGflcoxtzB1NK3XojxdUlVIXAORAjoMN810DKOGK/fXVoNyn1Kmh1R7RCBAelYYJmfh2nsDJCZyF//HrTkHmCjK+v3ca2MaktjbWcsUVGWJQVMRmEhfLAlR2UoFZ5THgseRB6yPPXtbyAJEQrCvz0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ea/4QlTx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1f2TCRKnCLX508cFHVCDLt0+6ZQAxKUvoIT7+Movbu8=; b=Ea/4QlTx+zYAa4LG/FUVpHHjuz
	UnQ0qjHeef/5JlQ022Kk03wLSivZAdUjl8cQpcMIVju7rXgYFoE3do/zMvcMpH/Ibz5pFka2CS1EI
	16f0JOzN+JTm3uOc09Ah567igcHrPDBQS0vBSSX58cPDfSUXzLSOVSg1i14aDDhoVyudglEsJstau
	mUS2G5UTCr6AHdhldjiBzeC4Z80VEbOTSxzrAeZuPfzV8wQ2LlWffc6iNdRoS4eFo45Kua5gMHqQs
	NBrM9KU0jByQsktZl1CiPjHQfjcHy2J+BXB1Kyy9VCu51HLklq07IZ1wFJjYiFmzkTSjdVe4wZIyN
	d3mpEiMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u22hG-00000002wTk-1gWG;
	Tue, 08 Apr 2025 06:44:34 +0000
Date: Mon, 7 Apr 2025 23:44:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	dlemoal@kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Weird loop device behavior in 6.15-rc1?
Message-ID: <Z_TF0vYWljwlWxoY@infradead.org>
References: <20250407233007.GG6266@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407233007.GG6266@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 07, 2025 at 04:30:07PM -0700, Darrick J. Wong wrote:
> Hey Christoph,
> 
> I have a ... weird test setup where loop devices have directio enabled
> unconditionally on a system with 4k-lba disks, and now that I pulled
> down 6.15-rc1, I see failures in xfs/259:

Hmm, this works just fine for with a 4k LBA size NVMe setup on -rc1
with latest xfsprogs and xfstests for-next.

> Then trying to format an XFS filesystem fails:

That on the other hand I can reproduce locally.

> I think there's a bug in the loop driver where changing
> LO_FLAGS_DIRECT_IO doesn't actually try to change the O_DIRECT state of
> the underlying lo->lo_backing_file->f_flags.  So I can try to set a 2k
> block size on the loop dev, which turns off LO_FLAGS_DIRECT_IO but the
> fd is still open O_DIRECT so the writes fail.  But this isn't a
> regression in -rc1, so maybe this is the expected behavior?

This does look old, but also I would not call it expected.

> On 6.15-rc1, you actually /can/ change the sector size:

> But the backing file still has O_DIRECT on, so formatting fails:

Looks like the fact that fixing the silent failure to change the sector
size exposed the not clear O_DIRECT bug..

I'll cook up a patch to clear O_DIRECT.

> Thoughts?
> 
> --D
> 
> (/me notes that xfs/801 is failing across the board, and I don't know
> what changed about THPs in tmpfs but clearly something's corrupting
> memory.)

That one always failed for me because it uses a sysfs-dump tool that
simply doesn't seem to exist.


