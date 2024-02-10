Return-Path: <linux-fsdevel+bounces-11039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBF485029A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 06:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808DB286707
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 05:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DB98F5A;
	Sat, 10 Feb 2024 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1fYDIBUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484463C
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707541569; cv=none; b=d7slgs6/E/qxd9KTIqk1sRwey6loLdt+v7uw9IRxWvorr3xqE39CGJaaPiaEZbydgCLJuQ06OwhCb1GSHOLiVRPDQR6Il+KmoMz5GKibnIHvrBT9PkDHHWIx9jomJSGBZyKO88Rfza0Cj104EPJ99qTXAEYRLFg+0dmzpcD1ZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707541569; c=relaxed/simple;
	bh=uGhnbafFw57DZUb2SjTRhMNCt6wGtyCxlU1nTO9g8Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gu8Q+9iY/y6KFSvBEFm2mJrcK/mmBK9ezF8keMcU7AkDy8ci/BLK3NiiKT3zRqncXdqjBoaniw5WMnE2gEdUvTCtddo1kjy4UD+c7GcO72eAEHPtBfTNutNvOLjMdswvnQ6htVhgWyl5/dgc+ffK603z11qUoEArXdexji0Zhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1fYDIBUu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PgqiFXHTY4BNefMXVU71C8xlnhYWmJXOTG4yohtyeaU=; b=1fYDIBUuvPe2xa9v1Aqnlo7eRR
	qxrOAOR08gP773/QuWv02BSjyz3QOVg4d0R6oEwV9+34NhWM63OYqjAb5KUT2HNHAg2ntNszIrxoO
	5Extu3Nv0bAWbi6MYsO6Q7b+VDLc7nuckLqupC/WxDNDw5W0lTo8UGtZQyx8NftoQyuqATTsPOSCc
	IJqK5wBulaDGOe7OVYu4ICkdeEiYJ1sIx9yCCMD26oGMpz+2rp8OZv6uleP6k7K/apW3W+dUV/Vyh
	Le/4jddhtqydDaPsHi911pwF8x6RpnQu6l6w6wqiaS7zxLFUjnifEVeaM3vFH36uUUsNj9zQpe11R
	xnxTe5Qg==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYfZ1-00000001E44-2EzL;
	Sat, 10 Feb 2024 05:06:07 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] fs/hfsplus: use better @opf description
Date: Fri,  9 Feb 2024 21:06:06 -0800
Message-ID: <20240210050606.9182-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a more descriptive explanation of the @opf function parameter,
more in line with <linux/blk_types.h>.

Fixes: 02105f18a26c ("fs/hfsplus: wrapper.c: fix kernel-doc warnings")
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 fs/hfsplus/wrapper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -30,7 +30,7 @@ struct hfsplus_wd {
  * @sector: block to read or write, for blocks of HFSPLUS_SECTOR_SIZE bytes
  * @buf: buffer for I/O
  * @data: output pointer for location of requested data
- * @opf: request op flags
+ * @opf: I/O operation type and flags
  *
  * The unit of I/O is hfsplus_min_io_size(sb), which may be bigger than
  * HFSPLUS_SECTOR_SIZE, and @buf must be sized accordingly. On reads

