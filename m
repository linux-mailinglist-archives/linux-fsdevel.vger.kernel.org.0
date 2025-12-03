Return-Path: <linux-fsdevel+bounces-70569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47121C9FBA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 16:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2B4B30552E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CD23148CD;
	Wed,  3 Dec 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWO+f3/J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SK33/zEL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3DF313E00
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776796; cv=none; b=PyAGJX7gg9t8YbI38sB5YNoJ+b/otn0NOzEm2ia74LfZU+A23d0jyZwmFyA29Jqavc70JxDvdb6LwDWR95E8gE49vgn+EF8vq8+8ZTkOXY6INKxyQvsUcSgqp1mPonxzywq39l7vl7BVUmcEj2mmyQMFkL2AkxNyrZeOrjZaTLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776796; c=relaxed/simple;
	bh=B4xyzwDKGxq/vyrw5rw3MiyV1PFc/MXbtlIPEadsNuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nHrRH5ItOgVtsjIPT8M/vMxVbtrMLGghwPaEdXnldDIIocW6utIgkdCBbI9bVNmHLY3urOtfKRY9rOwkk6jFZkjZvCRPdLGy1DGZtgFVK3naNEWlcBHiTZxZJKMzZx00iFXb/UKxdyhRC2N9JLp78uMpVPgzWjaC4qIsWUao6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWO+f3/J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SK33/zEL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764776793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jcDCLLxng0aZwTmIpvTEU2QWfymaHSnvSLSvvAB+tII=;
	b=CWO+f3/JghCj33onIGawGOS1xA+cPdlT2Wd9BFQDiht5hqk8Nd7b0ard8jODDIvaEhCdYf
	HWYQxK/PGy7I8pndsDeBlf5dr5XHaGUWvFD4zTEggZVlf2P0FgHBj3QTI4KxuwBLzCM3Yn
	hrrLepH20MqTr/Vsy9EfKdL3ooCGOYA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-tFhWyoHcPe2MqLlADGPNjg-1; Wed, 03 Dec 2025 10:46:32 -0500
X-MC-Unique: tFhWyoHcPe2MqLlADGPNjg-1
X-Mimecast-MFC-AGG-ID: tFhWyoHcPe2MqLlADGPNjg_1764776791
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6418122dd7bso4798254a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 07:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764776790; x=1765381590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcDCLLxng0aZwTmIpvTEU2QWfymaHSnvSLSvvAB+tII=;
        b=SK33/zEL7G+KrfyP6TOMKkSAT4SebBBxoAVbnZVgRfElK2nrBfSgBBFpu6ZpUJfG8P
         d2FA4E0zUiP/ShY8X78U6MK9TAvr5G+4XzzMLQKUtOFcr0jM84Q/sO1y5eodEVqU5YHN
         1VNDsDqEiYKpmJayhAdKVafxStlh/dGSX35TfYrw6ZMWi/RK3k4Og+cHmDg42Yq4GtsA
         98TCvzIOASAcqYIPkjElK87npwiDbjiWH+VOefEu7cKWDk/f40YKC7CrrqCU6uyVVD57
         Ol0b3eFzdsU91JPrsSaDBTGBz5Aqpj6wz7vFiVA+AJoMcOdU3j/z83ASwOUucpkiU9fH
         FEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764776790; x=1765381590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jcDCLLxng0aZwTmIpvTEU2QWfymaHSnvSLSvvAB+tII=;
        b=H1OVYvTYAK/SrTC4e0sw3InRrBmlcB7Sh3ko3UuFKfyFGGKkH0fAe++eFUSxJEZOEO
         hdTX9OLFZDijaIvUDP8mJDNCbq5H2f1MbyuFQFatIalLgbL2BI+DPp2MTC+hPEZImFnq
         ql35tBQxfkGWa348LbURQUWPe1QCSrvs7eqWyqh+ApJob8Wxdpu0+rkqxaLrBaT34eHx
         +7DVcctD02yhulPrVCnm85+pT/r9o9KGgcLXiz517CHE8udhcmcBLopXf6t9X9sZkdik
         cPg9lkL9BmXOyb5zTNpEMZuTR2Eq82bgqvPgh/tRuwBQ/v2RoOS1wZABKvtGcTNYWDHr
         9vGw==
X-Forwarded-Encrypted: i=1; AJvYcCWIt1U27JyRoMfpVbYmCzUoU/Dj7HYKekmnh+UiimPuDTYKGHoL3W6quGYqEdX9yTHLTXCtxD/Rr/uRT1Rd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4a7rkcA/ap6Tosnn2B/6K1tm6QJFcTr0CB7E1bAOru/H+8xN1
	mN5qpLOntIZ1jOR+yWrTv5mM6+fcATspq7TFK99qmiRQz7eHpA+kw2jsrgIz51VTNqk1a0GlR88
	t0mpFywgZEstR+nsZpaKCuyJTn9qdb4JMf7+eRDyODIg2jbcjzUJuOnaiAyujYrj1iWizgaMJ3t
	IOXg9V
X-Gm-Gg: ASbGncui+9XArNXftYKDAuGJGz7pLsLUAXnQgmR/uJXkuJGPvAFoGzg5NRY69Zu2aTS
	KyaYQVIfAxmwnzxnYvHISuKf1kTRnhgOvo+pS25jJcSN4E8eOHbqq1Dq2fGxOgSvgBDPH6AP8XP
	IoAL5A9SDV1y0bVeSrcxf6fD+lFdEqUitjOzrn8WWe6CsdHvTn5IXTcAGH9tBVozUmbsTeBl4Zy
	8MFj13iY8rUiZi05lKT3FR2VQuxOgSnCEVOJrPcXavZLOjGZktykcRWoEGlsRkWljPBSxwq/6HT
	4QPChLPxwmsScwPEfVi9VAEAY4pSfcl5D8U6PHfCCXVrzUn1AKAugOOrsCCvRd1GbKwhVcno4Zj
	8mKoPjk67tY2WX0OiE3O7+nPuPUnGucrKjL8NdUw5KhM=
X-Received: by 2002:a05:6402:84f:b0:647:8538:fcf4 with SMTP id 4fb4d7f45d1cf-6479c402183mr2555706a12.10.1764776790369;
        Wed, 03 Dec 2025 07:46:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHf8XPvEtviQ30GSatb+QSZ7A+HucIfCe+SqgwX87rOJna9fxFyDW8fq0EugBmlvCF/L0ZbEQ==
X-Received: by 2002:a05:6402:84f:b0:647:8538:fcf4 with SMTP id 4fb4d7f45d1cf-6479c402183mr2555669a12.10.1764776789916;
        Wed, 03 Dec 2025 07:46:29 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm18529786a12.29.2025.12.03.07.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 07:46:29 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v3 1/4] ceph: handle InodeStat v8 versioned field in reply parsing
Date: Wed,  3 Dec 2025 15:46:22 +0000
Message-Id: <20251203154625.2779153-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203154625.2779153-1-amarkuze@redhat.com>
References: <20251203154625.2779153-1-amarkuze@redhat.com>
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


