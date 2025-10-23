Return-Path: <linux-fsdevel+bounces-65330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCABC01A60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 16:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D12E25676A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3121322C9D;
	Thu, 23 Oct 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BVGYmQFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D863161A2;
	Thu, 23 Oct 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227768; cv=none; b=dXOwhI9z+NksTtu+6kogcsaJO5tlW9PCF9srnyqLBqjqfMEuy6G6W3HgwH/VT16Ecj1UA4Q+9fO20qLFD3nUpN7azAxWBPcHSyiU0EekHAK+nPr6BgEIOkqqcRjq9+kPZY8HaiJkyK0zDDZIjMXlrMIeUz7L7YTjwS6cNn9Al4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227768; c=relaxed/simple;
	bh=PJDIiAlHp9gdAENOfxIW6rdW+LJVVlmqWpn11KF6YJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGKCvaBOaRU9V1kxmeD1XZmC5pxm1b0XF09XvvYLD4PTg/UZVDJY9yfCuXCDG6lOoDnk7Vlapxorou2GO1Gdjp2HVe4T7T4Pg16uAHj3w5p69bO1tTU1NcINK0YY96jcepWu+5UQ/M2q7lNM7qte2lDss48EtJEt8ZQM/OeTI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BVGYmQFz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=n21YejjYScrCuGuHSLmpo+qaOUQes8bZo1gKYkZeJJI=; b=BVGYmQFzdqNcrMRV4TK62iebmK
	lIwbtqnZm4Qvp7fTu/874T87REVFGG/43BgJl01KdxBxGGOklr4NeJr0OgG3ZSesTeT5+kDdjsAG4
	pczDxbt5WDjhCJvUsgHyRVckgzYRZjzj0GicRbjIhzXdBdsTmppMaW8ciAGoISzbW3Kp1D+POXkU9
	7G5QFcgiMUKvcJmaXFAcXu6Dm4a2AsXAISvTtaBVDCFiH0HiG6rQIt78jAGasaD4Qb7HHQhfsXEYn
	JTUlvaA0/H1lB/rx5Cyl1NnLsXLrlQyWsfIuXu1A7dvwGUWPc+CS9Y9xW8qF8QK7WgkWcQdRYl0a+
	JmqHanzw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBvnQ-00000006UcH-0dnI;
	Thu, 23 Oct 2025 13:56:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: alloc misaligned vectors for zoned XFS
Date: Thu, 23 Oct 2025 15:55:41 +0200
Message-ID: <20251023135559.124072-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series enables the new block layer support for misaligned
individual vectors for zoned XFS.

The first patch is the from Qu and supposedly already applied to
the vfs iomap 6.19 branch, but I can't find it there.  The next
two are small fixups for it, and the last one makes use of this
new functionality in XFS.

Diffstat:
 fs/iomap/direct-io.c  |   17 +++++++++++++++--
 fs/xfs/xfs_file.c     |   21 +++++++++++----------
 include/linux/iomap.h |    8 ++++++++
 3 files changed, 34 insertions(+), 12 deletions(-)

