Return-Path: <linux-fsdevel+bounces-66588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42FC25339
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 14:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C23A3B4A6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 13:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EA334A789;
	Fri, 31 Oct 2025 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qd3JmRsd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B353D33FE0B;
	Fri, 31 Oct 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916252; cv=none; b=caZsDe+a2eYrQK6rUN3pVy7DnZesH8Gth15JIP5zEUcgTsn/8WMCo10KSTuproyQg3Za0xh8nE0FNMvwAW/UY+KHoTUKnNfSzXIsZW/KKDmuI+5ewU41b6JIcma4sP+/V3ZxDjrBWdGM4ka0OT9QmGv+/TXC9NMI7wLXaysTerE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916252; c=relaxed/simple;
	bh=d8DIrFuPSaOjc4gU5jpd3qXM5vfAeTqyV+X1w+DNHmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qn+VQjpFkWyuv3NRaAmaXhDqJ/NponQ08HUxrU0/FfPhH+fIFdm/5FTQNDQeMN9XgJ5hwqEEek56eZCxhFP0jumwDxaxA0tTy8i4x81wjHALH+fgJVBjUsxawUOBVkwY9Ol7OfyUzbqHJP92XMP5bnY98fZZHup1Knnf5Uo9hxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qd3JmRsd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9Q02G2J1neC1yB0Vmu0Ckbnf3KxxBChg1op+imde7V4=; b=Qd3JmRsdGk7S4Xtmb4UPQA1Gze
	++Nu4w2TSGu2GkCreSjxMgIENbKVVkWqi/cJWUx8nfulZJyiIrVrymTIHMPdq584z+YtSJkbBJsQl
	1RT9e1Ai9a60Hl8b/gSi8KerpFW98gmVx7uDfvsNiGHMsp4SCzL0j+7x6lzgZvRxjZ/o5BrFnkHsP
	WUvHhpoq0+PZtv4djEJf5XEGTft3LruRkjdI93E/vtBJwCi+Y0OJBd1CdEq27WZNIt8DV46MlasS6
	bsXM1A8RGSvvxvKElxSU/vssykjayyLiErDLrD4g3GxS5zDSZ8fxz7NcQAW+6YmGkzVFvF/8lSWIl
	6pLYoAIw==;
Received: from [2001:4bb8:2dc:10e5:1f29:7b81:1da3:7ada] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEou0-0000000699K-3267;
	Fri, 31 Oct 2025 13:10:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: alloc misaligned vectors for zoned XFS v2
Date: Fri, 31 Oct 2025 14:10:25 +0100
Message-ID: <20251031131045.1613229-1-hch@lst.de>
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

Note: the first patch replaces the patch of the same name in the
vfs iomap-6.19 branch.

Changes since v1:
 - squash the first patches
 - trace the new flag (based on a patch from Darrick)

Diffstat:
 fs/iomap/direct-io.c  |   17 +++++++++++++++--
 fs/iomap/trace.h      |    7 ++++---
 fs/xfs/xfs_file.c     |   21 +++++++++++----------
 include/linux/iomap.h |    8 ++++++++
 4 files changed, 38 insertions(+), 15 deletions(-)

