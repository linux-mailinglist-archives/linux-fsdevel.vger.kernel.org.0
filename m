Return-Path: <linux-fsdevel+bounces-78588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UL8LIVSJoGlvkgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:56:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C521AD0EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D903356FA70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC69449ECE;
	Thu, 26 Feb 2026 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtcPq9Nc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E142982C
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122171; cv=none; b=HU3oJREd0T3PJP1sYC2YALB4tOI70k2q8UbBMweD9/7w7BkqaeHdXtw+4AYSpo//IT+PfYeeWH3WVZIi4udddTgGRmymqpBOiiivr6PO+fiPdwQV8QcV0RvdPirK8DCKD/s5YS+mYbSi7hCjDclIYBsg/dItjzsYE+Z35w2bSdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122171; c=relaxed/simple;
	bh=V/GXiRpANGsEMhYKzBOchE0smCbiEsiW2zG9TTOtkjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmJFSP8FTez13IyU+i9/FxbZJkyY5MEC5zpGd+CueQWfAHESZBnvBDKs7YVcQzxqeca90z0+UNlLgdhtxKf0IlXDPKjxNx0CBUBfbLK4bevc3BHWoKl/TCEqU9Ur/12AweD5NVNSjEfrsMNDrKRVijJXXTLQ2YdY1X3TgsgBTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtcPq9Nc; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7985d11da10so10201267b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 08:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772122166; x=1772726966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqBzIH4InHJCj/l4Dt60MIlWrD3B8yAylq+UyEFD2Hw=;
        b=BtcPq9NczadZlyXkSbt2xvrdHNwagek20lgJEJ2dc8DUAF+ibkYwUzD47TKBwrRQ8a
         Gdf1U0v8B3tFspkrHzxicXTI5dcy4XJrYfrl3MrDk2+XY7ljV+RzAyvowkHYPdphkneN
         OY+SPzjxbSYbyRx6apfQWxnYAxoI332KQCZtFPXwkhktdljq1khu6FbmNcOp3h4BY0AG
         1sVKNDDIt+chEILQjFzg+Nw/2i9IzhIImL/ydXknddOeNnbojgOYQY0s6VjLr3rg5ZHD
         XkhAWEyXuq8fxkKooFrPGj/5Dg9MzuxuxZDcXnW3KkzEVmBOCs1c0mInVPDgufn1Io5X
         7YhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772122166; x=1772726966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cqBzIH4InHJCj/l4Dt60MIlWrD3B8yAylq+UyEFD2Hw=;
        b=oy8b+Flk6GDmHl/FKF75zoyoqdZzRuEpiipEV5y/AuWBcU4p9fWLFL0tpCZXZ43v+Z
         xuRwxSpAt8yvKviagwq3iwHCPit0MHNkOBRgDWSPWPZ8mu/a5R1qNgmBgBtnahjbTmKt
         PUp1k+cuveXxQrF9SJ0t3iS0Q/3xsYRzl8DlqwDPAPb0IgKPTWXMJIQdShfShOLtvgqW
         TZJKHXYg93YSESqDqhHKRNU5C2lvk5+kUmyFWy8l3CBc9piDPMHrLEKxs6erNN628bui
         8Hm+w5bKZm0pklbz980Fp4pVBWyZqMpON87GBZrg0rmpIyZKqAmF5+g3w+VUP/ajZBHH
         jp2A==
X-Gm-Message-State: AOJu0Yx0Krj/U9g9BUFF+q7GvrEgBNN2j3TrB226qPaz0em4VVdirHKR
	21WotZNtrsWJVpiw3ubi9j73ijmv5S+AUfUnKVgA1W1CjDmdO+z2V1j6
X-Gm-Gg: ATEYQzyyktLhSPdjgtMj24k9mZ86+gq7KvujdDODWfq/cz+s+nMI0dSbZl9MAgprrVK
	+lhWn5oh7gFbLdUIWPXtd2vWUQExi+2NTTH57NueFiS9VS1yp0iHvBS+S0TOtfIZQHgKxIzL85X
	WM0vCIqlMmx20QzA7PdVNC1nXjPM09z3NE6ZTmCCMY/fekdtYd+Rt1qrRt6VZwLqHeCiQlDRnA7
	3W8mbLvzmd3x6F/GiYMdRgSXWvUkgf+jKswcuOxia6fH0BW4jMG9ElFtmLp3zZSm4Tt+ZqNCH7t
	uP3EYXWjwjxWeUciKZb0pfJcps3ya/Axei/n4r2YihDU14FUkStk/5uPRez9DEFwNoDCau0UbRG
	XYt5kIGrDHKaVuhtGjHIgGxy73Wgp3Zg1XO4k5L7119NcHpF0QGm2nwJwGCXIdDrrs1WnO6LyCG
	3DKSyupXcNgPIyXK0/2gFP4se0ci95cSRtPEzKa0Ubh4TIaArqTjXZt8lhGxRDsSovMtZuQOxH3
	3rWRZQyP0BICVaGIJ8zz+Kj
X-Received: by 2002:a05:690c:d83:b0:796:6da9:bfa3 with SMTP id 00721157ae682-79876bcd9bdmr20581847b3.7.1772122165932;
        Thu, 26 Feb 2026 08:09:25 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876cb9f19sm10225967b3.53.2026.02.26.08.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 08:09:25 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 1/3] ntfs: Place check before dereference
Date: Thu, 26 Feb 2026 10:09:04 -0600
Message-ID: <20260226160906.7175-2-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226160906.7175-1-ethantidmore06@gmail.com>
References: <20260226160906.7175-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78588-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15C521AD0EE
X-Rspamd-Action: no action

The variable ni has the possiblity of being null and is checked for it
but, only after it was dereferenced in a log message.

Put check before dereference.

Detected by Smatch:
fs/ntfs/attrib.c:2115 ntfs_resident_attr_record_add() warn:
variable dereferenced before check 'ni' (see line 2111)

fs/ntfs/attrib.c:2237 ntfs_non_resident_attr_record_add() warn:
variable dereferenced before check 'ni' (see line 2232)

Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 fs/ntfs/attrib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index e8285264f619..e260540eb7c5 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2108,13 +2108,13 @@ int ntfs_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 	int err, offset;
 	struct ntfs_inode *base_ni;
 
+	if (!ni || (!name && name_len))
+		return -EINVAL;
+
 	ntfs_debug("Entering for inode 0x%llx, attr 0x%x, flags 0x%x.\n",
 			(long long) ni->mft_no, (unsigned int) le32_to_cpu(type),
 			(unsigned int) le16_to_cpu(flags));
 
-	if (!ni || (!name && name_len))
-		return -EINVAL;
-
 	err = ntfs_attr_can_be_resident(ni->vol, type);
 	if (err) {
 		if (err == -EPERM)
@@ -2229,14 +2229,14 @@ static int ntfs_non_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
 	struct ntfs_inode *base_ni;
 	int err, offset;
 
+	if (!ni || dataruns_size <= 0 || (!name && name_len))
+		return -EINVAL;
+
 	ntfs_debug("Entering for inode 0x%llx, attr 0x%x, lowest_vcn %lld, dataruns_size %d, flags 0x%x.\n",
 			(long long) ni->mft_no, (unsigned int) le32_to_cpu(type),
 			(long long) lowest_vcn, dataruns_size,
 			(unsigned int) le16_to_cpu(flags));
 
-	if (!ni || dataruns_size <= 0 || (!name && name_len))
-		return -EINVAL;
-
 	err = ntfs_attr_can_be_non_resident(ni->vol, type);
 	if (err) {
 		if (err == -EPERM)
-- 
2.53.0


