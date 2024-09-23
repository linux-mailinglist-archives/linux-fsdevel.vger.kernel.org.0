Return-Path: <linux-fsdevel+bounces-29860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230AA97EE1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB746280EA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B7619D084;
	Mon, 23 Sep 2024 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MjpC7r1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3FD80BFF;
	Mon, 23 Sep 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105354; cv=none; b=Q0m+mnCVCJ7BvePyW+zffSz2C0ucLSBy5WMzHIdrsx3QOFOPRW/YHtLi6w8bXk8jQVkqNBNc6rrey0Mrq/qWciiL/cT/e1xIL69TjBXjGieULz4nmfaoDr9EKcUwYXTMmKOVys5sSRvsJRLeGIvfHqp31Jfv3CrAAGtg61dUHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105354; c=relaxed/simple;
	bh=z7dWkS46e9BOeEefP+//+UkgTqItXFoc9lK9SX57Zdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6KHN5cImGDZK9dCZRtZ+gwvmWsrkYybh+9pAP/GB+cEa9+2Yl1Y1F+ylzS5eLkDOZgwhfd/NwdiE6wIat1TXmsdTOpTp4IygEzQv0bRczRnnwLW4jUgVgtKt9wGDsdt5QLWl9sjF0ysTZP7M3R2hG5M38gFiktG3sK/5YUVN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MjpC7r1O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=S/ZcRNTk+0q22n8lQhzs0ugvrdlSj7r3TKVJ/efHrqo=; b=MjpC7r1ObaC+w+RcloP1ECmwxE
	mr/cMoCzXccYhbFt1WWHHvXRzTnz7rFmyE7bqE1h+huaHrbKINf9TLwUmwmXXd/IVoO77PY8BaNKu
	WD0veX8AEM0DSRAePzytUezbaU7lqak7oSM2XyitR3nCfVXnrztQWyYNeMnk/Upui3AQKY4RXpuV+
	gRaGouLVY9gB94q1A1PXP5HCqszCz+n0lDm9h9DdlfPppf6q3+Kqu/9tK44L2FGYE9+4yiYmZgbyI
	VlW5BO4lVPqpycZT+YzUUWVQT/x6TLcMBh1fY58qkdEFp3HV1wKtJNVg5+RkcXqmu3Qldzf4ZTGeg
	0yUNdvZQ==;
Received: from 2a02-8389-2341-5b80-4c13-f559-77bd-3c36.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c13:f559:77bd:3c36] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sskzs-0000000HV7J-0eis;
	Mon, 23 Sep 2024 15:29:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: fix stale delalloc punching for COW I/O v3
Date: Mon, 23 Sep 2024 17:28:14 +0200
Message-ID: <20240923152904.1747117-1-hch@lst.de>
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

