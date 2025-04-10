Return-Path: <linux-fsdevel+bounces-46162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD568A8388A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 07:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F51219E78FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 05:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B432E1FAC42;
	Thu, 10 Apr 2025 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VbwJihu1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557901372;
	Thu, 10 Apr 2025 05:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744263805; cv=none; b=eWBNmmcUwtS5pRGKGQKdOfu0vYiFzdhYkWi+6rx6FCz1kZUgpON5X99MDMXkSoJ1rb81oeUM24sXXHsuiuidXhJ0ynKSwnQSIENCqcHxgouLpVZ9e1eEMFqAk5Vu+A/MIml/7rn9cQuA5Php+bD2InHi4i8Pi0EWoRNCydl8Bc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744263805; c=relaxed/simple;
	bh=rFqneeQKHO28Rsz3fVGEepUmfaQh+25dsCK+nn1qNIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mKP39K2JMqG56+bKf3MXirx/q11D7W1805YHFU8r13/I3gGFbbXnTHHL+qo1B6BxIAyxn7ztLcH7a6bD72Ow4EYUL0QsYvT98efmM0j9VZTXXnwnM3yRlt4Zn7IAo2pTdZYsTZSan9BUYb9UaK7I7A4pagUcUjcxeO+0rYtbLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VbwJihu1; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744263774;
	bh=h7/B3VpTYwFMRK7BwEjA91WCdUBkPynLzW4EacJ8QIs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=VbwJihu1PMKiuLPkP0GnUbRg9O8g/A4oDESd00VHU5lKHgdjhGEHMosRWd06ybJep
	 oeFE1uo6dRjgCTb8rluHoqwCv+CFxeL4ib/rCeZOVj9odiNJf8JSqRZdcLOY8hn11k
	 SJSmWpyfNilT2mmL/ronX7oQ1M6aEw1VlKQZOBao=
X-QQ-mid: izesmtpsz16t1744263745t1ecaab
X-QQ-Originating-IP: X7mWDyPm2f2P0h8j66ZypC6U/xG/EYVHodKn2NzE5GM=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Apr 2025 13:42:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11015122016074661312
EX-QQ-RecipientCnt: 8
From: Gou Hao <gouhao@uniontech.com>
To: gouhao@uniontech.com
Cc: brauner@kernel.org,
	djwong@kernel.org,
	gouhaojake@163.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	wangyuli@uniontech.com
Subject: [PATCH V2] iomap: skip unnecessary ifs_block_is_uptodate check
Date: Thu, 10 Apr 2025 13:42:23 +0800
Message-Id: <20250410054223.3325-1-gouhao@uniontech.com>
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
Feedback-ID: izesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: N+n6UtIkOPCa4bgU02EIefMEdYzNIBswAK4gGBBtCO0wtpa0rHnkUiYD
	yenyFeC1YJFz8oHtG54eDKhdjxyzH1kiZBslmSopDlP0npP8gRlsoyqJ6Nzjabofb6NAPjZ
	8TMzHNcfePc1aAQQIZVn8MSEuAQl1ptvlQCplIidLytNpVWl3kW3OkMv4QUJu+zmq4rd6yv
	WJZw2X6eKV2PVm82oh/sp+7duoU4PhmTrtDh1TKwsJCLztM/0bseCejdJF6yrV39HOf4U+c
	e7R+qQqTSgAQyYclZiywbqWF/oZipSSpZpTyX2r+jgOL5Qa8uxROVnl5SxgO1rlVvvG3czL
	uOXjKTGkOYang6Y3P+Mm9QFWLppHtCQjQJKdTXeQDpPBbDw0mr93qJrm3/IRUlfOvcTZuvM
	yIv2m/TgWSY0W6a1G0gDHh3KZ+vWy8lX8OzHYu/c7bDtRYtUouI5RnqZwovLBCAVjGxZw/1
	FV6AMxcOY/uahyGo+Msp6dItbYtWZ//4mPkznMq4u7wUDSyAJf34KwMT60aYf7ZkEViyzXF
	s0013FXOGzlOmxMgzOYr5gRMgOApk0C48iFFa9b6SwKdmE+KS3dkKPivZuk0z0JVIjf41to
	bk3DWxweqJKzAHOUEpQwZT6Vjfxc9cKkAtfGrWSKXtGiJ6dpvdlDMO8co0vpNlhPNNOcjyC
	cQrB7yjoEBrTIk91tJOyKVrSd3IDHDkZEqt1OqEpLuT/ZUMZZMpeq+1ByXPRh1MwlAa6upA
	95qASl+noI2+rUMo3DhI+eSPVPPvzCoYv0UmWktKhyUh98cMc3KuZriMRG94L4iOo3a8S+7
	DLWlogofmgIYO/TqM2MTqdrZcaIIIqGW+VeNlPrOG8jj5FhsRErr3L+sgOVGVHF635aalqp
	xOQoBDc9Trjyq9iWfeOaDhQEdO70sVeQW18PDLB4UL8cfs1VbfxKmxrXTt5CzI1c1vpNlYy
	B9pU97zRAuqaTjFyfqu5DwuYE3NGIZpbJBAciC2YLTngmdNkDTtIKkEnRk6eeyT05CQM=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

prior to the loop, $i is either the first !uptodate block, or
it's past $last.  Assuming there's no overflow (there's no combination
of huge folios and tiny blksize) then yeah, there's no point in
retesting that the same block $i is uptodate since we hold the folio
lock so nobody else could have set uptodate.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 31553372b33a..2f52e8e61240 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -259,7 +259,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 		}
 
 		/* truncate len if we find any trailing uptodate block(s) */
-		for ( ; i <= last; i++) {
+		for (i++; i <= last; i++) {
 			if (ifs_block_is_uptodate(ifs, i)) {
 				plen -= (last - i + 1) * block_size;
 				last = i - 1;
-- 
2.20.1


