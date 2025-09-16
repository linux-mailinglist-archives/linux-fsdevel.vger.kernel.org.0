Return-Path: <linux-fsdevel+bounces-61684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1747AB58D56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FAB522910
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 04:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC12E0905;
	Tue, 16 Sep 2025 04:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2+2k+jV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6A23F421
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 04:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998131; cv=none; b=WWwKtrreoj2kVtyWns4GuktY73ZV6s5mgV6l62CiDJWVEKiNvV4+TFDBjk4U2z+wyS61hpWqCD9/IuZE5uR187LXXnJ+uxVtC31bRDGddaXDqmlzXlJV0Tn58LcLP87aPYC0vMTHeTWWnb6dsXvcAze5nara2n0X8uySYxMkYYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998131; c=relaxed/simple;
	bh=McKpF5pbp0B08HxMwaOQh+77moGljXjpv9ExEqMvqrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O1ammFMUDD0QykLRGNYHdtMkS4rAOW3dlFaaEgCUpHQrhOtoDKGxQO93oF3R556O4+84cZS6NNzihZjaNRJyodgzbf4v/ubay0sL3Ho2nXXYifUkXzcs7XHzjDCBYhtyzcvT0iM9Wb+qdkAtikNc1AiYoyGmQL6Njl4G1TIebnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2+2k+jV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-267dff524d1so63155ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 21:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998128; x=1758602928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdSOTRlpcbSm77LoC5qTO7Qj2WXZD3913QNmAyohauk=;
        b=O2+2k+jVZntCb7zJd1I4vKOIfI1x2AzD279l4mgf1siqgFA6wQ+gkvdnTs2TXMhR45
         nMbk2OqwimFG7lIiilmDOYvCSNM7JyUh9ZsGoek8tSfM1VJnGVW+RgD4mZxLdZg9p+2B
         npunk42XRZRwmJOxM+d2MO+rJuqiRdipjIc38kXi3DK3H1mI4SUtTLMXDz4jY6anTpQa
         riNUznnJDu3LM25qeH93YMB7E/QrGJ5eWtAXuttwKoEypDeQK9aSZepg/WTSli97oOJz
         DcDVgsxufbnor4ddJDyCdRPHsnnnAuqMkfsqGKZCMCzBAjbdgRR+OnY9f3jLaVAFuZWB
         mCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998128; x=1758602928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdSOTRlpcbSm77LoC5qTO7Qj2WXZD3913QNmAyohauk=;
        b=o88XaKUdRHR82do/w2eRdZB1Xsj99Kh3uJqA7yJW8psifX+z0sNth0/X8RCL4ZvYTk
         3hAthJoc1G7CFueiWGVIvj4FwYj9XUbU34AoQT0dhFHpKP2kMRgNNKE3L9lkhIgAB6tj
         o6gIBBr79ISJQZbuPQ5bdgDsl2q1U7rRsjKo76PIaESMpoZPsNNjdy2AVgp9wv2uO031
         6w2UVrdEM5ETghzBXW69kaF+Vc6mbgTlssQkj3tR4K9r2djr5+I6S9IvCc26F+y5j3+S
         CR4HzeBzcJgYzC3kc7iOH0fhP+w4cztw/w3P338T5ngn9w7SBzlEh44jNuXmBtL1MPDo
         a71w==
X-Forwarded-Encrypted: i=1; AJvYcCVYrVyyrYdNMaBa4yqPhTbf2HiXjV9MbK3OGk0SmwJ2Pw1R2U/un84EWmccvJUagmBPY9JPoHyjuBegXUAw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Ej5/wCAjModQARSPoUS9mCjXgyODSyfdQOF+kF4sRkrLKjWM
	1TwOfnGVEdlMPlumQH3cr5ayHDn1w6DS1G6H1K1e55vQInTHyX/r+MQ8
X-Gm-Gg: ASbGncud2nIsuRtLlDD2ujGKBwDpHlXLYm3fCYj8TFas87nDADcCm9BUoPy7ofivKnP
	Mnmubqf67VtG4+94M3tiEcCY219NbcSgKBn2s6nVg62LjsUnIvpv9kEi/0k56MFOq0KvuNvkIto
	o0JBDYpXK7j5ZWK7p3csjYFuca7yeKcMFPpIe7E5irU4JSHRVc/eXFUiIloElAP4R/ySFYdXvt/
	RWy6IOScxCf5fo75oWZ1fNjijfI4/DeBYg4+K6cc+k+Zqy3ySMkoqMwyqR3Oy7gNCdiWPwZr4FW
	GrIJ4xOokG2SXOELjk0SoMS4dWplayHLqqeOIhpAr/nN6Zp4RTOSlIfwejSH04BFuEi3vyAKG+E
	XSa38getMoPemnelByWhhsisV1U6B87SZHpeIZTE=
X-Google-Smtp-Source: AGHT+IGkIhcIMGh+oiZ/aDBZPsHwPAhQG69OhML0E/f2mr/YjQA5clLbS6Ua4uwzILjLJIA06eQ5gQ==
X-Received: by 2002:a17:902:d2c4:b0:25e:5d83:2ddd with SMTP id d9443c01a7336-25e5d832fdcmr159755585ad.45.1757998127447;
        Mon, 15 Sep 2025 21:48:47 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:46 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 05/14] s390/pkey: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:26 +0800
Message-Id: <20250916044735.2316171-6-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Holger Dengler <dengler@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/s390/crypto/pkey_base.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/s390/crypto/pkey_base.c b/drivers/s390/crypto/pkey_base.c
index b15741461a63..4c4a9feecccc 100644
--- a/drivers/s390/crypto/pkey_base.c
+++ b/drivers/s390/crypto/pkey_base.c
@@ -48,16 +48,13 @@ int pkey_handler_register(struct pkey_handler *handler)
 
 	spin_lock(&handler_list_write_lock);
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(h, &handler_list, list) {
 		if (h == handler) {
-			rcu_read_unlock();
 			spin_unlock(&handler_list_write_lock);
 			module_put(handler->module);
 			return -EEXIST;
 		}
 	}
-	rcu_read_unlock();
 
 	list_add_rcu(&handler->list, &handler_list);
 	spin_unlock(&handler_list_write_lock);
-- 
2.34.1


