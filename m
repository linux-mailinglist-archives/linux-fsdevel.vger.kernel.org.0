Return-Path: <linux-fsdevel+bounces-44126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1086A63001
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E493A189368E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6284204851;
	Sat, 15 Mar 2025 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="Um+8Qf41"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95F18EB0;
	Sat, 15 Mar 2025 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742056186; cv=none; b=WpwHUiOWIOMIwHnoiPk1Fd/D33/eFuJPi059w4PlSwJs89Ay1B4CUrL/htXp77cAJ2zaPYx77WoG+vLm4NSZFvJd+F5KbcZxKjdW7cM9ZcuEgzf/1aDrntqNxCGHJumHYYWcl/ndRyT0vGpm0KczM7axhYfV1QYubEeBRhDRT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742056186; c=relaxed/simple;
	bh=8vJXzyaQxkgbOcUUR87Kt2S7V5pydAm0KqlwcjOWcRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HH1FmTDZtZx5p0F88B2qfSPf8CjcFkvm1xuFbobr9WwkOqiCHL0VB+JF2dsoGS5bGS4Krk8OE13z40ov4GYfsa4E5X65I/29Hwp4I9jskZg16iRqpxOjuyZAxXdGV+htY0QZsRPpf14fhDTixIpsZxIKvyJYOzqKrA0y3tdPWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=Um+8Qf41; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZFRXL6pX0z9sWp;
	Sat, 15 Mar 2025 17:29:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742056179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fmVK8GPId0IRUuWU4GHSeQ2zxJjlVPvROrUh8P67LzE=;
	b=Um+8Qf41oTrmnTS+ZEEq07LW3ATiYaYcQFRZBSAYriXtz5gfIIqg/w2PMz7fQMRBCvkM3E
	FEMukr0FOdUhdOujbiqsM7IVoVDN8VK+zKBNEgYI7klUCkU9Y/t7WYa1eXsHEDP3fpTdKH
	3VVBOczvTM4g8SjGX53NRHZG6aCW89cBuAcuoM/zJwbD1ZXRWkAWB5XNrdURE5dsLprR8G
	TsgKHmU2SFk2ZNm+XFV7q2ZJAdyVKSfJeV3WH1y84Wg7QqikeZCJSo50Rf5VibBLrRa2Pq
	yRwl+uAgJc4xyKsnoA5e5DXsPoyqDmNng6zQhaO7+lZAT3RPX/Q/74Jk1bhdgA==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sat, 15 Mar 2025 12:29:34 -0400
Subject: [PATCH] ext4: hash: change kzalloc(n * sizeof, ...) to kcalloc(n,
 sizeof, ...)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250315-ext4-hash-kcalloc-v1-1-a9132cb49276@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAO2q1WcC/x3MQQqAIBBA0avErBswLcKuEi3MphySCo0QpLsnL
 d/i/wyRAlOEocoQ6OHI51HQ1BVYZ46NkJdikEJ2QjUdUrpbdCY63K3x/rQohRJK6b6fFw2luwK
 tnP7nOL3vB0szHIdjAAAA
X-Change-ID: 20250315-ext4-hash-kcalloc-203033977bd9
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=8vJXzyaQxkgbOcUUR87Kt2S7V5pydAm0KqlwcjOWcRw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBGOWQ5YTV5V2ZUVURRa0xmNTZWTG1FL2Z1THpydTNYClpWeGlabDNwbU0zOFVPd0FT
 MWh5UnlrTGd4Z1hnNnlZSXN2L0hPVzBoNW96RkhiK2RXbUNtY1BLQkRLRWdZdFQKQUNieWNCdkQ
 vOEsrZlcvbVhWUGxaM0VPUHNlVWZldE0rKzVmeDdaclpLVUtYSGtWMzVtWTBzVHdUOEZoV1diZQ
 pneFYzcTQ0NktyTzkvQ3o1YzJMRzdFenVZeitkL2JiR3NyVDFzUUFBVCtaUjlBPT0KPTU2a1UKL
 S0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4ZFRXL6pX0z9sWp

Open coded arithmetic in allocator arguments is discouraged. Helper
functions like kcalloc are preferred.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 fs/ext4/hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index deabe29da7fbc3d35f674ff861a2f3b579ffdea2..7a9afac1597c69f319f02bb816ca797d32c188ca 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -302,7 +302,7 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 
 	if (len && IS_CASEFOLDED(dir) &&
 	   (!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir))) {
-		buff = kzalloc(sizeof(char) * PATH_MAX, GFP_KERNEL);
+		buff = kcalloc(PATH_MAX, sizeof(char), GFP_KERNEL);
 		if (!buff)
 			return -ENOMEM;
 

---
base-commit: da920b7df701770e006928053672147075587fb2
change-id: 20250315-ext4-hash-kcalloc-203033977bd9

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


