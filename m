Return-Path: <linux-fsdevel+bounces-70754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A4CCA61D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 05:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21C4430E3C74
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 04:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657C81C8611;
	Fri,  5 Dec 2025 04:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YhV6zJf9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADD02DAFBA;
	Fri,  5 Dec 2025 04:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764909320; cv=none; b=Toab2NPGIqLY5ItYe69P7Sxqv/tCrv/bmcyYTtmXTxS7mrSl9s587Ha9JfAB4jx8Jxbjj+hsiy1/MVTMu7T/08bQu5KESSxINxMIRSXEMuQosBz6FfvrEAa0LIMZc6rQr8oWY1Ca51/CdGmLGbW0hr6uGI6w9eEOcBlDsJxJDFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764909320; c=relaxed/simple;
	bh=EKmzBoXlXjGXl/1sn3Wo1rYKKCXn3nwrJANQAVzMaqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QuAzvfObyi0zIw5VD3yZWz2/nSXKC7IAjnUK3bWwwMQiMd094f5DQurJfNGilbqA+94pRAAJKq0qcq6XkBweHxs9YTw0V8Ry5sOoORkxRY+ypkEbSE8bEKMwvRgfCzdsF4nAQ8SFigW3TfhFAt2kQXTBHnqDG4vM/cyJ/bky8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YhV6zJf9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=gK01jioExk9QgqqKJWuj0nW12vKsCLoPguQ+woKkLDE=; b=YhV6zJf9UwxxQfXPraH5u8Zr0A
	EUtovP42SQHEcoP4rCDrTQezaxtICdjr5GB67zDW09lfUnzCwlSHonY82uU8gauwMyL9rgEYR2nPI
	PuFgp3jL5EsEms8rDPNmLrHAvUaPlu5zMLtf/HtlkvQBF8CMNEJ65isd5j39Tu7y2NRRRdpk8wgcN
	iQfMl4TDDdzzQlz9lnYQTWDPUPiHh0YzCecUv6jMrf6KxAww71ec6+NyO5RRZBrnBNjZsp3qIi93l
	N/pB2x+KGPO2uY3YAZhUWDGiV79M2qPCHgfzKXsuFNMsQE9JcC27gOIJFRTjElLgkRzcHqGboYHGr
	rc6p0MQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRNX5-00000005A2T-0Xng;
	Fri, 05 Dec 2025 04:35:03 +0000
Date: Fri, 5 Dec 2025 04:35:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	Song Liu <songliubraving@fb.com>
Subject: Removal of CONFIG_READ_ONLY_THP_FOR_FS
Message-ID: <aTJg9vOijOGVTnVt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is a heads-up that CONFIG_READ_ONLY_THP_FOR_FS is going to be removed
during the next merge window.  When it was merged in 2019, it was always
intended as a temporary step towards the more general solution which ended
up being merged as large folios.  It has been a good feature which helped
a lot, both as a way to develop other code which was eeded for large
folios and it provided an immediate solution for improved performance.

Now the majority of filesystems where performance is relevant have been
converted to support large folios (afs, btrfs, erofs, ext4, nfs, smb,
tmpfs, xfs, zonefs) with f2fs in progress.  It's time to get rid of
CONFIG_READ_ONLY_THP_FOR_FS.  It unnecessarily bloats struct inode and
it's now getting in the way of removing the old uniform split behaviour
of split_huge_page_to_list_to_order().

If more work needs to be done to your filesystem to support PMD-sized
folios, this would be a great time to do it ;-)  There's lots of examples
to learn from now; the infrastructure should all be in place, and I'll
be available to help after Plumbers (December 15th).

[note: all relevant filesystem mailing lists are on the bcc so as not to
alarm mailing list managers]

