Return-Path: <linux-fsdevel+bounces-43476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB4A57060
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 19:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD163AD6B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 18:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763EB241C8B;
	Fri,  7 Mar 2025 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pg65gzzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC523BCFA
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371717; cv=none; b=cYdt/LzsWhJ4JL2wMg/qt3s+/0R3sQCTNjGSwRJMmUGFEh45aDliXGYkWID6gcD2KFhqOf0l9Hsl6hYxW5vncDFqnh8lIQy95J54sKLHZjLYL8oMYJQM09tMluSjtsygOriTuI5QUkCyCH2zXmLR94fRo6zYooNi1nm8pifqoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371717; c=relaxed/simple;
	bh=ycJfChFASTqRmeUqi89k8vuNIJS0HjZ5PZGH9Wz2/hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqKuHsdevVp5whyA3UXStaF3DK789RogC1bFAmXqo8H8OQz4QC/iUPuVL5k+8vyfnqIF3X2ExzkulfC42xFzhkf1ZHa0L3y7MXX3AeIlLCo7jcRD2eZaq4K36NwiFLPp/TpCDYL5WBEyjCVTa2+EoAiwYSB4hsyHNuRozdcntQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pg65gzzN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=5IGKT7Tj99B1l/SXMBRRKAeDecLd+n5G67AdXVwCQts=; b=Pg65gzzN9aBRmOwclW1AkAgnvU
	BGnIiDdL9KZvFfemV9EPXNq3r45UtEG8w06S+cyNNIjYphNcJYyrvLFdt0BNmxIDnmx27FMgPFVN/
	pJPEEZXdxjXlQvC6mT/EC5NSO69oRGxcpljS5T8p03uhKsHzaqEItvs48Us8l7ucnXUNGcYPLclBD
	jQH9K6x9l/4Ay0xk0zvgPqQS1yip3Z+WICEXHGIdHcCoa7XaBMSKrYRbKAOknaE8IknXR5UKDBkey
	FGjrcgCCd4lJ19X8Ch9igo5xjKnbqaicF9wY3opr+209kgQUcyYNmMx9JuaaMhiX1NQmVVAN2irz0
	8h19xXBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqcKX-0000000EFie-03og;
	Fri, 07 Mar 2025 18:21:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] f2fs: Remove uses of writepage
Date: Fri,  7 Mar 2025 18:21:46 +0000
Message-ID: <20250307182151.3397003-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was planning on sending this next cycle, but maybe there's time to
squeeze these patches into the upcoming merge window?

f2fs already implements writepages and migrate_folio for all three
address_space_operations, so either ->writepage will never be called (by
migration) or it will only be harmful (if called from pageout()).

The only remaining filesystem with ->writepage defined in next-20250307
is vboxsf, so the concept of removing ->writepage is well proven.  I
have some follow-up patches which simplify f2fs writeback afterwards,
but I think we can postpone them to next cycle.

See
https://lore.kernel.org/linux-fsdevel/20250307135414.2987755-1-willy@infradead.org/
for where we're going; the first four patches in that series are the
same as the four patches in this series, and I've split them out here
for your convenience.

Matthew Wilcox (Oracle) (4):
  f2fs: Remove check for ->writepage
  f2fs: Remove f2fs_write_data_page()
  f2fs: Remove f2fs_write_meta_page()
  f2fs: Remove f2fs_write_node_page()

 fs/f2fs/checkpoint.c |  7 -------
 fs/f2fs/data.c       | 28 ----------------------------
 fs/f2fs/node.c       |  8 --------
 3 files changed, 43 deletions(-)

-- 
2.47.2


