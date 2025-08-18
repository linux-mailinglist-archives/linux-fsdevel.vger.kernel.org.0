Return-Path: <linux-fsdevel+bounces-58182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B02B2AB4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5D627BD85C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB90223337;
	Mon, 18 Aug 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfFH5ZYx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B41F4177;
	Mon, 18 Aug 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527993; cv=none; b=J2jDlcXPoesk3kn5eePnQvBZ9bFN+oZNcKw9nIaXWihCGSxYt1LypLGZq6S+O4u4KWbCdOAeVQAQ6cRkWMqLBjnBdO9lOgxtI5njSsyPulA1GTdcU2SnRexrXXVKGh1nCd+BkdsOjfzl7IB9+iCR3b5h/+OD1+lwaqCl+PUS4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527993; c=relaxed/simple;
	bh=QO1IbS4lq5QYUVdZC8ChSSth6wh6DFLdb/czjjq+vRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnvVzwjGddwFnIGYgWAup1X+8Mxma6Azd8bRyVEOGTJuXhy8J7Y+y7tluRqxwjaEEBx2XWBRhS0dz5Eqp2SWLJZpnJEiM96Is3V86TIaCppVsioNq3fXehsmQHPUKupJscPHzgTDvJDYKlnQBfKnP0DACTV5URj8n/GQ2FVAz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfFH5ZYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3421CC4CEF1;
	Mon, 18 Aug 2025 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755527992;
	bh=QO1IbS4lq5QYUVdZC8ChSSth6wh6DFLdb/czjjq+vRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfFH5ZYxeEW2TpHx+tfApYHOsbTiT2fXrAjDbrtXMFdnO/kr8K2PR32F9wTtJhfnC
	 xW9tD4rW7V+KXqzPMofu34MTLiuRoIHWeW7jEJxph0BVZKMWarm+/+3Ak/YF4xaajf
	 ykhwiQfF7EgOQ7yBrZ2qvrSpnVsjQ+3s52xfeZ6tWdBlfvJXKeVb81tg1oCIhDqUvD
	 pI+qZUFLFX8kRMik0Mrdj/HfxsZC3lbvEBvDcCVKrfnLgIcwk1/8Q8fnA4RqKgUmoW
	 HLYHS2Cr9qjd3RvxCV4dB17qxHLThmQUlHzLG2XSw6NNzjViXtLJcwkrjA+AQGV8XK
	 mkIS0bs96qnVQ==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v3 1/2] filemap: Add a helper for filesystems implementing dropbehind
Date: Mon, 18 Aug 2025 07:39:49 -0700
Message-ID: <ba478422e240f18eb9331e16c1d67d309b5a72cd.1755527537.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755527537.git.trond.myklebust@hammerspace.com>
References: <cover.1755527537.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add a helper to allow filesystems to attempt to free the 'dropbehind'
folio.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Link: https://lore.kernel.org/all/5588a06f6d5a2cf6746828e2d36e7ada668b1739.1745381692.git.trond.myklebust@hammerspace.com/
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 12a12dae727d..201b7c6f6441 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1221,6 +1221,7 @@ void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
+void folio_end_dropbehind(struct folio *folio);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
diff --git a/mm/filemap.c b/mm/filemap.c
index 751838ef05e5..e35dd0f90850 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1666,6 +1666,17 @@ void folio_end_writeback(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_end_writeback);
 
+/*
+ * Helper for filesystems that want to implement dropbehind, and that
+ * need to keep the folio around after folio_end_writeback, e.g. due to
+ * the need to first commit NFS stable writes.
+ */
+void folio_end_dropbehind(struct folio *folio)
+{
+	filemap_end_dropbehind_write(folio);
+}
+EXPORT_SYMBOL(folio_end_dropbehind);
+
 /**
  * __folio_lock - Get a lock on the folio, assuming we need to sleep to get it.
  * @folio: The folio to lock
-- 
2.50.1


