Return-Path: <linux-fsdevel+bounces-71978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1373BCD94DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 13:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B1A230463AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 12:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24963385A8;
	Tue, 23 Dec 2025 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPmUhukL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmeTWbfb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254E3338929
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766493322; cv=none; b=MTt2gCpBodaKlf0TJFJzCEcOwiTG13WTL+qQ1/s9K/88xGvWrMBMak2a3ugK9g9LeKPxcneW9x3v6sPyI+j/uZhHS1VB7L+Pnp0pJPQsiTwDHAaKLTYYMefDhNvR0dmsdDBDsav1uNCwrrpeSQhBMWFWGeqjk/JMwHO3YjbQzj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766493322; c=relaxed/simple;
	bh=B4xyzwDKGxq/vyrw5rw3MiyV1PFc/MXbtlIPEadsNuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mq4GDVgUCKH4g3lRBDCxRTUyKapk461esc4kRkiOD5+OlXfiEyPY/iBRw3m/V0OrBQszOUTWifB3A+20QKFmpAaELoA1jLO+olRzZGHTi1JaFOQjGKOjA3xz3A6BSaBGgqyaQhRWMvCuX/WREYrakYmzRGGnnm2I4PAMlXFvJxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPmUhukL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmeTWbfb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766493319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jcDCLLxng0aZwTmIpvTEU2QWfymaHSnvSLSvvAB+tII=;
	b=HPmUhukLm73eOAeqE0V5YujP/jNLNWKte1UWe/dyyWL12ZlPgGu2Eob3VWSWPqRJfYji1S
	Z8/V7j4E1oU3qFrWzbC1qvLNBL5zHPl7Mu4zduKx80HZFImQaW4N5EQPVSiUL0u4vcyyaI
	0oQLq59GsAiR6q8Kq9sciQWZEheatvk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-2xdxFbYLNxioNoPz8IYW-A-1; Tue, 23 Dec 2025 07:35:17 -0500
X-MC-Unique: 2xdxFbYLNxioNoPz8IYW-A-1
X-Mimecast-MFC-AGG-ID: 2xdxFbYLNxioNoPz8IYW-A_1766493317
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b726a3c3214so379223966b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 04:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766493316; x=1767098116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcDCLLxng0aZwTmIpvTEU2QWfymaHSnvSLSvvAB+tII=;
        b=fmeTWbfbgVJoJMDuiSRZCwCXMQiikuA/IoAACTkk7uPGtohWm3gh/WrmCahH4TysOZ
         aEWHxKNhULlkaPLjN2JMuBYS/qAd3aTmCAJIzz9bM1AuOtSkcNMFmUHfYK+wgzknH3U7
         BQW5Xc9iP/xpVgVlbZj+pnkyzGF7kl4pTxgqp+6edsY53NhFVA0wgg0k1rKk57WHpRtE
         Cs/Zck95WG2B3BFN/t6Q9lBvuecez3e6jOXOtgeuhz0aLA/w4aWaj6nfmbE88f/fWEjL
         EGdQEhElIQR8o2c81TYpr0h74qiK4Wu7xMszP+cEP4a0ZQjrvp16L3dHZv3xziHg7AnM
         LtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766493316; x=1767098116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jcDCLLxng0aZwTmIpvTEU2QWfymaHSnvSLSvvAB+tII=;
        b=bQNDsRV/Avx3kbk45iRk50+yL8aNKI8v4qOktvK9apbppIlFLXSGva73j6r2rluS7W
         KO1+/os3nIyPiVxcMCmgqS00egvOSQltn7+Fu71bXON7gmOxOBJ+ZVpqfOpHCRGEaOAo
         NisbdyQVl3vB78jExUTd+AkYxZ5ycVhkzKdPwXv+0nNz1mIH9f5/6wiVJu8u6OKcHeqe
         2DxScBvW/4ko09hPbVMe8x8LY5sBqJN4IJ/0gLMlcIoAA7hIH8UuVl0Y1bgDBK4Zccdo
         N4wB6i+PxFOWxDFSvDNu4cyuauARes1/kbPCobBSF1qJb42WZrpg3AMJv5Zao/tlTaL1
         mK0A==
