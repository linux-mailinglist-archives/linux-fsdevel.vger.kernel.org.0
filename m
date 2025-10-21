Return-Path: <linux-fsdevel+bounces-64820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E4CBF4E00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70AC426E23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 07:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40362277CB3;
	Tue, 21 Oct 2025 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="a/cBIgJ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5D2737F8;
	Tue, 21 Oct 2025 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.199.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030704; cv=none; b=sHO/tnoF4i+WLKtkjneOtjFNMpTEP6m+M5mzDlochydN/wwnRkrftUzJ4LMLdEq6aJlC729RBXWN3DrWLH2qpco2MvYPjibg6S0UB7/Po6gzzUYoU8jKzVRROwMw0nlFx0+5lKyiPKlRixHDFQnfO24/JTWA5ro7E2cMjG21WcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030704; c=relaxed/simple;
	bh=aS75Pmkr7ko5nrziWGIpkCaBU+bk1gMXDCjKi2pXjwc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnC35eojtI1CQMv/zQvcJWtaVXeFAjiJFbqHbtlUwvTUKLmFccmgmUtEWW39PzFtrQWOvA8H7wPHIv5l3sHO/V077IG6isihiFREi75U2D0ZWTprik7ojqN9u3oDzRZeO266/hRbS6jDZWGknOYqcHHf8o5SM6FIBzzl+c5hCTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=a/cBIgJ3; arc=none smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1761030702; x=1792566702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ER5cLgoC/4MdsBzdzUsBYBpn6poQFnbZbMEZNMZv5Vc=;
  b=a/cBIgJ3MTHuUdptKGjOpwVuAaXNjevyQzET7dHW1d7aMXrCofRxJsBb
   KVt61Z2+S+iWWg/ShZdxkwjVrPDmu8ctPAxXPK9oDt2myjWYS7D6VQYX1
   fI6MF4eQXBg30SauHLzg1ORoHPxdX+Q37Zkx5HYu4ibrvs1DWWnSePGbo
   6HpZv7w16D3N/Q1ElsKxvf/HVuMvp2UDFHY1IBo1CI1zKpD4F7PJprp7v
   glNR254YiE24Cd8PON3/T89Dc7EEy2OuGXLcrSrMiqETyOUSqgdQuckEo
   EMQPx7Nd+d3iBv/3H5YF/r/WrtQcJ6JYqv7KELFghFIbjzMe992kcDdM1
   w==;
X-CSE-ConnectionGUID: kUEZ2KC2Rfa44N6E7Rqgsw==
X-CSE-MsgGUID: epsBYkLXTYGjTRt8EkVXCA==
X-IronPort-AV: E=Sophos;i="6.19,244,1754956800"; 
   d="scan'208";a="3824996"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 07:11:29 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:28509]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.18.241:2525] with esmtp (Farcaster)
 id c31f0d4e-9a33-4d49-91df-70df47201fd2; Tue, 21 Oct 2025 07:11:28 +0000 (UTC)
X-Farcaster-Flow-ID: c31f0d4e-9a33-4d49-91df-70df47201fd2
Received: from EX19D013EUB004.ant.amazon.com (10.252.51.92) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 21 Oct 2025 07:11:28 +0000
Received: from dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com
 (10.253.107.175) by EX19D013EUB004.ant.amazon.com (10.252.51.92) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Tue, 21 Oct 2025
 07:11:19 +0000
From: Mahmoud Adam <mngyadam@amazon.de>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <nagy@khwaternagy.com>, Al Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, Ilya Dryomov
	<idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim
	<jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Christoph Hellwig
	<hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, "Ryusuke
 Konishi" <konishi.ryusuke@gmail.com>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "Hannes
 Reinecke" <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-xfs@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-nilfs@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: [PATCH 6.1 5/8] direct_write_fallback(): on error revert the ->ki_pos update from buffered write
Date: Tue, 21 Oct 2025 09:03:40 +0200
Message-ID: <20251021070353.96705-7-mngyadam@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021070353.96705-2-mngyadam@amazon.de>
References: <20251021070353.96705-2-mngyadam@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D013EUB004.ant.amazon.com (10.252.51.92)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Al Viro <viro@zeniv.linux.org.uk>

commit 8287474aa5ffb41df52552c4ae4748e791d2faf2 upstream.

If we fail filemap_write_and_wait_range() on the range the buffered write went
into, we only report the "number of bytes which we direct-written", to quote
the comment in there.  Which is fine, but buffered write has already advanced
iocb->ki_pos, so we need to roll that back.  Otherwise we end up with e.g.
write(2) advancing position by more than the amount it reports having written.

Fixes: 182c25e9c157 "filemap: update ki_pos in generic_perform_write"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Message-Id: <20230827214518.GU3390869@ZenIV>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Mahmoud Adam <mngyadam@amazon.de>
---
 fs/libfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index a5bbe8e31d6616..63bc52c20f7e03 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1615,6 +1615,7 @@ ssize_t direct_write_fallback(struct kiocb *iocb, struct iov_iter *iter,
 		 * We don't know how much we wrote, so just return the number of
 		 * bytes which were direct-written
 		 */
+		iocb->ki_pos -= buffered_written;
 		if (direct_written)
 			return direct_written;
 		return err;
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


