Return-Path: <linux-fsdevel+bounces-45286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA66A758C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 08:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F29188D223
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 06:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2E315820C;
	Sun, 30 Mar 2025 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VPgNJJiZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC320B22;
	Sun, 30 Mar 2025 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743317266; cv=none; b=PuOurxngB6QFEBsr03BYDjMCo/j4OaWachZQH2VG4mi0+QU/j9SWmYTbeKoYS+8BkiBD1Sh8JAABrKIjspKDQWAUjK+ZCjH0rcNYduWcvtYekdGhPbPK46Uw7v5XBeI9sQDpUlad8rry6M/6gV+NA2LDDo0cA9j8zDB0AY3mxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743317266; c=relaxed/simple;
	bh=kgB8OOaAyE/3r4VIOULxwjlKCP0HM/KVZ4YfAhG+pT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYCJ9g/IznBOLFEeRik+WWkdykiDR43oEe1BJcqgvyb7wtBY+b6DUqx5zHsFOkQkGC1WkAHl6hvVwmUk6r4wj3fkhgn6UYnPU8+fve6vSvuE/OmINnwJtm36ctXVik0PfVTPDgseBKfGBavlsvS7faIzw49k216ycJYJCF012L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VPgNJJiZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dsi6MQOqN7ghOTfrKnW38mWU0gU/PvadKLIXd+zTJ3U=; b=VPgNJJiZvXeAxUKUx/r9TdqDiX
	19jBaZ71+1CjptFA1uPOz7MTCa0Dtsu0KQDcIzZUn9Yi1YtO6j3j5PULNY2V6f/kNMVmC/4U/sNjK
	ugtHpJAPu+D/ECx8lTjKXbh0fgepBKkPRxSB8RySceHn+wbuC9K3XIza5cZvoQM/IJ4fbkFaQ5ALv
	Um0efa/I52oG3LJ+ea9SqLXbRwEGidQSjjTfZAfC1MuFqFI0+JafxaPi4N+6MRZX791VwYk7jtVdk
	jrT63PtUmoskyRNKQhE7QXj1MDsxFidXiGfbCST8XW+vWXZtagnsvPt3q3LLYOB6XmKtBB/x1dxGW
	89MIB91g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tymSJ-0000000FreE-2OYS;
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
	mcgrof@kernel.org,
	syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Subject: [PATCH 3/3] mm/migrate: avoid atomic context on buffer_migrate_folio_norefs() migration
Date: Sat, 29 Mar 2025 23:47:32 -0700
Message-ID: <20250330064732.3781046-4-mcgrof@kernel.org>
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

The buffer_migrate_folio_norefs() should avoid holding the spin lock
held in order to ensure we can support large folios. The prior commit
"fs/buffer: avoid races with folio migrations on __find_get_block_slow()"
ripped out the only rationale for having the atomic context,  so we can
remove the spin lock call now.

Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: syzbot+f3c6fda1297c748a7076@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/oe-lkp/202503101536.27099c77-lkp@intel.com
Fixes: 3c20917120ce ("block/bdev: enable large folio support for large logical block sizes")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/migrate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 712ddd11f3f0..f3047c685706 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -861,12 +861,12 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 			}
 			bh = bh->b_this_page;
 		} while (bh != head);
+		spin_unlock(&mapping->i_private_lock);
 		if (busy) {
 			if (invalidated) {
 				rc = -EAGAIN;
 				goto unlock_buffers;
 			}
-			spin_unlock(&mapping->i_private_lock);
 			invalidate_bh_lrus();
 			invalidated = true;
 			goto recheck_buffers;
@@ -884,8 +884,6 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 	} while (bh != head);
 
 unlock_buffers:
-	if (check_refs)
-		spin_unlock(&mapping->i_private_lock);
 	bh = head;
 	do {
 		unlock_buffer(bh);
-- 
2.47.2


