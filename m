Return-Path: <linux-fsdevel+bounces-44139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B201A63426
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 06:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376F93AEF12
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 05:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACDD1624E5;
	Sun, 16 Mar 2025 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="rET6U5aV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF1D85270;
	Sun, 16 Mar 2025 05:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742103255; cv=none; b=l9tvssy6qwGRKbroL6QuOymXMk6MMh5Fda5GciOJ5doTqFG4UkPaGgzDJMxUaUgTiiFhdxHhFnGHozM8EG4XQS4kMLG22LKlgMbPxIdidYYHpuFmdxCfIgndXDKSmx9wz9lH7hnzoJ5ee+HDA4jBcxGOgF7yPTc/9e5QLbXexHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742103255; c=relaxed/simple;
	bh=oGD1s/xNa6TBgsHChGC+t1D6VjHoYtHDt6gNPcPBSHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S8GOa7A8GViwCDpsFHlYxtSdykFAaczhtaDfVl4ZgElWltfX9YxE3Za7w/CcOwFmoku7ORNxYrrFKecZ4cP8rGLPen4vAeTDnjf4r7efKGbP2Aqd4GGU2dEOemqpqt5Axq9xGeyQ3Ncbmu4muU0U3PS2jroQ38trQlNmJA9ME6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=rET6U5aV; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZFmxR1Rmvz9sQ0;
	Sun, 16 Mar 2025 06:34:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742103243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w7sA28uhI2pO2WI83oBigupHnrWlvDC82flU/T+GvL8=;
	b=rET6U5aV5NdgHJxCDAFm5ix8iT3kxN70ItALnYsAIYOTerORS+deqO7URe8+43EvvT69dq
	Z4A6L4Xi3Y94rF1weikZ9f+DeBAQzFxrIIcocIHl0T1oIt7jhBKu0z+Ys9Mkh+lwfa6903
	2DTuNiXwjMNS5tSO+43w5cEk8qp1rMXnxpYQwFh4X6QLVbWVBOVI5eUmaBQbiE5N5i0ELf
	biKOu5Hk5AVTQ+TDx1RoQQ4FgQeVA2S2+JDKaFLa4TvufZIzu1GC1j6FIZ1/VhyV7FDNvG
	JtwO84LKROgKpGHZILfC2sflOcXrbKL8QZMpYTm4u6THqcZlMBqdBFXJiDpJ+A==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sun, 16 Mar 2025 01:33:59 -0400
Subject: [PATCH v2] ext4: hash: simplify kzalloc(n * 1, ...) to kzalloc(n,
 ...)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-ext4-hash-kcalloc-v2-1-2a99e93ec6e0@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAMZi1mcC/32OTQ7CIBSEr9K8tc/w00pw5T1MFxSeQqzFQIM1T
 e8u9gAuv0nmm1khUwqU4dyskKiEHOJUQRwasN5Md8LgKoNgomOSd0jL3KI32ePDmnGMFgWTTEq
 t1OA01N4r0S0su/PaV/YhzzF99onCf+k/W+HI0WguhR1aLdTpQnM9Ysm9TXL5aOMT+m3bvlc18
 PO6AAAA
X-Change-ID: 20250315-ext4-hash-kcalloc-203033977bd9
To: Matthew Wilcox <willy@infradead.org>, 
 Andreas Dilger <adilger@dilger.ca>
Cc: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=oGD1s/xNa6TBgsHChGC+t1D6VjHoYtHDt6gNPcPBSHg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBGOUxPcjc2YitFYjA3dXJMMFY0TmNROTlOZysyelB2ClpLTDBwTmVwcmsraUQ1eko5
 UkhzS0dWaEVPTmlrQlZUWlBtZm81ejJVSE9Hd3M2L0xrMHdjMWlaUUlZd2NIRUsKd0VSS3RCbit
 xVC9iMkxNalpzcm5JMnRYSEtsNlgvS0pyYjl5WFZvMDk2bWQzTzJHdS9pRFZqTXlIRTdOVERpNQ
 phdDdsQlo5bnNFck1GR2xZMFZ0MjRXcW8raHo3dnhyMzc1MFM1UVVBTGVoUnl3PT0KPWJMRm4KL
 S0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4ZFmxR1Rmvz9sQ0

sizeof(char) evaluates to 1. Remove the churn.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
Changes in v2:
- change back to kzalloc because sizeof(char) is 1. Nice catch. Thanks.
- Link to v1: https://lore.kernel.org/r/20250315-ext4-hash-kcalloc-v1-1-a9132cb49276@ethancedwards.com
---
 fs/ext4/hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index deabe29da7fbc3d35f674ff861a2f3b579ffdea2..33cd5b6b02d59fb749844fe481022f5f44244bb6 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -302,7 +302,7 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 
 	if (len && IS_CASEFOLDED(dir) &&
 	   (!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir))) {
-		buff = kzalloc(sizeof(char) * PATH_MAX, GFP_KERNEL);
+		buff = kzalloc(PATH_MAX, GFP_KERNEL);
 		if (!buff)
 			return -ENOMEM;
 

---
base-commit: da920b7df701770e006928053672147075587fb2
change-id: 20250315-ext4-hash-kcalloc-203033977bd9

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


