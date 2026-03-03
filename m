Return-Path: <linux-fsdevel+bounces-79234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAVKDiXspmnUaAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:11:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C69991F124D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A465730A009A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 14:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653B1372EE0;
	Tue,  3 Mar 2026 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtH9+uXP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7022D37105D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546733; cv=none; b=B5/FIUsL4gwp3b6CgAfbc2WEZ8yALNelnOXCtOe+3CAW4cfEGMh611bqYcMNqs70okDkt4ygZzXwzMOuOlSSL0gpnn/QeQt8MxkHKeHNTfmV0SjCZLW+P/rNbuFfiqU9mKRYX9iZRd1hx/gfIO4QDmCuoeN+wfxBLmXHH4PH+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546733; c=relaxed/simple;
	bh=78to4xX37jepPCsQPIj/aEiR/ioHwa8PPqM87jRSaJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=so3/L7hAfZA7P9eBYcduPx1DDzslOkxYw3fJ6exb3/kIkapwH0A6HXFt/pIuOmK3iPYwWtie5S6dTN1Bs3i/kE7bf2ZApGGOL7nzSstDsEs6Ot5mexCLRXYDYBb0hYpSkfBibvFN66+crJdwajE41txuojrefa8JYUv8INbZnxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtH9+uXP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8272a56b91cso4860849b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 06:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772546731; x=1773151531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKnpBxEFiyO+cBtM3GQyxdFXgNM7HxbJ6tEuCELZ7Pg=;
        b=JtH9+uXPmL3Gs1ud6wWSsprbQpbq/hckWsxec28qnVScD3GL9wdTVuuz5t0kPD3fer
         YyHRlsg7c5EEcGS6Mh4vC7BmrRDQjublc5YvHEScZpCJdUwiuI6paOGyDlCe/45kZRN5
         XBWmcyEckT1o+ueRMIXTYe+GJA/7fOxrD4u0TdY/Q6TlhV22LdsiU3JuaoXOlOLzaC9D
         DLh7EQKzd79K9Kz2XEyhTIxQApKxR0bWB7pfTgzPiy7Qa71wyFsz+P8tMkOJFKYrp5o4
         sDiw9IS+53n05rXan9qglcHZRvpMVh/RTAmxVComakAHcD+uAYlTUnEvjNl4lJzwOEA0
         14JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772546731; x=1773151531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKnpBxEFiyO+cBtM3GQyxdFXgNM7HxbJ6tEuCELZ7Pg=;
        b=TCqpPvaEq3Nio4h+KdYBb8OJaGLl+05JhPKEt2kLfcsn/XwGI3kJKNeJMAy86k1CT7
         421HCFIi2WqPekNX4075MV/HPfLnl3hL7GB021Pnu6FIR9qAnrEBMPcKgaSQp5ieCcjA
         /J00pxFAzSFPaKrfrOjuj0iZqwidGGgJ9VMwk7B6HjHIVmHwb6mavQ1kL/75X9sLirJk
         gDb8Cf+v8Q62CFVwusogxtBN/kfWOFtdYa74Sz7rQKnsKMdAaG0XUyhpZW6AW8CWXnhZ
         NA7tOMCgpw4mnpDh+4uFeIaCIZzhq3dqcTVDXIzrnFkV8sDJ9NBn0mjwOHMndoczSk1j
         ifyw==
X-Forwarded-Encrypted: i=1; AJvYcCU6wtDOaL9OMjmNF2f+Q9e4tCYRjIUZgxH7JcW/LChlRG4UoMhCfY/BA6j2mGWiU+S8iBSE/bY5j3KiDlyv@vger.kernel.org
X-Gm-Message-State: AOJu0YwTESQTumnLKzDORob7R3BvxVeXXtEduRfQO1BxHA3ZqJzkbL5Q
	vyGWdpzJqmY0LroPBYRW6H3FaFDaiaXz5fYsqyZMxvw9RkKyFq/aKOsz
X-Gm-Gg: ATEYQzyag61QP+e3bOmjKEhII5zDpjitZPdJFSs6of4c4bKj86F0rDGKqPS9WaAoorn
	zix+wir3yJ3Z2rNkgXl5vkodqx5v0O3BlqojVdIhjSbeplHMuAReBsJ9fVvnMzmLoc0pLHyNEqw
	gxL+BdHJRgiqy/c3MIvcVkDPO12lK4kGuAcYNii0lZhzA6PgttuiQPEzBlb5qZAS44S2RkikDvt
	N0A+RazXGoAbvJ/fcBIpT/NEM6H5eRh9g1+VWWfbuANn9v/CMTm1sW3efDBMuiCCLH0M6mMp+2L
	2R3ug7OpiimPa8xcSZqr1/4rE3q2GJ/rGOhE0TghOY9VwEmqFcfnFX7C4PeRFEyY3ZuyGREULpl
	TcZgIXuyB1nkX0YXrGvr1eNC2ofRlVU6iyyLDiE3YhmpAJhIETr0DxD4vRtnsI0mOMguGPBtDw+
	vhDXU/YpwLbEJE6gW/xtn7Wngg/m7Alt3iaA==
X-Received: by 2002:a05:6a00:9086:b0:81e:a228:f0cb with SMTP id d2e1a72fcca58-8274d9d9b38mr18083176b3a.36.1772546730640;
        Tue, 03 Mar 2026 06:05:30 -0800 (PST)
Received: from yangwen.localdomain ([121.225.53.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739dabd43sm19110835b3a.25.2026.03.03.06.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 06:05:14 -0800 (PST)
From: Yang Wen <anmuxixixi@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Wen <anmuxixixi@gmail.com>
Subject: [PATCH v2] exfat: initialize caching fields during inode allocation
Date: Tue,  3 Mar 2026 22:05:09 +0800
Message-ID: <20260303140509.3928-1-anmuxixixi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C69991F124D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sony.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-79234-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anmuxixixi@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
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
 fs/exfat/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 83396fd265cd..f793e66a4a38 100644
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
@@ -879,10 +883,6 @@ static void exfat_inode_init_once(void *foo)
 {
 	struct exfat_inode_info *ei = (struct exfat_inode_info *)foo;
 
-	spin_lock_init(&ei->cache_lru_lock);
-	ei->nr_caches = 0;
-	ei->cache_valid_id = EXFAT_CACHE_VALID + 1;
-	INIT_LIST_HEAD(&ei->cache_lru);
 	INIT_HLIST_NODE(&ei->i_hash_fat);
 	inode_init_once(&ei->vfs_inode);
 }
-- 
2.43.0


