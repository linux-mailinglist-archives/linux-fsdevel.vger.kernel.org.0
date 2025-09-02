Return-Path: <linux-fsdevel+bounces-60001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3E2B408D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 17:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D00F188F2A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC3431E0EE;
	Tue,  2 Sep 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AnLLyO9V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB128489B;
	Tue,  2 Sep 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826570; cv=none; b=plUpk+3nXYDZUWmPiUuJgmOPXdTvAQ174lTV7TnOVV5u4mT4z5BcqOLiRAIbEgH+HJHWmTrDwDDyR1WyxPOqYj4rBIfveAF636a0aTAvQw5pBNuw7ZzEysvQ8Y2o6ECxmW3HR4liYxDmXr9pH2A277cjrjLmgtgXGl71O+uzfRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826570; c=relaxed/simple;
	bh=HaUYGzzb/C0ZDIqppBt972XneJxjm2FpucYUwJY3Mq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOoLk7b3XPvOfrmMg5w0/a/krP3tfW0Ciwv5ufYEvCOFnKVE6fZdy5uzl35VGK9PbOVnV4PYh1bq1T3L4Q81DuGTcrNXvWOIy5seYZO0dCPJ1N+PZgGwVxGWBCLVkemOfBh9YOJXOlkz6XUoobc3MJPq6068dLaJZbAcdjpL/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AnLLyO9V; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=U0gQV6ybTFZGuryr56vx/u+MpC/277rOqkaUQrD8Who=; b=AnLLyO9VMFwCr2es3/frbxHCBC
	JjlPP7n5z9ULDCVWr5AQzJ2l+5q8UR66ExwbJHr6BkB1jeIzNQMrNOxqEIPvli742kjWtQgd2zzCY
	vMFTibF3LJcdJwQVNj22JNPUIL6brEeMOevh2LnJ3Fla/R2w5OyaEhlk8ekLJHdo9l4t0Gx5d9Qpt
	wNMbh5xJ2zU7tA0gctkcN5r3o3ZtkeDmFSF1c196PEPJ1+SPEOHBPfKAB6q5WmO0HRoA5UMPeoaM2
	cdJeEn7Q/ObGevUCQaRo+XaSlU61ZAy2B3RQbAmsUz/YQSV3qHJ55gQdj4H3qjFyKYnNPxsY187/W
	SMJSM2hg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utSqH-005lLV-MA; Tue, 02 Sep 2025 17:22:41 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH] fuse: remove WARN_ON_ONCE() from fuse_iomap_writeback_{range,submit}()
Date: Tue,  2 Sep 2025 16:22:34 +0100
Message-ID: <20250902152234.35173-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usage of WARN_ON_ONCE doesn't seem to be necessary in these functions.
All fuse_iomap_writeback_submit() call sites already ensure that wpc->wb_ctx
contains a valid fuse_fill_wb_data.

Function fuse_iomap_writeback_range() also seems to always be called with a
valid value.  But even if this wasn't the case, there would be a crash
before this WARN_ON_ONCE() because ->wpa is being accessed before it.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
As I'm saying above, I _think_ there's no need for these WARN_ON_ONCE().
However, if I'm wrong and they are required, I believe there's a need for
a different patch (I can send one) to actually prevent a kernel crash.

 fs/fuse/file.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5525a4520b0f..fac52f9fb333 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2142,8 +2142,6 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	loff_t offset = offset_in_folio(folio, pos);
 
-	WARN_ON_ONCE(!data);
-
 	if (!data->ff) {
 		data->ff = fuse_write_file_get(fi);
 		if (!data->ff)
@@ -2182,8 +2180,6 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
 {
 	struct fuse_fill_wb_data *data = wpc->wb_ctx;
 
-	WARN_ON_ONCE(!data);
-
 	if (data->wpa) {
 		WARN_ON(!data->wpa->ia.ap.num_folios);
 		fuse_writepages_send(wpc->inode, data);

