Return-Path: <linux-fsdevel+bounces-27290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16069600D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAFE283736
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4A7184E;
	Tue, 27 Aug 2024 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4aO5MkOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB09374CB;
	Tue, 27 Aug 2024 05:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735433; cv=none; b=sgqymlPlrlMXkpBqyrRHppWEUYarZ4g/R0D38l20Xaj4+ofVlx2C0oJ2c66iL9SbAvay17u2Izecmd2OWa6rRZq0dLUsXMeRMMxHohXlNZ2Ro22ARG/Ba/9XA3y3+JRIX+INppksOL8HNRA3td/oOGWd3HYLKfwhBR+OeNrqhGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735433; c=relaxed/simple;
	bh=D5kkM+PYE8cojvFa8sBFsGrPPZ39mq8PynmDqfjho4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YeAjbPijvTDdNaGisN88IK4vAJs52KztXjrz34aD55fp54Y4G70cRHlv0HZKa3KPntWw45oACFiKXPMsER9LYCx47Mktmc2G9jLyJNEZEuEDlDYe3Qv/ACyWCGgp/gbur43PV0NBA0OXoo7mzcs9cOuaGhKK2o1ncOejOatikcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4aO5MkOT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Bnka1d0Zod/mk1jB7dia7SIDil2SQDVaSK2H1g8Fz/U=; b=4aO5MkOTxvv8rJAQYakhtdWSat
	EnkMgjGRWJD4j4eZ2TtOeLskMwNhnhAfY+faqqO1Uu+jMExu3oa99NZAHc1QQOuGlTa0EZcf+I5B6
	YC+6zwa5tTHGEjGCzRhyQWyC6pqDz72+VYn+WqvbLaipY4ufdtiZbm7jaMlEEZYAL4M8ZeTuh4tsO
	6O/4smsDqnHCPZt+REKRNNY2LohgZykl7cXUJwFZ/sgQhc5LytWAUhPT7ymI/OX6erY5ZF8wYNNtT
	uyYVeIGjnJuILtkfw4oVGwJwNatBIIz8cnXEbiPrGfj5XuR2yb90vthZA2W+RypEw0XOIHn2f2jXo
	o+XFFkyw==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sioTO-00000009opZ-17uU;
	Tue, 27 Aug 2024 05:10:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: fix stale delalloc punching for COW I/O
Date: Tue, 27 Aug 2024 07:09:47 +0200
Message-ID: <20240827051028.1751933-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
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
fork, which means that it won't get punched out for short writes.

Diffstat:
 fs/iomap/buffered-io.c |  139 +++++++++++++++++++++++--------------------------
 fs/xfs/xfs_aops.c      |    4 -
 fs/xfs/xfs_bmap_util.c |   10 ++-
 fs/xfs/xfs_bmap_util.h |    2 
 fs/xfs/xfs_iomap.c     |   57 ++++++++------------
 include/linux/iomap.h  |   11 ++-
 6 files changed, 109 insertions(+), 114 deletions(-)

