Return-Path: <linux-fsdevel+bounces-30718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D31898DE33
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394211F265F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66D61D0DC8;
	Wed,  2 Oct 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z4gqCLJJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6531D094A;
	Wed,  2 Oct 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881249; cv=none; b=c6cGT6FYfcnp/BONUUcxj8xjuvKQirHOoLuQArAbvW2ERNwCgolkROtbqtN/WEdrJvbw2rHSa3KkUix+tD65WN48S2Syg0U61unQ9E0Q5IbPN5I+SFik4xpOejDUJTLljJyORL6XXKZqTqDBdC1Y31BgcJKtrbNr2Sd7I1R9Euk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881249; c=relaxed/simple;
	bh=LDV3VigSHBynG7uEy+OvZeIXQycKe5KCHz07IuxWk84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3EFoQgzP80yLqzqlXogr4UEb56icOKzfocT4mKvGdwUPGgB7e+OCoya2mv1GM9WoJCDIfKVSm7fs6xQJ1mZWO9CEz/HgX+Rl9lOOQTvNiJTt7p3SdMeoZVTRcPgeRycs/Xx+5BwzLbAUgGID8Zi9dL8mHNSWxBekeJInJnVafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z4gqCLJJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=v+nJkZDnQI6D6sTJVUS6Ztu5YqdY9/Cc8KfKcpniAQY=; b=Z4gqCLJJAIvk6M+O/OT5kwhphH
	/8hyhQxR7XO09f2G2pM1X+2f2ftIG+izWgO3OKWP8xDKUKsK+vwSs0TayLfYRTz75FCAGBys5yarY
	9EQ22LccCXjro0ZmJUnQG3wqyMMloBDegMumMjqsdJoMD6t3zLwhM/OKl38V58x9SJhQdxuU9pnz6
	oxSZyPMEdxrvRZjVrKklxjle+sfsVHmiwe+nS7wpN/f+fMc42+0MxoBnGjigFMv5xTB+r6pnlTTM5
	A3CPVWSPMWTU4iLXTgDTjVxXn4eYjrov3jE6uhm2gqoDpBi3+Y5C0CtwT/7WSHO/E6oCsug/sRPXU
	w2bLV0Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sw0qD-00000005cSd-1OUA;
	Wed, 02 Oct 2024 15:00:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nilfs@vger.kernel.org
Subject: [PATCH 0/4] nilfs2: Finish folio conversion
Date: Wed,  2 Oct 2024 16:00:30 +0100
Message-ID: <20241002150036.1339475-1-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After "nilfs2: Convert nilfs_copy_buffer() to use folios", there are
only a few remaining users of struct page in all of nilfs2, and they're
straightforward to remove.  Build tested only.

Matthew Wilcox (Oracle) (4):
  nilfs2: Remove nilfs_writepage
  nilfs2: Convert nilfs_page_count_clean_buffers() to take a folio
  nilfs2: Convert nilfs_recovery_copy_block() to take a folio
  nilfs2: Convert metadata aops from writepage to writepages

 fs/nilfs2/dir.c      |  2 +-
 fs/nilfs2/inode.c    | 35 ++---------------------------------
 fs/nilfs2/mdt.c      | 19 +++++++++++++++----
 fs/nilfs2/page.c     |  4 ++--
 fs/nilfs2/page.h     |  4 ++--
 fs/nilfs2/recovery.c | 11 ++++-------
 6 files changed, 26 insertions(+), 49 deletions(-)

-- 
2.43.0


