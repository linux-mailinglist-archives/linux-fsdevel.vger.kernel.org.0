Return-Path: <linux-fsdevel+bounces-50411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8B3ACBF40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 06:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1199C189079F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 04:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120B919DF48;
	Tue,  3 Jun 2025 04:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rLU41kh/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310078C91;
	Tue,  3 Jun 2025 04:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748925610; cv=none; b=DnDZIIY1ManwRtVetahD8hwNE1+Qm9uHdXxEvI1yEcifweJHGMyncjvCaTxJanrNXRj6Or79KccLZ0OMqiAqv0k9S9Y1n12L3IQlD1dM3yN+86TkThciRnP/6yzU8pQwt1EOQUp9dSYWeS+Ry+WIed+AU8+YSjJJtdyRySYtnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748925610; c=relaxed/simple;
	bh=pbaOO1xn3rMhafxSpXXlIbZ+eyqIW0522MBHWQRPMfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugbmLaenVFBOmiwtaoLFUvBkzBEtgYpk+zGBgREUG/g1eW8xPMiJb49NKRTtNRlSSV3zKKs5QXEH3ro4ub1QkMTMPVScbupV59r6yEUDlE8p5HH6e6Q/oluinhSZLRUCBUvsVkVH4mdoivBlWTTMBSbxmcgxQwEAC+KNW1/ExuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rLU41kh/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vkzRSZtw0QcwThVB/7CHRXwSFQ5wJlxTshTI9JHtxzg=; b=rLU41kh/xH8Vfh77Q8SIb6fbnP
	qwRiMxqA3J1L0Ga90L1CQpxg5jpW6zEpSzucoYv9PzbalGswuXvI4aTxp99pmp2Mj7HGUw2YCwUQU
	XVvVXYzczp1IM9mqb05xf6vH++G03VKLOpeQ34u6Uik51cll/9C60j/aTsv+4CySkbS+AoSCMwqps
	8sUAt9ILfOBh39TU3yAuJzyS/hOvYRZFZ79iDOLuQXi/O6sfYT2wvFSzVpG0DW9hk5p/zt4JngGL7
	0TuLsmE1J4pZOCEG3XsSFpIv7Mke1xbPUf+46/oqDE3t5wsFAS+AWmLpS+lgMviFce7NUvS8XiVIW
	kfgU6YBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMJRX-00000009h79-2235;
	Tue, 03 Jun 2025 04:40:07 +0000
Date: Mon, 2 Jun 2025 21:40:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
Message-ID: <aD58p4OpY0QhKl3i@infradead.org>
References: <CALOAHbDm7-byF8DCg1JH5rb4Yi8FBtrsicojrPvYq8AND=e6hQ@mail.gmail.com>
 <aD03HeZWLJihqikU@infradead.org>
 <CALOAHbDxgvY7Aozf8H9H2OBedcU1efYBQiEvxMg6pj1+arPETQ@mail.gmail.com>
 <aD5obj2G58bRMFlB@casper.infradead.org>
 <CALOAHbCWra+DskmcWUWJOenTg9EJQfS23Hi-rB1GLYmcRUKf4A@mail.gmail.com>
 <aD5ratf3NF_DUnL-@casper.infradead.org>
 <CALOAHbB_p=rxT2-7bWudKLUgbD7AvNoBsge90VDgQFpakfTbCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbB_p=rxT2-7bWudKLUgbD7AvNoBsge90VDgQFpakfTbCQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 03, 2025 at 11:50:58AM +0800, Yafang Shao wrote:
> 
> The drive in question is a Western Digital HGST Ultrastar
> HUH721212ALE600 12TB HDD.
> The price information is unavailable to me;-)

Unless you are doing something funky like setting a crazy CDL policy
it should not randomly fail writes.  Can you post the dmesg including
the sense data that the SCSI code should print in this case?


