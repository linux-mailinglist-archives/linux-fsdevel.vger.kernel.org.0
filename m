Return-Path: <linux-fsdevel+bounces-61686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15832B58D4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B3A3223B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 04:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7E42E5B3D;
	Tue, 16 Sep 2025 04:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCefdEHH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E32E4278
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 04:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998144; cv=none; b=EA7+w1EdqbVlIUsPp9O0SKM/2PFJI1bT6+IQq9VzKEbznyjKpUvs0wb2igTBLLEP+DxmFirDbgdqIug4bIqVu6qFJnpqhfSsI6kNHvgJFiRNG+NTVpRkbJE1PBTFeAP+XlgNL/Rf53wCrd5BMyMvJUCcKM4LipdLDh2Wjm9Wqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998144; c=relaxed/simple;
	bh=HguuC3cJW9LHrBXuF3iFTqdhADSKZ6I2ZWC/adsG6L4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CrdE+N+ZGUNQS024m2C0LxGrebtogghyP/AyBpCZXhBpfjyxWE3PXGzObRl5Z7WaKxElwcXbYe3MKPNb4Z/oPih27LKNjxsYtcmG9xNX8Fvj+yM9VJohS1QTsQO0sCE3NMtk3GkNfqTdZECjpsMjXi8uRTe1+UXkhevV4xFvd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCefdEHH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244580523a0so50862795ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 21:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998141; x=1758602941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y26N2MyOP2FIPMMMBT4JTn6kc4P01rdpdKyvYPEfOYc=;
        b=SCefdEHHiZ8jZW6xYxJti7tA2y6Bt/GimNvdDYVlgmt2cdNVo7OAJcSr5LXKXEOZbf
         UGGGRX1bIlzd25p9XFG3/AuL4AFo52i36GuOp66KC85Uy/XbHwdetBCk4RfB+CQtV8gG
         bGB3fSsvylkjw0Qw4Syn2pjMO2oaoTpIVOMeW4ync7cEGsK5I0d5n9YApMb74KRv+vYB
         BDsg0UVn1UNIr5Bvs8KUVv/ud5TILGiBsHgcv/yWZ1/CxUmiVCACSIprr/HVidhnRt5o
         0KUolDW/QN7el5Pxc8O7RQcX/fWH9lLT4zQlNsvIDmOvD+BeCZn4n36z8iFAwSLI9O/A
         kioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998141; x=1758602941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y26N2MyOP2FIPMMMBT4JTn6kc4P01rdpdKyvYPEfOYc=;
        b=CTiYPzR86YmjcRZVYloAPcegX1EUyFpOPVpbaUcvOVJj+Rd3xpnPUE5tQhGKLbPTHs
         DBLNyBCIwFwPWcPIl3USJbhecpDO4OoFC1Ihv06as76NG7DYBcelRXBm2E2voHzU6Nc0
         b1jkU9R9WmYdA7uKaCcJpxfmdOoDQ7K5g+Ela+dB+bVuzXtf0+SPP0WcEZZ3sLV3rIAT
         6HIgxFPSETgH/Pmf9Lcvmavle3KiwU8+mlDd6hMqVTxOVgPNiEJ+KHFL0bR9E5wPgJTm
         EE45J4ja2jHMDzgCzVlrAXaQwfFRBnZkxey9PL58m+Gert7iJ5+JkK4jGgzfsBW+nVhK
         WLXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0/SjQyeN7NxGk1d1TGjtiabFfjWCohkMIhc0G5z6DkaMwPpbz750OmGZTCdIArPxwS804geK+F+uwTFIY@vger.kernel.org
X-Gm-Message-State: AOJu0YwYFiBLHyDI9u1STsPazuR7EQHNiOJ7ok8L0HWD1lkkRU2fBwY/
	OMgQmwSfbVT3jmZ/ygKGBItCEErZeXgItrJbpxjmEoi8jWRG1jApKi1C
X-Gm-Gg: ASbGnctN59U/FZqy0WjFPQlrTLcUM/50u+Ys9zkJkU5m0YbuYozZ5GeLKmrRIFbq1m/
	4uhDiycuhMDaAesGgAPSIkqpP99Wb3kiZlBIGY1XsA3T8JZtsb53y3u7F3OX7pNUfo940503RZ2
	0DAmNifq5nBY3tcu/H9lWZYTlUSSDC+un6YD3tyncbvyMENsBZJNq+Dd2N6E/Q2g8jcbmku7FQ/
	V/QVa5/BNFB8rik4CbdvYUTL3NVnrmHQP7h+bly9zgDXCuxkEdhaBKVB/IE7eA4V9yIOAS3aixf
	eJUZgAulZTxFNs6MCIPzSGon2RjhxF08LtCRAZ4I/mzt/eOkmSliKxa/8EkpULMXmp2Tm+enJgf
	N4Rs9lMd/AekoXriuMegS5zxBzBuDKXN41lBPgqY=
X-Google-Smtp-Source: AGHT+IEF8hyGYSwfpfRfNi45Ml5S5Z1xWLwd/+S+vouYcjrRAMMRr1JH2N5TAK8bBOVvYAZpMt3b8w==
X-Received: by 2002:a17:903:ac3:b0:267:d772:f845 with SMTP id d9443c01a7336-267d772fcf1mr8896415ad.52.1757998140582;
        Mon, 15 Sep 2025 21:49:00 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:00 -0700 (PDT)
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
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 07/14] yama: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:28 +0800
Message-Id: <20250916044735.2316171-8-dolinux.peng@gmail.com>
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

Cc: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 security/yama/yama_lsm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 3d064dd4e03f..60d38deb181b 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -117,14 +117,12 @@ static void yama_relation_cleanup(struct work_struct *work)
 	struct ptrace_relation *relation;
 
 	spin_lock(&ptracer_relations_lock);
-	rcu_read_lock();
 	list_for_each_entry_rcu(relation, &ptracer_relations, node) {
 		if (relation->invalid) {
 			list_del_rcu(&relation->node);
 			kfree_rcu(relation, rcu);
 		}
 	}
-	rcu_read_unlock();
 	spin_unlock(&ptracer_relations_lock);
 }
 
@@ -152,7 +150,6 @@ static int yama_ptracer_add(struct task_struct *tracer,
 	added->invalid = false;
 
 	spin_lock(&ptracer_relations_lock);
-	rcu_read_lock();
 	list_for_each_entry_rcu(relation, &ptracer_relations, node) {
 		if (relation->invalid)
 			continue;
@@ -166,7 +163,6 @@ static int yama_ptracer_add(struct task_struct *tracer,
 	list_add_rcu(&added->node, &ptracer_relations);
 
 out:
-	rcu_read_unlock();
 	spin_unlock(&ptracer_relations_lock);
 	return 0;
 }
-- 
2.34.1


