Return-Path: <linux-fsdevel+bounces-36117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6D9DBF3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 06:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA44B164E17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 05:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26CB1581EE;
	Fri, 29 Nov 2024 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YK0YbkG3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C878156C70;
	Fri, 29 Nov 2024 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732859467; cv=none; b=kH/c+FK8iSnTOUW4b/7H0JPl14P/cPKIXqxZ96DiigJvlKDWeW9kd2hobRKWdYBTlVFzKWfIHXXVcmIF6tsqRd4l5YB5NyUj72TDjZTVZY9XjQGadMi4wwz0+HNkVfIqRXimG1gvun+qgMdeqjgb/HA76e+fKkZbZri7OQx0uVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732859467; c=relaxed/simple;
	bh=klqu7Dw7BJeUOQJFRrsSl4cxebKvqKXtsYWE6Cr1hAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFpn5nRVv7ax+PMC5tiSZJhG6/2slv6s9yJYgBhaf+JFRwkdW6exfyw6y+70fRHGSwxOypIDjQmP08b4Ngn1HYDFu9tPANqHxUJsPJdlFzhgYlwkww8I6T/q41m/uTni9lKwA3wDdEdV/xBI1+AMJl2mQFzaYZezYo4BGz6RP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YK0YbkG3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=sC8uQpivIY6+LG64nGDIb2BW/qZcysAW7q2qQBZuVhM=; b=YK0YbkG3xJ5ab5yNbts/iX1wLA
	9VlQ5PIcKv/e418Rku7VyOiIzLeelIuo9zxUzEmiYNznp+KaEUds5UXuk/c5gCN48YEISFAv51WMu
	jIK5lfInMKmGL6zHE7OLL77PvBkLkMpbSGBJx2Ggpwg5ALKTHiiMw7pEjia1drtwqvMk4aNyutsGv
	bAaJszTkPKZtJEfVIuvr/fr2PfBNdlYl4IE9CF+CBwSac5Y2/FuMgK9CXIe1PLbVfF602LHYtyB34
	v6g7YxlOo9SHKDK2tvPip+FlEy57jyaDQvT1kZrM2Llq1FeyO7VGTYnjxXihSe1WAtT73s7sCYWeH
	pi2wPLQw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGtu9-00000003bS6-0Led;
	Fri, 29 Nov 2024 05:51:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 0/5] Remove accesses to page->index from ceph
Date: Fri, 29 Nov 2024 05:50:51 +0000
Message-ID: <20241129055058.858940-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I know Dave Howells is working on a more comprehensive cleanup of ceph,
but I need either his work or these patches in the next merge window,
and it's possible he won't be done in time.

The first patch is a bugfix.  I'm not quite clear on the consequences
of looking at the wrong index; possibly some pages get written back
that shouldn't be, or some pages don't get written back that should be.
Anyway, I think it deserves to go in and get backported.

The other four patches I would like to see merged for v6.14.  Unless
Dave finishes his rewrite first.  I have only compile tested this,
but it's _mostly_ a one-to-one transformation.

Matthew Wilcox (Oracle) (5):
  ceph: Do not look at the index of an encrypted page
  ceph: Use a folio in ceph_page_mkwrite()
  ceph: Convert ceph_readdir_cache_control to store a folio
  ceph: Use a folio throughout writepage_nounlock()
  ceph: Use a folio in ceph_writepages_start()

 fs/ceph/addr.c   | 136 ++++++++++++++++++++++++-----------------------
 fs/ceph/crypto.h |   7 +++
 fs/ceph/dir.c    |  12 ++---
 fs/ceph/inode.c  |  26 ++++-----
 fs/ceph/super.h  |   2 +-
 5 files changed, 97 insertions(+), 86 deletions(-)

-- 
2.45.2


