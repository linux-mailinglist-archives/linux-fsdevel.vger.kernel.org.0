Return-Path: <linux-fsdevel+bounces-57671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5A9B245A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 11:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC085674BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509832F659E;
	Wed, 13 Aug 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="C7R/jBzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A82F28EB
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077933; cv=none; b=I8WUeSC+nm2vmpb+4cz8KF6gqiI1RfkKOKv58N08yWuEMW2yUsT4ohUe2GCFcEG1mBPoWo6v3rx4izTZvcZIZ7zsO+9N8LLpsiqByhxrvleUAnkHGiL2MmzDvYT8s+v3U+yxa6QyTJn1gd+iYdZ5pK3a3mIV62H6LHvpZj9K+uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077933; c=relaxed/simple;
	bh=Rmed9xCg6eLWAxnc3kS1JwWaJAhtuq+J2SdgL6KRG2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uxl8l1c2QddOuP9lqFeM7KMhj7e8Jkjm2HWcisQ97wg/60u5Uy64qGeEp7lCA/jWjHbbxdH5It818TgQMqZo/u3ys/IfOFHSZXnzdZX/DhrSs3lov4G9nJC7u7mFdtX8VXPVgxQZdHryQGmi5hDm5sD+t5tf3/2ttzQKdTplaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=C7R/jBzW; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=k4
	YO1ZwaezvR2OpFZA4zYeNsSYl/I40wlm4O2J62W+0=; b=C7R/jBzW5ucRXodPdw
	kKKx0JiTalFwYKEx7G9TlnImZP9gn/NSk/7wWzqohy0/9AO88kK61LuceSn89eDW
	ERO8w/kClt88OiI1/V04qf67iTSlJSsrEO9CUpvQUZhfYGDkHU6htmR7yQHWAtrD
	gpRcqTkCF/W3KF7vHFD67Nv+s=
Received: from YLLaptop.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3tyv8XJxo_MzyBQ--.54250S5;
	Wed, 13 Aug 2025 17:38:23 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Yi Zhang <yi.zhang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Nanzhe Zhao <nzzhao@126.com>
Subject: [RFC PATCH 3/9] f2fs: Using `folio_detach_f2fs_private` in invalidate and release folio
Date: Wed, 13 Aug 2025 17:37:49 +0800
Message-Id: <20250813093755.47599-4-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813093755.47599-1-nzzhao@126.com>
References: <20250813093755.47599-1-nzzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3tyv8XJxo_MzyBQ--.54250S5
X-Coremail-Antispam: 1Uf129KBjvJXoWrtr1kCFW7GF4rXw48AF43Jrb_yoW8Jr4Dpr
	WkKr4DKr48uw47WF13WF4UZr1S9FyFga1UuayxCr1xAF1UJwn5Kw1rtw1j9FW3JryDZF1S
	qw1FvF1rWF98ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYYLPUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiFhuoz2icTc3iBgADs5

Since `folio_detach_f2fs_private` can handle all case for a
folio to free it's private date , intergrate it as a subtitute
for `folio_detach_private`.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/data.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ed1174430827..415f51602492 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3748,7 +3748,16 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 			f2fs_remove_dirty_inode(inode);
 		}
 	}
+#ifdef CONFIG_F2FS_IOMAP_FOLIO_STATE
+	/* Same to iomap_invalidate_folio*/
+	if (offset == 0 && length == folio_size(folio)) {
+		WARN_ON_ONCE(folio_test_writeback(folio));
+		folio_cancel_dirty(folio);
+		folio_detach_f2fs_private(folio);
+	}
+#else
 	folio_detach_private(folio);
+#endif
 }
 
 bool f2fs_release_folio(struct folio *folio, gfp_t wait)
@@ -3757,7 +3766,11 @@ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
 	if (folio_test_dirty(folio))
 		return false;
 
+#ifdef CONFIG_F2FS_IOMAP_FOLIO_STATE
+	folio_detach_f2fs_private(folio);
+#else
 	folio_detach_private(folio);
+#endif
 	return true;
 }
 
-- 
2.34.1


