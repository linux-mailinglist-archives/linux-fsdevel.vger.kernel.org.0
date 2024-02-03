Return-Path: <linux-fsdevel+bounces-10124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544E84842E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 08:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86351F25B10
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 07:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDAE4CDFD;
	Sat,  3 Feb 2024 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hfk1jOB6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE314B5C1;
	Sat,  3 Feb 2024 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706944326; cv=none; b=Ax1eX5hVGVoDieRjCIdbURkaKHWomPrOQTPsG4dIKHrfEnpy/q7+UK6PkihXxG4jJy56HBgJHebSYCyzfTcMrexJL8G811FVkZaYWDdVIA3J1tjnxK/51mra8+qH+7ZmqlrmV//XIiDo5LnEwjOWP7yooiRjhMTzcFe4svyeGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706944326; c=relaxed/simple;
	bh=h1vKh875I7DQ97UVGmnI+2v/whFN/tFVvlOTyPdDGwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zmtq6oVefYdBQQY1/qNt6qvlC6rJ2eUI2pTSiufmnU8/9vmiqxI8CDXDR2SLYyBRxASazyKyrtIZYb6YW4Oi2Yn/8voO9ZvCXByYUqTLOW8TUY/79VnNKkUsok9dKqkAYccPxTO9sakh1b4m23mq5aQHqRC8phfxb3SIeGnFn+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hfk1jOB6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=HMBNnp3fgBDK6ztw/NO3s+iVnQcpEAV34TJMhHGz7lI=; b=Hfk1jOB6JsmsKp3tLeYrYuZOXy
	AayejwfIhn+MYGLWoPY2CdSef9mFapvkWNacoc7Rc9QLlNPfjrpcB9HUMYMlRG5YgwX2Apt8dzL3i
	Xw72vGE+8770V5or/kmoGOWXqDf+DXrRg8z75QB4pTc2FpV6phLf0yYPHlLstv6fYZTjqtmyAIouD
	07FCNuwksuY9zDDjYG8iD2ldZJhr9POZKriEsRotD8evbA9ivqmxN8qt+tih1wb9gjQKExRb5oo7U
	RESHqP+TPhdaALhK5CV/Yflm88j+YnlinUZXseBUAEUOCMrd2B7EsVm8PqMa6yl8S4CgEqJFGJNd/
	cYpziPdA==;
Received: from [89.144.222.32] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWABz-0000000FjxC-1WUq;
	Sat, 03 Feb 2024 07:12:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: convert write_cache_pages() to an iterator v6
Date: Sat,  3 Feb 2024 08:11:34 +0100
Message-Id: <20240203071147.862076-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this is an evolution of the series Matthew Wilcox originally sent in June
2023, which has changed quite a bit since and now has a while based
iterator.

Note that in this version two patches are so different from the previous
version that I've not kept any Reviews or Acks for them, even if the
final result look almost the same as the previous patches with the
incremental patch on the list.

Changes since v5:
 - completely reshuffle the series to directly prepare for the
   writeback_iter() style.
 - don't require *error to be initialized on first call
 - improve various comments
 - fix a bisection hazard where write_cache_pages don't return delayed
   error for a few commits
 - fix a whitespace error
 - drop the iomap patch again for now as the iomap map multiple blocks
   series isn't in mainline yet

Changes since v4:
 - added back the (rebased) iomap conversion now that the conflict is in
   mainline
 - add a new patch to change the iterator

Changes since v3:
 - various commit log spelling fixes
 - remove a statement from a commit log that isn't true any more with the
   changes in v3
 - rename a function
 - merge two helpers

Diffstat:
 fs/iomap/buffered-io.c    |   10 -
 include/linux/pagevec.h   |   18 ++
 include/linux/writeback.h |   12 +
 mm/page-writeback.c       |  344 ++++++++++++++++++++++++++--------------------
 4 files changed, 231 insertions(+), 153 deletions(-)

