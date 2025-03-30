Return-Path: <linux-fsdevel+bounces-45288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C7CA758CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 08:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCEA3ABB65
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 06:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D417A2FA;
	Sun, 30 Mar 2025 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dDhvo/HF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B45145B3F;
	Sun, 30 Mar 2025 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743317267; cv=none; b=R5oeojMN469vKOD3/oBHugs+eYLApOZkMl2chuGOHWXCD3Pr7e4GvNZR6kAfCVZ4ipxyZSuC0euVFIlhDVm1DQDZ6KwVk6JZDXU2bL6ekeci5K8oAOQw+Spn2b6fEKMP4wQ78t7cu+4/2hv1VojWzZ3P5dgVCT1JpavHct1wfcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743317267; c=relaxed/simple;
	bh=p3vFgBmW0ViEHivzpO5BZfXsshKTI20qpXw05c3sKE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrbZqXWoWMRn7YTJjn7cbL17dZJfw0pKnAdZMuFVzdIdZPF7WgqpS5fcYCjMLQVgLiW3n9Dw56cacmx4bUN4f0uzjG8kupTiXho8sP7b8dxCqWsIcVKTJohCRPoMpIG9UktmBRjYknXiDhhcotffWeQ7BB/XnjU4XtC227ia/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dDhvo/HF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RUUWKQeUwI7heeE55yHvLfByxYVbK6pQ52VmT/aJJR8=; b=dDhvo/HF/S2HHVyhDWQKPP60nE
	mWbUOhUGzO5ZItpyvnAvub9i2ByFYHzj/EjQvcldpK73T/UHAf7DlZI5ptDoyHUDofOO2Wxyaanas
	z4d8HgDYeEtrXDW58kA3kXIlbZUsmRIbaye8I3OPvYdUjHoNYSrKjuVrrHvDUvPvv2ZHKk0dnJY6n
	J5Z9L+Y70j79O0RtUuhUzfvkFLwVrGsMaKmHm9ZXn59kkXPAyKKyg/50f0/qu0ZCiRJhsUVnLWhg0
	Mfq1urymt5pjZC7jZoo044VwLHRlhreogQOq8VDqBXP+qkVIUCE5lmpfqXleZ5RxRBnyYOeMixIFb
	Qy2AkaCQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tymSJ-0000000FreA-26zy;
	Sun, 30 Mar 2025 06:47:39 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	riel@surriel.com
Cc: willy@infradead.org,
	hannes@cmpxchg.org,
	oliver.sang@intel.com,
	dave@stgolabs.net,
	david@redhat.com,
	axboe@kernel.dk,
	hare@suse.de,
	david@fromorbit.com,
	djwong@kernel.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH 1/3] mm/migrate: add might_sleep() on __migrate_folio()
Date: Sat, 29 Mar 2025 23:47:30 -0700
Message-ID: <20250330064732.3781046-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250330064732.3781046-1-mcgrof@kernel.org>
References: <20250330064732.3781046-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

When we do page migration of large folios folio_mc_copy() can
cond_resched() *iff* we are on a large folio. There's a hairy
bug reported by both 0-day [0] and  syzbot [1] where it has been
detected we can call folio_mc_copy() in atomic context. While,
technically speaking that should in theory be only possible today
from buffer-head filesystems using buffer_migrate_folio_norefs()
on page migration the only buffer-head large folio filesystem -- the
block device cache, and so with block devices with large block sizes.
However tracing shows that folio_mc_copy() *isn't* being called
as often as we'd expect from buffer_migrate_folio_norefs() path
as we're likely bailing early now thanks to the check added by commit
060913999d7a ("mm: migrate: support poisoned recover from migrate
folio").

*Most* folio_mc_copy() calls in turn end up *not* being in atomic
context, and so we won't hit a splat when using:

CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_ATOMIC_SLEEP=y

But we *want* to help proactively find callers of __migrate_folio() in
atomic context, so make might_sleep() explicit to help us root out
large folio atomic callers of migrate_folio().

Link: https://lkml.kernel.org/r/202503101536.27099c77-lkp@intel.com # [0]
Link: https://lkml.kernel.org/r/67e57c41.050a0220.2f068f.0033.GAE@google.com # [1]
Link: https://lkml.kernel.org/r/Z-c6BqCSmAnNxb57@bombadil.infradead.org # [2]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/migrate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index f3ee6d8d5e2e..712ddd11f3f0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -751,6 +751,8 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 {
 	int rc, expected_count = folio_expected_refs(mapping, src);
 
+	might_sleep();
+
 	/* Check whether src does not have extra refs before we do more work */
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
-- 
2.47.2


