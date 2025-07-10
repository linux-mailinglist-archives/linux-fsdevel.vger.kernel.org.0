Return-Path: <linux-fsdevel+bounces-54429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83409AFF9E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 08:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBAF3BB093
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 06:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586A9284B2E;
	Thu, 10 Jul 2025 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A+a7IWr9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5501821D3E8
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752129359; cv=none; b=elfDSErxIN+meNM2oux91QtmnB42B/mEm9X9vD1OrmXHJ9LegMSl5IGJl1HQz4E8EGB7OoDiIOqHD1zjMsJPNJMVBQRvBIy0SSvZ2CyG+MkceqI/F7HZ8h932KKR8kHme2T7R1J3ekDegvBEOYkvpZNcG9CGfizq+cFIRv0vAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752129359; c=relaxed/simple;
	bh=nhyZFQmEoyDcHjY2/BgSA4YyGRzsXCvZZYMkFleIIOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DkQ+GR3RZwlQurYSHQbGdNWCbXStk9zIcxfVaQiLB07GN1+hk+IigjT9IDwiYuHosMfYycu/XpvNrbEB1IyV0OjslhhJ3mrH4rkBxZHxEkTuqTjA7GJHMPyPV4z2fj6sHX1SMo8bN8sqrooh+0wKOcb+zLvLMD5JhFAWstyWOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=A+a7IWr9; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752129358; x=1783665358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nhyZFQmEoyDcHjY2/BgSA4YyGRzsXCvZZYMkFleIIOQ=;
  b=A+a7IWr9VfaLMqFiFPgDFMKvM1OvFk2Jk3JbGCNLVoHZOqkWtrMpLXpm
   nw1n6O1tQ9kHrAX+rRyVc4M+vTKijBKnkNZ+Tas6v0HFmVya6U8Qf7t5O
   AftLrMartPKkNs0vLMl6SAXsYxKiNGtEQU0KiCJoyIcX4J5tzTn9pYANW
   F+abZeMitd7V/XVNOjjXKTRbrjfYvlYk1mSvfm/5sCQ0R2fhVcExfizV0
   OAsr8LIt/p65JLv0OlWQwN4n/V4Kp8RdFkWB2vxG8b9780rwsOFxhMFl1
   Pmp33QPPlBkduqqIKslVGhVCIR+0GJi4FOKNh4XxqriJvK19auOVmHc4D
   g==;
X-CSE-ConnectionGUID: CGasTqWMQS6YnmlPFntH1w==
X-CSE-MsgGUID: fyRp5IljSGmXBV7AWo2bRw==
X-IronPort-AV: E=Sophos;i="6.16,300,1744041600"; 
   d="scan'208";a="91457759"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2025 14:35:57 +0800
IronPort-SDR: 686f50b5_donfnbCA14GOjbJZXjdrg7nzcN7t6MdalLsTQl2P377n5Bf
 L2AKs1+PM23MBPx3D3+X1mXhF2l3BYcX/OrNhyQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2025 22:33:42 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2025 23:35:56 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] hfsplus: don't set REQ_SYNC for hfsplus_submit_bio()
Date: Thu, 10 Jul 2025 08:35:53 +0200
Message-Id: <20250710063553.4805-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfsplus_submit_bio() called by hfsplus_sync_fs() uses bdev_virt_rw() which
in turn uses submit_bio_wait() to submit the BIO.

But submit_bio_wait() already sets the REQ_SYNC flag on the BIO so there
is no need for setting the flag in hfsplus_sync_fs() when calling
hfsplus_submit_bio().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/hfsplus/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 948b8aaee33e..8527e4ec406e 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -222,8 +222,7 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 
 	error2 = hfsplus_submit_bio(sb,
 				   sbi->part_start + HFSPLUS_VOLHEAD_SECTOR,
-				   sbi->s_vhdr_buf, NULL, REQ_OP_WRITE |
-				   REQ_SYNC);
+				   sbi->s_vhdr_buf, NULL, REQ_OP_WRITE);
 	if (!error)
 		error = error2;
 	if (!write_backup)
@@ -231,8 +230,7 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 
 	error2 = hfsplus_submit_bio(sb,
 				  sbi->part_start + sbi->sect_count - 2,
-				  sbi->s_backup_vhdr_buf, NULL, REQ_OP_WRITE |
-				  REQ_SYNC);
+				  sbi->s_backup_vhdr_buf, NULL, REQ_OP_WRITE);
 	if (!error)
 		error2 = error;
 out:
-- 
2.50.0


