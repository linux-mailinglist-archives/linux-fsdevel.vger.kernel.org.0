Return-Path: <linux-fsdevel+bounces-60132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82964B418A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 10:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34923BD127
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770042E719C;
	Wed,  3 Sep 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="O1d1dxvD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5047E2D77E8;
	Wed,  3 Sep 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888514; cv=none; b=BGpjwO5PxRAC0YC5fQ472UWVqYnE37vYHHZCQDk39OEfwb24LCCl6EA75+azQbp7y9ZkVjn8Rg5N79rByMgWMVGvjIlEuQj/mqeF4sJAKLP/aajUEW+NwqhBBEeWnVHMqLA6XKNoNCHyxcTgwrdYV+2KWB1hySqQAP/Jg7QePzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888514; c=relaxed/simple;
	bh=HOK2OBFehwf+Ojm351ekqU9NNngwOena2BOEdeRC/JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQyfeeys/pC11EdC+RAw7kTOUhve6fzk/2AbkRZMdbpS0e7fgCCqYyx2LYYZqQth/QtICw6+6JMkGPWopOEiZBXKTSj/RDlrgXVCuyYhuJc/J6ZPab/emqnyPZ0aJTV46mlvCtVZaxtusmvzKDYe0i+Ca18auE4r/P0iEisQBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=O1d1dxvD; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xT0ARSrlOs0s7qJir2qDh4AiSKuyaQLSzIrVIFAShXI=; b=O1d1dxvD4ujW5HuVrtDdeLx8sr
	t85Hzzf5zrPSukGnOQD6ro/kzm7Tin/X0gD+9VffRz5pkBJt++04fvuC0CqlkIGJo+ExpIt6oK+UV
	lMFQuJ87DS8FQuiQ8eCLvNpJ2SZ+c2ofrckTLTCuaZRzbHDrPTAFyqNjvi+LdzpZHUbcgTgRCs1UK
	7Vk0DWGQHYGJJhTvsJuxKCdEJlCn9+zuZlSi3U2eT92pjbMPAU5hgTfOdX0kYTwuUpZLM/hoHVP0B
	85V/zlAtWoClOqapoN+3L580rB6rjAduNYqwVsFHgDado2jo7d/ltu0pY2IDL1oCpvo9/TmHfHFJ2
	XGBdPNgg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utixJ-00663d-6L; Wed, 03 Sep 2025 10:35:01 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH v2] fuse: prevent possible NULL pointer dereference in fuse_iomap_writeback_{range,submit}()
Date: Wed,  3 Sep 2025 09:34:53 +0100
Message-ID: <20250903083453.26618-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two functions make use of the WARN_ON_ONCE() macro to help debugging
a NULL wpc->wb_ctx.  However, this doesn't prevent the possibility of NULL
pointer dereferences in the code.  This patch adds some extra defensive
checks to avoid these NULL pointer accesses.

Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
Signed-off-by: Luis Henriques <luis@igalia.com>
---
Hi!

This v2 results from Joanne's inputs -- I now believe that it is better to
keep the WARN_ON_ONCE() macros, but it's still good to try to minimise
the undesirable effects of a NULL wpc->wb_ctx.

I've also added the 'Fixes:' tag to the commit message.

 fs/fuse/file.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5525a4520b0f..990c287bc3e3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2135,14 +2135,18 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 					  unsigned len, u64 end_pos)
 {
 	struct fuse_fill_wb_data *data = wpc->wb_ctx;
-	struct fuse_writepage_args *wpa = data->wpa;
-	struct fuse_args_pages *ap = &wpa->ia.ap;
+	struct fuse_writepage_args *wpa;
+	struct fuse_args_pages *ap;
 	struct inode *inode = wpc->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	loff_t offset = offset_in_folio(folio, pos);
 
-	WARN_ON_ONCE(!data);
+	if (WARN_ON_ONCE(!data))
+		return -EIO;
+
+	wpa = data->wpa;
+	ap = &wpa->ia.ap;
 
 	if (!data->ff) {
 		data->ff = fuse_write_file_get(fi);
@@ -2182,7 +2186,8 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
 {
 	struct fuse_fill_wb_data *data = wpc->wb_ctx;
 
-	WARN_ON_ONCE(!data);
+	if (WARN_ON_ONCE(!data))
+		return error ? error : -EIO;
 
 	if (data->wpa) {
 		WARN_ON(!data->wpa->ia.ap.num_folios);

