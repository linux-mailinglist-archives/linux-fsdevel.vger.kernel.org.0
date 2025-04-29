Return-Path: <linux-fsdevel+bounces-47570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEBAAA07B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A975A786E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9A62BE0EE;
	Tue, 29 Apr 2025 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fVR99dWh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F392750ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745920010; cv=none; b=lMDMrQx6Olx2mWG2Q5qu2qVdrAz6ObVrNCVEIZem4XYsy0AzjMCqHv2sTyVTxD/c+w2NAny9jWRkFld5qtQHu3Vs6R8ZAQEXmbx5DLgrc7hWbDNteo3aURPvhNxAzjQqIabEe4/GzWfhgPuZG0H1oejauTB8wrtzyA2K3G3mPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745920010; c=relaxed/simple;
	bh=7h6TDK9XO4vi8HAwbxlZy15xoNWwk+1COdubrAjH45o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KL9hMJAp1HMGaGwHf43bYtYT6eof3P5Z+zN9+QBRjXKZ3BetGXaY69Cl9Rzn2D8cU+oRIKcp1+vtl3Mjtigd3m+f2yWWEYsS5FXcFYEztGyPMwj1xzvOTlVCvHz4n64aP4Wevrf7cxw25BnHZepDd17EWvcCGQigIBrfCDkoCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fVR99dWh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso65368065e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 02:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745920007; x=1746524807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/khpT6y/LHVtwUJo6f8G8UANag+DTR3Iq07zRFJyCJk=;
        b=fVR99dWhT4ZmLV/m1Fy1r2GhgFtAdO8896BH/FSAQSb3Vi53RsatZd//UBQhOd1b3i
         tEdOb9S57/nTn9B9MM3tDMYgtpkxWugS01p5TKk0WJWdICd6vd+0PO3nrS/f1OSBtIbr
         2wKVsQzrZm3RmZ9/tMr217vvcBX3LWZ6HN61zXAoDL0p6FjOLwTcI3cDFPcamwF6EO/m
         KTZmZd7dQcbeSTB3YJazQfVdxkdmdo5akmsur/Ncx9/GgW4IGL6f+775FlMbK8nCQeXu
         p2M/bGjfWFZDbKJcO0fsQnp9AgTiQtLsht7wdtLtM0ug/C5w/16IaZW6+QvkThHpQ2jV
         owqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745920007; x=1746524807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/khpT6y/LHVtwUJo6f8G8UANag+DTR3Iq07zRFJyCJk=;
        b=OsAbN7XsJASEU4Fy0JAHvoGsVSASOCrjUm+jTHKt9W+RlfEklnIwJYKlb+2lpGTwLB
         aWnRP55rM7J3yUe3ZHzILQnf90xWOjvEqCg+YGQ18yg3Dbg0jHvQO0t6d5X6cakDByhT
         14YGI2kFbMl83YN8vBwiWGX+KAfXHgSbHxJymmL+Ga3iNEOcexlBM9BjH/akG6LQWBwn
         GGh2vNCDnIOOs9SOqSQU4ELQH44Bik6oWBT5sIZO5WOAWA22LLGp4sLEGHRhEVgvi1l+
         gNKki01m+wHQo/wFDgatlVieEhfwrtuCU0M3SCnuxKJ6e2GprR2k8WUv1+408uNdt/8Q
         vGeg==
X-Forwarded-Encrypted: i=1; AJvYcCUNtOnODXJvdjCsti4MYUMJDxhpVDxq6FSeCRiW9fbpdmS6Ex/LOVJThJEvhxGdRBZcvyHKhuCUdmERyixa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5q9LJCHSZYKoy4Q1uw196QgQBdCY0dXBE0c1PFej9mH7JC2Q9
	lHlMQKzHX1weY9FhsXrqbTxG42IbC/4tNpJkiuQ+qEvrsnyPAM63Wznfz87A5FQ=
X-Gm-Gg: ASbGncvrUdUdCr9ckL2f6EKQNqLtwRG73HeInfY+BCGP0NLJVuXy6BpBLBGzKPzCF3R
	2t6gs19RAD8WVxFtArjd5IGkbAplXx2hrhtIT2Mdf/KLEovecXrL6xJyUIhVId6ISHvph2sbEfQ
	1rgYvJUR48gLXSQFRSVeJAOV13scYJ2AHtAB+UCjq2ZyUEMGKhdCcRlvXJP4/6G1SEygCnRFNWr
	CeYNNMkCQjTUcf9Vt4e4NV7JOMGD8ADUuQj+mU9f7qiA2zmTDrbN0pQ62h+iEEGPYNuWK8kUV7s
	pL/SKLRg5xqZAejQ8O+xUmdTf7cmvlUA2c/yEhV0oOQhzoDX877W2Thd7c2syzkCPtBkBcqU7ie
	MqBvAQ0F3+cyILa+m/3fHTbl00oY/+xckr4N8tmAP
X-Google-Smtp-Source: AGHT+IGmkb10LLUhYY7LbhpZXzXXe/rQSihIzdVs5Dw8ilO8bgW8q/PStbCy/K14wLZtJipqod7ONA==
X-Received: by 2002:a05:600c:4e90:b0:43d:22d9:4b8e with SMTP id 5b1f17b1804b1-441ac856140mr28432375e9.10.1745920006689;
        Tue, 29 Apr 2025 02:46:46 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a0692a22sm169766855e9.2.2025.04.29.02.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:46:46 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 1/2] include/linux/fs.h: add inode_lock_killable()
Date: Tue, 29 Apr 2025 11:46:43 +0200
Message-ID: <20250429094644.3501450-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for making inode operations killable while they're waiting for
the lock.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/fs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..5e4ac873228d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -867,6 +867,11 @@ static inline void inode_lock(struct inode *inode)
 	down_write(&inode->i_rwsem);
 }
 
+static inline __must_check int inode_lock_killable(struct inode *inode)
+{
+	return down_write_killable(&inode->i_rwsem);
+}
+
 static inline void inode_unlock(struct inode *inode)
 {
 	up_write(&inode->i_rwsem);
@@ -877,6 +882,11 @@ static inline void inode_lock_shared(struct inode *inode)
 	down_read(&inode->i_rwsem);
 }
 
+static inline __must_check int inode_lock_shared_killable(struct inode *inode)
+{
+	return down_read_killable(&inode->i_rwsem);
+}
+
 static inline void inode_unlock_shared(struct inode *inode)
 {
 	up_read(&inode->i_rwsem);
-- 
2.47.2


