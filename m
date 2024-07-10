Return-Path: <linux-fsdevel+bounces-23461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F0F92C7E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 03:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4C91F24105
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 01:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE16679C0;
	Wed, 10 Jul 2024 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eKqreQzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508BB647
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jul 2024 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574615; cv=none; b=Clzk38XpdUYWrv1Yov85h/05o+q0zREckDs54Rpz53qEGgcn41Ayuqja0B2tuDvDjzEjsatN0HoirwyNf2CgEJhfRcaW9aJes6Bqzd/k7R9tMt1ZvUfrznMQC2smBJcDm4MFxJjLtRsByNI0jXF07FOXivSXGAkPQoUe0VSx+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574615; c=relaxed/simple;
	bh=i6RI6MwLIKGxQQj8Q56jssDlFxQuhcctgTg8VuG/7kE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2yHnUcuR6wxn7G5HL2FctTl0PQkJtbx+4yLXrgIsh/QEsgOoJvjKuPgpcyDJPzN0FYce1UzE7dPCw0KuzeNrd0hLFAbD80C29Qqf8IEgkgFX7jROoVzQ13J4cCrgl3GWrLerBdSqOVbcNBrVj2aW5yge/zKN+IL0kQTb1h9UFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eKqreQzX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=3twUuQzy/bEe/rXcNPuU08yk0iVYE1NMtTn1S/kaGJA=; b=eKqreQzX1Gjc5IMpzW1FWBumhc
	N0v8PmdY2KJzMf6VsoYKk51u7gjSuL+b0rN+JO5e3xx7ckE5VFTW3297p9XgFG1pxbXoboRoT+50r
	r6Q++ejTqNPsvUumMer4HrTHBMjNlLH/n/qaD25PElameIMB+lI/QOqthatt55/K3a2XaqZwchsRy
	cVjnySgyVQSvU3Nb0vf2N2VOAv2VD525J6QEgup7tHJM/bnyfCCuzAaz46hDrHMxOiDNxESdSCUnh
	z58ydfqCORiEKPlfizflhpCa8oBPs7woQDPcJvdhr/MKNggzx0EbsdDvNCUL6w76MLQFlECuXTKno
	dvx9LFtA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRM3J-00000008YZw-1EpV;
	Wed, 10 Jul 2024 01:23:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/7] Convert minixfs directory handling to folios
Date: Wed, 10 Jul 2024 02:23:14 +0100
Message-ID: <20240710012323.2039519-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series mirrors the changes to ext2 directory handling.
It's a bit simpler than the UFS one from yesterday as minixfs was already
converted to kmap_local.  Again, compile tested only.  This is against
current linux-next and will need to be tweaked to apply on top of the
hotfix I sent earlier today.

And I'll need to fix up the typo of "minifs" that I just noticed.
So there will be a v2.

Matthew Wilcox (Oracle) (7):
  minixfs: Convert dir_get_page() to dir_get_folio()
  minixfs: Convert minix_find_entry() to take a folio
  minifs: Convert minix_set_link() and minix_dotdot() to take a folio
  minixfs: Convert minix_delete_entry() to work on a folio
  minixfs: Convert minix_make_empty() to use a folio
  minixfs: Convert minix_prepare_chunk() to take a folio
  minixfs: Convert dir_commit_chunk() to take a folio

 fs/minix/dir.c   | 134 +++++++++++++++++++++++------------------------
 fs/minix/inode.c |   4 +-
 fs/minix/minix.h |  40 +++++++-------
 fs/minix/namei.c |  33 ++++++------
 4 files changed, 104 insertions(+), 107 deletions(-)

-- 
2.43.0


