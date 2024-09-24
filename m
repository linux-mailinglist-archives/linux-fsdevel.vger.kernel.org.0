Return-Path: <linux-fsdevel+bounces-29935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C77983F6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C70B21DED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83081487FE;
	Tue, 24 Sep 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cGpJXv8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B4C148308;
	Tue, 24 Sep 2024 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163683; cv=none; b=eI50nohBknNlqQUT5Ql/9gYdEiSwRunuHHF4GGVTJQ4fvwreld4Ed0WVK+ykXcDEqU+f1EZg7M1NPcyBv2b0kJhRDN7JMExKxl7NbEuCIVtDTB36nhdbPqW4KV1e2fzEpaiiFKB4XN0I+ua6QOgay/vhd5FUhWzp5UtGJ78Svqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163683; c=relaxed/simple;
	bh=3y/KgGu+DFDq9jdV1IYbbcdKd3yJf7K1UjMdUwtM+a0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXYQmegCWJIai0z3VhlSpnMF0bNkoj4ETBfCtF6rHbe/zVW0bFc28/VP1w5ofwTGyEfvNRFRLpyu3+DkKXC4JpgDkHclZ+kD96QCLg3ORT0p8vzH4ONAP7occHNOTbLjvGrPKzzurQhLz7XB0zo0ryU61iNBGUbc7be1EhzQV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cGpJXv8W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Kgzuw5U5Gcr5LsvIf7qKXEELA+dEJrXd1rbQ3xSrbso=; b=cGpJXv8W/WS8IjQZXC45/DpS2e
	bPb9RtTkh0w5DZMq23nr4cUfaftM8Bu/m2pG23+EJkML1Q8mHmM8HvlfrPen57ObZsUCGaZ7dGDP0
	ayWmHsXKptakY7R4fp5rwPHasJKClRn/O2dS4Q4zdBCRZckz9rHV7sye5ZCetWLg8DjJ/g1OliNLi
	AyrrYpaXEpGWxhw32nyuSL35sEjyypaso/8+MT5TnpYDdjQg4liOMpCiYJs6piTGJyMTINQcanouQ
	WwzgLfECHr9H6vAxzlOszwfc+VsAPxpxeZEHF+BHiY5sC3VfQ+a8s0KdQAtWhePNv168+e57MQCBP
	OYO5G8Sw==;
Received: from 2a02-8389-2341-5b80-b62d-f525-8e84-d569.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b62d:f525:8e84:d569] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st0Ai-00000001SGh-1G0N;
	Tue, 24 Sep 2024 07:41:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: fix stale delalloc punching for COW I/O v4
Date: Tue, 24 Sep 2024 09:40:42 +0200
Message-ID: <20240924074115.1797231-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this is another fallout from the zoned XFS work, which stresses the XFS
COW I/O path very heavily.  It affects normal I/O to reflinked files as
well, but is very hard to hit there.

The main problem here is that we only punch out delalloc reservations
from the data fork, but COW I/O places delalloc extents into the COW
fork, which means that it won't get punched out forshort writes.

[Sorry for the rapid fire repost, but as we're down to comment changes
 and the series has been fully reviewed except for the trivial
 refactoring patch at the beginning I'd like to get it out before being
 semi-offline for a few days]

Changes since v3:
 - improve two comments

Changes since v2:
 - drop the patches already merged and rebased to latest Linus' tree
 - moved taking invalidate_lock from iomap to the caller to avoid a
   too complicated locking protocol
 - better document the xfs_file_write_zero_eof return value
 - fix a commit log typo

Changes since v1:
 - move the already reviewed iomap prep changes to the beginning in case
   Christian wants to take them ASAP
 - take the invalidate_lock for post-EOF zeroing so that we have a
   consistent locking pattern for zeroing.

Diffstat:
 Documentation/filesystems/iomap/operations.rst |    2 
 fs/iomap/buffered-io.c                         |  111 ++++++-------------
 fs/xfs/xfs_aops.c                              |    4 
 fs/xfs/xfs_bmap_util.c                         |   10 +
 fs/xfs/xfs_bmap_util.h                         |    2 
 fs/xfs/xfs_file.c                              |  146 +++++++++++++++----------
 fs/xfs/xfs_iomap.c                             |   65 +++++++----
 include/linux/iomap.h                          |   20 ++-
 8 files changed, 196 insertions(+), 164 deletions(-)

