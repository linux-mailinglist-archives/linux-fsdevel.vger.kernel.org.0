Return-Path: <linux-fsdevel+bounces-72151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BFCCE618C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 08:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DD7B3006F76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 07:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7728279917;
	Mon, 29 Dec 2025 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="A9pi13hm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881542E8B78;
	Mon, 29 Dec 2025 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766992478; cv=none; b=qxC27xcXkj2YOF3FfdbIIlCCmNaNmFMs4f+UiaEWDP6MxTdJxJGWmnEDzizQjAfCxR6yGFkO9T56Q+2LBUD2f2uuX2sGfwsUeQrJVY7IqmZmRbnH3sCYe5ZQHVOYLF2u4OYTvmTPFXCBK7KklYH9dRCf/DiY/Em2QCx5O6xxNTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766992478; c=relaxed/simple;
	bh=cUIQvo/ID4bw1ESziIR5NJSRyrhu1NJY1HnEW38PE/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pnEIRGijBWwEpt33syrdmD4dn4XswWffKOkSrd6ZWxfcEJEMoQhyvwOCXhZVXVIE3TbvDEHyrZhbQXkOsk/vcD9JmRKXoBJX7jPEiHGEN4h8b+LYP6uvDmAUMx4ZEia1h90aqS5jZffOCMoKczzV9zXaE/iz+LmzppAnHvJ3y3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=A9pi13hm; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1766992469; x=1798528469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Av0jtyQVQSLW889o9LVUN10IKhP8kvai2UsJ7tGsSIg=;
  b=A9pi13hmTm3KJcwSEnzQgZcvvMC7o4jB4jGT3aJuLa1S7+HZ/3OaPwXo
   amZnz00s7rGOvVDSE0+t+xG0ymg8o0h/go1uXemoGlJnkk+8GcpXc3rIm
   OpMpe93nXbDgH2Klg83LeifcitD4MtZMbi0yhkGCm1FkaSEJ4H+9a5AzU
   1Yo1zUPECvI/BIkgsgvhBbhR1OMnpK7TIS+62M7Frp8J4RTMvEeZAtU7C
   hmR/RwpbTVhA2WKutt+zg+bwa4P8cLaVbB+bzGcKwBIHuOnFn/y9d0ize
   3/uDV+OOaMcN/lczGNM1WgOwvnBYIYhGWZtp2I2QTu4v0+KrCfeWpI58p
   g==;
X-CSE-ConnectionGUID: Yh2EbFuGRcS7CorpEPOMDA==
X-CSE-MsgGUID: QPWXP6+TSDWcQqsw9EicEg==
X-IronPort-AV: E=Sophos;i="6.21,185,1763424000"; 
   d="scan'208";a="9870231"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 07:14:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:31110]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.226:2525] with esmtp (Farcaster)
 id a1a86f50-4f30-452b-952c-8ce81d842717; Mon, 29 Dec 2025 07:14:23 +0000 (UTC)
X-Farcaster-Flow-ID: a1a86f50-4f30-452b-952c-8ce81d842717
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 29 Dec 2025 07:14:23 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.33) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 29 Dec 2025 07:14:21 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Yuto Ohnuki <ytohnuki@amazon.com>
Subject: [PATCH] fs: remove stale and duplicate forward declarations
Date: Mon, 29 Dec 2025 07:14:01 +0000
Message-ID: <20251229071401.98146-1-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove the following unnecessary forward declarations from fs.h, which
improves maintainability.

- struct hd_geometry: became unused when block_device_operations was
  moved to blkdev.h in commit 08f858512151 ("[PATCH] move
  block_device_operations to blkdev.h")

- struct iovec: became unused when aio_read/aio_write were removed in
  commit 8436318205b9 ("->aio_read and ->aio_write removed")

- struct iov_iter (line 1910): duplicate of the declaration at line 70,
  added in commit 293bc9822fa9 ("new methods: ->read_iter()
  and ->write_iter()")

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 include/linux/fs.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5c9cf28c4dc..598096ec2dee 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -55,8 +55,6 @@ struct bdi_writeback;
 struct bio;
 struct io_comp_batch;
 struct fiemap_extent_info;
-struct hd_geometry;
-struct iovec;
 struct kiocb;
 struct kobject;
 struct pipe_inode_info;
@@ -1907,7 +1905,6 @@ struct dir_context {
  */
 #define COPY_FILE_SPLICE		(1 << 0)
 
-struct iov_iter;
 struct io_uring_cmd;
 struct offset_ctx;
 
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




