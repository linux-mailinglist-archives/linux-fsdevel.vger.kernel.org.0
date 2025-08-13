Return-Path: <linux-fsdevel+bounces-57674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE271B245B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 11:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E246882A91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE802F744F;
	Wed, 13 Aug 2025 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LfszXlop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6E02F659A
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077936; cv=none; b=tXl/s1OtRkuOrvL4/0edqW4ie7K4s8ygQHPT7ZUL1vDGPVQDbB4Ng7O4OpjXa/W6MxwKTwR0F9OBTZvURXRMcc1DF6QQljKMQjx2aEFfaga1/1/7WTVBaZLigAIz7SohooqQWolAyW17E31sjTxAExdrAMTlLaxXeF+UYH9jdLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077936; c=relaxed/simple;
	bh=kEyVBeUy6mpGa0wt4xczIbKFVLTayAhNHPRYX0MjGW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qa2JNhgOrZXmuUAI+LvCHmpSDC/9Sf3EpFee7PvGYswigagsReopXwrk8gcg2cbFQT+EmAh7zK3Tg1erte6x2td1i5/3FXmJxA/OTzkYWAzNhRx4NfpScV8z1Fe0eY5Ekv9q5Cnq8c9Kb4ecXti/DJ7uwm0UfeEazaxsBnlYPCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=LfszXlop; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jD
	Ev8IL/23nGWQ3lTXpOICy8DllsO9huiCSCaNsxpfA=; b=LfszXlop2m5pDvBNJP
	q6yF4z/A2hHRqWrU0gtM6tB+ozTVEirNHkjuOBc8dbsJvU9nvJmM1CcoQU68+w3/
	qiS9ur4B5MVDVS4K7TRaj1bb95uhkME1tsFLZRqZqIZD8wcCjIohyCLsnz7M9552
	6qOA582+k+m2yN2HkR9wFSj88=
Received: from YLLaptop.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3tyv8XJxo_MzyBQ--.54250S6;
	Wed, 13 Aug 2025 17:38:25 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Yi Zhang <yi.zhang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Nanzhe Zhao <nzzhao@126.com>
Subject: [RFC PATCH 4/9] f2fs: Convert outplace write path page private funcions to folio private functions.
Date: Wed, 13 Aug 2025 17:37:50 +0800
Message-Id: <20250813093755.47599-5-nzzhao@126.com>
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
X-CM-TRANSID:_____wD3tyv8XJxo_MzyBQ--.54250S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4xAr45Kw1DCF4UCF43GFg_yoW8Gw4rpF
	yDGFnYkrs5W348Xas3tFs5Zw1Fk3y5G3yUWanxCrWxtw4fXr1FqF4rt3WDuFn5trWkJ3W0
	va1YyF1rZa15AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRm-ewUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiEwqoz2icVjtiDQAAsI

    The core function `f2fs_out_place_write` and `__get_segment_type_6`
    in outplace write path haven't got their legacy page private functions
    converted which can be harmful for large folios support.
    Convert them to use our folio private funcions.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/data.c    | 2 +-
 fs/f2fs/segment.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 415f51602492..5589280294c1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2637,7 +2637,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 
 	if (fio) {
-		if (page_private_gcing(fio->page))
+		if (folio_test_f2fs_gcing(fio->folio))
 			return true;
 		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
 			f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 949ee1f8fb5c..7e9dd045b55d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3653,7 +3653,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 		if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
 			return CURSEG_COLD_DATA_PINNED;
 
-		if (page_private_gcing(fio->page)) {
+		if (folio_test_f2fs_gcing(fio->folio)) {
 			if (fio->sbi->am.atgc_enabled &&
 				(fio->io_type == FS_DATA_IO) &&
 				(fio->sbi->gc_mode != GC_URGENT_HIGH) &&
-- 
2.34.1


