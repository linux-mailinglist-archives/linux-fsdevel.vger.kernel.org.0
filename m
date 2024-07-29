Return-Path: <linux-fsdevel+bounces-24519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C01F9400FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 00:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB3A1F211B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 22:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4399E18D4BC;
	Mon, 29 Jul 2024 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBiTIg1a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F21653
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722291501; cv=none; b=ivj3XcNYNYucPIVDUgiYbesUD+e2YrVWCU9xTpgBmFNonBEJiJkCiEbkj3rATR14HfJDicc8yPLomoh9lXeHqImldScoYVcjTQj4AiUu0RrVXq0itjydBns8D43xG0vELzYbVim7xIn9SykKbyuwwK4FjdmdLiYE+EYbcXqBEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722291501; c=relaxed/simple;
	bh=3Qj2h/hS5S1t/VWm+2jBymaTMFccKG1oJEUb5XqBU7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aklrN3yc20leHrwxetPRv0NcAmR+xYaVe+010h5IuQY4LPxhg+TFHcYrGLAL5O4QYf46krphmhaYqrD1NYTFsth35/qUrQdwgiuZV1nbYWxWhSnPyjzDVhsXDgmFqTSPoozjN5dob/8pA/DPbTJfhtn+QKoDzCXEvLxjQai162g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBiTIg1a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722291498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GLhdkewoKu9olZ7QMCazkrxt78jf2sukd3GIhHzATXg=;
	b=QBiTIg1aU6MEPxSo/NWHNR2xnCDOoIh+Hr+F1t/vaInmnN/WPYe2FQ4ZvZ366uDQFFaL//
	vcbCrAGZDFvc2jYKV53/Bf0psKgHeXmaK6UXkHAIMS7rxuaRV1udTJ1Ai7recR9AGmmvm9
	bf8y/pq+Ohbi0A1oh1huuoZXvCO/8DE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-WioqWstcP3GN5PJBuMdpfA-1; Mon, 29 Jul 2024 18:18:17 -0400
X-MC-Unique: WioqWstcP3GN5PJBuMdpfA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280645e3e0so19975125e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 15:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722291495; x=1722896295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLhdkewoKu9olZ7QMCazkrxt78jf2sukd3GIhHzATXg=;
        b=AgCZgUOl/b5HFcDaf3y/InA3ADCeHP515DKFsg46QQIZrV2vx8rmB3xxDy1a38acYG
         eG4oFllT/Ri4/wVRjBeJcp9T7SYetZs50xrobsqYlSJ1mbXSMp5rjNNW28tomjeRLFr/
         q+yRVBCWchf/NsEsHLiWoPAoHTcg6tBFaWia8162TQAQhdIgeHKGBQgQb+XtsuhgR2Xg
         1K+03osFDwypDh2wHV5RU1TKQLwiDJmnTZQQnFX/ms9MnqagsQ/Vetxh/ReJFKBc1P2o
         NX6MonF7B5PZT5ruz+SHDbZkrqNvqz2h51LgudYgj21nyuvWLkCl2mgACF4eIcYeWFT+
         2v/g==
X-Gm-Message-State: AOJu0Yw/AdudJmcBaRXGb1VV/6sNK/6N3WfZwu6SFqKysurHxXlWfMZE
	sqtIvOjaEnqFgNrRFCvlQP/fesavDpIOXqqYiq5d6oLStxkAUNlrXsOBow8ncxck3bRfGSbl0J3
	yiOWPEiRbopisWVItd/72URckOEHT5pfxzQfiZyStsirKMQkfiWf3n58WwYSsEArTl1LHqIY=
X-Received: by 2002:a05:600c:5492:b0:427:b995:5bd0 with SMTP id 5b1f17b1804b1-42811dd08d3mr55960915e9.23.1722291495188;
        Mon, 29 Jul 2024 15:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcpA/CPpx8dwIf3lYomxNIPfJaCEz1klBoTnQLrs4U0DHGybfj2nssXHteItArGtbSQIQQbg==
X-Received: by 2002:a05:600c:5492:b0:427:b995:5bd0 with SMTP id 5b1f17b1804b1-42811dd08d3mr55960845e9.23.1722291494729;
        Mon, 29 Jul 2024 15:18:14 -0700 (PDT)
Received: from fedora.redhat.com (gw19-pha-stl-mmo-2.avonet.cz. [131.117.213.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42824130e43sm1477055e9.0.2024.07.29.15.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 15:18:14 -0700 (PDT)
From: Pavel Reichl <preichl@redhat.com>
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] quotaio_xfs: Fix memory leak
Date: Tue, 30 Jul 2024 00:18:13 +0200
Message-ID: <20240729221813.93878-1-preichl@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error: RESOURCE_LEAK (CWE-772):
quota-4.09/quotaio_xfs.c:162:2: alloc_fn: Storage is returned from allocation function "get_empty_dquot".
quota-4.09/quotaio_xfs.c:162:2: var_assign: Assigning: "dquot" = storage returned from "get_empty_dquot()".
quota-4.09/quotaio_xfs.c:180:4: leaked_storage: Variable "dquot" going out of scope leaks the storage it points to.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 quotaio_xfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/quotaio_xfs.c b/quotaio_xfs.c
index 2df27b5..5446bc5 100644
--- a/quotaio_xfs.c
+++ b/quotaio_xfs.c
@@ -174,6 +174,7 @@ static struct dquot *xfs_read_dquot(struct quota_handle *h, qid_t id)
 		 * zeros. Otherwise return failure.
 		 */
 		if (errno != ENOENT) {
+			free(dquot);
 			return NULL;
 		}
 	}
-- 
2.45.2


