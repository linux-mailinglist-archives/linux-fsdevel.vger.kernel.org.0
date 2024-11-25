Return-Path: <linux-fsdevel+bounces-35841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258679D8BB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 18:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB792163DB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B4D1B6D14;
	Mon, 25 Nov 2024 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GpWyo4pB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25CD1B414F
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557293; cv=none; b=CtGZyKd0Iedlkg00CgDWOxHEsF3tscmH4Ul8hBxUT7ZpOIEsfArLQ6MaO4DrNbih84qB/SlR+XqBWsTenZ694iUbjih4eB5nRBpsMZWMsqD8EhxpJqWelT7ju5TgYx/PxnhJKoULI+A2j4vmWMlqkg8JyF9BEhkCTYKDa68NP24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557293; c=relaxed/simple;
	bh=O3lFZWl1qrjbQm0ehlEqUOLnefaYbdUfOga132qNs6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oOWJrzY0rTBCk7/ZGRyL/RZcthnoX8eQAcf6X8n8aZSxUsfYjJxXDwvNmaVlSXgF+cHshph2wlHpZxM1miocDVTz1KBNUGL+yZ6Lp8em8zJuML5Pvsv67NQHv8SJIdnl6OTTbm5KJxiF2KOkSWEFA4qWThLVURZIyDuTbT36d74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GpWyo4pB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ZW6YYzp0eBx4sJSL2cnvgiZmSCS5qBW8UyMy+qwIRLw=; b=GpWyo4pBg7XDNBkSVM/FMl7owI
	tkSdgORTAovr09VRwiIsUGTOYeTsfEGymjH29HeppgYZh0JOvsm384wEGwsTTNxrlisywjCR/M6sG
	J7Pvb5cnAlTgYMyvhHTtXRuA9sN7Z6zxR3J/FZhFjK7sKn2oPNr0d9RsaxJk3X8hN77b4I8hUaHdS
	SQpjNpLqysL7y3MoDCJ/jP0FbTP+c51hYiMPqOtjYGD5qXu69A+2eaW3uWWX59UR4h4JF3inr2VhX
	h75omtqzJVyf1yD7OxBOXd8/T4Nm1rAwFWf9y0m8m0w/BAi0D1V7UuL9zNLIUm4/dg5o55u1lFc9V
	EqZT40jQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFdIP-0000000CDUQ-2WDU;
	Mon, 25 Nov 2024 17:54:49 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] watch_queue: Use page->private instead of page->index
Date: Mon, 25 Nov 2024 17:54:41 +0000
Message-ID: <20241125175443.2911738-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are attempting to eliminate page->index, so use page->private
instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 kernel/watch_queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 1895fbc32bcb..5267adeaa403 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -71,7 +71,7 @@ static void watch_queue_pipe_buf_release(struct pipe_inode_info *pipe,
 	bit /= WATCH_QUEUE_NOTE_SIZE;
 
 	page = buf->page;
-	bit += page->index;
+	bit += page->private;
 
 	set_bit(bit, wqueue->notes_bitmap);
 	generic_pipe_buf_release(pipe, buf);
@@ -278,7 +278,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 		pages[i] = alloc_page(GFP_KERNEL);
 		if (!pages[i])
 			goto error_p;
-		pages[i]->index = i * WATCH_QUEUE_NOTES_PER_PAGE;
+		pages[i]->private = i * WATCH_QUEUE_NOTES_PER_PAGE;
 	}
 
 	bitmap = bitmap_alloc(nr_notes, GFP_KERNEL);
-- 
2.45.2


