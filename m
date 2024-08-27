Return-Path: <linux-fsdevel+bounces-27330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A620A9604B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589A21F234C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 08:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51FD19752C;
	Tue, 27 Aug 2024 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ZCjX0/Di"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC9E19644B;
	Tue, 27 Aug 2024 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748151; cv=none; b=G8ChIo/fgrdelRFKurK2/ceP36o8pBbVF36k5Q5Q3EfAaQTb9lQB1zEP6wknYwl4iQq1nU0zhDgbZ0nzugK4RIewaFEDzsmotes0agqMZLKVEuPtvtzkvzcBNQUSwAwBJA6qWu2QC04q7OAfsTbnDLJQxR3LtHHwHf5rOgdz3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748151; c=relaxed/simple;
	bh=7A9So8y33HL8OEVSm58weAi/w2LIOKXBHjZNbHJpVwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ntQ3SNwQ/6NwyLTiAh9eXzSNALf3wDVou+Oh4Kko0dZJ8/KZKRbQqV7DLALKSPRALUJFrr4KIcZj4YIcZ+ZZ2iup34hcPrnqYBBMesMJWjMyNkTgTOS97F0DzxsGoHC8Aeb0FV+Szr+Ac8tUmEZYj+fHc+A7ytosIuItuJOgOK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ZCjX0/Di; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WtLdQ6rygz9v9g;
	Tue, 27 Aug 2024 10:42:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724748139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xut+nsVM1nB02oWk5qfgL9B+6ylpZd9v8jcCsaRl5IM=;
	b=ZCjX0/Div2MEZ5QtPqlHRmtd97qnVJlOTUI17ALBbZEkUgx/jQb4H9lrCukLX6FdI1i8CE
	uuk/wwm2XJ+9M4SLu4lV8BrKRopvbvI/zu3FmwPESx6KT8hBWc3z2i9QPlX5c3xe5Oprbw
	/HeU7ceT5c+68lF+rU1W1eiz5tMPTQWXDwoGgG4dS32G7Npyy7Cz7ZZ14W6qg3qrF0d6hS
	4gWDH+mIwMRC5a0SaYFhpLvqQo5e63fX5A+8e5Ywe92mNCWsPd0h7IKRbViC0+wxstM814
	s7u0QaXLGXAskuzYIjjkgkITXOairEXxfeB/SzPE+9R+xIjzVJlNcPUWVBos9w==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: brauner@kernel.org,
	sfr@canb.auug.org.au
Cc: linux-next@vger.kernel.org,
	mcgrof@kernel.org,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] filemap: fix htmldoc warning for mapping_align_index()
Date: Tue, 27 Aug 2024 10:42:07 +0200
Message-ID: <20240827084206.106347-2-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Stephen reported that there is a kernel build warning due to a missing
description of a parameter in mapping_align_index().

Add the missing index parameter in the comment description.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: c104d25f8c49 ("filemap: allocate mapping_min_order folios in the page cache")
---
This applies to the vfs.blocksize branch on the vfs tree.

 include/linux/pagemap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 55b254d951da..6c0dde447c98 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -470,6 +470,7 @@ mapping_min_folio_nrpages(struct address_space *mapping)
 /**
  * mapping_align_index() - Align index for this mapping.
  * @mapping: The address_space.
+ * @index: The page index.
  *
  * The index of a folio must be naturally aligned.  If you are adding a
  * new folio to the page cache and need to know what index to give it,
-- 
2.44.1