X-Forwarded-Encrypted: i=1; AJvYcCW0WmAm89Y0tH63SyNbgza3MyLMx+jL8WauE9QtAXJHVgeVzQ78fb7T6x5cOnrmHDcR38OeESzkK7NYoZ8G@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoe+Uf9G/zV9OZngY/MrCc7GzOt3HGpM/JhxV+/VKBwOhmoQoX
	iyt/XznRd80iAKMR3zn7Tgss6yVQAg4+yeacvNdOFAoBK/D8guRdndXwOWTlNPeU9fxqYTo9AGY
	uOlzeZPdchhwQ6qrVfppkKF3sI50bnyYO9IqZTsUSAXR81EbZuJVMCzYkUoCttpM5wbOygubnDh
	4asg==
X-Gm-Gg: AY/fxX5CQKOpFrYfsseeYYPk8AduGPV/+C7SHqZVDo7B/t1EaPPWjuglB/+fQPGXZMI
	BvPw+N78Qk0ntqyf5SGb1tdREcC/qaQY4N52rzMvNWsxHz8CRhcEtxj2A/TBRPvUGJlE4kOjioB
	wjCBJusppuYkK09FahlG9mlOXdy/qRXPy651m/XbvSiyYjTPjdJwvAVcfKAxnzczLE10m2zXLE5
	tWAe2QdODp13UcnrVMN6ifoRmvtq6KDw1N7hHR1O0hhe6mKF7D0kMhB/RAzTGZtgLeTdkktifBB
	NM3fK3VHN0FWNRcAWN3VAHYcfR25hwK/rsguV+z2kJNkhB+TfEcUBp1VC26sa6sPh2VykYcEnjo
	PHT95RAYg7JVuNsfB86UhplBh8aRazkzbk8+NrRp0WPQ=
X-Received: by 2002:a17:907:3d42:b0:b73:a0b9:181a with SMTP id a640c23a62f3a-b80371df391mr1542382866b.54.1766493316384;
        Tue, 23 Dec 2025 04:35:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExrun+Zq0TkoEnG1zYuJwmjwgqz7edHNFpN5rqW3xzlyjFGy/KN5Wd1rXi9RQhM5Hdz3CgBQ==
X-Received: by 2002:a17:907:3d42:b0:b73:a0b9:181a with SMTP id a640c23a62f3a-b80371df391mr1542380666b.54.1766493315965;
        Tue, 23 Dec 2025 04:35:15 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1353357366b.57.2025.12.23.04.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:35:15 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v4 1/3] ceph: handle InodeStat v8 versioned field in reply parsing
Date: Tue, 23 Dec 2025 12:35:08 +0000
Message-Id: <20251223123510.796459-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223123510.796459-1-amarkuze@redhat.com>
References: <20251223123510.796459-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add forward-compatible handling for the new versioned field introduced
in InodeStat v8. This patch only skips the field without using it,
preparing for future protocol extensions.

The v8 encoding adds a versioned sub-structure that needs to be properly
decoded and skipped to maintain compatibility with newer MDS versions.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 1740047aef0f..d7d8178e1f9a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -231,6 +231,26 @@ static int parse_reply_info_in(void **p, void *end,
 						      info->fscrypt_file_len, bad);
 			}
 		}
+
+		/*
+		 * InodeStat encoding versions:
+		 *   v1-v7: various fields added over time
+		 *   v8: added optmetadata (versioned sub-structure containing
+		 *       optional inode metadata like charmap for case-insensitive
+		 *       filesystems). The kernel client doesn't support
+		 *       case-insensitive lookups, so we skip this field.
+		 *   v9: added subvolume_id (parsed below)
+		 */
+		if (struct_v >= 8) {
+			u32 v8_struct_len;
+
+			/* skip optmetadata versioned sub-structure */
+			ceph_decode_skip_8(p, end, bad);  /* struct_v */
+			ceph_decode_skip_8(p, end, bad);  /* struct_compat */
+			ceph_decode_32_safe(p, end, v8_struct_len, bad);
+			ceph_decode_skip_n(p, end, v8_struct_len, bad);
+		}
+
 		*p = end;
 	} else {
 		/* legacy (unversioned) struct */
-- 
2.34.1


