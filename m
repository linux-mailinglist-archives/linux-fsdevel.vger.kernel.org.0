Return-Path: <linux-fsdevel+bounces-46166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90914A83A88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 09:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4A41724E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 07:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A7A205AA5;
	Thu, 10 Apr 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gUg9K++m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7260204F65;
	Thu, 10 Apr 2025 07:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269247; cv=none; b=iScFJ9Zhvsup3VSQX5J9z0T0jMZunvE78AOHRE8J8b5iIN8WD5Nm6XIvfXAsFjwWzYCf9F4yeMyJ+xEX8eX1uPysH+Ni4EK+QizGSGQXIcXQ6gOSQBcseV7wPx9jmD/JJJBcBHQP0wUnR4f/kBD5NKjQrUgqWGgqVM6yu7OtRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269247; c=relaxed/simple;
	bh=i7dZd4RTIenD4CtjHGHMsKXVu8m+BmrxpSyNLIQRWdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gok8bFUAwcFCLjb1N0kuV29hSnc49JeYEJo5Vz7eSxSqzuzvRoESS1L7mursrEfrOaKnMAzwexoy9BGkZeBTElSoY7rm1u4kZGFosvf2T7iuvVU/yaF/HZGfOjgcZdYimqYtFE2bATMAF2JJu31/r+akrxcVvaZhJ7z5LcCFoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gUg9K++m; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744269185;
	bh=KFB+f5rC28uYc0eBhkLr2z1mpTusC4wfoeGQhwpJZpo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=gUg9K++m6fTdywyw3VwqqRgxGUwLDZ1p0YWqvp44CGw2oDCUbzP8GoT6UIMNQXQdE
	 402IBMSFiphKz2VGoU34XRY8dYdl/pmQAb38QteFNU+Gq3yusH5NKaFNcSuULVQE+Q
	 FMWSai0jiRZJUDjj7De0jRhypwZNStveJSuzsCdo=
X-QQ-mid: bizesmtp87t1744269159t86b4cdc
X-QQ-Originating-IP: TwJbXaAheJs3zRhktUwKlzX37mdkkMKLQtdOz2WhpV8=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Apr 2025 15:12:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2740781724737550724
EX-QQ-RecipientCnt: 9
From: Gou Hao <gouhao@uniontech.com>
To: gouhao@uniontech.com,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org
Cc: gouhaojake@163.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	wangyuli@uniontech.com
Subject: [PATCH V3] iomap: skip unnecessary ifs_block_is_uptodate check
Date: Thu, 10 Apr 2025 15:12:36 +0800
Message-Id: <20250410071236.16017-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250408172924.9349-1-gouhao@uniontech.com>
References: <20250408172924.9349-1-gouhao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: N6g2F2FiE7U+JsZaZJ2rSFRnRrdLsR136cxjMeVn2kiqlfrD9SOsNYt8
	t7z5Fznsrg5u/Bvg1FWWStvR0J89gH2qaJIkWdUrzrhOiVDWejYV/Niiqr/8jPyj1N5DHeY
	ibpt1zjcNpaJiWBCgOlvQcQLIOSkd1FGwIu0z45EvLNfdI6vpXppX88PFYM4+OofYPlBeyt
	AX7+QaOKAnyBFfLtkCtV09vmG0Zs+nZ7/xqhW0cGbyYbPymPXVTgSenLRWPffGv38RhTpfd
	NYopLRqPlJf4bUM81W94GAs8LtFxaeBfwgVak+40TNb1Hz/WLwFbQTIiIgvyJ5IwtpqxrV/
	dccprraW31CoQV7wr+IDt/Y4XByZZd944mTlWvE60bJFtPX5a67PqkMFyX4pcgf46c3Nqxo
	iFMAyg31Y950lBGG87EZG2IwkF08POZr70o3ufEtgITB76S/R3Zioe6PjKuXwRhOK583a5H
	0H2nHrwhhxYsF1+1RfC85i/bJ4J1vzGsxUGEF5glmxphtKEJ3+JHjz1VIJVOyTYa+wXbzWu
	aRs0TryCDevfeDhAnW1KoUkQgb2f4qkRT6uwmuKqevmAV9giIytdP/W/5N7PX6mimdzvoEB
	rsfm/4xuYBtD1TD+X+yOarpFvB+g/Q9FHd1wzROkJq04nJgeDO/llDVipv7vvSkxTdAsJU1
	WDfAWkaDms1qstgbiqUopOoCqvfZxz1Spm53dxS45NVmjRql9bvFwQUZatuVQcs3YrZojy3
	ViVBKJqaVO6mqKhNRb065ZTHZYj8ke0U1YsU6hfQOqVtffhIsxxcc46GKvLb+LArmQKJxHN
	AOILAlWyWsw2VC5pxtRCHuk5dWYqBcSAhqEq1T3O9E3IePZcjOWJ3CoJFJEAMHF4aZrL9It
	h9A8Iq2OBPCEjjqsn/rGQenbmI4ClSEny4ga/NU95+Quza1OpQy/EvxFjR6rZ8p5JqlaycC
	/Vi8UzIYyXrRytkTw+CZQfSJfzeuDOQTQL4bX0owi6oeiu1hHdietkffFd6iyRDZu4KtMMQ
	/IEYYslAHX6oJR0FkfzhryjJNpPEisAeJYeSrS1vaDiCemf3XN
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

In iomap_adjust_read_range, i is either the first !uptodate block, or it
is past last for the second loop looking for trailing uptodate blocks.
Assuming there's no overflow (there's no combination of huge folios and
tiny blksize) then yeah, there is no point in retesting that the same
block pointed to by i is uptodate since we hold the folio lock so nobody
else could have set it uptodate.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes:
V3:
- optimize commit log
- change 'for' to 'while'

V2:
- optimize commit log

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 31553372b33a..5b08bd417b28 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -259,7 +259,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		}
 
 		/* truncate len if we find any trailing uptodate block(s) */
-		for ( ; i <= last; i++) {
+		while (++i <= last) {
 			if (ifs_block_is_uptodate(ifs, i)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
-- 
2.20.1


