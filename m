Return-Path: <linux-fsdevel+bounces-55471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877B9B0AACD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B41A464F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 19:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07520209F45;
	Fri, 18 Jul 2025 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fWvbX5LP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCB5D517;
	Fri, 18 Jul 2025 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752868445; cv=none; b=paH5nVZ9MUfwU7jmxS7FR1gbvImZo9MyOabUmUn4TnePFTQucGMbPHYdUkF26mspJMlq2Yrq6ZuEY4ANTFuYMvUErjEx3NcJdnRov/lRYdYWyVLDpEcFIIKFd9MvUjEbBkl28gkczq33IfvaHrpciab8bZY9NmRbVr6i12rGlaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752868445; c=relaxed/simple;
	bh=NBVvxfQU2UF5Ri4RW1U5k96OfhJ9HCekTHFhmOI0pqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcdcoacFRAA3FUCX6R62Ckiew4B4kktrOFl+wp6J/jWo73UutEwSRWyk0DF4iDKwGyINjQM65ljJ8yR3SDhV1zGRrUdMuZkX+ABh39C65Ya6qjDnhvqgiLzPCtMO4WI8UGSwBH9Z5nnH40AhEnGWac2cbdpkewwz6+WxHWqWNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fWvbX5LP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=DmhGbX3NcSp6znFOezRVw58iMq/M4scFjSJ0/rPL7xw=; b=fWvbX5LPjgmVsph3ARZGVZmBFR
	hT0bfKBkJD5+gnWruWXfXUT7EG1fjHYzmuMBbaOQ54BQps2NYzU9SHnDvpTkXKuL7ItRnRQ+5Chhb
	sutyn2WuvQ77/hOEn1dICmzDy/KUgfjlMfPNHDGJkLctgOldwyPJOO4RMJAbiF4VLk6PrhqA5CT1K
	I3Ji//jKcPFjPrFgljmfKzBlC9BrFlz/4KedEsLzT/xxKWdk4AFAwYlEZeR/7GZucgbtV7yvh6GPf
	cLF7ZmUuHywCt6EfchzTMmjSa28eg+IeOTqMCEDPyexv0OTlKr8diD7eYoWXjWZz6ePQfaNpTYstt
	EfLcroLg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucr9d-00000008FTN-49RW;
	Fri, 18 Jul 2025 19:54:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] Compression fixes for ntfs3
Date: Fri, 18 Jul 2025 20:53:55 +0100
Message-ID: <20250718195400.1966070-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Konstantin,

I found three problems with the NTFS (de)compression code.  The
first two are simple inefficiencies; there's no need to kmap these
pages.  The third looks like a potential data corruption (description
in the patch).  I've marked the third one for backport.

I haven't tested any of this; it could be that my analysis is wrong.

Matthew Wilcox (Oracle) (3):
  ntfs: Do not kmap pages used for reading from disk
  ntfs: Do not kmap page cache pages for compression
  ntfs: Do not overwrite uptodate pages

 fs/ntfs3/frecord.c | 50 +++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

-- 
2.47.2


