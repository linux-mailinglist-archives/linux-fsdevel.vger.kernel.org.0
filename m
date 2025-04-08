Return-Path: <linux-fsdevel+bounces-46011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1531A813AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 19:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC917B57E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8AA23E25F;
	Tue,  8 Apr 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="l7axJdpP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94DA23C8CF;
	Tue,  8 Apr 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133401; cv=none; b=Luei5zIMNgZfRELj3+/RtmjTPTZtGorLZ7UseQvGD0Ge733KueHQp4JEqQD2xWt+nzbPzVgJJjoKSN2z/tTPHo6ZxUhYGN6aqjMHWPWYROG58qnchGCiq9MnoXgKODpwCvlLIufsB80iM3xeS3qaw1HUmHS/hxp4OI3OXyT5oy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133401; c=relaxed/simple;
	bh=B3JNE/RJaHRf+FsK6E2+qovWjVp+i+WpEhj5NootNbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EXN3F8bg43F2qNij7PHBBIkpUUUAnD9yR5k2tNh/EMLI+0BQLZ1+h8I9PtZByB+PRo+K4AILae+MYCXEjggCR1F0hAWvAxwhE6vFPhvGRrfz7uzrHO8RCUvehEZxQBJEl9qXUJrfY/TgTOS/LQOnoZsgrPWBs7ZcJeCe6QPuKTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=l7axJdpP; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744133371;
	bh=JlHpHHiZ4Xge+vx1XrJwPQSvBNDkpNFpAIMsyEk8JRg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=l7axJdpPFiRN+JhCfL79Tp8lAK5vdlWYBcWoRMvisKX2GbsBVMZvW9CnJGYChOHee
	 Y2WdND/+srRxWGjjnlcl5aDyNJnyOvb6NCCGFD0/VpMXQQPI7g6+l3Fm7J6D9GBxBL
	 EMo5hnJc584mrWa3Bk05K7Oszsv6GRI3PYzzazvA=
X-QQ-mid: izesmtpsz21t1744133366t2b0302
X-QQ-Originating-IP: /o+76Ijt+bW3YgZYdCmv0p/YEdX6GjSFegE+xnYizTo=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 09 Apr 2025 01:29:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11347015374347384928
EX-QQ-RecipientCnt: 7
From: Gou Hao <gouhao@uniontech.com>
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	gouhaojake@163.com
Subject: [PATCH] iomap: skip unnecessary ifs_block_is_uptodate check
Date: Wed,  9 Apr 2025 01:29:24 +0800
Message-Id: <20250408172924.9349-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: MvUCj+jJbjsSjSYGtTEID3b5MqeBUxiHsF8GryNIwKvcN26m6Eifn3VE
	LYTJDmr1ry+G0BNgfNAB+sMF6KGCrToKL8hZ8tfqtUKJM17OX+u1sYumuRx1n33pHex+kNI
	7uZhG5nZitvaQ/C8nB3YZzWa31+sZvr2+TrQkFKDW2FhlOECoqbSQZxYMkICdd4QS7kwE/T
	MGDdNDEbKXfAqnlDJbo312t8n2oR1BcPwb8p74Cwm6hlMI/Nr2BpW2UYaw6PD7YiwGSVQqW
	cHZYIWJ26/Rsjybtyk1OR8tgMW8bIwt9puIofLLNm1L/44Rrw+60h8N+LBM/hXE1iQEbNvB
	MDeIrLMm7LC1iCO1HCqacrVf6dHid3bgZqxsNDq/C51Sjlg6fINDFX+GnUje7CIy1s0Dxn+
	iY+cHA5xNi65+ZK/LTBKP+7JCLq5umUXI2XQwFCv0ngozwSnrPzax1PX2+Pw01BDni+cV1c
	7HsgFc682rrA2GNC3KHCAd5O+w6EB/VLPIoJuTKY0hb1z6EeWf1PbN2SvZ++FABRBL3XoEq
	emObgpNSq4W+c0SVmiSDBN6sG10pwzYC+m9Nv6HvD5n6OUmnLygvBYwxWMXmzC3x/EREMn/
	PKgBwzwKQvpfdO2JfUE0L+RI0jKEi5woaoGFPaA/VwGk0Se3ZCGXNszqUi9nbbUbe8e5VGs
	alueoAJkYqjqKbJQbNHLgTu9ElFyE0pR5jGlikrbeoNAKgw2YVzCyeDXkjagOUYxwjR9Xb9
	ZEtf35n/dv6q+cSIY7U4cByNA4RkmXLDARjdUYzGtGzUJVMmBHJP6WFebBeQfOi285l2GMj
	A2VC8DHkaEtBY8EvBh5rqSFnfm31yYhwdY8KaOW64jjSiRJu0dQ6u5N1nSsOejKKcQOLv1R
	PiqZN2Bjl1ixgVUNeAzxmwPiLonsBSodw3s3vOZLSI4hDmAALRORRuTqlQHlzQF8UMeeEfZ
	8mHS0fgtIDBlpMnRVDn2MOsw3MvjrAJUYA06oX0KyzC74spvaqGzKNQfR2ZdLYDGuS71SWc
	bZArL5qiVyFok/tb7R
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

After the first 'for' loop, the first call to
ifs_block_is_uptodate always evaluates to 0.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
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


