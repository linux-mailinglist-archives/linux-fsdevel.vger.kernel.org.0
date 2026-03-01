Return-Path: <linux-fsdevel+bounces-78839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCiiJOUQpGlcWQUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 11:11:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6C01CF080
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 11:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E152D301D6A5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 10:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222DD335BA8;
	Sun,  1 Mar 2026 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFeiTvDE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92231A9FA0
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Mar 2026 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772359889; cv=none; b=uoXGbU+JaAZExgwA1lnKiYZhSqi7d7jn5rPzhjBoxA6iRjmxq0MxVKidoz3JtPAFQaxFovn0Ee1+07AS928OtuAE1I/m28hyZDQnUdsOSSJhgTxQBxkr5bGsdgMEDhEac2o9KTIJLyCDhXzHs06l17gfnm+TBk4fmw8ZuAxtiq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772359889; c=relaxed/simple;
	bh=woIS/wsHPvPvHWzL5+iJBEcWbuA0XO2nXIIe/7Qg0EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pfg9TZ6/dzurlKFFuULmbqGCA5mkuj7hb9k+ZYWLF6RViaHCPpNPuLG7ts+7c/+eeA7DO7Rw1SdDAkf868OS9cEyA0Z8zri4vVsZw2IE22ifNrtoyNDQnEmCE0P8rp/0UT+wzt1Yd5s54QQ83RvGJUPYP7vJBYOAIwJF7Zj0w4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFeiTvDE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8274843810cso1705664b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2026 02:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772359887; x=1772964687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp14pMKS6bkJE/Z/f1aNlGhNOXRNaHWCDHan9dnJcZo=;
        b=hFeiTvDEZyKuXLEIrztl8hrKJYwI7L2sfCXMIvoGECfpMSYPSQVAvdjdGQcM1XdKfj
         //lZZ3J8Mqyo4SHxEXP/BGbhNt5ZA/GzBm2KHbRIZDt4SZoJ4hhqlAQhbu8EXEsY8cTT
         8IGtG7JTc3BCRpsaouJInrtdrYR/78C1xojufDpIFSc7VfoZB75YJX5hYRU8vOJoXn93
         mhzLUK3lLwb1c0RX8BA4sqKW7bZxqdFIIhIzWjBi5cCJziqA2r2RT8Cujk+F0ykBfAag
         eiUNjPGX9AUZeid6gF468yYw0itn9s0Zyps9z549P1m8OE7GKZqD6g1D1bDPLIW2Oc95
         qHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772359887; x=1772964687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp14pMKS6bkJE/Z/f1aNlGhNOXRNaHWCDHan9dnJcZo=;
        b=HzcfFeuZNeI4C09mYymXQTkG9q1saIEc/uDjo0paBphJ01w6uGdd7gWJbHUWYffa/U
         RmkRs+xLemQOMSBbo1RHdeBudmcgY4JttV9C+TotrlTAipti+klbkZsybnsZBpoNStUy
         6f680sLUJP81iuorMBhTJLBbdpWo5w0Rd1l/IYhvfkdgDTpmol3d7xncawPvENPLT0ks
         eFNJhFO954qZ96FYoHQnNkoloPn2jYy8CRRgZkZ3ItC4K1p4Zoa0NItuZHRZMTEz9Q7D
         N+HPkH/JI0WcFR+F4qlBNK4Pd4eXfg3hs7KDhv9wG233G+aAfGEVtZWKYij/5+byIFSW
         sZuw==
X-Forwarded-Encrypted: i=1; AJvYcCWwPdDl4Xrzy7QnE2DBr+fpUnGFuxJ4h78gDCHCHQnVl+dWuGZr9gEPAsjM6S14uE3xarPRELSirkw4OWlC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7eco/BOO6rpJiB/HQyfIDFZJL+/Wlevr2L3mJxcBrCdB5LPed
	G/0ehYP72A/D3IMf+fb0ffleBXEZRwRCPdFt0nuC2MetOtqwAhd3aALQ
X-Gm-Gg: ATEYQzwAn6X7+Vvc+jsPVvmjQ7z7t+DNQkb/r681xMSfgGVuXSPk0Z30rMf3ta7hIr5
	twdH2jNqzGBXCoimASv/Wc7XJVy2pdALEYWe1Oo7dBi3almRKxW4rzT3anltqt1k0FSljJNxrgM
	sZuWCPPdEadK6lBy87Zub7Y6QaBATGL3VLeX1+R8g95WyA1KnTdug0wYSP0p4lLvJYbktZMX7mF
	w1iZA+xWDNlwu/vKEceVPFUcA+wOT2Tfg8M94ceJOZHGX/WCOKotsd0Q2sOjv6fEqYoPucDtGMT
	IomRDqXn7+L5dHxmz7xaTNUY/a9Auh1Y7lljqrdmOdccQWfaulGijGFFC4Uul4lk2LGoU0Xrh/1
	AamneqIarDS8jGX3o1ihCYc/ceXYj29dFu77tshwYGnSGR2AB5fyqnO5eW/otxM7nD/wjpSeMRB
	wcHXvkNojSOpBnDwG5TF657gYRfOwOPhKGt9Io+VrFqd78
X-Received: by 2002:a05:6a21:d89:b0:394:56ae:8a73 with SMTP id adf61e73a8af0-395c3af018amr8410142637.48.1772359887093;
        Sun, 01 Mar 2026 02:11:27 -0800 (PST)
Received: from yangwen.localdomain ([121.225.53.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa62147esm9205452a12.12.2026.03.01.02.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 02:11:26 -0800 (PST)
From: Yang Wen <anmuxixixi@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Wen <anmuxixixi@gmail.com>
Subject: [PATCH] exfat: initialize caching fields during inode allocation
Date: Sun,  1 Mar 2026 18:11:19 +0800
Message-ID: <20260301101119.447-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[sony.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78839-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anmuxixixi@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E6C01CF080
X-Rspamd-Action: no action

exfat_alloc_inode() does not initialize the cache_lru list head of
struct exfat_inode_info.

If an inode is evicted before its cache structures are properly
initialized (e.g., during a forced unmount), the cleanup
path in __exfat_cache_inval_inode() may observe an uninitialized
list head.

The check:

    while (!list_empty(&ei->cache_lru))

may incorrectly succeed when stale pointers remain from a reused
slab object. Subsequent list traversal can then operate on invalid
entries, potentially leading to a NULL pointer dereference or
memory corruption.

Initialize cache_lru, cache_lru_lock, nr_caches, and cache_valid_id
in exfat_alloc_inode() to ensure a well-defined state at allocation
time.

Signed-off-by: Yang Wen <anmuxixixi@gmail.com>
---
 fs/exfat/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 83396fd265cd..0c4a22b8d5fa 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -195,6 +195,10 @@ static struct inode *exfat_alloc_inode(struct super_block *sb)
 	if (!ei)
 		return NULL;
 
+	spin_lock_init(&ei->cache_lru_lock);
+	ei->nr_caches = 0;
+	ei->cache_valid_id = EXFAT_CACHE_VALID + 1;
+	INIT_LIST_HEAD(&ei->cache_lru);
 	init_rwsem(&ei->truncate_lock);
 	return &ei->vfs_inode;
 }
-- 
2.43.0


