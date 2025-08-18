Return-Path: <linux-fsdevel+bounces-58119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299F3B2996B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 08:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2700916784C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 06:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736427281D;
	Mon, 18 Aug 2025 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f1PwvdQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916522727FE;
	Mon, 18 Aug 2025 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755497424; cv=none; b=c75JANW9ELkhdXf8gr/Rs/Z6+Gs+jarZourSWxo3KTs2S6HPjFIxQg/uawGEnjpwnZn2H2nNC9yZ54XgeGvZRHyl7gz162Z5r1mdifbmkx022ykOoEFw7t6pFylu4VJ6pAtcpLhckT8of12n+Cg8oufHr4T0bda08dZYzGr9zbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755497424; c=relaxed/simple;
	bh=OuLMnqS+F6mmf/cIbwQV7tautxbOAtyAVuXrrQuaskE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zx5Cecn46aKTLHuE2tFP+75ogyMA6Vqqv0Tz20g+/sWc7g+gNcVnNal9444DKPKT/Bf8oIAQyiMRDJX5vPzf/3/u0N+HuHiyZbjoPd2s9AlDdkgt4OlZCP6zFp2Vyn0zYmMvXiLOEck5l/tPIJw7clTNOO17s0CucncCs7ZeVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f1PwvdQp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dpnwm04mLZ9r5oigDr9e2a5pokpGR4TaQMRCA1h4VTE=; b=f1PwvdQpvwfaPRcIJ8U32YGvLI
	q1zub5osggMmsp25CcFpJEQhwSgClZedqucIcJ8rp4AxZvP06CG8407nP40F/1JqCfMnM+NtMdy6D
	xI1QpL5Mu8PiY8isRAhuUJP9C210ghHO19Zsoakt+cLVlWf2U6eU2iLsmkUzgnErgBBQKfLrpxXTz
	f5UfqRBwsniaK3xV9dxg/2FkMyQMOyeY5Fbo5IC2jrEAdLaOfCH+yZ5LX6f43pTL6BOS6/6yF9JmR
	nkSxCxsa8z82rogN0H4Lm8RdccWgIh9RZNpd0fD5mig7Z3dzbnXyT0ktXpGhpwVZ46D5FLh1Y27Y1
	b5hGUnkQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unt4W-00000006bmJ-2OXI;
	Mon, 18 Aug 2025 06:10:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	linux-bcachefs@vger.kernel.org,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: remove write_cache_pages()
Date: Mon, 18 Aug 2025 08:10:07 +0200
Message-ID: <20250818061017.1526853-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Kill of write_cache_pages after converting the last two users to the
iterator.

Diffstat:
 fs/bcachefs/fs-io-buffered.c |   13 ++++++++++++-
 fs/ntfs3/inode.c             |   15 ++++++++++-----
 include/linux/writeback.h    |    6 ------
 mm/page-writeback.c          |   30 ------------------------------
 4 files changed, 22 insertions(+), 42 deletions(-)

