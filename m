Return-Path: <linux-fsdevel+bounces-26440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D749594C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6424E283733
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F274016DEAB;
	Wed, 21 Aug 2024 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZTBmb1kn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3072779CD;
	Wed, 21 Aug 2024 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222346; cv=none; b=n/vGKq0ANOiuBPwZFj0U6DcjopMmiw6PClwKRlt8irMTTO3UEoGuzqQu+ZMrwYxRxDOQ3PE08Llf7dV3obDGk6yDMQP+Ve3IxCPeZTlH5wXimuOkzFPtn3Vshq+rlmVnIvHgIIcd5rgSV88xiB0tvvUN19Vq8aIvRzDvd2PDdss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222346; c=relaxed/simple;
	bh=RuCtbWBm+VYmuNu5P1sunXVHsjJNs2o7ku16XlEfiDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AhYBYgTBNmi+8THUTWb5djKmdeTL6K2uFw/FqHajB/fbIYp8niYiBbhR0b8U9diARONexZYDxad1zSXZB+31t/bDUK3PvwXR9pbwRLiA6l1OpQ64Br6zTc3v65M+t7vEghir9AD+4NXIQqBMH0ZmSosdvY62yPPNmItx22Q5YeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZTBmb1kn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=kcAW8zreTZYbZD+/Ew29xyE3gmHQ2C4YiRQZGCf3m+Q=; b=ZTBmb1knid9UukyDtfBoK6tLGI
	lhZOIsS0iSmve9+FB/aQ4Adv65Tc2qLtLmyyirSM7qSW/RySEcOvbirD1zfpFNB89vAFw8L7H+h0A
	G1uTb6+XLV2OxLL8KQvBc6fM05by70FbiD/AkzHvhASc8t5tBj04WyfcFqVXj9vVDHpIOGRljOwwU
	uP0XjGqoXOWiSG5P3vO4Nt6+i3PcfDNdo6O7naHyAgMgWy4XGigRp4j6Nsce5lLrzzAiJ9pW5BNRh
	ueStvndbqnNQn1fVrolEvP9rUSsgzWssYJwxJgGEpwGLYKAH7V60B/66gLgd3+C/tEDb1y400iqNt
	6UUYJKAQ==;
Received: from 2a02-8389-2341-5b80-94d5-b2c4-989b-ff6e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:94d5:b2c4:989b:ff6e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgezn-00000007kBd-2U14;
	Wed, 21 Aug 2024 06:39:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: convert XFS perag lookup to xarrays v2
Date: Wed, 21 Aug 2024 08:38:27 +0200
Message-ID: <20240821063901.650776-1-hch@lst.de>
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

for a project with the pending RT group code in XFS that reuses the basic
perag concepts I'd much prefer to use xarrays over the old radix tree for
nicer iteration semantics.

This series converts the perag code to xarrays to keep them in sync and
throws in the use of kfree_rcu_mightsleep in the same area.

Changes since v1:
 - use xa_insert instead of reinventing it
 - split API changes into separate patches
 - simplify tagged iteration
 - use the proper xa_mark_t type for marks to make sparse happy

Diffstat:
 libxfs/xfs_ag.c |   94 +++++---------------------------------------------------
 libxfs/xfs_ag.h |   14 --------
 xfs_icache.c    |   85 +++++++++++++++++++++++++++++++++++---------------
 xfs_mount.h     |    3 -
 xfs_super.c     |    3 -
 xfs_trace.h     |    4 +-
 6 files changed, 72 insertions(+), 131 deletions(-)

